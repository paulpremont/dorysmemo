# Erreur :

Sur ubuntu 15.04 :

system-config-kickstart

    RuntimeError: Could not read video driver database

## Lien :

[linuxquestions.org](http://www.linuxquestions.org/questions/ubuntu-63/system-config-kickstart-not-working-in-ubuntu-14-04-a-4175502357/)

## Résolution

    apt-get remove hwdata
    wget ftp://mirror.ovh.net/mirrors/ftp.debian.org/debian/pool/main/h/hwdata/hwdata_0.234-1_all.deb
    dpkg -i  hwdata_0.234-1_all.deb
    apt-get install system-config-kickstart
