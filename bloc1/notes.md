# Bloc 1 — Linux, Bash, réseau

## Séance 1 — Fichiers et permissions (10 oct. 2026)

### Commandes clés
- `pwd`, `ls -la`, `cd`, `cd ..`, `cd -`, `tree -L 1`
- `mkdir -p`, `touch`, `cp`, `mv`, `rm` (pas de corbeille !)
- `cat`, `head -n 3`, `tail`, `grep '^MOT'` (^ = début de ligne)
- `>` écrase le fichier, `>>` ajoute à la fin

### Dossiers importants
- `/etc` : configuration
- `/var/log` : logs
- `/home` : utilisateurs
- `/usr/bin` : programmes
- `/tmp` : fichiers temporaires

### Permissions
- `-rwxr-x---` = type + propriétaire + groupe + autres
- r=4, w=2, x=1 → 644 fichier, 755 script ou dossier, 600 secret
- `chmod +x` donne x à tous, `chmod u+x` au propriétaire seulement
- `chown user:groupe fichier` change le propriétaire

### Mon erreur
- `cp fichier config` crée un FICHIER nommé `config` si le dossier `config` n'existe pas à cet endroit

## Séance 2 — Processus et services (10 oct. 2026)

### Processus
- `ps aux`, `htop`, `pgrep nom`, `kill PID` (`kill -9` en dernier recours)
- `&` lance en arrière-plan, `jobs` liste les tâches
- `|` envoie la sortie d'une commande à la suivante

### systemd
- `systemctl status|start|stop|restart|reload nom`
- `stop` = maintenant, `disable` = au prochain démarrage, `disable --now` = les deux
- `journalctl -u nginx --since "10 min ago"` : logs d'un service
- `sudo ss -tlnp` : ports en écoute

### Nginx
- Config : `/etc/nginx/sites-available/`, activée par un lien dans `sites-enabled/`
- Pages : `/var/www/html/`
- Logs : `/var/log/nginx/`
- Toujours `sudo nginx -t` avant `reload` ou `restart`
- `sudo echo ... > fichier` échoue → `echo ... | sudo tee fichier`

### Mon erreur
- Un `;` manquant → `invalid parameter "listen"`. Le message donne le fichier et la ligne.

## Séance 3 — SSH et GitHub (10 oct. 2026)

### SSH
- Paire de clés : la privée reste sur ma machine (600), la publique `.pub` se donne aux serveurs (644)
- `ssh-keygen -t ed25519 -C "email"` : génère la paire dans `~/.ssh/`
- `ssh -T git@github.com` : teste la connexion à GitHub

### Git et GitHub
- `git init -b main` dans le dossier racine du projet, jamais dans `~`
- `git add .` → `git status` (toujours vérifier) → `git commit -m "..."` → `git push`
- `git remote add origin git@github.com:pseudo/depot.git` (adresse SSH du bouton Code)
- `git remote set-url origin ...` pour corriger l'adresse
- `.gitignore` : `*.env` et `*.log` pour ne jamais publier secrets et logs

### Mon erreur
- Je pensais qu'ajouter un fichier au `.gitignore` après coup suffisait. Faux :
  1. le `.gitignore` ignore seulement les fichiers pas encore suivis ;
  2. le fichier reste lisible dans l'historique.
- Si un secret est poussé : le changer immédiatement, puis `git rm --cached fichier`, puis nettoyer l'historique (`git filter-repo`).

## Séance 4 — Scripting Bash et cron (10 oct. 2026)

### Bash
- Début de script : `#!/bin/bash` puis `set -euo pipefail` (stop à la première erreur)
- `VAR=$(commande)` : stocker le résultat d'une commande
- `$1` premier argument, `$#` nombre d'arguments, `${1:-80}` valeur par défaut
- Nombres : `-eq -ne -gt -ge -lt -le` ; texte : `= !=` ; fichier `-f`, dossier `-d`
- Toujours des guillemets : `"$VAR"` ; `${VAR}%` pour coller du texte
- Code de sortie : `0` = succès, autre = échec ; `echo $?` pour le voir ; `exit 1` pour signaler un échec

### Extraire des chiffres
- Disque : `df --output=pcent / | tail -1 | tr -d ' %'`
- RAM utilisée (Mo) : `free -m | awk '/^Mem:/ {print $3}'`
- Date : `date '+%F %T'`

### cron
- `crontab -e` pour modifier, `crontab -l` pour lister
- 5 champs : minute heure jour mois jour-semaine (vérifier sur crontab.guru)
- Toujours des chemins absolus + `>> fichier.log 2>&1`
- Vérifier : `journalctl -u cron --since "5 min ago" --no-pager`
- Sous WSL, cron ne tourne que si Ubuntu est ouvert

