# Import des contenus — inzirayakristu.com

Script : `scripts_migration/sync_inzira.py`
Dépendances verrouillées : `scripts_migration/requirements.txt` (Python 3.12).

---

## 1. Principes

- Source unique : `https://www.inzirayakristu.com`.
- Attribution conservée via `url_origine` (`inzirayakristu.com`).
- Aucune reformulation des textes : le contenu vient du PDF public officiel.
- Aucune correspondance texte/PDF/audio devinée en cas d'ambiguïté.
- Téléchargements vers `.part`, vérification taille, MIME, signature et
  SHA-256, puis renommage final.
- Aucun secret en argument ni dans les logs : identifiants PocketBase lus dans
  `PB_ADMIN_EMAIL` et `PB_ADMIN_PASSWORD`.
- Les fichiers temporaires et rapports d'import sont exclus de Git.

---

## 2. Modes

```bash
cd scripts_migration
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt

# Inventaire seul (aucun téléchargement, aucune écriture)
.venv/bin/python sync_inzira.py inventory

# Plan d'import et estimation disque
.venv/bin/python sync_inzira.py dry-run

# Import pilote d'une lettre dans une cible
PB_ADMIN_EMAIL=... PB_ADMIN_PASSWORD=... \
  .venv/bin/python sync_inzira.py pilot --letter 1 \
  --target http://127.0.0.1:8095

# Import complet des contenus non ambigus
PB_ADMIN_EMAIL=... PB_ADMIN_PASSWORD=... \
  .venv/bin/python sync_inzira.py full --target https://amabaruwa.rwazap.com

# Synchronisation idempotente
PB_ADMIN_EMAIL=... PB_ADMIN_PASSWORD=... \
  .venv/bin/python sync_inzira.py sync --target https://amabaruwa.rwazap.com

# Variante brouillon (ne publie rien)
... sync_inzira.py full --draft
```

La cible doit être HTTPS, sauf `http://127.0.0.1` / `localhost` pour les tests.

---

## 3. Inventaire constaté (2026-10-30)

- 22 pages WordPress, 0 publication (`posts`), 114 médias.
- 9 lettres numérotées, 9 PDF importables.
- PDF total : **6,28 Mio**.
- Audio total importable : **157,63 Mio**.
- Total estimé : **163,91 Mio**.
- Document d'introduction `ijambo-ryibanze-iriburiro-ibikubiyemo` :
  **ignoré**, car non classé comme lettre numérotée.
- Aucune publication « Mot du jour » clairement identifiée : **aucune
  création automatique**. Une validation éditoriale reste nécessaire.

### Correspondance audio

| Lettre | Audio | Décision |
| --- | --- | --- |
| 1 | 1 MP3 complet | importé |
| 2 | 1 MP3 complet | importé |
| 3 | 7 MP3 par chapitres | **ambigu, ignoré** |
| 4 | 8 MP3 par chapitres | **ambigu, ignoré** |
| 5 à 9 | aucun MP3 publié | non importé |

Le champ PocketBase `audio_file` accepte un seul fichier. Les lettres 3 et 4
ne seront pourvues d'audio qu'après validation éditoriale d'un fichier
complet ou d'une évolution de schéma dédiée. Aucun assemblage ni découpage
n'est effectué automatiquement.

### Texte des lettres

Les pages WordPress ne contiennent qu'un résumé. Le texte complet est extrait
des PDF officiels avec `pdfminer.six`. Les fins de versets (`Brw1/01`,
`Ibk/08`, etc.) sont conservées et servent de séparateurs de paragraphes.
Aucun mot n'est réécrit ; seuls les espaces et retours à la ligne issus de la
mise en page PDF sont normalisés.

---

## 4. Idempotence et mises à jour

- Clé stable : `source_key = inzirayakristu:lettre:<numéro>`.
- Un import relancé ne crée aucun doublon.
- Un enregistrement inchangé (même `source_modified_at`, fichiers présents,
  même statut) est **ignoré**.
- Un contenu modifié est **mis à jour** (PATCH), fichiers remplacés.
- Aucune suppression distante automatique.
- Les données locales de l'application (progression, favoris) ne sont jamais
  touchées par l'import.

---

## 5. Tests exécutés (base isolée locale)

1. `inventory` et `dry-run` : 9 lettres, 1 audio ambigu×2, estimation disque.
2. Import pilote lettre 1 : PDF + audio, texte de 90 083 caractères,
   vérification Range `206` sur PDF et audio.
3. Relance du pilote : `skipped`, aucun doublon.
4. Import `full` : 9 lettres publiées, audio présent sur 1 et 2,
   absent sur 3 et 4 (ambigu), PDF sur les 9.
5. Relance `full` : 9 `skipped`.
6. Lecture anonyme : 9 lettres visibles.
7. Écriture anonyme : `403`.
8. Passage en `--draft` : brouillon invisible en anonyme, puis republication
   contrôlée.
9. Volume : 9 PDF + 2 MP3 importés, fichiers vérifiés.

Aucun test n'a été exécuté sur la production.

---

## 6. Procédure d'import en production

Prérequis :

1. Backend accessible en HTTPS.
2. Superuser créé sans mot de passe dans l'historique (via tunnel SSH ou
   `read -s`).
3. Certificat TLS actif.

```bash
export PB_URL=https://amabaruwa.rwazap.com
export PB_ADMIN_EMAIL='...'
read -r -s -p 'Mot de passe PocketBase : ' PB_ADMIN_PASSWORD; echo
export PB_ADMIN_PASSWORD

cd scripts_migration
.venv/bin/python sync_inzira.py pilot --letter 1 --target "$PB_URL"
# vérifier dans l'application / l'API, puis :
.venv/bin/python sync_inzira.py full --target "$PB_URL"
.venv/bin/python sync_inzira.py sync --target "$PB_URL"   # doit tout ignorer
unset PB_ADMIN_PASSWORD
```

---

## 7. Mot du jour

- Aucune rubrique « Mot du jour » publiée n'a été identifiée sur le site.
- Le script ne fabrique aucune citation et ne publie rien.
- Toute sélection éditoriale devra fournir une citation exacte, sa référence
  et sa date (Africa/Kigali), puis être importée en `brouillon` avant
  validation du propriétaire.

---

## 8. Sécurité réseau

- Hôtes autorisés : `www.inzirayakristu.com`, `inzirayakristu.com`.
- HTTPS obligatoire, port 443, chemin `/wp-content/uploads/`.
- Résolution DNS vérifiée : toute adresse non publique est refusée.
- Redirections limitées et revalidées à chaque saut.
- Timeouts, reprises limitées avec backoff, débit ralenti.
- Taille contrôlée : PDF 50 MiB, audio 100 MiB.
- Aucun téléchargement de site entier sans inventaire préalable.
