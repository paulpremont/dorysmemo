==========================================================
                       A R C H  L I N U X
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://wiki.archlinux.fr
    https://wiki.archlinux.org

    
    Memos/Tutos:

        http://blog.portnumber53.com/2012/10/30/archlinux-installing-on-gptlvmgrub-2-no-installer/
        https://gist.github.com/rbellamy/3730750
        http://mart-e.be/post/2013/01/14/archlinux-avec-luks-et-lvm-sur-un-ssd/

    Chiffrement:


~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation live cd
~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://wiki.archlinux.fr/Installation

        --------------------------
        Récupération de l'image
        --------------------------
                __________________________
                Checksum

        --------------------------
        Boot sur le live
        --------------------------
                __________________________
                UEFI:

                    https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface

                    /!\ désactiver secure boot
                    Si vous disposer d'un UEFI à la place d'un BIOS, 
                    rajouter l'option de boot en mode 'compatible' si vus bootez sur du MBR au lieu de GPT.



                    /!\ Pour accéder à tous les modules et variables EFI, il faut s'assurer de booter en mode EFI sur le live usb. 
                        Sinon cela impactera le chargement de certain modules et par exemple de ne pas avoir efivars de chargé dans /sys/firmware/efi

                        Au niveau du BIOS si on a activer le mode boot legacy et EFI (Both), il faudra prioriser EFI en le mettant comme premier choix.

        --------------------------
        Clavier
        --------------------------

            > loadkeys fr-pc

        --------------------------
        GPT vs MBR
        --------------------------
            https://wiki.archlinux.org/index.php/GUID_Partition_Table

        --------------------------
        Partitionnement
        --------------------------
                __________________________
                Plan



                    Avec lvm:

                        sdX1    :   /boot   :   =~ 150 Mo   (fat) 
                        sdX2    :   swap    :   =~ 2Go
                        sdx3    :   LVM     :   le reste    (pv1 + vg1)
                         lv1    :   /       :   >~ 15 Go    (ext4)
                         lv2    :   /home   :   le reste    (ext4)

                    Sans lvm:

                        peut être plus approprié pour un laptop:

                        sdX1    :   /boot   :   =~ 150 Mo   (fat) 
                        sdX2    :   swap    :   =~ 2Go
                        sdx3    :   /       : >~ 15 Go      (ext4)
                        sdx4    :   /home   :   le reste    (ext4)

                    Création des partition avec gdisk (support de GPT):

                    Note: la partition de boot sera ici disponible pour un mode EFI.

                        > gdisk /dev/sdX
                        > o #créer une nouvelle table de partition GUID
                        > n  # partition 1 [enter], from beginning [enter], to [+150M], linux fs type [EF00]
                        > n  # partition 2 [enter], from beginning [enter], to [+4G], linux fs type [8200]
                        > n  # partition 3 [enter], from beginning [enter], to [+60G], linux fs type [enter]
                        > n  # partition 4 [enter], from beginning [enter], to [enter], linux fs type [enter]
                        > w  # Sauvegarde dans la table de partition.

                __________________________
                LUKS

                    https://gist.github.com/rbellamy/3730750
                    http://doc.ubuntu-fr.org/cryptsetup

                    Chiffrer sa partition:

                        > cryptsetup luksFormat -c aes-xts-plain -s 512 /dev/sda4
                        > cryptsetup luksOpen /dev/sda4 home

                __________________________
                LVM
                    http://doc.ubuntu-fr.org/lvm

                    Note:
                        Il n'est pas recommandé de mettre /boot sur une partition lvm.
                        Même si cela est supporté depuis le Grub 2, c'est encore un point sensible.


        --------------------------
        Formatage
        --------------------------

            mkfs.vfat -F32 /dev/sda1            (L'UEFI ne lit souvent que du FAT32)
            mkswap /dev/sda2
            mkfs.ext4 -L root /dev/sda3
            mkfs.ext4 -L home /dev/mapper/home  (ne pas oublier de déchiffrer sa partition)

        --------------------------
        Montage des partitions
        --------------------------

            > mount /dev/sda3 /mnt
            > mkdir /mnt/{boot,home}
            > mount /dev/sda1 /mnt/boot
            > mount /dev/mapper/home /mnt/home
            > swapon /dev/sda2


            Si l'on utilise une patition EFI en dehors du /boot:
                > mkdir -p /mnt/boot/efi
            Si l'ESP (EFI System Partition) est à part:
                > mount -t vfat /dev/sdaX /boot/efi
                > mkdir /mnt/boot/efi/EFI

        --------------------------
        Réseaux
        --------------------------

            En dhcp (en filaire)

                > ifconfig && dhclient enp4s0 && ifconfig

        --------------------------
        Time
        --------------------------

            date
            timedatectl
            timedatectl set-time '2014-12-03 19:35:00'

            https://wiki.archlinux.fr/Horloge

        --------------------------
        Les dépôts
        --------------------------

            Si l'on souhaite spécifier les miroirs à la main:

            vi /etc/pacman.d/mirror.list

        --------------------------
        Système de base
        --------------------------

            Installer l'arborescence du système:

                > pacstrap /mnt base base-devel

            base-devel est nécessaire pour bénéficier de AUR, le dépot communautaire.
            https://wiki.archlinux.fr/AUR

            liste des paquets:
                https://www.archlinux.org/packages/?arch=any&arch=i686&arch=x86_64&q=

            Liste des groupes:
                https://www.archlinux.org/groups/x86_64//
                

        --------------------------
        BootLoader
        --------------------------
            https://wiki.archlinux.fr/Cat%C3%A9gorie:Bootloader

            Choix d'un bootloader:

                syslinux à l'air plus légé et simple à configurer que grub2.
                Par contre au niveau EFI, grub2 est peut être à ce moment, plus abouti.

                Voir les limites de syslinux en mode UEFI.

                __________________________
                syslinux

                    https://wiki.archlinux.fr/Syslinux#Syst.C3.A8mes_UEFI

                    > pacstrap /mnt syslinux

                __________________________
                grub2

                    > pacstrap /mnt grub
                __________________________
                efi boot stub

        --------------------------
        Config de base
        --------------------------
                __________________________
                fstab:

                    > genfstab -U -p /mnt >> /mnt/etc/fstab

                    #vérifier ensuite:

                        > lsblk -f
                        ou
                        > blkid

                        Mettre sinon à la place des UUID le nom de la partition.

                        LUKS
                        ``````````````````````````

                            https://wiki.archlinux.org/index.php/Dm-crypt/System_configuration#crypttab

                            Si l'on a chiffrer sa partition, il existe deux méthodes pour la déchiffrer:
                                
                                -crypttab (déchiffrement pendant le boot (avant la fstab)):

                                    > vim /etc/crypttab

                                        home /dev/sda4

                                    Sans option, il demandera le mot de passe au démarrage.


                                -pam mount (déchiffrement à l'ouverture de session):


                __________________________
                chroot:

                    Pour le reste de l'installation, il faudra ce chroot dans son nouvel environnement:

                    > arch-chroot /mnt

                __________________________
                Un éditeur de texte convenable:

                    > pacman -S vim
                __________________________
                hostname:

                    > vim /etc/hostname

                        archfoo
                __________________________
                Locale:

                    https://wiki.archlinux.fr/Locale

                        Activation:
                        ``````````````````````````

                            On décommente les locales qui nous interesse:

                            > vim /etc/locale.gen

                                fr_FR.UTF-8 UTF-8
                                en_US.UTF-8 UTF-8

                            Génération des locales:

                                > locale-gen

                            Lister les locales:

                                Actuelle:

                                    > locale

                                Disponibles:

                                    > locale -a

                        Configuration:
                        ``````````````````````````

                            > vim /etc/locale.conf

                                # Spécifier fr par défaut
                                LANG="fr_FR.UTF-8"
                                # Préférer l'anglais à la langue par défaut si la traduction fr n'existe pas
                                LANGUAGE="fr_FR:en_US"
                                # mode de tri des lettres (exemple avec ls: E  e  f  é)
                                LC_COLLATE=C

                            pour charger la langue:

                                > export LANG=fr_FR.UTF-8

                __________________________
                Clavier:

                    > vim /etc/vconsole.conf

                        KEYMAP=fr-pc
                __________________________
                Fuseau horaire:
                    
                    > ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

                __________________________
                Environnement de base (init ramdisk)

                    Note: le init RAM disk est monté lors du chargement du kernel pour accéder à certaines fonctionnalités permetant de charger le fs.

                    https://wiki.archlinux.fr/Mkinitcpio

                    Support de LUKS:

                    > pacman -S cryptsetup
                    > vim /etc/mkinitcpio.conf

                        HOOKS="... encrypt ... filesystems"

                        #/!\ à l'ordre

                    chargement:

                    > mkinitcpio -p linux
                __________________________
                mot de passe root:

                    > passwd

                __________________________
                bootloader:

                    /!\ les commandes ne sont pas les même en fonction du type de firmware.
                    /!\ syslinux: /usr/bin/syslinux-install_update ne supporte pas encore l'installation UEFI

                        BIOS
                        ``````````````````````````


                        UEFI
                        ``````````````````````````
                            https://wiki.archlinux.fr/Syslinux#Unified_Extensible_Firmware_Interface.23efibootmgr

                            Pour syslinux:

                                /!\ Ne pas oublier d'avoir créer une partition de boot compatible EFI.

                                le ficheir .efi se place sur la partition que l'on à dédier à l'EFI and /EFI.

                                Pour ma part l'ESP est aussi dans /boot

                                > pacman -S syslinux dosfstools efibootmgr gptfdisk
                                > mkdir -p ${ESP}/EFI/syslinux
                                > cp -r /usr/lib/syslinux/efi64/* ${ESP}/EFI/syslinux

                                #Necessite d'avoir booté en EFI sur le livecd.
                                > mount -t efivarfs efivarfs /sys/firmware/efi/efivars  #(automatique maintenant)
                                > efibootmgr -c -d /dev/sda -p 1 -l /EFI/syslinux/syslinux.efi -L "Syslinux"

                                #Avec sda la partition ESP

                                #conf:
                                > cp /boot/syslinux/syslinux.cfg ${ESP}/EFI/syslinux/syslinux.cfg
                                > vim ${ESP}/EFI/syslinux/syslinux.cfg


                __________________________
                Quitter le chroot:

                    > exit
                    > cd
                    > umount /mnt/boot /mnt/home /mnt

~~~~~~~~~~~~~~~~~~~~~~~~~~
UI - Interface graphique
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Il faut au préalable installer l'interface graphique avant l'environnement.

        --------------------------
        Serveur d'affichage - Xorg
        --------------------------
            https://wiki.archlinux.fr/Xorg

            Xorg va nous permettre d'implémenter des fenêtre graphique.
            Il ne sait cependant pas les gérer. C'est le gestionnaire de fenêtre qui s'occupera de cette partie.
                __________________________
                Installation:

                    Xorg:
                        > pacman -Syu xorg-server xorg-xinit xorg-server-utils xorg-server-devel

                    Pilote graphique:

                        > pacman -S xf86-video-${MON_PILOTE}


                        exemple avec une Nvidia G740M
                            https://wiki.archlinux.fr/NVIDIA#Nouveau

                        Trouver les infos sur sa carte:

                            > lspci
                            > lspci | grep -e VGA -e 3D
                            > dmesg |grep -i chipset
                                --> GK208 (NV108)

                        Le pilote Nouveau:
                        ``````````````````````````

                            https://wiki.archlinux.org/index.php/Nouveau

                            Note: 
                                Il s'appui sur KMS
                                http://fr.wikipedia.org/wiki/Kernel-based_mode-setting
                                https://wiki.archlinux.org/index.php/Dynamic_Kernel_Module_Support


                            Vérifier si ce chipset est présent dans:
                                http://nouveau.freedesktop.org/wiki/CodeNames/

                            Puis installer le paquet suivant:
                                > pacman -S xf86-video-nouveau

                            Optionnel, l'accélération graphique recquis pour gnome-shell et certain effets de bureau:
                                > pacman -S nouveau-dri

                            DKMS:

                                > pacman -S dkms

                            Vérifier:

                                > lsmod |grep nouveau

                            générer le fichier xorg:

                                > nvidia-xconfig

                        Bumblebee
                        ``````````````````````````
                            https://wiki.archlinux.org/index.php/bumblebee

                            /!\ Fonctionne avec le driver nvidia et intel,
                            Pour nouveau/intel, voir PRIME.

                            Nvidia optimus pour les laptops:

                        PRIME
                        ``````````````````````````
                __________________________
                Configuration:

                    /etc/X11/xorg.conf.d/...
                    ou
                    /usr/share/X11/xorg.conf.d/.    #depuis Xorg 1.16

                        

        --------------------------
        Environnement
        --------------------------

            Ils se démarrent soit directement avec startx soir par l'intermédiaire du gestionnaire de connexion graphique.


            Choix d'un environnement:
                https://wiki.archlinux.fr/Cat%C3%A9gorie:Environnement_graphique

                Mes deux favoris:

                Awesome 3 : Gestionnaire de fenêtre minimaliste utilisant du tiling (utilisation de tout l'espace possible par chaque fenêtre sans chevauchement).
                    Idéal pour faire du multisrceen, du split ...
                    Note: awesome 3 se configure en lua par rapport aux autres versions.

                Xfce : un Environnement complet.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Laptops
        --------------------------

            https://wiki.archlinux.org/index.php/laptop

        --------------------------
        Network
        --------------------------

            https://wiki.archlinux.org/index.php/Dhcpcd
            https://wiki.archlinux.org/index.php/Network_configuration

            
            #Vérifier ses paramètres:
            > ip addr

            #Requête dhcp:
            > dhcpcd ${MonInterface}
            ou
            > systemctl start dhcpcd.service

            Installer les tools:
            > pacman -S net-tools

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
         [Solved] No package 'xorg-server' found, but it IS installed
        --------------------------

            https://bbs.archlinux.org/viewtopic.php?id=121647

            > pacman -S xorg-server-devel
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
