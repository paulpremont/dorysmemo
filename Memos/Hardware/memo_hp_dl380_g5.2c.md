==========================================================
                       HP DL 380 G5
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://h20566.www2.hp.com/portal/site/hpsc/template.PAGE/public/kb/docDisplay?javax.portlet.begCacheTok=com.vignette.cachetoken&javax.portlet.endCacheTok=com.vignette.cachetoken&javax.portlet.prp_ba847bafb2a2d782fcbb0710b053ce01=wsrp-navigationalState%3DdocId%253Demr_na-c00712808-51%257CdocLocale%253D%257CcalledBy%253D&javax.portlet.tpst=ba847bafb2a2d782fcbb0710b053ce01&ac.admitted=1406112576169.876444892.199480143
    https://wiki.debian.org/HP/ProLiant#HP_ProLiant_Servers
    http://www.cmbc.be/blog/proxmox-and-hp-proliant-dl380-g5-raid-monitoring/
    http://www.datadisk.co.uk/html_docs/redhat/hpacucli.htm
    http://cciss.sourceforge.net/cciss_vol_status.8.html

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Un serveur HP.
    Utilise le driver cciss ou hpsa (plus évolué).

        Voir: http://h10032.www1.hp.com/ctg/Manual/c02677069.pdf

    cciss : dans /dev/cciss/c*dX
    hpsa :  dans /dev/sdX


    Le serveur dont je dispose bénéficie de deux contrôleur:
        Le P400 pour les RAID 'internes'.
        Le P800 pour le DAS.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    TODO
        --------------------------
        P800
        --------------------------

            Appuyer sur F8 lors du test du contrôleur.
            Créer ses grappes dans le mode de RAID que l'on souhaite.

            Idéalement pour une grappes en RAID6, laisser un emplacement vide pour cocher le hotspare. (disque de remplacement)

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Tools HP
        --------------------------

            Ajout du dépot officiel:
                http://downloads.linux.hp.com/SDR/repo/

                > wget http://downloads.linux.hp.com/SDR/add_repo.sh
                > apt-get install lsb-release
                > ./add_repo.sh stk [hpsum ...]

                ou manuellement:
                    curl http://downloads.linux.hp.com/SDR/hpPublicKey2048.pub | apt-key add -
                    curl http://downloads.linux.hp.com/SDR/hpPublicKey1024.pub | apt-key add -
                    
                    exemples de depot:

                        > vim /etc/apt/sources.list.d/hp

                            deb http://downloads.linux.hp.com/SDR/repo/mcp/debian wheezy/current non-free
                            deb http://downloads.linux.hp.com/SDR/repo/mcp/ubuntu precise/current non-free

            Install des paquets

                apt-get update
                apt-get install cciss-vol-status hpacucli hp-health

                à part:
                apt-get install array-info

        --------------------------
        iLO - Integrated Lights-Out
        --------------------------

            Interface d'admin du serveur.

            Au démarrage F8
            Puis créer un utilisateur et assigner une IP à l'interface.

            On se rend ensuite sur https://@IP_assignée

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Controleur RAID
        --------------------------
            Voir les logs:

                > hplog -v

            Voir l'état du controleur:
                
                > cciss_vol_status /dec/cciss/c*dX

                ou encore:

                > array-info -d /dev/cciss/c*dX

            Manipuler le contrôleur:
                http://www.datadisk.co.uk/html_docs/redhat/hpacucli.htm

                > hpacucli
                    => help

                    #Voir la configuration du controleur:
                        ctrl all show config detail

                    #Voir l'état du contrôleur:
                        ctrl all show status

                    #Voir les datail sur un disque physique:
                        ctrl slot=X pd all show detail

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Les status
        --------------------------

            Drive Array Recovery Needed - This indicates that a disk of the array has failed.
            Drive Array Resuming Automatic Data Recovery Process - This is the controller starting to rebuild the array
            Drive Array Reports Valid Data Found in Array Accelerator - this usually appears after an unexpected shutdown, has the server rebooted on those dates?
            Drive Array - Array Accelerator Battery Charge Low - this appears at the beginning of the log, the server was new and battery was not charged yet.

            Pour connaitre l'état d'avancement du recovering:

                > array-info -d /dev/cciss/c1d0

                    #voir status

                Note: cela peut prendre beaucoup de temps.

        --------------------------
        Contrôleur P800
        --------------------------
                __________________________
                hpacucli:

                        Contrôleur désactivé
                        ``````````````````````````

                            The controller is disabled because the cache
                               module is not attached. Please re-attach the
                               cache module to re-enable the controller.

                            A voir : apparament repassé sur la version 8.70 de hpacucli (mais difficil à trouver en 64 bits)
                    
                        No controllers detected
                        ``````````````````````````
                            http://blog.wpkg.org/2012/03/15/hpacucli-error-no-controllers-detected-with-hpsa-module-in-use/
