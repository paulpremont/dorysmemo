R E C A L B O X
==============================

What is it ?
-----------------------------

Recalbox est un système de jeux Retrogaming.

### Main features

Links
-----------------------------

### Official

* [site officiel](https://www.recalbox.com/)
* [sources](https://github.com/recalbox)
* [README.fr](https://github.com/recalbox/recalbox-os/blob/master/README-FR.md)
* [Téléchargement de l'image](https://archive.recalbox.com/)
* [Tuto d'installation](https://www.recalbox.com/diyrecalbox)
* [etcher.io](https://etcher.io/)  (optionnel)
* [Notide FR](https://github.com/recalbox/recalbox-os/wiki/Notice-%28FR%29)
* [ROMSmania](https://romsmania.com/) pour télécharger des jeux

### Tutos

* [ssh recalbox](https://github.com/recalbox/recalbox-os/wiki/acc%C3%A8s-root-sur-Terminal--(FR))

### Matériel

* [Manettes pas cher](https://www.amazon.fr/CSL-Manettes-ordinateur-portable-tablette/dp/B0765VHJ2N)
* [Manettes plus cool](http://www.8bitdo.fr/)

How it works ?
-----------------------------

Installation
-----------------------------

### Installer l'image Recalbox


1. Télécharger l'image
2. Burner l'image sur la carte SD (avec [etcher.io](https://etcher.io/) ou plus simplement xzcat)

```
apt-get install xz-utils
xzcat recalbox.img.xz |sudo dd of=/dev/mmcblk0
sync
```

Il ne reste plus qu'à mettre la SD card dans le Raspberry.

Démarrez le raspberry, en y connectant au moins un clavier et une manette.


Configuration
-----------------------------

### Manettes

* [Configurer une manette](https://github.com/recalbox/recalbox-os/wiki/Notice-%28FR%29#4---configurer-une-manette)

Dès que recalbox a démarré, lorsque vous appuyez sur une touche de votre manette, il vous invitera à configurer ses touches.

#### Touche HOTKEY pour les retours au menu principal

Configurez la touche HOTKEY (Exemple : select) pour pouvoir faire des retours au menu sans utiliser le clavier (touche échap).

Une fois configuré, 

utilisez la HOTKEY + B pour arriver sur le menu "retroarch".

On peut aussi retourner sur le **menu principal** en appuyant simultanément sur **select + start**

Manipulations
-----------------------------

### Accès SSH

Récupérer l'adresse IP :

Allez dans les settings via la touche start (Network Settings)

Puis se connecter over SSH :

    ssh root@recalbox

Mot de passe : **recalboxroot**

### Ajouter des jeux

* [Notice, ajouter un jeux](https://github.com/recalbox/recalbox-os/wiki/Notice-%28FR%29#network-add)

Path d'ajout des jeux : **/recalbox/share/roms**

Puis mettre à jour la liste des jeux dans UISettings > Update Game list
