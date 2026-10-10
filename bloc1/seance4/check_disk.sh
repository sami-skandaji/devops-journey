#!/bin/bash
set -euo pipefail

SEUIL=${1:-80}
UTILISATION=$(df --output=pcent / | tail -1 | tr -d ' %')
MAINTENANT=$(date '+%F %T')

if [ "$UTILISATION" -ge "$SEUIL" ]; then
  echo "[$MAINTENANT] ALERTE : disque à ${UTILISATION}% (seuil ${SEUIL}%)"
  exit 1
else
  echo "[$MAINTENANT] OK : disque à ${UTILISATION}%"
fi
