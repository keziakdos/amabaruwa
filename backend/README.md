# Backend Amabaruwa — PocketBase

## Version épinglée

- PocketBase **v0.40.6** (release officielle du 2026-10-23).
- Archive : `pocketbase_0.40.6_linux_amd64.zip`.
- SHA-256 : `0e1f609158ed945f809f8a02ae012aa0427129c66ebb63c1aee76f2c0309373f`.
- L'empreinte est vérifiée dans le `Dockerfile` avant extraction.
- Architecture cible : `linux/amd64` (VPS x86_64).

## Arborescence

- `Dockerfile` : image Alpine avec PocketBase non-root.
- `docker-entrypoint.sh` : préparation de `/pb_data` puis `su-exec`.
- `compose.yaml` : projet Compose `amabaruwa`, port loopback 8095.
- `.env.example` : `AMABARUWA_PORT=8095`.
- `pb_migrations/` : collections et réglages versionnés.
- `nginx/amabaruwa.rwazap.com.conf` : modèle de vhost dédié.

## Lancement local isolé

```bash
cp .env.example .env
mkdir -p pb_data
# Pour un test isolé, surcharger le port et le nom du projet :
# AMABARUWA_PORT=18096 docker compose -p amabaruwa-test up -d --build
docker compose -p amabaruwa-test up -d --build
curl http://127.0.0.1:8095/api/health
docker compose -p amabaruwa-test down
```

Ne jamais utiliser la base de production comme environnement de test.

## Migrations

Appliquées automatiquement au démarrage. `--automigrate=0` et le montage
`pb_migrations` en lecture seule empêchent toute écriture accidentelle.

- `lettres` : `numero`, `slug`, `langue`, `titre`, `contenu_html`, `statut`,
  `pdf_file`, `audio_file`, `url_origine`, `source_key`,
  `source_modified_at`, tailles, SHA-256, durée audio.
- `mots_du_jour` : `date_locale`, `langue`, `titre`, `citation`,
  `reference_source`, `lettre_liee`, `audio_extrait`, `statut`,
  `source_key`.

Règles :

- lecture anonyme limitée aux enregistrements `statut = "publie"` ;
- un mot du jour lié à une lettre exige que la lettre soit publiée ;
- création, modification et suppression réservées aux superusers ;
- fichiers déclarés `protected` : un fichier de brouillon reste inaccessible
  même avec son URL directe.

## Superuser

À créer une fois sur le VPS avec mot de passe saisi hors historique :

```bash
docker compose -p amabaruwa exec pocketbase \
  /pb/pocketbase superuser upsert --dir=/pb_data EMAIL
```

Ne jamais embarquer de superuser dans l'application Flutter.
