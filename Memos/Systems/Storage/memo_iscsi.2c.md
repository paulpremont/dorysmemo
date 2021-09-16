==========================================================
                       i S C S I
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Du SCSI over TCP/IP

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Coté serveur (target)

        > apt-get install iscsitarget iscsitarget-dkms

    Coté client (initiator)

        > apt-get install open-iscsi

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Les disques
        --------------------------

            On peut soit utiliser un disque physique directe, 
            soit utiliser une surcouche drbd ou encore utiliser un disque virtuel:

            exemple pour un disque de 50G:

                > dd if=/dev/zero of=fs.isccsi.disk bs=1M count=50000
            
        --------------------------
        Le LUN
        --------------------------

            > vim /etc/iet/ietd.conf

                ex:
                    Target SAN:drbd0
                    Lun 0 Path=/dev/drbd0,Type=fileio

            Activation:

            > vim /etc/default/iscsitarget

                ISCSITARGET_ENABLE : true

            > service iscsitarget restart

            Note: port par défaut: 3260

        --------------------------
        Vérification
        --------------------------

            > cat /proc/net/iet/volume

        --------------------------
        Coté client
        --------------------------

            Lister les partages:

            > iscsiadm --mode discovery --type sendtargets --portal @IP_server

            Créer la liaison:

            > scsiadm --mode node --targetname SAN:drbd0 \ --portal @IP_server --login

            Pour l'avoir au démmarage:

            > vim /etc/iscsi/iscsid.conf

                node.startup = automatic

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
