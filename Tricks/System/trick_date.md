# Changer la date sur un système linux

Source : https://alexbacher.fr/unixlinux/modifier-date-heure-fuseau-horaire-linux-debian-ubuntu/

## Fuseau horaire 

    rm /etc/localtime
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
