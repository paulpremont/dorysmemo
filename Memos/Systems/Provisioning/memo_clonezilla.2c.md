==========================================================
                   C L O N E Z I L L A
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Site officiel :

        http://clonezilla.org

    Tutos :

        http://alltutorials.org/creating_an_unattended_image_restore_solution_using_clonezilla_and_usb_stick/
        http://clonezilla.org/related-articles/012_Automated_USB_thumb_drive_using_Custom/Automated_USB_thumb_drive_using_Custom.html

    Options de preseed :

        http://clonezilla.org/fine-print-live-doc.php?path=./clonezilla-live/doc/05_Preseed_options_to_do_job_after_booting/01-preseed-options.doc

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Clonezilla est un utilitaire à la Norton Ghost permetant de créer des images systèmes, de les restaurer ...

    Il va permettre par exemple de cloner plusieurs hôtes physique, de passer d'une VM à une machine physique (et inversement) ...

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Il s'appuie essentiellement sur l'outil 'dd' pour copier des blocs de données.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Récupérer l'iso
        --------------------------

            Pour installer la version live de clonezilla, il faut télécharger l'iso :

                http://clonezilla.org/downloads.php

                Choisir la version live stable de préférence et l'archi souaité (amd64 by example).

        --------------------------
        Sur une clé USB
        --------------------------

            Si l'on souhaite utiliser clonezilla sur une clé bootable, le meilleur moyen est de partitionner sa clé usb :

                 - une partition clonezilla (=~ 500 Mo)
                 - une partition images (> x Mo)

                 De préférence en FAT32

            Utiliser dd ou tuxboot.

            Exemple avec tuxboot :

                > sudo apt-add-repository ppa:thomas.tsai/ubuntu-tuxboot
                > sudo apt-get update
                > sudo apt-get install tuxboot
                > sudo tuxboot

            Choisir ensuite la première partition pour installer clonezilla

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Restauration automatique
        --------------------------

            Il faut éditer simplement les options de boot syslinux

            Exemple :

                cd /media/monUser/clonezilla/syslinux

                Puis pour chaque fichiers :

                    - extlinux.conf
                    - isolinux.cfg
                    - syslinux.cfg

                Rajouter une nouvelle entrée au menu et commenter le #MENU DEFAULT pour le premier label "Clonezilla live", à mettre donc avant ce label :

                    *******************
                    MENU TITLE clonezilla.org, clonezilla.nchc.org.tw

                    label Unattended Restore
                      MENU DEFAULT
                      # MENU HIDE
                      MENU LABEL Clonezilla Unattended Restore
                      # MENU PASSWD
                      kernel /live/vmlinuz
                      append initrd=/live/initrd.img boot=live config  noswap nolocales edd=on nomodeset ocs_prerun="mount /dev/sdb2 /home/partimag" ocs_live_run="ocs-sr -g auto -e1 auto -e2 -b -r -j2 -p reboot restoredisk MON_DOSSIER_IMAGE sda" ocs_live_extra_param="" ocs_live_keymap="NONE" ocs_live_batch="no" ocs_lang="en_US.UTF-8" vga=788 ip=frommedia  nosplash union=overlay username=user
                      TEXT HELP
                      * This is an Auto restore program
                      * WARNING: ALL DATA ON DISKS WILL BE OVERWRITTEN
                      ENDTEXT
                    *******************

                    Avec : 
                        - sdb2 le point de montage racine où se trouve les images systèmes.
                        - sda : le disque qui sera partitionné 
                        - MON_DOSSIER_IMAGE : le dossier contenant l'image du système (typiquement, un dossier comportant comme nom une date par défaut)

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Créer une image
        --------------------------

            Suivre le menu interactif (toutes les options par défaut)
            Bien choisir la partitions 'images' que l'on a précedement créer comme point de lecture et d'écriture pour les images systèmes.

            On peut par exemple créer une image système pour un hôte physique mais aussi pour un hôte virtuel.

            Typiquement, avec une clé usb partitionnée comme vu ci-dessus, 

            On aura une partition sdb1 avec clonezilla
            et une partition sdb2 avec nos images.

            Il faudra donc choisir la partition sdb2 comme point de lecture et d'écriture. (utilisez la racine de ce point de montage)

        --------------------------
        Restaurer une image
        --------------------------

            Idem suivre le menu interactif, au moment de choisir l'action, bien selectionner la restauration d'une image.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Erreur
        --------------------------
                __________________________
                aufs :

                    Si une erreur concernant l'aufs, sur les kernel récent, il faut bien setter le paramètre union=overlay.

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
