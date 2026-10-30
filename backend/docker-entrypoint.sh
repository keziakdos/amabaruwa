#!/bin/sh
set -eu

# PocketBase s'exécute en utilisateur non privilégié. Le volume ./pb_data est
# préparé ici pour éviter de dépendre des permissions de l'hôte.
mkdir -p /pb_data
chown -R pocketbase:pocketbase /pb_data

exec su-exec pocketbase /pb/pocketbase "$@"
