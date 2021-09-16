from:
    Récupérer un raid:
        http://steftech.wordpress.com/2012/09/16/recuperer-des-donnees-sur-un-disque-raid-1-issu-dun-synology/
        https://blog.maxux.net/index.php?post/2011/01/06/R%C3%A9cup%C3%A9rer-un-montage-raid-%28mdadm%29-plus-reconnu

    Monter un raid soft:
        http://www.sebastien-han.fr/blog/2011/06/27/introduction-au-raid-sous-linux/
        https://wiki.archlinux.org/index.php/Software_RAID_and_LVM


Créer un raid:

    Vérifier que le raid est supporté par le noyau:

        > modprobe raid1 #pour activer le raid1
        > lsmod |grep raid

    Install du paquet de gestion du raid:

        > apt-get install mdadm
            gdisk (over GPT)

    Check des disques:

        > fdisk -l

    Préparation des disques:

        exemple simple:

            Formater en 'fd' via fdisk:

                n : new partition
                p : primary
                t : formater
                fd : choix du format
                w : sauvegarde

    Création du raid:

        Avec md la partition rassemblant les deux disques
        et les paritions à mettre en raid (dev/sdX)

        > mdadm --create --verbose /dev/md0 --level=raid1 --raid-devices=2 /dev/sdb1 /dev/sdc1

    Check du raid:

        > mdadm --detail /dev/md0

    Création du fs:

        > mkfs.extN /dev/md0

    Montage:
        
        > mount /dev/md0 /where/you/want

Remonter un raid:

    TODO


Récupérer un raid:

    Packages needed:
        mdadm lvm2

    De manière très automatique:

        > mdadm --assemble --scan -v
        > mount /dev/mdX /where/you/want
