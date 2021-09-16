=====================================================
	Rappel sur les conversions
=====================================================

        4 bit = 1 caractère hexadecimal

        Décimal       0    1    2    3    4    5    6    7    8    9    10   11   12   13   14   15
        Binaire       0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111
        Hexadécimal   0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F

        On passe donc de l'hexa au binaire par regroupement de 4 bit (retranscription en décimal)
                        

        De l'hexa au décimal on multipli chaque caractère hexa par leur base et l'exposant en fonction de leur indice:
                 binaire        1.0101.1010.1010.1100.1111.0111 
                 hexadécimal    1   5    A    A    C    F   7
                 (Décimal)                             22719735 

                1×16^6 + 5×16^5 + 10×16^4 + 10×16^3 + 12×16^2 + 15×16^1 + 7×16^0 = 22719735

        L'inverse du décimal vers l'hexa se fait facilement en passant  vers le binaire (on éxécute des divisions successive de 2);
        On regroupe ensuite le résultat (qui se lit de bas en haut) et on le découpe par tranche de 4 bits
                
=====================================================
	I P V 4
=====================================================

~~~~~~~~~~~~~~~~~~~~~~~~~
Les classes:
~~~~~~~~~~~~~~~~~~~~~~~~~

	Classe		Bit_poids_fort		Plage		Netmask		CIDR

	A		0			1 à 126		255.0.0.0 	/8
	B		10			128 à 191	255.255.0.0	/16
	C		110			192 à 223	255.255.255.0	/24
	D		1110			224 à 239	---		---
	E		1111			240 à 255	---		---

~~~~~~~~~~~~~~~~~~~~~~~~~
Adresses Privées hôte:
~~~~~~~~~~~~~~~~~~~~~~~~~

	classe A:	10.0.0.0 	à 	10.255.255.255
	classe B:	172.16.0.0	à 	172.31.255.255
	classe C:	192.168.0.0 	à	192.168.255.255 

~~~~~~~~~~~~~~~~~~~~~~~~~
Adresses réservées:
~~~~~~~~~~~~~~~~~~~~~~~~~

	0.0.0.0 : non reconnue par les réseau (ou équivaux à "tout les réseaux, soit la route par défaut pour un routeur)
	127.0.0.0 : Loopback (boucle locale) attribué à un hôte par défaut.
	Broadcast : Adresse dont tout les bit partie hôte sont à 1 (correspond à la dernière adresse)
	Réseau : Adresse qui définit le réseau, les bit partie hôte sont à 0
	255.255.255.255 : broadcast général

~~~~~~~~~~~~~~~~~~~~~~~~~
Netmask:
~~~~~~~~~~~~~~~~~~~~~~~~~

	Le netmask sert à définir l'ip réseaux d'un hôte, on éxecute un ET logique entre le netmask et l'ip host

	Note : 
		classful  :  todo
		classless :  todo

~~~~~~~~~~~~~~~~~~~~~~~~~
Sous réseaux:
~~~~~~~~~~~~~~~~~~~~~~~~~

	Les sous réseaux permettent de diviser en plusieurs parties logiques un réseau et limiter ainsi les domaines de collision.
	Pour réaliser un sous réseau, on prend des bits parties hôtes pour les attribuer au réseau.

		On détermine le nombre de bit à prendre par la formule:
			(2^X) >= (Nbre sous réseaux)

		Exemple:

			on veux 10 sous réseaux du réseaux 10.0.0.0
			
			2^4 >= 10

			on prend donc 4 bit partie hôte:

			On aura donc les adresses de sous réseaux suivantes:

			network: 10.0.0.0  	Broadcast: 10.15.255.255
			network: 10.16.0.0	Broadcast: 10.31.255.255
			network: 10.32.0.0	Broadcast: 10.47.255.255
			...
			network: 10.240.0.0 	Broadcast: 10.255.255.255

			pas : 16
			netmask : 255.240.0.0	
			
~~~~~~~~~~~~~~~~~~~~~~~~~
VLSM:
~~~~~~~~~~~~~~~~~~~~~~~~~

	VLSM (Variable Length Subnet Mask): Le principe des VLSM est de définir des sous-réseaux à taille variable avec des masques différents.

		Il faut déterminer combien d'hôte nous voulons par sous réseaux:
			soit (2^X)-2 >= Nombre d'hôte:  (on enlève l'adresse réseau et de broadcast)

			Avec X le nombre de bit prélevé partie hôte.

		Exemple:

			Réseau: 192.168.1.0/24
			
			3 routeurs reliés à des sous réseaux différents:

				LAN A : 60 hôtes
				LAN B : 24 hôtes
				LAN C : 21 hôtes

				+ 3 liens pour interconnécter les trois routeurs entre eux.

			On aura donc besoin de 6 sous-réseaux. (un sous réseau par lien)
			Lorsqu'on se sert des VLSM, il faut commencer à définir les plages d'adresses les plus grandes:

			LAN A:

				2^6 - 2 = 62 >= 60 hôte
				On garde donc 6 bit partie hôte, ce qui nous fait prélever 2 bit partie réseaux:
				soit un masque /26

				Network: 192.168.1.0/26
				Broadcast: 192.168.1.63

			LAN B
				
				On part de la dernière adresse utilisable soit: 192.168.1.64

				2^5-2 = 30 >= 24

				On préleve donc 1 bit de plus partie réseaux

				Network: 192.168.1.64/27
				Broadcast: 192.168.1.95

			LAN C

				Idem:

				2^5-2 = 30 >= 21

				On garde le masque /27

				Network: 192.168.1.96/27
				Broadcasr: 192.168.1.127

			Les liens:

				Ici on a besoin seulement de 2 adresses (pour les interfaces des routeurs)
				Mais il faut aussi compter l'adresse réseau et le broadcast

				2^2 -2 = 2 >= 2

				Lien 1:
					Network: 192.168.1.128/30
					Broadcast: 192.168.1.131

				Lien 2:
					Network: 192.168.1.132/30
					Broadcast: 192.168.1.135

				Lien 3:
					Network: 192.168.1.136/30
					Broadcast: 192.168.1.139

~~~~~~~~~~~~~~~~~~~~~~~~~
Le numéro ordinal
~~~~~~~~~~~~~~~~~~~~~~~~~

	Il correspond au numéro d'ordre du réseau. 
	On le retranscrit en binaire et on l'appose partie réseau pour déduire l'adresse réseau:

	exemple:
		
		pour le réseau 172.16.0.0/22
		On cherche l'adresse du 22ème sous-réseau:

		On retranscrit 22 en binaire:

			010110

			on le place dans la partie réseau la plus à droite:

			ce qui donne sur le 3ième octet: 

			01011000 (6 bit partie réseau et 2 bit hôte)

			On reconverti ensuite en décimal:

			Ce qui donne:

			Network: 172.16.88.0/22
			Broadcast 172.16.91.255 (Comme sur le 3ième octet, il nous reste 2 bit hôte, il suffit d'ajouter la valeur décimal de ces bit à 1)

~~~~~~~~~~~~~~~~~~~~~~~~~
Supernetting
~~~~~~~~~~~~~~~~~~~~~~~~~

	Permet de résumer les routes pour diminuer la taille de la table de routage:
	Pour cela on récupère la partie commune de chaque sous réseau pour déterminer le nouveau masque à appliquer sur l'adresse réseau:

	Exemple:

		Pour le réseau 192.168.200.0/24
		Nous avons 7 sous-réseaux: 
			192.168.200.0 -> 192.168.207.0/24

		On isole la partie commune à tous ces sous-réseaux:

		11001 , soit les 5 premier bit du 3ème octet.

		Il suffit ensuite de passer tout ces bit à 1 pour determiner le nouveau masque:

		/21

		On aura donc la route résumé:
			192.168.200.0/21


	Note: cette option est initialement activé sur la plupart des routeurs (ce qui pose des problème lorsqu'on veut s'en passer).
		On pourra sur un routeur cisco la désactiver: # no auto-summary


~~~~~~~~~~~~~~~~~~~~~~~~~
Multicast:
~~~~~~~~~~~~~~~~~~~~~~~~~

	Le multicast a pour but de diffuser des paquets à un groupe multicast.
	Une table multicast est mise à jour pour réaliser cette diffusion.

	Le multicast nécéssite l'utilisation du protocole IGMP(+ PIM) et est basé sur UDP

	Il utilise les plage de 224.0.0.0 à 239.255.255.255

	Cependant l'IANA (Internet Assigned Numbers Authority) maintient une liste de groupe Multicast:

		224.0.0.0 : réservée
		224.0.0.0 à 224.0.0.255 : pour les protocole de routage, maintenance et découverte de topologie
			224.0.0.1 : tous les hosts IP Multicast sur un LAN
			224.0.0.2 : tous les routeurs sur un LAN
			224.0.0.4 : tous les routeurs DVMRP sur un LAN
			224.0.0.5 : tous les routeurs OSPF sur un LAN
		224.0.1.0 à 239.255.255.255 : disponibles


=====================================================
	I P V 6  (IPnG)
=====================================================

~~~~~~~~~~~~~~~~~~~~~~~~~
Généralités
~~~~~~~~~~~~~~~~~~~~~~~~~

	exemple d'adresse:

		fe80::d63d:7eff:fe07:58/64

	Default:
		-@IP sur 128 bit noté en hexadecimal
		-64bit réseau |64bit host
		-4 bloc de 16bit partie réseau |4 bloc de 16bit partie hôte
		-Gestion native d'IPsec
		-MTU : 1280 octets

	La notation CIDR est la même qu'en IPv4

	Note: 
		Pour la translation hexa -> decimal il faut transposer l'@IP en bloc de 4bit en base 2.
		Un caractère hexa = 4 bit en binaires. (voir tout en haut pour les rappels de conversion).

	Avantages:
		Amélioration dans la gestion du multicast
		Meilleure gestion des envois
		Amélioration de la flexibilité en intégrant d'autres fonctions dans l'entête
		Gestion de la QoS (utilse pour la VoIP) et de la sécurité native dans ce protocole
		auto configuration de routage
		Adressage unique ne nécéssitant pas de réadressage en cas de connexion à un nouveau réseau.
		Agrégation: le nombre d'adresse dispo permet de définir plus simplement des blocs d'adresses
		NAT et PAT inutile
		Intégration d'IPsec facilité
		Un en-tête simplifié.

	Impact:
		C'est le routeur qui donne l'IP de la gateway par défaut
		Pas besoin de NAT
		Supression du FCS (CRC de la couche 3) (etant déja dispo à la couche 2 et 4)
			--> moins de calcul au niveau du routeur.
		Tout les bits partie hôte et réseau sont exploitable (pas de reservation pour broadcast et réseau)

	Durée de vie:
		par défaut une IP est attribué pour 80 heures. (portable à l'infini)

	Entête:

		Version [4 bit] : version 6
		Traffic Class:
			Priorité du paquet [6 bit]
			Contrôle de flux [2 bits] - Remplace le champs ToSType of service 
		Flow Label: [20 bits] - Permet d'identifier un type de flux plus simplement
		Payload [16 bits] - 0: jumbo payload  (mtu = 1280 o)
		Next Header [8 bits] : Définit le type de données (TCP, UDP, ESP, AH)
		Hop limit [8 bits] : = TTL
		Adresse Src et Dst : sur 128 bits


~~~~~~~~~~~~~~~~~~~~~~~~~
adressage statique/dynamique:
~~~~~~~~~~~~~~~~~~~~~~~~~

	Géré par les RIR (Regional Internet Registration)
		Par zone géographique. (un préfix different par zone)
		Amélioration du routage entre zone géographque

	Forme d'une IPv6
		-> /23 par l'IRS
		/23 -> /32 : préfix ISP
		/32 -> /48 : préfix du site
		/48 -> /64 : préfix sous réseau
		/64 -> /128 : Interface ID

	Statique:
		Soit définition manuelle de l'adresse
		Soit génération automatique avec l'EUI-64

	Dynammique:
		DHCP stateful
		DHCP stateless : s'appui sur NDP

	Fonctionnement similaire à IPv4:

		SOLICIT "@IP" ----> 	SERVEUR		(= DISCOVER)
		ADVERTISE     <----	SERVEUR		(= OFFER)
		REQUEST "@IP" ---->	SERVEUR		(
		REPLY         <----	SERVEUR

	Ports:
		UDP 546(client) && 547(serveur)
				
	Etats:
		
		stateful : Adresse fourni par le dhcp 
				Attention l'@Ip de la gateway n'est plus délivré par le dhcp mais par la GW même.
		stateless : Adresse partie hôte généré automatiquement (EUI 64), 
				Préfixe Réseau découvert par NDP

	Note: il est possible de configurer le serveur DHCP en stateless pour fournir les autres info comme l'@ DNS ...


~~~~~~~~~~~~~~~~~~~~~~~~~
Spécification
~~~~~~~~~~~~~~~~~~~~~~~~~

	Résumé:
		Il est possible de résumer une adresse Ipv6:

		-Uniquement sur le bloc contenant le plus de 0:
			(Ne peut s'appliquer qu'une foi)

			On résumera tout les bloc ne contenant que des 0 à la suite par "::"

		-Les bloc de 16bit commençant par 0 peuvent être supprimés:

			Exemple:

				fe80:0000:0000:0000:d63d:7eff:fe07:0058
				fe80::d63d:7eff:fe07:58

	NDP (Neighbor Discovery Protocol)
		Permet de découvrir l'adresse de la gateway via les requêtes:

			-RS : Multicast FF02::2 demandant le préfixe réseau et les adresses de gw par défaut. (-> tout les routeurs)
				client -----> serveur
			-RA : Multicast FF02::1 fournissant les infos (réseau et gw) (toute les 5 min avec un TTL de 20 min) (-> tout les noeuds =~ broadcast)
				client <----- serveur

				Les RA peuvent être envoyés périodiquement ou sur demande (RS) du client.

	Interface ID:
		Correspond à l'adresse hôte (sur 64 bit)

	EUI-64 : Génération d'une IP automatiquement avec l'adresse MAC de l'hôte.

		Partie hôte:

			1ere moitier MAC (+bit U/L) | FFFE | 2ème moitier MAC

			exemple:

				@MAC : d5:6f:8e:05:1d:12
				-->
					d56f:8eff:fe05:1d12

	Bit U/L (Universal/Local):

		Influt le 7ème bit de l'interface ID.

		0 : BIA (Burned In Address) --> Adresse MAC non changé
		1 : --> Valeur défini localement

			Il faut recalculer le premier bloc en changeant se bit.
	
			

	Multicast (FF) :

		Scope:

			En hexa;
			Définit l'étendue de la diffusion des adresses multicast:

			1 : noeud
			2 : lien local
			5 : site local
			8 : organisation
			E : global (internet)

		Quelques adresses:

			FF02::1	-> tous les noeuds du lien
			FF02::2 -> tous les routeurs du lien
			FF02::5 FF02::6 -> Messages OSPF	(224.0.0.5 224.0.0.6)
			FF02::9 -> Messages RIP v2		(224.0.0.9)
			FF02::A -> Messages EIGRP		(224.0.0.10)
			FF02::1:2 -> Agent Relais DHCP

	Documentation:
		2001:DB8::/32

	MTU:
		1280 o
		Fixe de la taille du MTU via ICMP

~~~~~~~~~~~~~~~~~~~~~~~~~
DHCP IPv6
~~~~~~~~~~~~~~~~~~~~~~~~~

	PLus de broadcast niveau client mais multicast FF02::2:1
	Sollicit: =discover
	Advertise : =offer
	Request : =request
	Confirm : 
	... à finir 

	Relai DHCP existe aussi pour IPv6

~~~~~~~~~~~~~~~~~~~~~~~~~
Adressage ISATP - Instrasite Automatic Tunnel Adressing protocol
~~~~~~~~~~~~~~~~~~~~~~~~~
	Encapsulation d'une IPv4 dans de l'IPv6
	
~~~~~~~~~~~~~~~~~~~~~~~~~
Structure de l'adresse TEREDO
~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~
Comparaison avec Ipv4 + conventions de nommages
~~~~~~~~~~~~~~~~~~~~~~~~~

	Type d'adresse		IPv6				IPv4								Note


	Unicast			Décliné en Global unicast	Toutes les adresses IPv4
				et unique local unicast		

	Publique		Adresse Global unicast		Toutes les adresses non comprises dans les plages privées.
				2000::/3

	Unique local		FD00::/8			

	Global unicast		2000::/3
            IP allouées par l'IANA          2001::/16
            ...

	Lien local		FE80::/10			
	(Link local)

	Anycast			une même @IP définit  			(cette méthode permet de discuter avec
				sur plusieurs hôtes			le noeud le plus proche ayant cette IP)	

	Broadcast		Notion disparu			Tout les bit partie hôte sont à 1
				Peut se comparer à FF02::1	

	Multicast		FF00::/8 +scope			224.0.0.0 à 239.255.255.255

	DNS (Address)		AAAA				A

	DNS inverse		ip6.arpa			ip4.arpa 	(à détailler)

	Loopback		::1/128				127.0.0.1

	Privée (NAT66)		FC00::/7			


~~~~~~~~~~~~~~~~~~~~~~~~~
Cohabitation Ipv6 et Ipv4
~~~~~~~~~~~~~~~~~~~~~~~~~

	Dual stack:
		Fonctionnement en Ipv4 et Ipv6

	Adresses ISATP (Instrasite Automatic Tunnel Adressing protocol):
		Utile pour l'interconnexion de réseaux en dual stack

		complement du préfix sur les 32 premiers bits:
			00 00 5E FE si @IPv4 privée
			02 00 5E FE si @Ipv4 pub

	Adresse Ipv4 Mappée:

		80 premiers bit à 0

		Ipv4 = A.B.C.D
		Ipv6 = ::FFFF:A.B.C.D

	Méthodes:

		Dual stack	: équipement gères Ipv6 et Ipv4
		Tunneling	: encapsulation de l'IPv6 dans de l'Ipv4
		Translation	: Via les ALGs (Application Level Gateways) l'adresse Ipv6 est traduite en Ipv4 et inversement
		Address Embedding : (Ip mappées) , les adresses Ipv4 sotn transportées dans le paquet Ipv6


