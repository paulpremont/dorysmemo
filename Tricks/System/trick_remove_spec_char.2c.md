===============================================
=	REMOVE SPECIAL CHARACTER
===============================================

Certaine chaîne ne s'affiche pas correctement ou ne sont pas exploitable dû aux caractères de contrôle...

Afin de voir quel effet ces caratères ont sur la chaîne un simple:

	> echo "|string|"

permetra de d'avoir un aperçu.

Une méthode pour afficher ces caractères:

	> hexdump -C STRING

Ainsi on obtiendra quelque chose du type:
	
		hostname: |00000000  65 76 61 0d 0a                                    |eva..|
		00000005|

Dans ce cas on peut identifier précisément les caractères pouvant causer problème:
	
 		-0d et 0a (les caratères de fin)
		-"65 76 61" = "eva"

Pour voir la correspondance: 
	
		> man ascii 

In n'y aura plus qu'a regarder le tableau ascci pour repérer le caractère:

		0d = \r
		0a = \n

On peut maintenant procéder à l'élimination de ces caratères:

	> echo string | tr -d "\r\n"

Enjoy! 
