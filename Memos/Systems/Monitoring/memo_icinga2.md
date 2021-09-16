Icinga2
==============================

What is it ?
-----------------------------

Icinga est un outil de monitoring système permetant de contrôler la disponibilité des services/hôtes mais aussi de relever des métrics.
Il dispose d'un système de notification et graphes.
Orienté grosse infra et architecture distribuée.
C'est un fork de Nagios à la base, il est donc compatible avec les checks nagios.

Links
-----------------------------

### Official

* [Site Web](https://www.icinga.com/)
* [Documentation Icinga2](https://docs.icinga.com/icinga2/latest/doc/module/icinga2/toc)
* [Sources](https://github.com/Icinga/icinga2)
* [Nagios Documentation](https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/toc.html)
* [IcingaWeb2 Director module](https://www.icinga.com/2017/01/19/exceptions-prove-the-rule-director-to-the-rescue/)

### Tutos

* [Trap SNMP](http://grantcurell.com/2015/10/27/receive-snmp-traps-with-icinga-2-on-ubuntudebian/)
* [Topic avancés](https://github.com/Icinga/icinga2/blob/master/doc/8-advanced-topics.md)


How it works ?
-----------------------------

### Composants/Features Icinga2

Icinga2 dispose d'un coeur écrit en C++ sur lequel on vient greffer des features.
Ces features sont des composants d'Icinga2 :

* checker : Permet d'ordonancer et exécuter les checks
* api : Interface de pilotage d'Icinga2
* ido : Permet d'interfacer Icinga2 à une base de données.
* perfdata : Permet de stocker les métriques
* livestatus : Protocole permettant d'intérroger le status des événements d'icinga2 (ne pas s'en servir comme backend)
* compatlog : Permet d'écrire des logs compatible avec Icinga1


### Arborescence type :

PATH  | DESCRIPTION
----- | ---------
/etc/icinga2 | Fichiers de conf icinga2
/etc/init.d/icinga2 | Script de manipulation du service
/usr/sbin/icinga2 | Les libs Icinga2
/usr/share/doc/icinga2  | La Documentation
/usr/share/icinga2/include  | Les modèles de lib et les configurations des commandes des plugins (ITL, Icinga Template Library)
/var/run/icinga2  | PID
/var/run/icinga2/cmd  | le pipe de commandes et le socket Livestatus.
/var/cache/icinga2  | Fichiers status.dat/objects.cache, icinga2.debug
/var/spool/icinga2  | Utilisé pour les fichiers de spool de données de performance.
/var/lib/icinga2  | Fichier d'état d'icinga2, les logs de cluster, la CA et des fichiers de conf.
/var/log/icinga2  | Fichiers de logs comprenant le dossier compat pour la fonctionnalitée de "CompatLogger"

### Plugins et Checks

#### Plugins

Les plugins permettent de contrôlers l'état des services externes ou d'un hôte.
Ils s'occupent donc de founir les moyens d'intérroger un service et d'obtenir un résultat.
C'est l'intermédiaire entre le serveur Icinga et le Client à superviser pour obtenir des informations de supervision.

Exemples de plugins :

* check_http
* check_ping
* check_snmp
* check_nrpe
...

#### Commandes de contrôles (check_command)

Les checks sont les commandes finales utilisées pour effectuer un contrôle sur un hôte.
Ils peuvent être directement un plugin executé avec des arguments.

L'execution d'un check et son résultat sont opérés par l'intermédiaire du plugin.

Exemple de check_command avec des variables associée :

     check_command = "nrpe"
     vars.nrpe_command = "check_load"


### Supervision des hôtes et services

On distingue 2 types d'objets à superviser :

* Un hôte
* Un service

dont l'état dépend du dernier check effectué.

#### Un hôte :

    object Host "my-server1" {
      address = "10.0.0.1"
      check_command = "hostalive"
    }

Un contrôle par défaut peut lui être attribué.
Un hôte peut avoir un de ces états :

* UP
* DOWN

#### Un service associé à un hôte :

    object Service "mon_service_http" {
      host_name = "my-server1"
      check_command = "http"
    }

Un service peut être dans un de ces états :

* OK
* WARNING (Toujours en fonctionnement mais rencontre un problème)
* CRITICAL
* UNKNOWN

#### Types d'états

Les objets peuvent être dans deux types d'états :

* SOFT : En cours de re-check après détection d'un problème (basé sur max_check_attempts et retry_interval)
* HARD : Pas de changement d'état récent détecté.

### Templates

Les modèles permettent de configurer des attributs/paramètres qui seront hérités par d'autres objets lors de l'appel à ces templates.

Exemple de définition d'un service :

    template Service "generic-service" {
      max_check_attempts = 3
      check_interval = 5m
      retry_interval = 1m
      enable_perfdata = true
    }

Exemple d'assignation de ce template à un type d'hôte particulier :

    apply Service "ping4" {
      import "generic-service"
      check_command = "ping4"
      assign where host.address
    }

!!! note
    On herite via la clause "import", la clause "apply" permet d'appliquer un comportement à un type d'objet.

#### ITL (Icinga Template Library)

Icinga2 embarque bon nombre de modèle préconfigurés.  
Ils sont disponible dans le path par défaut :  

**/usr/share/icinga2/include**

Le fichier itl est chargé par icinga2 (voir /etc/icinga2/icinga2.conf:include <itl>)

En plus d'ITL, on a les commandes de plugins chargée là aussi grâce au fichier icinga2.conf.
On y trouve par exemple la commande hostalive.

### Variables custom

On peut définir ses propres variables grâce à la constante "Vars".

Ces variables peuvent être des chaînes, des nombres des booléens, des dictionnaires, des tableaux ou encore des fonctions.

Exemple :

    vars.ssh_port = 2222
    vars.text = {{ Math.random() * 100 }}

#### Fonctions

Elles permettent de renvoyer un résultat spécifique après traitement au sein d'une variable.

Les fonctions ont accès, par défaut à plusieurs variables :

* user      : de l'objet user pour les notifications
* service   : de l'objet service pours les checks, notifs et le event handler
* host      : de l'objet host
* command   : de l'objet command

Exemple :

    vars.text = {{ host.check_interval }}

Exemple de définition d'une fonction avec l'utilisation d'une macro :

    vars.text = {{
      if (macro("$address$") == "127.0.0.1") {
        log("Running a check for localhost!")
      }

      return "Some text"
    }}

### Macros

Les macros permettent d'accéder aux attributs des autres objets.  
Elles sont définient entre '$' 

Exemple :

    vars.ping_address = "$address$"

Plusieurs macros prédéfinies existent déja.
On y accède via le pattern suivant : **object_type.attribut**

Exemples :

    $host.state$
    $host.state_type$

Où, on peut aussi faire référence à une variable directement par son nom (dans se cas, il faudra se fier à l'ordre d'évaluation).

Exemple :

    $state$
    $address$

#### Règles

* [Runtimes Macro](https://docs.icinga.com/icinga2/latest/doc/module/icinga2/toc#!/icinga2/latest/doc/module/icinga2/chapter/monitoring-basics#host-runtime-macros)

Les macros sont utilisées pour accéder aux attributs des différents objets lors de leur exécution.  
Il faut donc les voir comme des variables globales.

Syntax d'une macro :

    $ma_macro$

Pour définir une macro, on utlise la variable "vars" locale à l'objet ou une macro prédéfinie.

Exemple de macro prédéfinie :

    object Host "router" {
      check_command = "my-ping"
      address = "10.0.0.1"
    }

On pourra accéder à la variable address depuis un autre objet grâce à la syntaxe suivante :

    $address$

Exemple :

    object CheckCommand "my-ping" {

      command = [ PluginDir + "/check_ping", "-H", "$ping_address$" ]
      ...

      vars.ping_address = "$address$"
      ...
    }


Ici le $ping_address$ fait référence à une variable custom locale "vars.ping_address", faisant elle même référence à une macro prédéfinie.

Ce mécanisme d'attribution d'une valeur à une macro est définie par l'ordre d'évaluation (voir la section ci-dessous).  
Si on ne spécifie pas où Icinga2 doit trouver la valeur de cette macro, c'est à dire dans quel objet, il essaye de trouver cette valeur dans un ordre précis.

Sinon on aurait pu écrire :

    $host.address$

#### Ordre d'évaluation et overrider une valeur.

La recherche de la valeur d'une macro se fait dans cet ordre :

1. User object (only for notifications)
2. Service object
3. Host object
4. Command object
5. Global custom attributes in the Vars constant

La première évaluation l'emporte. (Service l'emporte sur Host qui l'emporte sur Command ...)  


Grâce à cette méthode d'évaluation, on peut donc écrire des valeurs par défaut au niveau de l'objet grâce à la variable 'vars'.
Et les overrider dans un objet de plus haut niveau :

    object CheckCommand "my-ping" {
      ...
      arguments = {
        "-p" = "$ping_packets$"
      }
      ...
      vars.ping_packets = 5 // valeur par défaut reprise directement par défaut dans la variable arguments.
    }

    object Service "ping" {
      host_name = "localhost"
      check_command = "my-ping"

      vars.ping_packets = 10 // Override la valeur par défaut définie au niveau de l'objet CheckCommand au niveau du dicitonnaire "arguments".
    }

### Apply

Au lieu de spécifier pour chaque objet (Hôtes et Services), un service, un groupe, une notification, etc, à associer,
il est possible d'utiliser une syntaxe particulière d'assignement.

    assign where ...

Chaque expression renvoyant un résultat de type booléen (True ou False).

#### Expressions

Exemple d'assignement en fonction d'un attribut :

    assign where host.vars.attribute_does_not_exist

Exemple d'assignement avec des conditions multiples (OU) :

    assign where match("*mysql*", host.name) && match("db-*", host.vars.prod_mysql_db)
    ignore where host.vars.test_server == true
    ignore where match("*internal", host.name)

#### Exemples d'assignement

##### Un service à plusieurs hôtes

    apply Service "ssh" {
      import "generic-service"

      check_command = "ssh"

      assign where host.address && host.vars.os == "Linux"
    }

##### Une notification à des hôtes ou des services

Créer une notification "mail-noc" pour tous les services ayant notification.mail comme attribut.
La commande de notification sera "mail-service-notification" et tous les membres du groupe noc seront notifiés.

  apply Notification "mail-noc" to Service {
    import "mail-service-notification"

    user_groups = [ "noc" ]

    assign where host.vars.notification.mail
  } 

##### Avec le mot clé "For"

Attention cela est rendu possible uniquement avec les variables de type tableau ou Dictionnaire.

    object Host "router-v6" {
      check_command = "hostalive"
      address6 = "::1"

      vars.oids["if01"] = "1.1.1.1.1"
      vars.oids["temp"] = "1.1.1.1.2"
      vars.oids["bgp"] = "1.1.1.1.5"
    }

    apply Service for (identifier => oid in host.vars.oids) {
      check_command = "snmp"
      display_name = identifier
      vars.snmp_oid = oid

      ignore where identifier == "bgp" //don't generate service for bgp checks
    }


### Groupes

Un groupe est un ensemble d'objets de même type.
Peut s'avérer très utile, notamment au niveau de la visualisation de l'application web.

#### Exemple d'utilisation "simple" :

**1- Création :**

    object HostGroup "linux" {
      display_name = "Linux Servers"
    }

!!! note
    Cela peut être utilisé aussi pour les ServiceGroup et UserGroup

**2- Attribution à un template :**

    template Host "linux-server" {
      groups += [ "linux" ]
    }

**2- Utilisation au niveau d'un hôte :**

    object Host "mssql-srv1" {
      import "windows-server"
      ...
    }

#### Assignement

Pour faciliter l'assignement des groupes, on peut utiliser la syntaxe avec 'assign' :

    object HostGroup "prod-mssql" {
      display_name = "Production MSSQL Servers"

      assign where host.vars.mssql_port && host.vars.prod_mysql_db
      ignore where host.vars.test_server == true
      ignore where match("*internal", host.name)
    }


### Notifications

Plusieurs outils externes peuvent être utilisés pour notifier les problèmes à des utilisateurs (ou un groupe d'utilisateurs).
Les notifications se font par l'intérmédiaire de plugins/addons.


Il faut d'abord définir à qui les notifications seront envoyées :

    object User "icingaadmin" {
      display_name = "Icinga 2 Admin"
      enable_notifications = true
      states = [ OK, Warning, Critical ]
      types = [ Problem, Recovery ]
      email = "icinga@localhost"
    }

Puis appliquer les notifications sur un service :

    apply Notification "mail" to Service {
      import "generic-notification"

      command = "mail-notification"
      users = [ "icingaadmin" ]

      assign where service.name == "ping4"
    }

!!! note
    Aucune notification n'est envoyée durant un "downtime", un acquittement ou une dépendance logique.

#### États et Types 

    template Notification "generic-notification" {
      states = [ Warning, Critical, Unknown ]
      types = [ Problem, Acknowledgement, Recovery, Custom, FlappingStart,
                FlappingEnd, DowntimeStart, DowntimeEnd, DowntimeRemoved ]
    }

#### Escalader une notification

On peut escalader une notification en fonction d'un temps donné.

Exemple, après une heure de non résolution et uniquement pendant une heure :

    apply Notification "escalation-sms-1st-level" to Service {
      import "generic-notification"

      command = "sms-notification"
      users = [ "icinga-oncall-1st-level" ]

      times = {
        begin = 1h
        end = 2h
      }

      assign where service.name == "ping4"
    }

#### Délai (Delay)

Pour temporiser les notifications, on utilise times.begin.
S'utilise avec un interval de réémission assez court.

Exemple :

  times.begin = 15m
  interval = 5m

Pour désactiver les réémission de notification, on met l'interval à 0 :

  interval = 0

### Commandes

Elles peuvent être de trois types :

* Commandes de contrôle (checks)
* Commandes de notification
* Commandes d'évenements

#### Commandes de checks

* [Liste des checks et leurs attributs](https://docs.icinga.com/icinga2/latest/doc/module/icinga2/toc#!/icinga2/latest/doc/module/icinga2/chapter/plugin-check-commands)

Les checks peuvent être executés directement depuis la ligne de commande :

    /usr/lib/nagios/plugins/check_disk --help

Il s'agit ensuite des les utiliser au sein d'un objet (host ou service) avec les bon arguments.

On peut ajouter ses propres checks et leurs arguments par défaut dans le fichier **/etc/icinga2/conf.d/commands.conf**.
Où chaque macros définies dans le bloc de commande sont accessibles comme variables au niveau de l'objet.

Exemple de commande dans **/etc/icinga2/conf.d/commands.conf** :

    object CheckCommand "my-mysql" {
      command = [ PluginDir + "/check_mysql" ] //constants.conf -> const PluginDir

      arguments = {
        "-H" = "$mysql_host$"
        "-u" = {
          required = true
          value = "$mysql_user$"
        }
        "-p" = "$mysql_password$"
        "-P" = "$mysql_port$"
        ...
        "-S" = {
          set_if = "$mysql_check_slave$"
          description = "Check if the slave thread is running properly."
        }
        "-l" = {
          set_if = "$mysql_ssl$"
          description = "Use ssl encryption"
        }
      }

      vars.mysql_check_slave = false
      vars.mysql_ssl = false
      vars.mysql_host = "$address$"
    }

Exemple d'utilisation dans un service **/etc/icinga2/conf.d/services.conf** :

    apply Service "mysql-icinga-db-health" {
      import "generic-service"

      check_command = "my-mysql"

      vars.mysql_user = MysqlUsername
      vars.mysql_password = MysqlPassword

      vars.mysql_database = "icinga"
      vars.mysql_host = "192.168.33.11"

      assign where match("icinga2*", host.name)
      ignore where host.vars.no_health_check == true
    }

#### Commande de type notification

Voir la partie notifications

#### Commande de type événement

Les événements sont appelés à chaque exécution de check si l'une de ces conditions est remplie :

* L'hôte ou le service est dans un état "soft"
* L'hôte ou le service change d'état vers "hard"
* L'hôte ou le service revient vers un état UP/DOWN


1. On définit une EventCommand
2. On rajoute cette commande à un service

##### Exemple, redémarrer un service si un check failed

**commands.conf**

    //Définition d'une commande capable de redémarrer un service via ssh en fonction de l'état du check.
    object EventCommand "restart_service" {
      import "check_ssh"

      //only restart the daemon if state > 0 (not-ok)
      //requires sudo permissions for the icinga user
      vars.ssh_command = "test $service.state_id$ -gt 0 && sudo /etc/init.d/$ssh_service$ restart"
    }

**services.conf**

    //Application de la EventCommand (event_command)
    object Service "http" {
      import "generic-service"
      host_name = "remote-http-host"
      check_command = "http"

      event_command = "restart_service"
      vars.ssh_service = "apache2"
    }

### Dépendances

Les dépendances entre services et hôtes sont utilisés pour déterminer leur disponibilité.
Cela permet de désactiver les notifications en cas de changement d'état des enfants.

Pour spécifier une dépendance, on utilise les mots clés "parent_host_name" et "parent_service_name"

Exemple :

    parent_host_name = "core-router"
    parent_service_name = "uplink-port"

#### Assigner une dépendance

On peut facilement appliquer une dépendance avec le bloc "apply".

Exemple :

    apply Dependency "internet" to Host {
      parent_host_name = "dsl-router"
      disable_checks = true
      disable_notifications = true

      assign where host.name != "dsl-router"
    }

### IcingaWeb2 Director

* [How it works](https://github.com/Icinga/icingaweb2-module-director/blob/master/doc/10-How-it-works.md)

Ce module permet de configurer icinga2 via l'interface web.
Il utilise l'API icinga2 pour ce faire.

Schméa type :

    +------------+     +--------------+    +------------+
    | Sat 1 / EU |     | Sat 2 / Asia |    | Sat 3 / US |
    +------------+     +--------------+    +------------+
            \           /                    /
             \         /                    /
           +-------------+       +-------------+
           |  Master 1   | <===> |  Master 2   |  (Master-Zone)
           +-------------+       +-------------+
                 ^                       ^
                 |   Icinga 2 REST API   :
                 |                       :
               +----------------------------+
               |       Icinga Director      |
               +----------------------------+

!!! note
    Il n'utilise pas /etc/icinga2 mais passe par la base de données pour stocker sa configuration.


### Langage et Syntaxe Icinga2

* [Language reference](https://docs.icinga.com/icinga2/latest/doc/module/icinga2/toc#!/icinga2/latest/doc/module/icinga2/chapter/language-reference)

Icinga2 met à disposition un manuel de référence de sa syntaxe au niveau des objets.


#### Conditions

Ces blocs peuvent êtres insérés au niveau des objets (hosts,services,commandes...) et dans des fonctions.

Tester si une variable existe :

    if (!vars.warn) { vars.warn = "15%" }
    if (!vars.crit) { vars.crit = "5%" }

Autres exemples :

    vars.hostname = "$host.name$"
    if ( vars.hostname == "bidul" ) {
      vars.fifoo = "yop"
    }

    ...

    if ( host.vars.os == "Linux" && vars.area == "foo" ) {
      vars.yo = "foo"
    } else {
      vars.yo = "oof"
    }

Via une fonction :

    vars.foo = {{
      if ( macro("$host.vars.os$") == "Linux" ) {
        return "linux4ever"
      }
    }}


#### Boucles

    

Installation
-----------------------------

### Ajout du repo

#### Debian

    wget -O - https://debmon.org/debmon/repo.key 2>/dev/null | apt-key add -
    echo 'deb http://debmon.org/debmon debmon-jessie main' >/etc/apt/sources.list.d/debmon.list
    apt-get update

#### Ubuntu

    add-apt-repository ppa:formorer/icinga
    apt-get update

!!! note
    La commande add-apt-repository est inclut dans le package software-properties-common

### Icinga2

    apt-get install icinga2
    icinga2 feature list

Par défaut 3 features sont activées :

* checker : pour exécuter les checks
* notification : pour envoyer les notifications
* mainlog : pour écrire le log icinga2.log

    Disabled features: api command compatlog debuglog gelf graphite influxdb livestatus opentsdb perfdata statusdata syslog
    Enabled features: checker mainlog notification

### Plugins

    apt-get install nagios-plugins

### Icinga Web 2 (optionnel)

[Doc install icinga web 2](https://github.com/Icinga/icingaweb2/blob/master/doc/02-Installation.md)

    apt-get install mysql-server mysql-client
    apt-get install icinga2-ido-mysql

!!! note
    Il est possible de bypasser l'assistant d'installation, la suite couvre la configuration de la base de façon manuelle.

Le module IDO (Database Icinga Data Output) sert à exporter toutes la configuration et les informations en base.

A vérifier :

    Création de la base de données :

        mysql -u root -p

        CREATE DATABASE icinga;
        GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga.* TO 'icinga'@'localhost' IDENTIFIED BY 'icinga';
        quit;

    Importation du schéma :

        mysql -u root -p icinga < /usr/share/icinga2-ido-mysql/schema/mysql.sql

Voir la configuration IDO dans **/etc/icinga2/features-available/ido-mysql.conf**

Activation des modules :

    icinga2 feature enable ido-mysql
    icinga2 feature enable command
    service icinga2 restart

Install du serveur web :

    apt-get install nginx php7.0-fpm
    apt-get install icingaweb2

Création de la base icingaweb2 :

    mysql -u root -p

    CREATE DATABASE icingaweb2;
    GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icingaweb2.* TO 'icingaweb2'@'localhost' IDENTIFIED BY 'icingaweb2';
    quit

    mysql -p icingaweb2 < /usr/share/icingaweb2/etc/schema/mysql.schema.sql

Génération d'un compte admin :

    openssl passwd -1 mypassword  #Récupération du hash

    mysql -p icingaweb2
    INSERT INTO icingaweb_user (name, active, password_hash) VALUES ('icingaadmin', 1, 'MON_HASH');


Création du VHOST :

    #Dumper le contenu du vhost :
    icingacli setup config webserver nginx --document-root /usr/share/icingaweb2/public

    #A copier sur son vhost default par exemple
    location ~ ^/icingaweb2/index\.php(.*)$ {
      # fastcgi_pass 127.0.0.1:9000;
      fastcgi_pass unix:/run/php/php7.0-fpm.sock;
      fastcgi_index index.php;
      include fastcgi_params;
      fastcgi_param SCRIPT_FILENAME /usr/share/icingaweb2/public/index.php;
      fastcgi_param ICINGAWEB_CONFIGDIR /etc/icingaweb2;
      fastcgi_param REMOTE_USER $remote_user;
    }

    location ~ ^/icingaweb2(.+)? {
      alias /usr/share/icingaweb2/public;
      index index.php;
      try_files $1 $uri $uri/ /icingaweb2/index.php$is_args$args;
    }

!!! warning 
    le fastcgi_pass n'est peut être pas à jour, il faudra le remplacer par unix:/run/php/php7.0-fpm.sock, si on a installer fpm.

Ajuster les droits :

    usermod -a -G icingaweb2 www-data

Configurer le timezone **/etc/php/7.0/fpm/php.ini**

    date.timezone = UTC

Redémarrer les services web :

    service php7.0-fpm start
    service nginx restart

Création du Token pour configurer l'interface :

    icingacli setup token create
    icingacli setup token show

Rendez vous sur votre interface : **http://my_ip/icingaweb2**

Et suivre les instructions de configuration.

!!! note
    Lors de la conf, utilisez l'utilisateur admin précédemment créé : "icingaadmin"

Certains Addons comme l'interface web ont besoin d'envoyer des commandes via le pipe de commandes externes :

    icinga2 feature enable command
    service icinga2 restart

#### Icinga Web2 module director

* [IcingaWeb2 Director github](https://github.com/Icinga/icingaweb2-module-director)



Configuration
-----------------------------




Manipulations
-----------------------------

### systemd Service

    service icinga2 restart       #stop + start
    service icinga2 reload        #n'attend pas que Icinga2 redémarre complètement
    service icinga2 checkconfig   #check des erreurs dans /etc/icinga2/icinga2.conf 

### Checks

#### Lancer un check manuellement

Il suffit d'exécuter le check directement en console : 

Exemple :

    /usr/lib/nagios/plugins/check_http -H google.com -u http://google.com


#### NRPE (Nagios Remote Plugin Executor)

* [Wiki NRPE monitoring-fr](https://wiki.monitoring-fr.org/nagios/addons/nrpe)

NRPE est un protocol permetant d'exécuter des plugins côté agent.
Il permet simplement de requêter et transporter le résultat d'un check depuis un hôte distant.

Port d'écoute côté agent par défaut : 5666

!!! note
    Préferez le mode "client" de icinga2.
    
##### Côté agent

###### Installation :

    apt-get install nagios-nrpe-server nagios-plugins libssl-dev
    service nagios-nrpe-server status

###### Configuration :

**/etc/nagios/nrpe.cfg**

    #Autoriser le serveur à requêter le plugin
    allowed_hosts=127.0.0.1,icinga2-server

    #Autoriser le passage d'arguments (si le serveur l'autorise)
    dont_blame_nrpe=1

    #Définition des alias de commandes
    command[check_root]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /

    #Avec des arguments (nécessite d'installer le nrpe via les sources avec l'option --enable-command-args)
    command[check_disk]=/usr/lib/nagios/plugins/check_disk -w $ARG1$ -c $ARG2$ -p $ARG3$
    ...

!!! warning
    Le check avec argument ne passera que si le serveur nrpe a été installé depuis les sources avec l'option "--enable-command-args"

###### Redémarrer le deamon :

    service nagios-nrpe-server restart

##### Côté serveur Icinga

###### Installation :

    apt-get install nagios-nrpe-plugin libssl-dev

###### Configuration

**services.conf** Exemple avec arguments :

    apply Service "nrpe_disk_root" {
      import "generic-service"
      check_command = "nrpe"

      vars.nrpe_command = "check_disk"
      vars.nrpe_arguments = [ "20%", "10%", "/" ]

      assign where "nrpe_disk_root" in host.vars.checks
    }

**services.conf** Exemple sans arguments :

    apply Service "nrpe_disk_root" {
      import "generic-service"
      check_command = "nrpe"

      vars.nrpe_command = "check_root"

      assign where "nrpe_disk_root" in host.vars.checks
    }

!!! note
    Icinga2 embarque déja une commande NRPE (/usr/share/icinga2/include/command-plugins.conf), rien n'a faire de ce côté donc.

#### SSH

Icinga2 intègre un template "by_ssh" nativement.

##### Côté Agent

Installer le service ssh (normalement installé par défaut).  
Définissez un compte utilisateur ayant droit de se connecter et exécuter les checks.  
(si on passe par root, ne pas oublier d'ajouter "PermitRootLogin yes" au  niveau de /etc/ssh/sshd_config.)

##### Côté serveur Icinga

Génération d'une paire de clé (exemple depuis l'utilisateur root) :

    ssh-keygen -t rsa
    ssh-copy-id -i /root/.ssh/id_rsa.pub icinga@my_remote_host
    ssh my_remote_host

    cp -R /root/.ssh /var/lib/nagios
    chown -R nagios: /var/lib/nagios/.ssh

Création d'une commande over_ssh **commands.conf** :

    object CheckCommand "by_ssh_apt" {
      import "by_ssh"

      vars.by_ssh_command = "/usr/lib/nagios/plugins/check_apt"
    }

Création d'un service **services.conf** :

    apply Service "by_ssh_apt" {
      import "generic-service"

      check_command = "by_ssh_apt"

      vars.by_ssh_logname = "icinga"

      assign where "by_ssh_apt" in host.vars.checks
    }

#### SNMP

##### Côté Agent

Installation :

    apt-get install snmpd
    service snmpd status
    export MIBDIRS=/usr/share/snmp/mibs/

Ports par défaut : UDP 161 (Agent) et 162 (Trap).

Configuration **/etc/snmp/snmpd.conf** (exemple) :

    agentAddress udp:161,udp6:[::1]:161
    view   all         included   .1
    rocommunity private  default    -V all

Vérifier la présence des MIB dans **/usr/share/snmp/mibs**.

Editer les variables dans **/etc/default/snmpd**

    #export MIBS=
    export MIBDIRS=/usr/local/share/snmp/mibs

Redémarrer le service

    service snmpd restart

Tests :

    #Obtenir des informations globales
    snmpwalk -v1 -c public 127.0.0.1 [OID_prefix]

    #Obtenir une information sur un OID en particulier
    snmpget -v1 -c public 127.0.0.1 OID

##### Côté serveur Icinga

Installation :

    apt-get install snmp snmpsnmp-mibs-downloader libsnmp-dev

Test :

    /usr/lib/nagios/plugins/check_snmp -H 192.168.0.24 -o .1.3.6.1.4.1.2021.9.1.9.1 -w 80 -c 90 -P 1 -C private

**services.conf**

    apply Service "snmp_root_disk" {
      import "generic-service"

      check_command = "snmp"

      vars.snmp_oid = ".1.3.6.1.4.1.2021.9.1.9.1"
      vars.warn = 80
      vars.crit = 90

      assign where host.vars.snmp_community != ""
    }

#### SNMP TRAP

Icinga2 utilise SNMPTT pour filtrer les traps et récupérer le résultat.

##### Côté serveur Icinga

Installation :

    apt-get install snmptrapd snmptt
