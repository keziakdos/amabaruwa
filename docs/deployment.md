# Déploiement — Amabaruwa

Dernière vérification : 2026-10-31.

---

## 1. État déployé

| Élément | Valeur |
| --- | --- |
| VPS | `148.230.124.5`, Ubuntu 24.04.5, x86_64 |
| Utilisateur | `trading` |
| Répertoire | `/opt/amabaruwa-pb` |
| Port local | `127.0.0.1:8095` → conteneur `8090` |
| Projet Compose | `amabaruwa` |
| Conteneur | `amabaruwa-pocketbase-1` |
| Image | `amabaruwa-pocketbase:0.40.6` |
| PocketBase | v0.40.6, empreinte SHA-256 vérifiée au build |
| Domaine | `https://amabaruwa.rwazap.com` |
| Certificat | Let's Encrypt, `CN=amabaruwa.rwazap.com`, valide jusqu'au 2027-01-28 |
| Vhost | `/etc/nginx/sites-available/amabaruwa.rwazap.com.conf` |
| Webroot ACME | `/var/www/amabaruwa-acme` |
| Données | `/opt/amabaruwa-pb/pb_data` |

Services existants préservés : `rwaresto-app`, `rwatrade_app`,
`rwazap_news_app`, `coach-app`, `n8n`, `n8n-new` (arrêté).

---

## 2. Fichiers de déploiement

- `backend/Dockerfile`
- `backend/compose.yaml`
- `backend/.env.example`
- `backend/pb_migrations/`
- `backend/nginx/amabaruwa.rwazap.com.http.conf` (bootstrap HTTP)
- `backend/nginx/amabaruwa.rwazap.com.conf` (final HTTPS)
- `backend/deploy/bootstrap.sh`
- `backend/deploy/issue-cert.sh`
- `backend/deploy/enable-https.sh`

---

## 3. Première installation (résumé reproductible)

1. Vérifier le port et les services :
   ```bash
   ss -ltnp | grep ':8095' || echo libre
   docker ps -a
   ```
2. Transférer le backend vers `/home/trading/amabaruwa-pb-stage`.
3. Avec sudo :
   ```bash
   sudo bash /home/trading/amabaruwa-pb-stage/deploy/bootstrap.sh
   ```
4. Créer `.env` (mode 600) à partir de `.env.example`.
5. Construire et démarrer uniquement le projet :
   ```bash
   cd /opt/amabaruwa-pb
   docker compose up -d --build
   curl http://127.0.0.1:8095/api/health
   ```
6. Créer le superuser sans exposer le mot de passe :
   ```bash
   docker compose exec -T pocketbase \
     /pb/pocketbase superuser upsert --dir=/pb_data EMAIL
   ```
   ou via tunnel SSH + tableau de bord.
7. Certificat et HTTPS :
   ```bash
   sudo bash /opt/amabaruwa-pb/deploy/issue-cert.sh
   sudo bash /opt/amabaruwa-pb/deploy/enable-https.sh
   ```

---

## 4. Mise à jour

```bash
# 1. Sauvegarder (voir docs/backup-restore.md)
# 2. Mettre à jour les fichiers (sans pb_data ni .env)
rsync -az --exclude 'pb_data/' --exclude '.env' backend/ \
  trading@148.230.124.5:/opt/amabaruwa-pb/
# 3. Reconstruire et redémarrer le seul projet
ssh trading@148.230.124.5 \
  'cd /opt/amabaruwa-pb && docker compose up -d --build'
# 4. Vérifier
curl https://amabaruwa.rwazap.com/api/health
```

Les migrations sont appliquées au démarrage et sont versionnées. Ne jamais
modifier `pb_data` à la main.

---

## 5. Nginx et TLS

- Ne jamais redémarrer Nginx : `nginx -t` puis `systemctl reload nginx`.
- Le vhost Amabaruwa est autonome ; ne pas modifier les autres vhosts.
- `client_max_body_size 200M` uniquement dans ce vhost.
- `/_/` est bloqué publiquement ; l'administration se fait par tunnel SSH.
- Le renouvellement utilise Certbot webroot et un `--deploy-hook` limité à ce
  certificat (`systemctl reload nginx`).
- Vérifier le renouvellement :
  ```bash
  sudo certbot renew --dry-run --cert-name amabaruwa.rwazap.com
  ```

---

## 6. Vérifications

```bash
curl -sS https://amabaruwa.rwazap.com/api/health
curl -sS -o /dev/null -w '%{http_code}\n' https://amabaruwa.rwazap.com/_/
curl -sS https://amabaruwa.rwazap.com/api/collections/lettres/records
ss -ltnp | grep 8095
docker compose -p amabaruwa ps
```

Attendu :

- santé `200` ;
- `/_/` → `404` ;
- liste anonyme contenant uniquement les contenus publiés ;
- port `8095` lié à `127.0.0.1` ;
- conteneur `healthy`.

---

## 7. Retour arrière

1. Restaurer `pb_data` sauvegardé (voir `docs/backup-restore.md`) ;
2. restaurer la version précédente des fichiers backend ;
3. `docker compose up -d --build` ;
4. si nécessaire, restaurer l'ancien vhost puis `nginx -t` et
   `systemctl reload nginx` ;
5. ne jamais supprimer le certificat des autres domaines.

Les migrations disposent d'une fonction `down` ; ne rétrograder qu'après
sauvegarde et validation sur une base isolée.

---

## 8. Sécurité

- Aucun secret dans Git ni dans Flutter.
- `pb_data` et les sauvegardes ne sont jamais servis par Nginx.
- Superuser créé hors historique shell, accès admin par tunnel SSH.
- Ne pas lancer de nettoyage Docker global.
- Ne pas toucher aux autres services ni aux certificats existants.
