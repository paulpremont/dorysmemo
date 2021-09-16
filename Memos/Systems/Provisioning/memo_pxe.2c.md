==========================================================
                       P X E
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Général :

        http://www.syslinux.org/wiki/index.php/PXELINUX
        https://help.ubuntu.com/community/Installation#head-b751f1c9b3b4e0c27d6bc8828a831de92eb57a70

    LocalNet (Net install) :

        https://help.ubuntu.com/community/Installation/LocalNet
        https://help.ubuntu.com/community/PXEInstallServer

    Installer un LiveCD over PXE :

        https://wiki.ubuntu.com/LiveCDNetboot
        http://doc.ubuntu-fr.org/personnaliser_livecd
        http://doc.ubuntu-fr.org/netboot_live

    Preseed

        https://www.debian.org/releases/stable/i386/apb.html
        https://www.debian.org/releases/squeeze/example-preseed.txt

        https://help.ubuntu.com/community/Cobbler/Preseed
        http://searchitchannel.techtarget.com/feature/Performing-an-automated-Ubuntu-install-using-preseeding
        http://saz.sh/2011/07/30/preseed-debian-squeeze-using-pxe/
        
    Understanding PXE:

        https://docs.oracle.com/cd/E24628_01/em.121/e27046/appdx_pxeboot.htm#EMLCM12200

    Tutos :

        http://wiki.centos.org/HowTos/PXE/PXE_Setup
        http://chschneider.eu/linux/server/tftpd-hpa.shtml
        http://doc.ubuntu-fr.org/netboot
        https://www.howtoforge.com/ubuntu-14.10-pxe-server-installation
        http://www.ossramblings.com/deploy-ubuntu-14.04-trusty-desktop-pxe
        http://www.tecmint.com/add-ubuntu-to-pxe-network-boot/
        https://clinta.github.io/Automated-PXE-Ubuntu-Installs/


    Installer un serveur PXE sur un Docker :

        https://jpetazzo.github.io/2013/12/07/pxe-netboot-docker/

    Centraliser le boot via une image et un montage NFS :

        https://help.ubuntu.com/community/Desktop/PXE

    Kickstart

        https://help.ubuntu.com/community/KickstartCompatibility

    Repo :

        http://techblog.glendaleacademy.org/ubuntu-10-04/pxe-boot-network-install-repository-server
        http://ubuntuforums.org/showthread.php?t=1090731

    Projects :

        http://sourceforge.net/projects/oneclickkick/
        http://sourceforge.net/projects/qfpxeinstaller/
        http://sourceforge.net/projects/erpxe/?source=typ_redirect

        Un projet open source qui a l'air le plus prometteur :

            http://cobbler.github.io/

    CustomCD :

        https://help.ubuntu.com/community/InstallCDCustomization
        https://help.ubuntu.com/community/InstallCDCustomization/Scripts
        http://askubuntu.com/questions/520543/installing-14-04-from-ubuntu-14-04-desktop-amd64-iso-with-pxe

    Voir aussi :

        Le projet iPXE :
            http://linuxfr.org/news/presentation-d-ipxe-un-chargeur-d-amorcage-en-pxe

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    PXE,  pour Pre-boot eXecution Environment, permet à une machine de démarrer depuis le réseau.

    Le serveur va pouvoir diffuser un OS à des machines clientes pour qu'ils puissent les installer.

    Le boot over PXE permet aussi de centraliser le lancement d'une iso depuis le réseau par l'intérmédiaire de montage NFS par exemple.

    Les composants usuels d'un serveur PXE sont:

        - DHCP/BOOTP : pour la diffusion des IP
        - TFTP : pour la diffusion du kernel linux et de la configuration (kickstart)
        - HTTP/FTP : pour la diffusion des packages/sources
        - DNS : pour la translation d'adresse (optionnel)
        - NFS : pour les chargement centralisés d'une image (optionnel)
                ou le partage de fichiers (peut remplacer FTP ou HTTP)

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Etapes de fonctionnement
        --------------------------

            1 : boot de la machine cliente
            2 : Requête DHCP vers le serveur
            3 : Envoies de l'IP, DNS ... + target vers l'image de boot (pxelinux.0) au client
            4 : Connexion avec le serveur TFTP pour récupérer l'image
            5 : Envoie de l'image au client
            6 : Récupération de la configuration dans le dossier pxelinux.cfg comme suite:
                
                - Fichier ayant le nom de la MAC address de la VM avec '01' comme premier id
                    Exemple: 01-45-00-98-23-51-fx (en minuscule)

                - Si il ne trouve pas, il regarde en fonction de l'IP (en hexa)
                    Exemple: C000025B pour l'IP: 192.0.2.91

                - Si il ne trouve pas, il essaye en enlevant le dernier caractère hexa 
                    Exemple: C000025 puis C00002, C0000, C000 ...

                - Enfin si il ne trouve toujours pas, il chargera 'default'

            7 : Le client télécharge tous les fichiers (kernel + root fs) et les charges.
            8 : Chargement du Kickstart pour la conf de la machine.
                Ce fichier kickstart est renseigné dans le fichier de conf de pxelinux.cfg

        --------------------------
        L'image, Les fichiers
        --------------------------

            Pour que le chargement de l'image ait lieu, il faut qu'elle comporte :

                - d'un kernel [ex: vmlinuz.efi]
                - d'un initrd (INITial RamDisk), l'image minimal de l'OS initialisée au démarrage. [ex: initrd.lz]
                - idéalement d'un kickstart (configuration de l'image pour ne pas saisir manuellement les informations à saisir lors de linstallation)
                - un squashFS contenant le FS du systeme
                - des packages : Pour l'installation des composants logiciels de l'OS

            Arborescence sur le TFTP :

                pxelinux.0 : Fichier de démarrage
                pxelinux.cfg : dossier contenant le menu de démarrage
                ubuntu-installer : dossier contenant les fichiers ubuntu

        --------------------------
        Les différentes ISO
        --------------------------
                __________________________
                Ubuntu :

                    Ubuntu nous livre plusieurs types d'iso et en fonction de celle-ci, la manière de booter over PXE peut changer.

                    Voici une liste des types d'iso fournits :

                        - Netboot : Cette dernière est facilement configurable via un kickstart par exemple, et necessite un mirroir (local ou externe) pour installer ses packages.

                        - Minimal : Cette iso ressemble de près à la Netboot mais propose en plus une selection du desktop à installer

                        - LiveCD (client desktop): les nouvelles version ne sont maintenues qu'en version Live CD. (> 12.04)
                            Ce qui oblige, pour le moment, à utiliser NFS pour installer son système.
                            Note :
                                Il semble qu'il soit difficilement configurable (modification du live à faire à sa convenance)
                                Pas de kickstart possible via le réseau. (ou à confirmer)

                        - Server : Cette version comprend un dossier d'install pour PXE.
                            Il est donc facilement installable via PXE.
                            Il est possible de récupérer tous les packages présent dans /pool (+ le dists pour que le miroir soit fonctionnel)
                            On peut par exemple s'en servir comme point de départ et installer le desktop que l'on souhaite via le kickstart.

                        - Alternate : Cette version n'est plus maintenue sur les nouvelles versions desktop d'ubuntu (s'arrête à la 12.04 au moment ou j'écrit).
                            Pratique aussi pour le boot PXE car elle contient elle aussi tous les packages à installer pour constituer son propre miroir.

        --------------------------
        Preseed / Kickstart
        --------------------------

            Toutes les options possibles de l'installation peuvent être représentées par des variables.
            On peut configurer ses variables dans un fichier et les présenter à l'installeur pour automatiser l'installation.

            Ces variables peuvent être configurer de deux manières :

                - preseed           #initialement porté par Debian
                - kickstart         #initialement porté par RedHat (kickseed pour Ubuntu)

                Il convient d'utiliser les deux méthodes pour Ubuntu (mais pas obligatoirement)
                kickstart ne couvre pas intégralement les options proposées par preseed et vis versa.

            Elles concernent à la fois la réponses par défaut aux options de l'installateur mais aussi celles des packages qui seront installés.

                __________________________
                preseed

                        les méthodes de preseeding
                        ``````````````````````````

                            Selon la méthode de preseeding choisie, le point de chargement du fichier preseed n'est pas effectué au même moment :
                            Dans l'ordre :

                                - via initrd : Au début de l'installation, avant la première question.
                                - via file : Après le chargement de l'image
                                - via network : Une fois que la configuration réseau a été faite.

                            Il existe le paramètre 'auto' pour temporiser l'installation et attendre que la configuration réseau soit faite.


                __________________________
                kickstart
                
~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        DHCP/BOOTP
        --------------------------

            > apt-get install isc-dhcp-server

        --------------------------
        TFTP
        --------------------------

            > apt-get install tftpd-hpa

        --------------------------
        DNS
        --------------------------

            > apt-get install bind9

        --------------------------
        HTTP
        --------------------------

            > apt-get install nginx apt-mirror

        --------------------------
        Kickstart
        --------------------------

            Sur une machine avec un environnement graphique :

                > apt-get install system-config-kickstart

                En cas d'erreur au lancement de cette commander, essayer :

                    > apt-get remove hwdata
                    > wget ftp://mirror.ovh.net/mirrors/ftp.debian.org/debian/pool/main/h/hwdata/hwdata_0.234-1_all.deb
                    > sudo dpkg -i  hwdata_0.234-1_all.deb
                    > sudo apt-get install system-config-kickstart

        --------------------------
        NFS : pour les installations liveCD
        --------------------------

            > apt-get install nfs-kernel-server nfs-common rpcbind

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        DHCP/BOOTP
        --------------------------
                __________________________
                Ajout d'un hôte :


                    > vim /etc/dhcp/dhcpd.conf

                        ddns-update-style none;
                        option domain-name "local";
                        option domain-name-servers 172.17.0.2;
                        default-lease-time 600;
                        max-lease-time 7200;
                        authoritative;
                        log-facility local7;

                        # PXE
                        allow booting;
                        allow bootp;
                        option option-128 code 128 = string;
                        option option-129 code 129 = text;

                        subnet 172.17.0.0 netmask 255.255.0.0 {

                            range 172.17.0.20 172.17.0.30;

                            option routers 172.17.0.2;
                            option broadcast-address 172.17.255.255;

                            #Ip du TFTP :
                            next-server 172.17.0.2;

                            #à mettre à la racine du TFTP :
                            filename "pxelinux.0";
                            
                            # évalue si l'adresse est déjà attribuée
                            ping-check = 1;

                        }

        --------------------------
        TFTP
        --------------------------
                __________________________
                Daemon :

                    En mode daemon (sans passer par inetd) :

                        > vim /etc/default/tftpd-hpa

                            TFTP_USERNAME="tftp"
                            TFTP_DIRECTORY="/srv/tftp"
                            TFTP_ADDRESS="0.0.0.0:69"
                            TFTP_OPTIONS="--secure"
                            RUN_DAEMON="yes"

                        > service tftpd-hpa restart

                __________________________
                Test client :

                    > apt-get install tftp
                    > tftp 172.17.0.2
                    > get foo
                    > quit

                    /!\ au firewall en place 

                __________________________
                Fichiers d'amorçage :

                    Les fichiers d'amorçage via PXE sont :

                        - Le fichier NBP (Network Bootstrap Program) :
                            Ce fichier sert comme premier amorçage et décrit la pile PXE. Il va lancer la deuxième phase d'amorçage.

                            Note :

                                Le projet iPXE se passe de ce fichier et charge directement le noyau. 

                        - la configuration du menu de démarrage PXE :
                            Avec les éléments à afficher sur les postes clients.

                        - le noyau linux :
                            Fournit la communication materielle mais en premier lieu, il monte l'initrd 

                        - l'initrd :
                            Contient l'image minimale de linux
                            Determine les modules à charger pour communiquer avec le materiel.


                    Les noms de fichiers communs :

                        - NBP :                 [pxelinux.0]
                        - configuration PXE :   [pxelinux.cfg] avec souvent [boot-screens]
                        - le noyau :            [linux] ou [vmlinuz]
                        - l'initrd :            [initrd.gz]


                    Il est possible d'avoir ces fichiers de plusieurs manières :

                        via syslinux :
                        ``````````````````````````

                            Il devrait être possible de récupérer les fichiers suivant via le paquet syslinux :

                            > apt-get install syslinux pxelinux
                            > cp /usr/lib/PXELINUX/pxelinux.0 /srv/tftp

                                Copier aussi les fichiers suivant de /usr/lib/syslinux

                                    menu.c32
                                    memdisk
                                    mboot.c32
                                    chain.c32

                        via une archive netboot 
                        ``````````````````````````

                            Avec le netboot d'ubuntu :

                                voir : http://cdimage.ubuntu.com/netboot

                                Exemple avec la version trusty d'ubuntu :

                                    > cd /srv/tftp
                                    > wget http://archive.ubuntu.com/ubuntu/dists/trusty-updates/main/installer-amd64/current/images/netboot/netboot.tar.gz
                                    > tar -xvf

                                On devrait avoir une arborescence de se type (selon votre version) :
                                Celle ci a été prise sur une 14.04.

                                    |-- netboot.tar.gz
                                    |-- pxelinux.0 -> ubuntu-installer/amd64/pxelinux.0
                                    |-- pxelinux.cfg -> ubuntu-installer/amd64/pxelinux.cfg
                                    |-- ubuntu-installer
                                    |   `-- amd64
                                    |       |-- boot-screens
                                    |       |   |-- adtxt.cfg
                                    |       |   |-- exithelp.cfg
                                    |       |   |-- f1.txt
                                    |       |   |-- f10.txt
                                    |       |   |-- f2.txt
                                    |       |   |-- f3.txt
                                    |       |   |-- f4.txt
                                    |       |   |-- f5.txt
                                    |       |   |-- f6.txt
                                    |       |   |-- f7.txt
                                    |       |   |-- f8.txt
                                    |       |   |-- f9.txt
                                    |       |   |-- menu.cfg
                                    |       |   |-- prompt.cfg
                                    |       |   |-- rqtxt.cfg
                                    |       |   |-- splash.png
                                    |       |   |-- stdmenu.cfg
                                    |       |   |-- syslinux.cfg
                                    |       |   |-- txt.cfg
                                    |       |   `-- vesamenu.c32
                                    |       |-- initrd.gz
                                    |       |-- linux
                                    |       |-- pxelinux.0
                                    |       `-- pxelinux.cfg
                                    |           `-- default -> ../boot-screens/syslinux.cfg
                                    `-- version.info

                        via une ISO Server
                        ``````````````````````````

                            /!\ sur les versions desktop actuelles il se peut que le dossier d'install ne soit pas présent.
                            Dans ce cas, on a surement affaire à une version LiveCD s'appuyant sur casper (voir la section suivante)

                            Sinon, Exemple avec ubuntu serveur :

                                > mount -o loop ubuntu-14.04.2-server-amd64.iso /mnt/ubuntu
                                > cp -a /mnt/ubuntu/install/netboot/* /srv/tftp/

                            Vérifiez que l'inird (initrd.gz) et le noyau (linux) sont bien présent dans le dossier.

                                Ex: 
                                    /srv/tftp/ubuntu-installer/amd64/linux
                                    /srv/tftp/ubuntu-installer/amd64/initrd.gz

                            Il faudra aussi récupérer le squashfs :

                                > cp -a /mnt/ubuntu/install/filesystem.squashfs /var/www/ubuntu

                        via une ISO Desktop
                        ``````````````````````````
                            todo

                        via une ISO LiveCD
                        ``````````````````````````

                            Monter le liveCD :

                                > mount -o loop ubuntu-14.04.2-desktop-amd64.iso /mnt/ubuntu
                                
                            Copier les fichiers d'installation dans le dossier tftfp :

                                > mkdir /srv/tftp/ubuntu1404
                                > cp -a /mnt/ubuntu/casper /srv/tftp/ubuntu1404

                                casper/
                                ├── filesystem.manifest
                                ├── filesystem.manifest-remove
                                ├── filesystem.size
                                ├── filesystem.squashfs
                                ├── initrd.lz
                                └── vmlinuz.efi

                                Ces fichiers suffirons à lancer le live sur le poste client

                            Il faudra récupérer les fichiers NBP et de config PXE depuis le package syslinux :

                                > apt-get install syslinux
                                ou depuis une version netboot, server ...

                                à savoir :
                                    
                                    - pxelinux.0
                                    - pxelinux.cfg

                __________________________
                Configuration du menu PXE :

                    > vim /srv/tftp/ubuntu-installer/amd64/boot-screens/txt.cfg

                        Exemple : Server Ubuntu over HTTP :
                        ``````````````````````````

                            > cat /srv/tftp/ubuntu-installer/amd64/boot-screens/txt.cfg

                            default install
                            label install
                                menu label ^Install
                                menu default
                                kernel ubuntu-installer/amd64/linux

                                #Default append :
                                #append vga=788 initrd=ubuntu-installer/amd64/initrd.gz -- quiet 

                                #Append with kickstart :
                                #append vga=normal ks=http://192.168.200.1/ubuntu/ks.cfg initrd=ubuntu-installer/amd64/initrd.gz live-installer/net-image=http://192.168.200.1/ubuntu/filesystem.squashfs --

                                #Append with preseed :
                                append vga=normal auto=true priority=critical preseed/url=http://192.168.200.1/ubuntu/preseed.cfg initrd=ubuntu-installer/amd64/initrd.gz live-installer/net-image=http://192.168.200.1/ubuntu/filesystem.squashfs --

                            label cli
                                menu label ^Command-line install
                                kernel ubuntu-installer/amd64/linux
                                append tasks=standard pkgsel/language-pack-patterns= pkgsel/install-language-support=false vga=788 initrd=ubuntu-installer/amd64/initrd.gz -- quiet 


                            ***
                            Sur une version serveur, il ne faut pas oublier l'option 'live-installer' et y renseigner le quashfs.
                            Squashfs : fait référence au FS dans un format compréssé.

                                Pour voir son contenu : 

                                    > apt-get install squashfs-tools
                                    > mkdir /mnt/squashfs
                                    > mount -t squashfs filesystem.squashfs /mnt/squashfs

                                    ou

                                    > sudo unsquashfs filesystem.squashfs
                            ***

                        Exemple over NFS :
                        ``````````````````````````

                            LABEL ubuntu1404
                                MENU LABEL Ubuntu Live (ubuntu1404) 
                                KERNEL /ubuntu1404/casper/vmlinuz.efi
                                APPEND initrd=/ubuntu1404/casper/initrd.lz boot=casper netboot=nfs nfsroot=192.168.200.1:/srv/tftp/ubuntu1404 quiet splash locale=fr_FR bootkbd=fr console-setup/layoutcode=fr --
                                IPAPPEND 2

                        Note sur la syntaxe du menu PXE :
                        ``````````````````````````

                            Label : fait référence aux choix proposés via l'interface de l'installeur .

        --------------------------
        NFS - Live CD
        --------------------------

            Cette section concerne surtout les live CD mais le partage NFS peut aussi être utilisé si l'on veux monter un système directement depuis le réseau.
            La doc nous oriente vers l'utilisation de NFS pour les versions Live CD.

            Il faut rendre accessible le dossier contenant tout les fichiers d'install présent sur le tftp :

            Exemple :

                > vim /etc/exports

                    /srv/tftp/ubuntu1404   *(ro,sync,no_subtree_check)

                > service rpcbind start
                > service service nfs-kernel-server restart

                            
        --------------------------
        HTTP
        --------------------------

                __________________________
                rajouter le support du parcours des dossiers pour nginx :

                    > vim /etc/nginx/sites-available/default

                        location / {
                            ...
                            autoindex on;
                        }

                    > service nginx restart

                __________________________
                Proposer son propre mirroir :


                        Via le CD d'installation Alternate :
                        ``````````````````````````
                            On copie les sources au niveau du vhost :

                                > mkdir /var/www/html/ubuntu
                                > wget http://releases.ubuntu.com/14.04.2/ubuntu-14.04.2-desktop-amd64.iso
                                > mount -o loop ubuntu-14.04.2-desktop-amd64.iso /mnt
                                > cp -R /mnt/* /var/www/html/ubuntu

                            Note :

                                C'est les dossier pool et dists qui nous interessent avec :

                                    pool : les packages disponibles
                                    dists : la descriptions des packages avec leurs dépendances

                            Voir ISSUE_PACKAGE_FROM_CD


                        Via les nouvelles iso Desktop :
                        ``````````````````````````
                            
                            Depuis la version 14.04, il n'y a plus de CD Alternate.
                            Il faut donc finter avec l'iso server.



                        Via apt-mirror :
                        ``````````````````````````

                            Configurer apt-mirror :

                                > vim /etc/apt/mirror.list

                                #Ubuntu 14.04 :

                                    deb http://fr.archive.ubuntu.com/ubuntu/ trusty main restricted
                                    deb http://security.ubuntu.com/ubuntu trusty-security main restricted
                                    deb http://fr.archive.ubuntu.com/ubuntu/ trusty-updates main restricted

                            Lancer le script :

                                > apt-mirror

                            Via la cron :

                                Décommenter :

                                    > vim /etc/cron.d/apt-mirror

                                        0 4 * * *   apt-mirror  /usr/bin/apt-mirror > /var/spool/apt-mirror/var/cron.log

                            On créer ensuite un lien vers le vhost :

                                > ln -s /var/spool/apt-mirror/mirror/MON_MIRROIR/ubuntu/ ubuntu

                        Via aptly :
                        ``````````````````````````

                            Voir memo aptly
                            Il suffira ensuite de faire un lien vers le dossier public de aptly.

                            /!\ Le problème se trouvera au niveau de la clé gpg.
                            Il faudrait importer la clé gpg au niveau de l'image

                __________________________
                Générer le package.gz : 

                    Pour générer la liste des packages présent dans son pool et leurs dépendances :

                    Ajouter ses packages dans le pool 

                    puis regénérer le package.gz :

                        > dpkg-scanpackages poolfolder  /dev/null |gzip -9c >  distsfolder/Packages.gz

        --------------------------
        Preseed
        --------------------------
                __________________________
                Créer son preseed :

                    Pour créer son fichier preseed, il est possible de récupérer des exemples sur le net :

                        https://help.ubuntu.com/12.04/installation-guide/example-preseed.txt
                        https://www.debian.org/releases/squeeze/example-preseed.txt

                    Et/Ou de compléter avec le preseed d'une distribution fraichement installée :

                        debconf-get-selections --installer > preseed.cfg
                        debconf-get-selections >> preseed.cfg

                    /!\ ne pas s'appuyer uniquement sur le preseed généré par debconf.
                    Il faut l'éditer et supprimer une bonne partie des variables inutiles.

                __________________________
                Appliquer son presseed :

                    Le preseed devra être accessible par exemple via http.

                    Pour l'utiliser avec les options de boot :

                        auto=true priority=critical preseed/url=http://192.168.200.1/ubuntu/preseed.cfg 

                    auto et critical sont nécessaires pour temporiser les question avant que la configuration réseau soit établie.

                    Note :

                        Pour les anciennes version, seul le paramètre auto est nécessaire.

                        à la place (par exemple) pour un CD :

                            file=/cdrom/preseed/ ubuntu-server.seed 

                        Pour kickstart, il semble que ces options ne soient pas nécessaires.

                    Il est possible de passer par le DHCP pour fournir le fichier preseed :
                    à placer dans son range par exemple :

                        if substring (option vendor-class-identifier, 0, 3) = "d-i" {
                            filename "http://192.168.200.1/ubuntu/preseed.cfg";
                        }

                        Il faut quand même spécifier dans la config de l'installer la variable preseed :

                            preseed/url=foo

                __________________________
                Exemple de preseed :

                    ## Options to set on the command line

                    ### Localization
                    d-i debian-installer/locale string fr_FR

                    ### Time
                    d-i clock-setup/utc boolean true
                    # /usr/share/zoneinfo/ for valid values.
                    d-i time/zone string Europe/Paris
                    d-i clock-setup/ntp boolean true
                    #d-i clock-setup/ntp-server string ntp.example.com

                    ### Keyboard selection.
                    d-i console-keymaps-at/keymap select fr
                    d-i keyboard-configuration/xkb-keymap select fr

                    ### Network
                    d-i netcfg/choose_interface select auto
                    d-i netcfg/get_hostname string unassigned-hostname
                    d-i netcfg/get_domain string unassigned-domain
                    d-i netcfg/wireless_wep string

                    ### Mirror settings
                    d-i mirror/country string manual
                    d-i mirror/http/hostname string 192.168.200.1
                    d-i mirror/http/directory string /ubuntu
                    d-i mirror/http/proxy string

                    ### APT
                    d-i apt-setup/restricted boolean false
                    d-i apt-setup/universe boolean false
                    d-i apt-setup/backports boolean false
                    d-i apt-setup/proposed boolean false
                    d-i apt-setup/security_host string
                    #d-i apt-setup/local0/repository string http://X.X.X.X/ubuntu/extra trusty main
                    #d-i apt-setup/local0/key string http://X.X.X.X/ubuntu/gpgkey.pub
                    #d-i apt-setup/local0/source boolean false
                    #d-i debian-installer/allow_unauthenticated boolean true

                    ### PARTITIONS
                    d-i partman-auto/method string lvm
                    d-i partman-lvm/device_remove_lvm boolean true
                    d-i partman-md/device_remove_md boolean true
                    d-i partman-lvm/confirm boolean true
                    d-i partman-auto/choose_recipe select atomic

                    d-i partman-partitioning/confirm_write_new_label boolean true
                    d-i partman/choose_partition select finish
                    d-i partman/confirm boolean true
                    d-i partman/confirm_nooverwrite boolean true

                    ### USER
                    d-i passwd/make-user        boolean true
                    d-i passwd/user-fullname    string advanced
                    d-i passwd/username string advanced
                    # Généré avec mkpasswd :
                    d-i passwd/user-password-crypted    password $1$2M9TK
                    d-i passwd/user-uid string
                    d-i user-setup/allow-password-weak  boolean false
                    d-i user-setup/encrypt-home boolean false
                    d-i passwd/user-default-groups      string adm cdrom dialout lpadmin plugdev sambashare

                    ### PKGS
                    d-i pkgsel/include string openssh-server curl
                    d-i pkgsel/upgrade  select safe-upgrade
                    #ou
                    #d-i pkgsel/update-policy select unattended-upgrades

                    ### Scripts
                    d-i preseed/late_command string chroot /target sh -c "/usr/bin/curl -o /tmp/postinstall.sh http://X.X.X.X/ubuntu/postinstall.sh && /bin/sh -x /tmp/postinstall.sh"
                __________________________
                Exemple de partitionnement :

                    https://wikitech.wikimedia.org/wiki/PartMan

                        *********************************
                        d-i partman-auto/disk string /dev/sda

                        d-i partman-auto/method string lvm

                        d-i partman-lvm/device_remove_lvm boolean true
                        d-i partman-md/device_remove_md boolean true
                        d-i partman-lvm/confirm boolean true
                        d-i partman-lvm/confirm_nooverwrite boolean true

                        d-i partman-auto/init_automatically_partition \
                            select Guided - use entire disk and set up LVM

                        d-i partman-auto-lvm/guided_size string max
                        d-i partman-auto-lvm/new_vg_name string vg00

                        d-i partman-auto/expert_recipe string                         \
                              boot-root ::                                            \
                                      64 128 128 ext3                                 \
                                              $primary{ } $bootable{ }                \
                                              method{ format } format{ }              \
                                              use_filesystem{ } filesystem{ ext4 }    \
                                              mountpoint{ /boot }                     \
                                      .                                               \
                                      128 512 200% linux-swap                         \
                                              method{ swap } format{ }                \
                                      .                                               \
                                      1024 1024 1000000 ext4                          \
                                              method{ format } format{ } $lvmok{ }    \
                                              use_filesystem{ } filesystem{ ext4 }    \
                                              mountpoint{ / }                         \
                                      .                                               \

                        d-i partman/default_filesystem string ext4

                        d-i partman/confirm_write_new_label boolean true
                        d-i partman/choose_partition select finish
                        d-i partman/confirm boolean true
                        d-i partman/confirm_nooverwrite boolean true
                        *********************************

                    Avec comme syntaxe :

                        3000 5000 8000 ext3 $primary{ } $bootable{ } method{ format } format{ } use_filesystem{ } filesystem{ ext3 } mountpoint{ / }
                        3000: minumum size of partition in mb
                        5000: priority if it and other listed partitions are vying for space on the disk (this is compared with the priorities of the other partitions)
                        8000: maximum size of partition in mb (80GB; this is for 80GB disks, which the apaches all have.)
                        ext3: filesystem type
                        $primary{ }: this is a primary, not logical partition
                        $bootable{ }: this is a bootable partition
                        method{ format }: set to format to format the partition, to "keep" to not format, and to "swap" for swap partitions
                        format{ }: also needed so the partition will be formatted
                        use_filesystem{ }: this partition will have a filesystem on it (it won't be swap, lvm, etc)
                        filesystem{ ext3 }: what filesystem it gets
                        mountpoint{ / }: where it's mounted

        --------------------------
        Kickstart
        --------------------------

            Pour automatiser l'installation de l'image, kickstart permet de configurer les éléments de bases.
                __________________________
                Créer son kickstart :

                    Il est possible de le créer via l'interface graphique :

                        > system-config-kickstart

                    Il faut ensuite configurer les partitions, la langue ...

                    Et enregistrer le fichier ks.cfg

                __________________________
                Appliquer son kickstart :

                    Copier le fichier ks à la racine de son tftp 

                        > cp ks.cfg /var/www/html/ubuntu

                    En fonction de sa version d'ubuntu :

                        > vim /srv/tftp/pxelinux.cfg/default

                            label linux
                                ...
                                kernel ubuntu-installer/amd64/linux
                                append ks=http://192.168.200.1/ubuntu/ks.cfg ...

                __________________________
                Exemple de kickstart :

                    #Generated by Kickstart Configurator
                    #platform=AMD64 or Intel EM64T

                    #System language
                    lang en_US
                    #Language modules to install
                    langsupport en_US
                    #System keyboard
                    keyboard fr
                    #System mouse
                    mouse
                    #System timezone
                    timezone --utc America/New_York
                    #Root password
                    rootpw --disabled
                    #Initial user
                    user advanced --fullname "advanced" --iscrypted --password $1$R7UlZnOr$Ok2f4LzEJrAgRtPSQzlrW.
                    #Reboot after installation
                    reboot
                    #Use text mode install
                    text
                    #Install OS instead of upgrade
                    install
                    #Use Web installation
                    url --url http://192.168.200.1/ubuntu
                    #System bootloader configuration
                    bootloader --location=mbr 
                    #Clear the Master Boot Record
                    zerombr yes
                    #Partition clearing information
                    clearpart --all --initlabel 
                    #Disk partitioning information
                    part swap --recommended 
                    part / --fstype ext4 --size 1 --grow --asprimary 
                    #System authorization infomation
                    auth  --useshadow  --enablemd5 
                    #Network information
                    network --bootproto=dhcp --device=eth0
                    #Firewall configuration
                    firewall --disabled 
                    #Do not configure the X Window System
                    skipx
                    %packages
                    wget
                    openssh-server

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Démarrer un client PXE
        --------------------------
            
            Allez dans le bios et activer le démarrage par le réseau
            Idem pour une VM, exemple avec virtualbox,
                > System / Boot order / Network en premier choix.

            Ne pas oublier de le désactiver après que l'install soit terminée.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Toubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Erreur Package From CD
        --------------------------

            Erreur à résoudre :

                The installer Failed to download from the mirror ...

                (Serveur web fonctionnel et fichiers accessibles over http ...)

                Ouvrir une console pendant l'install et voir les log (/var/log/syslog)

                    => Problème au niveau du package libc6-udeb

                La liste des packages à installer est dans le fichier :

                    > /var/www/html/ubuntu/casper/filesystem.manifest ??

                L'ISO n'a pas tout ces paquets , il faut passer par la méthode apt-mirror par exemple pour créer un vrai mirroir en local.

                ou creuser ..

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
