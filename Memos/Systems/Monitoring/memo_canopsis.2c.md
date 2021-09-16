C A N O P S I S
==============================

What is it ?
-----------------------------

Canopsis est une solution d'hypervision au sens "supervision" du terme.  
Il permet de centraliser les événements d'un SI, de sources de données telles que des superviseurs.  
Afin d'y appliquer de la corrélation et générer des vues métiers.  
Il permet de créer des statistics, notifications ... dans une dashboard customisable.
Il est compatible avec les superviseurs types nagios et toutes sources de données du moment qu'un connecteur AMQP existe. 


Links
-----------------------------

### Officiels

* [Documentation](http://canopsis.readthedocs.io/en/readthedocs/)
* [Présentation](http://www.canopsis.org/)
* [Lien commercial](http://www.canopsis.com/)
* [GitHub Sources](https://github.com/capensis/canopsis)
* [GitHub Wiki](https://github.com/capensis/canopsis/wiki)
* [Admin LTE](https://almsaeedstudio.com/themes/AdminLTE/index2.html)

### Tutos

* [tutos monitoring-fr](http://wiki.monitoring-fr.org/canopsis/start)
* [presentation technique](http://linuxfr.org/news/presentation-technique-de-canopsis)


How it works?
-----------------------------

Canopsis communique via le protocole AMPQ (Advanced Message Queuing Protocol).
AMPQ est un élément très important de canopsis, il est implémenté via RabbitMQ.

C'est par ce protocol qu'on peut connecter plusieurs sources de données au système.
Il suffit donc d'écrire un connecteur (si il n'existe pas déja) poru dialoguer avec Canopsis.

!!! note
    C'est le JSON qui est utilisé dans le bus d'AMPQ.

Les Features clés :

* Aggregation
* Filtering
* Correlation
* Business rules
* Notification
* Reporting
* Performance data

Il utilise une base noSQL MongoDB pour le stockage de données. (format JSON)

Pour la partie graphe, c'est la librairie Highchart qui est utilisée.

L'interfaçe web s'appuie sur Amber et AdminLTE pour la visualisation des évéments.

![canopsis](Pictures/canopsis.png)

### Architecture:

Canopsis embarque un système de Bus et queuing AMQP où toute l'info arrive sur le buffer 'exchange',  
le moteur 'cleaner' s'occupe ensuite de parser les données et de les mettre dans la première queue AMQP.  
Les autre moteurs vont ensuite "s'échanger" l'information aux travers de ces queues.

#### Les moteurs

##### Schéma interne


                     --------------------------------------------------------------------------
                     V                   V                                                    |
    [Cleaner] --> [EventFilter] --> [Derogation] --> [Tag] --> [PerfStore2] --> [EventStore]  |
       A                                                  -----------|------------|           |
       |                                                  V          V            V           |
    [Selector] <-- [Topology] <-- [Alert Counter] <-- [cleaner] [Random          [Persistent  |
       A            A                  |                         Access DB]       DB]       <-|
       |            |                   -------------------------^      V             A       |
       |            | [CollectDGW]  [SLA] [Consolidation]--------|     [Perfstore2_rotate]    |
       |            |        A        A         A                                             |
       ---------------------------------------------------------------------------------------


##### Moteurs synchrones

**Cleaner**

* Check si les messages sont bien formatés (Event Filter)
* Parse et export les données sous le bon format (Derogation)

**Tag**

* Tag les données (si un tag est définit)

**Perfstore2**

* Sauvegarde les perfdata dans la bdd random acess

**Event store**

* Sauvegarde les évenements passés

##### Moteurs Asynchrone

CollectDGW:

**SLA**

* Calcul des SLA

**Consolidation**

* Consolidation/Aggrégation des données.

**Perfstore2_rotate**

* Change les données de bases

        --------------------------
        Sources
        --------------------------

            Canopsis est multi-sources, n'importe quelles sources de données peut envoyer du flux AMQP à canopsis du moment que le format est respecté.

        --------------------------
        Connecteurs
        --------------------------

            Ce sont les scripts mis coté client pour transformer l'information sous la bonne bonne forme.

        --------------------------
        Evenements
        --------------------------

            Toutes les informations envoyées à Canopsis sont sous forme d'évenement.
            Dailleur même lorsque canopsis génére de nouveaux event, il le renvoie dans le bus AMQP comme n'importe quel event.

        --------------------------
        UI
        --------------------------
                __________________________
                Vues:

                    Chaque vue correspondant à une dashboard personnalisable contenant les widgets canopsis.
                    On peut y toruver un bac à évenement, une météo, des topologies ...

                    Par défaut il existe une vue 'bac à évenement' avec tout les évenements disponibles.
            
                __________________________
                widget:

                    On les insères dans les vue, c'est grâces aux widgest qu'on visualise les évenments sous la forme désirée.

Installation
-----------------------------

* [Depuis les paquets](https://github.com/capensis/canopsis/wiki/Install-from-packages)
* [Depuis les sources](https://github.com/capensis/canopsis/wiki/Install-from-sources)

### Utiliser une image officielle :

    mkdir Canopsis
    vagrant init capensis/debian7
    vagrant up
    vagrant box list    #normalement il installe un conteneur lxc (voir lxc-ls)
    vagrant ssh

### Installation depuis les sources

    #Install des prérequis
    apt-get update
    apt-get install sudo git-core libcurl4-gnutls-dev libncurses5-dev

    #Mise à jour des sources
    cd /opt
    git clone https://github.com/capensis/canopsis.git
    cd canopsis
    git submodule init
    git submodule update

    #Execution de l'installation (voir le dossier log en cas d'erreur)
    ./build-install.sh

!!! warning 
    Toutes les version d'OS ne sont pas supportées:
    Voir les dépendances (ou en créer une nouvelle) dans **/opt/canopsis/sources/extra/dependencies**

### Installer un module

    cd /opt/mmonModule
    ./build-install.sh -d /path/to/canospsis_sources  #(pas le dossier canopsis auto-généré)


Manipulations
-----------------------------

#### Démarrer Canopsis

    su - canopsis
    hypcontrol start

    #Faire un test fonctionnel :
    python opt/canotools/functional-test.py 

#### Accéder à l'interface

    http://Your_IP:8082 (Login: root, Password: root)


Tutos
-----------------------------

### Ajout d'un utilisateur

### Ajout d'un connecteur nagios

~~~~~~~~~~~~~~~~~~~~~~~~~~
Mise à jour
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > git pull
    > git submodule update
    > ./build-install.sh

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Tous les fichiers de configuration sont disponibles dans canopsis/etc

        --------------------------
        RabbitMQ (Côte Canopsis)
        --------------------------

            Les connecteurs AMQP vont se connecter au bus rabbitMQ.

            Il faut donc penser à le configurer, notament créer un utilisateur avec les droits sur le vhost canopsis.

            Par défaut RabbitMQ écoute sur toutes les interfaces.

            Note:

                Ne pas confondre avec la configuration de amqp.conf dans canopsis/etc

                __________________________
                Création d'un utilisateur RabbitMQ si il n'existe déja pas:
                (+ attribution des droits sur le vhost)

                    - soit via l'interface: (port 15672)

                    - soit manuellement:

                        > rabbitmqctl add_user monUser monPwd

                    Il ne faut pas oublier d'attribuer les droits au vhost:

                        > rabbitmqctl set_permissions -p monUser monPwd ".*" ".*" ".*"

        --------------------------
        Connecteurs
        --------------------------
                __________________________
                Shinken:


                        Installation du module:
                        ``````````````````````````

                            > shinken install canopsis  #(le search n'aboutissant pas !)
                            > easy_install kombu


                        Activation du module Canopsis au niveau du broker:
                        ``````````````````````````

                            > vim /etc/shinken/brokers/broker-master.cfg

                                define broker {
                                    ...
                                    modules livestatus, simple-log, webui, canopsis
                                    ...
                                }


                        Configuration du module
                        ``````````````````````````

                            > vim /etc/shinken/modules/canopsis.cfg

                            define module{
                                    module_name          canopsis
                                    module_type          canopsis
                                    host                 xxx.xxx.xxx.xxx	#Ip ou hostname de canopsis
                                    port                 5672		#correspond au port d'écoute de rabbitmq
                                    user                 guest      # à changer par un user rabbitmq
                                    password             guest      # à changer par son mot de passe
                                    virtual_host         canopsis
                                    exchange_name        canopsis.events
                                    identifier           shinken-1
                                    maxqueuelength       50000
                                    queue_dump_frequency 300
                            }


                            Note: si l'on change le socket d'écoute au niveau de canopsis [/opt/canopsis/etc/rabbitmq/rabbitmq.config]
                                    Il faudra aussi le faire sur [/opt/canopsis/etc/amqp.conf]

                        Mongodb
                        ``````````````````````````

                            Si l'on install shinken sur le même serveur que canopsis:
                            Il faudra changer le port d'écoute du mongodb de shinken:

                                > vim /etc/mongodb.conf

                                    port=27018

                                > vim /etc/shinken/module/mongodb.cfg

                                    uri             mongodb://localhost:27018/?safe=false

                        Restart des services
                        ``````````````````````````

                            > service mongodb restart
                            > service shinken restart

                __________________________
                centreon:

                __________________________
                cucumber:

        --------------------------
        Canopsis au démarrage / Contrôle des démons / boot
        --------------------------

            > ln -s /opt/canopsis/etc/init.d/canopsis /etc/init.d/

                __________________________
                Debian:

                    > update-rc.d canopsis defaults
                __________________________
                RHEL:

                    > chkconfig --add canopsis
                    > chkconfig |grep canopsis

	
~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Accès aux interfaces
        --------------------------
                __________________________
                canopsis:

                    Port: 8082

                    admin/admin
                    root/root

                __________________________
                rabbitmq:

                    Port: 15672

                    admin/admin

        --------------------------
        Les vues
        --------------------------
                __________________________
                Bac à événement:

                    Par défaut un bac évenement existe.

                    Cependant il faut créer un filtre pour les voir tous:

                    Exemple:

                        component != quelquechosequonnetrouverajamais


                __________________________
                Rajouter des onglets pointant sur une vue:

                    1) Edition d'une nouvelle vue
                    2) Récupération de son id via l'url
                    3) Edition de la vue 'header'
                    4) Ajout d'un nom d'onglet et de l'identifiant de la vue
                    5) refresh de l'interface

        --------------------------
        Widgets
        --------------------------
                __________________________
                Ajouter un widget:

                    1) Edition d'une nouvelle vue
                    2) Ajout d'un widget
                    3) choix du type de widget
                    4) Paramétrer l'affichage du widget via l'onglet "Mixin"


~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Impossible to find Python-2.7.9
        --------------------------
            1) Vérifier si le submodule à été correctement mis à jour:

                > git submodule init
                > git submodule update

            sinon) Charger python-2.7.9 dans le dossier sources:

                > cd /opt/canopsis/sources/external
                > wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tar.xz

        --------------------------
        Error 1 easy install
        --------------------------

            Si vous avez une erreur de ce type pendant l'installation, il faut checker le fichier correspondant:

            1) Vérifier si le submodule à été correctement mis à jour:

                > git submodule init
                > git submodule update

            sinon) Voir quelle commande ne passe pas:

                exemple:
                    /opt/canopsis/sources/build.d/25_python-libs.install

                    Et voir sur quelle installation le script plante:

                        > easy_install_pylib lxml

                        Récupérer l'output et debuguer

        --------------------------
        Error Code 1 - Impossible to install mongo (ou autre)
        --------------------------

            Checker les logs:
                > less /opt/canopsis/log/canolibs.log

            ImportError: Wrong path canopsis.mongo at ['canopsis'], errors when importing module canopsis.mongo : No module named bulk, 'module' object has no attribute 'mongo'

            
            --> solution: installation polluée, reinitialistion du repo.

        --------------------------
        collectd - problème de démarrage
        --------------------------
                __________________________
                Problèmes de démarrage:

                    #En canopsis
                    hypcontrol stop

                    #En root
                    pkill -9 -u canopsis

                    #En canopsis
                    cd
                    hypcontrol start

                    Pour fixer:

                    > vim etc/supervisord.conf

                        [supervisord]
                        directory=~/

                    Peut être aussi un problème de hosts (voir les logs de collectd dans tout les cas)

        --------------------------
        collectd - hypcontrol ERROR
        --------------------------
                __________________________
                logs:

                    canopsis_sources/logs/collectd

                __________________________
                Message type:

                    collectd ne démarre pas 

                __________________________
                Résolution:

                    - Voir les logs
                    - Vérifier que le fichier de configuration est bien présent dans /opt/canopsis/etc
                    - qu'il ne porte pas le nom collectd.conf.pkg-orig

                    Par exemple:

                        > mv collectd.conf.pkg-orig collectd.conf


        --------------------------
        socket error / problème de connexion avec un superviseur
        --------------------------

            -Attention au hostname si il a été changé ! (remettre l'ancien hostname sur la loopback dans le fichier hosts) .
                ou voir au niveau de la conf ou réinstaller avec le nouveau hostname)

            -Sinon bien vérifier les socket au niveau des conf du rabbitmq et celui de shinken. (par défaut il écoute sur toute les interfaces)
                Donc il ne devrait pas y avoir de souci à ce niveau.

        --------------------------
        Websocket unavailable
        --------------------------

            Vérifier les logs amqp:
                /opt/canopsis/var/log/rabbitmq
                __________________________
                access to vhost 'bidul' refused for user 'jesus'

                    IL faut s'assurer que le vhost rabbitmq soit créer:

                    > rabbitmqctl list_vhosts
                    > rabbitmqctl add_vhost bidul
                    > rabbitmqctl set_permissions -p bidul jesus ".*" ".*" ".*"

                    On redémarre canopsis

                    > hypcontrol restart

                    Et on clic sur le bouton websocket en haut à droite de la dashboard.

                    Le problème devrait être résolu (inchala)


        --------------------------
        Tuple index out of range
        --------------------------
                __________________________
                Message type:

                    File "/usr/local/lib/python2.7/dist-packages/shinken/daemons/brokerdaemon.py", line 268, in manage_brok
                    mod.manage_brok(b)                                                                                               
                    File "/var/lib/shinken/modules/canopsis/module.py", line 109, in manage_brok
                        self.manage_host_check_result_brok(b)
                    File "/var/lib/shinken/modules/canopsis/module.py", line 173, in manage_host_check_result_brok
                    logger.debug('[Canopsis] {0}: {1}'.format(err))
                    IndexError: tuple index out of range
                __________________________
                Résolution:
             
                    -- logger.debug('[Canopsis] {0}: {1}'.format(err))
                    ++ logger.debug('[Canopsis] Error: {0}'.format(err))


Notes :
----------------------

sources : sources d'événements
moteurs : traitement sur l'information
Hypervision : centralisation des événements dans un but de corrélation.
État : OK ou KO
Référentiel : Description du SI sous forme de données.
Ack: Par défaut, l'acquittement se fait au niveau de l'hyperviseur mais l'information ne redescend pas sur le superviseur.
Base de données: Mongodb (évéements), orienté documents [clé/valeur]
  InfluxDb pour la métrologie
Mettre en supervision l'hypervision
L'interface Web passe aussi par l'API pour aller cherher des données.


Exemple de sources de données :

* logs
* superviseurs
* CMDB
* tcicketing
* applications

Normalisation des données en JSON, publiés dans un bus AMQP. (Implémenté par RabbitMQ dans notre cas)

Publish AMQP Exchange -> Exchange => Binding sur une file d'attente (FIFO) -> consomateurs (traiter les données et prendre une décision).
C'est au niveau de l'Exchange que l'info est pris en compte par Canopsis. Attention il faut que l'info respecte le format de données. (Pas de log des drop mais écoute possible [car trop couteux])
Possibilité de mettre en place un 'Y' au niveau de rabbitMQ (dupplication des info sans impacter la prod)
Voir "Shovel" AMQP (https://www.rabbitmq.com/shovel.html)

Schéma AMQP : https://www.google.fr/search?q=AMQP&client=ubuntu&espv=2&biw=1920&bih=916&source=lnms&tbm=isch&sa=X&ved=0ahUKEwi52q_LhbDSAhUEchQKHS62AEoQ_AUIBigB#imgrc=OGzaAn8xTljSBM:

Moteur : Process dont le but est de traiter un événement, en flux tendu.
Traitement asynchrone, 
certain moteur travail à chaque beat une exection est faite (ex : calcul de stats)
Moteur de terminaison : stockage des données.

Conneccteur -> Bus AMQP -> Moteurs -> Bus AMQP -> Moteurs -> Stockage.
Dialogue entre moteur via AMQP ou par une base (permet d'aporter la garantie d'une Haute dispo, même information pour chaque process).

Événements :

  message entrant
  dispo et performances
  attribut natif ou spécifiques
  tout est événements (ex : acquittement = alarme, génération d'un event)

Structure d'un event :

Type et nom connecteur : Nagios ..
Type de l'event : Sup, Log ...
Composant : Sitch, disques ...
Message
Etat
...

### Installation

* service rabbitmq

* Par source : services embarqués
* Via ansible : services à la charge du système

client.events = exchange.

Un service pour le bus de données
Un service pour les moteurs
Un service pour ...
Un service pour la WebUI

Note, pour le passage avec un proxy, il est possible d'utiliser de la compression pour optimiser les performances.

/!\ si on passe par l'install via Ansible, les services seront gérés au niveau système et non plus niveau caopsis.
Il faut donc voir 

    service collectd start
    service amqp2engines start
    service webserver start
    service collectd start
    service webserver start

Pour gérer les services via hypcontrol :
Gestion des services avec Canopsis
, on peut paralléliser le lancement des moteurs en rajoutant l'*' après amqp2engines :

    /opt/canopsis/etc/hypcontrol.conf

    #!/bin/bash

    BACKEND=(rabbitmq-server mongodb influxdb)
    MIDDLEWARE=(collectd amqp2engines*)
    FRONTEND=(webserver)

!!! note
    On rajoute le * pour démarrer tous les services amqp


    amqp2engines:engine-acknowledgement-0 RUNNING    pid 8479, uptime 0:16:33
    amqp2engines:engine-cancel-0     RUNNING    pid 8315, uptime 0:16:35
    amqp2engines:engine-cleaner-alerts-0 RUNNING    pid 8474, uptime 0:16:33
    amqp2engines:engine-cleaner-events-0 RUNNING    pid 8329, uptime 0:16:35
    amqp2engines:engine-collectdgw-0 RUNNING    pid 8355, uptime 0:16:35
    amqp2engines:engine-context-0    RUNNING    pid 8287, uptime 0:16:36
    amqp2engines:engine-downtime-0   RUNNING    pid 8407, uptime 0:16:34
    amqp2engines:engine-event-filter-0 RUNNING    pid 8347, uptime 0:16:35
    amqp2engines:engine-eventstore-0 RUNNING    pid 8300, uptime 0:16:36
    amqp2engines:engine-linklist-0   RUNNING    pid 8392, uptime 0:16:34
    amqp2engines:engine-perfdata-0   RUNNING    pid 8338, uptime 0:16:35
    amqp2engines:engine-scheduler-0  RUNNING    pid 8436, uptime 0:16:34
    amqp2engines:engine-selector-0   RUNNING    pid 8445, uptime 0:16:34
    amqp2engines:engine-serie-0      RUNNING    pid 8363, uptime 0:16:35
    amqp2engines:engine-tag-0        RUNNING    pid 8416, uptime 0:16:34
    amqp2engines:engine-ticket-0     RUNNING    pid 8378, uptime 0:16:35
    amqp2engines:engine-topology-0   RUNNING    pid 8286, uptime 0:16:36
    amqp2engines:taskhandler-dataclean-0 RUNNING    pid 8418, uptime 0:16:34
    amqp2engines:taskhandler-linklist-0 RUNNING    pid 8495, uptime 0:16:33
    amqp2engines:taskhandler-mail-0  RUNNING    pid 8370, uptime 0:16:35

Hypcontrol est un wrapper au démarrage de tous ces services.
Par défaut on utilise supervisord avec Canopsis.


Afficher l'état de tous les services :

    hypcontrol status

Login AMQP:

    etc/amqp.conf

    cpsrabbit/canopsis

Privilégier les check sur un service (sur son socket)
On peut en plus y soutirer les performances de connexion.
(Pas possible pour un moteur)

Conf des moteurs dans etc/engines/*.ini

Avec numproc, le nombre de process que l'on peut lancer.
On peut y paramétrer, par exemple, le niveau de log (-l debug)

Gestion des moteurs :

1. Traitement
2. Redirection vers une autre fil
3. Traitement réalisé à un beat interval

Le beat interval est configurable dans (pour chaque moteur) :

    etc/amqp2engines.conf

Les moteurs ont accès à RabbitMQ et MongoDB
Voir :

    etc/amqp.conf [Connexion avec AMQP]
    etc/cstorage.conf ou  etc/storage/storage.conf [Connexion avec MONGODB]

Voir l'état des queues :

    rabbitmqctl list_queues -p canopsis name messages_ready messages consumers status

!!! note
    L'interface d'admin rabbitmq, peut être accesible par défaut via admin/admin

    (Si par ansible : cpsrabbit/canopsis, sinon admin/admin)

L'onglet queues indique l'état des queus rabbitMQ.

/!\ à a perte de connexioin entre connecteur et bus AMQP, il faut que le connecteur puisse stocker les évents et les timestamper de son côté.

Baseline :

    Un event toutes les X secondes.
    Si le connecteur n'envoi pas de données au bout de deux baseline, une alerte sera levée. (event envoyé).

    On peut aussi le faire à l'inverse, c'est à dire si le nombre d'event augmente fortement.
    
    Un connecteur est identifiable par son type et son nom (modifiable)

Un reverse proxy est vraiment conseillé (on peut gagner facilement 8 MB/s)

Pas de maintient de SE Linux avec Canopsis.

!!! note
    On est passé par supervisord pour pouvoir lancer les services dans un environnement utilisateur.

Debuguer l'input de AMQP :

    amqp2tty  #Affiché sur la sortie d'erreur, attention donc au grep et à la redirection de flux.

Mixin :

    Configuration des vues.

Chaque minute (beat par défaut), les engines publient leur stats.


Renderer : transformer l'affichage, le rendu.
On peut le désactiver via le mode édition d'un widget

!! note :
    collectd est installé par défaut pour monitorer le système canopsis par défaut.

J2
---------------

### AMQP

HA : possibilité de faire un cluster RabbitMQ (plusieurs machines pour un même bus AMQP).
+ ajouter du load balancing TCP (HA proxy par exemple) sur une VIP.
Dans ce cas, les connecteurs devront être configurés pour envoyer les infos sur le load balancer.

Il est aussi possible de faire un proxy AMQP dans le cas où l'ont doit passer par une machine intermédiaire.

### Structure commune d'événements

Identification unique d'un événement avec la rooting key :

Concaténation des infos : (connector, connector_name, source_type, event_type, source_type, component, resource).

Types d'events : (check, perfdata, log, eue, selector (résultat d'une agrégaio, trap)

### Cucumber 

On peut dropper le resultat de check au niveau de canopsis, et ajouter un Formatter au niveau de cucumber pour envoyer l'event directement à Canopsis.
L'ordonancement se fera toujours pas nagios mais le resultat sera bypassé par le connecteur.

### Attributs

Si on force l'ajout d'u attribut custom non existant dans le data model, il faudra l'ajouter et surtout l'indexer si l'on souhaite faire des recherches sur ce motif.

#### Envoyer un event

Il faut récupérer l'auth key via l'interface web (au niveau du profile utilisateur)
(Executer depuis l'hôte canopsis en user canopsis) :
  
    send_event -a f663430c-b0c2-11e6-be7c-00163eec6a65 -f event.json

Exemple de fichier json :

    {
      "connector" : "testformation",
      "connector_name" : "instanceprod",
      "event_type" : "check",
      "source_type" : "myself",
      "component" : "vim",
      "resource" : "sendevent",
      "state" : 3,
      "output" : "this is a custom test",
      "perf_data" : "foocpu=12%;80;90;0;200"
    }

Exemple d'export du send_event :

  virtualevn /.sendevent
  cd sendevent
  . bin/activate
  #copier le script send_event
  pip install kombu



Solution court terme de deprovisioning :

1. acquitter une alerte
2. supprimer l'alerte sur une event
3. jouer avec les filtres des vues

### Synchro

Dans la future version, en utilisant le mode graph de mongo3 (fonctionnement en mode graph au lieu de document).
Permettra d'interfacer plus facilement un référentiel et faire de la rootcause

### Mongo

    cat etc/mongo/storage.conf
    mongo canopsis -u leuser -p pwd
    show collections

Pour connaître l'encour de tous les events :

    db.events.find()
    db.events.find().pretty()
    db.events.find({'connector':'testformation'}).pretty()

!!! note
    Un event, même après modif de l'output reste unique, cela évite de faire grossir la collection mongo

    db.events.find({'connector':'testformation'},{'component':1}).pretty()

### Influx

Si on a inséré des données de perfdata, on les retrouvera au niveau d'influ :

    cat /opt/canopsis/etc/influx/storage.conf
    influx -database canopsis -username cpsinflux -password canopsis

    show measurements
    show series from foocpu

Afficher sur canopsis :

    brickmanager install brick-timechart
    brickmanager enable brick-timechart

### Etats

Attention les états gérés par Nagios ne sont pas les même que canopsis

N° Nagios Canopsis

0 Ok      info
1 Warn    min
2 Criti   maj
3 Unknows Critique

Créer une règle de mapping :

Dans la conf, Engines -> event filter.
On créer un nouveau filtre
Avec filter : les règle de selection (sur quel event on va appliquer notre action)
Action : quoi faire, par exemple pour modifier l'état 3 remonté par nagios à info dans canopsis on fera : 
    Filter: connector = nagios and state = 3
    Action: override state = 1

### Edition

Mode Edition : possibilité d'éditer le widget
Ajout d'une colonne sur le widget et le data model.

Ajouter une colonne pour un event :

    /opt/canopsis/etc/schema.d/crecord.event.json

    "status": {
      "type": "number",
      "role": "status"
    },
    "cancel": {
      "type": "object",
      "role": "object"
    },
    "author": {
      "type": "string"
    },
    "entity_id": {
      "type": "string"
    },
    "max_attempts": {
       "type": "number"
    }

   schema2db

### Note pour Livestatus

    bien mettre à jour kombu :
    pip install --upgrade kombu

### TRAP SNMP

OID : correspondance à faire, (traduction)
MIB : fournit par le "constructeur" pour stocker les infos sous un OID.

J'envoi le TRA, convertion des OID par rapport à la MIB, puis traduction en environement Canopsis.


TRAP SNMP -> |CONN SNMP| -> Exchange SNMP -> SNMP Engine -> Republication d'un event sur le Exchange event.

### Ecriture d'un connecteur

Via un script par exemple : Formatage d'un JSON et envoi sur le bus AMQP.

### Authentification

L'authent peut se faire via un LDAP, mais pas la gestion des droits
WebSSO CAS supporté.
(locale, LDAP, CAS).

### Widgets et Vues

Interface responsive

!!! note
    si on se deco alors qu'on est en authent websso, on cassera le token de la websso (deco de toutes les applications) mieux vaut fermer donc la page.

Organisation par Onglet.
Une Vu est compsé de conteneurs et widgets ...

Attention à bien configurer le gridlayout pour les conteneurs.

Pour ajouter un onglet, il faut éditer la vue "header"

!!! note
    Le framework utilisé est amber

!!! note
    Pour la conf du mixin gridlayout, privililégier un max de colonne pour les petites résolution

On peut insérer les classes de ADMIN LTE directement dans le widget de texte. (voir admin LTE)

https://almsaeedstudio.com/themes/AdminLTE/index2.html

Conteneur = Conteneur de widgets
Widget = type de visualisation (texte, meteo, bac à events ...)
mixin = propriété d'un widget.


Filtre = ensemble de règles sur un attribut.

Pour faire des méteos sur un aspect general :

1. créer un selecor
2. créer une méteo à partir de ce selector.

Idéalement le faire en fonction des hostsgroups.
Par défaut une meteo rapporte le pire état d'un groupe d'event.

Si jamais on voulait pondérer ce résultat, il faut utiliser les topologies.
La topologie permet de configurer un "poid" sur les arrêtes entre events. (Idéalement, ces informations doivent être tirées d'un rérentiel).

### Droits :

Permission + rôles + utilisateurs
On peut ajouter des permissions à un utilisateur de façon unitaire (pas besoin de réecrire un rôle à chaque fois).

Une permission : 

* Action : droit ou non
* modes : lectures/écritures ...

Rôles :
* Une liste de permissions

### Downtime

pbehavior

Transformer une info par exemple pendant un downtime.

Action : drop , faire un pbehavior sur une periode

### supprimer les bordures des widget

Appliquer un mixin lightlayout

### Conf manager et vue

Exporter une vue et la placer dans /opt/canopsis/opt/mongodb/load.d/json_object

    canopsis-filldb --update

/!\ en mode dev :

Ou pour remettre en état initial (/!\ casse tout ce qu'on a fait depuis le début (vues, selecteurs, filtres...).

    canopsis-filldb --init

### Notification

Utiliser Jinja pour écrire un message par exemple :

co : {{ component }}
re : {{ resourcce }}
message : {{ output }}

Un message peut être envoyé lorsqu'on déclare un incident.

### tests mail

apt-get install postfix

### timeline

    var/www/src/canopsis #check  de la présence de la brick
    brickmanager install brick-timeline
    brickmanger enable brick-timeline

    et recharger l'interface

Cliquer sur le "+" d'un event pour afficher la timeline (historique de l'event)

### Actions

Disponibles pour chaque event, surtout après acquittement.

1. j'acquite pour dire je travail sur l'event
2. J'effectue une action (déclaration de ticket ...)

### Timechart

    cd /opt/canopsis/var/www/
    bin/brickmanager install timechart
     
### Mixin

#### recordinfopopup

Ajouter du texte comme popup. 
(sur une colonne sans renderer)

Exemple sur component : {{output}}
La colonne component devient cliquable et un popup apparait

### LinkList

Donne la possibilité de créer une liste d'URL en fonction des attributs pour chaque events.

### Activation de l'édition de filtre

    bin/brickmanager install brick-querybuilder
    bin/brickmanager enable brick-querybuilder

Rajouter dans les paramètres de l'interface utilisateur, onglet editeur :

filter -> querybuilder
mfilter -> querybuilder
cfilter -> querybuilder

### Ajouter un nouvel attribut, par exemple pour les liens wiki :

1. Rajouter l'attribut au niveau du superviseur, exemple : action_url au niveau d'icinga2
2. dans le linklist ajouter un nouveau champ d'url , exemple : action_url
3. Un bouton d'action apparait sur l'interface 

### Interprétation du html

Il est possible de visionner l'output HTML avec les triples accolades '{{{'
balise {{{ output }}} => interprétation du code HTML.

!!! note
    Intégration d'un attribut d'event avec interprétation du code html : {{{ event.ccc.svg }}}
    autre exemple avec les metrics: {{ metric.moncomponent.maresource.nomResource }}, on pourrait utiliser le code d'une progressbar avec cette metric par exemple.
    (voir bootstrap progressbar)

### Topology

    ./var/www/bin/brickmanager install brick-topology
    bin/brickmanager enable brick-topology

### Handlebars

    Utilisé pour l'interprétation du code.

### Exemple de progressBar :

1. ajout d'une métrique via l'onglet métrique
2. récupération du code de la codebar et ajout du handlebar {{ }} pour l'interprétation de la métrique.

### Event Fiilter

L'event filter permet d'overrider des éléments, de définir aussi des attributs vides ...
Attention à bien utiliser les bons opérateurs comme 'in' pour les listes.
Exemple : hostgroups in linux-servers

### Notification job :

Une fois créee, on peut le chercher comme une action disponible dans le event filter.

Issues
-----------------------------

### Ajouter le connector_name sur les fitres des components pour le widget meteo notamment

Éditer le fichier suivant :

    ~/var/www/src/canopsis/monitoring/src/components/eventselector/template.hbs
    cd ~/var/www/src/canopsis/monitoring
    npm i
    npm run full-compile

### Problèmes d'installation

Dans tout les cas, voir le dossier log/

Si il y a une erreur avec les submodule, 
Checker, voir supprimer les dossiers concernant le submodule init, 
à savoir: 

* sources/externals
* sources/webcore

Si il y a une erreur avec mongoDB:
* Checker si une instance de mongodb n'existe pas déja
* Vérifier la taille du disque disponible (avoir 10Go de libre)

Une erreur avec l'install d'isit "Easy install Python Library: isit ... Error" :

C'est lié à l'hôte Ubuntu avec des conteneurs Debian.

Dans **log/python-libs.log**

    Running isit-0.2.6/setup.py -q bdist_egg --dist-dir /tmp/easy_install-ZwhP40/isit-0.2.6/egg-dist-tmp-22CrYj
    error: [Errno 2] No such file or directory: '/etc/lsb-release'

Résolution :

    lsb_release -a > /etc/lsb-release
    vim /etc/lsb-release

    DISTRIB_ID=Debian
    DISTRIB_DESCRIPTION="Debian GNU/Linux 7.11 (wheezy)"
    DISTRIB_RELEASE=7.11
    DISTRIB_CODENAME=wheezy

### Plus de données dans les graphes

Erreur de connexion avec influxdb :

1: vérifier que influx soit bien en mode running
2: vérifier les credentials (etc/influx/storage.conf)

Tester la connexion :

    influx --database canopsis --username cpsinflux --password canopsis
    show measurements
    select * from measurefoo

3: Il peut y a voir un problème avec le proxy (les requêtes se font via l'API http)
S'assurer que les variables http_proxy soient désactivées.
 
    env

Note : vérifier via l'outil de debug du navigateur les échanges réseaux (peffdata) et checker le traceback python.


### Provisioning

#### Export des vues :

    su - canopsis
    git clone <project_url> backend_toolbelt
    cd backend_toolbelt
    python setup.py install

    cano-toolbelt confexport -c cbt-confexport-example.json

#### Import des données :

    su - canopsis
    tar xf /tmp/canopsis-confexport.tgz -C opt/mongodb/load.d/
    canopsis-filldb --update

Il est possible d'éviter de surcharger des vues en plaçant le paramètre "loader_no_update" à true :

    "loader_no_update": true,
