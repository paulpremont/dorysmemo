===================================================
   P O R T 	S E R I E 	C O N S O L E 
===================================================



trouver les infos sur l'interface:

	> dmesg |egrep --color 'serial|ttyS'

On peut aussi passer par le tool "setserial"

	> apt-get install setserial 
	> setserial -g /dev/ttyS[0123]

Une foie qu'on connait son interface, on peut prendre la main de l'équipement:

	
	Via cu:

		> apt-get install cu
		> cu -l MON_DEVICE -s MON_BAUD

		exemple courant pour du matos cisco:

		> cu -l /dev/ttyS0 -s 9600

	Via screen:

		> apt-get install screen
		> screen MON_DEVICE MON_BAUD

		Exemple:

			> screen /dev/ttyS0 9600

		Petit problème ensuite (mauvaise interprétation des touches, à configurer)

	Via minicom:

		Ce dernier est intératif, il faut connaitre quelque commande:

		CTRL+A Z : afficher l'aide
		CTRL+A Q : quitter

		
		> apt-get install minicom
		> minicom -s 	#lancer la configuration en setant l'interface série et le baud
		#Puis relancer minicom
		> minicom

		Ensuite c'est simple faut suivre le menu.
	
		Voir: 
		
			http://www.cyberciti.biz/trick/connect-soekris-single-board-computer-using-minicom.html



En attendant cu reste le plus simple.

~~~~~~~~~~~~~~~~~~~~~~~~~
LINK
~~~~~~~~~~~~~~~~~~~~~~~~~

        http://www.cyberciti.biz/hardware/5-linux-unix-commands-for-connecting-to-the-serial-console/
