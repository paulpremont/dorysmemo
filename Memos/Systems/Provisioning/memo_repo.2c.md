==========================================================
                        R E P O
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Tutos :

        http://askubuntu.com/questions/170348/how-to-make-my-own-local-repository
        http://wiki.centos.org/HowTos/CreateLocalRepos
        https://wiki.debian.org/HowToSetupADebianRepository
        http://ubuntuforums.org/showthread.php?t=1090731
        http://techblog.glendaleacademy.org/ubuntu-10-04/pxe-boot-network-install-repository-server
        http://doc.ubuntu-fr.org/tutoriel/comment_installer_un_depot_local
		http://www.isotton.com/software/debian/docs/repository-howto/repository-howto.html

    Metapackages :

        https://help.ubuntu.com/community/MetaPackages

    TODO...

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Pour les .deb :
        --------------------------

            Le repo est un conteneur de paquets .deb avec au moins deux fichiers spéciaux:
            Packages.gz : pour les infos concernant les binaires.
                (nom, version, taille, description ...)
                Correspondant au mot clé deb dans sources.list
            Sources.gz : pour les infos concernant les sources.
                (nom .. + dépendances)
                Coresspondant au mot clé deb-sr dans sources.list

            Il est possible de créer deux type de repo:
                La version "automatic" qui permet de simplifier la recherche de paquet avec apt
                Le deuxième "trivial" qui est plus simple à mettre en oeuvre mais qui nécéssite de renseigner des path complet.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        .RPM
        --------------------------

            > yum install createrepo        #l'outil existe aussi pour apt

                __________________________
                Serveur :

                    > mkdir -p /var/www/html/$distribution/$version/$type/$architecture
                    > createrepo /var/www/html/$distribution/$version/$type/$architecture 

                    avec type = os ou updates
                    
                    Ensuite il faut copier une liste de rpm dans ce dossier.
                    Une première liste peut être récupérée sur les cd d'installation dans le dossier d'un nom similaire.

                    On peu aussi le mettre à jour via rsync:

                    exemple:

                    > rsync://URL/packages/distribution/

                __________________________
                Client :

                    > vim /etc/yum.repos.d/$repo_name.repo

                    [base]
                    name=CentOS-$releasever - Base
                    baseurl=http://192.168.*.*/centos/$releasever/os/$basearch/
                    #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os
                    #baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/
                    gpgcheck=1
                    gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-5
                    #released updates

                    [update]
                    name=CentOS-$releasever - Updates
                    baseurl=http://192.168.*.*/centos/$releasever/updates/$basearch/
                    #mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates
                    #baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch/
                    gpgcheck=1
                    gpgkey=http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-5

                    todo

        --------------------------
        .DEB
        --------------------------

            > apt-get install apache2 dpkg-dev
                __________________________
                Création de l'arbre :

                        Manuellement (deprecated) :
                        ``````````````````````````

                            #Contiendra tout les paquets:

                            mkdir -p /home/repositories/packages/apt/$DISTRIB/amd64
                            mkdir -p /home/repositories/template/yum/$DISTRIB/i386
                            
                            #Contiendra uniquement les liens vers les paquets qui nous interessent:
                            mkdir -p /home/repositories/apt/clients/dists/debian/main/
                            mkdir -p /home/repositories/apt/servers/dists/debian/main/

                            mkdir -p /home/repositories/apt/dists/amd64/servers
                            mkdir -p /home/repositories/apt/dists/i386/clients
                            mkdir -p /home/repositories/apt/dists/i386/servers

                            mkdir -p /home/repositories/yum/amd64/clients
                            mkdir -p /home/repositories/yum/amd64/servers
                            mkdir -p /home/repositories/yum/i386/clients
                            mkdir -p /home/repositories/yum/i386/servers

                        Automatiquement :
                        ``````````````````````````
                            > mkdir -p dists/

                    
                        Trivial :
                        ``````````````````````````

                            #Création de l'arborescence:

                                > cd /home/packages
                                > mkdir binary source

                            #Création des fichiers index:

                                > dpkg-scanpackages binary /home/packages/debian |gzip -9c > binary/Packages.gz
                                > dpkg-scansources source /home/packages/debian |gzip -9c > source/Sources.gz

                            #sources.list
                            
                            Et bien sur il suffit ensuite de se créer un site pour heberger tout ça :) . 
                __________________________
                Un exemple :

                    #montage d'une iso de base:
                        mount /cdrom1 /media/cdrom0

                    #Copie des paquets:
                        find /media/cdrom0 -type f |egrep "\.deb$" |xargs -i cp {} /home/repositories/template/

                    #Création du fichier archive 
                        dpkg-scanpackages ./ | gzip -9c > binary-i386/Packages.gz

                    TODO

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

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
