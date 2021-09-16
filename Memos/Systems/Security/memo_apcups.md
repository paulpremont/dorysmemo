APCUPS
==============================

What is it ?
-----------------------------

Un outil pour contrôler les infos de son onduleur APC.
Il permet notament de stopper une machine proprement pendant une coupure de courant.

Links
-----------------------------

[apcupsd_ubuntu](https://help.ubuntu.com/community/apcupsd)

Installation
-----------------------------

    apt-get install apcupsd

Pour une interface web :

    apt-get install apcupsd-cgi apache2

Configuration
-----------------------------

### Pour une connexion over USB :

    vim /etc/apcupsd/apcupsd.conf

        UPSNAME myownups
        UPSCABLE usb
        UPSTYPE usb
        comment out DEVICE (it contains a TTY link, which will prevent it from working)

    vim /etc/default/apcupsd

        ISCONFIGURED=yes


Manipulations
-----------------------------

### Service :

    /etc/init.d/apcupsd start
    apcaccess status

### Logs :

* /var/log/apcupsd.events
* /var/log/daemon.events
* /var/log/syslog

### Arrêter le serveur en cad de défaillance :

    vim /etc/init.d/halt

       poweroff="" # à la place de poweroff="-p"
