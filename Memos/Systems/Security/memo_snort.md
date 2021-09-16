S N O R T
==============================

What is it ?
-----------------------------

SNORT est un détecteur d'intrusion résueau (NIDS pour Network Intrusion Detection System).
Il permet d'analyser le flux, de loguer des paquets et de lever des alertes.
La communauté partage un ensemble de règle permetant de détecter plus facilement ces intrusions.
Il peut aussi fonctionner en mode IPS (Intrusion Prevention System).

Bientôt en version 3.0

Links
-----------------------------

### Official

* [Site officiel](https://www.snort.org/)
* [Documents](https://www.snort.org/documents)
* [Documentation](http://manual-snort-org.s3-website-us-east-1.amazonaws.com/)
* [Plugin OpenAppID slides](https://s3.amazonaws.com/snort-org-site/production/document_files/files/000/000/066/original/OpenAppID-Community-Webinar.pdf?AWSAccessKeyId=AKIAIXACIED2SPMSC7GA&Expires=1480101871&Signature=gMvEUbChOGxZz3GDOvj7vv5Re9s%3D)
* [Pulledpork pour rester à jour](https://github.com/shirkdog/pulledpork)

### Sources

Voir la page downloads pour récupérer les dernières versions

* [downloads](https://www.snort.org/downloads/#rule-downloads)
* [daq-2.0.6](https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz)
* [snort-2.9.8.3](https://www.snort.org/downloads/snort/snort-2.9.8.3.tar.gz)
* [community-rules](https://www.snort.org/downloads/community/community-rules.tar.gz)
* [OpenAppID](https://www.snort.org/downloads/openappid/4602)

### Tutos

* [SNORT CookBook](http://commons.oreilly.com/wiki/index.php/Snort_Cookbook)
* [doc.ubuntu-fr](https://doc.ubuntu-fr.org/snort)
* [Utiliser OpenAppID](https://www.osnet.eu/fr/content/tutoriels/utiliser-openappid-snort-et-le-logiciel-pfsense%C2%AE)
* [SNORT en mode IPS](http://sublimerobots.com/2016/02/snort-ips-inline-mode-on-ubuntu/)
* [Installation de SNORT](http://www.emind.co/how-to/how-to-install-snort/)

### Alternatives

* [Bro](https://www.bro.org/index.html)
* [Suricata](https://suricata-ids.org/)
* [Suricata vs SNORT](http://wiki.aanval.com/wiki/Snort_vs_Suricata)

How it works ?
-----------------------------

Snort est écrit principalement en C, il peut fonctionner selon 3 modes :

* Sniffer (Affichage du flux sur la console (comme tcpdump)
* Packet Logger (permet de loguer les paquets sur un espace de stockage)
* NIDS (Détecte et analyse le flux)

Le mode Sniffer et Packet Logger sont comparables aux fonctionnalités de tcpdump.
Il est possible d'ajouter un mode IPS avec snort.

#### Mode sniffer

Permet de lire le flux en direct sur sa console (visualisation)

#### Mode Packet Logger

Permet de sauvegarder et lire du flux à partir de logs.
Les logs sont sous la forme de binaires et peuvent être compatible tcpdump.

#### DAQ (Data Acquisition library)

C'est une couche d'abstraction à la libpcap

#### Workflow d'analyse :

1. Capture (Lecture du paquet)
2. Decoder 
3. Preprocessor
4. Detector (Application des règles)
5. Alerting

![schema du workflow de traitement du flux](http://seclists.org/snort/2012/q3/att-894/image.png)

#### Rules


Installation
-----------------------------

### Depuis les sources 

Note : 

L'installation via les sources est un peu fastidieuse.  
Bien qu'écrite de façon simpliste sur le site officiel,  
pas mal d'erreurs sont à prévoir (dépendances manquantes, problèmes dans les paths ...).  
Il faut bien regarder les options de configuration et s'aider des tutos en ligne.

    ./configure --help

Section à revoir.

#### Dépendances

    apt-get install build-essential wget flex bison libpcap-dev libpcre3-dev libdumbnet-dev zlib1g-dev

Des tools utils :

    apt-get install nmap tcpdump

#### Obtention des sources

    wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz
    wget https://www.snort.org/downloads/snort/snort-2.9.8.3.tar.gz

#### Installation de la DAQ

    tar xvzf daq-2.0.6.tar.gz
    cd daq-2.0.6
    ./configure && make && sudo make install

#### Installation de snort

    tar xvzf snort-2.9.8.3.tar.gz
    cd snort-2.9.8.3
    ./configure --enable-sourcefire && make && sudo make install

Vérifications

    snort --version

Il est possible de l'installer avec le support de mysql.

#### Installation des règles

**Les règles de la communauté**

    mkdir -p /etc/snort/community
    wget https://www.snort.org/downloads/community/community-rules.tar.gz
    tar -xvzf community-rules.tar.gz -C /etc/snort/community

**Les règles des personnes enregistrées. (plus complètes)**  
Il faut récupérer son **OINKCODE** disponible sur son compte et télécharger les règles de sa version SNORT.

    mkdir -p /etc/snort/registered
    oinkcode='XXXXXXX'
    version='2983'
    wget https://www.snort.org/rules/snortrules-snapshot-${version}.tar.gz?oinkcode=${oinkcode}
    tar -xvzf snortrules-snapshot-${version}.tar.gz* -C /etc/snort/registered
    
### Depuis les packages

#### Ubuntu :

    apt-get install snort snort-doc


Configuration
-----------------------------

### Rules

#### Pattern

Une règle est constituée de la sorte :

**RuleAction/RuleType Protocol Source SourcePort** DirectionOperator **Destination DestPort Options**

#### Actions possibles

alert : générer une alerte
log : loguer un paquet
pass : ignorer le paquet
activate : alerte et active une règle dynamique
dynamic : règle qui attend d'être activée
drop : détruire le paquet
reject : bloque le paquet et envoi un message d'erreur
sdrop : bloque le paquet et ne log pas

Il est possible de créer ses propres actions :

**Exemple :**

Créer son action (log tcpdump) :

    ruletype suspicious
    {
        type log
        output log_tcpdump: suspicious
    }

ou encore une action de qui log à la fois en mode syslog et tcpdump :

    ruletype redalert
    {
          type alert 
          output alert_syslog: LOG_AUTH LOG_ALERT 
          output log_tcpdump: suspicious.log
    }

utilisation :

    suspicious tcp $HOME_NET any -> $HOME_NET 6667 (msg:"Internat_IRC_Server";)

#### Création d'une règle


Manipulations
-----------------------------


### Mode Sniffer 

**Afficher le header TCP/IP des paquets sur la console**

    snort -v

Attention, des paquets peuvent être droppés dû à la lenteur d'affichage.

**Afficher en plus la couche applicative + le header de la couche liaison.**

    snort -vde

Un CTRL+C pour annuler et afficher les statistiques.

**Exemple d'output lors d'un ping + l'option -v :**

    WARNING: No preprocessors configured for policy 0.
    11/28-13:35:22.055573 10.0.3.1 -> 10.0.3.160
    ICMP TTL:64 TOS:0x0 ID:16467 IpLen:20 DgmLen:84 DF
    Type:8  Code:0  ID:19654   Seq:1  ECHO

Et de dump de statistique :

    ===============================================================================
    Run time for packet processing was 27.634610 seconds
    Snort processed 8 packets.
    Snort ran for 0 days 0 hours 0 minutes 27 seconds
       Pkts/sec:            0
    ===============================================================================
    Memory usage summary:
      Total non-mmapped bytes (arena):       782336
      Bytes in mapped regions (hblkhd):      21590016
      Total allocated space (uordblks):      669968
      Total free space (fordblks):           112368
      Topmost releasable block (keepcost):   105456
    ===============================================================================
    Packet I/O Totals:
       Received:            8
       Analyzed:            8 (100.000%)
        Dropped:            0 (  0.000%)
       Filtered:            0 (  0.000%)
    Outstanding:            0 (  0.000%)
       Injected:            0
    ===============================================================================
    Breakdown by protocol (includes rebuilt packets):
            Eth:            8 (100.000%)
           VLAN:            0 (  0.000%)
            IP4:            6 ( 75.000%)
           Frag:            0 (  0.000%)
           ICMP:            6 ( 75.000%)
            UDP:            0 (  0.000%)
            TCP:            0 (  0.000%)
            IP6:            0 (  0.000%)
        IP6 Ext:            0 (  0.000%)
       IP6 Opts:            0 (  0.000%)
          Frag6:            0 (  0.000%)
          ICMP6:            0 (  0.000%)
           UDP6:            0 (  0.000%)
           TCP6:            0 (  0.000%)
         Teredo:            0 (  0.000%)
        ICMP-IP:            0 (  0.000%)
        IP4/IP4:            0 (  0.000%)
        IP4/IP6:            0 (  0.000%)
        IP6/IP4:            0 (  0.000%)
        IP6/IP6:            0 (  0.000%)
            GRE:            0 (  0.000%)
        GRE Eth:            0 (  0.000%)
       GRE VLAN:            0 (  0.000%)
        GRE IP4:            0 (  0.000%)
        GRE IP6:            0 (  0.000%)
    GRE IP6 Ext:            0 (  0.000%)
       GRE PPTP:            0 (  0.000%)
        GRE ARP:            0 (  0.000%)
        GRE IPX:            0 (  0.000%)
       GRE Loop:            0 (  0.000%)
           MPLS:            0 (  0.000%)
            ARP:            2 ( 25.000%)
            IPX:            0 (  0.000%)
       Eth Loop:            0 (  0.000%)
       Eth Disc:            0 (  0.000%)
       IP4 Disc:            0 (  0.000%)
       IP6 Disc:            0 (  0.000%)
       TCP Disc:            0 (  0.000%)
       UDP Disc:            0 (  0.000%)
      ICMP Disc:            0 (  0.000%)
    All Discard:            0 (  0.000%)
          Other:            0 (  0.000%)
    Bad Chk Sum:            0 (  0.000%)
        Bad TTL:            0 (  0.000%)
         S5 G 1:            0 (  0.000%)
         S5 G 2:            0 (  0.000%)
          Total:            8

### Mode Packet Logger


**Sauvegarde du flux dans un dossier**

    snort -dev -l snort_log_dir

Au format tcpdump (plus légé et approprié pour les grosses captures)

    snort -dev -l snort_log_dir -b

Spécifier le réseau "home" pour trier l'output :

    snort -dev -l snort_log_dir -h 192.168.1.0/24

**Lire les paquets sauvegardés**

    snort -dv -r mon_paquet

### Mode IDS

**Lancer SNORT en tant que service**

Si l'on a installé SNORT depuis les sources, il faura faire un peu de conf pour le faire fonctionner en tant que service.

    service snort start

**Lancer en mode IDS en foreground**

    snort -dev -l snort_logs/ -h 10.0.3.0/24 -c /etc/snort/snort.conf

**Lancer en mode IDS en background**

Rajouter l'option -D

    snort -D -dev -l snort_logs/ -h 10.0.3.0/24 -c /etc/snort/snort.conf

Exemple du service snort :

    snort -m 027 -D -d -l /var/log/snort -u snort -g snort -c /etc/snort/snort.conf -S HOME_NET=[10.0.3.0/24] -i eth0

### Choisir son type d'output :

[Snort cookbook pour choisir son type d'output](http://commons.oreilly.com/wiki/index.php/Snort_Cookbook/Logging,_Alerts,_and_Output_Plug-ins#Installing_and_Configuring_MySQL)
[Doc officielle sur les différent types d'output (plus pauvre que le cookbook)](http://manual-snort-org.s3-website-us-east-1.amazonaws.com/node21.html)

#### Built-in format

Avec l'option -A :

* fast    #format simplifié (timestamp, message d'alerte, source et destination)
* full    #format détaillé
* unsock  #envoyer les alertes à un socket
* none    #pas d'alerte
* console #Afficher l'alerte en console
* cmd     #format cmg

**fast**

    -A fast

Exemple :

    11/29-11:35:22.362915  [**] [1:408:5] ICMP Echo Reply [**] [Classification: Misc activity] [Priority: 3] {ICMP} 10.0.3.95 -> 10.0.3.1

**full**

format complet des alertes

    -A full

Exemple :

    [**] [1:366:7] ICMP PING *NIX [**]
    [Classification: Misc activity] [Priority: 3] 
    11/29-11:36:48.327073 10.0.3.1 -> 10.0.3.95
    ICMP TTL:64 TOS:0x0 ID:34861 IpLen:20 DgmLen:84 DF
    Type:8  Code:0  ID:24060   Seq:1  ECHO


## OLD

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    En mode IDS : pas d'agissement niveau système mis à part de l'alerting.
        Le traffic peut être tapé dans ce mode

    En mode IPS : Snort doit faire partie de la chaine pour pouvoir agir sur le flux avant qu'il n'arrive vers les services réseaux.

    Il fonctionne de façon modulaire:
        Noyau de base
        Pré processeurs
        Analyseurs apres pre-process
        filtre IDS

    Les étapes:
        Lorsque snort reçoit un paquet il passe par:
            Decoders
            Preprocessors
            Detector (Application des règles)

    Le préprocessor:
        Il prépare les données pour le 'Detector'

        Exemple sur TCP:
            Contrôle d'état
            Construction de session
            Normalisation (changement des header à la volée)

        --------------------------
        Preprocessor Plugins
        --------------------------

            stream : réassemble les connections a travers le réseau
            defrag
            http_decode : écoute et restructure les paquets http

            ...

            exemple:
                preprocessor defrag



~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Voir /etc/snort/snort.conf

        --------------------------
        Unified2
        --------------------------

            C'est la méthode de records

            > vim snort.conf

                output unified2: filename merged.log, limit 128, nostamp, mpls_event_types, vlan_event_types


        --------------------------
        Logs
        --------------------------

            output alert_unified2: filename snort.alert, limit 128, nostamp
            output log_unified2: filename snort.log, limit 128, nostamp 
            output alert_syslog: LOG_AUTH LOG ALERT

        --------------------------
        Inclure un fichier
        --------------------------
            include fichier

            exemple:

                include $RULE_PATH/something

