# Mettre de La couleur dans son terminal

## Liens

[nicofo.tuxfamily](http://nicofo.tuxfamily.org/index.php?post/2006/12/21/17-un-terminal-tout-en-couleur)
[trusttonme.net](http://trick.trustonme.net/trick-read-43.html)

On active l'échappement avec l'option -e d'echo, puis on écrit une séquence définissant la couleur:

Cette séquence commence par le caractère échap: \033

Suivi des attributs placés entre un crochet et un 'm'.

exemple:

    echo -e "\033[attribut1;attribut2;...m $MESSAGE"

## Liste des attributs:

attr  | correspondance
:---- | :------------
0     | Annule tous les attributs, sauf les couleurs d'avant et premier plan
1     | Grad
2     | Normal
4     | Souligné
5     | Clignotant (selon le type de terminal)
7     | Invers l'avant et l'arrière plan
8     | Cacher les caractères

Texte | Fond  | Couleur
:---- | :---  | :------
	30	| 40	  | gris foncé
	31	| 41	  | rouge
	32	| 42	  | vert
	33	| 43	  | jaune
	34	| 44	  | bleu
	35	| 45	  | violet
	36	| 46	  | cyan
	37	| 47	  | gris clair

## Dans son bash:

Pour simplifier la coloration dans ses scripts, il suffit de définir des variable contenant le code de la couleur pour les ajouter dans un echo plus tard:

exemple:

		VERT="\\033[1;32m"
		NORMAL="\\033[0;39m"
		ROUGE="\\033[1;31m"
		ROSE="\\033[1;35m"
		BLEU="\\033[1;34m"
		BLANC="\\033[0;02m"
		BLANCLAIR="\\033[1;08m"
		JAUNE="\\033[1;33m"
		CYAN="\\033[1;36m"=

		echo -e "$VERT mon texte en couleur"

## Invite de commande en couleur:

Pour avoir une invite de commande en couleur, il faut changer la variable PS1 qui représente le prompt standard.

exemple:

		PS1='\[\033[36m\] '$PS1'\[\033[0;0m\]'
