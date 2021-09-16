==========================================================
                O P E N S T A C K
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Officiel:
        http://www.openstack.org/

        Docs:
            http://docs.openstack.org/
            http://docs.openstack.org/juno/install-guide/install/apt-debian/content/


    Tuto:
        doc.ubuntu-fr.org/openstack

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Openstack est un système de cloud qui permet de gérer des pools de stockage, réseaux et de calcul importants.
    Il peut remplacer un système de virtu type proxmox mais n'est pas orienté HA.
    Openstack est donc idéal dans une situation de IaaS (Infrastructure As A Service).
    En découle le PaaS et le SaaS.

    http://lists.openstack.org/pipermail/openstack/2014-May/007146.html

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://docs.openstack.org/juno/install-guide/install/apt-debian/content/ch_overview.html

    Openstack inclu plusieurs services liés entre eux dans le but de fournir un environnement cohérent pour nos futures VM.

        -Horizon: (Dashboard) C'est l'interface web d'openstack.
        -Nova: (compute) Gère le cycle de vie des instances de calcul telles que la création de vm... 
        -Neutron: (Networking) Fourni une API permettant de se rattacher au réseaux.

        -Swift: (Object storage): Sauvegarde toutes les données non structurées.
        -Cinder: (Block storage): Permet de fournir des bloc de données.

        -Keystone: (Identity) : Fourni la couche d'authentification aux services openstack.
        -Glance: (Image) : Gère les images disk des différentes vm.
        -Ceilometer: (Telemetry): gère toute la partie stats du cloud.

        -Heat: (Orchestration) : Coordonne au plus haut niveau le cloud.
        -Trove: (Database) : Fourni la base de données en tant que service pour les moteur relationels ou non.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Prérequis
        --------------------------

            -Support de la virtu.
            -Une partition LVM disponible.
            -Avoir une IP fixe.
            -Voir les prérequis en terme de ressource (pour optimiser)
                http://docs.openstack.org/juno/install-guide/install/apt-debian/content/ch_basic_environment.html

        --------------------------
        Test du support de la virtu:
        --------------------------

            > egrep '^flags.*(vmx|svm)' /proc/cpuinfo

        --------------------------
        Packages:
        --------------------------

            > apt-get install kvm libvirt-bin virtinst
            > apt-get install mysql-server python-mysqldb
            > apt-get install bridge-utils

            Suppression de certains packages:

                > apt-get remove network-manager


~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Le réseau
        --------------------------

            Dans la suite nous admetrons qu'il y a deux interfaces dédiés pour openstack:

                __________________________
                Configuration des bridges:

                    > vim /etc/network/interfaces

                        auto lo
                        iface lo inet loopback

                        auto eth0
                        iface eth0 inet dhcp

                        auto eth0:1
                        iface eth0:1 inet manual

                        auto eth0:2
                        iface eth0:2 inet manual

                        auto br0
                        iface br0 inet static
                            bridge_ports eth0:1
                            address 192.168.0.250
                            netmask 255.255.255.0
                            gateway 192.168.0.1
                            broadcast 192.168.0.255

                        auto br1
                        iface br1 inet manual
                            bridge_ports eth0:2

                    > service networking restart
                __________________________
                Config de son dns:

                    > vim /etc/resolv.conf

                        nameserver 8.8.8.8
                        nameserver 8.8.4.4
                __________________________
                Activation du forwarding:

                    > net.ipv4.ip_forward=1
                    > sysctl -p

                __________________________
                Install du ntp

                    Pour la synchro du cloud:

                    > apt-get install ntp

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
