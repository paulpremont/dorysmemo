# rsyslog's issues

## Erreur Impossible de redémarrer le service rsyslog

    Failed to restart rsyslog.service: Unit rsyslog.service is masked

### Lien :

[Forum Debian](http://forums.debian.net/viewtopic.php?f=5&t=126190)


### Résolution :

    systemctl unmask rsyslog.service
