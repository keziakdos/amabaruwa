#!/usr/bin/env bash
# Amabaruwa — activation du vhost HTTPS après obtention du certificat.
# À exécuter avec sudo. Teste Nginx puis recharge, sans redémarrage.
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "Erreur : exécuter avec sudo." >&2
  exit 1
fi

DST="/opt/amabaruwa-pb"
CONF_SRC="${DST}/nginx/amabaruwa.rwazap.com.conf"
CONF_DST="/etc/nginx/sites-available/amabaruwa.rwazap.com.conf"
LINK="/etc/nginx/sites-enabled/amabaruwa.rwazap.com.conf"
CERT="/etc/letsencrypt/live/amabaruwa.rwazap.com/fullchain.pem"

if [[ ! -f "${CERT}" ]]; then
  echo "Erreur : certificat absent (${CERT})." >&2
  exit 1
fi
if [[ ! -f "${CONF_SRC}" ]]; then
  echo "Erreur : vhost HTTPS introuvable (${CONF_SRC})." >&2
  exit 1
fi

cp -a "${CONF_DST}" "${CONF_DST}.http.bak.$(date +%s)"
install -m 0644 "${CONF_SRC}" "${CONF_DST}"
ln -sfn "${CONF_DST}" "${LINK}"

nginx -t
systemctl reload nginx

echo "Vhost HTTPS Amabaruwa actif."
