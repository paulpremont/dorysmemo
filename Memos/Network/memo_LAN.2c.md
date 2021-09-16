=====================================
COUCHE 1
=====================================
	----------------
	topologies
	----------------

		bus:
			physique: Les hôtes sont connectés directement à une liaison 
			logique: Tous les hôtes voient tous les signaux provenant de tous les autres équipements

		Anneau (Token Ring):

			physique: Les éléments sont chaînés dans un anneau fermé
			logique: Chaque hôte communique avec ses voisins pour véhiculer l'information

			Inventé par IBM, l'hôte récupère le token vide pour transmettre les données.
			(Le token est plein lorsqu'il véhicule des données)
			Cette technologie utilise toute la bande passante du lien.

			Une variante de cette topologie est le double anneau (mais la bande passante est divisé en deux)
			Ce deuxième anneau sert comme lien redondant.

		Etoile:

			Physique: comporte un noeud central où les hôtes sont connectés.
			Logique: Toutes les informations passent par un équipement réseaux

			"Etoile étendue": plusieurs étoiles sont connécté à un autre noeud central

		Hiérarchique:

			Physique: Ici on utilise un noeud de jonction à partir duquel on branche d'autres noeuds:
			Logique: Les flux sont hiérarchisés.

			NET------ROUTEUR-------COMMUTATEUR1------HOTES
					|------COMMUTATEUR2------HOTES

		Maillée:

			Physique: Chaque noeud est connecté ave tous les autres
			Logique: dépend des équipements utilisés

			Le nombre de lien est n(n-1)/2

			avec n le nombre de noeud.

			Surtout présent dans le coeur de réseau des WAN.

	----------------
	Environnement d'un bit
	----------------

		Un bit dans un milieu electrique correspond à 2 tensions: 0 et +5 volts (ou un codage plus complexe)
		
		Propagation de signaux réseau:
			C'est le temps que met un bit à ce déplacer dans le média.

		L'atténuation du signal:
			C'est la perte de la force du signal (limitable grâces aux répéteurs notament)

		La réflexion réseau:
			Retour d'énergie causée par le pasage des impulsions, il peut perturber le signal des impulsions suivante. (des energie supplémentaire se déplacent dans le média)

		
		Le bruit:
			Des sources d'énergie situées à proximité du média fournissent un supplément d'énergie venant perturber le signal
			Ces sources peuvent être des alimentation externes, des variations thermiques, des interférences électromagnétiques ou encore des interférences de radio fréquences.

			On y trouve:

			La Diaphonie:
				Bruit ajouté au signal d'origine d'un conducteur par l'action d'un champ magnétique d'un autre conducteur

			La Paradiaphonie:
				Diaphonie causée par un conducteur interne au câble

		La dispersion:
			C'est l'étalement des impulsions dans le temps. Si elle est trop forte, le signal d'un bit peu recouper le signal du suivant ou précédent.
			(La durée d'une impulsion est fixe mais peut être modifiée lors de la propagation du signal dans le média)

		La gigue:
			Correspond à une désynchronisation des horloges de la source et de la dest
			(Les systèmes numériques sont synchronisés avec des impulsions d'horloge)

		La latence:
			Retard de transmission 

		Les collisions:
			Se produit lorsque plusieurs hôtes émettent en même temps sur le même segment réseau.
			Les impulsions se mélanges détruisant alors les données. (Voir les valeurs du Runt et Giant pour la détection de collision)


	----------------
	Media et équipements
	----------------

		___________________
		Les types de liaisons:

			-Simple (unidirectionnelle): Un hôte emmetteur et un autre récepteur distinct
			-Half-duplex (bidirectionnelle à alternat): La communication change de sens à tour de rôle (exemple: talkies-walkies)
			-full-duplex (bidirectionnelle simultanée): plusieurs hôtes peuvent émettre et recevoir en même temps

		___________________
		Cuivre:

			UTP: câble à paires torsadées non blindées
				4 paires de fils torsadées 2 à 2. Les torsades permettent de limiter la dégradation du signal causée par une perturbation électromagnétique et une interférence radioélectrique mais ce procédé n'est pas des plus efficace.

				Avantages: simple, peu couteux et petit diamètre
				Inconvénients: sensible aux interférences.

				Comporte une Gaine extérieure, et pour chaque fil, le conducteur et un isolant en plastique.

			STP: câble à paires torsadées blindées
				Apporte une méthode de blindage, d'annulation et torsion de câbles.
				Le blindage doit être mis à la terre, il permet d'absorber les parasites.

				Composition: UTP + blindage globale (après la gaine extèrieure) + blindages des paires.

				Avantages: idem que UTP mais plus résistants aux interférences
				Inconvénients: un peu plus couteux que UTP

			Les connecteurs RJ-45: (Pour UTP et STP)

				8 conducteurs (au lieu de 4 pour les prise téléphoniques)
				Sert au passage du courant entre les quatres paires torsadée de câbles torsadés de catégorie 5 et les broches du RJ-45.


			Le câble coaxial:

				Composé d'une gaine extèrieue, d'un blindage en cuivre tressé, d'une isolation en plastique et enfin d'un conducteur en cuivre.
				Le blindage en cuivre agit comme le second fil du circuit et comme protecteur du conducteur intérieur.

				Avantages: Performant et permet d'être installé sur de longue distance. (+ faible coût)
				Inconvénients: poids, rigidité, connectique délicate 

				Le câble coaxiale devrait petre peu à peu remplacer par la fibre optique.

				Plusieurs variantes:
					Thicknet: Epais et raide: gaine jaune (pour les câbles fédérateur)
					Thinnet: Diamètre plus réduit: blindage moins performant. Plus pratique pour install avec des courbes.
					Cheapernet: Version économique du câble coaxial

				La mise à la terre n'est pas importante, en revanche il faut une solide connexion électrique aux deux extrémité du câble.

		___________________
		Medias optiques

			Fibre optique:

				un câble optique doit contenir au moins 2 fibres (une pour la transmission et l'autre pour la réception)
				Il peu allé jusqu'a 48 fibres.

				La fibre ne créer pas de bruit donc n'a pas besoin de blindage.

				Nécessite tout de même une bonne solidité (renforcement en kevlar) pour ne pas être pliée.

				Le câble optique est composé d'une enveloppe protectrice, d'une gaine optique puis du coeur.

				Fibre monomode: un seul rayon est transmis. (Utilise le laser)
					--> plus cher et peu parcourir 3000m (utile pour les WAN)
					--> connecteur le plus utilisé: ST (Straight Tip qui ressemble à un coaxial)


				Fibre multimode: Plusieurs rayon sont transmis. (nécessite un plus grand coeur) (Utilise la LED)
					--> un peu moins cher et peu parcourir 2000m (utile pour réseaux d'entreprise)
					--> connecteur le plus utilisé: SC (Subscriber Connecter qui ressemble presque à du RJ45)

				Les facteurs de perturbation:

					-La dispertion (diminution du signal) lorsque la fibre est trop abimé/pliée.
					-L'absorption: arrive lorsque le rayon rencontre des impurtées

					Pour palier à ses atténuations, on utilise des outils permetant d'effectuer des tests.

		___________________
		Tableau Récapitulatif: (à vérifier)


			Technologie		Type		Débit		Longueur	Connecteur	Coût

			10 Base 2 (Thinnet)	Coaxial		10 Mbps		200 m		BNC		Peu cher
			10 Base 5 (Thicknet)	Coaxial		100 Mbps	500 m		BNC		Peu cher
			10 base T		UTP cat5	10 Mbps		100 m 		RJ45		Bon marché
			100 base TX		UTP cat5	100 Mbps	100 m 		RJ45		Bon marché
			10 base FL		Fibre optique	10 Mbps		2000 m		SC		Elevé
			100 base FX		Fibre optique	100 Mbps 	400 m 		SC		Elevé

			___________________
			Spécification et normes:

			forme: vitesses en Mbps ; type de signal ; type de câble

				exemple: 100 base TX

			Deux types de signalisation:
				BaseBand (transmission numérique)
				BroadBand (utilisation de la porteurse, exemple: transmission par onde)

			Types de câbles

				F: Fiber
				UTP ...

			On exprime aussi le plus souvent la capacité du media ) supporter le Full Duplex par un X

		___________________
		Media sans fil (air)

			WLAN:

				utilisent des fréquences radio à 2.5 GHz et 5 Ghz
				La bande la plus utilisée est l'ISM (Industrial Scientific and Medical) i
					= à la bande passante des 2.4 Ghz avec une largeur de bande de 83,5 Mhz

				Récapitulatif des fréquences débits:
								802.11b		802.11a		802.11g

					Bande de fréquence:	2.4Ghz		5Ghz		2.4Ghz
					Débit max:		11 Mbps		54 Mbps		54 Mbps

				Loi de la radio:
					Débit plus grand = converture plus faible.
					Puissance d'émission élevée = converture plus grande mais dureée de vie des batterie plus faible.
					Fréquance radio élevées = Meilleur débit, couverture plus faible.
	

=====================================
COUCHE 2
=====================================
	----------------
	Contrôle d'accès
	----------------

		Il determine la méthode d'accès à un media, décrit par le protocole de couche 2.

		Les méthodes d'accès sont soit deterministe: on determine qui peut transmettre,
		soit concurentielle (chaque noeud peut transmettre à tout moment).

	----------------
	[802.3] ETHERNET (Technologie LAN)
	----------------

		Opère sur la couche 1 et 2

		L'accès se fait selon la méthode CSMA/CD: (Carrier Sense Multiple Access with Collision Detection)

			Chaque noeud écoute la porteuse, si elle est libre il transmet l'information.
			Si une collision est détectée, la transmission est arrétée, une temporisation est calculée avant de tanter une nouvelle transmission.


		Longueur minimale d'une trame: 64 octets
		Longueur max (MTU) Maximum transfert unit:  1508 octets

		___________________
		Résultat d'une collision:
			Runt: < 64 octet
			Giant: > 1508 octets

		___________________
		Débits:
			Ethernet (802.3): 10 Mbps (Coaxial/UTP/fibre optique)
			Fast (802.3u): 100 Mbps (UTP 
			Giga (802.: 1 Gbps

		___________________
		Mode de commutation: (Lors de la commutation de trame)

			Fast and Forward: Transmission de l'info dès que l'adresse de dest est lue
			Fragment Free: Lit à partir de 64 octets (Ecite les Runt)
			Store and forward: Lecture et contrôle de l'intégrité de la trame

		___________________
		Domaine de collision:
		
			= environnement partagé. Les hôtes accèdent en concurrence à une ressource.	
				De ce fait, des collisions vont se créer sur cette partie du réseaux.

		___________________
		Segmentation:

			Permet de diminuer les domaines de collision et ainsi augmenter la bande passante par hôte.
			La segmentation permet de n'envoyer des données qu'a la portion de réseau concernée.

			On peu segmenter par:

			Ponts:
				Apprend sur quel réseau est un hôte via son adresse MAC et filtrera le traffic en conséquence.
				(Type store and Forward)

			Commutateurs:

				Le commutateur tient à jour une table de correspondance (port/mac) et redirige donc le traffic d'un destinataire sur un port spécifique.
				(Utilisation de circuit virtuel)

			Routeurs:
				
				Agit au niveau de la couche 3, il diminue en plus les domaines de broadcast.


		___________________
		Spanning Tree: 

			Permet de supprimer les boucles de commutation de façon virtuel et éviter les tempêtes de broadcast.
			(Dû à la redondance des liens)

			Chaque commutateurs envoie des datagrammes BPDU (Bridge Protocol Data Units) pour indiquer sa présence.
			Chaque commutateurs calcul la route optimales suivant la topologie et éliminent les chemins redondants grâces à l'algo STA.

			Un port peu prendre ensuite plusieurs états:

				Blocage: aucune trame acheminée, BPDU comprises
				Ecoute: aucune trame acheminée, écoute des trames
				Apprentissage: trames acheminées, apprentissage des adresses.
				Acheminement: trames acheminées, apprentissage d'adresses.
				Désactivation: aucune trame acheminée, BPDU comprises

=====================================
COUCHE 3
=====================================

	voir protocole IP, table de routages, et les protocoles de routages dans les mémos cisco, protocoles et calcul_ip

	----------------
	Système autonome et Routage
	----------------

		Un système autonome est un réseau ou un ensemble de réseaux sous un contrôle administratif commun.
		Il est composé de routeurs ayant les mêmes règles et fonctions.

		Les IGP (Interior Gateway Protocol, exemple: RIP, IGRP, EIGRP, OSPF) routent les données dans un Système autonome.
		Les EGP (Exterior Gateway Protocol, exemple: BGP) routent les données entrent les réseaux autonomes.

=====================================
COUCHE 4
=====================================

	Essentiellement TCP et UDP (voir memo protocoles)
