==========================================================
                       A F P 
==========================================================

Apple Filing Protocol


~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Protocol :
        https://fr.wikipedia.org/wiki/Apple_Filing_Protocol
        https://en.wikipedia.org/wiki/Apple_Filing_Protocol

    Client :
        http://stackoverflow.org/wiki/Mount_an_AFP_share_from_Linux
        http://sourceforge.net/projects/afpfs-ng/files/afpfs-ng/
        http://sourceforge.net/projects/afpfs-ng/

    Server :
        http://straightedgelinux.com/blog/howto/afp.html
        https://www.outcoldman.com/en/archive/2014/11/09/ubuntu-as-home-server-part-3-afp-server/

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Un protocole de partage de fichier utilisé notament par Apple.
    La version libre d'AFP s'appele sous linux: netatalk

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Ce protocole utilise par défaut le port 548
    et s'occupe de gérer le service afpd

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Côté serveur
        --------------------------

            > apt-get install netatalk

        --------------------------
        Côté client
        --------------------------

            voir : http://sourceforge.net/projects/afpfs-ng/files/latest/download

            ou :

                > git clone https://github.com/simonvetter/afpfs-ng
                > ./configure
                > make
                > sudo make install
                > sudo ldconfig

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Côté serveur
        --------------------------

            #conf basic :
                > vim /etc/netatalk/afpd.conf

                    - -tcp -noddp -uamlist uams_dhx.so,uams_dhx2.so -nosavepassword

            #Ajouter un partage :
                > useradd -m macshare

            #configuration du partage :
                > vim /etc/netatalk/AppleVolumes.default

                :DEFAULT: options:upriv,usedots /home/macshare macshare 
                allow:instructor,student,admin,staff,klaatu,bob,carol,alice
                options:upriv,usedots dperm:0777 fperm:0220

                voir aussi :

                    /usr/local/etc/afp.conf

            #Appliquer les droits :
                
                > chmod/chown ...

            #Configuration du daemon : 

                > vim /etc/default/netatalk

                    ATALKD_RUN=no
                    PAPD_RUN=no TIMELORD_RUN=no
                    A2BOOT_RUN=no
                    CNID_METAD_RUN=yes
                    AFPD_RUN=yes

            #Redémarrage du daemon

                > /etc/init.d/netatalk restart
                > ps faux |grep afpd

        --------------------------
        Côté client
        --------------------------

            #Monter le partage :

                > mount_afp 'afp://user:password@servername/sharename' /mnt/test

            #Démonter le partage :

                > afp_client unmount /mnt/test
           

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

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
