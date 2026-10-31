# Sauvegarde et restauration — Amabaruwa

---

## 1. Principes

- Un volume Docker n'est **pas** une sauvegarde.
- Une copie sur le même VPS ne protège pas de la perte du VPS.
- Ne jamais copier à chaud une base SQLite active sans méthode cohérente.
- Ne jamais restaurer une sauvegarde sur la production pour « tester ».
- Toute restauration se teste d'abord dans un environnement isolé.

---

## 2. Contenu à sauvegarder

- `/opt/amabaruwa-pb/pb_data` : base SQLite, fichiers PDF/MP3, journaux,
  réglages PocketBase.
- `/opt/amabaruwa-pb/.env` (non secret en soi, mais à protéger).
- Migrations et configuration Nginx versionnées dans Git.
- Certificats : gérés par Certbot, non copiés manuellement.

---

## 3. Sauvegarde cohérente

### Option A — arrêt bref du conteneur (simple et sûre)

```bash
cd /opt/amabaruwa-pb
STAMP=$(date -u +%Y%m%dT%H%M%SZ)
docker compose stop
tar -czf "/home/trading/amabaruwa-pb-$STAMP.tar.gz" pb_data .env
docker compose start
sha256sum "/home/trading/amabaruwa-pb-$STAMP.tar.gz" \
  > "/home/trading/amabaruwa-pb-$STAMP.tar.gz.sha256"
```

Transfert hors VPS (depuis le poste local) :

```bash
scp trading@148.230.124.5:/home/trading/amabaruwa-pb-*.tar.gz* .
```

### Option B — sauvegarde PocketBase intégrée

Le tableau de bord PocketBase permet de créer et télécharger une sauvegarde
cohérente sans arrêter le service. Utiliser un accès par tunnel SSH, puis
copier l'archive hors du VPS. Ne pas exposer les sauvegardes via Nginx.

### Rétention suggérée

- 7 sauvegardes quotidiennes ;
- 4 hebdomadaires ;
- 3 mensuelles ;
- au moins une copie hors VPS et une copie hors site.

---

## 4. Restauration en environnement isolé

Ne jamais utiliser la production comme cible de test.

1. Copier l'archive sur le poste de développement.
2. Créer un répertoire de test :
   ```bash
   mkdir -p /tmp/amabaruwa-restore
   tar -xzf amabaruwa-pb-YYYYMMDDTHHMMSSZ.tar.gz -C /tmp/amabaruwa-restore
   ```
3. Lancer un PocketBase isolé sur un port différent :
   ```bash
   cd /tmp/opencode
   ./pbbin/pocketbase serve \
     --dir=/tmp/amabaruwa-restore/pb_data \
     --migrationsDir=/home/i/projets/amabaruwa/backend/pb_migrations \
     --http=127.0.0.1:18099 \
     --automigrate=0
   ```
4. Vérifier :
   ```bash
   curl http://127.0.0.1:18099/api/health
   curl http://127.0.0.1:18099/api/collections/lettres/records
   ```
5. Contrôler le nombre de lettres, les fichiers PDF/audio et les règles
   anonymes.
6. Arrêter l'instance isolée et supprimer le répertoire de test.

---

## 5. Restauration en production

1. Prévenir et planifier une fenêtre de maintenance.
2. Sauvegarder l'état actuel avant toute restauration.
3. Arrêter uniquement le projet :
   ```bash
   cd /opt/amabaruwa-pb
   docker compose stop
   ```
4. Déplacer l'ancien `pb_data` (ne pas le supprimer) :
   ```bash
   mv pb_data "pb_data.avant-restauration-$(date -u +%Y%m%dT%H%M%SZ)"
   ```
5. Extraire l'archive validée.
6. Corriger les permissions :
   ```bash
   chown -R trading:trading pb_data
   chmod 750 pb_data
   ```
7. Redémarrer et vérifier :
   ```bash
   docker compose start
   curl -sS http://127.0.0.1:8095/api/health
   curl -sS https://amabaruwa.rwazap.com/api/health
   ```
8. Comparer le nombre de contenus et les fichiers.
9. Si échec, revenir à `pb_data.avant-restauration-*`.

Les migrations déjà appliquées sont enregistrées dans la base ; ne pas
restaurer une base plus récente que le code déployé sans vérifier la
compatibilité des migrations.
