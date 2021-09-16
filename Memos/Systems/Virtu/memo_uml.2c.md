==========================================================
                       U M L
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Pratique pour tester les noyau à moindre risque
    Pas d'exploit SMP
    Paratge de root fs en utilisant des fichiers Copy on Write

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Réseau:
        Interface TAP : niveau 2 (bridge)

        Interface TUN : niveau 3 (routage)

            On route ensuite avec iptables

        tunctl -t tap0
        ip tunel/tap (pour arch)

            eth0=tuntap,tap1,fe:XXX;IP

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

    /kernel* ubda=./root_fs mem=256m
    ...

    FS: todo

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
