SYSSTAT
==============================

What is it ?
-----------------------------

Un système de monitoring de performance de son système par l'intermédiaire d'un service.
Permet de collecter des données de performance (CPU, RAM, I/O, Network) dans le temps.
C'est une suite de binaires.

On l'utilise pour faire des mesures de performance mais aussi pour faire des contrôles d'activité et de debug.

Links
-----------------------------

* [Référence sysstat](http://pagesperso-orange.fr/sebastien.godard/documentation.html)
* [sysstat howto](https://www.linux.com/learn/sysstat-howto-deployment-and-configuration-guide-linux-servers)
* [wiki sysstat](https://wiki.deimos.fr/Sysstat_:_Des_outils_indispensable_pour_analyser_des_probl%C3%A8mes_de_performances#sar)

How it works ?
-----------------------------

systat est un service permettant de collecter des données dans le temps grâce à plusieurs utilitaires.

### Les utilitaires

* iostat : pour les statistiques CPU, I/O des périphériques, des partitions et des fs réseaux.
* mpstat : ensemble de statistiques concernant le CPU.
* pidstat : ensemble de stats pour chaque process.
* sar : Collècte et créer des rapports sur les données d'activités du système (CPU, RAM, disks, interrupts, network interfaces, TTY, kernel tables, socket, NFS...)
* sadc : Backend pour sar, il permet de sauvegarder les données.
* sa1 : Collècte les données journalières sous forme de binaire. C'est un frontend de sadc executé en cron.
* sa2 : Ecrit un résumé de l'activité système journalier. C'est un frontend de sar executé en cron.
* sadf : Affiche les données collectées par sar dans de multiples formats (CSV, XML...) => utilise pour générer des graphiques.

Les 4 composants principaux de sysstat pour la collecte de données sont :

* sar (système activity report)
* sa1, sa2 et cron

Par défaut le résultat de la collecte est donc écrit sous forme de binaire dans :

**/var/log/sysstat/**

Les fichiers sont sous la forme saXX où XX représente le jour de collecte.

!!! note
    Par dafaut la collecte de données se fait toutes les 10 minutes.

### Cron

Systat a besoin de la cron pour collecter les données.

Par défaut il créer un fichier dans :

*/etc/cron.d/sysstat* pour la collecte des données toutes les 10 minutes :

    # The first element of the path is a directory where the debian-sa1
    # script is located
    PATH=/usr/lib/sysstat:/usr/sbin:/usr/sbin:/usr/bin:/sbin:/bin

    # Activity reports every 10 minutes everyday
    5-55/10 * * * * root command -v debian-sa1 > /dev/null && debian-sa1 1 1

    # Additional run at 23:59 to rotate the statistics file
    59 23 * * * root command -v debian-sa1 > /dev/null && debian-sa1 60 2

et dans */etc/cron.daily/sysstat* pour la création d'un rapport résumé journalier :

    #!/bin/sh
    # Generate a daily summary of process accounting.  Since this will probably
    # get kicked off in the morning, it is run against the previous day data.

    #  our configuration file
    DEFAULT=/etc/default/sysstat
    #  default settings, overriden in the above file
    ENABLED=false

    [ ! -x /usr/lib/sysstat/sa2 ] && exit 0

    # read our config
    [ -r "$DEFAULT" ] && . "$DEFAULT" 

    [ "$ENABLED" = "true" ]  || exit 0

    exec /usr/lib/sysstat/sa2 -A


Installation
-----------------------------

### La suite d'outils sysstat :

    apt-get install sysstat

### Interface de visualisation des graphes :

    apt-get install isag

Configuration
-----------------------------

### Service

Activer le service :

*/etc/default/sysstat*

    ENABLED="true"

### Mysql (optionnel)

todo

### isag

Fichier de conf par défaut : **$HOME/.isag.cfg**  
Path par défaut des binaires sar recherché : **/var/log/sysstat**

Manipulations
-----------------------------

### Démarrer le service de collecte :

    service sysstat start

### sar

Exemples de mesures :

#### Sur NFS (toutes les 5 secondes, 3 fois) :

    sar -n NFS 5 3

Continuer d'écrire le résultat dans un binaure :

    sar -n NFS 5 3 -o /tmp/sa99

#### Sur les interfaces réseaux (toutes les secondes deux fois) :

    sar -n DEV 1 2

#### Check d'un process en particulier :

    pidstat -p 2365 1 50

#### Check de la mémoire :

    sar -r 1 30
    vmstat -n 1 30

#### Check du CPU :

    sar -u 1 3

#### Check des devices :

    sar -d -p 1 2

!!! note
    Pour pouvoir ensuite grapher le résultat avec isag, utilisez l'option -o pour écrire un nouveau fichier.
    exemple: -o /tmp/sa99

### isag

isag doit pouvoir accéder aux binaires saXX

#### Afficher les données sous forme de graphique :

    isag

depuis un dossier custom :

    isag -p $HOME/sysstat
