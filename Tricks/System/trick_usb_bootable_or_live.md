# Media bootable

## Sources

- https://doc.ubuntu-fr.org/dd
- http://wiki.debian-facile.org/doc:install:usb-boot
- http://admincloud.net/116/creer-une-cle-usb-bootable-de-windows-sous-linux/

## Via dd

```
df #repérer la partition cible
dd if=pve-cd.iso of=/dev/XYZ bs=4k status=progress
```

## Via un utilitaire

(à revérifier)

apt-get install syslinux mtools mbr gparted

En mode custom:
        dd if=image.iso of=/dev/sdX (pas la partition mais le volume ne entier)
        
        ex:
            dd if=pve-cd.iso of=/dev/XYZ bs=4k status=progress


> sudo add-apt-repository ppa:gezakovacs/ppa && sudo apt-get update && sudo apt-get install unetbootin
ou
> apt-get install unetbootin 
        Puis le lancer, par contre ici c'est bien sur la partition qu'il faut procéder

ou encore usb-creator:

> apt-get install usb-creator-common
> apt-get install usb-creator-gtk

Pour un live:

        TODO
