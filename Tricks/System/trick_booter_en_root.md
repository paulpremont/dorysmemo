# Comment récupérer une console en root au boot

Cette méthode fonctionne si le GRUB le permet :

## De manière générale

Démarrer en runlevel 1 (single) :

* Éditez au niveau du grub la ligne voulue, editer la ligne concernant le kernel , et rajouter l'option 1 en fin de ligne.
* Rebooter en appuyant sur 'b' (ce placer sur la bonne ligne) ; vous redémarrer en run-level 1 avec les droits root.

## Sur une ubuntu:

Accédez au grub à l'aide de Esc

* Editez la ligne concernant le kernel sur lequel vous voulez booter
* à la ligne "linux /boot", rajouter "single" en fin de ligne.
* appuyez sur b pour rebooter

Sur une débian:

* il faut remplacer 'ro quiet' par 'rw single'
