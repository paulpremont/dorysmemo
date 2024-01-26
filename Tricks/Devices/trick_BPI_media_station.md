# Installation d'un micro serveur multimedia

DEPRECATED => PROBLÈMES DE SUPPORT HARDWARE

## Device

Device utilisé : BananaPi M5
Carte microSD 64 GB Samsung

## OS

Sources :

* [bpi](https://wiki.banana-pi.org/Banana_Pi_BPI-M5#Raspbian)
* [images](https://drive.google.com/drive/folders/1oqamIMl5Kmb3LVYMPFw-1tilvwKQI6n-)

Choix de Raspbian pour sa grande communauté et son support.

```bash
sudo dd if=2022-05-25-raspios-bullseye-arm64-hdmi-edid-bpi-m5-m2pro-sd-emmc.img of=/dev/mmcblk0
```

Puis booter sur le BPI.

## Mise à jour du système

```bash
sudo su -
setxkbmap fr #passage en azerty
raspi-config #étendre la partition pour pouvoir faire la mise à jour du système (http://cagewebdev.com/raspberry-pi-expanding-the-root-partition-of-the-sd-card/)
#rebooter le BPI
# apt update && apt upgrade
```

## Installation de Kodi

Source : https://kodi.wiki/view/HOW-TO:Install_Kodi_on_Raspberry_Pi

```bash
apt install kodi
```

## Installation de RetroPie

Source : https://retropie.org.uk/docs/Manual-Installation/

```bash
sudo apt install git lsb-release
cd
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
cd RetroPie-Setup
chmod +x retropie_setup.sh
sudo ./retropie_setup.sh
#Faire un quick setup
```

## TroubleShooting

**Interface réseau non fonctionnelle :**

Installation de la bonne image à faire (réitérer l'instalation jusqu'à trouver la bonne).
