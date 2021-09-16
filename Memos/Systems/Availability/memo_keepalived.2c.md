==========================================================
                       K E E P A L I V E D
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Un outil utilisé pour la HA.
    Il permet de vérifier qu'un hôte est toujours joignable.
    Sinon l'hôte qui n'arrive plus à contacter son voisin prendra son @IP.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Protocoles utilisés:

        VRRP : pour le failover
        IPVS : loadbalancing (l4)

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install keepalived

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Master:
        --------------------------

            > vim /etc/keepalived/keepalived.conf

            # Configuration File for Keepalived
            # Global configuration
             
                global_defs {
                        notification_email {
                                admin@example.net
                        }
                        notification_email_from noreply@example.net
                        smtp_server smtp.example.net
                        smtp_connect_timeout 30
                        router_id HOSTNAME_SERVER
                }
                 
                vrrp_instance VI_1 {
                        state MASTER
                        interface eth0
                        virtual_router_id 51
                        priority 100
                        advert_int 1
                        authentication {
                                auth_type PASS
                                auth_pass xxx
                        }
                        virtual_ipaddress {
                                192.168.100.100/24
                        }
                        notify_master "service iscsitarget restart"
                        notify_backup "service iscsitarget restart"
                }

            Note: activer le routage:
                vim /etc/sysctl.conf
                    net.ipv4.ip_forward=1

            > service keepalived restart
            > service shutdown -r now

            Vérifications:

                > ip addr sh eth0

        --------------------------
        Esclave/Backup
        --------------------------

            Sur le noeud esclave:
                
                Remplacer 'state MASTER' par 'state BACKUP'


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
