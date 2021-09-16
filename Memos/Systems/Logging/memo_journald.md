Journald
==============================

What is it ?
-----------------------------

Journald est le service de collecte de log introduit par systemd.
Il améliore notamment la prise d'information lors de la phase de boot.
Le format de log est aussi plus précis que pourraît l'être syslog.


Links
-----------------------------

### Tutos et Articles

* [logging with systemd](https://www.loggly.com/ultimate-guide/linux-logging-with-systemd/)
* [why journald](https://www.loggly.com/blog/why-journald/)
* [Utiliser journald](http://www.linuxtricks.fr/wiki/utiliser-journalctl-les-logs-de-systemd)


How it works ?
-----------------------------

Journald bénéficie de son propre format de données.
Il ajoute une structure pour les fichiers de logs.
Les logs sont sauvegardés dans un fichier binaire pour optimiser la prise d'information.
Journald ne necessite pas l'installation d'un logrotate.
Il permet d'intérroger rapidement ses logs en fonction de critère de selection à la manière d'une base de données.

Par défaut les fichiers de log sont volatiles et écrit dans :

    /run/log/journal

Il est possible de les rendre persistants via la configuration, et seront stockés dans :

    /var/log/journal

### Mode distant, inconvénient
    
L'inconvénient majeur, actuel, de journald,
est qu'il ne fournit pas, par défaut, de système de centralisation de log distant comme pourrait le faire syslog.
Et forcement dans le domaine de l'industrie cela peut poser problème.
Voir : **systemd-journal-remote** ou **journald-forwarder**.

Installation
-----------------------------

journald est installé par défaut avec systemd.


Configuration
-----------------------------

La configuration se fait par défaut au niveau de **/etc/systemd/journald.conf**.

Il est possible d'overrider la conf existante avec plusieurs fichiers de conf :

* /etc/systemd/journald.conf.d/*.conf
* /run/systemd/journald.conf.d/*.conf
* /usr/lib/systemd/journald.conf.d/*.conf

Notez que le fichier de conf principal est d'abord lu avant les autres fichiers custom (.conf).

Pour avoir toutes les infos de config :

    man journald.conf

### Stockage des logs

#### Mode volatile

Uniquement en RAM

    [journal]
    storage=volatile

#### Mode persistant

Sur le disque

    [journal]
    storage=persistent

### Forward des logs vers syslog

2 méthodes possibles :

* via un socket
* via un fichier journal

#### mode socket

Pour envoyer les logs vers syslogd, on peut le faire en envoyant les données sur un socket **/run/systemd/journal/syslog)**
Ceci est rendu possible par l'option **ForwardToSyslog=**

#### mode fichier journal

Il suffit de configurer journald en mode "storage=persistent".

Manipulations
-----------------------------

### Processus 

    /lib/systemd/systemd-journald

### Service

    service systemd-journald status

### Afficher les logs à la manière d'un less

    journalctl

### Afficher les logs à la manière d'un tail -f

    journalctl -f

### Filtrer :

On peut combiner les options suivantes :

**par service**

    journalctl -u crond

**par PID**

    journalctl _PID=<PID_Number>

**par programme**

    journalctl /usr/sbin/sshd

**par niveau de log**

    journalctl -p err

**depuis une date**

    journalctl --since "2016-02-10 21:00:00"

**jusqu'à une date**
    
    journalctl --until "2016-02-10 22:00:00"
