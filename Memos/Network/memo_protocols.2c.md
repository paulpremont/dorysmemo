======================================================================
		P R O T O C O L E S   -   R E S E A U X                	
======================================================================

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Définitions
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Les protocoles réseaux définissent une méthode des règles et des procédures à respecter pour émettre et recevoir des données sur un réseau.

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Modèles de référence
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                 ____________________________________________________________________________________________________________________
                |TCP/IP         |OSI                            |Rôle
                |_______________|_______________________________|____________________________________________________________________
                |Application    |7 Application (APDU):          |Initie/accepte une requête réseau. Permet de determiner le type de communication, Email, Filetransfert, client/server ...
                |               |_______________________________|____________________________________________________________________
                |               |6 Présentation (PPDU):         |Ajoute des informations de formatage, d'affichage, de chiffrement.
                |               |_______________________________|____________________________________________________________________
                |               |5 Session (SPDU):              |Ajoute des informations de flux (départ d'un paquet...). Gère les session entre applications (Débute, Arrête les sessions).
                |_______________|_______________________________|____________________________________________________________________
                |Transport      |4 Transport (TPDU):            |Ajoute des informations pour assurer la livraison des paquets.
                |_______________|_______________________________|____________________________________________________________________
                |Internet       |3 Réseau (Paquet):             |Ajoute des informations d'adressage au paquet.	
                |_______________|_______________________________|____________________________________________________________________
                |Accès réseau	|2 Liaison de données: (trame):	|Ajoute des informations de contrôle d'erreurs d'un paquet (CRC), permet la transmission entre les différents noeud.
                |               |_______________________________|____________________________________________________________________
                |               |1 Physique (bit):              |Emet les paquets sur le réseau sous la forme d'un flot de bits bruts. (Signal Electrique et câbles)
                |_______________|_______________________________|____________________________________________________________________

                *APDU= Application Protocol Data Unit


                Les protocols usuels et leurs ports associés sont disponibles dans:
                        /etc/services

========================================================
	COUCHE 1	Physical   	
========================================================



========================================================
	COUCHE 2 	Data-link
========================================================

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Ethernet (opère sur la couche 1 & 2)
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Champs des trames Ethernet IEEE 802.3

                        [Préambule] (7 octets): 	Suite de 0 et 1 alternés. Il permet à l'horloge du récepteur de se synchroniser sur celle de l'émetteur. 
                        [Délimiteur de début de trame (SFD)] (1 octet): Indique l'arrivée d'une trame (10101011).
                        [Adresse destination] (6 octets): Adresse MAC (Media Access Contrôl) du destinataire (Unicast, Multicast ou Broadcast).
                                                        Dans le cadre d'un broadcast, l'adresse utilisée est FF-FF-FF-FF-FF-FF.
                                                        Les 3 premiers octets désignent le constructeur, et les 3 derniers, le numéro d'identifiant de la carte.
                        [Adresse source] (6 octet): 	Adresse MAC de la source
                        [Longueur/Type] (2 octets): 	Si la valeur est infèrieur à 1536 (décimal), soit 0x600 (hexadécimal), alors elle indique la longueur. 

                                -La longueur indique le nombre d'octets de données qui suit ce champ.
                                -Le type précise le type de protocole de couche supérieure qui reçoit les données:
                                        0x6000 - DEC
                                        0x0609 - DEC
                                        0*0600 - XNS
                                        0x0800 - IPv4
                                        0x0806 - ARP
                                        0x8019 - Domain
                                        0x8035 - RARP
                                        0x8100 - 802.1Q
                                        0x86DD - IPv6

                                        Dans le cadre d'une trame VLAN taggé 802.1Q, 4 octets s'ajoutent:

                                                [Priorité] (3 bits): 000 = la plus basse, 111 : la plus haute
                                                [Canonical Format Indicator CFI] (1 bit): utilisé pour des raisons de compatibilité entre les réseaux Ethernet et les réseaux de type Token ring.
                                                [VLAN ID] (12 bits): représente le numéro de VLAN. (si = 0 : pas de VLAN mais application de la  priorité)
                                                [EtherType] (2 octets): Idem que champ [type], voir ci-dessus.

                        [Données/Remplissage] (46 à 1500 octets): Si il n'y a pas assez de données, des données de remplissage viennent alors s'ajouter pour remplir les 64 octets minimaux.
                        [FCS/CRC] (4 octets): 		Contient une valeur calculée du contenu de la trame. Le destinataire recalcule la valeur afin de voir si la trame a été endommagée.

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	STP - Spanning Tree Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Sert à déterminer une topologie réseau sans boucle au sein d'une LAN.

                Mécanisme:
                        TODO

                Champs d'en tête:
                        TODO


	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	CDP - Cisco Discovery Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Protocol propriétaire Cisco, il permet d'obtenir des informations sur les dispositifs voisins et d'établir une topologie.

                Envoyé en multicast toutes les 60 secondes par défaut.

                Les infos CDP:
                        
                        [ID de dispositif] : Nom d'hôte et nom de doamine du voisin.
                        [Liste d'adresses] : Une adresse pour chaque protocole routé voisin.
                        [ID de port] : Interface du voisin utilisée pour se connecter au routeur.
                        [Liste de capacités] : Fonction du dispositif voisin (routeur, pont, commutateur ...).
                        [Version IOS] : Version du IOS voisin.
                        [Plateforme] : Type de dispositif.



========================================================
	COUCHE 3	Network	
========================================================

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	ARP - Address Resolution Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
                Il se situe à l'interface entre la couche 3 et 2.
                Il effectue une traduction d'une adresse de protocole réseau en une adresse de couche liaison.
                Exemple : Adresse IP --> Adresse MAC

                Ce protocole est nécéssaire au fonctionnement IPv4.
                Pour le IPv6, c'est le protocole NDP (Neighbor Discovery Protocol) qui reprend les fonctions de ARP.

                Fonctionnement:
                        
                        Dans le cas où un ordinateur veut émettre une trame ethernet à un ordinateur sur le même réseau dont il connait son adresse IP. 
                        L'ordinataire source emet une requête ARP en broadcast afin de récupérer l'adresse MAC de destination.
                        Seule la machine ayant l'adresse IP contenue dans la requête répondra en transmettant sont adresse MAC.
                        L'ordinateur source tient alors à jour son cache ARP contenant les correspondances IP/MAC Address.

                        Si on utilise un routeur, les requêtes ARP , n'appartenant pas directement à son réseau, sont à la charge du routeur.
                        Si le routeur a une route directement connecté concernant une IP, il transmettra ses requêtes ARP sur celle-ci. 
                        
                        Le routeur peut répondre aux requêtes ARP si il dispose d'une route concernant cette requête ou bien même si il dispose d'une règle Nat.


                En-tête ARP:

                        [Hardware type] 		(16 bits): 	Indique le type de matériel.
                                                                        Exemple:
                                                                                01 : Ethernet (10MB) JBP
                                                                                02 : Experimental Ethernet (3Mb) JBP
                        [Protocol type] 		(16 bits): 	Indique le type de protocole de couche 3 qui utilise ARP
                        [Hardware Address Length] 	(8 bits): 	Longueur de l'adresse physique en octets.
                        [Protocol Address Length 	(8 bits):  	Longueur de l'adresse réseau en octets.
                        [Operation] 			(16 bits): 	Indique la fonction et l'objectif du message (Request = 01 et Repply = 02).
                        [Sender Hardware Address] 	(32 bits): 	Adresse MAC source dans le cadre d'Ethernet
                        [Sender Protocol Address] 	(32 bits): 	Adresse IP source dans le cadre TCP/IP
                        [Target Hardware Address] 	(32 bits): 	Adresse MAC destination dans le cadre Ethernet.
                        [Target Protocol Address] 	(32 bits): 	Adresse IP destination dans le cadre TCP/IP.

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	RARP - Reverse Address Resolution Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		TODO


	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	IP v4
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		[Version] 			(4 bits):	Indique la version du protocole IP utilisée.
		[Longueur d'en tête (IHL)]	(4 bits):	Nombre de mot de 32 bits constituant l'en tête (valeur minimale = 5)
		[Type de service (ToS)]		(8 bits):	Indique la façon dont le datagramme doit être traité.
		[Longueur totale] 		(16 bits):	Précise en octets, la longueur du paquet IP, y compris les données de l'en-tête.
		[Identification]		(16 bits):
		[Drapeau]			(3 bits):
		[Décalage fragment]		(13 bits):
		[Durée de vie (TTL)] 		(8 bits):	Compteur qui se décrémente jusqu'à 0. Si = 0 alors le datagramme est supprimé.
		[Protocole]			(8 bits):	Permet de savoir de quel protocole est issu le datagramme:
								   ICMP: 	1
								   IGMP: 	2
								   TCP: 	6
								   UDP:	17
		[Somme de contrôle] 		(16 bits):	Assure l'intégrité de l'en-tête IP
		[Adresse IP source] 		(32 bits):	Indique le noeud destinataire.
		[Adresse IP destination]	(32 bits): 	Indique le noeud récepteur.
		[Données] 			(jusqu'à 64Ko):	Contient les informations de couche supèrieure.
		[Remplissage]:					Des 0 sont ajoutés pour s'assurer que l'en-tête IP soit toujours multiple de 32 bits.
		


	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	PROTOCOLES DE ROUTAGES
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		Il définissent:
			Comment envoyer les mises à jours;
			Les informations contenues dans ces mises à jours;
			Le moment où ces informations doivent être envoyées;
			Comment localiser les destinataires des mises à jour.

		Exemples de protocoles de routage:

            IGP : (Interior Gateway Protocol):
                
                            Link State          Distance vector     Hybride
                VLSM         IS-IS, OSPF           RIPv2            EIGRP
                Classful                           IGRP, RIP

                Note: pour IPv6 : IS-IS, OSPFv3, RIPv6

            EGP: (Exterior Gateway Protocol): (routage entre AS)
                
                -EGP (lui même, il est maintenant obsolète)
                -BGP (Border Gateway protocol) utilisé pour le routage internet (en v4 actuellement)
                -ES-IS (Exterior System to Interior System)


		Ces protocoles peuvent utiliser des algorithmes différents:
			-Vecteur de distance;
			-État de liens;
			-Hybride symétrique.

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	RIP v2 - Routing Information Protocol version 2
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                (RIPv1 : Cette version ne prend pas en charge les masques de sous-réseaux de longueur variable ni n'authentification des routeurs.

                Protocole de routage IP de type "Vector Distance" faisant partie de la famille des IGP (Interior Gateway Protocol).
                Ce protocole permet à un routeur de communiquer sa métrique, c'est à dire le nombre de sauts (hops) qui les séparent d'un réseau IP pour déterminer une route.
                
                RIP est limité dans le sens où il ne prend pas en compte l'état de la liaison (bande passante ...). De plus, le nombre de saut est limité à 15 (pour éviter les boucles de routage).

                Spécifications RIPv2:
                        -Classless
                        -Multicast pour les maj
                        -Préfixe et masques de sous-réseau dans les maj
                        -Support du VLSM
                        -Authentification des voisins

                Spécification RIPv1:
                        -Classful
                        -Broadcast pour les maj
                        -Préfixes dans les maj

                En tant que protocole de routage à vecteur de distance, RIP utilise quatre compteurs:
                        -Update: Intervalle de temps entre les maj périodiques.
                        -Invalid: Intervalle de temps après réception de la dernière maj pour chaque entrée dans la table de routage avant de la considérer comme périmée. Après ce temps, l'entrée concernée ne sera plus analysée lors du parcours de la table de routage.
                        -Holddown: Intervalle de temps après réception de la dernière maj avant d'autoriser le remplacement de cette route par une autre moins bonne.
                        -Flush: Intervalle de temps après réception de la dernière maj pour chaque entrée dans la table de routage avant de la supprimer de la table de routage.

                En-tête RIPv2 :

                        [Commande] (8 bits): 		Requête/réponse ou diffusion.
                        [Version] (8 bits):		Version du protocole utilisé (1 ou 2).
                        [Routing Domain] (16 bits)	Permet de découper le réseau en sous-réseaux.
                        [Address family identifier] (16 bits): 
                        [Route tag] (16 bits):		Marqueur qui peut être utilisé pour distinguer les routes apprises en interne par RIP de celles apprises par d'autres protocoles (ex: OSPF)	
                        [Adresse IP] (32 bits):
                        [Masque] (32 bits):	
                        [Metric] (32 bits):		Distance de la route (entre 1 et 15).


	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	IGRP - Interior Gateway Routing Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
		Protocole de routage à vecteur de distance propriétaire Cisco de type IGP. Il a été conçu pour remplacer RIP. Ce protocole est capable de fonctionner sur des réseaux hétérogène de très grande taille et propose un calcul des métriques basé sur les critères suivants:
			-Bande passante
			-Délai
			-Fiabilité
			-Charge

		La métrique est un nombre de 24 bits calculé selon les critère suivants:

			K1 : Coef bande passante (def = 1)
			K2 : Coef charge (def = 0)
			K3 : Coef délai (def = 1)
			K4 : Coef fiabilité (def = 1)
			K5 : coef MTU (def = 0)
			Bandwidth: Correspond à la plus petite bande passante de liaison entre les hôtes source et destination. 
				Cette valeur est calculée avec la formule 10^7 / BP (Kbps)
			Load: Charge sur la liaison. C'est un pourcentage binaire pouvant aller de 0 à 255.
			Delay: Délai de transmission sur le chemin exprimé en microseconde.
				C'est la somme des délais de toutes les liaisons entre les hôtes source et destination.
				Cette valeur est calculée via la somme des délais.
			Reliability: Fiabilité de la liaison. 
				Pourcentage binaire pouvant aller de 0 à 255.
				Déterminé par le ratio entre le nombre de paquets corrects et le nombre de paquets transmis sur le média.

		Formule:

			Métrique = (K1 + Bandwidth + K2 * Bandwidth / (256 - Load) + K3 * delay) + K5 / (Reliability + K4)

		Il peut y avoir jusqu'a 4 routes pour une même destination dans la table de routage. Ces routes peuvent être de 3 types:
			-Intérieure: Route entre des sous-réseaux directement connectés au routeur local.
			-Système: Route interne au système autonome propagée par un routeur.
			-Extérieure: Route externe à l'AS qui a été redistribuée dans l'AS IGRP (inclus aussi les routes statiques redistribuées).

		En tant que protocole de routage, IGRP utilise 4 compteurs (voir protocole RIP).

		IGRP utilise aussi les maj Poison Reverse. Ceci permet de placer des routes directement à l'état Holddown. Toute route dont la métrique augmentant d'un facteur de 1.1 fera l'objet d'une maj Poison Reverse.

	
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	EIGRP - Enhanced IGRP
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		Protocole propriétaire Cisco, c'est une version améliorée d'IGRP qui utilise la même technologie à vecteur de distance.

		Améliorations:
			-Propriétés de convergence.
			-L'efficacité des opérations du protocole

		Caractéristiques principales:
			-Protocole de routage Classless avec support VLSM
			-Algorithme DUAL
			-Maj incrémentales avec adressage multicast via RTP (fiable)
			-Utilisation de la bande passante réduite par rapport à IGRP.
			-Utilisation d'un métrique composite.
			-Découverte des voisins.
			-Principe de successeur avec des multiples FS.
			-Agrégation de routes manuelle
			-Etat des routes (Active et Passive)
			-Partage de charge entre chemins n'ayant pas les mêmes métriques.
			-Compatible avec IGRP
			-Distance administrative de 90

		Pour chaque protocole routé, EIGRP maintient 3 tables:
			-Neighbor Table
				Etat des voisins (Hello)
			-Topology Table
				Contient les informations de la topologie (DUAL, Update, Query, Reply, ACK)
			-Routing Table
				Contient les successeurs pour chaque réseau de destination (Décisions de routage)

		Métriques (sur 32 bits):
			
			Il peut y avoir jusqu'a 6 routes pour une même destination dans la table de routage et ces routes peuvent être de 3 types:
				-Internal: route interne à l'AS
				-Summary: Routes internes mises sous la forme d'un unique agrégat de routes.
				-External: Route externe à l'AS qui a été redistribuée dans l'AS EIGRP (inclus aussi les routes statiques redistribuées)

			Métrique = (K1 * Bandwidth + K2 * Bandwith / (256-Load) + K3 * Delay) + K5 + (Reliability + K4)

				K1: Coefficient rattaché à la bande passante (1 par défaut)
				K2: Coefficient rattaché à la charge (0 par dafaut)
				K3: Coefficient rattaché à la fiabilité (0 par défaut)
				K4: Coefficient rattaché à la fiabilité (0 par défaut)
				K5: Coefficient rattaché au MTU (0 par défaut)
				Bandwidth: Valeur correspondant à la plus petite bande passante de liaison entre les hôtes source et destination. Cette valeur est calculée avec la formule 10^7 / BP * 256 (BP en Kbps).
				Load: Charge sur la liaison. C'est un pourcentage binaire dont la valeur peut aller de 0 à 255.
				Delay: Délai de transmission sur le chemin exprimé en microsecondes (us). C'est la somme des délais de toutes les liaisons entre les hôtes source et destination. Cette valeur calculée via la formule [Somme des délais] * 256.
				Reliability: Fiabilité de la liaison. C'est aussi un pourcentage binaire dont la valeur peut aller de 0 à 255 et qui est déterminée par le ratio entre le nombre de paquets corrects et le nombre de paquets transmis sur le média.

				Soit la métrique par défaut:
				(10^7 / BP + [Somme délais])* 256.
				
				La métrique EIGRP est 256 fois plus grande qu'une métrique d'IGRP pour une même destination.
			
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	HELLO
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		Permet l'échange des informations de routage entre les routeurs utilisant le protocole EIGRP ainsi que la découverte dynamique des voisins. Certains messages utilisent RTP afin d'assurer la bonne réception des informations.
		
		Les paquets du protocole Hello utilisent le multicast et se servent de l'adresse 224.0.0.10

		Plusieurs types de paquets:
			
			Hello:
				Emis périodiquement
				Non orienté connexion
				Toutes les 5s sur LAN
				Toutes les 60s sur WAN

			Update:
				Infos dces réseaux connus par un routeur EIGRP.
				Orienté connexion avec RTP
				En unicast s'il sagit d'un nouveau voisin, sinon multicast.

			Query:
				Requête vers un voisin en vue d'obtenir des informations sur les différents réseaux connus par ce dernier. Celui-ci répondra, via des paquets Reply.
				Envoyé lorqu'une destinations passe à l'état Active.
				Orienté connexion RTP
				Envoyé en multicast
				Permet d'enquêter sur un réseau suspect.

			Reply
				Réponse a Query
				Orienté connexion RTP
				unicast

			ACK
				Accusé de réception pour les paquets envoyés orientés connexion
				unicast
				Paquet Hello sans données qui contient un n° d'accusé de réception différent de 0
				Fenetrage = 1. Ceci implique qu'un paquet ACK est envoyé pour chaque Query, Reply et Update (sinon réenvoi de ces derniers).
				Après 16 essais unicast, le routeur marquera le voisin comme mort.


	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	OSPF - Open Shortest Path First
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		Protocole de routage libre à état de lien. C'est l'IGP (Interior Gateway Protocol) le plus répendu.


		Princpales caractéristiques:
			-Émissions des maj déclenchées par modification topologique.
			-Connaissance exacte et complète de la topologie réseau.
			-Chaque noeud connaît l'existence de ses voisins adjacents.
			-Utilisation d'un arbre et d'un algorithme du plus court chemin (SPF Tree & algo de Dijkstra) pour générer la table de routage.
			-Envoie des maj topologiques via une adresse multicast et non broadcast.
			-Utilisation moindre de la bande passante.
			-Protocole de routage classless supportant le VLSM
			-Domaines de routage exempts de boucles de routage.
			-Métrique : côut (chaque liaison a un côut)
			-Détermination d'un ou plusieurs domaines de routag appelés Areas au sein d'un système autonome (AS).
	
		Les interfaces OSPF distinguent 4 types de réseaux:
			-Les réseaux multi-accès broadcast comme Ethernet
			-Les réseaux point à point 
			-Les réseaux multi-accès non broadcast ou encore Nonbroadcast multi-access (NBMA), tel que Fram Relay.
			-Les réseaux point à multipoint configuré manuellement par un admin.

		En tête OSPF:
			
			[Version]
			[pkt type]
			[length]
			[Source OSPF Router Id]
			[OSPF Area ID]
			[Packet Checksum]
			[Authentication type]
			[Authentication data]

		Fonctionnement dans un réseau ne comportant qu'une aire.

			1-Découverte des routeurs voisins:

				Recquiert le protocole "HELLO" pour envoyer des paquets "HELLO" à intervalles réguliers sur chaque interfaces en utilisant l'adresse multicats 224.0.0.5. Les voisins découverts sont ensuite enregistrés dans la "Neighbor Database".

			2-Etablissement de la bdd topologique:
				
				-Dans un réseau point à point:

					Envoie des paquets LSU (Link State Update) contenant des LSA (Link State Advertissement) pour maintenir à jour la "Topological Database". Ces informations contiennent les réseaux accessibles par les différents voisins (neighbor).

				-Dans un réseau multi-accès
					
					Tous les routeurs étant voisin, cela va soliciter beaucoup de trafic. C'est pourquoi le protocole HELLO va élire un DR (Designated Router) qui sera chargé de centraliser toutes les informations de modifications topologiques et de les retransmettre. Ainsi que l'election d'un BDR (Backup Designated Router) servant de secours.
					Tous les routeurs transmettent leurs information au DR par l'adresse multicast 224.0.0.6. 
					Le DR redistribuera ces informations avec l'adresse multicast 224.0.0.5.

		Opérations OSPF:

			Élection du DR/BDR:
				
				L'élection se fait grâce aux paquets HELLO qui contiennent l'ID du routeur et une priorité.
				Le routeur ayant la plus grande priorité sur le réseau multi-accès sera élu DR. Si tous ont la même priorité, les routeurs devront comparer leur router-id, le plus grand sera élu DR.
				Le BDR élu correspond à la deuxieme plus haute priorité.

			Détermination du Router-ID

				Le routeur ID correspond à une adresse IP.
				Si des interfaces Loopback sont présentes sur le routeur, le router-id correspondra à la plus grande adresse IP de ces interfaces.

				Si pas de loopback, alors le router-id sera la plus grande IP des interfaces actives.

				(Il est conseillé de faire usage des loopback)

		Construction de la table de routage:

			Lorsque tout les routeurs ont convergés, chacun d'entre eux va contruire à partir de sa base de données topologique, un arbre du plus court chemin d'abord (SPF Tree) grâce à l'algorithme SPF.
			SPF parcourt la bdd topologique et considère chaque routeur comme des sommets reliés par des liens point à point. Le routeur qui l'implémente sera placé à la racine de l'arbre du plus SPF Tree.
			Chaque lien va avoir un coût=10^8/bande passante (en bps). La métrique d'une route est calculée en faisant la somme de la bande passante de chaque lien de la route.
			SPF va parcourir ensuite le SPF Tree pour determiner les meilleures routes et les ajouter à la table de routage.



	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	ICMP v4 - Internel Control Message Protocol version4
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Protocole permetant de savoir si il y a eu un un incident réseau.
                Même si il est implémenté au même niveau que le protocol IP du modèle OSI, ce protocole est encapsulé dans un datagramme IP. 

		___________________
		Format paquet ICMP:
 
                        [En-tête IP]
                        [En-tete ICMP] 
                        [Données ICMP]

		___________________
		En tête:

                        [Type] (8 bit):		ICMP type
                        [Code] (8 bit):		Subtype
                        [Checksum] (16 bit):	Error checking data
                        [Rest of the Header] (32 bit):	Based on the ICMP type and code.

		___________________
		Deux catégories:

			-Messages d'erreurs
			-Messages de contrôle

		___________________
		Types de messages:

			0	Echo Reply
			3	Destination Unreachable
			4	Source Quench
			5	Redirect/Change Request
			8	Echo Request
			9	Router Discovery
			10	Router Solicitation
			11	Time Exceeded
		  	12	Parameter Problem
			13	Timestamp Request
			14	Timestamp Reply
			15	Information Request
			16	Information Reply
			17	Address Mask Request
			18	Address Mask Reply


		___________________
		-Echo 
			Determine si un hôte est joignable.
			La commande ping envoie un message Echo Request.
			Le destinataire renvoie un message Echo Reply.

			Données

				   [Identificateur](16 bits):
				   [Numéro de Séquence](16 bits): Utilisé pour distinguer les différentes requêtes effectuées.
				   [Remplissage](variable):
		
		___________________
		-Destination Unreachable

			Envoyé par l'hôte s'il ne dispose pas de toute les informations pour transmettre un paquet.

			Données

				   [Inutilisé](16 bits):
				   [En-tête paquet source + 64 premiers bits]

				   Les différents codes:

						 0	Réseau inaccessible
						 1	Hôte inaccessible
						 2	Protocole inaccessible
						 3	Port inaccessible
						 4	Fragmentation nécessaire mais refusée
						 5	Echec de la route source
						 6	Réseau de destincation inconnu
						 7	Hôte de destination inconnu
						 8	Hôte source isolé
						 9	Communication avec le réseau de destination administrativement refusée
						 10	Communication avec l'hôte de destination administrativement refusée
						 11	Réseau inaccessible pour le ToS utilisé
						 12	Hôte inaccessible pou le ToS utilisé

		___________________
		-Parameter Problem 

			Envoyé lorsqu'un paquet n'a pas pu être tranmis à cause d'une erreur d'en tête ICMP.

			Données:

				   [Pointeur]	(8 bits): Indique l'octet de l'en tête IP posant problème.
				   [Inutilisé]	(8 bits): =0
				   [En-tête du paquet source + 64 premiers bits]

		___________________
		-Source Quench 

			Envoyé par un dispositif réseau subissant une congestion réseau. Ne pouvant pas traiter tous les paquets entrants en cas de congestion, il est obligé d'en supprimer. Les sources des paquets supprimés sont averties par ce message ICMP.

		___________________
		-Redirect/Change Request

			Permet la notification à la source qu'une meilleure route existe pour une destination précise.

			Ce message est envoyé uniquement si:
				-Interface d'entrée = interface de sortie
				-Réseau de la source = réseau du prochain saut
				-Route dans la table de routage  != route par défaut
				-Paquet reçu n'est pas un ICMP Redirect
				-Routeur configuré pour envoyer des messages ICMP Redirect.
			Données:
				[IP routeur] (32 bits):
				[En tête paquet source + 64 premiers bits]:

			Code:
				0	Redirection pour le réseau de destination
				1	Redirection pour l'hôte de destination
				2	Redirection pour le ToS pour le réseau de destination
				3	Redirection pour le ToS pour l'hôte de destination

		___________________
		-Timestamp Request/Reply

			(Remplacés par le protocole NTP (Network Time Protocol))

			Données:
				[Identificateur]
				[N°séquence]
				[Temps d'origine]
				[Temps reçu]
				[Temps envoyé]

		___________________
		-Information Request/Reply
			Messages qui étaient utilisés par un hôte pour déterminer son adresse réseau. (Remplacés par les protocoles BOOTP, RARP et DHCP)

		
		___________________
		-Adress Mask Request/Reply
			Messages qui permettent à un hôte de demander à sa gateway le netmask.

		___________________
		-Router Discovery/Solicitation
			Indiquer aux hôtes d'un réseau l'adresse de la gateway.

			ICMP Router Solicitation : envoyé par un hôte n'ayant pas de gateway.
			ICMP Router Discovery : envoyé par le routeur en réponse à un message ICMP Router Solicitation.

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	ICMP V6 - Internet Control Message Protcol version 6 (IPv6)
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	TODO

========================================================
	COUCHE 4	Transport
========================================================

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	RTP - Real-time Transport Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	Protocole utilisé principalement pour la VoIP, Vidéo Conférence et même streaming.
	Utilise UDP pour le transport de données, mais rajoute une en-tête comportants plusieurs informations.
	Ces informations aiderons le récepteur à corriger la gigue, réordonner les paquets... (utilisation de buffer...)
	
	
		Champs de l'entête RTP:
	
		[Version V] 	(32 bits):	Version du protocole (V = 2).
		[Padding P] 	(1 bit):	Si P=1 -> le paquet contient des octets additionnels pour finir le dernier paquet.
		[Extension X] 	(1 bit):	Si X=1 -> l'en-tête est suivi d'un paquet d'extension.
		[CSRC count CC] (4 bits):	Contient le nombre de CSRC qui suivent l'en-tête.
		[Marker M] 	(1 bit):	Interprété selon son profile d'application (profil).
		[Payload Type PT] (7 bits):	Définis le type de payload (charge utile) (audio, vidéo, image, html ...).
		[Séquence number] (16 bits):	Valeur initiale aléatoire, ++1 à chaque paquet envoyé (pour détecter les paquets perdus).
		[SSRC]		(32 bits):	Identifie de manière unique la source. Sa valeur est choie aléatoirement par l'appli.
		[CSRC]		(32 bits):	Identifie les sources (SSRC) qui ont contribué à l'obtention des données du paquet.
		[Timestamp]	(32 bits):	Reflète l'instant où le premier octet du paquet RTP a été échantilloné. 
						Cet instant doit être dérivé d'une horloge qui augmente de façon uniforme et linaire afin de permetre la synchronisation et calculer la gigue.
	
	
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	RTCP - Real-time Transport Control Protocol (complément du RTP)
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Il transmet à intervalle des paquets de contrôle contenant des statistiques et des informations sur la session ouverte. 
	Les stats circulent sous forme de rapports:
		Les Sender Report (SR)
		Les Receivers Report (RR)
		
	Ils contiennent par exemple, le nombre de paquets envoyés depuis le début de la session ou encore le nombre d'octets déja envoyés ainsi que le taux de pertes.
	On peut ainsi détécter si les conditions de trafic réseau se dégrade.
	

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	TCP - Transmission Control Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Protocole orienté connexion (Etablir une connexion entre 2 hôtes en utilisant le même chemin virtuel)

	Méthode de connexion TCP:

		Nécéssite de réspécter 3 points importants:

			-Un chemin unique entre la source et le destinataire;
			-Transmission séquentielle (les données arrivent dans l'ordre);
			-Connexion fermée lorsqu'elle n'est plus nécessaire.

		Connexion ouverte en 3 étapes:

			-L'émetteur envoie un paquet avec un numéro de séquence initial {Syn(seq=x)}.
			-Le destinataire le reçoit, consigne le numéro de séquence initial, répond par un accusé de réception et inclut son propre numéro de séquence {Syn+Ack(seq=y ack=x+1)}.
			-L'émetteur reçoit x+1 et renvoie y+1 pour dire au destinataire que la réception s'est bien passé {Ack(seq=x+1 ack=y+1)}.

		Fenêtrage: (méthode de la fenêtre glissante)

			Le fenêtrage est un mécanisme dans lequel le récepteur envoi un accusé de réception après avoir reçu un certain nombre de données.

		Temporisation:
			
			C'est le temps qu'attend un hôte pour réemettre un paquet si il n'a toujours pas reçu d'ACK.

		Contrôle de flux:

			Chaque hôte dispose d'un tampon de réception dont la taille est limité.
			Chaque segment contient la taille disponible dans le tampon de réception de l'hôte qui l'a envoyé pour le prévenir.
			En réponse, l'hôte emeteur va réduire la taille de la fenêtre d'envoi afin de ne pas le surcharger.

		Contrôle de congestion.

			Gràces aux acquittements on peu déduire si le réseaux est congestionné ou non.
			Dans ce cas les hôtes vont transmettres les données plus lentement.


		To BE CONTINUED...


	Structure d'un Segment TCP:

		[Port Source] (16 bits): 	Numéro du port source.
		[Port Destination] (16 bits):	Numéro du port destinataire.
		[N° Séquence] (32 bits):	Numéro de séquence du premier octet de ce segment (ISN = Initial Sequence Number)
                                                Il sert au réassemblage ordonné des messages.
		[N° Acquittement] (32 bits): 	Numéro de séquence du prochain octet TCP attendu.
		[Longueur en-tête] (4 bits):	Taille de l'en-tête (en mot de 32 bits)	
		[Flags/Control-bits] (6 bits):	Permet de connaître l'état de connexion:

			-URG : Signale la précence de données urgentes.
			-ACK : Signale que le paquet est un accusé de réception.
			-PSH : Données à envoyer tout de suite.
			-RST : Rupture anormale de la connexion.
			-SYN : Demande de synchronisation ou établissement de la connexion.
			-FIN : Demande de fin de connexion.

		[Fenêtre] (16 bits):		Taille de la fenêtre demandée 
                                                (le nombre d'octets que le récepteur souhaite recevoir sans accusé de réception).
		[Checksum] (16 bits):	        Somme de contrôle calculée des champs d'en-tête et de données.
		[Options] (22 bits):		Facultatives.
		[Remplissage] (10 bits):	Les bit 0 rajoutés pour avoir 32 bits minimum.
		[Data] (variable):		Données de protocole de couche supèrieure.



	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	UDP - User Datagram Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Protocole non orienté connexion, il est plus légé que TCP.

	Datagramme UDP:
		
		[Port Source] (16 bits):	N° de port source.
		[Port Destination] (16 bits):	N° de port destinataire.
		[Longueur] (16 bits):		Longueur totale, en octet, du datagramme (8 octets minimum).
		[Checksum] (16 bits):		Somme de contrôle permettant de s'assurer de l'intégrité du paquet reçu.


========================================================
	COUCHE 5	Session
========================================================

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	NBNS - NetBIOS Name Service
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Nommé aussi WINS pour les systèmes Windows.

	Le but de ce protocole est de procurer tout comme le DNS, un système de résolution de nom.

	Il fonctionne uniquement en IPv4.

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	SOCKS - Socket Secure
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            http://en.wikipedia.org/wiki/SOCKS

            C'est un protocol situé entre la couche transport et applicative pour router des paquets entre un client et serveur au travers d'un serveur socks.

            Il est utilisé comme serveur proxy socks mais plus souple qu'un serveur proxy standard car il gère bien plus de protocol.

            Depuis la version 5 il intégre des mécanismes d'authentification.


========================================================
	COUCHE 6	Presentation
========================================================


========================================================
	COUCHE 7	Application
========================================================

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	BROWSER - Microsoft Windows Browser
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Ce se base sur plusieurs acteurs (master, backup et client) chacun répondant à un besoin précis.
                Le but de ce protocole est de fournir la correspondance des hôtes d'un Workgroup et/ou domaine.

                Mécanismes :
                        TODO
                
                Champs d'en tête:

                        TODO

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	SMB v2 - Server Message Block
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Ce protocole permet le partage de ressource sur le réseau (fichier paratgés, imprimantes ...).
                Il remplace le protocole CIFS (lui même remplacant le protocole LAN Manager).
                SMB propose deux modes d'authentification qui sont:
                        -share : associe mot de passe -> ressource
                        -user : associe mot de passe -> utilisateur
                C'est le serveur qui négocie le chiffrement du mot de passe. Attention donc au détournement de flux.
                
                Champs d'en tête:

                        TODO

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	NTP v4 - Network Time Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                NTP permet de synchroniser l'horloge d'un hôte via le réseaux.

                L'heure de référence fournie par NTP est UTC et ne gère donc pas le changement d'heure dû au fuseau horaire et du passage à l'heure d'été et d'hiver. c'est le système qui s'occupera de cette tâche.

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	SNMP - Simple Network Management Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            https://kadionik.vvv.enseirb-matmeca.fr/embedded/snmp/net-snmp.html
            http://www.cisco.com/c/en/us/td/docs/ios/12_2/configfun/configuration/guide/ffun_c/fcf014.html

                Ce protocol permet de superviser un réseau et d'uniformiser les messages relatifs aux ressources d'un réseau. (Consommation, Charge, défaillance ...)

                over UDP:

                Ports:  161 Agent [server]
                        162 Manager [client]

                ___________________
                Les éléments:

                        Ce base sur un système de manager (superviseur), d'agent et de MIB (Management Information Base)

                                          polling (Get/Set)
                                [manager] ------> [Agent]
                                [manager] <------ [Agent]
                                           traps/responses

                        -Manager: Envoie les requêtes aux agent et agrémente les informations pour les rendre disponible à l'administrateur (via un NMS: Network Management System)
                        -Agent: Il envoi des infos sur demande du manager ou via des Trap pour. Dans ces informations on trouve les OID.
                        -OID : (Object Identifier) est une paire clé-valeur, qui peut être lue ou écrite par le manager.

                        -MIB: C'est une base qui va contenir tout les objets relatif à un équipement mais traduit de façon lisible pour l'humain.
                            La MIB sert donc à traduire les OID. 
                            Elle se trouve normalement coté Agent.
                            C'est une structure en arbre similaire à un DNS.

                        -polling : envoyer des requêtes clientes 
                            vérifications actives

                        -traps : envoyer des données vers un autre serveur SNMP
                            vérifications passives

                        -SMI : Structure décrivant les règles d'identification d'un OID.
                            

                ___________________
                Méthodes d'envoi d'information

                        Du Manager à l'agent:
                                
                                Le manager peur envoyer des requêtes à l'agent directement pour qu'il lui fournisse des informations. (Via des GET ou des SET par exemple).

                                get-request
                                get-next-request
                                set-request

                        De l'agent vers le manager:

                                Avec les Trap, peu gourmand en ressource et ne demandant pas d'acquitement (donc peu fiable). Les trap permettent d'envoyer des infos au manager pour l'alerter dans le cas ou une évenement survient (définis par l'admin).

                                get-response
                                trap

                                Les requêtes "inform" qui permettent à l'agent d'envoyer des infos mais demandant l'acquitement au manager. Tant que l'agent ne reçoit pas l'acquitement, il continu d'envoyer ses données.

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Radius
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            Voir aussi Diameter (plus récent et sécurisé)
            et TACACS (cisco propriétaire)

            A été developpé dans le but de fournir au FAI l'auth et le temps d'accès aux réseau RTC par les client (via leur modem).

            Assure le transport de données d'authentification vers une base externe ou interne et permet l'accounting.

            Supplicant (user) -> client RADIUS (équipement) -> Serveur


            Fonctionne avec EAP (pour 'divisé' le port en deux) et n'autoriser dans un premier temps que la communication EAP avec le supplicant pour l'auth avant d'ouvrir completement le port. (si l'auth à réussi)

            exemple:


            Supplicant          AP              Server

            802.11 Association
            WPA/WPA2    ->

                --802.1x--
                EAPOL-STart ->

              <-  EAP-Request Identify

              EAP-REsponse Identify ->  RADIUS Access-Request ->

                            --SSL/TLS Tunnel--

             <- EAP Request Crednetials <- RADIUS Access-Challenge
             EAP-Response-Credentials -> RADIUS Access-Request

                            --/SSL/TLS Tunnel--

            <- EAP-Success/failure  <-  Radius Access-Accept/Reject
                --/802.1x--

            <- 802.11 Keying -->
                WPA/WPA2
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    HL7 - Health Level 7
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        http://www.hl7.org/implement/standards/
        http://www.yakakliker.org/@api/deki/files/374/=HL7-1ini1.pdf
        http://www.corepointhealth.com/resource-center/hl7-resources

        C'est un protocole destiné aux systèmes d'information de santé.
        Il uniformise la structure de communication des différents appareils médicaux.

        Principe de fonctionnement:
            

            Un système source émet des messages hl7 après un trigger event au sous systèmes concernés.
            Les sous systèmes peuvent émettre un ACK en fonction du type de message ou encore exécuter des query pour demander des informations.


        Les type de messages:


            Trigger event : Evenement déclencheur (ex: admission d'un patient) d'envoie d'un messahe HL7
            A01 : message expedié lors d'un event admission de patient à tout les sous sytèmes concernés.
            A02 : idem lors d'un event transfert de patient.
            ...
            ADT : envoie d'un message d'admission (Admission, Discharge, Transfer)
            ACK : Accusé de reception des systèmes destinataires.
            Query : utilisées pour la demande d'information sur un patient.

            ORU : Transmission non sollicitée de message d'examen. (Résultat d'observation)
                Envoyé suite à un ordre (ORM)

                    Composé de 3 groupes:

                        -Patient Group  : Toutes les infos sur le patient (un patient par message ORU)
                        -Order Group    : Contient le nom du test effetué sur le patient.
                        -Observation Group  : Contient le résultat du test.

        Structure HL7:

            Un message est composé de plusieurs segments, eux même composé de plusieurs champs.

                { MESSAGE 
                    { SEGMENT: | CHAMP1 | CHAMP2 | }
                    ...
                }


            Le message:

                Message identifié par son type (ex: ADT) et portentielement par l'evenement déclenchant (ex : admission patient):

                Avec au minimum un segment d'en tête:

                    -Segment en-tête (MSH , Message Header Segment)

            Les segments:

                Contient plusieurs champs délimités par un séparateur de champs (ex: | )

            Les champs:

                Ils sont de longueur variable et determinés par un type de données:
                    
                    ST : chaîne de caractère
                    NM : numérique
                    CN : numéro d'id + nom
                    CE : élement codé: valeur du code + désignation + type de codage
                    MO : prix + type de monnaie
                    ...

            Règles d'encodage:
                
                | : séparateur de champ
                ^ : séparateur d'élement
                ~ : séparateur de répétition
                \ : échappement
                & : séparateur de sous-composant

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	UPnP - Universal Plug and Play
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            Basé sur HTTP et XML, UPnP permet le partage de contenu multimedia (Fichiers, Vidéo ...).

            Il est indépendant des médias et périphériques et se base sur l'adressage IP.

            Avec une partie découverte:
            Description
            contrôle
            notification d'evenement
            Présentation

            TODO

            Standards:
                UPnP AV (UPnP Audio et Video) est supervisé par la DLNA qui est un regroupement de constructeurs et vendeurs et définissant des standards visant l'interopérabilité des guides de conceptions.

            Les composants d'UPnP AV:

                - MediaServer DCP
                - MerdiaServer ControlPoint
                - MediaRander DMR
                - MediaRander DMP

            TODO
                
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	SIP - Session Initiation Protocol
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            http://www.testeur-voip.com/technologie-voip-explication.php?numpage=3
            http://fr.wikipedia.org/wiki/Session_Initiation_Protocol

            C'est en quelque sorte un successeur du H323

            Ce protocole est destiné à la gestion des sessions de communications.
            Utilisé surtout pour la VoIP.
            Il s'occupe uniquement de la signalisation.
            On va souvent employer RTC pour le transport.

            Il peut ressembler à HTTP notament sur certain message de réponse serveur:

                404: Not Found (Erreur)

            Les composants:

                UA (User Agents):

                    Agit comme un serveur (appelé) ou client (appelant).
                    Il permet via un soft ou un matèriel compatible SIP d'initier et recevoir un appel.

                Registrars:

                    C'est un annuaire pour la VoIP. Il stocke les URI (Uniform Ressource Identifier) des UA qui se sont inscrits.
                    Exemple d'URI:
                        sip:polo:user@mondomaine.fr

                Proxys:

                    Il permetent de mandater les demandes clientes . Il communique avec le registrar et donne les URI aux Agents.
                    Les UA établissent ensuite directement une session avec leur destinataire sans passer par le proxy.


======================================================================
	        Technos/protocoles par thèmes
======================================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Messagerie
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        POP
        IMAP
        SMTP
        PGP

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Partage de fichier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        DFS
        NFS
        NIS
        SSHFS
        FTP
        Samba

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
WEB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        HTTPS
        FTP
        TLS

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interconnexion
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        VPN
        TLS
        Ipsec
        SSH

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Connexion Hôte
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        SSH
        Telnet

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Redondance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        VRRP : Virtual Router Redundancy Protocol: redondance de routeur virtuel.
        CARP (Common Adress Redundacy Protocol) : partage d'une adresse IP pour plusieurs hôtes

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Répartition de charge
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

       
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Telecommunication
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Sécurisation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Transport
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Adressage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
