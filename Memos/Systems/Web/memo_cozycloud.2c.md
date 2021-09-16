==========================================================
                       C O Z Y  C L O U D
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Officiel:
        http://cozy.io/

        Install:
            http://cozy.io/host/install.html

        Sources:
            https://github.com/cozy

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Un cloud web tout comme ownCloud avec une interface très épurée et déja plein d'application.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Cozy cloud est esssentielement codé en Javascript + Html5 + python
    Son architecture ressemble à un PaaS

    /!\ : Pour le moment Cozy Cloud ne gère qu'un utilisateur par cloud !
        Le stockage est effectué aussi en local.
        Donc pour du multi utilisateur, se rabattre sur ownCloud ou créer plusieurs VM/conteneurs ...


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Prérequis:

        Note: Préparer une machine vierge sans serveur web déja installé (ou le stopper)

        > apt-get install python python-pip python-dev software-properties-common

        #Install de Fabric:
            > pip install fabric fabtools

        > wget https://raw.githubusercontent.com/cozy/cozy-setup/master/fabfile.py

    Lancement du script:

        > fab -H sudoer_user@localhost install


~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Se connecter ensuite sur son cloud et suivre les instructions.

    Connexion:
        https://@IP_server:443

    Paramètres Nginx:
        ... 

    Les fichiers:
        Dans /etc/cosy
            /usr/local/cozy

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Interface et Applications
        --------------------------

            Tout ipeut se gèrer au clic.

        --------------------------
        Mise à jour
        --------------------------

            Via fabric:

                > fab -H user@ip update_stack
                > fab -H user@ip update_all_apps
                > fab -H sudoer@host:ip update_indexer


            Sans Fabric:

                sudo cozy-monitor update data-system
                sudo cozy-monitor update home
                sudo cozy-monitor update proxy
                sudo supervisorctl stop cozy-controller
                sudo pkill -9 node # make sure no process is remaining.
                sudo npm -g update cozy-controller
                sudo supervisorctl start cozy-controller

                l'indexer:

                    cd /usr/local/cozy-indexer/cozy-data-indexer
                    . virtualenv/bin/activate
                    git pull origin master
                    pip install --use-mirrors --upgrade -r ./requirements/common.txt
                    supervisortctl restart cozy-indexer

            Une application:

                > sudo cozy-monitor update <app>

        --------------------------
        Infos
        --------------------------

            > cozy-monitor status
            > cozy-monitor versions
            > cozy-monitor versions-apps

        --------------------------
        Redémarrer cozy
        --------------------------

            > cozy-monitor restart-cozy-stack

        --------------------------
        Gestion des applications
        --------------------------

            > cozy-monitor [stop|start|restart|update|brunch|uninstall] <app>

        --------------------------
        Gestion de la base
        --------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~
Trouble shootings
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Voir: https://github.com/cozy/cozy-setup/wiki/Trouble-shootings

    L'installation d'une application ne s'arrête jamais:

        Refresh la page et tenter de redémarrer le module data-system

        > sudo cozy-monitor restart data-system

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
