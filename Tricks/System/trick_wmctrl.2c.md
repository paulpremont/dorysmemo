=====================================================================
	T I P S 	W M C T R L 	Windows Manager Control 
=====================================================================

Compatible avec le gestionnaire X Window et les spécification EWMH/NetWM:

Pour rendre la chose pratique, installer le paquet:

> sudo aptitude install wmctrl

Voici un exemple de configuration pour résoltion de 1680*1024 avec deux barres de tâches de 27px (une en haut et une en bas)

Dans les paramètres du clavier:

Activer un Raccourcis avec les commandes suivantes:

	Split verticale droite: 

	>	wmctrl -r :ACTIVE: -e 0,840,27,840,970

	Split verticale gauche:

	>	wmctrl -r :ACTIVE: -e 0,0,27,840,970

	Split Horizontale bas:

	>	wmctrl -r :ACTIVE: -e 0,0,512,1680,485

	Split Horizontale haut:

	>	wmctrl -r :ACTIVE: -e 0,0,27,1680,485


Explications: (Pour les split Verticaux)

	Pour plus de spécification se référer au manuel !

	L'option -r permet de spécifier sur quelle fenêtre appliquer la commande. 
	L'option -e permet de redimentioner et déplacer une fenêtre (implique que l'option -r soit active)
		dans l'ordre: --> g,x,y,w,h: (toute les valeurs sont en pixels)

			(Le point de départ des mesures se fait à partir de l'angle supèrieur gauche de l'écran)

			0------X---------->
			|
			Y
			|
			|
			V

			g: correspond à la gravité de la fenêtre (voir les spécifications EWMH:
				NorthWest (1), North (2), NorthEast (3), West (4), Center (5), East (6), SouthWest (7), South (8), SouthEast (9) and Static (10)
				0 = utilise la valeur par défaut.

			x: correspond au point de départ de la fenêtre sur l'axe verticale (Il suffira de diviser par deux la largeur en pixel de l'écran)

			y: correspond au point de départ de la fenêtre sur laxe horizontale (prendre en compte la hauteur de la barre des taches ...)

			w: correspond à la largeur de la fenêtre (Pour calculer cette valeur, c'est comme pour x)

			h: correspond à la hauteur de la fenêtre (Soit la hauteur en pixel de l'écran (-) les eventuelles barres de tache (si il y en a plusieurs).


