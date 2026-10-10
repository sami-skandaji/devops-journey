#!/bin/bash
set -euo pipefail   # arrête le script à la première erreur

# Variables et substitution de commande
NOM="Skand"
DATE=$(date +%F)
echo "Bonjour $NOM, nous sommes le $DATE"

# Arguments : $1 = premier argument, $# = nombre d'arguments
if [ "$#" -ne 1 ]; then
  echo "Usage : $0 <dossier>"
  exit 1
fi

if [ -d "$1" ]; then
  echo "$1 est un dossier"
else
  echo "$1 n'existe pas"
fi

# Boucle sur des services
for service in nginx cron ssh; do
  if systemctl is-active --quiet "$service"; then
    echo "$service : OK"
  else
    echo "$service : ARRÊTÉ"
  fi
done
