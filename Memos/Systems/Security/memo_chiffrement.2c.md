===========================================================
Rappel sur les protocoles de chiffrement/authentification et méthodes de hash
===========================================================

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Algorithmes à clé symétrique 
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
		Chaque hôte dispose de la même clé de chiffrement pour chiffrer/déchiffrer les données.

		--------------------
		AES
		--------------------

		--------------------
		DES
		--------------------

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Algorithmes à clé asymétrique 
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			
		
		2 clé par hôte existent (une clé pub et une privée)
		Chaque clé est en mesure de déchiffrer ce que l'autre a chiffrer et vis versa.
			
			-La clé publique est ditribué et connu par les hôte pour chiffrer des données
			-La clé privé doit être secrete et sert à déchiffrer les données chiffrées avec la clé pub.

		--------------------
		RSA
		--------------------
	
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	La signature
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		

		
		Garentie l'intégrité;
		Construite à partir d'une méthode de hash appliqué sur un contenu:
			exemple le contenu d'un email.
			
		Ce hash peut ensuite être chiffré avec la clé privé d'un hôte expéditeur.
		Le destinataire poura vérifier que la signature est bien celle de l'expéditeur,
		car seule ça clé publique (partagées) pourra la déchiffrer.
			
		Ensuite on peut vérifier que le document n'a pas été corrompue en comparant le hash trouvé et celui trouvé en déchiffrant la signature.

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Certificats
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
			
		
		
		Le certificat sert à ajouter et grouper des informations supplémentaire pour accroitre la sécurité:
		Joue surtout sur la non répudiation des données. 
		C'est à dire affirmer qui l'a envoyer, identifier l'expéditeur.
			
		Le certificat comprend au moins:
			
			-La clé publique
			-La signature d'un CA attestant l'authenticité et l'identité de son propriétaire
			-La méthode de hash utilisée la signature

		--------------------
		X.509
		--------------------
			
			
			_____________________
			Whats is it:

				C'est une norme de cryptographie reposant sur un système de hiérarchie d'autorités de certification. (à l'inverse de PGP ou n'importe qui peut signer les certificats des autres)

				Il lie une clé publique à un dn (distinguished name), à une @mail et un enregistrement dns.
				
				Signé par une CA (à l'aide sa clé privé) 
					Cette dernière peut aussi délivrer un certificat signé par une autre CA ...


				Les CA racines ont des certificats auto-signés 
		
				La durée de validité d'un certificat n'est pas infini.

			_____________________
			Structure du cetificat:

		
	   			Version
  				Numéro de série
    				Algorithme de signature du certificat
  				DN (Distinguished Name) du délivreur (autorité de certification)
  				Validité (dates limite)
    					Pas avant
    					Pas après
  				DN du détenteur du certificat
   				Informations sur la clé publique :
    					Algorithme de la clé publique
    				    	Clé publique proprement dite
    				Identifiant unique du signataire (optionnel, X.509v2)
   				Identifiant unique du détenteur du certificat (optionnel, X.509v2)
   				Extensions (optionnel, à partir de X.509v3)
    				    	Liste des extensions
    				Signature des informations ci-dessus par l'autorité de certification

			_____________________
			La liste de révocation:
				
				Cette liste définit tout les certificats qui ne sont plus valide (car compromis ou expiré ...) 
				Elle est signé par la CA pour que personne ne puisse y toucher.
				
				
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Méthodes de hash (aussi digest)
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		--------------------
		SHA-2
		--------------------

		--------------------
		MD5
		--------------------

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Sallage SALT
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		

		TODO
			
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Protocoles d'authentification
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
		--------------------
		Kerberos
		--------------------
			_____________________
			Liens:

				http://www.microelec.patricklecoq.fr/docs/kerberos_linux.pdf
				http://fr.wikipedia.org/wiki/Kerberos_%28protocole%29

			_____________________
			Caractéristiques
			
				C'est un protocole d'authentification (uniquement)
				Utilisant un système de tickets à la place de mot de passe.	
				Il utilise une cryptographie à clé symétrique
				Une horloge est utilisé pour rendre temporaire l'utilisation des tickets et détecter les attaques par rejeu.
				DES est utilisé pour le chiffrement
				Il ne chiffre pas les données

			_____________________
			Fonctionnement:

				Kerberos utilise un cryptage symétrique et KDC (Key Distribution Center) pour authentifier un utilisateur.
				Une fois l'authentification faite, Kerberos transmet un ticket à l'hôte.
				Ce ticket va permetre pendant un temps donné d'être utilisé par n'importe quel service kerbérisé.
				Ainsi pendant toute la durée de validité du ticket, aucun transmission de login/mot de passe n'est faite.
				
			Détails d'une authentification:
			
				1: Le client emet une requête (AS-REQ ou TGT) au KDC:
					Pendant cette demande, l'utilisateur doit entrer son mot de passe qui va être hashé et utilisé comme clé de chiffrement;
					
					
					Note:
						La demande d'authentitication peut être émise par le soft de connexion ou être transmise par kinit une fois l'utilisateur connecté.

				2: Le KDC reçoit la requête d'authentitifaction du client 
					Comme il contient en base tout les mots de passe, et qu'il a reçu le principale, il est à même de déchiffrer la demande d'authentitification.
					Si le déchiffrement c'est bien passé c'est que l'identité de l'hôte est approuvée.
					Le KDC emet donc une réponse positive (AS-REP) avec la clé de session TGT servant à valider les échanges entre l'utilisateur et le KDC (le tout chiffré avec la clé utilisateur)

					Le TGT servira au client à demander des tickets auprès du KDC (TGS) afin de les fournir aux services requérant une authentitifaction (sert de preuve).
				3: Le TGT est stocké dans le cache du client pendant un temps donné ou jusqu'a la prochaine déconnexion.
					à Chaque fois qu'un service demande une authentification, le client utilise le TGT pour demander au TGS un nouveau ticket qui sera délivré au service en question.

			_____________________
			Fonctionnement détaillé

				1 : le client demande un TGS au serveur d'authentification (AS) (Ce dernier est souvent compris dans le KDC).
					Cette demande est chiffré avec la clé partagé contenu sur le client et l'AS (appelons la KC (peut être un hash du mot de passe).
					Elle comprend le nom de l'utilisateur (le principale)
					Permettant ainsi de prouvé l'identité de l'utilisateur.

				2 : L'AS ayant attesté l'identité de l'utilisateur envoie le ticket TGS chiffré avec la clé de l'AS (KTGS) non connue du client.
					Le ticket (TGT) comporte la clé de session et d'autre information comme la validité, l'id du client ...)
					Il envoie également la clé de session (KC,TGS) chiffrée avec la clé partagé du client (KC).
				
				3 : Le client peut demander des tickets permettant de s'authentifier auprès d'un service.
					Il envoie donc une demande de ticket avec un ID (comprenant bon nombre d'info) chiffré avec la clé de session (KC,TGS) au TGS (Lui aussi compris générallement dans le KDC).
					Ainsi que le ticket fournis par l'AS (étant chiffré avec la clé KTGS).

				4 : le TGS déchiffre le ticket (car il connait la clé KTGS) et récupère ainsi la clé de session.
					Grâce à la clé de session, il va pouvoir déchiffrer ce fameux ID et vérifier l'exactitude des informations et pour quel service/serveur l'authentification est demandé.
					Le TGS renvoie un nouveau ticket (TS) d'accès chiffré avec la clé appartenant au serveur/service demandé. (KS).
					Il envoie également une clé de session (KC,S) valide X-temps pour les futurs échanges entre le client et le service demandé.
					Ce dernier étant chiffré à l'aide de la clé de session KC,TGS fournis pas l'AS.
				5 : Le client va pouvoir envoyer les informations nécéssaire à son authentification auprès du service demandé:
					Il renvoie le ticket d'accès (TS) au service (chiffré avec KS)
					Et un nouvel ID chiffré avec KC-S 

				6 : le serveur déchiffre le ticket avec sa clé (KS) et récupère les infos de validité et la clé de session KC,S.
					Il déchiffre ensuite l'ID avec cette nouvelle clé de session pour vérifier la bonne conformité des informations et attesté l'authentitification du client.
					
	
			_____________________
			Layout :

				(1)   CLIENT                     KDC (AS)
				
				     [KC]     ======[KC]======        [KC]
						demande TGT   >     [KTGS]	
					          ================

				(2)   CLIENT                     KDC (AS)
				
				     [KC]     ======[KTGS]====        [KC]
				     [TGT]   <   TGT (KC,TGS)       [KTGS]	
				     	      ================

					          ======[KS]======
					    [KC,TGS]  <  KC,TGS	
					          ================


				(3)   CLIENT                     KDC (TGS)
				
				     [KC]     ======[KTGS]====        [KS]
				     [TGT        TGT (KC,TGS) >     [KTGS]	
				   [KC,TGS]   ================    [KC,TGS]

					           ======[KC,TGS]==
         			                 IDs	  >   
					           ================

				(4)   CLIENT                     KDC (TGS)
				
				     [KC]     ======[KS]======        [KS]
				     [TS]     <   TS (KC,S)         [KTGS]	
				 [KC,TGS]     ================    [KC,TGS]
				   	
					          ======[KC,TGS]==
						   [KC,S]     <   KC,S	
					          ================

				(5)   CLIENT                     Serveur X
				
				     [KC]     ======[KS]======        [KS]
				     [KC,S]      TS (KC,S)    >     [KC,S]	
				   [KC,TGS]   ================

					            ======[KC,S]====
         			                 IDs	      >   
					            ================

				Légende:
					KC: clé de chiffrement cliente (connue par le client et l'AS)
					KTGS : clé de chiffrement du TGS (connue par l'AS et le TGS)
					TGT : Ticket transmis par l'AS pour dialoguer avec le TGS
					KC,TGS : clé de session pour chiffrer chiffrer les ids entre le client et TGS
					KS : clé de chiffrement du service réseau demandant l'authentification
					KC,S : clé de session pour chiffrer les ids entre le client et le serveur
					

				
			_____________________
			Lexique :

				
				KDC: (Key Distribution Center)
					Il contient une base de données avec les infos sur les clients, les serveurs et les clés associées.
					Souvent associé avec l'AS et le TGS
				
				AS: (Authentication Service) : Donne au client un ticket de session et un TGT pour dialoguer avec le TGS
				
				TGS: (Ticket Granting Service) : Distribue les ticket d'accès aux services réseaux.
				
				principal: contient le nom unique de l'utilisateur/service pouvant s'authentifier.
						

				TGT: (Ticket Granting Ticket) : permet de demander directement les tickets auprès du TGS.
				Kerbérisé: C'est le fait qu'un service soit compatible avec l'authentitification Kerberos.
				

		--------------------
		SASL (Simple Authentication and Security Layer)
		--------------------
			_____________________
			Liens:
					http://fr.wikipedia.org/wiki/Simple_Authentication_and_Security_Layer
					
			_____________________
			Détails:
				
					SASL est une norme d'authentification et d'autorisation de l'IETF.
					Le but étant de pouvoir gérer n'importe quel protocole d'authentitification via SASL.
					C'est à dire qu'une application devra juste s'occuper d'utiliser SASL au travers de profil de configuration.
					
			_____________________
			Les mécanismes SASL:
					
					EXTERNAL : authentification faite déja par le protocole externe (exemple TLS ...)
					ANONYMOUS : accès anonyme sans authentification
					PLAIN : mot de passe en clair
					OTP : mot de passe à usage unique
					DIGEST-MD5 : basé sur MD5 et le partage de secret
					GSSAPI : authentification via Kerberos V (GSSAPI pour l'intégrité des données)
					
		--------------------
		GSSAPI (Generic Security Service Application Program Interface)
		--------------------			
			_____________________
			Liens:

				http://en.wikipedia.org/wiki/Generic_Security_Services_Application_Program_Interface
				
			_____________________
			Détails:
			
				GSSAPI est un ensemble de librairie permetant aux application d'utiliser un envirionnement de sécurité.
				Son but étant de standardiser l'authentification et de fonctionner sur une archi client/serveur.
				
				IL emploit directement les mécanismes de Kerberos et le rend compatible API.
				
				Pour rappel, un API fait référence à un ensemble normalisé de classes, méthodes, fonctions utilisable par n'importe quel logiciel. Le tout regroupé dans une bibliothèque et fournis avec un peu de doc (normalement :p )
				
			
		--------------------
		SASL DIGEST-MD5
		--------------------

		--------------------
		RADIUS
		--------------------

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Protocoles de Chiffrement
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
		--------------------
		TLS (anciennement SSL)
		--------------------

			_____________________
			Liens:

				http://fr.wikipedia.org/wiki/Transport_Layer_Security
				https://en.wikipedia.org/wiki/Transport_Layer_Security
				http://www.rfc-editor.org/rfc/rfc4346.txt

			_____________________
			Caractéristiques:
			
				-Garentie l'authentification du serveur
				-Confidentialité des données échangées
				-Intégrité des données échangées
				-Transparent: il opère entre la couche 4 et 5 sans nécessité de recoder un 
				-utilise X.509protocole.

				En option:
				-Authentification du client (avec certificats)

			_____________________
			Fonctionnement:
					
				Le client demande le cetiticat au serveur
				Le client vérifie la signature du CA faite sur le certificat du serveur
				Puis la connexion est chiffrée avec à l'aide d'une paire de clé symétrique échangée grâce à la clé publique du serveur.

				Si l'authentitification du client est activée, le serveur va aussi vérifier le certificat du client.

			_____________________
			Fonctionnement détaillé:
				
				1: le client envoie au serveur la version de SSL, et les algo de chiffrement utilisés
				
				2: Idem mais dans le sens du serveur vers le client et envoie en plus son certificat. 
					Si nous sommes dans un cas ou le serveur requier aussi l'authentitification du client, alors il lui envera en plus une requête de demande de son certificat.

				3: Le client tente d'authentifier le serveur en checkant sa signature (par l"interméfiaire des racines de confiances et en checkan les listes de révocation).
				Si jamais il y a un doute, l'hôte doit prévenir l'utilisateur que le certificat est potentiellement dangereux. (Car auto-signé ou compromis ...)
			
				4: Si le client a correctement identifier le serveur, 
					Il créer un secret 'pre-master' 
					Puis il lui renvoie chiffré avec la clé pub du serveur

				5: Dans le cas ou le serveur avait aussi demander l'authentitification du client:
					Le client envoie en plus son certificat et une partie des données signées (avec sa clé privée)

				6: Le serveur vérifie la signature du client et son certficat dans le cas où ce dernier doit être authentitifier
					Le serveur déchiffre le secret 'pre-master' avec sa clé privée.
					Puis il va générer le "secret master" (en même temps que le client) à partir du pre-master.
					
				7: Le secret master va permettre de définir les clé de sessions qui sont des clé symétrique qui vont permettre de chiffrer les flux échanger durante la session.

				8: Le client envoie un message au serveur pour l'avertir que le prochain message sera chiffré avec la clé de session et que le mécanisme de "handshake est finis'(prérequis)

				9: idem coté serveur.
				

			_____________________
			Versions:
				
				TLS 1.2 : todo
				
		

		--------------------
		IPsec
		--------------------

			_____________________
			Liens:

				http://fr.wikipedia.org/wiki/Internet_Protocol_Security


			_____________________
			Caractéristiques:

				C'est un standard non figé définissant une communication sécurisée sur un réseau IP.
				Son objectif est d'authentifier et de chiffrer les données. 
				Ce dernier agit au niveau de la couche 3 et inclut un ensemble de protocole.
				Lié souvent au service de tunneling VPN.

			_____________________
			Modes de fonctionnement:

				transport : (Host to Host) 
						Ce mode permet de chiffrer uniquement la payload du paquet IP n'influant pas sur le routage IP.
						Par contre Si il y a du NAT, l'ip est changé et le hash de l'en-tête AH deviens erroné.
						Dans ce cas il faut encapsuler via NAT-T.

				tunnel : (tunneling)
						Chiffre entièrement le paquet IP qui est ensuire réencapsulé dans un autre paquet IP avec un nouvel en-tête. 
						Il supporte donc le NAT et est utilisé pour créer des réseaux VPN pour la communication entre réseau mais aussi d'hôte à réseau (exemple un itinérant) et encore d'hôte à hôte (exemple messagerie privée).
						(Note: ce mode n'est pas seulement propre à IPsec ... mais à tout les modes de tunneling)

			_____________________
			Fonctionnement : 
			
				Echanges des clés:

					Via ISAKMP (Internet Security Association and Key Management Protocol)
					
					via IKE (Internet Key Exchange) 
					
				 A FINIR
				 
				Transfert des données:
				

			_____________________
			Lexique : 
	
				AH : Authentication Header
					Il fournis l'intégrité et l'authentification en signant le paquet

				ESP : Encapsulation Security Payload
					Assure aussi l'intégrité en ajoutant la confidentialité via le chiffrement des données.
				
			

		--------------------
		SSH
		--------------------

		--------------------
		PGP
		--------------------
		
	
