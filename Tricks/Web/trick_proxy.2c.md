================================================================================
H O W T O   M A N D A T E R   S E S   R E Q U Ê T E S   W E B
================================================================================

Ce howto a pour but de montrer divers moyen d'utiliser un serveur externe pour exécuter ses requêtes web.
Plus dans le but de chiffrer son flux et de changer d'adresse IP publique que de configurer en détail un serveur proxy (voir memo_squid pour ça)

Pour chacun des cas, une connexion (ssh de préférence) est requise pour accéder à votre serveur distant. 
Les solutions présentez ci-dessous fonctionne sur une Debian squeeze v6.0

Voici divers moyens:


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Par un proxy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ici on utilisera un serveur proxy pour exécuter nos requêtes web

Coté client (votre pc local):

	1) Récupérez votre IP publique:

	par exemple sur:
	http://www.monip.org/

Sur le serveur distant:

	> apt-get install squid3
	> vim /etc/squid3/squid.conf

		acl friendly src $MON_IP_PUB/32	
			#faire un /^acl, pour se placer au bon endroit :-)

		http_access allow friendly
			#idem /^http_access, pour bien se placer, 
			#Mettez cette ligne avant http_access deny all

	> service squid3 reload


Si la conf du squid est toute neuve, le port d'écoute par défaut est 3128
Pour vous en assurer:

	> cat /etc/squid3/squid.conf |grep ^http_port

Coté client

	Il faut maintenant configurer le client pour lui indiquer d'envoyer son flux web au serveur proxy:
	Cette config ce fait généralement au niveau de votre browser (sauf si vous utiliser la conf système)

	Pour firefox allez dans Edit/Preferences/Advanced/Network/Settings
		Ensuite cochez "Manual proxy configuration"

		Sur la ligne HTTP Proxy mettez le nom de votre server ( ou son IP) et le Port 3128
		Puis enfin cochez appliquer à tout ;)


Avantages de cette méthode:

	Très peu ! L'avantage c'est la rapidité de mise en place (environ 5 minutes quand on connais)
	Le problème c'est que toute vos requêtes véhicule en clair !
	C'est plus une solution pour l'homme sport préssé.

La suite propose des solutions plus avantageuse :-)

	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Par tunnel SSH
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Le tunnel SSH est monté entre votre pc client et le server. Ce tunnel chiffrera toute les requêtes !

Pour plus de détail sur le fonctionnement des tunnels, allez voir dans la partie memo_linux_network :).


Coté serveur:

	> apt-get install openssh-server #Si ce n'est pas déja fait :p
	
	Je n'ai ensuite pas eu de configuration préalable à faire coté serveur


Coté client: 

	Automatisez votre connexion ssh (sinon c'est chiant)

	Si vous avez déja vos certif alors allez directement à l'ouverture du tunnel :-)

	> ssh-keygen -t rsa
		Laissez tout par défaut à la limite, ne mettez pas de mot de passe sur votre clé pour être plus tranquil ;-). C'est moins sécur mais plus confort, à vous de voir donc ;p.

	> ssh-copy-id -i $HOME/.ssh/id_rsa.pub user@host

		Saisissez votre mot de passe, votre clé sera copié dans authorized_key sur le serveur distant.

	Puis dans la configuration ssh:

	> vim ~/.ssh/config

	  1 HOST NOM_DE_VOTRE_SERVER
	  2         User VOTRE_USER
	  3         IdentityFile $HOME/.ssh/id_rsa

	  Le tour est joué (pour la connexion automatique :p)
	  Le nom du serveur doit être au moins consultable via le DNS ou dans votre fichier host

	Ouverture du tunnel: 

	> ssh -TqnNf -D 4444 $MON_SERVER

	 --> you win, le tunnel est créer, il faut maintenant y faire passer vos requêtes web.

	 Je prend en exemple firefox pour la config car c'est sur ce browser que j'ai fait mes tests:

	 Dans Edit/Préférences/Advanced/Network/Settings

	 Manual proxy configuration:

	 	Sur la ligne SOCKS host:
			Nom_du_server	Port 4444

	vérifier votre IP_PUB ( http://www.monip.org/ ), elle a changée :p !
	Sinon c'est que vous avez loosé quelque part ou voir au niveau du firewall si tout est ok. 

	Automatiser votre tunnel avec un script bash par exemple:
	
	vim tunnel_ssh.sh

		#!/bin/bash
					
		server="mon_server"   
		port="mon_port"                     # > 1023
		command="ssh -TqnNf -D $port $server"
		pid=$(ps aux |grep "${command}$" |awk '{print $2}')                                                                 
		[[ $1 = "start" ]] && $command
		[[ $1 = "stop" ]] && kill $pid

	Un dernier effort, il faut faire passer les requêtes DNS dans le tunnel, sinon tout ça n'aurai servi a rien.
	Sur firefox:

		tapez "about:config" dans l'URL,
		Search : socks

		Sélectionnez network.proxy.socks_remote_dns --> clic droit --> toggle (inversé)
			La valeur passe à true

	Vous pouvez toujours vérifier avec un tcpdump que vos requêtes DNS ne passent pas en clair.

	Voir du coté de tsocks pour ne pas configurer vos clients. 

	todo

	Sinon s'amuser à rediriger le flux 


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Par VPN
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Voir memo_openvpn
