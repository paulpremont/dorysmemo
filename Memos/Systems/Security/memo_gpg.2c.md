==========================================================
                       G P G
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    tutos :

        http://www.bauer-power.net/2010/05/how-to-setup-free-pgp-key-server-in.html#.VqnKQ9-6znE
        http://www.rainydayz.org/content/installing-opensks-keyserver

    official :

        https://www.gnupg.org/

    wiki :

        https://help.ubuntu.com/community/GnuPrivacyGuardHowto

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    GPG est un système de chiffrement basé sur l'échange de clé asymétrique public et privée.
    Les clés publiques peuvent être distribuées individuellement ou stockées sur un serveur partagé.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Server side
        --------------------------

                __________________________
                SKS :

                    > apt-get install sks
            
        --------------------------
        Client side
        --------------------------

            > apt-get install gpg

                __________________________
                Plugins :

                        Thunderbird / Enigmail 
                        ``````````````````````````
                            Enigmail est un plugin supporté par thunderbird utilisant le système GPG pour chiffrer/déchiffrer les emails

                            > apt-get install enigmail

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Server side
        --------------------------

                __________________________
                SKS :

                    #Port d'écoute par défaut : 11371/11370

                    #Build database :

                        > sks build

                    #Set db and log permissions :

                        > chown -Rc debian-sks:debian-sks /var/lib/sks/DB /var/log/sks/db.log

                    #Auto start :

                        > vim /etc/default/sks
                            initstart=yes

                        > service sks start
                        > service sks status

                    #Web access :

                        #Récupérer l'index :

                            > wget http://ftp.bauer-power.net/misc/gpg/sks/sks.zip
                            > unzip sks.zip
                            > cp index.html keys.jpg /var/lib/sks/www

                        #Modifier l'index (changer le nom de domaine)

                            > vim /var/lib/sks/www/index.html

                        #Changer les droits :

                            > chown -R debian-sks:debian-sks /var/lib/sks/www

                        #Acces :

                            http://your.server.name:11371

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Server
        --------------------------

        --------------------------
        Client
        --------------------------
                __________________________
                Générer une paire de clé :

                    > gpg --gen-key
                __________________________
                Importer une clé localement :

                    > gpg --import mykey

                __________________________
                Télécharger une clé depuis un serveur :

                    > gpg --keyserver myserver --recv-key 0xABC...

                __________________________
                Exporter une clé sur un serveur :

                    > gpg --keyserver myserver --send-key mykey.pub
            

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
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
