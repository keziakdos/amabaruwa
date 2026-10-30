# Suivi du projet Amabaruwa

Ce document consigne les constats, décisions, commandes exécutées, tests et
blocages, sans aucun secret. Il est mis à jour après chaque phase.

Dernière mise à jour : 2026-10-30 — Phase 1 terminée (push initial effectué).

---

## Phase 1 — Inspection du dépôt et vérifications en lecture seule

### Dépôt local (WSL2 Ubuntu)

- Répertoire de travail : `/home/i/projets/amabaruwa`.
- État initial : répertoire **non versionné**, contenant uniquement `AGENTS.md`
  et `Prompt.md` (aucun `.git`, aucun code source).
- `Prompt.md` renommé en `PROMPT.md` afin de respecter la casse attendue par
  `AGENTS.md` (systèmes de fichiers sensibles à la casse).
- Dépôt Git initialisé sur la branche `main`.
- Remote `origin` : `git@github.com:keziakdos/amabaruwa.git` (SSH).
- Identité Git locale disponible : `keziakdos <keziakdos@gmail.com>`.

### Dépôt distant GitHub

- Dépôt `keziakdos/amabaruwa` : **public**. À l'inspection initiale il était
  **vide** (`size: 0`), branche par défaut `main`.
- Après le commit initial, le `push` a réussi : la branche `main` distante
  pointe sur `696e6a07d49d90026b45700121d4911b88831745`.
  **Le droit d'écriture Git est donc confirmé par un push réel** (sans
  force-push).
- `git ls-remote` (HTTPS et SSH) : aucune référence retournée, cohérent avec
  un dépôt vide.
- Authentification SSH GitHub vérifiée en lecture :
  `Hi keziakdos! You've successfully authenticated, but GitHub does not
  provide shell access.`
- La lecture ne prouve pas l'écriture ; celle-ci a été confirmée par le
  `push` initial de la branche `main`.

### VPS

- Hôte : `srv944093`, Ubuntu 24.04.5 LTS, architecture `x86_64`.
- Utilisateur : `trading` (`uid=1001`), groupes `trading`, `sudo`, `users`,
  `docker`. Connexion SSH par clé fonctionnelle, `BatchMode` actif.
- Docker : `29.9.2` ; Docker Compose : `v5.6.1`.
- Espace disque `/` : 48 G au total, 15 G utilisés, **33 G disponibles (32 %)**.
- Mémoire : 3,8 Gi au total, ~3,0 Gi utilisés, ~804 Mi disponibles.
- `/opt/amabaruwa-pb` : **inexistant**.
- Port TCP **8095 : libre** (aucun binding, aucun conteneur).

### Conteneurs et services existants (état initial à préserver)

| Nom | État | Binding | Image |
| --- | --- | --- | --- |
| `rwaresto-app` | Up 5 days (healthy) | `127.0.0.1:3107->3000` | `rwaresto-app:latest` |
| `rwatrade_app` | Up 7 days | `127.0.0.1:5005->5000` | `rwatrade-web` |
| `rwazap_news_app` | Up 7 days | `127.0.0.1:8001->5000` | `rwazap-news-web` |
| `coach-app` | Up 7 days | `127.0.0.1:8005->8005` | `coach_web` |
| `n8n` | Up 7 days | `0.0.0.0:5678->5678` (IPv4 + IPv6) | `n8nio/n8n` |
| `n8n-new` | Exited (255) 5 months | `127.0.0.1:5679->5678` | `docker.n8n.io/n8nio/n8n` |

Écart constaté par rapport à `AGENTS.md` : `n8n` écoute sur `0.0.0.0:5678`
et non uniquement en loopback. Aucune action : service extérieur au périmètre.

Sockets TCP supplémentaires observés côté hôte (hors périmètre, non modifiés) :
`3306` (MySQL, loopback), `6379` (Redis, loopback + `::1`), `8000`, `5006`
(gunicorn), `22`, `80`, `443`.

Réseaux Docker existants : `bridge`, `host`, `none`, `coach_default`,
`root_default`, `rwaresto_internal`, `rwatrade_default`, `rwazap-news_default`,
`traderwazapcom_rwatrade_net`.

### Nginx

- Version : `nginx/1.24.0 (Ubuntu)`.
- Aucun vhost ni référence `amabaruwa` dans `sites-available` / `sites-enabled`.
- Avertissement préexistant confirmé :
  `protocol options redefined for [::]:443` dans
  `/etc/nginx/sites-enabled/rwaresto.rwazap.com.conf:26`.
  **Non corrigé** conformément aux consignes.
- Le test `nginx -t` en tant qu'utilisateur non privilégié échoue uniquement
  sur la lecture des certificats (`/etc/letsencrypt/live/...`) : résultat non
  concluant. Le test effectif nécessite `sudo` (voir blocages).

### Certbot et TLS

- Certbot `5.9.0` installé (`/usr/bin/certbot`).
- Aucun certificat Amabaruwa. `https://amabaruwa.rwazap.com` renvoie une erreur
  de nom de certificat (`no alternative certificate subject name matches`),
  comportement attendu avant la phase 4.
- Le certificat Amabaruwa sera créé en phase 4 (ce n'est pas un prérequis
  fourni par le propriétaire).

### DNS

- `amabaruwa.rwazap.com` → A `148.230.124.5`.
- Aucun AAAA, aucun CNAME. Conforme.

### Blocages identifiés

1. **`sudo` interactif requis** : `sudo -n` retourne
   `sudo: a password is required`. Les vérifications effectives suivantes sont
   en attente d'une exécution interactive par le propriétaire :
   `sudo nginx -t`, `sudo certbot certificates`, `sudo ufw status`.
   Le mot de passe ne doit jamais transiter par la conversation.
2. **Adresse e-mail ACME** non connue pour Certbot : à fournir/confirmer en
   phase 4.
3. **Environnement Flutter local cassé** : SDK pointant vers
   `/mnt/c/src/flutter` avec fins de ligne CRLF
   (`shared.sh: $'\r': command not found`) ; `java` absent ; SDK Android
   présent côté Windows (`/mnt/c/Users/DiD/AppData/Local/Android/Sdk`).
   Décision : installer un SDK Flutter Linux natif dans `~/flutter` (phase 6).

### Décisions validées par le propriétaire

- `sudo` : saisie interactive du mot de passe par le propriétaire dans son
  terminal ; aucune commande `sudo` automatisée sans TTY.
- Dépôt : initialisation Git + renommage `Prompt.md` → `PROMPT.md` + push.
- Flutter : installation d'un SDK Linux natif sous WSL (Java 17 + Android SDK).

### Port retenu

Le port **8095** étant libre, le binding retenu est
`127.0.0.1:${AMABARUWA_PORT}:8090` avec `AMABARUWA_PORT=8095`.
PocketBase écoutera sur `0.0.0.0:8090` dans le conteneur.

### Commandes exécutées

- `git status`, `git ls-remote`, `ssh -T git@github.com`
- `git init -b main`, `git remote add origin`, `git commit`, `git push -u origin main`
- `mv Prompt.md PROMPT.md`
- `ssh trading@148.230.124.5 'id; uname -m; ...; docker ps -a; ss -ltnp; ...'`
- `dig A/AAAA/CNAME amabaruwa.rwazap.com`
- `curl` vers `inzirayakristu.com` et `amabaruwa.rwazap.com`
- `nginx -t` (sans `sudo`, non concluant)

### Plan des phases suivantes

- **Phase 2** : audit `https://www.inzirayakristu.com`, `docs/design-system.md`,
  maquettes des écrans accueil / bibliothèque / lecture / audio /
  téléchargements avec données fictives isolées.
- **Phase 3** : backend PocketBase épinglé, `backend/` (Dockerfile,
  `compose.yaml`, `.env.example`, migrations, modèle Nginx), tests sur base
  isolée.
- **Phase 4** : `/opt/amabaruwa-pb`, déploiement projet `amabaruwa`, vhost
  dédié, Certbot webroot, HTTPS + redirection, vérifications, rollback.
- **Phase 5** : `scripts_migration/sync_inzira.py` et import pilote idempotent.
- **Phase 6** : application Flutter (thème solaire, kinyarwanda, offline-first).
- **Phase 7** : tests (format, analyze, test, tests physiques documentés).
- **Phase 8** : `.github/workflows/android-build.yml`.
- **Phase 9** : documentation finale, commits, rapport de livraison.
