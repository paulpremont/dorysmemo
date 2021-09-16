# Changer l'ordre des interfaces

## Liens

[unix.stackexchange](http://unix.stackexchange.com/questions/10254/how-to-change-the-order-of-the-network-cards-eth1-eth0-on-linux)

## HowTo

* Première méthode bourine :

Unload the drivers :
    modprobe -r driver_0        # eth0 nic interface
    modprobe -r driver_1        # eth1 nic interface

Load the drivers in corrected order :
    modprobe driver_1
    modprobe driver_0


* Deuxième méthode luxe :

Dans /etc/modprobe.d/

Créer son PROPRE fichier, exemple : disable-nics.conf

    blacklist driver_0     # eth0 by default
    blacklist driver_1     # eth1 by default

Puis lancer :

    depmod -ae
    update-initramfs -u

Dans /etc/modules

Drivers in wanted order :

    driver_1    # this one should be loaded as eth0
    driver_0    # this one should be loaded as eth1

Pour switcher ensuite :

    modprobe -r driver_0; modprobe -r driver_1; modprobe driver_1; modprobe driver_0
