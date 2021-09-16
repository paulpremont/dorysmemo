https://blog.sleeplessbeastie.eu/2012/05/08/how-to-mount-software-raid1-member-using-mdadm/
http://pissedoffadmins.com/os/mount-unknown-filesystem-type-lvm2_member.html

Comment récupérer un disk raid :

----------------
montage du disk raid :

#S'assurer que le disque est bien monté :

> sudo fdisk -l

#Install des packages pour le montage raid

> apt-get install mdadm

#Vérifier le type de raid ...

> sudo mdadm --examine /dev/sdyX
> sudo mdadm -A -R /dev/md9 /dev/sdyX
> sudo mount /dev/md9 /mnt

#Si il ya une couche lvm :

> sudo apt-get install lvm2

> sudo modprobe dm-mod
> sudo vgchange -ay
> sudo lvscan
> sudo mount /dev/c/c /mnt

#Démonter :

> sudo umount /mnt
> sudo mdadm -S /dev/md9

#si il y a un problème avec lvm (mdadm: Cannot get exclusive access to /dev/md9:Perhaps a running process, mounted filesystem or active volume group?)

#essayer:

> sudo dmsetup ls
> sudo dmsetup remove c-c
> sudo mdadm --stop /dev/md9
