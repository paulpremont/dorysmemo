E L K
==============================

What is it ?
-----------------------------

ELK est une suite de produit permettant la centralisation, l'analyse et le stockage de log grâce à ces outils :

* Logstash : Analyse et filtre de logs
* Elasticsearch : Stock et recherche d'événements après analyse
* Kibana : Interface de visualisation
* Beats : pour la récupération d'événements.

Links
-----------------------------

### Official

* [Site de la suite ELK](https://www.elastic.co/)

### Description des produits

* [Logstash](https://www.elastic.co/products/logstash)
* [ElasticSearch](https://www.elastic.co/products/elasticsearch)
* [Kibana](https://www.elastic.co/products/kibana)
* [Beats](https://www.elastic.co/products/beats)

### Docs

* [Documentation](https://www.elastic.co/guide/index.html)
* [Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
* [Logstash](https://www.elastic.co/guide/en/logstash/current/index.html)
* [Kibana](https://www.elastic.co/guide/en/kibana/current/index.html)
* [Beats](https://www.elastic.co/guide/en/beats/libbeat/current/index.html)

### Tutos

* [Blog sur les stratégies de déploiement](http://blog.jetoile.fr/2014/04/logstash-petit-tour-dhorizon.html)
* [Installation d'ELK sous debian](https://www.atlantic.net/community/howto/install-elk-stack-on-debian-8/)


How it works ?
-----------------------------

### Logstash

Logstash est écrit principalement en java et permet de traiter un peu n'importe quel type de données en input pour la filtrer, la formatter et l'envoyer vers une destination.  
Le tout écrit sous la forme d'un pipeline.

![Logstash](Pictures/logstash.png)

#### Pipeline

![Logstash](Pictures/basic_logstash_pipeline.png)

Un pipeline est le format de configuration des traitements appliqués par Logstash.  
On active la lecture (input) de logs via un plugin (syslog, beats, apache, ...), on écrit un filtre pour ne garder qu'une partie des logs et rajouter des informations (grok, ...),  
enfin on active un output pour stocker les données formattées par logstash (elasticsearch, nagios, canopsis, ...)

Exemple de pipeline :

    input {
        beats {
            port => "5044"
        }
    }
    filter {
        grok {
            match => { "message" => "%{COMBINEDAPACHELOG}"}
        }
    }
    output {
        stdout { codec => rubydebug }
    }

#### Inputs

* [Input-plugins](https://www.elastic.co/guide/en/logstash/current/input-plugins.html)

Logstash gère bon nombre d'input pré-formatté pour simplifier l'extraction d'information.

Elastic propose beats comme nouvel agent de collecte de données.

Exemple, accepter les logs venant de l'agent beats :

    input {
        beats {
            port => "5044"
        }
    }

!!!note
    Il est possible de mettre plusieurs input de différentes sources.

#### Filters

* [Filter-plugins](https://www.elastic.co/guide/en/logstash/5.4/filter-plugins.html)

C'est ici le coeur de Logstash.  
Les filtres permettent de définir les opération effectuées sur les logs, comme manipuler les données, les sélectionner, les modifier, les enrichirs...  
Le filtre le plus répendu est "grok" qui permet de filtrer n'importe quel type de fichier texte.

!!! note
    On peut chaîner les filtres.

Sans filtre, toute la ligne de log sera envoyée sous la forme :

    {
        "@timestamp" => 2017-05-12T08:53:03.868Z,
            "offset" => 6,
          "@version" => "1",
        "input_type" => "log",
              "beat" => {
            "hostname" => "elk",
                "name" => "elk",
             "version" => "5.4.0"
        },
              "host" => "elk",
            "source" => "/var/log/foolog",
           "message" => "hello",
              "type" => "log",
              "tags" => [
            [0] "beats_input_codec_plain_applied"
        ]
    }


##### Grok

* [grok](https://www.elastic.co/guide/en/logstash/5.4/plugins-filters-grok.html)

Grok embarque plus de 120 patterns pré-faits.  
Il est toutefois possible de créer ses propres pattern.

Syntax utilisé :

    %{SYNTAX:SEMANTIC}

Avec :

* SYNTAX : Indique le pattern utilisé pour selectionner une partie de la ligne du log.
* SEMANTIC : L'identifiant utilisé pour stocker cette partie du log.

Exemple :

    filter {
      grok {
        match => { "message" => "%{IP:client} %{WORD:method} %{URIPATHPARAM:request} %{NUMBER:bytes} %{NUMBER:duration}" }
      }
    }

Ce qui a pour effet de stocker les logs dans les champs suivants (pour un log type web)

* client: X.X.X.X
* method: GET
* request: /index.html
* bytes: XXXX
* duration: X.XXX

**Définir ses propres pattern**

TODO


#### Output

* [output plugins](https://www.elastic.co/guide/en/logstash/current/output-plugins.html)

C'est dans ce bloc qu'on définit sur quelle destination on envoie les données.
Par défaut ELK fonctionne avec Elasticsearch :

    output {
      elasticsearch {
        hosts => ["localhost:9200"]
      }
    }

Pour debug, en executant logstash en foreground, et visualiser l'output en live :

    output {
      stdout { 
        codec => rubydebug 
      }
    }

Écrire vers un fichier :

    output {
      file { 
        path => "path/to/target/file" 
      }
    }

!!!note
    Il est possible de mettre plusieurs output, et même plusieurs IP Elasticsearch par exemple.


### Elastisearch

Elasticsearch est un moteur de d'analyse et de recherche texte orienté Big Data.  
Il est très performant sur le plan de la lecture.  
Il est utilisé (par défaut) comme backend entre Kibana et Logstash.

[Les concepts](https://www.elastic.co/guide/en/elasticsearch/reference/current/_basic_concepts.html)

Vocabulaire :

* Near Real Time (NRT) : Normalement une seconde s'écoule entre l'indexation d'un document et son accès dans le moteur de recherche.
* Cluster : Une collection de noeud
* Node : Un serveur faisant partie d'un cluster permettant de stocker les données et les rendre accessibles. Identifiable par un UUID.
* Index : C'est une collection de document ayant les mêmes caractéristiques.
* Type : C'est une catégorisation logique de données dans un index (des données ayant en commun plusieurs colonnes).
* Document : Une unité d'inforlation qui peut être indéxé. Il est exprimé en JSON.
* Shards/Sharding : Un morceau d'index. Il est possible de divisé un index en plusieur morceau sur différente machines lorsque ce dernier devient conséquent.
* Replica shards : Méthode de réplication des données pour le failover.

#### REST API

Elasticsearch est livré avec une API permettant de :

* Check l'état des clusters, nodes ... et récupérer des stats.
* Administrer le cluster.
* Faire du CRUD (Create, Read, Update and Delete).
* Faire des recherches plus ou moins avancées.

l'API écoute sur le port 9200 par défaut.

* [cat API](https://www.elastic.co/guide/en/elasticsearch/reference/current/cat.html)

### Kibana

### Beats

Beats est le nouvel agent léger de collecte de logs.  
Il est décliné en plusieurs produits :

* Filebeat : pour la collecte de logs
* Metricbeat : pour la collecte de métriques (données de mesures)
* Packetbeat : pour la collecte de données réseau
* Winlogbeat : pour la collecte de logs windows
* Heatbeat : pour la collecte d'information de supervision

#### Filebeat

* [How filebeat works](https://www.elastic.co/guide/en/beats/filebeat/current/how-filebeat-works.html)

Filebeat remplace maintenant le Logstash Forwarder qui utilisait le protocol Lumberjack pour l'envoi de logs.  
Il semblerait que le protocol beats soit une amélioration de Lumberjack.

Filebeat tient à jour un registre local **/var/lib/filebeat/registry** pour ne pas transmettre tout le log en entier à chaque fois.  
Si l'on souhaite tout renvoyer from scratch (dans le cas ou on a fait un nouveau filtre par exemple), il faudra supprimer ce fichier.


Installation
-----------------------------

### Java

    sudo apt-get install openjdk-8-jdk openjdk-8-jre
    java -version

Exemple de l'output :

    openjdk version "1.8.0_121"
    OpenJDK Runtime Environment (build 1.8.0_121-8u121-b13-0ubuntu1.16.04.2-b13)
    OpenJDK 64-Bit Server VM (build 25.121-b13, mixed mode)


### Dêpot des paquets officiels

    apt-get install wget
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add
    sudo apt-get install apt-transport-https
    echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
    sudo apt-get update

### Elastic Search

    sudo apt-get install elasticsearch

Note, pour une installation LXC ou Docker, on rajoutera l'option suivante pour éviter d'écrire des variables sur des fichiers en read-only.

    export ES_SKIP_SET_KERNEL_PARAMETERS="true"
    sudo apt-get install elasticsearch

On démarre le service:

    sudo systemctl daemon-reload
    sudo systemctl enable elasticsearch.service
    sudo systemctl start elasticsearch.service
    sudo systemctl status elasticsearch.service

### Logstash

    sudo apt-get install logstash
    sudo systemctl daemon-reload
    sudo systemctl enable logstash.service
    sudo systemctl start logstash.service
    sudo systemctl status logstash.service

### Kibana

    sudo apt-get install kibana
    sudo systemctl daemon-reload
    sudo systemctl enable kibana.service
    sudo systemctl start kibana.service
    sudo systemctl status kibana.service

### File beat

File beat permet d'envoyer des logs à Logstash.

    sudo apt-get install filebeat
    sudo systemctl daemon-reload
    sudo systemctl enable filebeat.service
    sudo systemctl start filebeat.service
    sudo systemctl status filebeat.service


Configuration
-----------------------------

### Filebeat

#### Envoyer les logs à logstash

**/etc/filebeat/filebeat.yml**

    filebeat.prospectors:
    - input_type: log
      paths:
        - /var/log/*.log

    output.logstash:
      hosts: ["localhost:5044"]

Redémarrer le service :

    service filebeat restart
    #=> /usr/share/filebeat/bin/filebeat -c /etc/filebeat/filebeat.yml -path.home /usr/share/filebeat -path.config /etc/filebeat -path.data /var/lib/filebeat -path.logs /var/log/filebeat

**Notes :**

Le path peut cibler un fichier en particulier ou utiliser le wildcard '*'.
Il n'est pas encore possible de cibler de façon récursive tous les logs, mais on peut faire '/var/log/*/*'

Il ne reste plus qu'à configurer logstash avec le plugin beats pour accepter les logs.

### Logstash

#### Configuration de base Exemple

Par défaut logstash ne livre pas de configuration dans **/etc/logstash/conf.d**.

Exemple de pipeline avec en input du beats.
On attend ici des logs de type syslog qui seront filtrés et enrichis (ajout d'un timestamp et du hostname)  
puis envoyés sur elasticsearch.

**my-first-pipeline.conf**

    input {
      beats {
        port => 5044
      }
    }

    filter {
      if [type] == "syslog" {
        grok {
          match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }
          add_field => [ "received_at", "%{@timestamp}" ]
          add_field => [ "received_from", "%{host}" ]
        }
        syslog_pri { }
        date {
          match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
        }
      }
    }

    output {
      elasticsearch {
        hosts => ["localhost:9200"]
      }
    }

#### Tester sa configuration

    /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/first-pipeline.conf --config.test_and_exit
    ...
    07:55:51.510 [LogStash::Runner] INFO  logstash.runner - Using config.test_and_exit mode. Config Validation Result: OK. Exiting Logstash

#### Activer le rechargement automatique de la configuration

**/etc/logstash/logstash.yml**

    config.reload.automatic: true
    config.reload.interval: 3

    

### Kibana

Par défaut Kibana écoute sur la loopback,  
pour accéder à l'interface, il faut d'abord configurer l'interface d'écoute dans **/etc/kibana/kibana.yml**.

    server.host: "X.X.X.X"

Puis redémarrer le service

    service kibana restart

Manipulations
-----------------------------

### Elasticsearch

La manipulation d'elasticsearch se fait via son API.
On peut utiliser pour cela curl ou le faire directement depuis la console kibana.

#### Lire les données (_cat)

* [cat API](https://www.elastic.co/guide/en/elasticsearch/reference/current/cat.html)

Les requêtes de lecture se font via l'API _cat.

Exemple de requête :

Avec curl

    curl -XGET 'localhost:9200/_cat/health?v&pretty'

Via kibana

    GET /_cat/health?v

##### Les paramètres communs :

**mode verbose**

    ?v

**obtenir de l'aide**
    ?help

Exemple :

    GET /_cat/master?help

ou

    curl -XGET 'localhost:9200/_cat/master?help'

**Chaîner les paramètre**

On peut le faire via le caractère "&"

    ?v&pretty

**N'afficher que certain élément avec via l'option du header**

    ?h=ip,port,heapPercent,name

Exemple :

    GET /_cat/nodes?h=ip,port,heapPercent,name

**Formatter l'output**

    ?format=json&pretty'

**Trier l'output**

    s=order:desc,my_column


##### Lister les indices/index

Kibana :

    GET /_cat/indices?v

Curl :

    curl 'localhost:9200/_cat/indices?v'
    curl 'localhost:9200/_cat/indices?format=json&pretty'

#### Écrire des données

##### Créer un index

    curl -XPUT 'localhost:9200/customer?pretty&pretty'
    curl -XGET 'localhost:9200/_cat/indices?v&pretty'

##### Écrire des informations dans un index

    curl -XPUT 'localhost:9200/customer/external/1?pretty&pretty' -H 'Content-Type: application/json' -d'
    {
      "name": "John Doe"
    }
    '

    curl -XGET 'localhost:9200/customer/external/1?pretty&pretty'



### Logstash

#### Service

    service logstash start
    service logstash status
    ...

#### Logstash Pipelines

Tester simplement le système de pipe sans fichier :

    cd /usr/share/logstash
    bin/logstash --path.settings /etc/logstash -e 'input { stdin { } } output { stdout {} }'
    hello world
    CTRL + D

### Filebeat

#### Supprimer le registre

Pour renvoyer tout le log :

    rm /var/lib/filebeat/registry


Troubleshooting
-----------------------------

### Problème de fs en Read-only file system

Exemple d'output:

    Couldn't write '1' to 'kernel/yama/ptrace_scope', ignoring: Read-only file system
    Couldn't write '1' to 'fs/protected_symlinks', ignoring: Read-only file system
    Couldn't write '4 4 1 7' to 'kernel/printk', ignoring: Read-only file system
    Couldn't write '1' to 'kernel/kptr_restrict', ignoring: Read-only file system
    Couldn't write '1' to 'fs/protected_hardlinks', ignoring: Read-only file system
    Couldn't write '65536' to 'vm/mmap_min_addr', ignoring: Read-only file system
    Couldn't write '176' to 'kernel/sysrq', ignoring: Read-only file system
    Couldn't write '1' to 'net/ipv4/tcp_syncookies', ignoring: No such file or directory
    Couldn't write '262144' to 'vm/max_map_count', ignoring: Read-only file system
    dpkg: error processing package elasticsearch (--configure):
     subprocess installed post-installation script returned error exit status 1
    Errors were encountered while processing:
     elasticsearch
    E: Sub-process /usr/bin/dpkg returned an error code (1)

[Résolution](https://github.com/elastic/elasticsearch/issues/21877)

Voir partie installation elasticsearch sur LXC.
