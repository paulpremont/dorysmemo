==========================================================
                       C O R O S Y N C
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Projet:

        http://corosync.github.io/corosync/

    Tuto:

        http://blogduyax.madyanne.fr/haute-disponibilite-avec-corosync-et-pacemaker.html
        http://doc.ubuntu-fr.org/pacemaker

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Corosync est orienté HA.
    C'est un moteur de cluster. 
    Il permet d'implémenter de la HA au sein des applications.

    Il s'utilise notament avec pacemaker et peuvent être une alternative à heartbeat.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Il fonctionne sur un principe d'anneaux de connexion.
    Un réseau est dédié pour le check de l'état des hôtes.
    Il dispose d'un gestionnaire redémarrant les process plantés.

    On va utiliser pacemaker pour gérer les ressources du cluster.
    Comme par exemple le basculement sur un autre noeud en cas de défaillance d'un process.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install corosync

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Voir /etc/corosync

    #Générer les clés d'authentification pour le ring 
    
        > cd /tmp
        > corosync-keygen
        > mv authkey /etc/corosync/authkey
        > chown root:root /etc/corosync/authkey
        > chmod 400 /etc/corosync/authkey

    #On exporte la clé sur les autres noeuds concernés:

        > scp /etc/corosync/authkey root@noeudX:/etc/corosync/authkey

    #Config des anneaux:

        > vim /etc/corosync.conf

            totem {
                version: 2

                # How long before declaring a token lost (ms)
                token: 3000

                # How many token retransmits before forming a new configuration
                token_retransmits_before_loss_const: 10

                # How long to wait for join messages in the membership protocol (ms)
                join: 60

                # How long to wait for consensus to be achieved before starting 
                #a new round of membership configuration (ms)
                consensus: 3600

                # Turn off the virtual synchrony filter
                vsftype: none

                # Number of messages that may be sent by one processor on receipt of the token
                max_messages: 20

                # Limit generated nodeids to 31-bits (positive signed integers)
                clear_node_high_bit: yes

                # Disable encryption
                secauth: off

                # How many threads to use for encryption/decryption
                threads: 0

                # Optionally assign a fixed node id (integer)
                # nodeid: 1234

                # This specifies the mode of redundant ring, which may be none, active, or passive.
                rrp_mode: passive

                interface {
                    ringnumber: 0
                    bindnetaddr: 10.20.13.0
                    mcastaddr: 226.94.1.1
                    mcastport: 5405
                }
                interface {
                    ringnumber: 1
                    bindnetaddr: 192.168.1.0
                    mcastaddr: 226.94.1.1
                    mcastport: 5407
                }
            }

            amf {
                mode: disabled
            }

            service {
                # Load the Pacemaker Cluster Resource Manager
                ver:       0
                name:      pacemaker
            }

            aisexec {
                user:   root
                group:  root
            }

            logging {
                fileline: off
                to_stderr: yes
                to_logfile: no
                to_syslog: yes
                syslog_facility: daemon
                debug: off
                timestamp: on
                logger_subsys {
                    subsys: AMF
                    debug: off
                    tags: enter|leave|trace1|trace2|trace3|trace4|trace6
                }
            }

    #Activation de corosync::

        > vim /etc/default/corosync

            START=yes

    #Démarrer le démon sur les noeuds du cluster:

        > service corosync start

        --------------------------
        Plusieurs interfaces
        --------------------------

            TODO

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

    #Voir l'état du cluster:

        > crm_mon --one-shot

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
