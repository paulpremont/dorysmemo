=============================================================
	U S B     L I V E     B O O T A B L E
=============================================================

Pour une iso:

Links:
        http://wiki.debian-facile.org/doc:install:usb-boot
        http://admincloud.net/116/creer-une-cle-usb-bootable-de-windows-sous-linux/


apt-get install syslinux mtools mbr gparted

En mode custom:
        dd if=image.iso of=/dev/sdX (pas la partition mais le volume ne entier)
        
        ex:
            dd if=pve-cd.iso of=/dev/XYZ bs=1M


> sudo add-apt-repository ppa:gezakovacs/ppa && sudo apt-get update && sudo apt-get install unetbootin
ou
> apt-get install unetbootin 
        Puis le lancer, par contre ici c'est bien sur la partition qu'il faut procéder

ou encore usb-creator:

> apt-get install usb-creator-common
> apt-get install usb-creator-gtk

Pour un live:

        TODO
