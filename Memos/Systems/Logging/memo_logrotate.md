Logrotate
==============================

What is it ?
-----------------------------

Un sytème de rotation de log.


Links
-----------------------------

### Manpage

http://www.linuxcommand.org/man_pages/logrotate8.html

### Tutos

https://linuxconfig.org/logrotate


How it works ?
-----------------------------

Logrotate archive et compresse tous les logs actuels pour en créer de nouveaux.
Il est capable de lancer des commandes avant et après ce changement de log, comme redémarrer un service.
Logrotate est à executer normalement, via la crontab (par défaut dans /etc/cron.daily/logrotate).

### Les options :

TODO

Installation
-----------------------------

### over apt

    apt-get install logrotate

Configuration
-----------------------------

### Main file

Le fichier principal de configuration se trouve dans /etc/logrotate.conf
Il devrait y avoir un :

    include /etc/logrotate.d

### Ajouter un ou des logs à logrotate :

    vim /etc/logrotate.d/example

    logs_to_manage {
        options
    }

Exemple avec lighttpd :

    /var/log/lighttpd/*.log {
        weekly
        missingok
        rotate 12
        compress
        delaycompress
        notifempty
        sharedscripts
        postrotate
           if [ -x /usr/sbin/invoke-rc.d ]; then \
              invoke-rc.d lighttpd reopen-logs > /dev/null 2>&1; \
           else \
              /etc/init.d/lighttpd reopen-logs > /dev/null 2>&1; \
           fi; \
        endscript
    }

On peut aussi lister les logs de la manière suivante :

    /var/log1
    /var/log2
    {
        options...
    }

### Logrotate dans la cron :

Par défaut le script suivant devrait se trouver dans /etc/cron.daily/logrotate :

    #!/bin/sh

    # Clean non existent log file entries from status file
    cd /var/lib/logrotate
    test -e status || touch status
    head -1 status > status.clean
    sed 's/"//g' status | while read logfile date
    do
        [ -e "$logfile" ] && echo "\"$logfile\" $date"
    done >> status.clean
    mv status.clean status

    test -x /usr/sbin/logrotate || exit 0
    /usr/sbin/logrotate /etc/logrotate.conf


Manipulations
-----------------------------

### Executer logrotate manuellement :

    logrotate -vf /etc/logrotate.conf
