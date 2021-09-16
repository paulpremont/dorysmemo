==========================================================
	F R E E   R A D I U S
==========================================================

~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~

	Schéma:
		[Supplicant] <---> [Authenticator] <---> [Radius]
		(hôte) 	     <---> (Client radius) <---> (NAS)

	> apt-get install free-radius


~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~

	Fichiers de conf dans /etc/freeradius

	Pour une configuration basique, seul les fichiers client et user nous interesserons:

	_______________
	USER:

		Ajouter les lignes suivante pour ajouter un nouveau compte utilisateur
		(N'utilise pas de protocole de chiffrement dans cet exemple):

		> vim users

		> hello		Cleartext-Password := "world" 			#Correpond au user/password (hello/world)
		>		Reply-Message = "You win %{User-Name}"		#Correspond au message envoyé en cas de réussite de connexion

		> DEFAULT	Auth-Type = Reject				#Correspond aux valeurs par défaut (dans le cas ou l'user n'est pas trouvé)
		>		Reply-Message = "You failed Mr %{User-Name}"


	_______________
	CLIENT:

		Cette partie concerne la configuration des clients radius:

		> vim clients.conf

		client ASA {				#Nom du client (fictif) pour la v1 de freenas, mettre l'@ IP
			ipaddr = 10.10.10.254		#@ IP du client (utile pour la v2)
			netmask = 24			#Netmask ^^
			secret = secretradius		#Le secret partagé à configurer aussi sur le client
			shortname = ciscoasa		#(Optionnel) utilisé pour la v1
			nastype = cisco			#Voir plus haut dans le fichier de conf pour les types de nas
		}

~~~~~~~~~~~~~~~~~~~~~~
Mise en route et tests
~~~~~~~~~~~~~~~~~~~~~~
	_______________
	service

		> /etc/init.d/freeradius start|stop|restart

	_______________
	mode debug (à préférer pour que le serveur soit verbeux !=)

		> freeradius -X -f

	_______________
	test de la configuration

		radtest "username" "password" "client_name" "port" "secret_phrase"

		exemple:

		> radtest hello world localhost 0 testing123

		(le port 0 désigne le port par défaut du système)
