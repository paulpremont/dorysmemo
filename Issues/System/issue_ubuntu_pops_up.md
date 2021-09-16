# Ubuntu pop up issue

## Erreur "program problem detected"

Popups : system program problem detected

### Lien :

[askubuntu.com](http://askubuntu.com/questions/133385/getting-system-program-problem-detected-pops-up-regularly-after-upgrade/369297)

### Résolution :

Ce sont les erreurs rapportées par apport.

Supprimer les rapports de crash :

    sudo rm /var/crash/*

Killer les popups :

    killall system-crash-notification

Désactiver apport :

    vim /etc/default/apport
        enabled=0
    service apport stop
