=====================================
COUCHE 1
=====================================
	----------------
	Généralités
	----------------

		Dans un WAN, la couche physique décrit principalement l'interface entre l'ETTD ((DTE) Equipement terminal de traitement de données) et l'ETCD (DCE Equipement de terminaison de circuit de données)
		
		ETTD = unité connecté au réseau du FA par l'ETCD (exemple: pc client)
		ETCD = unité connecté au réseau du fournisseur d'accès  (exemple: modem)

		Exemples de protocoles couche1:
			EIA/TIA-232
			EIA/TIA-449
			EIA/TIA-612/613
			v.24
			v.35
			X.21
			G.703

		caractéristiques d'un WAN:

			-Ils fonctionnent au niveau des couches physiques et liaison de données
			-portée plus grande qu'un LAN
			-Ils utilisent les services d'opérateurs Télécoms.
			-Ils utilisent divers connexions série pour communiquer.
	----------------
	Boucles locales
	----------------

                Raccorde l'usagé (CPE : Customer Premise Equipment) au réseau d'opérateur:
                Ce sont tout les éléments allants du répartiteur de l'opérateur à la prise de l'abonné.

                http://image.noelshack.com/fichiers/2010/21/1274973483-ipatm.jpg
		___________________
                Quelques techniques:

                        HFC: Hybrid Fiber Coaxial
                        DSL: Digital Subscriber Line
                        FO: Fibre Optique

		___________________
                Exemple de parcours:

                        CPE -> Boucle locale -> Commutateur de Rattachement -> Réseaux d'accès (NAP Network Access Provider) -> Réseaux de service NSP (Network Services Provider) = Internet/Frame-Relay ... 

	----------------
	xDSL
	----------------

                -Sigle générique pour les techno DSL utilisant les liaisons téléphoniques.
                -Module les signaux sur la boucle locale
                -Permet de transporter des données types voix/vidéo
                -Décliné en fonction des débits et distances et les modes de transmission (symétrique, asym )

		___________________
                ADSL: (Asymétrique DSL)

                        http://upload.wikimedia.org/wikipedia/commons/7/71/Principe_ADSL.png
                        Les Débits montants sont infèrieurs au Débits descendant.
                        Il est nécéssaire d'avoir un filtre (splitter sur la prise téléphone) pour séparer les flux dara et voix
                        sur 2km:
                               UPLOAD:  800 Kbps
                               DOWNLOAD: 8 Mbps

                        Les protocoles de couche 2 utilisé sur l'ADSL sont surtout:
                                ATM et TCP/IP

                        Il a permis d'optimiser la BP (Bande Passante) des lignes téléphoniques.
                        On peux y faire passer la data en direction d'internet et la voix sur du RTC (Réseau Téléphonique commuté) sur le même câble téléphonique via 3 canaux:
                                -Le haut de bande : 1 Mhz (DOWN)
                                -Le milieu de bande : 300-700 Khz (UP)
                                -Téléphonie analogique : 0 - 4 Khz

                        C'est le splitter qui permet la séparation de ces différents flux sur les différentes fréquences.
                        Il faut ensuite rajouter un modem pour convertir les données analogique en données numérique (et vis versa) et permet ainsi au pc de faire transiter son flux sur le réseaux analogique.


                        De l'abonné à Internet nous parcourons donc tous ces éléments:

                        Abonné -> Router xDSL (box) -> Boucle locale (xDSL) -> DSLAM -> Réseaux de transport (ATM/Ethernet) ->  BRAS -> Réseau du FAI (IP) -> Routeur Internet -> Internet
                        http://upload.wikimedia.org/wikipedia/commons/1/11/XDSL_Connectivity_Diagram_fr.svg

                        Le DSLAM servant à multipléxer les lignes téléphonique. Autrement dit il va concentrer les différente les différents type de données et les envoyer vers le bon réseau opérateur.

                        Rappel sur multiplexage:
                               C'est unet technique permetant de faire passer plusieurs informations à travers un seul support de transmission avec 2 grandes méthode: Temporelle et fréquentielle.
                               http://fr.wikipedia.org/wiki/Multiplexage

                        Le transport des données est assuré communément via 2 protocole de couche2 (voir ci la partie couche2), PPPoA et PPPoE eux même encapusé dans de l'ATM (du modem au BAS).

                        BAS: Broadband Access Server, il s'occupe du routage vers le FAI

		___________________
                ReADSL2: (Reach-Extended ADSL)

                        Augmente de 5 à 10% la porté de l'ADSL
                        Les débits sont par contre réduits:
                        Pour une porté de 5 à 8 km:
                                UPLOAD: 128 Kbps
                                DOWN : 512 Kbps

		___________________
                ADSL2+:

                        Augmente les débits de l'ADSL
                        Pour 2km on aura plutot en théorie bien entendu:
                                UP: 1 Mbps
                                DOWN:  25 Mbps

		___________________
                SDSL (Symetryc DSL)

                        Une porté de 2 à 3km
                                UP et DOWN de 144 Kbps à 2 Mbps
                        Il ne permet pas de partage de fréquences avec le téléphone 
                        et sert donc plutôt d'interco de sites

		___________________
                HDSL (High data rate DSL)
                        
                        Débits symétriques sur une porté de 4 KM: 2Mbps
                      
		___________________
                VDSL (Very High bit rate DSL)
                        Il permet le partage des data et et de la voix sur de courte distances:
                        50 m max:

                        Il peut aussi fonctionner dans les deux modes de transmissions:
                                asymétrique:
                                        UP: 1.5 à 6 Mbps
                                        DOWN: 13 à 52 Mbps

                                symétrique:
                                        34 Mbps

	----------------
	Réseaux sans fils (wireless)
	----------------

                IL existe plusieurs type de ces technologie utilisant les ondes radio pour véhiculer des informations.
                Les critères:
                        -Le domaine d'application
                        -La bande de fréquences d'émission et les débits associés
                        -la portées (zone de couverture)

		___________________
                WPAN (Personal Area Network)

                        porté =~ 10m

                        Exemple technos:
                                -Bluetooth (IEEE 802.15.1)
                                        débits =~ 1 Mbps
                                -Home RF
                                -ZigBee
                                -Infrarouge

		___________________
                WLAN
                        porté =~ 100 m

                        Exemples technos:
                                -WIFI (802.11)
					802.11b:
						porté: 300m
						débits: 11 Mbps
						Le plus répandu

					mode infrastructure:
						BSS (Basic Service Set)
							identifié par un BSSID, 
							Il définit une zone de couverture par un AP
						ESS (Extended Service Set)
							identifié par un SSID
							Il relie plusieur BSS pour rendre la connexion des client d'un AP à un autre de façon transparente.
					mode ad hoc:
						Réseau point à point

                                -HiperLan2
                                -DECT

		___________________
                WMAN (BLR) Boucle Locale Radio
                        802.16
                        porté =~ 4 à 10 km
                        Débits =~ 1 à 10 Mbps
                        
                        Déployé coté opérateur principalement.
			Il représente l'ensemble des techno radio pour relier un particulier à un opérateur.
			
			Exemples technos:
				DECT:
				PHS:
				PACS:
				LMDS:
                        
		___________________
                WWAN (Reseau cellulaire mobile)
                        
                        Exemples techno:
                                GSM
                                GPRS
                                UMTS
                                WIMAX
					porté : 20 km
					Débits: 12 mbps
	----------------
	LL (Liaison louées)
	----------------
		
		-Liaison dédiée permanente en full duplex entre 2 (PP) ou plusieurs entité (multipoint).
				  <-	 LL      ->
		ETTD -> jonction -> ETCD -> ETCD -> jonction -> ETTD
		
		Permet notament l'interco des entreprises.

		Débits:
			Europe:
				E0 : 64 kbps
				E1 : 2 Mbps (32 lignes E0)
				E2 : 8 Mbps (128 lignes E0)
				E3 : 34 Mbps (16 lignes E1)
				E4 : 140 Mbps (64 lignes E1)
			US:	
				T1 : 1.544 Mbps
				T2 : 6 Mbps (4 lignes T1)
				T3 : 45 Mbps (28 lignes T1)
				T4 : 275 Mbps (168 lignes T1)

	----------------
	RNIS (Réseau Numérique à Intégration de Service) [ISDN in english]
	----------------

		Permet de véhiculer sur un meme réseau numérisé divers flux de données.
		Il à fait évoluer le traditionnel RTC en multicanaux virtuels.
		Attention une ligne utilisée pour du RNIS, sera employé uniquement pour une seul techno, donc pas de mix ADSL et RNIS par exemple :) .
		
		RNIS implique tout un lot de protocoles en fonction des types de canaux.

		Il utilise 2 type de canaux bidirectionnelle:
			Les canaux D pour la signalisation, (mode paquet) 16/64 Kbps
				
			
			
			Les canaux B pour les données.  64 Kbps
				Utilisé en mode circuit principalement (1 usagé)

		___________________
		Les services

			RNIS apporte des services facturés:
				Identification d'appel
				Renvoi d'appel
				Rappel automatique
				
			Téléservices:
				Teletex, Telecopie ...
				
				
		___________________
		Les interfaces
			
			Deux utilisations principales:
			
				Accès de base (BRI)
					interfaces S0/T0 = 2B + 1D

				Accès Primaire: (PRI)
					interface S2/T2 = 30 B + 1D
					
					
			

=====================================
COUCHE 2
=====================================
	----------------
	Généralités
	----------------

		Les normes de la couche liaison définissent le mode d'encapsulation et les caractéristiques de transmission de ces données.

		___________________
		exemples de protocoles:

			HDLC : Encapsulation par défaut des interfaces WAN d'un routeur cisco
			PPP : Ce protocole n'est pas propriétaire, il comprend un champ d'id du protocole réseau ainsi que la gestion de l'authentification (PAP et CHAP)
			Frame Relay : Prévue pour les unités numériques haut de gamme, il est dépourvue de mécanismes de correction d'erreurs.

		___________________
		Catégories de technologie WAN:

			Services à commutation de circuits, paquet et celules.
			Services dédiés
			Autres...

		Les liaisons doivent toujours être point à point (physiquement ou virtuellement)

		___________________
		Services à commutation de circuits

			Les services à commutation de circuits se servent du réseau téléphonique (analogique ou numérique) pour créer une liaison dédiée non permanente entre la source et la destination. (grâce à une commutation physique des différents centraux téléphonique).

			Ce type de techno offre une bande passante maximale du lien pendant la durée de l'appel.

			exemple de service:
				RNIS (Réseau Numérique a Intégration de Services)
		
		___________________
		Services à commutation de paquets/cellules

			Fournis une connectivité au travers de commutateurs. On peu accéder à toutes les destinations via des liaisons point à point ou multipoint.
			On utilise un circuit virtuel par dessus un réseau commuté pour respecter le principe de connexion point à point.

			La différence entre commutation pasquet et cellules:

				paquet: trames de taille variable et traitement logiciel
				cellules: trames de taille fixe et réduite permettant un traitement matériel.

			Techno:
				Frame Relay pour la commutation de paquet
				ATM pour la commutation de circuit.

		___________________
		Services dédiés:

			offrent un lien physique dédié entre chaque source et destination.

			Techno:
				T1,T3,E1,E3
				SDH
		___________________
		Autres services:

			Toutes les techno référencées non référencées dans les catégories précédentes:
				Modem câble
				Satellite
				Sans fil

	----------------
	PPPoE / PPPoA
	----------------

		___________________
                PPPoA , Point to Point Protocol over ATM, 
                        Pour les modem avec une connexion usb (notion d'un seul hôte source)
                        Dans le cas de l'ADSL, la trame peut être encapsulé dans de l'ATM du modem au BAS
		___________________
                PPPoE : over Ethernet:
                        Pour les modem avec interface rj45 généralement (notion de plusieurs hôtes sources /users)

