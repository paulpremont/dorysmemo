==========================================================
                       A P T L Y
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    doc :

        http://www.aptly.info/doc/why/
        https://golang.org/project/

    tutos :

        http://www.aptly.info/tutorial/
        http://www.aptly.info/tutorial/mirror/
        http://fedoraproject.org/wiki/Creating_GPG_Keys

    FAQ :

        http://www.aptly.info/doc/faq/

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    aptly est un tools permettant de gérer facilement ses propres repository/packages.
    Il ajoute une couche de contrôle et de snapshot pour créer et maitenir facilement ses propres mirrors.
    Il est écrit en Go et s'appuie sur apt.

    En roadmap : la compatibilité avec yum.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://www.aptly.info/doc/overview/

    aptly est un outils de gestion de repo de packages.
    Il permet de créer, supprimer, merger plusieurs repo entre eux issu d'un miroir externe ou encore de paquets locaux.

        --------------------------
        Layout :
        --------------------------

            - Mirror : Copie d'un miroir distant.
            - Local Repo : Son propre repo local créer à partir de packages individuels.
            - Snapshot : Permet de  sauvegarder / contrôler les changements dans un repo.
            - Published Repo : Repos gérés via aptly et prêt à l'emploi pour le gestionnaire de version (apt).

        --------------------------
        Workflow :
        --------------------------

            Ce workflow peut s'appliquer sur un repo local ou un miroir:

            -> Création d'un repo local -> snapshot du repo -> publication d'un repo valide

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Via apt
        --------------------------

            Repo :

                > vim /etc/apt/sources.list.d/aptly.list

                    deb http://repo.aptly.info/ squeeze main

                > apt-key adv --keyserver keys.gnupg.net --recv-keys E083A3782A194991
                > apt-get update

            Packages :

                > apt-get install aptly bzip2 gnupg gpgv
    
        --------------------------
        Via git 
        --------------------------

            Avec go et gom :

                > go get -u github.com/mattn/gom
                > mkdir -p $GOPATH/src/github.com/smira/aptly
                > git clone https://github.com/smira/aptly $GOPATH/src/github.com/smira/aptly
                > cd $GOPATH/src/github.com/smira/aptly
                > gom -production install
                > gom build -o $GOPATH/bin/aptly

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Les fichiers
        --------------------------

            Les fichiers de configurations sont dispo dans :

                ~/.aptly.conf : configuration par défaut d'aptly.
                ~/.aptly : dossier contenant la base aptly et les packages.
                    ~/.aptly/pool/ : contient les packages des miroirs

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Afficher l'aide
        --------------------------

            > man aptly

            > aptly <Command> help

        --------------------------
        /!\ Créer sa clé GPG
        --------------------------

            Pour signer les 'published repo' il faut générer sa propre clé gpg (si il n'y en a pas déja)

            > gpg --gen-key

        --------------------------
        Importer un miroir distant
        --------------------------

                __________________________
                Création d'un miroir :

                        Permier lancement :
                        ``````````````````````````

                            > aptly mirror create -architectures="amd64,i386" wheezy-main http://mirror.yandex.ru/debian/ wheezy main

                            autres exemples:

                                > aptly mirror create -architectures=amd64 -filter='Priority (required) | Priority (important) | Priority (standard)' wheezy-main http://ftp.ru.debian.org/debian/ wheezy main

                                > aptly mirror create -architectures="i386,amd64" -filter="xfce4" -filter-with-deps -dep-follow-recommends -dep-follow-suggests -dep-follow-all-variants -ignore-signatures xfce4 http://ae.archive.ubuntu.com/ubuntu/ trusty main universe



                        Filtre des paquets à installer :
                        ``````````````````````````

                            -filter='Priority (required) | Priority (important) | Priority (standard) | nginx | postgresql | redis-server | memcached | ruby | golang' -filter-with-deps


                        Trust GPG :
                        ``````````````````````````

                            Un message d'erreur gpg apparaitra car il manquera surement des clés trustées dans sa base :

                                > gpg --no-default-keyring --keyring /usr/share/keyrings/debian-archive-keyring.gpg --export | gpg --no-default-keyring --keyring trustedkeys.gpg --import

                            Sinon pour bypasser la vérification gpg (à eviter):

                                -ignore-signatures

                        Mise à jour du miroire (importation des packages) :
                        ``````````````````````````

                            > aptly mirror update wheezy-main

        --------------------------
        Créer un repo local à partir de paquets .deb
        --------------------------

            Pour créer son propre repo sans passer par un miroir, il est possible d'importer directement des paquets .deb.

                __________________________
                Obtenir des .deb

                    Par exemple depuis le net :

                        > wget http://somewhere/mon.deb

                    Ou depuis une iso :

                        > wget http://somewhere/mon/iso
                        > mount -o loop mon.iso /mnt

                        Voir ensuite le dossier pool/

                __________________________
                Créer un nouveau repo local :

                    > aptly repo create -distribution=DISTNAME -component=TYPE REPO_NAME

                    Exemple :

                        > aptly repo create -distribution=trusty -component=main trusty-iso
                __________________________
                Importer des .deb

                    > aptly repo add REPO_NAME DEB_DIR

                    Exemple :

                        > aptly repo add trusty-iso loop

                    On peut ensuite vérifier :

                        > aptly repo show -with-packages trusty-iso

        --------------------------
        Snapshoter un miroir / un repo
        --------------------------

            Pour conserver l'état d'un miroir, il est important de le snapshoter.
            Cela équivaut entre autre à le versionner et appliquer un label sur le nom de cette version.

            C'est la première étape avant de publier un repo.
                __________________________
                Créer un snapshot :

                    > aptly snapshot create SNAPSHOT_NAME from mirror APTLY_MIRROR_NAME
                    > aptly snapshot create SNAPSHOT_NAME from repo APTLY_LOCAL_REPO_NAME

                    Exemple :

                        > aptly snapshot create wheezy-main-2014-08-16 from mirror wheezy-main

                    Note:

                        Les snapshots prennent très peut de place, ce sont simplement des fichiers contenant des listes de packages.

                __________________________
                Lister les snapshots :

                    > aptly snapshot list

                __________________________
                Merger des snapshot :

                    Cela permet de créer un nouvel ensemble de package à partir de plusieurs snapshot :

                    > aptly snapshot merge [STRATEGY to apply] FINAL_SNAPSHOT SNAP1 SNAP2 ...

                    Exemple :

                        Pour être sur d'avoit toutes les versions de ses packages (et éviter les conflits de dépendances) :

                            > aptly snapshot merge -no-remove FINAL_NAME SNAP1 SNAP2 ...

                        Pour n'avoir que les derniers packages :

                            > aptly snapshot merge -latest wheezy-final-20141009 wheezy-main-7.6 wheezy-updates-20141009 wheezy-security-2014100

                        Avec -latest la statégie appliquée par défaut : garder tout les paquets les plus récent (en cas de conflit).

        --------------------------
        Packages
        --------------------------

                __________________________
                Afficher les infos :

                    > aptly package show -with-references 'Name (PACKAGE_NAME)'

                __________________________
                Rechercher un ou des packages :

                    Exemple, dans un mirroir :

                        > aptly mirror search xfce4 'Name (% xfce4*)

        --------------------------
        Publier un miroir
        --------------------------

            Cette étape permet de valider un snapshot comme un repo utilisable par apt.

                __________________________
                Valider et publier un snapshot :

                    > aptly publish snapshot -distribution=DIST_NAME SNAPSHOT_TRUSTED

                    Exemple :

                        > aptly publish snapshot -distribution=wheezy wheezy-final-20141009

                    /!\ il est préférable de renseigner le nom de distribution pour la gestion du repo.

                    Note : il utilisera la clé définit dernièrement par gpp.

                __________________________
                Mettre à jour un miroir local publié issu d'un repo local :

                    Si l'on update les packages de son repo local, il faudra mettre à jour le repo publié :

                        > aptly publish update myMirror

                    /!\ sinon voir switch pour mettre à jour un repo publié (on bascule sur un nouveau snapshot)

                __________________________
                Switcher/mettre à jour un mirroir publié :

                    Il suffit pour cela de créer un nouveau snapshot et de 'switcher' le mirroir publié :

                        > aptly publish switch myPublishedMirror newSnapshot

                __________________________
                Mettre à jour un miroir :

                    Si l'on update, par exemple, les packages de son repo local, il faudra mettre à jour le repo publié :

                        > aptly publish update maDistrib
            
                __________________________
                Diffuser le miroir via http :

                        Via son propre serveur http :
                        ``````````````````````````

                            Il est ensuite possible de publier le miroir over http ou par son propre service http.
                            dans ce cas, il faut présenter le dossier suivant :

                                ~/.aptly/public/

                        Via le webserver intégéré à aptly :
                        ``````````````````````````

                            > aptly serve


        --------------------------
        Publier plusieurs composants d'un repo (main, contrib ...)
        --------------------------
                    
                __________________________
                Créer un miroir avec plusieurs composants :

                    > aptly mirror create wheezy-main http://ftp.ru.debian.org/debian/ wheezy main
                    > aptly mirror create wheezy-contrib http://ftp.ru.debian.org/debian/ wheezy contrib
                    > aptly mirror create wheezy-non-free http://ftp.ru.debian.org/debian/ wheezy non-free


                    > aptly mirror list -raw | xargs -n 1 aptly mirror update

                __________________________
                Création des snapshots :

                    > aptly snapshot create wheezy-main-7.5 from mirror wheezy-main
                    > aptly snapshot create wheezy-contrib-7.5 from mirror wheezy-contrib
                    > aptly snapshot create wheezy-non-free-7.5 from mirror wheezy-non-free
                    
                __________________________
                Publier tout les snapshot dans un seul repo :

                    #avec le préfix monrepo :

                        > aptly publish snapshot -component=main,contrib,non-free -distribution=wheezy wheezy-main-7.5 wheezy-contrib-7.5 wheezy-non-free-7.5 monrepo

                    #Forme raccourcie :

                        > aptly publish snapshot -component=,, wheezy-main-7.5 wheezy-contrib-7.5 wheezy-non-free-7.5 monrepo
                __________________________
                Avec un repo :

                    Création :

                        > aptly repo create -distribution=wheezy -component=main my-soft-main
                        > aptly repo create -distribution=wheezy -component=contrib my-soft-contrib

                    Publication (sans snapshot):

                        > aptly publish repo -component=, my-soft-main my-soft-contrib

                    Publication (avec snapshot):

                        > aptly snapshot create my-soft-main-1.0 from repo my-soft-main
                        > aptly snapshot create my-soft-contrib-1.0 from repo my-soft-contrib

                        > aptly publish snapshot -component=, my-soft-main-1.0 my-soft-contrib-1.0

        --------------------------
        Graphs
        --------------------------

            Pour afficher l'organisation des repos d'aptly :

                > aptly graph

            Tout les graphes sont générés par défaut dans /tmp

                > ls /tmp/*.png

        --------------------------
        Utiliser un repo (partie cliente)
        --------------------------

                __________________________
                importer la clé publique du miroir :

                    Export de la clé côté serveur :

                        > gpg --export --armor > my_key.pub

                    Import sur le client :

                        > sudo apt-key add my_key.pub

                __________________________
                Editer ses sources :

                    Exemple avec le port 8080 et un serveur en 10.0.2.14 :

                        > vim /etc/apt/sources.list.d/monRepo.list

                            #Repo pour les archi x86 et x64
                            deb http://10.0.2.14:8080/ wheezy main

                            #Pour n'avoir que l'archi en x64 :
                            deb [arch=amd64] http://10.0.2.14:8080/ wheezy main

                        > apt-get update
                        > apt-get upgrade

        --------------------------
        Mettre à jour un repo Mirroré
        --------------------------

            #On met à jour le repo frontal :

                > aptly mirror update wheezy-securit

            #On recréer un snapshot qu'on merge (ou pas) avec les repo souhaité.

                > aptly snapshot create wheezy-security-20141019 from mirror wheezy-security
                > aptly snapshot merge -latest wheezy-final-20141019 wheezy-main-7.6 wheezy-updates-20141009 wheezy-security-20141019

            #Il faut ensuite switcher le miroir publié :

                > aptly publish switch wheezy wheezy-final-20141019

            #Enfin on updatera le repo au niveau du client

                > apt-get update
                > apt-get upgrade

        --------------------------
        Maintenir la base
        --------------------------
                __________________________
                Supprimer les anciens snapshots et les paquages qui ne sont plus utilisés :

                    > aptly db cleanup

        --------------------------
        Former ses queries, ses filtres
        --------------------------

            http://www.aptly.info/doc/feature/query/

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        file already exists and is different
        --------------------------

            https://github.com/smira/aptly/issues/90
                __________________________
                Logs:

                    ERROR: unable to publish: unable to process packages: error linking file to /home/aptly/.aptly/public/pool/main/3/389-ds-base/389-ds_1.3.2.16-0ubuntu1_all.deb: file already exists and is different

                __________________________
                Description:

                    Un package du même nom/version existe déja dans un autre repo mergé.

                __________________________
                Résolution:

                    Utiliser l'option -force-overwrite lors du publish.

                    Ex :

                        > aptly publish -force-overwrite switch trusty trusty_common_2016_01_20_060000

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
