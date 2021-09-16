==========================================================
                    P A C E M A K E R 
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Tuto:
        http://doc.ubuntu-fr.org/pacemaker
        http://www.sebastien-han.fr/blog/2011/07/04/introduction-au-cluster-sous-linux/

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Pacemaker est un gestionnaire de cluster haute disponibilité.
    Il supervise les ressources du cluster et est chargé de démarrer et arrêter les différents processus.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Il s'appuie sur des soft tels que heartbeat et corosync (par défaut sous ubuntu) pour contrôler les différents noeuds.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install pacemaker

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Voir memo sur corosync pour l'installation du cluster.

    > crm configure

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Pacemaker ce pilote avec crm (Cluster Resource Manager)

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
