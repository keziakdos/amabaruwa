# Suivi du projet Amabaruwa

Ce document consigne les constats, décisions, commandes exécutées, tests et
blocages, sans aucun secret. Il est mis à jour après chaque phase.

Dernière mise à jour : 2026-10-31 — Phase 4 TLS terminée, import de production en attente d'identifiants.

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

### Vérifications sudo (exécutées par le propriétaire le 2026-10-30)

- `sudo nginx -t` : **succès**
  (`syntax is ok` / `test is successful`), avec le seul avertissement
  préexistant `protocol options redefined for [::]:443` dans
  `rwaresto.rwazap.com.conf:26`. Aucun autre avertissement.
- `sudo certbot certificates` : 12 certificats existants
  (`coach`, `deco`, `hinga`, `n8n`, `news`, `proba`, `resto`, `rwaresto`,
  `rwazap`, `trade`, `trading`, `webmaster`), tous valides, **aucun
  certificat `amabaruwa.rwazap.com`**.
- `sudo ufw status verbose` : `Status: inactive`. Aucune règle pare-feu
  modifiée.
- `/etc/letsencrypt/live` : 12 répertoires de domaines + `README`, aucun
  répertoire Amabaruwa.

### Blocages identifiés

1. **Adresse e-mail ACME** non connue pour Certbot : à fournir/confirmer en
   phase 4 (ne pas réutiliser arbitrairement un compte existant).
2. **Environnement Flutter local cassé** : SDK pointant vers
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

## Phase 2 — Audit du site et base graphique

### Audit de https://www.inzirayakristu.com (2026-10-30)

- Site WordPress / thème Avada 3.16.2, accessible (HTTP 200, ~83 Ko).
- API WordPress : `wp-json` et `wp/v2/pages` accessibles ; `wp/v2/posts`
  retourne une liste vide (le contenu est publié en pages).
- 22 pages publiées, dont :
  - `Murisanga` (accueil),
  - `Nyirikwandika`,
  - `Amabaruwa` + « ijambo ry'ibanze iriburiro ibikubiyemo » + lettres 1 à 9,
  - pages Audio (introduction, lettres 1 à 4),
  - `Bene BUDAMA`, `Kudutumaho`, `murisanga`.
- Sitemap : PDF `Ibanze-Iriburiro-Ibikubiyemo.pdf` et `Ibaruwa-1.pdf` à
  `Ibaruwa-9.pdf`.
- Médiathèque (75 éléments) : PDF des 9 lettres, MP3 de l'introduction et
  des lettres 1 à 4, **plus des MP3 découpés par chapitres** pour les lettres
  3 et 4 (`ibaruwa-ya-3-igice-cya-1.mp3`, etc.).
- **Ambiguïté audio** : la relation exacte entre les MP3 par chapitres et les
  lettres n'est pas explicite. Aucune correspondance n'a été devinée ;
  elle sera traitée en phase 5 (inventaire + validation).
- Structure d'une page lettre : titre `Ibaruwa ya N :`, bloc `KRISTU
  ARAGARUTSE`, sous-titre `Arivugira ukuri kwe.`, `AMABARUWA YA KRISTU`,
  lien source `www.christsway.co.za`, texte, puis lien
  `Soma / Télécharger / Download` vers le PDF.
- Bannière observée : `Kristu-aragaruste-2-scaled.jpg` (2560 × 1237), texte
  intégré « Kristu / Aragarutse / Arivugira ukuri kwe mu mabaruwa 9
  n'inyandiko 16 ».
- Logo observé : `Logo-Inzirayakristu.jpg` (950 × 390),
  « BeneBUDAMA / AmabaruwaYaKristu ». Ce n'est pas un logo Amabaruwa isolé :
  usage comme icône à valider.
- Favicon observé : `cropped-Logo-Inzirayakristu-1-192x192.jpg`.
- Typographie du site : Raleway / Open Sans. L'application retient **Lato**
  (OFL) conformément à `AGENTS.md` ; écart documenté.

### Ressources intégrées au dépôt

- `assets/images/brand/kristu-aragarutse-banner.jpg` (bannière officielle).
- `assets/images/brand/bene-budama-logo.jpg` (logo officiel observé).
- `assets/fonts/Lato-Light.ttf`, `Lato-Regular.ttf`, `Lato-Bold.ttf`,
  `Lato-Black.ttf` et `OFL.txt`.
- `docs/design-system.md` : palette, contrastes WCAG calculés, typographie,
  espacements, composants, navigation, adaptation téléphone/tablette,
  accessibilité, thème sombre, points ouverts.
- `docs/prototype/index.html` : prototype interactif des 5 écrans
  (accueil, bibliothèque, lecture, audio, téléchargements), autonome, sans
  CDN, avec données **explicitement fictives** (badges « URUGERO GUSA »).
  Aucune citation religieuse inventée.

### Contrastes clés (WCAG calculés)

- `#25364A` sur blanc : 12,32:1 (AAA).
- `#FFC52E` sur `#25364A` : 7,79:1 (AAA).
- `#FFFFFF` sur `#FFC52E` : 1,58:1 → interdit.
- `#9B9B9B` sur blanc : 2,78:1 → interdit pour du texte.

### Vérifications du prototype

Exécutées avec Chromium headless (Playwright), viewport 390 × 844 :

- chargement sans erreur console ni erreur JavaScript ;
- aucun débordement horizontal (`scrollWidth = clientWidth = 390`) ;
- navigation entre les 5 écrans fonctionnelle ;
- recherche locale fonctionnelle ; filtre favoris fonctionnel ;
- lecteur simulé : lecture/pause, position, avance de 15 s, mini-lecteur ;
- réglage de taille de lecture fonctionnel (18 → 20 px testé) ;
- captures des 5 écrans vérifiées visuellement (non versionnées).

### Points ouverts (phase 2)

1. Logo / icône : valider l'usage du logo BeneBUDAMA ou choisir une
   solution typographique sobre « Amabaruwa ».
2. Formulation de bannière : conserver la version exacte des pages lettres.
3. Correspondance audio ↔ lettres : à résoudre en phase 5.
4. Traductions kinyarwanda de l'interface à faire relire.
5. Attribution `inzirayakristu.com` à conserver.

## Phase 3 — Backend reproductible

### Version retenue

- **PocketBase v0.40.6**, release officielle du 2026-10-23
  (`https://github.com/pocketbase/pocketbase/releases/tag/v0.40.6`).
- Archive `pocketbase_0.40.6_linux_amd64.zip`.
- SHA-256 vérifié au build :
  `0e1f609158ed945f809f8a02ae012aa0427129c66ebb63c1aee76f2c0309373f`.
- Architecture VPS : `x86_64` (compatible `linux/amd64`).

### Fichiers créés

- `backend/Dockerfile` : Alpine 3.20.3, PocketBase épinglé, empreinte
  vérifiée, utilisateur `pocketbase` (UID 10001), healthcheck.
- `backend/docker-entrypoint.sh` : préparation de `/pb_data` puis `su-exec`.
- `backend/compose.yaml` : compatibilité Compose v1/v2 (`version: "3.9"`),
  port `127.0.0.1:${AMABARUWA_PORT:-8095}:8090`, volume `./pb_data`,
  migrations en lecture seule, `init`, `no-new-privileges`, logs bornés.
- `backend/.env.example` : `COMPOSE_PROJECT_NAME=amabaruwa`,
  `AMABARUWA_PORT=8095`.
- `backend/.dockerignore` : exclut données, `.env`, logs.
- `backend/pb_migrations/` :
  - `1750000000_create_lettres.js`,
  - `1750000100_create_mots_du_jour.js`,
  - `1750000200_initial_settings.js`.
- `backend/nginx/amabaruwa.rwazap.com.conf` : vhost HTTP/HTTPS dédié,
  challenge ACME webroot, `client_max_body_size 200M`, blocage public de
  `/_/`, proxy Range, SSE optionnel.
- `backend/README.md` : version, exploitation, migrations, superuser.

### Collections et règles

`lettres` :

- champs conformes à `AGENTS.md` : numéro entier positif, slug, langue,
  titre, HTML, statut (`brouillon`/`publie`), PDF 50 MiB, audio MP3 100 MiB,
  URL d'origine, `source_key`, date source, tailles, SHA-256, durée audio ;
- index uniques `source_key` et `(numero, langue)` ; index statut et slug ;
- lecture anonyme : `statut = "publie"` ;
- écriture anonyme : interdite (`create/update/delete = null`) ;
- fichiers `protected: true`.

`mots_du_jour` :

- `date_locale` (format `YYYY-MM-DD`), langue, titre, citation,
  `reference_source`, relation optionnelle `lettre_liee`, audio extrait,
  statut, `source_key` ;
- index uniques `source_key` et `(date_locale, langue)` ;
- lecture anonyme :
  `statut = "publie" && (lettre_liee = "" || lettre_liee.statut = "publie")` ;
- fichiers `protected: true`.

Réglages : nom `Amabaruwa`, URL `https://amabaruwa.rwazap.com`, logs 14 jours,
IP non journalisée, proxy de confiance `X-Forwarded-For` / `X-Real-IP`.

### Tests exécutés sur base isolée (jamais la production)

1. Build de l'image : **succès**, empreinte SHA-256 validée (`OK`).
2. Démarrage Compose projet `amabaruwa-test`, port `18096` : conteneur
   `Up (healthy)`.
3. Migrations appliquées sur base neuve : collections `lettres` et
   `mots_du_jour` présentes avec les règles attendues.
4. `/api/health` : `200`.
5. Lecture anonyme : seule la lettre publiée apparaît ; le brouillon est
   masqué.
6. Écriture anonyme : `403` sur `lettres` et `mots_du_jour`.
7. Fichiers : PDF publié accessible (`200`) sans jeton ; PDF de brouillon
   inaccessible (`404`) même avec URL directe et jeton aléatoire.
8. Brouillon : API record `404` en anonyme.
9. Relation : mot du jour lié à une lettre brouillon masqué ; mot du jour
   lié à une lettre publiée visible.
10. Unicité : `source_key` dupliquée → `400` ; `(numero, langue)` dupliqué
    → `400`.
11. Persistance : `down` puis `up` du projet de test, enregistrements
    conservés.
12. Vhost Nginx testé avec un certificat auto-signé temporaire :
    `nginx: configuration file ... test is successful`.

### Notes d'exploitation

- `COMPOSE_PROJECT_NAME=amabaruwa` dans `.env` garantit le nom de projet.
- PocketBase démarre avec `--automigrate=0` ; les migrations sont montées en
  lecture seule.
- La commande superuser doit inclure `--dir=/pb_data` lorsqu'elle est lancée
  via `docker compose exec`.
- Le conteneur de test local a été arrêté et retiré ; aucune ressource VPS
  n'a été créée en phase 3.

## Phase 4 — Déploiement VPS (en cours)

### Réalisé

- Staging transféré vers `/home/trading/amabaruwa-pb-stage`.
- Exécution par le propriétaire de `deploy/bootstrap.sh` avec sudo :
  - création de `/opt/amabaruwa-pb` (propriétaire `trading`, mode 0750) ;
  - création de `/var/www/amabaruwa-acme` (propriétaire `www-data`) ;
  - installation du vhost HTTP dédié ;
  - `nginx -t` réussi (seul avertissement préexistant `rwaresto`) ;
  - rechargement Nginx, sans redémarrage.
- `.env` créé sur le VPS (`COMPOSE_PROJECT_NAME=amabaruwa`,
  `AMABARUWA_PORT=8095`, mode 0600).
- `docker compose config` valide, projet `amabaruwa`, binding
  `127.0.0.1:8095`.
- Image construite avec empreinte PocketBase vérifiée (`OK`).
- Conteneur `amabaruwa-pocketbase-1` démarré, `Up (healthy)`.
- Santé locale `http://127.0.0.1:8095/api/health` : `200`.
- Port 8095 lié uniquement à `127.0.0.1`.
- Accès HTTP public `http://amabaruwa.rwazap.com/api/health` : `200`.
- Interface `/_/` en HTTP public : `404`.
- Challenge ACME : chemin accessible (fichier absent → `404`).
- Adresse ACME retenue : `keziakdos@gmail.com`.
- Certificat Let's Encrypt émis le 2026-10-30, valide jusqu'au 2027-01-28
  (émetteur `YE1`, CN `amabaruwa.rwazap.com`).
- Vhost HTTPS activé ; HTTP redirige en `301` vers HTTPS.
- `https://amabaruwa.rwazap.com/api/health` : `200`, certificat vérifié.
- En-têtes Nginx/PocketBase vérifiés (HTTP/2, `nosniff`, `SAMEORIGIN`).
- `/_/` public : `404`.
- Écriture anonyme : `403`.
- Challenge ACME conservé en HTTP (fichier absent → `404`, pas de redirection).
- Superuser créé par le propriétaire via le tableau de bord (mot de passe
  saisi hors conversation).
- Services existants inchangés (mêmes conteneurs, mêmes ports).

### Reste à faire

1. Vérifier le renouvellement :
   `sudo certbot renew --dry-run --cert-name amabaruwa.rwazap.com`.
2. Importer en production le pilote puis les contenus non ambigus.
3. Vérifier les médias HTTPS et les requêtes Range après import.

---

## Phase 5 — Inventaire et import

### Script

- `scripts_migration/sync_inzira.py` : modes `inventory`, `dry-run`, `pilot`,
  `full`, `sync`.
- `scripts_migration/requirements.txt` : dépendances verrouillées.
- `docs/content-import.md` : procédure complète, sécurité et résultats.
- Identifiants PocketBase uniquement via `PB_ADMIN_EMAIL` /
  `PB_ADMIN_PASSWORD`, jamais en argument.
- Téléchargements `.part`, contrôle MIME, taille, signature et SHA-256.
- HTML généré depuis le texte des PDF, sans script ni contenu actif.
- `scripts_migration/reports/` et `tmp/` exclus de Git.

### Inventaire (2026-10-30)

- 9 lettres numérotées, 9 PDF importables.
- PDF : 6,28 Mio ; audio importable : 157,63 Mio ; total 163,91 Mio.
- Audio importable : lettres 1 et 2 uniquement.
- Audio ambigu, ignoré : lettres 3 (7 chapitres) et 4 (8 chapitres).
- Document d'introduction ignoré (non classé comme lettre).
- Aucun « Mot du jour » identifié : aucune création automatique.

### Tests sur base isolée locale

- Import pilote lettre 1 : texte 90 083 caractères, PDF et audio vérifiés
  (`Range` → `206`).
- Relance pilote : `skipped`, aucun doublon.
- Import complet : 9 lettres publiées ; audio sur 1 et 2 ; PDF sur 9.
- Relance complète : 9 `skipped`.
- Lecture anonyme des 9 lettres : OK ; écriture anonyme : `403`.
- Passage en brouillon : invisible en anonyme, puis republication contrôlée.
- Fichiers temporaires supprimés, conteneurs de test retirés.

### Correction de schéma

- Migration `1750000300_content_limits.js` : `contenu_html` porté à
  200 000 caractères et `citation` à 20 000, la valeur `max: 0` étant
  interprétée par PocketBase comme 5 000.

### Reste à faire

- Importer le pilote puis les contenus non ambigus dans l'instance de
  production, après création du superuser et activation HTTPS.
- Faire valider une éventuelle sélection éditoriale « Mot du jour ».

---

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
