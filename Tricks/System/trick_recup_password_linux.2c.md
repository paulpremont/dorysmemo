=======================================================================
	T I P S	   :	B O O T E R 	E N 	R O O T  (init 1)
=======================================================================

Pour booter en root sur un système linux, 
Lorsqu'on a accès au grub:

Lors du démmarage de sa machine (présser une touche si il faut (F quelque chose)
OU bien souvent la restez appuyé sur la touche SHIFT.

Puis séléctionnez le noyau sur lequel vous voulez booter.

Ensuite éditer la ligne concerné en appuyant sur "e"

Placez vous sur la ligne concernant l'image du noyau et rajouter l'option single:

exemple:
	linux /vmlinuz-3.6.10-4.fx18.i686.PAE root=/dev/mapper/fedora-root ... single

Note:
	Le single peut être remplacé par "1" , il défnit le mode de démarrage init en fait

Puis rebooter à l'aide de la touche "b" ou encote Ctrl+X ... c'est écrit normalement ;)

Vous allez booter en root et une console apparaitra,
tapez 
	passwd 

Et entrez votre nouveau password root.

Le tour est joué ! plus qu'a rebooter ! 

	> reboot
