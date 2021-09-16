R A S P B E R R Y   P I
==============================

What is it ?
-----------------------------

C'est un nano ordinateur monocarte avec un processeur ARM.
Destiné à un usage ludique en premier lieu. Il est possible d'y installer plusieurs variantes d'OS.

Links
-----------------------------

### Official

* [Site officiel](https://www.raspberrypi.org/)
* [Documentation](https://www.raspberrypi.org/documentation/)
* [Wikipedia](https://fr.wikipedia.org/wiki/Raspberry_Pi)

### Tutos

### Boutiques

* [Kubii](http://www.kubii.fr/)


How it works ?
-----------------------------

#### Modèles et caractéristiques

Actuellement le dernier modèle en date depuis le 29 février 2016, est le **Modèle 3B (Raspberry Pi 3)**

Composants          | Modèle 3B 
------------------  | -----------------
Date de sortie      | Février 2016
SoC                 | Broadcom BCM2837
CPU                 | 64 bit ARM Cortex-A53 quadricoeur à 1,2 GHz 
GPU                 | Broadcom VideoCore IV, OpenGL ES 2.0, MPEG-2 et VC-1 (avec licence), 1080p30 h.264/MPEG-4 AVC high-profile decodeur et encodeur
SDRAM               | 1 GB
USB2.0              | x4
Sortie Video        | HDMI + composite (via Jack)
Sortie Audio        | HDMI + composite + Jack
Stockage            | MicroSD
Wifi                | Intégré : Wifi 802.11n
Bluetooth           | Intégré : Bluetooth 4.1 
Ethernet            | 10/100
Puissance nominale  | 800 mA (4 W)
Consommation max    | 720 mA
Source alimentation | 5 volt via Micro-B USB ou GPIO header
Dimensions          | 85,60 mm × 53,98 mm × 17 mm
Poids               | 45 g



Installation
-----------------------------

### Raspbian

Par défaut c'est l'OS Noob qui est installé.
Si l'on souhaite avoir un OS proche d'une Debian, il faut se rediriger vers Raspbian :

[Raspbian](https://www.raspberrypi.org/downloads/raspbian/)

Il faut choisir en la version lite (bien pour un serveur) ou desktop "Pixel" (bien pour un usage graphique/multimedia).
Ici je retiendrai la version lite :

    wget https://downloads.raspberrypi.org/raspbian_lite_latest

On vérifie ensuite le SHA-1 sum donné sur la page de téléchargement.

    echo 6741a30d674d39246302a791f1b7b2b0c50ef9b7 && sha1sum 2016-11-25-raspbian-jessie-lite.zip

Il faut ensuite déziper l'archive et copier le contenu sur une carte SD externe :

    unzip 2016-11-25-raspbian-jessie-lite.zip

On identifie le nom du device/partitions de la carte SD

    df -h
ou
    sudo fdisk -l

On démonte les partitions 

    umount /dev/mmcblk0pX
    df

!!! warning "attention ne pas copier sur une partition mais bien sur le device"

0n copie l'image sur le carte SD

    sudo dd bs=4M if=2016-11-25-raspbian-jessie-lite.img of=/dev/mmcblk0

Il est possible de voir ou la copie en est soit en utilisant dans un autre terminal :
    
    pkill -USR1 -n -x dd

Ou via l'outil **dcfldd**

Ensuite on vide le cache et on démonte proprement la carte SD :

    sync
    umount /dev/XXX

On peut maintenant brancher la carte SD sur le raspberry et booter dessus.

Pour Jessie, le login et le mot de passe par défaut sont :

[login](https://www.raspberrypi.org/documentation/linux/usage/users.md)

* user : pi
* pwd : raspberry

!!! note 
    Le clavier peut être en qwerty par défaut ;)

On peut y accéder directement over ssh
    

Configuration
-----------------------------

### ssh

!!! note 
    First, from now on SSH will be disabled by default on our images

Voir le lien [A SECURITY UPDATE FOR RASPBIAN PIXEL](https://www.raspberrypi.org/blog/a-security-update-for-raspbian-pixel/)

Les anciennes version de raspbian avait le service SSH de démarré par défaut.
Mais pour des raisons de sécurités évidente, ce service a été désactivé, il faut donc le configurer manuellement lors de l'installation de l'image :

Lorsqu'on a monté la carte SD, il suffit de placer un fichier "ssh" dans la partition boot de la carte SD :

    touch /media/$USER/boot/ssh

!!! warning "Ce fichier sera supprimé au prochain boot du raspberry"
    Il faut donc veuiller à activer le service au niveau du raspberry et changer le login et mot de passe. (voir aussi le port par défaut).

!!! note 
    L'attribution de l'adresse IP est par défaut en DHCP
Si vous n'avez pas l'IP de votre raspberry, il suffit de regarder au niveau de votre serveur DHCP la dernière addresse qui a été attribuée.
Ou sniffer le réseau.

### raspi-config

Pour configurer au minimum son raspberry, comme étendre le FS, configurer la langue,  un utilitaire est mis à disposition.

À executer depuis le raspberry lors de sa première execution :

    sudo raspi-config

### Wifi

Lister les SSID :

    sudo iwlist wlan0 scan

Rechercher la clé "ESSID" pour obtenir le nom du point d'accès wifi et "IE: IEEE 802.11i/WPA2 Version 1" pour obtenir la version des algos de chiffrement.

    sudo vim /etc/wpa_supplicant/wpa_supplicant.conf

    network={
        ssid="The_ESSID_from_earlier"
        psk="Your_wifi_password"
    }

Redémarrer l'interface :

    sudo ifdown wlan0
    sudo ifup wlan0

Attendez quelques secondes et constatez le resultat :

    iwconfig


Manipulations
-----------------------------

