==========================================================
                       M E S O S
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    officiels:

        http://mesos.apache.org/
        http://mesos.apache.org/gettingstarted/
        http://mesos.apache.org/documentation/latest/

        https://mesosphere.com/learn/
        http://mesosphere.com/docs/getting-started/

    Tutos:
        http://typesafe.com/blog/play-framework-grid-deployment-with-mesos

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Mesos est une techno de clustering open source.
    IL s'appuie notament sur Hadoop qui est un framework java libre orienté applications distribuées scalables.
    On parle ici d'organisation de partage de ressources.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~
    http://mesos.apache.org/documentation/latest/mesos-architecture/

    Mesos s'appuie sur une architecture de type maitre gérant tout les noeuds esclave du cluster ainsi que les applications mesos appelées aussi Framework éxécutant alors leurs tâches sur les esclaves.

    Les esclaves offrent leurs ressources au master.
    Ce dernier va ensuite proposer cette offre à un Framework 
    Le framework va envoyer les tâche à effectuer avec leur besoins en terme de ressources. 
    Le master fait donc exécuter ces applications sur le noeud esclave.

        --------------------------
        Hadoop
        --------------------------
        --------------------------
        Master
        --------------------------
        --------------------------
        Slaves
        --------------------------
        --------------------------
        Frameworks
        --------------------------

            Ce sont les applications mesos.
            On y trouve par exemple Hadoop, MPI, Chronos, Marathon, Spark.

            - Marathon permet notament de distribuer un système d'initialisation 'init' ou 'upstart'.
            - Chronos est à l'image d'une "cron" distribuée executant les tâche sur le cluster mesos.

            Ces deux briques fournissent les éléments nécessaire à la création d'application distribuées.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

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
