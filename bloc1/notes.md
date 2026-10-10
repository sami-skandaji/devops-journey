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
