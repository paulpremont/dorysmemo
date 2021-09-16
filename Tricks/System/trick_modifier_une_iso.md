# Modifier le contenu d'un .iso

    mount -o loop image.iso /mnt/iso
    cp -R /mnt/iso /tmp/new_iso

Appliquer ses changements dans */tmp/new_iso**

    mkisofs -o new.iso /tmp/new_iso
ou

    dd if=/dev/sdX of=new.iso

Pour un iso bootable :

* [osdev.org](http://wiki.osdev.org/El-Torito)
* [bencane.com](http://bencane.com/2013/06/12/mkisofs-repackaging-a-linux-install-iso/)
* [romant.net](http://blog.romant.net/technology/creating-bootable-iso-linux-solaris-windows/)

<!-- cmd -->

    mkisofs -o ../your-new.iso -b isolinux/isolinux.bin -c isolinux/boot.cat 

D'autres options :

    -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V Your Disk Name Here .
