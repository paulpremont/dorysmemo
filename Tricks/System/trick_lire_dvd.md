# Lire un DVD du commerce protégé par CSS

Dû au monde impitoyable du commerce,
les DVD sont protégés et intègrent des systemes de chiffrement anti-copie (CSS - Content Scrambling System).

Les softs qui décryptent ne sont pas libres, ce qui explique pourquoi Ubuntu ne l'intègre pas par défaut.

Mais heureusement il existe une librairie qui permet de contourner ce bridage.

## Liens

[ubuntu-fr](http://doc.ubuntu-fr.org/lire_un_dvd)

## Procédé

1- Installer libdvdcss

    apt-get install ubuntu-restricted-extras  #(existe pour kubuntu et xubuntu)

2- Finaliser l'installation

    sudo sh /usr/share/doc/libdvdread4/install-css.sh

3- Bonus

3.1. vider le cache

Supprimer le cache des clés de déchiffrement (si le lancement du dvd est lent).

    rm -r ~/.dvdcss2/*

3.2. Le zonage

Si votre DVD n'est pas lisible, c'est peut être un problème de zonage.  
Le zonage est un paramère propre au périphérique (lecteur dvd).
Attention! Cette méthode n'est utilisable que 4 fois!
(Elle ne sert normalement que pour le constructeur)

Le zonage est encore un problème du commerce. Cerains DVD ne sont utilisable que dans leur zone propre.
	
Les zones:

Pour voir les zones rdv sur: [wikipedia](https://fr.wikipedia.org/wiki/Code_de_r%C3%A9gion_DVD)
	
Pour changer le zonage :

Installer regionset

    apt-get install regionset

Voir la zone du périphérique

    regionset /dev/cdrom

		[N] : pour quitter le soft
		[Y] : modifuer la zone (1 à 8)

3.3. lancer à la main

Si jamais vous avez des problèmes de player :

    apt-get install mplayer
    mplayer -nocache dvdnav://

3.4. Changer la vitesse de lecture

    eject -x <Nombre> /dev/cdrom   (éssayer 4 puis faire varier ... (voir la doc!))
