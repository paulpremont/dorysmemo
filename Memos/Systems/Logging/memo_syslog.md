Syslog
==============================

What is it ?
-----------------------------

Syslog est un système de centralisation de log ainsi qu'un protocole d'échange.  
Il permet de collecter, filtrer, transmettre et stocker des logs.  
Il définit un format standard pour les événements du système et des applications.

Nous allons voir ici surtout la version améliorée **syslog-ng**  
Un autre mémo fera référence à rsyslog.

Links
-----------------------------

### Official

* [Site officiel](https://syslog-ng.org/)
* [Sources Github](https://github.com/balabit/syslog-ng)
* [wikipedia](https://fr.wikipedia.org/wiki/Syslog)
* [Admin guide](https://www.balabit.com/documents/syslog-ng-ose-latest-guides/en/syslog-ng-ose-guide-admin/html/)

### Tutos

* [une bonne explication sur le fonctionnement de syslog](http://ram-0000.developpez.com/tutoriels/reseau/Syslog/)

### Alternatives/compléments

* [rsyslog](http://www.rsyslog.com/)
* [Logstash(shipper)](https://www.elastic.co/fr/products/logstash)
* [NXLog](https://nxlog.co/)
* [Graylog2-fr](http://www.graylog.fr/)

* [Un gros comparatif de solutions de log](http://blog.takipi.com/the-7-log-management-tools-you-need-to-know/)
* [Comparaison entre rsyslog et syslog-ng](https://www.balabit.com/syslog-ng-rsyslog-comparison)


How it works ?
-----------------------------

Syslog est écrit en C et permet de collecter des logs depuis n'importe quelle source d'événements.

### Fonctionnement

L'application syslog-ng lit les messages d'entrées (source) et les renvoi vers les destinations configurées.  
Il peut recevoir des messages depuis un fichier, un hôte distant ou d'autres sources. 

Des drivers sont écrits permettant de collecter les données au bon format (tel que des fichiers).
Les drivers permettent aussi d'envoyer de la données formattée.

![syslog-ng fonctionnement](Pictures/syslog-ng.png)

### Composition

Syslog est composé de :

* Un périphérique (génère les fichiers syslog)
* Un relais (reçoit les messages syslog et les retransmet)
* Un collecteur (reçoit et collecte les messages syslog)

Port par défaut d'écoute : UDP 514

### Notions

Le protocole syslog renseigne :

* le N° de fonctionnalité (facility) 
défini par la [RFC 3164](http://www.faqs.org/rfcs/rfc3164.html) sur 24 numero.

* le N° de sévérité (severity) défini ainsi :

Numéro de sévérité | Usage
0 | Emergency : system is unusable
1 | Alert : action must be taken immediately
2 | Critical : critical conditions
3 | Error : error conditions
4 | Warning : warning conditions
5 | Notice : normal but significant condition
6 | Informational : informational messages
7 | Debug : debug-level messages

* le N° de priorité (priority) qui est égal à (facility * 8 + severity)

À savoir que la priorité n'influence pas la vitesse de traitement du log...
C'est juste une indication.

### Structure de la trame :

* PRI (priority)
* HEADER (Timestamp [Mmm dd hh:mm:ss] + hostname(facultatif) )
* MSG (Message du log à transférer)

Exemple :

    <165>May 18 14:46:18 192.168.1.1 Un message Syslog classique

Dans un fichier de log :

    Nov 30 15:16:27 logger syslog-ng[977]: syslog-ng starting up; version='3.5.6'

### Versions

syslog est aujourd'hui décliné en trois solutions :

* syslog
* rsyslog
* syslog-ng

**syslog** est la base du projet syslog, il est légé et permet de faire l'essentiel, stocker, rediriger les logs.
**rsyslog** est une amélioration de syslog avec l'ajout de modules, de filtres, et de transport sécurisé (TLS) et du TCP.
**syslog-ng** ajoute en plus de rsyslog, la classification, les tags et la correlation de message en temps réel et une structure orientée objet.

syslog-ng semble être le plus abouti et sa configuration plus lisible par rapport à rsyslog.
Il est aussi plus récent.

### Modes d'envoi des messages

* Un fichier
* UNIX SOCKET (SOCK_STREAM ou SOCK_DGRAM)
* UDP/TCP


Installation
-----------------------------

Ubuntu :

    apt-get install syslog-ng


Configuration
-----------------------------

Le fichier principal de configuration se trouve dans **/etc/syslog-ng/syslog-ng.conf**
Pour la configuration des variables d'initialisation voir  **/etc/default/syslog-ng**

### Configuration du client

**1- On ajoute les sources d'événements**

Exemple :

    #Unix socket
    source s_src {
           #unix DGRAM /dev/log
           system();
    
           #kernel messages /proc/kmsg
           internal();
    };

    #File
    source s_nginx {
           #file driver
           file("/var/log/nginx/access.log" follow-freq(1));
    };

À savoir qu'il est toujours préférable d'utiliser la fonctionnalité syslog depuis l'application en question si c'est possible.

**2- On ajoute les destinations**

C'est à dire où va être redirigé l'événement.

Exemple :

    destination d_syslog { file("/var/log/syslog"); };

**3- On écrit les filtres**

Exemple :

    filter f_syslog3 { not facility(auth, authpriv, mail) and not filter(f_debug); };

**4- On créer notre nouveau log**

Un log est défini par une source, un filtre et une destination.

Exemple  :

    log { source(s_nginx); filter(f_syslog3); destination(d_syslog); };

Dans notre cas si on a un serveur nginx qui tourne et qu'on fait un wget sur le locahost,
On verra apparaître le message du access.log dans syslog :

    Nov 30 18:06:10 logger 127.0.0.1 - - [30/Nov/2016:18:06:09 +0000] "GET / HTTP/1.1" 200 612 "-" "Wget/1.17.1 (linux-gnu)"

### Configuration du serveur

Le serveur devra être mis comme destinatire au niveau du client.

Exemple au niveau du client :

    destination d_syslog_tcp {
         syslog("10.1.2.3" transport("udp") port(2016)) 
    };

Sur le serveur il faudra récupérer les informations avec une source :

    source s_network { 
        syslog(ip(10.1.2.3) transport("udp") port(2016)); 
    };

Et créer le même cheminement que pour un client, c'est à dire définir un filtre et un endroit où stocker les données.

### Configuration du relay

En mode relay il suffit de faire pointer la source sur son socket et le rediriger vers un autre serveur.

Exemple :

    log { source(s_local); source(s_network);
      destination(d_syslog_tcp);
    };

Note : on peut définir plusieurs sources et destination sur une même ligne de log.


Manipulations
-----------------------------

### Service

    service syslog-ng start

### Voir la connextion unix (mode client)

    netstat -nxp

Exemple d'output :

    Proto RefCnt Flags       Type       State         I-Node   PID/Program name    Path
    unix  2      [ ]         DGRAM                    422786   8706/syslog-ng      /dev/log

### Test d'envoi de log avec logger

    logger fake log
