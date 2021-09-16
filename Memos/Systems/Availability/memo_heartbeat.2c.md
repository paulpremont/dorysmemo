==========================================================
                       H E A R T B E A T
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Officiel:
        http://linux-ha.org/wiki/Heartbeat
        http://www.linux-ha.org/doc/users-guide/users-guide.html

    Tuto:
        http://doc.ubuntu-fr.org/heartbeat

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    C'est un système de gestion de service en HA au sein d'un cluster.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    C'est un daemon fournissant une infra de service en cluster.
    Il est combiné avec un CRM (Cluster Ressource Manager) qui a pour but de lancer et arrêter les processus.
    Ce CRM est souvent Pacemaker ou encore Corosync.

    Hearbeat peut détecter les défaillance d'un noeud en moins d'une demi-seconde. Il s'enregistrera avec le process te temps watchdog si il a été configuré pour.

    Note:
        Watchdog est un process permetant de fournir l'état du system au kernel pour l'empecher notament de réinitialiser.

    TODO

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install heartbeat

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
