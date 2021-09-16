==========================================================
                       P A C K A G E S
==========================================================

Comment créer ses propres paquets.

~~~~~~~~~~~~~~~~~~~~~~~~~~
DEBIAN .DEB
~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://www.debian.org/doc/manuals/maint-guide/build.fr.html

        --------------------------
        dpkg-deb --build
        --------------------------

            http://openclassrooms.com/courses/creer-un-paquet-deb

                __________________________
                Arboresence type pour créer un paquet:

                    meu                     #Nom du projet (paquet)
                    ├── DEBIAN              #Dossier contenant les prerequis
                    │   ├── control         #Fichier d'information (version, dépendances ...)
                    │   ├── postinst        #Script bash lancé avant l'installation
                    │   ├── postrm          #Script bash lancé avant la suppression
                    │   ├── preinst         #Script bash lancé après l"installation
                    │   └── prerm           #Script bash lancé après la suppression
                    └── usr                 #Destinations du code
                        ├── bin
                        │   └── meu.sh
                        └── lib

                __________________________
                control:

                    https://www.debian.org/doc/debian-policy/ch-controlfields.html

                    On commence par créer un dossier DEBIAN au niveau de son logicies ou de ses sources.

                    On y place un fichier control avec ces informations:

                        Package: meu
                        Version: 1.0
                        Section: science
                        Priority: optional
                        Architecture: i386
                        Depends: bash
                        Maintainer: plo <adresse@mail.fr>
                        Description: la vache qui fait meuh
                        Homepage: http://nowhere.com

                        Note pour la section:
                             The Debian archive maintainers provide the authoritative list of sections. At present, they are: admin, cli-mono, comm, database, debug, devel, doc, editors, education, electronics, embedded, fonts, games, gnome, gnu-r, gnustep, graphics, hamradio, haskell, httpd, interpreters, introspection, java, kde, kernel, libdevel, libs, lisp, localization, mail, math, metapackages, misc, net, news, ocaml, oldlibs, otherosfs, perl, php, python, ruby, science, shells, sound, tasks, tex, text, utils, vcs, video, web, x11, xfce, zope. The additional section debian-installer contains special packages used by the installer and is not used for normal Debian packages. 

                __________________________
                Scripts liés à dpkg:

                    On peu créer les scripts d'installation, postinst, postrm ...
                    
                    Exemple:
                        
                        > vim preinst

                            #!/bin/bash

                            echo "du lait tu auras"


                __________________________
                Destination des fichiers:


                    Enfin on place les fchiers de son soft de la même manière qu'on le ferai au niveau de son système.

                __________________________
                Builder le .deb

                    Revenir au même niveau que son projet:

                    > sudo dpkg-deb --build monPaquet

                __________________________
                Installer le .deb:

                    > sudo dpkg -i monPaquet

                __________________________
                Désinstaller le paquet:

                    > sudo apt-get remove monPaquet

        --------------------------
        Reconstruction d'un paquet
        --------------------------



        --------------------------
        Autobuild
        --------------------------
            
        --------------------------
        Avec des VCS:
        --------------------------

                __________________________
                mercurial:

                    http://manpages.ubuntu.com/manpages/precise/man1/mercurial-buildpackage.1.html
                __________________________
                svn:

                __________________________
                git:

                    http://www.eyrie.org/~eagle/notes/debian/git.html

                __________________________
                cvs:

        --------------------------
        Résumé des commandes
        --------------------------


                debian/rules = script du mainteneur pour la construction du paquet ;
                dpkg-buildpackage = partie principale de l’outil de construction de paquet ;
                debuild = dpkg-buildpackage + lintian (construction avec des variables d’environnement vérifiées) ;
                pbuilder = partie principale de l’outil pour l’environnement chroot de Debian ;
                pdebuild = pbuilder + dpkg-buildpackage (construction dans le chroot) ;
                cowbuilder = accélération de l’exécution de pbuilder ;
                git-pbuilder = syntaxe d’utilisation aisée de ligne de commande pour pdebuild (utilisée par gbp buildpackage) ;
                gbp = gestion des sources Debian dans le dépôt git ;
                gbp buildpackage = pbuilder + dpkg-buildpackage + gbp.


        --------------------------
        Patch - Update
        --------------------------

            https://help.ubuntu.com/community/UpdatingADeb

                        subtitle 4
                        ``````````````````````````
~~~~~~~~~~~~~~~~~~~~~~~~~~
RedHAt .RPM
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://doc.fedora-fr.org/wiki/La_cr%C3%A9ation_de_RPM_pour_les_nuls_:_Cr%C3%A9ation_du_fichier_SPEC_et_du_Paquetage
