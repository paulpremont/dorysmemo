=========================================
        B O O T (ou Bootstrap)
=========================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Séquence de démarrage
~~~~~~~~~~~~~~~~~~~~~~~~~~

        cold boot : démarrage de l'ordinateur (allumage)
        warm boot: redémarrage de la machine (rechargement du programme initial)

        Le but étant de charger un programme alors qu'il n'existe rien en mémoire:
                Exemple: le noyau de l'OS.

        Il faut éxécuter certaines étape avant l'exploitation du bootloader (s'il existe)  pour extraire un programme sur un périphérique de stockage.

        Exemple courant:

        Le BIOS, qui se charge de lire le MBR (Master Boot Record) [512 octet] sur un media de stockage. Il le place en ram et lui passe la main.

                        On peut avoir aussi sur des systèmes embarqué différent type de bootloader:
                                Par exemple sur du matèriel type calculatrice, routeur ...
                                Le programme peut être écrit en permanence en ROM ou en mémoire Flash.

        Note: voir EFI pour l'autre méthode courante
        -----------------
        Schéma de l'allumage au boot:
        -----------------

            http://fud.community.services.support.microsoft.com/Fud/FileDownloadHandler.ashx?fid=fc7b42fb-b993-4f6a-96f2-5e8eb0f1969a

            Allumage->Matèriel->Micrologiciel->Séquence d'amorçage->[bootloader]->OS


        -----------------
        Schéma de partitionnement:
        -----------------

            http://i.technet.microsoft.com/dynimg/IC197579.gif


~~~~~~~~~~~~~~~~~~~~~~~~~~
Les micrologiciel - Firmware
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Il check le materiel et recherche le secteur de démarrage.

        -----------------
        BIOS et boot standard
        -----------------
                Ecrit en assembleur

                Exécution du Power Good:
                        Il vérifie que la tension fournie est stable. Sinon il abandonnera le démarrage.

                Exécution du POST (Power-on self)
                        Vérifications des composants matériels

                Exécution des ROM d'extension des périphériques
                        Pour les demandes d'initialisation particulière

                Affichage des configurations

                Chargement de l'OS
                        Appel du MBR (ou peut être remplacé par la GPT) par le BIOS
                                Puis ce dernier lance le chargeur d'amorçage (LILO, GRUB, NTLDR) (Boot-loader)
                                        Ce dernier lance l'OS qui se chargera de la suite.

                Note sur le Fastboot:
                        Certaines étapes peuvent être inutile sur certain pc c'est pourquoi le fastboot n'éxécute pas tous les 'test'.

                _______________
                MAJ un BIOS:

                _______________
                Layout:

                    BIOS -> MBR -> BootLoader -> Kernel -> OS

        -----------------
        UEFI/EFI (Unified Extensible Firmware Interface)
        -----------------
                http://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface
                https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface

                UEFI = promotion de la spécification EFI, il définit l'interface entre le firmware et l'OS

                Il s'intercale entre le micrologiciel et l'OS:

                C'est une sorte d'évolution du BIOS.

                L'EFI offre des fonctionnalités supplémentaire et intègre en standard les tables GPT.
                Il est écrit en C ce qui le rend plus maniable que le BIOS.

                Secure Boot: 
                        à enlever pour démarrer sur des OS non signés.


                Il est possible de passer en compatibilité BIOS, c'est à dire faire comme si l'UEFI n'était pas présent:

                legacy BIOS mode ou encore CSM (Compatibility Support Module)

                _______________
                Layout:

                    UEFI -> EFI Boot Loader -> Kernel -> OS
                _______________
                Migrer du BIOS vers UEFI:

                    https://wiki.manjaro.org/index.php?title=UEFI_-_Install_Guide

                        1) Création d'une partition en fat32 =~ 512 MB
                        ``````````````

                            Installation des packages suivnts:

                                - efibootmgr
                                - dosfstools
                                - grub

                        2) Créer un dossier /boot/efi
                        ``````````````
                            mkdir /boot/efi
                            
                        3) Monter sa partition efi dans /boot/efi
                        ``````````````
                            mount /dev/sdX /boot/efi

                        4) Installation du grub et update:
                        ``````````````
                            grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ubuntu --recheck
                            update-grub

                            En cas de problème:

                                /boot/grub not readable => ce chroot (https://wiki.manjaro.org/index.php?title=Restore_the_GRUB_Bootloader#Identify_and_Prepare_the_Installed_Partition.28s.29)

                                EFI variables not supported => modprobe efivars

        -----------------
        EFI vs BIOS
        -----------------
            http://1.bp.blogspot.com/-zdy3mz5hei8/U4HaTwpHzOI/AAAAAAAASKo/BWpRUghwjf0/s1600/bios_vs_uefi.png

        -----------------
        LBA : todo
        -----------------

~~~~~~~~~~~~~~~~~~~~~~~~~~
Secteur de démarrage et Table de partition
~~~~~~~~~~~~~~~~~~~~~~~~~~

        http://fr.wikipedia.org/wiki/Secteur_de_d%C3%A9marrage

        Présent sur un disque dur, un cd, une clé usb ...

        Il est indispensable à la bonne utilisation d'un media de données.



        ------------------
        MBR Master Boot Record [512 premier octets]
        ------------------

            http://1.bp.blogspot.com/-7jxys-fNSBM/UCdFNi9MPEI/AAAAAAAAAeA/q9VaLfVEwMA/s1600/paint.JPG

            (Cylindre 0, tête 0, secteur 1 ou 0 en adressage logique)

            C'est le premier secteur d'un disque dur, ou un autre média amovible...

            Le MBR (zone d'amorce):

                    Il contient la table de partition ( 4 partition primaires max).
                    Il contient une routine d'amorçage pour charger l'OS ou le chargeur d'amorçage (boot-loader)
                    Le magic number (octet 510, 0xAA55) permet au BIOS de d'éxécuter la routine de démarrage du MBR.

                _______________
                Installation du MBR:

                        Sous Windows:
                                Voir FDISK/MBR
                                fixmbr sous xp
                                bootrec /FixMbr sous Seven

                        Sous Linux:
                                Voir du coté de dd

                                exemples:

                                sauvegarde du MBR:
                                        dd if=/dev/sda of=boot.mbr bs=512 count=1
                                
                                Restauration du MBR:
                                        dd if=boot.mbr of=/dev/sda bs=512 count=1

                _______________
                Afficher le mbr:

                        sudo dd if=/dev/sda bs=512 count=1 | hexdump -C

            
                _______________
                Schéma typique:

                    BIOS                #Scan des disques à la recherche du MBR/EBR
                        -> /boot        #Partition de boot contenant le boot loader.
                            -> |MBR - boot_loader|kernel...|      #Accès au menu du MBR après lécture du premier secteur du disque (pas de notion de FS)


        ------------------
        VBR
        ------------------

        ------------------
        EFI
        ------------------

            A ce niveau l'EFI étend ses fonctionnalité comme un simple boot loader.
            Il est possible de cumuler plusieurs EFI. Ce dernier est dépendant d'un FS, généralement du FAT32.

            Ce qui donne le schéma suivant:
                _______________
                Schéma typique:

                    UEFI                #Scan des disques à la recherche d'un fichier /EFI/EFIX/xxx.efi
                        -> /boot        #Partition de boot contenant le boot loader en mode efi.
                            -> |EFI1|kernel...|      #Accès au menu de l'UEFI listant les EFI possible (ici l'EFI correspond au boot loader en mode EFI)
                               |EFI2|         | 
                                    FS [FAT32]

        ------------------
        GPT GUID Partition Table
        ------------------
                http://fr.wikipedia.org/wiki/GUID_Partition_Table

                Elle permet de gérer des partition plus grande notament.

                Il décrit la partition du disque dur. Il fait partit du standard EFI
                C'est un sous ensemble des spécification de UEFI

                La GPT comporte une entrée MBR 'protectrice' pour garder une certainte compatibilité, une en-tête GPT, et le tableau de partition

                Il l'écrit dailleur au début et à la fin du disque pour offrir une redondance.

                MBR protecteur
                GPT primaire: en tête.
                GPT primaire: table de partition
                        Partitions ...
                GPT secondaire: table de partition
                GPT secondaire: entête (din du disque)


~~~~~~~~~~~~~~~~~~~~~~~~~~
Les boots loaders
~~~~~~~~~~~~~~~~~~~~~~~~~~
        ------------------
        Checker sur quel partition est installée le MBR 
        ------------------

            Exemple avec GRUB:

                > dd bs=512 count=1 if=/dev/sda 2>/dev/null |hexdump -C

                Voir ensuite si il y a "GRUB .Geom.Hard..."

        ------------------
        GRUB Legacy
        ------------------
        ------------------
        GRUB 2
        ------------------

                http://www.gnu.org/software/grub/
                https://help.ubuntu.com/community/Grub2
                https://help.ubuntu.com/community/Grub2/Troubleshooting
                http://wiki.gentoo.org/wiki/GRUB2
                _______________
                Installation

                        gentoo
                        ``````````````
                                emerge sys-boot/grub

                        debian
                        ``````````````
                                apt-get install grub-pc

                        > grub2-install /dev/sda
                _______________
                Configuration

                        /etc/default/grub
                        /etc/grub.d

                            ### BEGIN /etc/grub.d/40_custom ###
                            # This file provides an easy way to add custom menu entries. Simply type the
                            # menu entries you want to add after this comment. Be careful not to change
                            # the 'exec tail' line above.

                            menuentry "Windows" {
                            set root=(hd0,1) #voir le langage grub dans la partie Legacy
                            chainloader +1 #renvoie à un autre bootloader
                            }

                            menuentry 'Gentoo Linux 3.2.12' {
                            root=hd0,1
                            linux /boot/kernel-3.2.12-gentoo root=/dev/sda3
                            }

                        > grub2-mkconfig -o /boot/grub/grub.cfg


        ------------------
        SYSLINUX
        ------------------

        ------------------
        LILO
        ------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~
Processus de démarrage system
~~~~~~~~~~~~~~~~~~~~~~~~~~

        ------------------
        LINUX
        ------------------

                Une fois le noyau chargé par le bootloader, il prépare les structures mémoires et les pilotes puis passe le relai au système d'initialisation (Exemple: init ).
                Le démon init finalise le boot du système en démarrant et contrôlant les services appropriés.
                Durant cette phase, il fait appel au démon udev:

                        udev est le remplaceant de devfs, il s'occupe principalement de gérer les périphériques dans /dev de façon dynamique.
                        Il se charge notament de préparer le système en fonction des périphériques détectés.
                        A ce moment tout les FS sont montés et le restes des services sont lancés.
                
                _______________
                initramfs et initrd:

                        https://wiki.gentoo.org/wiki/Initramfs/HOWTO/fr
                        http://en.wikipedia.org/wiki/Initrd

                        Dans certain cas, il est nécessaire de monter des partitions avant que le démon init intervienne:
                                Par exemple, en cas de chiffrment de partitions nécessaire au démarrage du système ou si les partitin /usr et /var ne sont pas sur la partition root.

                        Pour ce faire, il existe deux méthodes les plus connus:

                                initrd:
                                ``````````````
                                        Dans ce cas, on dédie un espace fixe formaté sur son disque appelé 'initrd' pour INITial RamDisk.
                                        Ce initrd va contenir une image minimal du système, comprenant entre autre des outils de montages de FS. 
                                        Le noyau va alors appelé un script de configuration, usuellement appelé linuxrc sur ce initrd
                                        Ainsi il sera en mesure de monter les partition avant de retourner sur la vrai racine et rendre la main au système d'initialisation (init le plus souvent).
                                        

                                initramfs:
                                ``````````````
                                        initramfs à l'avantage de ne pas nécéssiter une taille bloc fixe sur le disque car il se base directement sur la RAM avec des FS type tmpfs.
                                        Pour réaliser se iniramfs, on créer une archive type cpio qui va contenir tout nos outils.
                                        Compréssée (gzip) l'achive (cpio) sera placée avec le noyau pour que le bootloader puisse la lui fournir.
                                        Enfin le noyau créera un FS 'tmpfs', pour extraire le contenu de l'archive et lancera le script init de ce disque virtuel pour monter nos partition physique (et autre outils) pour ensuite repasser la main au système d'initialisation de notre racine "reelle".


~~~~~~~~~~~~~~~~~~~~~~~~~~
Dual BOOT
~~~~~~~~~~~~~~~~~~~~~~~~~~

        En mode legacy bios et/ou bios

                Installez avec mbr est la chose la plus simple.
                Attention s'il reste une table de partition GPT, il faut penser à l'enlever.

                Dans le cas de l'UEFI, il faut désactiver le 'secure boot'

        Pour le dual boot en EFI il faut que les deux OS soit compatible EFI en gros et booter/installer dans ce mode.

~~~~~~~~~~~~~~~~~~~~~~~~~~
BOOT FLAG
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Ce flag est optionnel maintenant. Il sert surtout pour Windows XP-2000.
        Il fait un octet et indique simplement sur quelle partition booter.

        Note: les bootloader actules type GRUB2 n'ont pas besoin de ce flag.

