==========================================================
                       M O L O C H
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://github.com/aol/moloch/wiki/FAQ
    http://blog.alejandronolla.com/2013/04/06/moloch-capturing-and-indexing-network-traffic-in-realtime/
    http://www.ntop.org/products/pf_ring/
    http://www.ntop.org/pf_ring/installation-guide-for-pf_ring/

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Moloch est un outil d'indexation de flux réseaux.
    Il s'utilise conjointement avec une base type ElasticSearch
    /!\ Moloch ne remplace pas un IDS il sert surtout à sauver du flux et à le parcourir.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Moloch s'appui sur 3 composants:

        Capture: Ecrit en C,il permet d'écouter et de capturer le flux sur chaque interface.
        Viewer : Ecrit en node.js, il gère l'interface web et le transfert de fichier pcap.
        elasticsearch : La base de données.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Prérequis moloch:
        > apt-get update && apt-get upgrade -y && apt-get install git openjdk-7-jdk openjdk-7-jre -y

    Moloch:
        > git clone https://github.com/aol/moloch.git

        Pour une démo:
            > cd moloch
            > ./easybutton-singlehost.sh

        Moins sallement:

            

    Pfring:
        Pour pfring (Outils de capture haute vitesse avec filtre et analyse)
        TODO
        >

    Note: moloch install lui même elasticsearch apache & co avec le script easybutton

    toutefois voici la procédure d'install d'elasticsearch:
        
        elasticsearch:
            voir http://www.elasticsearch.org/download/ pour connâitre la dernière version:

            > wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.0.tar.gz
            > tar -xvf elasticsearch-1.4.0.tar.gz

            désactiver la gestion du cluster:

                > echo 'marvel.agent.enabled: false' >> ./config/elasticsearch.yml

            Finaliser l'install
            > ./bin/plugin -i elasticsearch/marvel/latest
            > ./bin/elasticsearch

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Fichier de conf: /data/moloch/etc/config.ini

        --------------------------
        Filtre
        --------------------------

            Par défaut moloch écoute sur eth0

            Il est possible d'appliquer un filtre sur IP pour notament supprimer les flux entre l'hôte et l'interface web de moloch:

            > vim /data/moloch/etc/config.ini

                #Berkeley Packet Filter (bpf)
                bpf=not host 19.16.5.5

        --------------------------
        Elasticsearch
        --------------------------

            Pour accéder à l'interface Elasticsearch autrement que via la loopback de moloch, il faut configurer l'ip d'écoute:

            > vim /data/moloch/etc/elasticsearch.yml

                network.bind_host: 0.0.0.0
                network.publish_host: 0.0.0.0
                network.host: 0.0.0.0

            On redémarre elasticsearch:

                > curl -XPOST 'http://localhost:9200/_shutdown'
                > nohup /data/moloch/bin/run_es.sh &

            Accès à elasticsearch

                http://MOLOCH_IP_ADDRESS:9200/_plugin/head/

                

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Accéder à l'interface web de moloch
        --------------------------

            https://moloch:8005

            login:
                admin:admin

            changement de mot de passe:
                node addUser -c <configfilepath> <user id> <user friendly name> <password> [--admin]

~~~~~~~~~~~~~~~~~~~~~~~~~~
subtitle 1
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        subtitle 2
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
