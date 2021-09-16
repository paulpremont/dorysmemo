Updates :

Liens :

http://sjcamhd.com/
http://sjcamhd.com/firmware-2/
http://support.sjcamhd.com/support/solutions/articles/9000011785-sj5000-new-version-firmware-update

Firmware :

#Formattage de la carte en FAT32

> umount /media/XXX/SJ5000PLUS
> mkfs.fat /dev/mmcblk0p1

#Copy des nouveaux fichiers

> cp -R SJCAM_FWUPDATE_V3.bin /media/XXX/SJ5000PLUS

#Reboot de la camera

Mise à jour du firmware via les settings de la camera

#Reformater la carte SD :

> umount /media/XXX/SJ5000PLUS
> mkfs.fat /dev/mmcblk0p1
