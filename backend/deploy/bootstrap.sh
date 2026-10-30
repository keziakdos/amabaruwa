#!/usr/bin/env bash
# Amabaruwa — installation initiale côté VPS.
# À exécuter avec sudo par le propriétaire, après transfert du staging.
# Ne touche qu'aux ressources dédiées à Amabaruwa.
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "Erreur : exécuter avec sudo." >&2
  exit 1
fi

SRC="${SRC:-/home/trading/amabaruwa-pb-stage}"
DST="/opt/amabaruwa-pb"
CONF_SRC="${SRC}/nginx/amabaruwa.rwazap.com.http.conf"
CONF_DST="/etc/nginx/sites-available/amabaruwa.rwazap.com.conf"
LINK="/etc/nginx/sites-enabled/amabaruwa.rwazap.com.conf"

if [[ ! -d "${SRC}" ]]; then
  echo "Erreur : staging introuvable (${SRC})." >&2
  exit 1
fi
if [[ ! -f "${CONF_SRC}" ]]; then
  echo "Erreur : vhost HTTP introuvable (${CONF_SRC})." >&2
  exit 1
fi

install -d -o trading -g trading -m 0750 "${DST}"
rsync -a --delete \
  --exclude 'pb_data/' \
  --exclude '.env' \
  "${SRC}/" "${DST}/"

install -d -o trading -g trading -m 0750 "${DST}/pb_data"
chown -R trading:trading "${DST}"

install -d -o www-data -g www-data -m 0755 /var/www/amabaruwa-acme

if [[ -f "${CONF_DST}" ]]; then
  cp -a "${CONF_DST}" "${CONF_DST}.bak.$(date +%s)"
fi
install -m 0644 "${CONF_SRC}" "${CONF_DST}"
ln -sfn "${CONF_DST}" "${LINK}"

nginx -t
systemctl reload nginx

echo "Installation Amabaruwa terminée. Vhost HTTP actif."
