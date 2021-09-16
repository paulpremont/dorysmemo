==========================================================
                       Linux Virtual Server
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Official:

        http://www.linuxvirtualserver.org/index.html
        http://www.linuxvirtualserver.org/HighAvailability.html

    Tutos:

        http://doc.fedora-fr.org/wiki/Cluster_LVS_ou_Linux_Virtual_Server
        https://www.guillaume-leduc.fr/lequilibrage-de-charge-sous-linux-avec-lvs-theorie.html
        https://www.guillaume-leduc.fr/lvs-et-haute-disponibilite-sous-linux-avec-keepalived.html


~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    LVS est un système de répartition de charge fonctionnant au niveau de la couche 4 du modèle OSI.
    (HA proxy, fonctionne au niveau de la couche 7).
    Attention à ne pas confondre avec un système de clustering où les hôtes ont conscience de l'état du voisin.


~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    LVS est basé sur un système de "director" ou encore maître s'occupant d'envoyer le flux sur plusieurs hôtes réels en fonction du mode de répartition de charge choisi (Round Robin, Least connection ...). Le tout representant un hôte virtuel.

    Schéma: 

        https://www.guillaume-leduc.fr/wp-content/uploads/2014/02/Sch%C3%A9ma-global-LVS.png

        - On aura une VIP (Virtual IP) sur le director pour l'accès aux clients.
        - Une DIP (Director IP) pour la connexion vers les serveurs réels.
        - Des RIP (Real IP) au niveau des serveurs réels.
        - Il vaut mieux utiliser deux sous réseaux différents entre l'accès externe et l'accès aux serveurs réels.

        --------------------------
        Modes de fonctionnement:
        --------------------------
                __________________________
                LVS-NAT:

                    En mode NAT, le director fait office de routeur et NAT les adresses vers les serveurs réels.
                    Ce mode implique d'avoir un director bien dimensionné et/ou d'avoir plusieurs director en cluster, toutes les connexions passant par lui.

                __________________________
                LVS-DR:

                    En mode Direct Routing, les serveurs réels répondent directement aux clients.
                    Ce qui donne un gain en terme de performance par rapport au NAT mais un peu plus de sécurité à entreprendre.

                __________________________
                LVS-TUN:

                    Fonctionnement en mode tunnel lorsque un serveur virtuel se trouvent très éloigné de notre réseau.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Vérifications:
        --------------------------

            Support du multicast:

                > ipconfig eth0 |grep MULTICAST

            Support ipvs:

                > modprobe ip_vs && lsmod |grep ip_vs

        --------------------------
        Packages
        --------------------------

            > apt-get install ipvsadm
            > yum install ipvsadm

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Director
        --------------------------
                __________________________
                Activation du routage:

                    > echo "1" >/proc/sys/net/ipv4/ip_forward
                __________________________
                Création d'une IP virtuelle:

                    > ifconfig eth0:virt 192.168.0.100 netmask 255.255.255.0 broadcast 192.168.0.255 up
                __________________________
                Configuration de la répartition:

                    Clean de la table ipvsadm:

                        > ipvsadm -C

                    Chargement des modules noyau, exemple avec round robin:

                        > modeprobe ip_vs
                        > modeprobe ip_vs_rr

                    Activation du socket de répartition de charge (exemple sur le port 10123)

                        > ipvsadm -A -t 192.168.0.100:10123 -s rr

                            -s rr : méthode round robin
                            -t : Type TCP
                            -A : Ajouter un service

                    Ajout des serveurs réels:

                        > ipvsadm -a -t 192.168.0.100:10123 -r 192.168.1.10:10123 -m -w 1
                        > ipvsadm -a -t 192.168.0.100:10123 -r 192.168.1.20:10123 -m -w 1

                            -a -t : ajouter un socket pour les serveurs réel de type TCP
                            -r : socket du serveur réel
                            -m : mode NAT
                            -g : mode gateway, (Direct Routing)
                            -w : poid du serveur réel

                    Lister ses connexions:

                        > ipvsadm
                        > ipvsadm -Ln

                    Sauver ses paramètres:

                        > ipvsadm -Sn > /etc/ipvsadm_rules

        --------------------------
        Serveur réels:
        --------------------------
                __________________________
                Activation du routage:

                    > echo "1" >/proc/sys/net/ipv4/ip_forward
                    > route add default gw 192.168.0.100
                __________________________
                Locker les réponses ARP:

                    Pour éviter de répondre aux requêtes autres que celle du directeur:

                    > vim /etc/sysctl.conf

                        net.ipv4.conf.all.arp_ignore=1
                        net.ipv4.conf.all.arp_announce=2
                        net.ipv4.conf.lo.arp_ignore=1
                        net.ipv4.conf.lo.arp_announce=2

                    > sysctl -p


~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Toubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Erreur
        --------------------------
                __________________________
                Logs:

                __________________________
                Description:

                __________________________
                Résolution:

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
