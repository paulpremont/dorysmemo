D O C K E R
=========================

/!\ Docker est une solution en pleine essort qui bouge beaucoup, il faut se mettre constament à jour.

Links
-----------------------

### Officiels

* [Site officiel](https://www.docker.com/)
* [Installation](https://docs.docker.com/engine/installation/ubuntulinux/)
* [Documentation](https://docs.docker.com/)
* [Fonctionnement](http://docs.docker.io/introduction/technology/)

### Tutos

* [Manipuler les conteneurs](http://linuxfr.org/news/docker-tutoriel-pour-manipuler-les-conteneurs)
* [aresu.dsi](https://aresu.dsi.cnrs.fr/spip.php?article202)
* [exposition des ports](http://stackoverflow.com/questions/19897743/exposing-a-port-on-a-live-docker-container)
* [conteneur mysql](http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/)

### Execution de process au démarrage d'un conteneur :

* [groups.google.com](https://groups.google.com/forum/#!topic/docker-user/M-or-QHyQ_o)
* [Exemple dockerfile](https://github.com/dotcloud/hipache/blob/master/Dockerfile)

### Registry :

* [Lien officiel](https://docs.docker.com/registry/)
* [Api registry](http://docs.docker.io/reference/api/registry_index_spec/)
* [private registry](http://www.activestate.com/blog/2014/01/deploying-your-own-private-docker-registry)
* [tuto centos](http://cloudcounselor.com/2014/01/07/docker-private-registry-on-centos-rhel-6-5/)
* [docker registry exemple](https://github.com/dotcloud/docker-registry)
* [tuto how to use registry](http://blog.docker.io/2013/07/how-to-use-your-own-registry/)
* [tuto run private registry](https://blog.codecentric.de/en/2014/02/docker-registry-run-private-docker-image-repository/)

### https :

[remote access with tls](http://sheerun.net/2014/05/17/remote-access-to-docker-with-tls/)
[tuto](https://gist.github.com/cameron/10797040)
[private registry example](https://github.com/shipyard/docker-private-registry)

### Elargissement :

[database](http://dbdeploy.com/documentation/taking-control-of-your-database-development-white-paper/)
[buildbox](http://callumj.com/posts/weave_docker_buildbox.html)

### Bonnes pratiques :
[best-practises](http://crosbymichael.com/dockerfile-best-practices-take-2.html)

### Créer des docker file à partir de diff :

**Produit payant (GuardRail):**
[guardraild](http://www.scriptrock.com/blog/comparing-containers-generating-dockerfiles-guardrail)

### Alternatives

* [Rocket](https://coreos.com/blog/rocket/)
* [lxc](https://linuxcontainers.org/fr/)

### Versus

**Mise à plat des différences entre systèmes de conteneurs (LXC, LXD, Docker) :**

* [difference entre docker, lxd et lxc](http://unix.stackexchange.com/questions/254956/what-is-the-difference-between-docker-lxd-and-lxc)


What is it ?
-----------------------

C'est une surcouche d'abstraction à LXC étendant son utilisation.  
On garde donc le même principe d'isolation mais avec en plus la possibilité de manipuler facilement ses conteneurs.

Il est orienté applications. C'est à dire que la philosophie est : une appli = un conteneur ou un set de conteneurs.  
Un conteneur est désigné de manière à lancer une seule application.  
On peut toujours détourner cette utilisation avec supervisord pour lancer plusieurs process au démarrage.
Car docker est dépourvu d'init contrairement à lxc.

Il se base sur le FS AUFS/Devicemapper en plusieurs couches read-only. (principe des images qui sont représentées par plusieurs stacks).

Les instances (les conteneurs) sont censées être éphémères.  
Les données persistantes stockées sur l'hôte même ou des conteneurs de données.

Installation
-----------------------

### via les packages

**Pour avoir les derniers build docker via le repo docker:**

/!\ lxc-docker est l'ancien nom du package, il faut maintenant installer docker-engine
et purger l'anien lxc-docker-XX

Ajouter les sources:

    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

    vim /etc/apt/sources.list.d/docker.list

        deb https://apt.dockerproject.org/repo ubuntu-wily main

    sudo apt-get update
    sudo apt-get install docker-engine

### Execution en sudo

docker s'execute en root

si vous passez par sudo, il suffit simplement de rajouter un alias dans son bashrc:

    alias docker="sudo docker"


How it work ?
-----------------------

### Fichiers

Les fichiers sont stockés dans /var/lib/docker

    /var/lib/docker
    ├── aufs
    ├── containers
    ├── graph
    ├── image
    ├── linkgraph.db
    ├── network
    ├── repositories-aufs
    ├── swarm
    ├── tmp
    ├── trust
    └── volumes

### Images et conteneurs

Les images sont les RootFS des conteneurs en mode read only.
Elles representent les modèles à partir desquels les conteneurs vont s'initier.
Un conteneur est une instance d'une image en read write. (utilisant UnionFS)
On peut le commit pour qu'il devienne à son tour une image.

### Dockerfile

Contient toutes les instructions d'automatisation de construction d'image/conteneur.

    vim Dockerfile

#### Instructions:

##### FROM

    FROM monIMage:monTag #Image du rootFS (l'image de base en Read only)

**Exemple :**

    FROM ubuntu

##### MAINTAINER 

    MAINTAINER nom prénom, adresse email

**Exemple :**

    MAINTAINER Prémont paul, paul@premont.fr

##### RUN

    RUN command     #Lancer une commande et commiter (= docker run IMAGE COMMAND ; docker commit IMAGE_ID)
    RUN ["cmd", "arg1', ...]

**Exemple :**

    ENV DEBIAN_FRONTEND noninteractive
    RUN apt-get -q -y install mysql-server

Note: pour les paquets demandant un mot de passe, il faut utiliser les bonnes options de son gestionnaire de paquet.

Pour avoir plusieurs commandes sur le même RUN (Il est préférable de regrouper les commandes) :

    RUN ma_commande && \
    ma_commande2 && \
    ma_commande3 ...

##### CMD

Lancer une commande après l'éxécution du terminal (une seule commande possible et doit être lancée en foreground)

    CMD ma_Commande
ou
    CMD ["binary", "arg1 ...]
ou
    CMD ["param1", ... ] # à utiliser avec entrypoint, et donner les paramètres par défauts

Note: si l'on précise un argument lors d'un 'docker run', alors la commande CMD sera overridée par cet argument.

##### ENTRYPOINT

Lancer une commande après le démarrage du conteneur. (Un seul ENTRYPOINT possible)

    ENTRYPOINT ["binary", "arg1"]   
    
**Exemple :**

    ENTRYPOINT ["echo", "Hello you"]

On peut utiliser ENTRYPOINT dans le but d'avoir un conteneur comme une commande :

**Exemple :**

    ENTRYPOINT ["wc", "-l"]

On build son image :

    docker build -t wc - < Dockerfile_wc

On utilise le conteneur comme la commande wc :
    
    cat /etc/hosts | docker run -i wc

##### USER

Utilisateur qui va lancer les commandes dans le conteneur.

    USER userName

Lorsque le conteneur sera lancé, il sera cloisoné avec le user spécifié :

Exemple:

    USER monUser
    ENV HOME /home/monUser
    WORKDIR /home/monUser

##### EXPOSE

Permet d'indiquer à Docker que le conteneur écoutera sur ces ports.

    EXPOSE port1 port2 ...

Le expose est utilisé surtout comme metadata du conteneur.

Note: on expose les ports que l'on souhaite binder avec l'hôte.
Le conteneur fonctionnera comme une VM niveau réseau, son IP étant accessible depuis l'hôte.

Pour les binder avec l'hôte :

    docker run -p HOST_PORT:CT_PORT MON_IMAGE

Si on ne spécifie pas de port coté host avec -p, un port aléatoire est fourni.

On peut aussi utiliser un socket :

    docker run -p HOST_IP:HOST_PORT:CTN_PORT IMAGE

Et lister le port d'écoute au niveau du système :

    docker ps

Pour publier tous les ports exposés d'un conteneur, on utilise l'option -P

Si l'on souhaite voir quels ports sont publiés sur un conteneur :

    docker inspect container_name
ou
    docker port container_name

##### VOLUME

Création d'un point de montage :

    VOLUME ["/point"]

##### ADD

Copier un ficher de l'hôte vers l'image

    ADD pathHost pathCT

Fonctionne avec les wildcards et les folders

**Note: attention au path !**

Il est relatif au 'build context', au dossier contenant le Dockerfile.
Lorsqu'on utilise l'input standard, on ne créer pas de 'build context'

Il faut donc préférer :

    docker build monDossier


##### ENV

Configurer une variable d'environnement :

    ENV variable contenu

**exemple :**

    ENV DEBIAN_FRONTEND noninteractive

### Nommage

#### TAG :

Le tag comprend à la fois le nom du repo et le nom de tag.

**exemples :**

    -t monRepo : seul le nom du repo sera changé
    -t monRepo:monTag : le nom du repo et le nom du tag sera changé

#### image :

Le nom d'image peut être l'identifiant ou le tag en entier :
Par défaut si on ne fournit que le nom du repo, docker pointera sur le nom de tag "latest".


### Composants

#### Le deamon :

Installé sur l'hôte, il gère les conteneurs.

#### Le client :

l'interface cliente pour communiquer avec le deamon

#### Docker.io registry :

C'est l'archive contenant les images.
Par défaut le registre est externalisé.
Mais il peut être crée en local.
Il est associé avec un index pour la recherche d'image.


        --------------------------
        Les technos
        --------------------------
                __________________________
                namespaces:

                    Fourni l'isolation de workspace, nommés conteneurs.
                __________________________
                cgroups:

                    Permet l'isolation et la distribution des ressources.
                __________________________
                UnionFS:

                    FS légé pour la création de bloc pour les conteneurs

                __________________________
                Containers:

                    Résulte de la combinaise des précédentes techno. IL supporte de plus les conteneurs LXC qui fait partie intégrante de ses composants.

        --------------------------
        Les services dans un conteneur
        --------------------------

            Docker n'utilise pas, par défaut, un système init pour lancer les différents processsus.
            Idem pour syslog, un conteneur Docker s'en trouve dépourvu par défaut.

            Il faut donc soit faire plusieurs manipulations pour le faire fonctionner avec un process init
            ou utiliser simplement supervisord pour manager les process en background.

                __________________________
                Faire fonctionner systemd dans une Redhat7 like :

                    http://developerblog.redhat.com/2014/05/05/running-systemd-within-docker-container/

                    DockerFile :

                        FROM fedora:rawhide
                        MAINTAINER “Dan Walsh” <dwalsh@redhat.com>
                        ENV container docker
                        RUN yum -y update; yum clean all
                        RUN yum -y install systemd; yum clean all; \
                        (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
                        rm -f /lib/systemd/system/multi-user.target.wants/*;\
                        rm -f /etc/systemd/system/*.wants/*;\
                        rm -f /lib/systemd/system/local-fs.target.wants/*; \
                        rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
                        rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
                        rm -f /lib/systemd/system/basic.target.wants/*;\
                        rm -f /lib/systemd/system/anaconda.target.wants/*;
                        VOLUME [ “/sys/fs/cgroup” ]
                        CMD [“/usr/sbin/init”]

                    Run avec les privilèges :

                        docker run –privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 httpd_rawhid

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Deamon
        --------------------------

            > service docker start|stop|restart

        --------------------------
        Les images (=~ RootFS)
        --------------------------
                __________________________
                Afficher les images:

                        docker images       #lister les images locales
                        docker images -a    #lister toutes les images
                        docker images --tree    #Afficher les commit sous forme d'arborescence

                        docker images *Image*   #listera toute les image comprenant 'Image' dans son nom.


                __________________________
                Obtenir une image:

                        docker pull IMAGE   #Télécharger l'image (ex: debian)
                __________________________
                Manipuler les images avec un repo:

                    > docker pull MON_IMAGE
                    > docker push MON_IMAGE
                    > docker search MON_IMAGE

                    voir partie registre

                __________________________
                Supprimer une image:

                        > docker rmi IMAGE_ID

                        ou

                        > docker rmi REPO_NAME:IMAGE_TAG

                __________________________
                Renommer/Taguer une image:

                    > docker tag IMAGE_SOURCE_NAME NEW_NAME:TAG_NAME

                    exemples:

                        #repo local:
                            > docker tag d76d3e4cc978 template:debian7.5

                        #repo externe:
                            > docker tag d76d3e4cc978 repo.domain.com/template:debian7.5
                            > docker tag d76d3e4cc978 localhost:5000/template:debian7.5

                    Supprimer un tag:

                        > docker rmi REPO:TAG

                    Note: le tag par défaut est latest.
                __________________________
                DockerFile

                        Un Dockerfile permet via une syntaxe précise de créer des images personnalisées.


                    Construire son image
                    ``````````````````````````

                        > docker build [-t IMAGE_NAME[:TAG]] FOLDER_WITH_DOCKERFILE

                        ou

                        > docker build -t NAME - < Dockerfile

                        ou encore

                        > docker build github.com/creack/docker-firefox

                __________________________
                Inspecter une image ou un conteneur:

                    Permet de dumper un tas d'info sur une image ou un conteneur

                    > docker inspect IMAGE|CONTAINER
                __________________________
                importer une image:

                    Importer un conteneur (from export):

                        > cat export.tar |docker import - image:name

                    Importer une image (from save):

                        > docker load < mon_IMAGE.tar
                __________________________
                Insérer des fichiers dans un conteneur:

                    > docker insert FILES IMAGES

                __________________________
                Historique:

                    > docker history IMAGE

                __________________________
                Créer une image from scratch:

                    http://blog.claude.duvergier.fr/2014/06/creer-ses-propres-images-docker-de-base/

                    avec la commande import:
                        > docker import repo:tag

                    Obtenir la tarball de son OS avec debootstrap:
                    Il faut un accès au repo debian:

                        > debootstrap nomVersion(wheezy...) monDossier
                        > tar -C monDossier -c . |docker import - nomImage

                        tuto:
                        ``````````````````````````
                            http://www.aossama.com/build-debian-docker-image-from-scratch/

                            Exemple avec wheezy:

                            #Build du system:

                                > apt-get install debootstrap
                                > mkdir -p /tmp/vdisks/chroot/wheezy
                                > sudo debootstrap wheezy /tmp/vdisks/chroot/wheezy
                                > chroot /tmp/vdisks/chroot/wheezy /bin/bash
                                > echo "Debian 7 Docker image" > /etc/motd
                                > exit

                            #importation du docker:

                                > sudo tar -C wheezy/ -c . | docker import - IMAGE_NAME
                                > docker images

                    ou via une iso:

                        > mkdir mountPoint
                        > mount -o loop maDistrib mountPoint
                        > tar -C mountPoint -c . |docker import - nomImage

                        Note: à vérifier mais le debootstrap est nécessaire.

                    ou avec From et Add

                        #une image vide:
                        > tar cv --files-from /dev/null |docker import - nomImage
                        >vim Dockerfile

                            FROM nomImage
                            ADD ./fs/bin /bin
                            ADD ./fs/boot /boot
                            # ...
                            CMD ["/bin/sh"]

                        > docker build -t='imageName' Dockerfile

        --------------------------
        Les conteneurs
        --------------------------
                __________________________
                Démarrer un nouveau conteneur depuis une image:

                    Forme générique:

                        > docker run MON_IMAGE MA_COMMANDE

                        Note: un Id aléatoire est géré à chaque lancement de commande.

                    Firewall :

                        #Il faut autoriser l'interface Docker à forwarder les packets :

                            > service docker restart  #Regénéra automatiquement les règles iptables
                            > iptables -L -nvx
                            > iptables-save > somewhere


                        #Puis redumper les nouvelles règles (la chaîne DOCKER doit existée)

                            Exemple :

*********************

Chain INPUT (policy DROP 4 packets, 124 bytes)
    pkts      bytes target     prot opt in     out     source               destination
       0        0 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
     269    78222 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED

Chain FORWARD (policy DROP 0 packets, 0 bytes)
    pkts      bytes target     prot opt in     out     source               destination
       0        0 DOCKER     all  --  *      docker0  0.0.0.0/0            0.0.0.0/0
       0        0 ACCEPT     all  --  *      docker0  0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
       0        0 ACCEPT     all  --  docker0 !docker0  0.0.0.0/0            0.0.0.0/0
       0        0 ACCEPT     all  --  docker0 docker0  0.0.0.0/0            0.0.0.0/0
       0        0 ACCEPT     all  --  *      docker0  0.0.0.0/0            0.0.0.0/0
       0        0 ACCEPT     all  --  docker0 *       0.0.0.0/0            0.0.0.0/0

Chain OUTPUT (policy DROP 0 packets, 0 bytes)
    pkts      bytes target     prot opt in     out     source               destination
       0        0 ACCEPT     all  --  *      lo      0.0.0.0/0            0.0.0.0/0
     270    44363 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            state NEW,RELATED,ESTABLISHED

Chain DOCKER (1 references)
    pkts      bytes target     prot opt in     out     source               destination

*********************


                    Exemples:

                        Lancer directement un conteneur avec bash :

                            > docker run -it --name containerName REPO:TAG /bin/bash
                            > docker run -it --name containerName IMAGE_ID /bin/bash

                        Lancer un conteneur en background :

                            > docker run -it -d -p 2222:22 --name containerName REPO:TAG /bin/bash
                            > docker run -it -d -p 2222:22 --name containerName IMAGE_ID /bin/bash

                    Options:

                        -a [stdin stdout stderr]: attach to a standard
                        -d : detach
                        -t : activer le tty du container
                        -i : garder l'input à l'écoute
                        -p HOST_PORT:CONTAINER_PORT     (voir syntaxe dans la publication de port)
                        -sig-proxy=false : Pour quitter simplement le conteneur avec CTRL+C
                            Note: on peu en rajouter autant qu'on veut
                                -p 22:22 -p 80:80

                        Si erreur type : Error running container: mkdir /sys/fs/devices: no such file:

                                voir https://github.com/ubergarm/debian-docker-runit

                        -h | --hostname  : changer le hostname du conteneur.
                        --dns=@IP : seter l'IP du DNS (dans resolv.conf)
                __________________________
                Sortir d'un conteneur:

                    CTRL + P puis CTRL + Q
                    (échapement puis quitter)
                    ou
                    CTRL + C (necessite l'option -sig-proxy=false)
                __________________________
                Partager un volume:

                    http://www.projectatomic.io/docs/docker-image-author-guidance/

                    Partager un volume entre conteneurs:

                        docker run -i  -v /var/volume1-name 'ContainerA' -t fedora /bin/bash
                        docker run -i --volumes-from ContainerA -t fedora /bin/bash

                        autre exemple:
                            docker run -v /var/volume1 -v /var/volume2 -name DATA busybox true
                            docker run -t -i -rm -volumes-from DATA -name client1 ubuntu bash

                __________________________
                commiter un conteneur

                    Commiter un conteneur revient à le transformer en image.

                        > docker commit -m'message' CONTAINER_ID [REPO:TAG]

                __________________________
                Publier un port sur un conteneur:

                    Relier un port hôte au port du conteneur

                    > docker run -p SOCKET IMAGE
                        -P : publie tout les ports en écoute.

                        Formats possible pour le socket:

                            ip:host‐Port:containerPort
                            ip::containerPort
                            hostPort:containerPort

                    On peut vérifier les ports publiés:

                    > docker port CONTAINER PUBLISHED_PORT

                __________________________
                Ajouter des hosts au fichier host:

                    > docker run -it --add-host=monHOST:127.0.0.1

                __________________________
                Afficher les logs sur un conteneur:

                    docker logs $CONT1
                    docker logs ID_CONTENEUR
                __________________________
                Lister les conteneurs:

                    docker ps -a    #Conteneurs actifs
                    docker ps -n=XX #Avec XX le nombre d'ancien 'snapshot à afficher'
                    docker ps -l    #Voir le dernier container lancé
                __________________________
                Gérer un conteneur:

                    docker start ID_CONTENEUR       #démarrer le conteneur
                    docker restart ID_CONTENEUR     #rerémarrer le conteneur
                    docker stop ID_CONTENEUR        #stopper un conteneur
                    docker attach ID_CONTENEUR      #Se connecter au conteneur
                    docker kill ID_CONTENEUR        #SIGKILL au conteneur
                    docker wait ID_CONTENEUR        #Attendre que le conteneur se stop
                __________________________
                Supprimer un conteneur:

                    docker rm $CONT1
                    docker rm CONTAINER_ID
                    docker rm $(docker ps -a -q)
                __________________________
                Infos sur conteneur:

                    inspect: voir toutes les infos sur un conteneur
                    logs : voir les logs du contenur
                    events : voir les évenements liés au conteneur
                    top : voir les conteneur en cours d'execution
                    diff : voir les fichiers qui ont été changés

                __________________________
                Copier des fichiers

                    Du conteneur vers l'hôte:

                        > docker cp CONTAINER_ID:/PATH /HOST/PATH

                    De l'hôte vers un conteneur :

                        > docker cp LOCALPATH CONTAINER:PATH

                __________________________
                Exporter:

                    Un conteneur:

                        > docker export CONTENEUR_ID > archive.tgz

                        Agit au niveau du conteneur.
                        (perte de l'historique et des meta data de l'image)
                        Mais plus légé que save

                    Une image:

                        > docker save IMAGE_ID > archive.tar

                        Sauvegarde d'une image.
                        Concervation de l'historique (des commits)

                __________________________
                Import:

                    > cat archive.tgz | docker import - TAG

                __________________________
                Lancer les services au démarrage du conteneur:

                    Via supervisord et le Dockerfile:
                    http://docs.docker.io/examples/using_supervisord/

                    exemple:

                        RUN apt-get update
                        RUN apt-get install -y supervisor openssh-server

                        RUN mkdir -p /var/run/sshd
                        RUN mkdir -p /var/log/supervisor

                        ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
                        EXPOSE 80 443 22 23

                        CMD ["/usr/bin/supervisord"]

                    Exemple de conf supervisor:

                        [supervisord]
                        nodaemon=true

                        [program:sshd]
                        command=/usr/sbin/sshd -D

                        [program:apache2]
                        command=/bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"

                        [program:mysqld]
                        command=/usr/bin/pidproxy /var/mysqld/mysqld.pid /usr/bin/mysqld_safe
                        autostart=true
                        autorestart=true
                        user=root

                        [program:xinetd]
                        command=/usr/sbin/xinetd -pidfile /var/run/xinetd.pid -stayalive -inetd_compat -dontfork

                    On build:
                        docker build -t REPO:TAG - < Dockerfile

                    On le lance:
                        docker run -d -t -i -p 127.0.0.1:2323:23 -p 2222:22 -p 8080:80 -p 4443:443 repo.domain/template:debian7.5

                        /!\ ne pas mettre de commande en argument sinon elle surpassera le CMD du Dockerfile.

                        Pour s'attacher au conteneur il faudra utiliser la commande 'docker exec'

                    Note: Quelque souci avec lighttpd, à creuser (lancement de fastcgi ...)

                        Pour exposer des ports sur un conteneur démarré:
                        ``````````````````````````
                            http://stackoverflow.com/questions/19897743/exposing-a-port-on-a-live-docker-container

                            2 méthodes pour le moment:

                                Avec iptables:

                                    Récupérer l'adresse IP du container et créer la règle de NAT:

                                        > docker inspect container_name | grep IPAddress
                                        > iptables -t nat -A  DOCKER -p tcp --dport 8002 -j DNAT --to-destination 172.17.0.19:8000

                                Avec les commandes docker:

                                    > sudo docker commit containerid foo/live
                                    > sudo docker run -i -p 22 -p 8000:80 -m /data:/data -t foo/live /bin/bash

                __________________________
                Executer une commande dans un conteneur:

                    Testé depuis la version 1.3.1
                    Avec docker-exec:

                    > docker exec [OPTIONS] CONTAINER COMMAND [ARGS]

                        -t : alloué un tty
                        -i : en mode interactif
                        -d : en mode détaché

                    exemple:

                        > docker exec -ti 65464d6q4d65q4s /bin/bash

                        (se rattacher au container avec un shell)
                __________________________
                Se lier à un conteneur:

                    https://docs.docker.com/articles/networking/#between-containers

                    Rajoutera un alias dans le fichier /etc/host du conteneur:

                    --link=CONTAINER_ID:ALIAS

                __________________________
                Les packages utiles :

                    Exemple pour une Debian :

                         - supervisor : pour lancer les services au démarrage
                         - net-tools  : pour les outils réseau (ifconfig ...)
                         - procps     : pour afficher les process (ps ...)


~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Interface réseau
        --------------------------

            Modes:

                none - no networking in the container
                bridge - (default) connect the container to the bridge via veth interfaces
                host - use the host's network stack inside the container
                container - use another container's network stack

            http://docs.docker.io/use/networking/

        --------------------------
        Démarrer automatiquement un conteneur:
        --------------------------

            https://docs.docker.com/articles/host_integration/

            Les conteneurs démarrons après le service docker:

            Exemple avec upstart:

                > vim /etc/init/demo-container.conf

                    description "Demo container"
                    author "Polo"
                    start on filesystem and started docker
                    stop on runlevel [!2345]
                    respawn
                    script
                      /usr/bin/docker start demo_container
                    end script

            Exemple avec systemd:

                [Unit]
                Description=Demo container
                Author=Polo
                After=docker.service

                [Service]
                Restart=always
                ExecStart=/usr/bin/docker start demo_container
                ExecStop=/usr/bin/docker stop -t 2 demo_container

                [Install]
                WantedBy=local.target


~~~~~~~~~~~~~~~~~~~~~~~~~~
DockerUI
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Pour avoir une interface docker:

        https://github.com/crosbymichael/dockerui

        > docker search dockerui
        > docker pull dockerui/dockerui
        ou
        > docker pull crosbymichael/dockerui (peut être moins à jour)

        On run le conteneur:

            > docker run -d -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui

        On accède à l'interface:

            > http://<dockerd host ip>:9000


~~~~~~~~~~~~~~~~~~~~~~~~~~
Repos - docker-registry
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Fonctionnement
        --------------------------

            Le registre comprend:

            __________________________
            Un index (optionnel)

                A voir comment l'installer

                L'index peut fonctionner en mode standalone:

                    C'est à dire qu'il faut lancer le registre dans ce mode.
                    on peut même s'en passer: --no-index


                -Comptes utilisateurs
                -Checksum des images
                -espaces de nom public

                avec les compostans suivants:

                    -WUI
                    -Meta-data (comments ...)
                    -Authentication
                    -Tokenization

            __________________________
            Un registre:

                -contient les images
                -supporte plusieur type de backend de sauvegarde (local FS, S3 ...)

            __________________________
            Les backends de sauvegarde:

                local:      utilise le FS locale
                s3:         utilise les le système S bucket d'Amazone
                swift:      utilise un conteneur swift d'openStack
                glance:     utilise le projet glance d'openStack
                elliptics:  utilise les clé Elliptics

        --------------------------
        Création
        --------------------------

            On télécharge les prérequis:

                > apt-get install build-essential python-dev libevent-dev python-pip liblzma-dev

            On télécharge l'application python:

                > git clone https://github.com/dotcloud/docker-registry.git

                ou

                > pip install docker-registry

            On édite sa config (voir plu loin)

                > cd config
                > cp config_sample config.yml

            On install les packages python requis:

                > pip install -r requirements.txt
                > pip install .

            On fait écouter notre registre sur un socket:

                > gunicorn --access-logfile - --debug -k gevent \
                 -b 0.0.0.0:5000 -w 1 docker_registry.wsgi:application


        --------------------------
        Installation rapide du registre
        --------------------------

            Si on veut passer par la méthode rapide: (pas forcement très safe)

                > docker pull registry
                > docker run -p 5000:5000 registry

                ou voir avec cette image:

                > docker run -p 5000:5000 samalba/docker-registry

                __________________________
                En modifiant les variables d'env

                        exemple (du site):
                            docker run \
                                     -e SETTINGS_FLAVOR=s3 \
                                     -e AWS_BUCKET=acme-docker \
                                     -e STORAGE_PATH=/registry \
                                     -e AWS_KEY=AKIAHSHB43HS3J92MXZ \
                                     -e AWS_SECRET=xdDowwlK7TJajV1Y7EoOZrmuPEJlHYcNP2k4j49T \
                                     -e SEARCH_BACKEND=sqlalchemy \
                                     -p 5000:5000 \
                                     registry

        --------------------------
        Configuration
        --------------------------


            Voir dans docker-registry/config

            Note voir aussi ?
                    /var/lib/docker/aufs/diff/xxxxx/docker-registry/config/config_sample.yml

            export DOCKER_REGISTRY_CONFIG=config.yml
            docker run -p 5000:5000 -v /home/user/registry-conf:/registry-conf -e DOCKER_REGISTRY_CONFIG=/registry-conf/config.yml registry

        --------------------------
        Actions
        --------------------------
                __________________________
                Pull:

                        Puller un repo entier
                        ``````````````````````````
                            > docker pull REPO

                            exemple:

                                > docker pull ubuntu

                            Sur un repo privée:

                                > docker pull url/nom_image

                                exemple:

                                    > docker pull mon.repo.fr:5000/debian

                        Puller une image précise
                        ``````````````````````````
                            > docker pull REPO:TAG
                            ou
                            > docker pull --tag="footag" REPO

                __________________________
                Push:

                    > docker push namespace/name
                    ou
                    > docker push url/name
                    ou
                    > docker push host/repo:tag

                    Avec le name space ou l'url l'équivalent du nom du repo [:tag]

                    Avant de push, ne pas oublier de commiter son image:

                    > docker commit CONTAINTER_ID IMAGE_NAME

                    Il faut d'abord taguer son image avec le nom du repo sur lequel on doit la pousser. (peut être fait au niveau du commit en mettant le bon nom d'image)

                        > docker tag IMAGE_ID REPO_ADDRESS/IMAGE_NAME[:tag]

                        exemple:

                            > docker tag 8dbd9e392a96 localhost.localdomain:5000/ubuntu

                    On push ensuite son image sur le repo:

                        > docker push REPO_ADDRESS

                        exemple:

                            > docker push localhost.localdomain:5000/ubuntu

                    Note:
                        Pour que docker ne confonde pas le hostname du nom d'utilisateur, il faut qu'il y au moins un '.' pour indiquer un hostname ou le numéro de port.

                __________________________
                version rapide:

                    docker pull fooimage
                    docker tag fooimage localhost:5000/fooimage
                    docker push localhost:5000/fooimage

                __________________________
                S'authentifier auprès d'un registre:

                    > docker login docker_registry_hostname

                    Note les élements d'authentification sont sauvegardé dans:
                    ~/.dockercfg

                __________________________
                Rechercher dans un registre:

                    > docker search

                    ou pour lister:

                    https://HOSTNAME/v1/repositories/REPO/tags

        --------------------------
        Accès overs ssh:
        --------------------------

            # Run the registry on the server, allow only localhost connection
            docker run -p 127.0.0.1:5000:5000 registry

            # On the client, setup ssh tunneling
            ssh -N -L 5000:localhost:5000 user@server

        --------------------------
        Tuto
        --------------------------
                __________________________
                Un registre sécurisé avec nginx: (From ActiteState)

                    S'appuie sur Nginx pour l'authentification et le reverse proxy.
                    Nginx utilise chunkin pour autoriser le transfert de "chunks" pour l'ajout additionnel de header HTTP:
                    voir http://tools.ietf.org/html/rfc2616#section-3.6.1

                    Et enfin gunicorn (le process de lancement du registre) integrera redis pour le caching LRU (Least Recently Used), permetant de réduire l'effet de roundtrip vers la base.

                        Les paquets
                        ``````````````````````````

                            #pour le module chunkin:
                            > apt-get install git nginx-extras

                            #pour la commande htpasswd:
                            > apt-get install apache2-utils

                            #Les dépendances:
                            > apt-get install build-essential libevent-dev libssl-dev liblzma-dev python-dev python-pip

                            #LRU cache:
                            > apt-get install redis-server

                        Les sources
                        ``````````````````````````

                            #On importe notre repo:
                            > git clone https://github.com/dotcloud/docker-registry.git /opt/docker-registry
                            > cd /opt/docker-registry
                            > git checkout 0.7  #la dernière relase disponible (voir avec git branch -a)
                            > mkdir -p /var/log/docker-registry
                            > pip install -r requirements.txt
                            > pip install .
                            > cp config/config_sample.yml config/config.yml

                            #On test:
                            gunicorn --access-logfile - --debug -k gevent -b 0.0.0.0:5000 -w 1 docker_registry.wsgi:application

                            #Point de stockage des données
                            > mkdir -p /data/registry

                        La conf
                        ``````````````````````````

                            #La conf (config.yml)
                            #On génere une clé: http://uuidgenerator.net/

                                #########################################
                                # The `common' part is automatically included (and possibly overriden by all
                                # other flavors)
                                common:
                                    secret_key: 219349c5-7d00-4ebb-8a7d-318e68d473c3
                                    standalone: true

                                dev:
                                    storage: local
                                    storage_path: /data/tmp_registry
                                    loglevel: debug

                                prod:
                                    storage: local
                                    storage_path: /data/registry
                                    loglevel: info

                                    cache:
                                         host: localhost
                                         port: 6379
                                    cache_lru:
                                         host: localhost
                                         port: 6379
                                #########################################

                            #On créer un daemon:

                            > vim /etc/init.d/docker-registry

                                #########################################
                                #!/bin/bash

                                ### BEGIN INIT INFO
                                # Provides: docker-registry
                                # Required-Start: $network $remote_fs $syslog
                                # Required-Stop: $network $remote_fs $syslog
                                # Default-Start: 2 3 4 5
                                # Default-Stop: 0 1 6
                                # Short-Description: Start Docker-Registry
                                ### END INIT INFO

                                PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin

                                # check is we are running as root
                                [ $(id -u) -ne 0 ] && echo "must run as root, exiting" && exit 1

                                # a way to figure out a service home directory, no matter where it's called from
                                self_path="$(readlink -e $0)"

                                DOCKER_REGISTRY_HOME=/opt/docker-registry

                                # set defaults if they are not set by config
                                RUNAS=$(stat --format "%U" $self_path)          # defaults to user owning this init script
                                ACCESS_LOGFILE=/var/log/docker-registry/access.log  # will be chowned to $RUNAS
                                ERROR_LOGFILE=/var/log/docker-registry/error.log    # will be chowned to $RUNAS
                                LOGFILE=/var/log/docker-registry/docker-registry.log    # will be chowned to $RUNAS
                                PIDFILE=/var/run/docker-registry/docker-registry.pid    # path will created and chowned to $RUNAS
                                LISTEN_IP="127.0.0.1"
                                LISTEN_PORT=5000
                                GUNICORN_WORKERS=4

                                NAME="Docker Registry"
                                DAEMON="/usr/local/bin/gunicorn"
                                DAEMON_OPTS="-D --error-logfile ${ERROR_LOGFILE} --access-logfile ${ACCESS_LOGFILE} --log-file ${LOGFILE} --pid ${PIDFILE} --max-requests 500 --graceful-timeout 3600 -t 3600 -k gevent -b ${LISTEN_IP}:${LISTEN_PORT} -w ${GUNICORN_WORKERS:-2} docker_registry.wsgi:application"

                                RED='\e[0;31m'
                                GREEN='\e[0;32m'
                                YELLOW='\e[0;33m'
                                PURPLE='\e[0;35m'
                                NC='\e[0m'

                                if [[ -z "${DOCKER_REGISTRY_HOME}" ]]; then
                                    echo "DOCKER_REGISTRY_HOME is not set, update this \"$(readlink -e $0)\" script or set it in /etc/default/docker-registry , exiting.."
                                    exit 1
                                else
                                    cd $DOCKER_REGISTRY_HOME
                                fi

                                #Loggers
                                log_daemon_msg() { logger "$@"; }
                                log_end_msg() { [ $1 -eq 0 ] && RES=OK; logger ${RES:=FAIL}; }

                                start_server() {
                                    [ -d ${PIDFILE%/*} ] || mkdir -p ${PIDFILE%/*} || return 1
                                    chown -R $RUNAS ${PIDFILE%/*} || return 1
                                    touch $LOGFILE && chown $RUNAS $LOGFILE || return 1
                                    touch $ERROR_LOGFILE && chown $RUNAS $ERROR_LOGFILE || return 1
                                    touch $ACCESS_LOGFILE && chown $RUNAS $ACCESS_LOGFILE || return 1
                                    export SETTINGS_FLAVOR=prod
                                    export DOCKER_REGISTRY_CONFIG=/opt/docker-registry/config/config.yml
                                    RUN=`$DAEMON $DAEMON_OPTS`
                                    return $?
                                }

                                stop_server() {
                                    kill $(cat $PIDFILE)
                                    RETVAL=$?
                                    rm -f $PIDFILE
                                    return $RETVAL
                                }

                                reload_server() {
                                        kill -HUP $(cat $PIDFILE)
                                }

                                status_server() {
                                    if [ ! -r $PIDFILE ]; then
                                        return 1
                                    elif ( kill -0 $(cat $PIDFILE) 2>/dev/null); then
                                        return 0
                                    else
                                        rm -f $PIDFILE
                                        return 1
                                    fi
                                }

                                case $1 in
                                  start)
                                    if status_server; then
                                      /bin/echo -e "${NAME} is ${GREEN}already running${NC}" >&2
                                      exit 0
                                    else
                                    log_daemon_msg "Starting ${NAME}" "on port ${LISTEN_IP}:${LISTEN_PORT}"
                                      start_server
                                      sleep 1
                                      status_server
                                      log_end_msg $?
                                    fi
                                  ;;
                                  stop)
                                    if status_server; then
                                log_daemon_msg "Stopping ${NAME}" # "on port ${LISTEN_IP}:${LISTEN_PORT}"
                                      stop_server
                                      log_end_msg $?
                                    else
                                log_daemon_msg "${NAME}" "is not running"
                                      log_end_msg 0
                                    fi
                                  ;;
                                  restart)
                                    log_daemon_msg "Restarting ${NAME}" # "on port ${LISTEN_IP}:${LISTEN_PORT}"
                                    if status_server; then
                                stop_server && sleep 1 || log_end_msg $?
                                    fi
                                start_server
                                log_end_msg $?
                                  ;;
                                  reload)
                                    if status_server; then
                                log_daemon_msg "Reloading ${NAME}" # "on port ${LISTEN_IP}:${LISTEN_PORT}"
                                      reload_server
                                      log_end_msg $?
                                    else
                                log_daemon_msg "${NAME}" "is not running"
                                      log_end_msg 1
                                    fi
                                  ;;
                                  status)
                                   /bin/echo -en "${NAME} is.. " >&2
                                   if status_server; then
                                     /bin/echo -e "${GREEN}running${NC}" >&2
                                     exit 0
                                   else
                                     /bin/echo -e "${RED}not running${NC}" >&2
                                     exit 1
                                   fi
                                  ;;
                                  *)
                                    echo "Usage: $0 {start|stop|restart|reload|status}" >&2
                                    exit 2
                                  ;;
                                esac

                                exit 0
                                #########################################

                                > chmod +x docker-registry

                        Nginx
                        ``````````````````````````

                            > vim /etc/nginx/sites-available

                                #########################################
                                upstream docker-registry {
                                  server localhost:5000;
                                }

                                server {
                                  listen 443;
                                  server_name REPO_FQDN;

                                  ssl on;
                                  ssl_certificate /etc/ssl/certs/docker-registry.crt;
                                  ssl_certificate_key /etc/ssl/private/docker-registry.key;


                                  proxy_set_header Host             $http_host;   # required for docker client's sake
                                  proxy_set_header X-Real-IP        $remote_addr; # pass on real client's IP
                                  proxy_set_header Authorization    ""; # see https://github.com/dotcloud/docker-registry/issues/170

                                  client_max_body_size 0; # disable any limits to avoid HTTP 413 for large image uploads

                                  # required to avoid HTTP 411: see Issue #1486 (https://github.com/dotcloud/docker/issues/1486)
                                  chunkin on;
                                  error_page 411 = @my_411_error;
                                  location @my_411_error {
                                    chunkin_resume;
                                  }


                                  location / {
                                    auth_basic              "Restricted";
                                    auth_basic_user_file    docker-registry.htpasswd;

                                    proxy_pass http://docker-registry;
                                    proxy_set_header Host $host;
                                    proxy_read_timeout 900;
                                  }

                                  location /_ping {
                                    auth_basic off;
                                    proxy_pass http://docker-registry;
                                  }

                                  location /v1/_ping {
                                    auth_basic off;
                                    proxy_pass http://docker-registry;
                                  }
                                }
                                #########################################


                            #Génération du password
                            > htpasswd -bc /etc/nginx/docker-registry.htpasswd USERNAME PASSWORD

                        Certificats
                        ``````````````````````````
                            On récupère ses certificats et on les met au bon endroit:
                            > mv server.key /etc/ssl/private/docker-registry.key
                            > mv server.crt /etc/ssl/certs/docker-registry.crt

                            Si le certificat est signé avec une ca self-signed, il faut penser à la rajouter au niveau du magasin du client:

                            # méthode rapide: (mais ugly)
                            > cat ca.crt >> /etc/ssl/certs/ca-certificates.crt
                            #/!\ : voir tips ca pour importer la ca de façon plus propre avec update-ca-certificates
                            > cp ca.crt /usr/share/ca-certificates
                            > echo ca.crt >> /etc/ca-certificates.conf
                            > update-ca-certificates

                            > service docker restart #(en sudo)

                        Vérifications
                        ``````````````````````````

                            > curl -k -u USER:PASSWORD https://REPO_FQDN
                            > docker login https://REPO_FQDN

                            On peut ensuite utliser son repo:

                            > docker pull fooImages
                            > docker tag fooImages REPO_FQDN/REPO_NAME
                            > docker push REPO_FQDN/REPO_NAME

                            En cas d'erreur de connexion au login:

                                Coté serveur:

                                    Vérifier que les daemon nginx et registry docker soient bien démarrés.
                                    Vérifier les identifiants de connexion nginx (htpasswd)
                                    Vérifier son firewall et ses ports d'écoutes
                                    Redémarrer les services nginx et docker-registry en cas de doute

                                Coté client

                                    Vérifier que le service docker est bien up
                                    Exécuter les commandes en sudo
                                    Importer les certificats racines (ca et subca) en cas de certif auto-signés

                        Ajouter un search backend:
                        ``````````````````````````
                            http://tuhrig.de/docker-registry-rest-api/
                            https://registry.hub.docker.com/u/cloudaku/docker-registry-latest/
                                voir la section search

                            Interface web:
                                https://github.com/atc-/docker-registry-web

                            Exemple config:

                                common:
                                  search_backend: sqlalchemy
                                  sqlalchemy_index_database: sqlite:////tmp/docker-registry.db

                            Install de sqlalchemy:
                                http://docs.sqlalchemy.org/en/rel_0_9/intro.html#installation
                                easy_install SQLAlchemy
                                ou
                                pip install SQLAlchemy

                            Tests:
                                wget http://localhost:5000/v1/search?q=base

~~~~~~~~~~~~~~~~~~~~~~~~~~
ISSUES
~~~~~~~~~~~~~~~~~~~~~~~~~~

    __________________________
    Fichiers en read only type hosts ...

       -->  Fixed depuis la version 1.2 de docker

    __________________________
    Problème avec les services, par exemple si le service est lancé mais que toutes les commandes services failed:

        http://blog.deliverous.com/2015-01-03.start-stop-daemon.html

        -->  Lancez le conteneur avec l'option --cap-add

        fonctionne pour le service tomcat7 et plus précisément avec start-stop-daemon qui tente de lire dans /proc/%d/exec

        exemple:

            docker run --cap-add SYS_PTRACE -it -d -p 2222:22 -p 2323:23 -p 8000:80 -p 8001:8080 --name demo_prov prov:demo /bin/bash

                ou --cap-add=ALL

        Pour tomcat7:

            remplacer l'option --exec par --startas

    __________________________
    Envoyer une commande docker sur un conteneur:

        À ce jour (fevrier 2015), je n'ai pas trouvé de commande permetant de faire ça.

        Mais on peut envoyer des commandes aux conteneur avec la commande 'docker exec' ou modifier manuellement quelques config:

            Par exemple publier des ports:

                http://stackoverflow.com/questions/19897743/exposing-a-port-on-a-live-docker-container

                > docker inspect container_name | grep IPAddress
                > iptables -t nat -A  DOCKER -p tcp --dport 8001 -j DNAT --to-destination 172.17.0.19:8000

    __________________________
    Changer le hostname d'un conteneur déja runné:

        Stopper le conteneur et le daemon

            > docker stop CT_ID
            > service docker stop

        Modifification du hostname:

            > cd /var/lib/docker/containers/CT_ID
            > vim config.json

                Remplacer le hostname: "Hostname":"monHostname"

            > vim hostname

        Puis relancer les services:

            > service docker start
            > docker start CT_ID

    __________________________
    fs full au niveau de /var/ dû à la base mlocate :

        http://blog.cloud66.com/giant-mlocate-with-overlayfs/

        1) Edit the /etc/updatedb.conf file
        2) Amend the line PRUNEPATHS="...<<original content>>... /var/lib/docker".
        3) Manually regenerate locate index file by running sudo updatedb (eventually a cron task would have done this for us, but we wanted immediate results!)

    __________________________
    Lancer ssh sur un centos avec systemd :

        > /usr/bin/ssh-keygen -A
        > /usr/sbin/sshd -D -e

    __________________________
    ssh debug :

        Si on a une erreur du type :

            Connection closed by UNKNOWN
            ou encore
            No supported key exchange algorithms [preauth]

            1 : lancer le daemon ssh en foreground et en mode debug pour voir ce qu'il se passe :

                > /usr/sbin/sshd -D -d

            2 : Niveau config sshd :

                > vim /etc/sshd_config

                    #Path vers les clés serveurs (en fonction du protocol)
                    HostKey /etc/ssh/ssh_host_key
                    HostKey /etc/ssh/ssh_host_rsa_key

                    #Acces root
                    PermitRootLogin yes

                    UsePam yes
                    PasswordAuthentication yes

            3 : Générer les clés si elles n'existent pas (ne pas mettre de password) :

                > cd /etc/ssh
                > ssh-keygen -t ed25519 -f ssh_host_ed25519_key
                > ssh-keygen -t rsa -b 4096 -f ssh_host_rsa_key

            4 : Assurez vous que l'utilisateur ou root a bien un password :

                > passwd root

            5 : Relancer le daemon :

                #via supervisor ou en mode debug :
                > supervisorctl restart sshd

            6 : Retantez de vous connectez

                Note : s'arrurer que le port du conteneur est bien exposé :

                    > docker port $container_id 22
                    #ou via un nmap

            7 : Si le problème persiste, vérifiez aussi que tous les packages soient bien installés :
                - libssh ?
                - pam_ssh_agent_auth ?
                ...

Docker-Compose
---------------------

[docker compose overview](https://docs.docker.com/compose/overview/)
[docker gettingstarted](https://docs.docker.com/compose/gettingstarted/)

Permet de builder facilement un set de conteneurs définissant une application.
La communication entre conteneur est assurée via le socket : hostname:port.
L'IP des conteneurs pouvant varier si l'on utilise le réseau docker.

**Ordre de définition d'une application :**

1. Définition du DockerFile.
2. Définition des services composant l'application.
3. Lancer docker-compose pour créer le set de conteneurs.

### Installation

    sudo su -
    curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

On peut aussi le faire via pip (>6.0) :

     pip install docker-compose

### Création d'une application avec docker-compose

**Le projet**

    mkdir myApp_composed

**Création des images**

Les images peuvent être crées au préalable, il est aussi possible de mettre un dockerfile dans son projet et de rajouter le mot clé 'build'
dans son fichier docker-compose.yml au niveau du service concerné.
Dans ce cas on pourra faire pointer un service vers un Dockerfile pour qu'il créer l'image en question.

Exemple :

    vim Dockerfile

<!-- vim -->

    FROM debian
    ADD
    WORKDIR
    RUN
    CMD

**Définition des services**

On définit dans un fichier "docker-compose.yml" toutes les images qui définissent notre application. En y renseignant les ports publiés, si il faut builder ou non l'image et les hostnames des conteneurs.

Exemple :

    vim docker-compose.yml

<!-- vim -->

    version: '2'
    services:
      web:
        build: .
        ports:
         - "5000:5000"
        volumes:
         - .:/code
        depends_on:
         - redis
      redis:
        image: redis

**Build des conteneurs**

    docker-compose up

**Côté réseau**

Si on utilise le sous-réseau par défaut de docker,
on utilisera les hostnames définis au niveau du docker-compose.yml.

### Quelques commandes utiles

**Lancer les services en background**

    docker-compose up -d

**Voir les set de conteneurs actifs**

    docker-compose ps

**Lancer une commande dans un service**

    docker-compose run web env

**Stopper les services**

    docker-compose stop

Docker Swarm
---------------------

Docker swarm permet d'apporter de la HA en créant un cluster de conteneurs.

### Installation

Docker Notary
---------------------
