#!/usr/bin/env python3
"""Import et synchronisation des contenus d'inzirayakristu.com vers PocketBase.

Modes :
  inventory  inventaire seul, sans téléchargement ni écriture distante ;
  dry-run    inventaire + plan d'import et estimation disque ;
  pilot      import d'une seule lettre (identifiée par son numéro) ;
  full       import des contenus non ambigus ;
  sync       import idempotent, mise à jour des contenus modifiés.

Sécurité :
  - aucun secret en argument ni dans les logs ;
  - identifiants PocketBase lus dans PB_ADMIN_EMAIL / PB_ADMIN_PASSWORD ;
  - URL de médias limitées aux hôtes et chemins autorisés, sans IP privée ;
  - téléchargements vers .part, vérification taille/MIME/empreinte, renommage
    final après validation ;
  - HTML généré à partir du texte extrait, sans script ni contenu actif ;
  - aucune correspondance audio devinée en cas d'ambiguïté.
"""

from __future__ import annotations

import argparse
import datetime as dt
import getpass
import hashlib
import html
import ipaddress
import json
import os
import re
import socket
import sys
import time
from pathlib import Path
from typing import Any
from urllib.parse import urljoin, urlparse

import requests
from bs4 import BeautifulSoup
from mutagen.mp3 import MP3
from pdfminer.high_level import extract_text
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

SITE_URL = "https://www.inzirayakristu.com"
WP_API = f"{SITE_URL}/wp-json/wp/v2"
ALLOWED_HOSTS = {"www.inzirayakristu.com", "inzirayakristu.com"}
UPLOAD_PREFIX = "/wp-content/uploads/"
USER_AGENT = "AmabaruwaImporter/1.0 (+https://amabaruwa.rwazap.com)"

MAX_PDF_BYTES = 50 * 1024 * 1024
MAX_AUDIO_BYTES = 100 * 1024 * 1024
RATE_DELAY = 0.4
HTTP_TIMEOUT = (10, 90)

BASE_DIR = Path(__file__).resolve().parent
TMP_DIR = BASE_DIR / "tmp" / "downloads"
REPORT_DIR = BASE_DIR / "reports"

LETTER_NUMBERS = {
    "mbere": 1,
    "kabiri": 2,
    "gatatu": 3,
    "kane": 4,
    "gatanu": 5,
    "gatandatu": 6,
    "karindwi": 7,
    "munani": 8,
    "cyenda": 9,
}


class SyncError(Exception):
    """Erreur contrôlée, sans secret dans le message."""


def log(message: str) -> None:
    print(message, flush=True)


def warn(message: str) -> None:
    print(f"AVERTISSEMENT : {message}", file=sys.stderr, flush=True)


def now_utc() -> str:
    return dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def normalize_space(value: str) -> str:
    return re.sub(r"\s+", " ", value).strip()


def normalize_wp_date(value: str | None) -> str | None:
    if not value:
        return None
    raw = value.strip().replace(" ", "T").replace("+00:00", "Z")
    if raw.endswith("Z"):
        raw = raw[:-1] + "+00:00"
    try:
        parsed = dt.datetime.fromisoformat(raw)
    except ValueError:
        return value.strip()
    if parsed.tzinfo is None:
        parsed = parsed.replace(tzinfo=dt.timezone.utc)
    return parsed.astimezone(dt.timezone.utc).replace(microsecond=0).strftime("%Y-%m-%dT%H:%M:%SZ")


def text_of_html(value: str) -> str:
    soup = BeautifulSoup(value or "", "html.parser")
    for tag in soup(["script", "style", "noscript", "iframe", "object", "embed"]):
        tag.decompose()
    return normalize_space(soup.get_text(" ", strip=True))


def is_global_ip(host: str) -> bool:
    try:
        infos = socket.getaddrinfo(host, 443, type=socket.SOCK_STREAM)
    except socket.gaierror as exc:
        raise SyncError(f"Résolution DNS impossible pour {host}.") from exc

    addresses = {info[4][0] for info in infos}
    if not addresses:
        raise SyncError(f"Aucune adresse pour {host}.")
    for address in addresses:
        ip = ipaddress.ip_address(address)
        if not ip.is_global:
            raise SyncError(f"Adresse non publique refusée pour {host}.")
    return True


def validate_site_url(url: str, *, uploads_only: bool = False) -> str:
    parsed = urlparse(url)
    if parsed.scheme != "https":
        raise SyncError("Seules les URL HTTPS sont autorisées.")
    if parsed.username or parsed.password:
        raise SyncError("URL avec identifiants refusée.")
    if (parsed.hostname or "").lower() not in ALLOWED_HOSTS:
        raise SyncError(f"Hôte non autorisé : {parsed.hostname}.")
    if parsed.port not in (None, 443):
        raise SyncError("Port non standard refusé.")
    if uploads_only and not parsed.path.startswith(UPLOAD_PREFIX):
        raise SyncError(f"Chemin de média non autorisé : {parsed.path}.")
    is_global_ip(parsed.hostname or "")
    return url


def build_session() -> requests.Session:
    session = requests.Session()
    retry = Retry(
        total=3,
        connect=3,
        read=3,
        status=3,
        backoff_factor=0.8,
        status_forcelist=(429, 500, 502, 503, 504),
        allowed_methods=frozenset({"GET", "HEAD", "POST", "PATCH"}),
        raise_on_status=False,
    )
    adapter = HTTPAdapter(max_retries=retry, pool_connections=2, pool_maxsize=2)
    session.mount("https://", adapter)
    session.headers.update({"User-Agent": USER_AGENT, "Accept": "*/*"})
    return session


def safe_request(
    session: requests.Session,
    method: str,
    url: str,
    *,
    uploads_only: bool = False,
    stream: bool = False,
    max_redirects: int = 4,
    **kwargs: Any,
) -> requests.Response:
    current = url
    for _ in range(max_redirects + 1):
        validate_site_url(current, uploads_only=uploads_only)
        response = session.request(
            method,
            current,
            stream=stream,
            timeout=HTTP_TIMEOUT,
            allow_redirects=False,
            **kwargs,
        )
        if response.status_code in (301, 302, 303, 307, 308):
            location = response.headers.get("Location")
            response.close()
            if not location:
                raise SyncError("Redirection sans destination.")
            current = urljoin(current, location)
            continue
        if response.status_code >= 400:
            snippet = response.text[:200] if not stream else ""
            response.close()
            raise SyncError(f"HTTP {response.status_code} pour {current} {snippet}".strip())
        time.sleep(RATE_DELAY)
        return response
    raise SyncError("Trop de redirections.")


def wp_get(session: requests.Session, kind: str, params: dict[str, Any]) -> tuple[Any, dict[str, str]]:
    url = f"{WP_API}/{kind}"
    response = safe_request(session, "GET", url, params=params)
    try:
        data = response.json()
    except ValueError as exc:
        raise SyncError(f"Réponse JSON invalide pour {kind}.") from exc
    return data, dict(response.headers)


def fetch_paginated(session: requests.Session, kind: str, fields: str) -> list[dict[str, Any]]:
    items: list[dict[str, Any]] = []
    page = 1
    while True:
        batch, headers = wp_get(
            session,
            kind,
            {
                "per_page": 100,
                "page": page,
                "_fields": fields,
            },
        )
        if not isinstance(batch, list):
            raise SyncError(f"Réponse inattendue pour {kind}.")
        items.extend(batch)
        total_pages = int(headers.get("X-WP-TotalPages", "1") or "1")
        if page >= total_pages:
            break
        page += 1
    return items


def find_media_urls(content_html: str, page_link: str) -> list[str]:
    soup = BeautifulSoup(content_html or "", "html.parser")
    found: list[str] = []
    for tag in soup.find_all(["a", "audio", "source"]):
        raw = tag.get("href") or tag.get("src") or ""
        if not raw:
            continue
        absolute = urljoin(page_link, raw)
        parsed = urlparse(absolute)
        if parsed.path.lower().endswith((".pdf", ".mp3", ".m4a", ".ogg", ".wav")):
            try:
                validate_site_url(absolute, uploads_only=True)
            except SyncError as exc:
                warn(str(exc))
                continue
            if absolute not in found:
                found.append(absolute)
    return found


def detect_letter_number(page: dict[str, Any]) -> int | None:
    slug = page.get("slug", "")
    match = re.search(r"^ibaruwa-ya-(mbere|kabiri|gatatu|kane|gatanu|gatandatu|karindwi|munani|cyenda)$", slug)
    if match:
        return LETTER_NUMBERS[match.group(1)]
    title = text_of_html(page.get("title", {}).get("rendered", ""))
    match = re.search(r"\bIbaruwa\s+ya\s+(\d{1,2})\b", title, re.IGNORECASE)
    if match:
        number = int(match.group(1))
        if 1 <= number <= 99:
            return number
    return None


def detect_audio_number(page: dict[str, Any]) -> int | None:
    slug = page.get("slug", "")
    match = re.search(r"^audio-ibaruwa-?(\d{1,2})$", slug)
    if match:
        return int(match.group(1))
    title = text_of_html(page.get("title", {}).get("rendered", ""))
    match = re.search(r"audio\s*[–-]\s*ibaruwa\s+(\d{1,2})", title, re.IGNORECASE)
    if match:
        return int(match.group(1))
    return None


def build_inventory(session: requests.Session) -> dict[str, Any]:
    log("Lecture des pages WordPress…")
    pages = fetch_paginated(
        session,
        "pages",
        "id,slug,link,title,content,modified,modified_gmt",
    )
    log(f"{len(pages)} pages récupérées.")
    log("Lecture des publications WordPress…")
    posts = fetch_paginated(
        session,
        "posts",
        "id,slug,link,title,content,modified,modified_gmt",
    )
    log(f"{len(posts)} publications récupérées.")
    log("Lecture de la médiathèque…")
    media = fetch_paginated(
        session,
        "media",
        "id,source_url,mime_type,media_details,title",
    )
    log(f"{len(media)} médias récupérés.")

    media_sizes = {
        item.get("source_url", ""): (item.get("media_details") or {}).get("filesize")
        for item in media
    }
    media_mimes = {item.get("source_url", ""): item.get("mime_type", "") for item in media}

    audio_map: dict[int, dict[str, Any]] = {}
    audio_pages: list[dict[str, Any]] = []
    for page in pages:
        number = detect_audio_number(page)
        if number is None:
            continue
        urls = [u for u in find_media_urls(page.get("content", {}).get("rendered", ""), page.get("link", "")) if urlparse(u).path.lower().endswith(".mp3")]
        audio_pages.append({"page_id": page.get("id"), "slug": page.get("slug"), "numero": number, "urls": urls})
        if number in audio_map:
            audio_map[number] = {"status": "ambiguous", "urls": []}
            continue
        if len(urls) == 1:
            audio_map[number] = {"status": "ok", "url": urls[0]}
        elif len(urls) > 1:
            audio_map[number] = {"status": "ambiguous", "urls": urls}
        else:
            audio_map[number] = {"status": "missing", "urls": []}

    letters: list[dict[str, Any]] = []
    ignored_documents: list[dict[str, Any]] = []
    seen_numbers: dict[int, str] = {}
    for page in pages:
        number = detect_letter_number(page)
        if number is None:
            title = text_of_html(page.get("title", {}).get("rendered", ""))
            if page.get("slug") == "ijambo-ryibanze-iriburiro-ibikubiyemo":
                ignored_documents.append(
                    {
                        "page_id": page.get("id"),
                        "slug": page.get("slug"),
                        "titre": title,
                        "raison": "Document d'introduction, non classé comme lettre numérotée.",
                    }
                )
            continue

        if number in seen_numbers:
            warn(f"Numéro de lettre {number} présent sur plusieurs pages ; contenu ambigu.")
        seen_numbers[number] = page.get("slug", "")

        link = page.get("link", "")
        urls = find_media_urls(page.get("content", {}).get("rendered", ""), link)
        pdf_urls = [u for u in urls if urlparse(u).path.lower().endswith(".pdf")]
        issues: list[str] = []

        pdf_url: str | None = None
        if len(pdf_urls) == 1:
            pdf_url = pdf_urls[0]
        elif len(pdf_urls) > 1:
            issues.append("plusieurs PDF : correspondance ambiguë")
        else:
            issues.append("PDF absent")

        audio_info = audio_map.get(number)
        audio_url: str | None = None
        audio_ambiguous_urls: list[str] = []
        if audio_info:
            if audio_info["status"] == "ok":
                audio_url = audio_info["url"]
            elif audio_info["status"] == "ambiguous":
                audio_ambiguous_urls = audio_info.get("urls", [])
                issues.append("plusieurs fichiers audio : correspondance ambiguë, aucun import")
        elif number > 4:
            issues.append("aucune page audio publiée pour cette lettre")

        pdf_size = media_sizes.get(pdf_url or "")
        audio_size = media_sizes.get(audio_url or "")

        letters.append(
            {
                "numero": number,
                "slug": page.get("slug"),
                "titre": text_of_html(page.get("title", {}).get("rendered", "")) or f"Ibaruwa ya {number}",
                "langue": "rw",
                "page_id": page.get("id"),
                "url_origine": link,
                "source_modified_gmt": page.get("modified_gmt"),
                "pdf_url": pdf_url,
                "pdf_size_bytes": pdf_size,
                "pdf_mime": media_mimes.get(pdf_url or ""),
                "audio_url": audio_url,
                "audio_size_bytes": audio_size,
                "audio_mime": media_mimes.get(audio_url or ""),
                "audio_ambiguous_urls": audio_ambiguous_urls,
                "issues": issues,
                "importable": pdf_url is not None,
                "source_key": f"inzirayakristu:lettre:{number}",
            }
        )

    letters.sort(key=lambda item: item["numero"])

    daily_candidates: list[dict[str, Any]] = []
    daily_pattern = re.compile(r"ijambo\s+ry[’']?\s*uyu\s+munsi|mot\s+du\s+jour", re.IGNORECASE)
    for item in list(pages) + list(posts):
        haystack = " ".join(
            [
                item.get("slug", ""),
                text_of_html(item.get("title", {}).get("rendered", "")),
                text_of_html(item.get("content", {}).get("rendered", "")),
            ]
        )
        if daily_pattern.search(haystack):
            daily_candidates.append(
                {
                    "type": "page" if item in pages else "post",
                    "id": item.get("id"),
                    "slug": item.get("slug"),
                    "titre": text_of_html(item.get("title", {}).get("rendered", "")),
                    "url": item.get("link"),
                }
            )

    importable = [item for item in letters if item["importable"]]
    total_pdf = sum((item.get("pdf_size_bytes") or 0) for item in importable)
    total_audio = sum((item.get("audio_size_bytes") or 0) for item in importable if item.get("audio_url"))
    ambiguous_audio = [item["numero"] for item in letters if item.get("audio_ambiguous_urls")]

    return {
        "generated_at": now_utc(),
        "source": SITE_URL,
        "pages_count": len(pages),
        "posts_count": len(posts),
        "media_count": len(media),
        "letters": letters,
        "ignored_documents": ignored_documents,
        "audio_pages": audio_pages,
        "daily_word_candidates": daily_candidates,
        "summary": {
            "letters_found": len(letters),
            "letters_importable": len(importable),
            "letters_without_pdf": [item["numero"] for item in letters if not item["importable"]],
            "audio_importable": [item["numero"] for item in letters if item.get("audio_url")],
            "audio_ambiguous": ambiguous_audio,
            "estimated_pdf_bytes": total_pdf,
            "estimated_audio_bytes": total_audio,
            "estimated_total_bytes": total_pdf + total_audio,
        },
    }


def print_inventory(inventory: dict[str, Any]) -> None:
    log("")
    log(f"Inventaire {inventory['source']} — {inventory['generated_at']}")
    log(f"Pages : {inventory['pages_count']} · publications : {inventory['posts_count']} · médias : {inventory['media_count']}")
    log("")
    log(f"{'N°':>3}  {'Titre':<42} {'PDF':<4} {'Audio':<11} Observations")
    log("-" * 96)
    for item in inventory["letters"]:
        audio_state = "oui" if item.get("audio_url") else ("ambigu" if item.get("audio_ambiguous_urls") else "non")
        issues = "; ".join(item.get("issues", [])) or "—"
        log(f"{item['numero']:>3}  {item['titre'][:42]:<42} {'oui' if item['pdf_url'] else 'non':<4} {audio_state:<11} {issues}")
    log("")
    summary = inventory["summary"]
    log(f"Lettres trouvées : {summary['letters_found']} · importables : {summary['letters_importable']}")
    log(f"Audio importable : {summary['audio_importable'] or 'aucun'}")
    log(f"Audio ambigu (ignoré) : {summary['audio_ambiguous'] or 'aucun'}")
    log(f"Estimation PDF : {summary['estimated_pdf_bytes'] / (1024 * 1024):.2f} Mio")
    log(f"Estimation audio : {summary['estimated_audio_bytes'] / (1024 * 1024):.2f} Mio")
    log(f"Estimation totale : {summary['estimated_total_bytes'] / (1024 * 1024):.2f} Mio")
    if inventory["ignored_documents"]:
        log("")
        log("Documents ignorés (non classés comme lettres) :")
        for doc in inventory["ignored_documents"]:
            log(f"  - {doc['titre']} ({doc['slug']}) : {doc['raison']}")
    log("")
    if inventory["daily_word_candidates"]:
        log("Candidats Mot du jour identifiés (validation éditoriale requise) :")
        for candidate in inventory["daily_word_candidates"]:
            log(f"  - {candidate['titre']} — {candidate['url']}")
    else:
        log("Aucune publication « Mot du jour » clairement identifiée. Aucune création automatique.")


def write_report(report: dict[str, Any], path: str | None) -> Path:
    REPORT_DIR.mkdir(parents=True, exist_ok=True)
    destination = Path(path) if path else REPORT_DIR / "inventory.json"
    destination.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return destination


def normalize_pdf_text(raw: str) -> list[str]:
    raw = raw.replace("\r\n", "\n").replace("\r", "\n").replace("\xa0", " ")
    lines: list[str] = []
    for line in raw.split("\n"):
        line = re.sub(r"[ \t]+", " ", line).strip()
        if re.fullmatch(r"\d+\s*/\s*\d+", line):
            continue
        if line.lower() == "loading...":
            continue
        lines.append(line)

    paragraphs: list[str] = []
    current: list[str] = []
    reference_end = re.compile(r"(?:Brw|Ibk)\s*\d*/\d+\.?$", re.IGNORECASE)
    for line in lines:
        if not line:
            if current:
                paragraphs.append(normalize_space(" ".join(current)))
                current = []
            continue
        current.append(line)
        # Une référence de fin de verset marque une fin de paragraphe dans les PDF.
        if reference_end.search(line):
            paragraphs.append(normalize_space(" ".join(current)))
            current = []
    if current:
        paragraphs.append(normalize_space(" ".join(current)))
    return [p for p in paragraphs if p]


def pdf_to_html(pdf_path: Path) -> tuple[str, str]:
    try:
        raw = extract_text(str(pdf_path))
    except Exception as exc:  # noqa: BLE001 - message générique sans secret
        raise SyncError("Extraction du texte PDF impossible.") from exc
    paragraphs = normalize_pdf_text(raw)
    if not paragraphs:
        raise SyncError("PDF sans texte exploitable.")
    html_body = "".join(f"<p>{html.escape(p, quote=False)}</p>" for p in paragraphs)
    return html_body, "\n\n".join(paragraphs)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def download_media(
    session: requests.Session,
    url: str,
    *,
    kind: str,
    max_bytes: int,
) -> dict[str, Any]:
    validate_site_url(url, uploads_only=True)
    expected_mime = "application/pdf" if kind == "pdf" else "audio/mpeg"
    expected_ext = ".pdf" if kind == "pdf" else ".mp3"

    TMP_DIR.mkdir(parents=True, exist_ok=True)
    temp_path = TMP_DIR / f".part-{os.getpid()}-{int(time.time() * 1000)}"

    response = safe_request(session, "GET", url, uploads_only=True, stream=True)
    try:
        content_type = (response.headers.get("Content-Type") or "").split(";")[0].strip().lower()
        if content_type and content_type not in {expected_mime, "application/octet-stream", "binary/octet-stream"}:
            raise SyncError(f"Type MIME refusé pour {kind} : {content_type}.")
        declared = response.headers.get("Content-Length")
        if declared and int(declared) > max_bytes:
            raise SyncError(f"Fichier {kind} trop volumineux ({int(declared)} octets).")

        digest = hashlib.sha256()
        size = 0
        with temp_path.open("wb") as handle:
            for chunk in response.iter_content(1024 * 256):
                if not chunk:
                    continue
                size += len(chunk)
                if size > max_bytes:
                    raise SyncError(f"Fichier {kind} dépassant la limite autorisée.")
                digest.update(chunk)
                handle.write(chunk)
        if declared and size != int(declared):
            raise SyncError(f"Taille {kind} incohérente après téléchargement.")
    finally:
        response.close()

    header = temp_path.read_bytes()[:5]
    if kind == "pdf" and not header.startswith(b"%PDF"):
        temp_path.unlink(missing_ok=True)
        raise SyncError("Signature PDF absente.")
    if kind == "audio" and not (header.startswith(b"ID3") or header[:1] in (b"\xff", b"\xfe")):
        temp_path.unlink(missing_ok=True)
        raise SyncError("Signature MP3 absente.")

    checksum = sha256_file(temp_path)
    final_path = TMP_DIR / f"{checksum}{expected_ext}"
    if final_path.exists():
        temp_path.unlink(missing_ok=True)
    else:
        os.replace(temp_path, final_path)

    duration = None
    if kind == "audio":
        try:
            duration = round(float(MP3(final_path).info.length), 2)
        except Exception:  # noqa: BLE001
            duration = None

    return {
        "path": final_path,
        "size": final_path.stat().st_size,
        "sha256": checksum,
        "duration": duration,
        "url": url,
    }


class PocketBaseClient:
    def __init__(self, base_url: str, email: str, password: str) -> None:
        self.base_url = self._validate_target(base_url)
        self.session = build_session()
        self.token = self._authenticate(email, password)

    @staticmethod
    def _validate_target(value: str) -> str:
        parsed = urlparse(value)
        if parsed.scheme == "https":
            return value.rstrip("/")
        if parsed.scheme == "http" and (parsed.hostname or "") in {"127.0.0.1", "localhost", "::1"}:
            return value.rstrip("/")
        raise SyncError("La cible doit être HTTPS, ou HTTP en loopback pour les tests.")

    def _authenticate(self, email: str, password: str) -> str:
        response = self.session.post(
            f"{self.base_url}/api/collections/_superusers/auth-with-password",
            json={"identity": email, "password": password},
            timeout=HTTP_TIMEOUT,
        )
        if response.status_code != 200:
            raise SyncError("Authentification PocketBase refusée.")
        token = response.json().get("token")
        if not token:
            raise SyncError("Jeton PocketBase absent.")
        return token

    @property
    def headers(self) -> dict[str, str]:
        return {"Authorization": self.token}

    def find_letter(self, source_key: str) -> dict[str, Any] | None:
        response = self.session.get(
            f"{self.base_url}/api/collections/lettres/records",
            params={"filter": f"(source_key='{source_key}')", "perPage": 1},
            headers=self.headers,
            timeout=HTTP_TIMEOUT,
        )
        if response.status_code != 200:
            raise SyncError("Recherche du enregistrement impossible.")
        items = response.json().get("items", [])
        return items[0] if items else None

    def save_letter(
        self,
        fields: dict[str, Any],
        files: dict[str, tuple[str, Any, str]],
        record_id: str | None,
    ) -> dict[str, Any]:
        url = f"{self.base_url}/api/collections/lettres/records"
        if record_id:
            url = f"{url}/{record_id}"
        response = self.session.request(
            "PATCH" if record_id else "POST",
            url,
            data={key: str(value) if value is not None else "" for key, value in fields.items()},
            files=files,
            headers=self.headers,
            timeout=(10, 300),
        )
        if response.status_code not in (200, 201):
            message = ""
            details = ""
            try:
                payload = response.json()
                message = payload.get("message", "")
                data = payload.get("data") or {}
                if data:
                    details = " " + json.dumps(data, ensure_ascii=False)
            except ValueError:
                pass
            raise SyncError(f"Écriture PocketBase refusée ({response.status_code}) {message}{details}".strip())
        return response.json()

    def verify_file(self, record: dict[str, Any], field: str) -> bool:
        filename = record.get(field)
        if not filename:
            return False
        if isinstance(filename, list):
            filename = filename[0] if filename else ""
        if not filename:
            return False
        url = f"{self.base_url}/api/files/lettres/{record['id']}/{filename}"
        response = self.session.get(url, headers={**self.headers, "Range": "bytes=0-0"}, timeout=HTTP_TIMEOUT)
        return response.status_code in (200, 206)


def importable_letters(inventory: dict[str, Any], only: int | None) -> list[dict[str, Any]]:
    items = [item for item in inventory["letters"] if item["importable"]]
    if only is not None:
        items = [item for item in items if item["numero"] == only]
    return items


def import_letter(
    client: PocketBaseClient,
    session: requests.Session,
    item: dict[str, Any],
    *,
    draft: bool,
) -> dict[str, Any]:
    existing = client.find_letter(item["source_key"])
    desired_statut = "brouillon" if draft else "publie"
    expected_modified = normalize_wp_date(item.get("source_modified_gmt"))

    if existing:
        same_modified = normalize_wp_date(existing.get("source_modified_at")) == expected_modified
        has_pdf = bool(existing.get("pdf_file"))
        has_audio = bool(existing.get("audio_file")) or not item.get("audio_url")
        has_html = bool(existing.get("contenu_html"))
        if same_modified and has_pdf and has_audio and has_html and existing.get("statut") == desired_statut:
            return {"status": "skipped", "id": existing.get("id"), "numero": item["numero"]}

    pdf = download_media(session, item["pdf_url"], kind="pdf", max_bytes=MAX_PDF_BYTES)
    html_body, plain_text = pdf_to_html(pdf["path"])
    if len(plain_text) < 500:
        raise SyncError(f"Texte PDF trop court pour la lettre {item['numero']}.")

    audio = None
    if item.get("audio_url"):
        audio = download_media(session, item["audio_url"], kind="audio", max_bytes=MAX_AUDIO_BYTES)

    fields: dict[str, Any] = {
        "numero": item["numero"],
        "slug": item["slug"],
        "langue": item["langue"],
        "titre": item["titre"],
        "contenu_html": html_body,
        "statut": desired_statut,
        "url_origine": item["url_origine"],
        "source_key": item["source_key"],
        "source_modified_at": expected_modified or None,
        "pdf_size_bytes": pdf["size"],
        "pdf_sha256": pdf["sha256"],
    }
    if audio:
        fields.update(
            {
                "audio_size_bytes": audio["size"],
                "audio_sha256": audio["sha256"],
                "audio_duration_seconds": audio.get("duration"),
            }
        )

    files: dict[str, tuple[str, Any, str]] = {}
    pdf_handle = pdf["path"].open("rb")
    files["pdf_file"] = (f"ibaruwa-{item['numero']}.pdf", pdf_handle, "application/pdf")
    audio_handle = None
    if audio:
        audio_handle = audio["path"].open("rb")
        files["audio_file"] = (f"ibaruwa-{item['numero']}.mp3", audio_handle, "audio/mpeg")

    try:
        record = client.save_letter(fields, files, existing.get("id") if existing else None)
    finally:
        pdf_handle.close()
        if audio_handle:
            audio_handle.close()

    if desired_statut == "publie":
        if not client.verify_file(record, "pdf_file"):
            raise SyncError(f"PDF non vérifiable après import pour la lettre {item['numero']}.")
        if audio and not client.verify_file(record, "audio_file"):
            raise SyncError(f"Audio non vérifiable après import pour la lettre {item['numero']}.")
    else:
        # Un brouillon protège ses fichiers : leur accès public doit échouer.
        if not record.get("pdf_file"):
            raise SyncError(f"PDF absent du brouillon de la lettre {item['numero']}.")
        if audio and not record.get("audio_file"):
            raise SyncError(f"Audio absent du brouillon de la lettre {item['numero']}.")

    return {
        "status": "updated" if existing else "imported",
        "id": record.get("id"),
        "numero": item["numero"],
        "pdf_size": pdf["size"],
        "audio_size": audio["size"] if audio else None,
    }


def read_password_file(path_value: str) -> str:
    path = Path(path_value).expanduser()
    try:
        mode = path.stat().st_mode
    except OSError as exc:
        raise SyncError("Fichier de mot de passe illisible.") from exc
    if mode & 0o077:
        raise SyncError("Fichier de mot de passe trop permissif : exécuter chmod 600.")
    try:
        value = path.read_text(encoding="utf-8").strip()
    except OSError as exc:
        raise SyncError("Fichier de mot de passe illisible.") from exc
    if not value:
        raise SyncError("Fichier de mot de passe vide.")
    return value


def load_credentials(mode: str) -> tuple[str, str]:
    email = os.environ.get("PB_ADMIN_EMAIL", "").strip()
    password = os.environ.get("PB_ADMIN_PASSWORD", "")
    password_file = os.environ.get("PB_ADMIN_PASSWORD_FILE", "").strip()
    if not password and password_file:
        password = read_password_file(password_file)
    if not email and sys.stdin.isatty():
        email = input("Adresse superuser PocketBase : ").strip()
    if not password and sys.stdin.isatty():
        password = getpass.getpass("Mot de passe superuser PocketBase : ")
    if not email or not password:
        raise SyncError(
            "Identifiants manquants. Définir PB_ADMIN_EMAIL et "
            "PB_ADMIN_PASSWORD ou PB_ADMIN_PASSWORD_FILE (fichier chmod 600)."
        )
    return email, password


def run_import(args: argparse.Namespace, inventory: dict[str, Any]) -> int:
    only = args.letter if args.mode == "pilot" else None
    if args.mode == "pilot" and only is None:
        only = 1
    letters = importable_letters(inventory, only)
    if not letters:
        raise SyncError("Aucune lettre importable pour ce mode.")

    email, password = load_credentials(args.mode)
    target = args.target or os.environ.get("PB_URL") or "http://127.0.0.1:8095"
    client = PocketBaseClient(target, email, password)
    session = build_session()

    results: list[dict[str, Any]] = []
    failures: list[dict[str, Any]] = []
    for item in letters:
        try:
            result = import_letter(client, session, item, draft=args.draft)
            results.append(result)
            log(f"Lettre {item['numero']} : {result['status']} ({result.get('id')})")
        except SyncError as exc:
            failures.append({"numero": item["numero"], "erreur": str(exc)})
            warn(f"Lettre {item['numero']} : {exc}")

    report = {
        "generated_at": now_utc(),
        "mode": args.mode,
        "target": target,
        "results": results,
        "failures": failures,
        "skipped_ambiguous_audio": inventory["summary"]["audio_ambiguous"],
        "letters_without_pdf": inventory["summary"]["letters_without_pdf"],
    }
    report_path = REPORT_DIR / f"import-{args.mode}-{dt.datetime.now().strftime('%Y%m%d-%H%M%S')}.json"
    report_path.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    imported = sum(1 for item in results if item["status"] == "imported")
    updated = sum(1 for item in results if item["status"] == "updated")
    skipped = sum(1 for item in results if item["status"] == "skipped")
    log("")
    log(f"Résumé : {imported} importée(s), {updated} mise(s) à jour, {skipped} ignorée(s), {len(failures)} échec(s).")
    log(f"Rapport : {report_path}")
    if failures:
        return 1
    return 0


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Import inzirayakristu.com vers PocketBase")
    parser.add_argument("mode", choices=["inventory", "dry-run", "pilot", "full", "sync"])
    parser.add_argument("--letter", type=int, help="Numéro de lettre (mode pilot)")
    parser.add_argument("--draft", action="store_true", help="Importer en brouillon au lieu de publier")
    parser.add_argument("--target", help="URL PocketBase (défaut : PB_URL ou loopback)")
    parser.add_argument("--report", help="Chemin du rapport JSON d'inventaire")
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    session = build_session()
    try:
        inventory = build_inventory(session)
    except (SyncError, requests.RequestException) as exc:
        warn(str(exc))
        return 2

    print_inventory(inventory)

    if args.mode in {"inventory", "dry-run"}:
        path = write_report(inventory, args.report)
        log(f"Rapport écrit : {path}")
        if args.mode == "dry-run":
            log("")
            log("Plan d'import :")
            for item in inventory["letters"]:
                if not item["importable"]:
                    log(f"  - Lettre {item['numero']} : ignorée ({'; '.join(item['issues'])}).")
                    continue
                audio = "PDF seul" if not item.get("audio_url") else "PDF + audio"
                log(f"  - Lettre {item['numero']} : {audio}.")
            log("Aucune écriture distante effectuée en dry-run.")
        return 0

    try:
        return run_import(args, inventory)
    except (SyncError, requests.RequestException) as exc:
        warn(str(exc))
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
