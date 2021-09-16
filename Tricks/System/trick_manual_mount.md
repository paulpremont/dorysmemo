# Monter manuellement une partition :

1 identifier le device :

    fdisk -l
    dmesg |grep sd
    lshw -short
    hwinfo --short

2 créer le point de montage :

    mkdir /mnt/foo

3 Faire le montage :

    mount /dev/XXX /mnt/foo
