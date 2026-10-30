#!/usr/bin/env bash
# Amabaruwa — obtention du certificat TLS via webroot, sans arrêter Nginx.
# À exécuter avec sudo après activation du vhost HTTP et vérification DNS.
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  echo "Erreur : exécuter avec sudo." >&2
  exit 1
fi

EMAIL="${ACME_EMAIL:-keziakdos@gmail.com}"
DOMAIN="amabaruwa.rwazap.com"
WEBROOT="/var/www/amabaruwa-acme"

if [[ ! -d "${WEBROOT}" ]]; then
  echo "Erreur : webroot ACME absent (${WEBROOT})." >&2
  exit 1
fi

certbot certonly \
  --webroot \
  --webroot-path "${WEBROOT}" \
  --cert-name "${DOMAIN}" \
  -d "${DOMAIN}" \
  -m "${EMAIL}" \
  --agree-tos \
  --no-eff-email \
  --keep-until-expiring \
  --non-interactive \
  --deploy-hook 'systemctl reload nginx'

echo "Certificat disponible pour ${DOMAIN}."
