==============================================================================
				C O M M A N D E S 	--	C I S C O
==============================================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
IOS - Internetwork Operating System
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	IOS est un système d'exploitation propriétaire à CISCO, il offre une CLI (Command Line Interface). EXEC est le programme d'exécution des commandes entrées dans la CLI.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Connexion console
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Vitesse: 9600 bauds
	BIts de données: 8
	Parité: Aucun
	Bits d'arrêt: 1
	Contrôle de flux: Aucun

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les types de mémoires
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-RAM : Mémoire principale de travail du routeur, contient l'IOS une fois chargé, le fichier de conf courant, la/les tables de routage...
	-NVRAM (Non-Volatile RAM) : Stock le registre de configuration et le fichier de co,nfiguration de sauvegarde.
	-Flash : Mémoire principale de stockage, contient l'image du système IOS.
	-ROM : Contient le bootstrap ainsi que la séquence d'amorçage du routeur.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Raccourcis clavier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	[CTRL+MAJ+6] : Arrêter l'exécution d'une commande.
		(no ip domain-lookup)
	[CTRL+C] : Idem mais pour les commandes show et le mode SETUP
	_______________
	Commandes d'éditions:

		> terminal [no] editing : active/désactive les commandes d'édition.

		   [CTRL+A] : Revient au début de la ligne.
		   [CTRL+B] : Recule d'un caractère.
		   [ESC+B] : Recule d'un mot.
		   [CTRL+E] : Fin de la ligne.
		   [CTRL+F] : Avance d'un caractère.
		   [ESC+F] : Avance d'un mot.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Séquence d'amorçage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-Etape1: POST (Power On Self Test).
		Chargement du bootstrap contenu dans la ROM qui va se charger de tester le matèriel.
	
	-Etape2: Chargement IOS en RAM.
		-Analyse la valeur du registre de configuration pour savoir si la séquence de recherche IOS se fait par défaut ou dans le fichier de configuration de sauvegarde.
		-Séquence de recherche de l'IOS. Si l'image spécifiée dans le fichier de configuration est ignorée, le routeur tentera de démarrer avec l'IOS présent dans la mémoire Flash.
		-Si aucune image trouvée. Arrêt au mode RXBoot.
	
	-Etape3: Chargement de la configuration.
		Par défaut, le routeur importe le fichier de conf de sauvegarde dans le fichier de conf courant. Dans le cas où il ne trouve pas ce fichier de conf, le mode SETUP est lancé.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Modes de commandes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-utilisateur > : Permet uniquement de consulter, à l'aide des commandes d'états, les informations du routeur.
	-privilégié # : Niveau plus avancé que utilisateur, il permet en plus d'importer/exporter les fichiers de configuration IOS.
	-Configuration globale (config)# : Permet d'utiliser toute les commandes de configuration globale.
	-Configuration spécifiques : Permet d'utiliser les commandes spécifique au composant du routeur:

		exemple:
			-Interface (config-if)#
			-Ligne (config-line)#
			-Routage (config-router)#

	-SETUP : Affiche un dialogue interactif, grâce auquel l'utilisateur peut créer une configuration élémentaire initiale.
	-RXBoot : Mode de maintenance, qui permet notamment de récupérer les mots de passe perdus.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Changer de mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	> enable : utilisateur --> privilégié.
	# disable : inverse.

	# configure terminal : privilégié --> mode conf globale.

	(config)# line {type} {N°} : conf globale --> conf ligne.
	(config)# interface {type} {N°} : conf globale --> conf interface.
	(config)# router {protocole} [option] : conf globale --> conf routeur.

	> exit : quitter un mode.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Notifications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	> terminal [no] monitor : désactive les messages de notification sur le terminal. Efféctuer un reload ensuite.
	> no ip domain-lookup : désactiver les messages de résolution DNS.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
L'aide
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	? : fournis une liste complète de commandes accessibles.
	{chaîne}? :  fournis la liste de mot clé commançant par la châine.
	{commande} ? : founis la liste d'options pour la commande.
	
	^ : indique où se situe l'erreur.
	tabulation : autocomplémentation.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Historique 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	> show history : Affiche la liste des commandes en mémoire.
	> terminal history size {taille} : Définit la taille de la mémoire des commandes (max 256)?
	> terminal [no] history : Active/désactive l'historique des commandes.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Fichiers de configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Désactiver la pagination (Pour exécuter certain script, on peu avoir l'utilité d'enlever la pagination):

	>	terminal length 0


	   Les fichiers de configuration sont soit stockés dans la RAM (conf active) soit dans la NVRAM (conf de sauvegarde).

	   Les informations de ces fichiers comportent:

		   -Infos générique de la version IOS avec laquelle le fichier de configuration fonctionne.
		   -Le nom du routeur ainsi que le mot de passe du mode privilégié.
		   -Les entrées statiques de résolution de noms.
		   -Chaque interface avec sa config.
		   -Toutes les infos de routage.
		   -Chaque ligne et sa config.


	> show running-config : Affiche la configuration courante
	> show startup-config : Affiche la configuration de sauvegarde
	
	> copy running-config statup-config : Sauvegarde de la configuration courante.
	> copy running-congig tftp : Exporte la conf active vers le serveur TFTP.
	> copy tftp running-config : inverse
	> copy startup-config tftp : Exporte la conf de sauvegarde ver le TFTP.
	> copy tftp startup-ĉonfig : Importe la conf du serveur TFTP vers la NVRAM.

	> erase startup-config : Supprime le fichier de configuration de sauvegarde.
	> reload : redémarrer le routeur.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Visualisation d'état 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	> show running-config : Affiche le fichier de conf actif.
	> show startup-config : Affiche le fichier de conf de sauvegarde.
	> show version : Affiche la conf matèrielle, la version d'IOS, le nom de la source de l'image IOS d'amorçage et la valeur du registre de configuration.
	> show processes : Affiche les infos sur les processus actifs.
	> show memory : Affiche des stats sur la mémoire du routeur.
	> show stacks : Contrôle l'utilisation de la pile par les processus et les routines.
	> show buffers : Affiche les stats sur la mémoire tampon.
	> show arp : Affiche la table ARP.
	> clear arp : Vide la table ARP.
	> show hosts : Affiche la table de résolution de noms.
	> show flash : Affiche les informations sur la mémoire flash.
	> show interfaces [{type} {N°}] : Affiche les infos de configuration des interfaces ainsi que des stats de trafic.
	> show controllers [{type} {N°}] : Affiche les infos de couche 1 des interfaces.
	> show ip interface [{type} {N°}] [brief] : Affiche les infos IP des interfaces.

	> show counters [{type} {N°}] : Met à zero tous les stats des interfaces du routeur.
	
	> show ip route : Affiche la table de routage.
	> show protocols : Affiche le nom de l'état de tous les protocoles configurés de couche 3.
	> show ip protocols : Affiche les valeurs des compteurs de routage et les infos de réseau associées à l'ensemble du routeur. 
	> show sessions : Affiche la liste des sessions en cours.
	> show users : Affiche la liste des utilisateurs actuellement connectés.
	> show clock : Affiche la date et l'heure actuelle.
	> show history : Affiche la liste des commandes en mémoire.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Date et Heure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	> show clock : Affiche la date et l'heure.
	# clock set {hh:mm:ss} {jour} {mois} {année} : configurer la date.

	Il est possible d'utiliser un serveur de temps (NTP) pour avoir une date synchronisée.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Infos system
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Voir le modèle:

        > show system

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Noms d'hôte et résolution de noms.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	(config)# hostname {nom} : Donne un nom au routeur. 
	(config)# ip host {nom} [N°port] {IP1} [{IP2} ...] : création d'une entrée statique de résolution de noms dans la table d'hôtes.
		[N°port] : permet de spécifier un port TCP à utiliser avec l'hôte pour un accès Telnet.
	(config)# [no] ip domain-lookup : Active/Désactive le DNS.
	(config)# ip name-server {DNS1} [{DNS2} ...] : Spécifie le ou le serveurs DNS pour la résolution d'adresses. (6 serveurs max).
	(config)# ip domain-name {préfixe} : Précise le préfixe DNS par défaut à utiliser pour la résolution d'adresses dynamique.

	> show hosts : Voir la table des correspondances dentre hôte et adresse.
		
		Champs de la table:
				
		-Host: Noms des machines connues
		-Flag: Description de la méthode utilisée pour apprendre les informatins et pour juger de leur pertinence actuelle.
		-perm: Configuré manuellement.
		-temp: Acquis par le biais du serveur DNS.
		-OK: entrée valide
		-EX: Entrée obsolète
		-Age: Temps (en heure) écoulé depuis que le logiciel a appris l'entrée.
		-Type: Champ identifiant le protocole de couche 3.
		-Address: Adresses logiques associées au nom de machine.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Descriptions et Bannières
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	(config)# banner motd " {message} " : Afficher un message de connexion. Les guillement peuvent être remplacées par un autre caractère du moment qu'il ne se retrouve pas dans le message.
	
	(config-interface)# description {texte} : Permet de mettre une description sur une interface.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Mots de passe
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Les mots de passe pour les lignes console et aux ne sont pris en compte qu'après le redémarrage du routeur. 
	Les lignes VTY ne sont opérationnelles que si ont un mot de passe configuré.

	(config)# line {console | aux | vty} {{N°} | {premier} {dernier}} : Passer dans la configuration de la/les lignes voulues.

		Exemple:
			line vty 0 4 : accède au mode de configuration des 5 lignes vty.

	(config-line)# password {pwd} : Spécifie un mot de passe pour la ligne courante. (Écrit en clair dans le fichier de conf).
	(config-line)# login : Si un mot de passe est actif, cette commande précise qu'aucun login ne sera demandé lors de la connexion.
	(config)# enable password {pwd} : Restreindre l'accès au mode privilégié.
	(config)# enable secret {pwd} : Crypte le mot de passe. (cette commande surpasse password, on peu utiliser uniquement secret)
	(config)# service password-encryption : Permet de crypter tous les mots de passe du fichier de configuration. (Ecrit en clair par défaut).


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Serveur HTTP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Les valeurs par défauts de connexions au service HTTP sont:
		login : (aucun)
		pwd : (pwd du mode privilégié)

	Le serveur HTTP fait l'objets d'exploitation de failles de sécurité, il est recommandé de le désactiver apres utilisation.

	(config)# [no] ip http server : Active/Désactive le serveur HTTP interne du routeur.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration des interfaces
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	_______________
	Loopback

		(config)# interface loopack {N°} : Passer en mode de conf d'interface.
		(config-interface)# ip address {IP} {masque} [secondary] : Attribuer une IP à l'interface.
			secondary : précise qu'il s'agit d'une IP secondaire.

	_______________
	Ethernet

		(config)# interface {Ethernet | FastEthernet} {N° | slot/N°} : Passer en mode de conf de l'interface.
		(config-interface)# ip address {IP} {masque} [secondary] : idem que loopback (attribue une IP).
		(config-interface)# [no] keepalive : Active/Désactive les "keep alive" de l'interface pour rendre la opérationnelle sans avoir à brancher un média.
		(config-interface)# [no] shutdown : Active/Désactive l'interface.

	_______________
	Série

		(config)# interface {serial | async} {N° | slot/N°} : Permet de passer en mode conf de l'interface.
			async : utilisable uniquement pour les interfaces asynchrones.
		(config-interface)# clock rate {vitesse} : Spécifie la vitesse de fonctionnement de la liaison WAN (bit/s), à faire uniquement sur les interfaces ETCD.
		(config-interface)# ip address {IP} {masque} [secondary] : conf IP.
		(config-interface)# [no] shutdown : Active/Désactive l'interface.
		
		Pour les interfaces séries, on peut être amené à déterminer qui est le DCE ou DTE afin de donner la porteuse.
		Pour voir si l'interface est considérée comme DCE ou DTE tapez:

			> show controller serial $INTERFACE

			(si DCE : alors définir l'horloge [clock rate])

	_______________
	interface d'admin

		> vlan X
		> name bidule
	
		> interface f0/X...
		> switchport mode access
		> switchport access X
		
		> interface vlan X
		> ip address X.X.X.X Y.Y.Y.Y
		> no sh

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration du CDP (Cisco Discovery Protocol)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	CDP est un protocole qui permet de trouvers les voisin (périphériques) alentours. IL véhicule un bon nombre d'information et n'est donc pas consillé pour sécuriser son réseau.

	(CDP est actif par défaut)

	(config)# [no] cdp run : Active/Désactive CDP
	(config-interface)# [no] cdp enable : Active/Désactive CDP sur l'interface
	(config)# cdp timer {time} : Spécifie l'intervalle de temps en secondes pour l'émission des trames CDP.
	(config)# cdp holdtime {temps} : Spécifie le temps en secondes avant suppression d'une information non rafraîchie.

	_______________
	Vérifications && Résolution d'erreurs

		> show cdp : Affiche les compteurs de temps pour CDP.
		> show cdp interface [{type} {N°}] : Affiche les interfaces sur lesquelles CDP est activé.
		> show cdp entry {nom | *} : Affiche les informations d'un ou des voisins.
		> show cdp neighbors [detail] : Affiche la liste des voisins CDP ainsi que les informations les concernant.
		> show cdp traffic : Affiche les compteurs de trafic CDP
		> show cdp counters : Réinitialise les compteurs de trafic CDP
		> clear cdp table : Vide la table d'information CDP.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Telnet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

L'accès Telnet s'effectue sur une ligne VTY.
Chaque routeur dispose d'un total de 5 ou 16 lignes VTY selon le modèle.

	_______________
	Accéder à un hôte:

		> telnet {IP | nom} [N°port] : Établir une session telnet.
		> connect {IP | nom} : idem.
		> {IP | nom} : idem.

		> exit : Fermeture d'une session telnet.
		> disconnect : idem.

		[CTRL+MAJ+6] X : Suspendre la session Telnet.
		> show sessions :  Afficher la liste des sessions en cours.
		> resume {N°} : Reprendre la session telnet précisée.

Il est souvent possible qu'une érreur de commande soit interprété comme une connexion telnet. L'IOS tente alors de lancer une résolution DNS jusqu'a l'expiration du timeout. Pour y remédier, il faut alors désactiver le service DNS sur le routeur (si on ne l'utilise pas).

	_______________
	Configurerun accès telnet:

		> line vty 0 4

		(active 5 interface pour acces telnet)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Boot System
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	La recherche des images est définit par l'ordre dans lequel on a entré les commandes.

	(config)# boot system flash {Filename} : Spécifie le nom de fichier dans la Flash contenant l'IOS.

	(config)# boot system tftp {Filename} {IP_TFTP} : Précise le nom de fichier et l'adresse du serveur TFTP stockant l'image IOS.

	(config)# boot sytem rom : Spécifie que l'IOS est dans la ROM.

	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Registre de configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Le registre de configuration est codé sur 16 bits et est exprimé en hexadécimal. Valeur par défaut: 0x2102.

	0x---0 : Passer par le mode moniteur de mémoire ROM et attendre que l'utilisateur tape la commande b ou boot pour démarrer.
	0x---1 : Démarrer avec la première image présente en Flash ou en utilisant l'image minimaliste présente en ROM.
	0x---2 à 0x---F : Demander d'utiliser les commandes boot sytem présentes dans la configuration de sauvegarde. Si pas d'IOS trouvé, le routeur démarrera avec la première image dispo en Flash.
	
	(config)# config-register {value} : Modifie la valeur du registre.
	> show version : Affiche la valeur du registre de configuration.
	

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Mode SETUP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Mode de configuration intéractif.

	> setup : lancer le mode SETUP.
	[CTRL+C] : stopper le mode SETUP.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Sauvegarde de configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	> copy run start
	> wr mem

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Effectuer une copie
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	> copy {source} {destination} : Permet de copier un fichier vers une destination. La source peut être un mot clé (tftp, running-config...) ou une syntaxe IFS (IOS File System):
	{Plateforme}-{FeatureSet}-{Format}.{Version}.bin

	avec:
		Plateforme: Matèriel sur lequel l'image est prévue pour fonctionner.
		Feature Set: Code qui correspond aux fonctionnalités de l'image.
		Format: Permet de connaître le format de conditionnement de l'image.
		Version: Numéro de version de l'IOS.

	Cette commande permet notament de procéder à une maj de l'IOS.

	Avant de procéder il faut verifier:
		-Quantité de mémoire Flash disponible.
		-Sauvegarder l'image IOS actuelle.
		-Lancer la maj avec copy.
		-Vérifier la validité de l'image IOS (checksum).

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Variables d'environnements.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	IP_ADDRESS : Contient l'IP du routeur.
	IP_SUBNET_MASK : Contient le masque de sous-réseau du routeur.
	DEFAULT_GATEWAY : Contient l'IP de la passerelle.
	TFTP_SERVER : Contient l'IP du serveur TFTP.
	TFTP_FILE : Contient le chemin d'accès de l'image IOS du serveur TFTP.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RXBoot(/ROMmon)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Permet la récupération du mot de passe et du système.

	[CTRL+Pause] pendant 60s : Accéder au mode RXBoot.

	> confreg [value] : Afficher/modifier les paramètres de la ligne console.
		value: correspond à la valeur hexadécimal du registre de configuration à attribuer. (utile pour récupérer le mot de passe).

	> xmodem -c {Filename} : Lance la demande de chargement de l'IOS au travers de la ligne console.

	> dir {File system} : Affiche le contenu d'un système de fichiers.
	> boot [{préfixe}:{fichier}] : Démarre le routeur en utilisant une image IOS précise. (voir syntaxe IFS).
	> set : Permet de visualiser les valeurs des variables d'environnement.
	> tftpdnld : lance le téléchargement de l'image IOS en utilisant les valeurs des variables d'environnement.
	> reset : Redémarre le routeur.
	> i : Quitte le mode RXBoot et continue la séquence d'amorçage.

	
	_______________
	Récupération systeme:

		2 méthodes: Xmodem et tftpdnld.

		Xmodem:
			-Etape1: Modifier les paramètres de la ligne console avec la commande confreg (par défaut 56000 bauds à changer en 115200 bauds).
			-Etape2: Redémarrer le routeur avec reset et réentrer dans le mode RXBoot.
			-Etape3: Lancer la demande de téléchargement de l'image grâce à xmodem -c {Filename}.
			-Etape4: Lancer le téléchargement de l'image depuis le soft d'émulation de terminaux.
			-Etape5:Une fois le téléchargement terminé, effectuer un redémarrage du routeur.

		tftpdnld:
			-Etape1: Configurer les variables d'environnement.
			-Etape2: V2rifier les variables d'environnement avec set.
			-Etape3: Lancer le téléchargement de l'IOS avec tftpdnld.
			-Etape4: Relancer la séquence d'amorçage (i ou reset).

	_______________
	Sur un routeur:

		-[Ctrl + Pause] pendant la phase de démarrage;
		-confreg 0x2102		(permet de ne pas booté sur la startupconfig)
		-reboot une autre fois
		-conf t 
		-config-register 0x2142 	(permet de redémarrer dans le bon mode la prochaine fois)
		-faire sa conf
		-write mem

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DHCP:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	exemple:

		Config du dhcp:

		Configuration de l'interface du routeur
		Router(config)#ip dhcp pool private 
		Router(dhcp-config)#network 192.168.1.0 255.255.255.0
		Router(dhcp-config)#default-router 192.168.1.254
		exit
		ip dhcp excluded-address 192.168.1.0 192.168.1.250 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Routage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	------------------------
	Fonctions:
	------------------------

		2 fonctions distinctes && complémentaire:
			-routage 	: Determine le meilleur chemin et utilise une talble de routage pour acheminer le paquet.
			-commutation	: Accepte et traite les paquet en file d'attente d'entrée vers la sortie. (input -> output).
				
		Il est possible d'accélérer le processus de tranmission entre routage et commutation avec les méthodes suivantes:
			-Fast Switching : met en mémoire cache les décisions de routage pour chaque destination selon la première décision.
			-Silicon Switching
			-Autonomous Switching
			-CEF (Cisco Express Forwarding)

	------------------------
	Fast Switching:
	------------------------

		(config-interface)# [no] ip route-cache : Active/Désactive le Fast Switching sur l'interface courante. (Actif par défaut).

	------------------------
	Table de routage:
	------------------------
		
		Destination: Réseau de destination que l'on souhaite atteindre. 
			Si on ajoute plusieurs routes différentes (6 à 16max selon IOS), il faut renseigner un prochain saut différent pour chaque entrées. Ceci permet la répartition de charge (Round Robin).

		Interface de sortie : Correspond à l'interface (output) du routeur sur laquelle le paquet doit être acheminé pour atteindre le réseau de destination.

		Prochain saut: Adresse de couche 3 du prochain routeur sur le chemin pour attendre le réseau de destination.

		Métrique: Calculé par le protocole de routage, plus cette valeur est petite, plus la route est meilleur.

		Distance administrative: Indique un ordre de préférence entre les protocoles de routage. (Leur métrique n'est pas calculé sur les mêmes critères).
			Différentes valeurs:
				Directement connecté: 	0
				Statique:		1
				RIP:			120
				IGRP:			100
	
		Moyen d'apprentissage: Indique le protocole de routage qui a été employé:
				Directement connecté:	C
				Statique:		S
				RIP:			R
				IGRP:			I
				proto par défaut:	*

	------------------------
	Routage statique
	------------------------

		(config)# {protocole} routing : Active/désactive le routage pour un protocole routé (IP, IPX, IP6 ...)
		(config)# ip classless : Active le routage Classless sur le routeur (actif par défaut).
		(config)# ip route {préfixe} {netmask} {prochain saut | interface} [distance administrative] : Crée une route statique sur le routeur. ( =1 par défaut).
			Préfixe 0.0.0.0 & netmask 0.0.0.0 : route par défaut.


	------------------------
	Visualisation d'état
	------------------------

		> show ip protocols : Affiche des information sur la liste des protocoles de routages configurés sur le routeur.
		> show ip route : Affiche la table de routage IP
		> clear ip route [{préfixe} |*] : Supprime une ou plusieurs routes de la table de routage.
		
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RIP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------
		Commandes
	------------------------

	_______________
	(config) 

		# router rip 
			Passer en mode de configuration RIP

		# rip equal-cost {nombre}
			Indique le nombre d'entrées ayant la même métrique pouvant être insérées dans la table de routage.

	_______________
	(config-router) 

		# network {préfixe} 
			Spécifie le réseau qui sera inclut dans les maj de routage. 
			Détermine les interfaces appartenant à ce réseau qui participent au processus de routage. Le préfixe doit être un réseau directement connecté au routeur.

		# neighbor {IP} 
			Définit l'adresse IP d'un voisin avec lequel RIP échangera les maj de routage.

		# passive-interface {type} {N°} 
			Empêche l'interface indiquée d'envoyer des maj.

		# [no] ip split-horizon 
			Active/Désactive Split Horizon.

		# timers basic {update} {invalid} {holddown} {flush} 
			Définit les intervalles de temps, en secondes.

		# version {1|2}
			Indique la version de RIP utilisée par le routeur.

		# default-information originate
			Propage le réseau candidat par défaut aux autres routeurs RIP du système autonome.

		# maximum-paths {nombre} 
			Spécifie le nombre maximum de liens ayant la même métrique pouvant être utilisés pour la répartition de charge.

		# redistribute static 
			Injecte les routes statiques locales et les propagent dans les maj RIP.

	_______________
	(config-interface) 

		# ip rip {send | receive} version {1|2|12} 
			Spécifie le type de maj reçues.

	------------------------
	Configuration
	------------------------

	[Etape1]: Activer le protocole RIP (router rip)
	[Etape2]: Spécifier les réseaux directement connectés devant participer au processus de routage (network)
	[Etape3]: Désactiver l'émission de maj de routage vers les réseaux n'ayant pas de routeur RIP autre que le routeur local (passive-interface)
	[Etape4]: Ajuster les différents compteurs de temps (timers basic)
	[Etape5]: Choisir la version RIP
	[Etape6]: Propager la route par défaut existante sur le routeur local aux autres routeurs RIP du système autonome (default-information originate).
	[Etape7]: Activer la répartition de charge entre plusieurs liens de même métrique (maximum-paths).

	exemple:

		>conf t
		>router rip
		>network 172.16.1.0
		>network 100.0.0.0
		>network 90.0.0.0
		>version 2
		>no auto-summary
		>exit
		>show ip route

	Pour RIPv2 (et surtout le classless), ne pas oublier de désativer l'auto summary: no auto-summary.

	------------------------
	Vérifications
	------------------------

	> show ip protocols : Affiche les compteurs RIP, les interfaces participant au processus de routage, les versions ...
	> show ip rip database : Affiche la FIB (Forward Information Base) de RIP.
	> debug ip rip [events] : Affiche en temps réel les maj RIP envoyées et reçues.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
IGRP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Il ne peut y avoir qu'une seule instance IGRP par N° d'AS. 
Il peut donc y avoir plusieurs instances d'IGRP sur un même routeur.

	------------------------
	Commandes
	------------------------

	_______________
	(config)

		# router igrp {AS} 
			Active le protocole de routage IGRP pour le système autonome indiqué et permet de passer en mode de configuration routeur.

		# ip default-network {préfix}
			Définit un réseau candidat par défaut à propager dans le système autonome.
			Le réseau indiqué doit être connu des routeurs IGRP et doit être directement connecté.
			La route propagée sera vue par les autres routeurs IGRP comme une route externe.
			

	_______________
	(config-router)

		# UTILISE LES MÊME COMMANDES QUE RIP (sauf pour le versioning et ce qui est propre à RIP)
			-network
			-neighbor
			-passive-interface
			-split-horizon
			-maximum-paths
			-timers basic
			-redistribute static


		# variance {value}
			Permet la répartition de charge entre les liens n'ayant pas la même métrique.
			La valeur peut varier de 1 à 128 (def = 1).
			La variance est un coef multiplicateur permettant de sélectionner les routes ayant des métriques identiques à la variance près pour faire de la répartition de charge pondérée (Weighted Round Robin).

		# metric weights {TOS} {K1} {K2} {K3} {K4} {K5}
			Spécifie les valeurs pour les coefs utilisés pour la calcul des métriques.
			TOS doit toujours être à 0.

		# metric maximum-hops {value}
			Indique le nombre maximum de sauts (diamètre du système autonome).
			Valeur pouvant aller de 1 à 255 (def = 100).

		
	_______________
	(config-interface)

		# bandwidth {BP}
			Définit la bande passante de la liaison.
			Exprimé en Kbps.


	
	------------------------
	Configuration
	------------------------

	Etape1: Activer le protocole de routage IGRP (router igrp).
	Etape2: Spécifier les réseaux directement connectés devant participer au processus de routage (network).
	[Etape3]: Désactiver l'émission de maj de routage vers les réseaux n'ayant pas de routeur IGRP autre que le routeur local (passive-interface).
	[Etape4]: Ajuster les différents compteur de temps (timers basic).
	[Etape5]: Propager la route par déf existante sur le routeur local aux autres routeurs IGRP du système autonome (ip default-network).
	[Etape6]: Activer la répartition de charge entre plusieurs liens de même métrique (maximum-paths && variance).

	------------------------
	Vérifications
	------------------------

	> show ip protocols
	> debug ip igrp events : Affiche en temps réel les événements d'IGRP.
	> debug ip igrp transactions : Affiche en temps réel les échanges d'IGRP.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ICMP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------
	Configurer ICMP Redirect
	------------------------

	_______________
	(config-interface)
		
		# [no] ip redirects
			Active/désactive les messages ICMP Redirect
			(Actif par défaut)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Résolution des problèmes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------
	Commandes de vérifiation
	------------------------

	> telnet {IP | hostname} [N°tcp_port] : Test le plus complet car il permet de vérifier toute les couches du modèle OSI

	> ping [IP | hostname} : Mécanisme de base de couche 3

	> trace {IP | hostname} : Vérification de connexion de chaque routeur situé sur le chemin jusqu'a la destination


	------------------------
	Débogage
	------------------------

	> no debug all : Permet de stopper tous les débogages en cours
	> undebug all : idem
	> debug all : Affiche l'intégralité des informations de débogage disponibles.

	
	-----------------------
	Procédure de récupération des mots de passe d'un routeur
	------------------------

	Nécessite un accès console et 2 redémarrages:

		_______________
		Premier redémarrage:

			-Redémarrer physiquement ou avec la commande reload
			-Appuyer sur [CTRL + Pause] avant expiration des 60 secondes pour démarrer en mode RXBoot.
			-Changer la valeur du registre de configuration afin de forcer le routeur à ignorer le fichier de configuration de sauvegarde lors du démarrage:
				-Commande o/r 0x2142 (routeurs 2500)
				-Commande confreg 0x2142 (routeurs 1600, 1700, 2600, 3600, ...)
				-Commande i (routeurs 2500).
				-Commande reset (routeurs 1600, 1700, 2600, 3600, ...).

		_______________
		Deuxieme redémarrage:
			
			-Quitter le mode SETUP (CTRL +C)
			-Il est maintenant possible d'accéder au mode privilégié.
			-Restaurer la valeur initiale du registre:
				config-register 0x2102

		_______________
		Restaurer la configuration précédente:

			-Importer la confiuration (copy start run)
			-Changer les mots de passe
			-Sauvegarder la configuration (copy run start)
			-Redémarrer le routeur (reload)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
VLAN
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	liens:
		http://clemanet.com/switch-vlan-cisco.php


	Le but du Vlan étant de faire des réseaux étanche ethernet virtuel.
	il permetent de limiter l'étendue des broadcast sur le swicth et implémenter un peu de sécurité.
	On peu les configurer selon plusieurs critère: port, ip ...


	méthode de configuratio sur un port:

		(config)#	vlan X
		(config-vlan)#	name STRING
		(config-vlan)#	ex
		(config)#	vlan X,Y,Z
		(config-vlan)#	ex

	Supression d'un vlan:

		(config)#	no vlan X

	Affectation d'un port à un vlan:

		(config-if)#	switchport mode access
		(config-if)#	switchport access vlan X
		(config-if)#	ex

		sur plusieurs interfaces:
		
		(config)#	interface range fastEthernet 0/N-M
		...

	
	-----------------------
	TRUNK (se fait au niveau du switch)
	------------------------

	Le trunk chez cisco (à ne pas confondre avec les autres constructeurs qui peuvent parler de LAG) permet de faire transiter sur un seul lien plusieurs vlan, on économise ainsi des ports du switch. 
	Note: il faudra configurer sur le routeur une sous-interface pour chaque vlan.

  Source : https://www.reseaucerta.org/sites/default/files/VLAN_5.pdf

  "Remarque : dans la terminologie CISCO un lien trunk correspond à un lien étiquetée alors que pour la
plupart des autres constructeurs un lien trunk correspond à une agrégation de liens (notamment chez
Allied-Telesyn et HP) Une agrégation de liens chez CISCO est un Etherchannel."


		(config-if)#	switchport trunk encapsulation dot1q
		(config-if)#	switchport mode trunk
		(config-if)#	ex

	-----------------------
	Filtrage des vlans sur un port uplink
	------------------------

		Ce filtrage s' applique sur le lien trunk:
		
		_______________
		Autoriser un vlan sur le trunk

			(config-if)#	switchport trunk allowed vlan add X,Y,Z

		_______________
		Supprimer un vlan autorisé
			
			(config-if)#	switchport trunk allowed vlan remove X

		_______________
		Suppresion du filtrage

			(config-if)#	no switchport trunk allowed vlan

	-----------------------
	Vlan dédié à la téléphonie:
	------------------------

		(config)#	switchport voice vlan X



				
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ACL - Access Control List
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-S'applique dans l'odre.
	-Une ACL pour un trafic sortant n'affecte pas le trafic originaire du routeur local.
	-S'applique à une interface.
			
	-----------------------
	ACL standard
	------------------------

		-ACL les plus simple et moins gourmandes en ressources CPU.
		-Ne peut indiquer que des adresses sources.
		-Permet d'autoriser/interdire des adresses spécifiques ou bien un ensemble d'adresses ou de protocoles.
		-à placer au plus près de la destination.

		_______________
		(config)

			# access-list {N°} {permit | deny} {préfixe} [wildcard] [log]
			# access-list {N°} {remark} {commentaire}
				Si le masque générique n'est pas précisé, le masque par défaut 0.0.0.0 est utilisé.
				log permet de garder en mémoire le nombre de paquets correspondants à l'instruction en cours.
				remark suivi d'un commentaire permet d'indiquer l'utilité de l'instruction.

	-----------------------
	ACL étendue
	------------------------
		
		-Permet de faire un filtrage plus précis qu'une ACL standard.
		-Peut filtrer en fonction de:
			-protocole utilisé (couche 3 et 4)
			-adresse source
			-adresse destination
			-N° de port

		-à placer au plus près de la source.


		_______________
		(config)

			# access-list {N°} {permit | deny} {protocol} {préfixe source} {wildcard_src} [{opérateur} | {opérande}] {préfixe destination} {wildcard_dest} [{opérateur} {opérande}] [icmp-type] [log] [established]
			# access-list {N°} {remark} {commentaire}
				
				protocole peut être soit le nom (IP, TCP, UDP, ICMP, IGRP, ...) soit le numéro.
				opérateur/opérande pour les numéros de ports TCP ou UDP uniquement:
					eq : equal
					neq : no equal
					lt : lower than
					gt : greater than
					range : (nécessite 2 N° de ports)
				icmp-type : correspond au nom ou au numéro du type de message ICMP devant être vérifié.
				established: pour TCP, permet de faire correspondre les sessions TCP déja établies. (flags: ACK, FIN, PSH, RST, SYN ou URG)

	-----------------------
	ACL nommée
	------------------------

		-Permet d'identifier avec des châine les ACLs.


		_______________
		(config)

			# ip access-list {standard | extended} {nom}
				créer une ACL standard ou étendue

		_______________
		(config-acl)

			# {permit | deny} {préfixe} [masque] [log]
				idem que pour une ACL standard numérotée.
			# {permit | deny} {protocol} {préfixe source} {masque source} [{opérateur} | {opérande}] {préfixe destination} {masque destination} [{opérateur} {opérande}] [icmp-type] [log] [established]
				idem que pour ACL étendue

			# remark {commentaire}
				fournir un commentaire


	-----------------------
	Mise en place et vérification des ACLs
	------------------------
		_______________
		(config-interface)

			# ip access-group {N° | nom} {in|out}
				Appliquer une ACL

		_______________
		(config-line)

			# access-class {N° | nom} {in | out}
				Appliquer une ACL sur une ligne


		_______________
		(config)
			
			# no access-list {N°}
				Supprimer une ACL numérotée


		_______________
		Vérifications:

			> show access-lists [N° | nom]
			> show ip interface [{type} {numéro}]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Promiscuous mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

http://www.cisco.com/en/US/docs/security/ips/5.0/configuration/guide/cli/cliinter.html

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Port Mirroring (SPAN)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

link:

	http://www.cisco.com/en/US/docs/switches/lan/catalyst2940/software/release/12.1_19_ea1/configuration/guide/swspan.html

	Le port mirroring permet de diffuser l'intégralité du traffic reçut sur un port sur un autre port.

	
	_______________
	activer le monitoring d'un port:

		(config-if)#	port monitor fastethernet 0/1

	_______________
	configurer la source:

		(config)#	monitor session X source interface fasthernet Y/Z

	_______________
	configurer la destination:

		(config)#	monitor session X destination interface fastethernet Y/X
	



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Routage Classless
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Règles (selon la norme)
		2^n -2 : premier sous-réseau et broadcast exclus.
		2^n -1 : premier sous-réseau exclu.
		2^n : utilisation de tout les sous-réseaux.

	Le CIDR et le VLSM on été nécéssaire pour l'envoie du masque de sous-réseaux aux équipement afin de pouvoir gérer des sous-réseaux et économiser des adresses IPv4.
	

	-----------------------
	CIDR - Classless Inter-Domain Routing
	------------------------

		Permet d'alléger la taille des tables de routage.
		Permet d'agréger plusieurs routes en une seule.

		Pour ce faire on compare les bits de chaque réseau, on garde la partie commune (partie réseau restant toujours égal entre chaque réseaux). Puis on determine la route agrégée:

		exemple:
		Réseaux:		
			10.3.4.0 /24	00001010.00000011.00000100.00000000
			10.3.5.0 /24	00001010.00000011.00000101.00000000
		Masque: 255.255.252.0	11111111.11111111.11111100.00000000
		Route agrégée: 10.3.4.0 /22

		
		
	L'emploie du CIDR n'est possible que si:
		-Le protocole de routage utilisé transporte les préfixes étendus dans ses mises à jour.
		-Les routeurs implémentent un algorithme de la correspondance la plus longue.
		-Un plan d'adressage hiérarchique est appliqué pour l'assignation des adresses afin que l'agrégation puisse être effectuée.
		-Les hôtes et les routeurs supportent le routage classless.
	

	------------------------
	VLSM - Variable Length Subnet Mask
	------------------------

		Permet à un réseaux classless d'utiliser différents masques de sous-réseaux.

		-Néssecite d'employer un protocole de routage supportant le VLSM (RIPc2, OSPF, IS-IS, EIGRP, BGP, routage statique supportant VLSM).
		-Les routeurs doivent implémenter un algorithme de la correpondance la plus longue.
		-Un plan d'adressage hiérarchique doit être appliqué pour l'assignation des adresses afin que l'agrégation puisse être effectuée.
		VLSM repose sur l'agrégation (plusieurs adresses de sous-réseaux sont résumées en une seule adresse). 


	------------------------
	Réalisation
	------------------------
		_______________
		VLSM Symétrique 

			Cas typiquement scolaire où chaque instance/hiérarchie sont similaire (nombre, taille ...)

			Etape1: on recense les niveaux hiérarchiques de l'entreprise (Entreprise dans X villes, Y batiments de Z étages avec N utilisateurs)
			Etape2: on identifie la taille du sous-réseau (Nbre user + broadcast + réseau + gateway = A)
			Etape3: on determine le nombre de bits nécéssaires. (2^B >= A ; B = ?)
			Etape4: on determine la classe d'adresse ou l'agrégat d'adresse (classe A, B C ???)
			Etape5: on découpe la classe d'adresse et on attribue une adresse réseau/masque à chaque niveau.

			Si on utilise une régle 2^n-1 ou 2^n-2, il faudra l'appliquer une seule fois sur toute la topologie.


		_______________
		VLSM Asymétrique

			Cas réel, chaque instance est différente.

			Etape1: Dessiner la topologie, identifier les besoins de chaque niveau hiérarchique.
			Etape2: Connâitre le nombre d'hôte par sous-réseaux.
			Etape3: Determiner la classe d'adresse.
			Etape4: On procede à l'adressage. (processus récursif montant)


	------------------------
	Configuration
	------------------------

		_______________
		(config)

			# ip subnet-zero
				Permet d'utiliser le premier sous-réseau (2^n)

			# ip classless
				Permet d'activer le support des masques de sous-réseau et d'une route par défaut.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RIP v2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------
	Commandes
	------------------------
		_______________
		(config)

			# router rip
				Active le protocole RIP

		_______________
		(config-routage)

			# version 2
				Utiliser RIPv2

			# network {adresse réseau}
				Indique les réseaux directement connectés au routeur.

			# ip default-network {adresse réseau}
				Spécifier une route par défaut.

			# default-information originate
				Propager la route par défaut dans les maj de routage.
			
			# no auto-summary
				Désactive l'auto-agrégation.


	------------------------
	Authentification
	------------------------

		_______________
		(config)

			# key-chain {nom}
				Identifier un groupe de clef d'authentification.

		_______________
		(config-key)

			# key {id}
				Permet de créer une clef dans un groupe de clef. L'identifiant de clef peut prendre une valeur de 0 à 2147483647. L'identifiant de clef peut ne pas être consécutif.

			# key-string {password}
				Définir le mot de passe pour une clef
			
			# ip rip authentication key-chain {nom}
				Active l'authentification RIP sur une interface
			
			# ip authentication mode {text | md5}
				Spécifier le type d'authentification en clair ou crypté.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OSPF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	------------------------
	Commandes
	------------------------

		_______________
		(config)

			# router ospf {id processus}
				Active OSPF
				Plusieurs processus peuvent être lancés.

			# interface loopback {number}
				Creer une interface logique
		_______________
		(config-routeur)

			# network {préfixe}
				Spécifie les réseaux devant participer au processus de routage.
				Le préfixe correspond à un réseau directement connecté au routeur.

		_______________
		(config-interface)

			# bandwidth
				Spécifie la bande passante sur l'interface

			# ip ospf prority {number}
				Modifier la priorité d'une interface pour l'élection du DR.
				Valeur pouvant allé de 0 à 255.

			# ip ospf cost {number}
				Spécifie la valeur du coût.


	------------------------
	Authentification
	------------------------

		_______________
		(config-routeur)

			# area {N°aire} authentication
				Active l'authentification OSPF pour le mot de passe en clair.

			# area {N°aire} authentication message-digest
				Active l'authentification pour le mot de passe encrypté.

		_______________
		(config-interface)

			# ip ospf message-digest-key {key-id} md5 {type d'encryption}
				Permet l'encryption du password

			# ip ospf authentication-key {password}
				Spécifie le password utilisé pour générer les données d'authenfication de l'en-tête de paquet OSPF.

		
	------------------------
	Timers
	------------------------

		_______________
		(config-interface)
			
			# ip ospf hello-interval {intervalle}
				Définit la fréquence d'amission des paquets HELLO.

			# ip ospf dead-interval {intervalle}
				Définit la durée pendant laquelle un lien sera considéré comme actif, après que le routeur ai reçu un paquet HELLO d'un routeur voisin.


	------------------------
	Vérifications
	------------------------

		> show ip ospf interface
			Afficher la priorité de l'interface

		> show ip protocols
			Afficher les infos sur les protocoles de routage.

		> show ip route
			Afficher la table de routage

		> show ip ospf
			Affiche la durée pendant laquelle le protocole est activé ...

		> show ip ospf neighbor detail
			Affiche une liste détaillée des voisins.
		
		> show ip ospf database
			Affiche le contenu de la base de données topologique.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
EIGRP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------
	Commandes
	------------------------
		_______________
		(config)

		# router eigrp {n°AS}
			Active Eigrp
			passe en mode conf routeur
			
		_______________
		(config-routeur)

		# network {réseau} [masque générique]
			Spécifie sur quel réseau EIGRP sera actif

		# [no] auto-summary
			Permet d'activer l'agrégation de routes aux frontières Classful (par défaut)

		# variance {multiplicateur}
			Variance max des routes de la table de routage.
			multiplicateur de 1 à 128

		# maximum-paths {nombre}
			de 1 à 6 routes à métriques égales pouvant être mises dans la table de routage pour une même destination.

		# passive-interface {type} {N°}
			Empêche l'émission et la réception de mises à jour de routage en empêchant la formation d'une relation de voisinage sur l'interface spécifiée.

		# metric weight {TOS} {K1} ... {K5}
			Modifie les coefficients de la métrique
			TOS doit toujours être = à 0

		_______________
		(config-interface)

		# ip summary-address eigrp {n°AS} {réseau} {masque}
			Configurer manuellement un agrégat de routes à une frontière Classless
			no auto-summary doit être établi

		# bandwidth {BP}
			Informe les protocoles de routage utilisant la BP pour le calcul des métriques.
			La bande passante d'une liaison n'est pas détéctée, elle est égal à 1544 Kbps (T1) par défaut pour les interfaces série haut débit.
			En Kbps.


	------------------------
	Visualisation
	------------------------

		> show ip route [eigrp [n°AS]]
			Visualiser les routes eigrp

		> show ip eigrp neighbors [{type} {n°} [n°AS]] [detail]
			Fournit toutes les informations sur les voisins, l'état de la relation de voisinage ainsi que les interfaces et adresses par lesquelles ils communiquent.

		> show ip eigrp topology [all | n°AS | [IP] masque ]
			Affiche les infos de la table de topologie

		> show ip eigrp traffic [n°AS]
			Infos trafic total envoyé depuis et vers le processus EIGRP.

		> show ip eigrp interfaces [n°AS] [detail]
			Infos sur interfaces participant au processus de routage EIGRP.


	------------------------
	Debug
	------------------------

		> debug eigrp packet
		> debug ip eigrp
			Affiche les paquets EIGRP émis et reçus
		> debug eigrp neighbors
			Affiche les paquets Hello émis et reçus par le routeur ainsi que les voisins découverts.

		> debug ip eigrp route
			Affiche les changements dynamiques apportés à la table de routage.

		> debug ip eigrp summary
			Affiche un résumé des informations concernant EIGRP telles que les voisins, le filtrage et la redistribution.

		> debug eigrp events
			Affiche les types de paquets émis et reçus et les stats sur les décisions de routage.

	------------------------
	Configuration
	------------------------

		-Activer le protocole EIGRP (router eigrp)
		-Indiquer les interfaces devant participer au processus de routage (network)
		-Optionnel: Spécifier la bande passante réelle de la liaison (bandwidth)
		-Optionnel: Désactiver l'émission/réception des informations de routage vers les interfaces connectées à des réseaux moignons (passive-interface)
		-Optionnel: Meilleure gestion des routes (maximum-paths, variance, metric weights)
		-Optionnel: Agrégation de routes manuelle (no auto-summary, ip summary-address)
		

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NAT ET PAT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	Le but du pat et du nat est d'économiser des adresses IP.
	La translation permet de substituer une adresse par une autre.

	NAT = Network Address Translation
	PAT = Port Address Translation

	4 types d'adresses pour le NAT:
		
		-Inside local address
			Adresse IP attribuée à un hôte dans le LAN

		-Inside global address
			Adresse IP attribuée par le FAI

		-Outside local address
			Adresse IP d'un hôte sur le réseau externe telle qu'elle est connu par les hôte internes. (= outside global address)

		-Outside global address
			Adresse IP attribuée à un hôte dans le réseau externe


			INSIDE LOCAL 	| 	INSIDE GLOBAL 	| 	OUTSIDE GLOBAL

			Hôtes LAN      router		     internet		Server X

		NAT statique: translate une adresse IP privée avec toujours la même IP public. (une IP pub par hôte)
		NAT dynamique: translate une addresse privée avec un pool d'adresse IP public.
				Un hôte n'utilisera donc pas toujours la même IP pub, s'il toute les adresse sont utilisée, il faudra attendre qu'une se libère.

		PAT (Overloadig): Attribue une IP pub pour la translation de plusieurs IP privées.
				Chaque hôte est différencié par un numéro de port unique.
				En moyenne un équipement réseau peur translater envirion 4000 ports par adresse pub.

	------------------------
	Commandes
	------------------------
		_______________
		(config)

		# ip nat inside source static {local-ip} {global-ip}
			Établie une translation static entre une 'Inside local address' et une 'Inside global address'

		# ip nat inside static tcp {locap-ip} {port} {global-ip}
			Permet de faire de la translation sur un port

		# access-list {n°} permit {prefix} {wildcard_mask}
			Spécifie le ou les réseaux autorisés à être translatés

		# ip nat inside source list {n°} pool {pool_name}
			Définie le pool qui va être translaté

		# ip nat pool {pool-name} {first_ip} {last_ip} netmask {mask}
			Spécifie le pool d'adresses IP 

		# ip nat inside source list {n°} interface type {n°} overload
			Configuration du PAT sur l'interface outside

		# clear ip nat translation
			Configuration du PAT sur l'interface outside
		
		_______________
		(config-interface)

		# ip nat inside|outside
			spécifie l'interface out ou in

		
	------------------------
	Configuration
	------------------------

		Exemple de configuration du PAT:

		Router(config)#interface fastEthernet 0/0
		Router(config-if)#ip nat inside
		Router(config-if)#exit
		Router(config)#interface serial 1/0
		Router(config-if)#ip nat outside
		Router(config-if)#exit
		Router(config)#access-list 1 permit any
		Router(config)#ip nat inside source list 1 interface serial 1/0 overload 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
IPV6
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	------------------------
	Interface en ipv6
	------------------------
	
		Router(config-if)#ipv6 address 3001:11:0:1::10/64

	------------------------
	Activation du routage IPv6
	------------------------

		Router(config)#ipv6 unicast-routing
		Router(config)#ipv6 route ::/0 2001:DB8:3002::9

	------------------------
	RIPng
	------------------------

		Router(config)#ipv6 unicast-routing
		(config-if)#ipv6 rip $domain_name enable
		(config)#ipv6 router rip $domainanme
		(config)#redistribute connected

		Debug:

			show ipv6 route
			debug ipv6 rip


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Security
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------
	outils de sécurité:
	------------------------
	IDS (Intrusion detection system) : détéction en temps réel de certaines attaques.
	IPS (Intrusion Prévention system) : Remplace l'IDS en ajoutant la capacité à bloquer les attaques.
	Firewall : Empeche le trafic indésirable


	------------------------
	2 catégories d'attaques internet:
	------------------------
	Spoofing : Usurpation d'identité
	DoS (Denial of Service) : Sature les ressource d'un ordinateur.

	------------------------
	Quelques organisations dédiés à la sécurité:
	------------------------
	-SANS
	-CERT
	-ISC 
	...

	------------------------
	12 domaines de sécurité réseaux:
	------------------------

	-Risk Assessment (Évaluation des risques)
	-Security Policy (Politique de sécurité)
	-Organization of Information Security
	-Asset Management (Gestion des biens)
	-Human Ressources Security
	-Physical and Environmental Security
	-Communications and Operations Management
	-Access Control
	-Information Systems Acquisition, Development and Maintenance
	-Information Security Incident Management
	-Business Continuity Management
	-Compliance (Conformité)

	------------------------
	SDN : Cisco Self-Defending Network : utilise le réseau pour identifier, prévenir et s'adapter aux menaces.
	------------------------
	Une topologie SDN inclue :
		-Un gestionnaire de Sécurité Cisco
		-Un systeme de surveillance (Monitoring), d'analyse (Analysis), et de réaction/réponse (Response System) = MARS
		-IPSs
		-Firewalls
		-Routers
		-VPN concentrator

	------------------------
	3 grand types d'attaques réseaux:
	------------------------

	-Reconnaissance Attacks : Découvertes des failles et de la topologie réseau.
		-packets sniffers
		-Ping sweeps
		-Port scans
		-Internet information queries

	-Access Attacks : Utilisation des failles afin de récupérer des informations au seins des DB ..
		-Password attack (brute-force attacks, trojan, sniffers...)
		-Trust exploitation: Utilisation des droits d'un système pour corrompre un autre hôte.
		-Port redirection: Un hôte est utilisé comme source pour atteindre d'autres cibles.
		-Man in the middle attack: Permet d'usurper l'identité d'un hôte pour modifier, intercepter des informations.
		-Buffer overflow: Consiste à saturer la mémoire tampon d'un programme pour modifier des variables et exécuter des codes malveillants introduits dans le programme. 

	-Denial of Service Attacks: Saturer les ressources d'un réseau, d'un système en effectuant un maximum de requête.

	------------------------
	Atténuer les attaques réseaux:
	------------------------
	-Garder des systèmes à jour.
	-Eteindre les services et ports non utilisés.
	-Utiliser des mot de passe fort et les changer régulièrement.
	-Contrôler l'accès physique aux systèmes.
	-Eviter les page web inutiles.
	-Instorer des backups
	-Eduquer les utilistaeurs.
	-Crypter les données
	-Ajouter du métèriel de sécurité comme les firewall...
	-Développer un police de sécurité.


	------------------------
	Secure the edge router:
	------------------------

	-Physical
	-OS
	-Hardening

	------------------------
	Secure Administrative Access:
	------------------------
	First stape, secure lines with strong password:
	
	_______________
	(config)
		# enable secret {pwd}
		# line vty 0 4
		# line aux 0
		# line con 0
		# security passwords min-lenght
		# [no] service password-encryption
		# username {name} password {pwd}
		# username {name} secret { [0] password | 5 encrypted-secret}

	_______________
	(config-line)
		# password {pwd}
		# login 
		# [no] exec-timeout {minutes} [secondes]
		# login local
		
	_______________
	Step to secure:
		1: set service password-encryption
		2: set username password
		3: set username secret
		4: configure line
		5: use login local
	
	------------------------
	Configuring enhanced security for virtual logins
	------------------------

	_______________
	(config)
		# login block-for {seconds} attempts {tries} within {seconds}
		# login quiet-mode access-class {acl-name | acl-number}
		# login delay {seconds}
		# login on-failure log [every {login}]
		# login on-success log [every {login}]
		# login quiet-mode access-class {id}
		# ip access-list standard {id}
		# security authentication failure rate {threshold-rate} log 
		# banner {exec | incoming | login | motd | slip-ppp} d message d

	_______________
	(config-std-nacl)
		# remark Permit only Administrative hosts
		# permit {IP}

	_______________
	Verif:
		> show login
		> show login failure
		
	_______________
	step:
		1: conf username secret
		2: conf line (login local)
		3: use login block
		4: ip access-list standard 
		5: use remark
		6: permit
		7: login quiet
		8: login delay
		9: login success
			or use security authentication
		10: login failure

	------------------------
	SSH
	------------------------

	_______________
	(config)

		# ip domain-name 
		# crypto key generate rsa general-keys modulus {modulus size} : modulus-size : size of RSA key (360 bits -> 2048)
		# username {name} secret {pwd}
		# line vty 0 4
		# ip ssh version {1 | 2} 
		# ip ssh time-out {seconds}
		# ip ssh authentication-retries {number}

	_______________
	(config-line)

		# login local
		# transport input ssh
		# exit

	_______________
	client connection:

		> ssh [-l {userid}, -p {port}]
			

	_______________
	Verifs:

		> show crypto key mypubkey rsa
		> show ip ssh
		> sho ssh

	_______________
	Step (server):

		1: Configure the IP domain name (ip domain-name)
		2: Generate one-way secret keys
		3: Verify or create a local database entry
		4: Enable VTY inbound SSH sessions

	_______________
	SDM:
		Configure > Additional Tasks > Router 
			Access > SSH

		Configure > Additional Tasks > Router Access > VTY
			Edit


	_______________
	Exemple:
		
		> crypto key zeroize RSA
		> crypto key generate RSA modulus 1024
		> aaa authentication ssh console LOCAL
		> username admin password cisco privilege 15
		> ssh 80.80.80.80 255.255.255.255 outside
		> ssh timeout 5
		> ssh version 2
		> ssh 172.16.1.0 255.255.255.0 inside



	
	------------------------
	Configuring Privilege levels
	------------------------

	level 0 : include: disable, enable, exit, help and logout
	level 1 : default level , cannot make any changes or wiex running configuration file.
	level 2-14 : May be customized.
	level 15 : Reserved for enable mode privileges (enable command). Can change and view conf

	> privilege <mode> {level <level command> | reset} [command]

	_______________
	Create Privilege Levels:

		# 	conf t
	(config)#	username USER privilege 1 secret cisco

			privilege exec level 5 ping 
			enable secret level 5 cisco
			username SUPPORT privilege 5 secret cisco5

			privilege exec level 10 reload
			enable secret level 10 cisco10
			username JR-ADMIN privilege 10 secret cisco10

			username ADMIN privilege 15 secret cisco123

	------------------------
	Configuring Role Based CLI Access
	------------------------

	_______________
	Create view:

	step:
		1: Enable AAA (aaa new-mode) exit
			enter root view (enable {view [view-name]})
		2: Create a view (parser view [view-name]})
		3: Assign secret password to the view (secret {PWD})
		4: Assign commands to the view (commands {parser-mode} {include | include-exclusive | exclude} [all] [interface INTERFACE-NAME | COMMAND]
		
	Exemple:
	(config)#	parser view VERIFYVIEW
	(config-view)#	secret cisco5
			commands exec include ping
			exit

	
	_______________
	Create superview:

	step:
		1: Create a view : (parser view VIEW-NAME superview)
		2: Assign a secret pwd : (secret PWD)
		3: Assign an existing view : (view VIEW-NAME)
		4: exit

	To acces a view: use (enable view)
		

	------------------------
	Securing IOS and Configuration Files
	------------------------

	_______________
	(config)#
		secure boot-image : Enable Cisco image resilience
		secure boot-config : Make an config archives in persistent storage

	_______________
	verifs
		show secure bootset : verify backup and security

	_______________
	restore a primary bootset from archive:

		1: reload the router (reload)
		2: From ROMmon, enter dir && show secure bootset
		3: use boot command with filename found in step 2
			When router boots, change privileged EXEC mode and restore conf
		4: conf t
		5: secure boot-config restore FILENAME command

	_______________
	Recovering a router password:

		1: Connect to the console port
		2: show version : write configuratin register (hexadecimal value like 0x2102)
		3: Use power switch 
		4: put router into ROMmon (Ctrl-Break)
		5: confreg REGISTER_VALUE (0x2142)
		6: reset (at romon 2> prompt)
		7: type "no" or Ctrl-C to skip initial setup procedure
		8: enable (at router prompt)
		9: copy startup-config running-config
		10: show running-config (to view pwd)
		11: enable secret PWD
		12: no shutdown on every interface
		13: config-register REGISTER_VALUE
		14: copy running-config startup-config
			show version (to confirm register setting)

	_______________
	Break recovering pwd:

		(config)#
			no service password-recovery

	------------------------
	Secure Management and reporting
	------------------------
	
	Information flow between management hosts and the managed devices can take two paths:
		
		Out-of-band (OOB): Information flows on a dedicated management network on which no production traffic resides.
			-Provide the highest level of security and mitigate the risk of passing insecure management protocols over the production network.


		In-band : Information flows across an enterprise production network, the internet, or both using regular data channels.
			-Apply only to devices that need to be managed or monitored.
			-Use IPsec, SSH, or SSL when possible
			-Decide whether the management channel needs to be open at all times.

	
	------------------------
	Using Syslog for Network Security
	------------------------

	It is possible to configure the router router to send log messages:
		Console: log can be viewved while connected to the console port of the router.

		Terminal lines: can be configured to  receive log messages on any terminal lines. 

		Buffered logging: log message are stored in router memory for a time.

		SNMP traps: require the configuration and maintenance of SNMP system.

		Syslog: send log messages to an external syslog service.

	Security levels:

		0 : emergencies
		1 : alerts
		2 : critical
		3 : errors
		4 : warnings
		5 : notification
		6 : informational
		7 : debugging

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
IPSEC (ASA + Routeurs)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	show crypto isakmp sa
	show crypto ipsec sa
	
	crypto isakmp policy 200
	encryption des 
	group 1
	hash md5 
	authentication pre-share
	lifetime 68400

	
	crypto isakmp policy 100
	hash md5
	authentication pre-share

	crypto isakmp key cisco123 address 60.60.60.253

	crypto ipsec transform-set MYIS esp-des esp-sha-hmac

	crypto map MYMAP 10 ipsec-isakmp
	set peer 60.60.60.253
	set transform-set MYIS
	match address 100

	spanning-tree mode pvst



=======================================================================
		N E W  		T E M P L A T E 
=======================================================================

Attention, les lignes de configuration cisco peuvent varier d'un modèle à l'autre, bien s'orienter vers la doc officiele.

~~~~~~~~~~~~~~~~~~~~~~~~~~
F E A T U R E S
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Voici une liste des fonctionnalitées que l'on retrouve souvent sur les équipements cisco :

        EtherChannel : Agrégations de liens
        VLAN : tag appliqué sur les paquet pour créer des réseaux virtuels
        mode TRUNK : Un port laissant passer plusieurs vlan 'tagged'.
            Il est possible de filtrer les VLAN qui y transitent.
            On peut aussi appliquer un VLAN par défaut (Untagged). (Native VLAN)
        mode ACCESS : Application de Vlan 'Untagged', c'est à dire que le VLAN est géré virtuellement entre les ports du switch.
            Peut recevoir du flux appartenant à son VLAN en Rx.
            Renvoi du flux non tagué en Tx.
        Stack : groupement de plusieurs équipement pour n'en gérer qu'un virtuellement. (HA)
        SPAN : port mirroring
        ...

~~~~~~~~~~~~~~~~~~~~~~~~~~
A L L
~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------
	Bases
	------------------------

		>	hostname XX
		> 	enable secret $PASSWORD
		
		pour chiffrer tout les password dans la conf:

		>	service password-encryption

	------------------------
	Initialiser une interface:
	------------------------

                >       default interface range $PORT - X

	------------------------
	Telnet
	------------------------

		> 	line vty 0 4
		>	login
		>	password $PASSWORD
		>	no sh
		>	exit

		>	créer ensuite un vlan si pas déja fait
		>	interface vlanXX
		>	ip address $IP $NETMASK
		>	no sh

                ou mettre une IP directement sur une des interfaces si l'on utilise pas de VLAN.

	------------------------
	MTU
	------------------------

                >       system mtu jumbo XXX    #régler le mtu au seuil max


~~~~~~~~~~~~~~~~~~~~~~~~~~
S W I T C H
~~~~~~~~~~~~~~~~~~~~~~~~~~
	------------------------
	ARP
	------------------------

		Afficher la table arp:
		> sh arp

		Effacer la table arp:
		> clear arp-cache

	------------------------
	CAM
	------------------------

		Afficher la cam:
		> show mac address-table

		Vider la cam:
		> clear mac address-table dynamic

	------------------------
	VLAN
	------------------------

		>	vlan X
		>	name bidule

		>	interface f0/0/1
		>	switchport mode access
		>	switchport access <$VLAN>
		>	no sh


	------------------------
	TRUNK
	------------------------

		>	interface Gi1/0/1
		>	switchport mode trunk			#passe l'interface en mode trunk
		>	switchport trunk native vlan X		#permet de mettre un vlan par défaut pour le flux non tagué
		>	no sh

	------------------------
	Interface d'admin
	------------------------

        Note : On peut créer une interface d'administration en assigant une IP pour un vlan donné
        ou directement configurer une IP sur une interface.
        
        Exemple avec un VLAN :

            #Configuration des accès :

                Note : soit over ssh, soit over telnet ... (Exemple avec telnet) :

                > 	line vty 0 4
                >	login
                >	password $monPASSWD
                >	exit

                #Mot de passe enable (souvent requit par défaut)

                >   enable password $monPASSWD

            #Création du vlan :

                >	vlan X
                > 	name bidule
                >   exit
        
            #Assignation d'une IP au vlan :

                > 	interface vlan X
                > 	ip address X.X.X.X Y.Y.Y.Y   (Ip permettant de se connécter sur l'équipement)
                > 	no sh
                >   exit

            #Assignation d'un vlan à un port :

                > 	interface f0/X...
                > 	switchport mode access
                > 	switchport access vlan X
                >   exit

            #Conf de la gateway (facultatif en fonction de son environnement)

                >   ip default-gateway X.X.X.X


	------------------------
	SPAN
	------------------------

		> conf t
		> monitor session X source interface Z  [, ... rx]  : choix des interfaces sources (Avec vhoix de monitorer le traffic reçu et transmis ...)
		> monitor session X destination interface W [options ...] : choix des interfaces de destination

		Note: le nombre de session peut être limité (2 basiquement)
		Note2 : Le flux est détagué en destination par défaut:
                        -Rajouter "encapsulation replicate" sur la destination pour garder le tag d'origine.

		Il est possible de filtrer les vlan à voir sur une interface trunké:
		> monitor session X filter vlan Y

	------------------------
	SNMP
	------------------------

                http://www.cisco.com/en/US/docs/ios/internetwrk_solutions_guides/splob/guides/dial/dial_nms/snmpios.html

                todo:

                :>      snmp-server trap-source $interface

	------------------------
	Stack
	------------------------

        http://www.cisco.com/c/en/us/products/collateral/switches/catalyst-2960-x-series-switches/white_paper_c11-728327.html

        Le stack se monte normalement automatiquement en fonction du branchement réalisé.
        Par exemple si on ne branche que deux switchs entre eux, sur leur ports respectifs, 

        Celui-ci actera comme un switch mirroré. Si l'un tombe en panne, le deuxième prendra le relais.

        On peut voir l'election du master se faire au démarrage par exemple.

        Pour afficher les infos du stack :

            >#show switch
            ou
            >#show stack

        Sur un stack de plus de deux switchs, on va pouvoir configurer leur niveau de priorité.
        > TODO

	------------------------
	ACL
	------------------------
        http://www.cisco.com/c/en/us/td/docs/switches/lan/catalyst2960/software/release/12-2_55_se/configuration/guide/scg_2960/swacl.html#wp1285529

        Une ACL va nous permettre de filtrer le traffic entrant ou sortant de notre switch.

        Il existe plusieurs type d'ACL :

            - la standard           : contrôle de l'IP source (avec application de masques) [peu gourmande en ressource]
            - l'étendue             : contrôles de l'IP source et dest, des ports, le type de flux et la gestion des priorité. (avec application de masques)
            - l'étendue nommée      : idem que précedement mais avec un nom sur cette ACL.

        Attention au masque, il fonctionne de la même manière qu'un masque IP mais à l'inverse. (0 = validation de tous les bits)

        Voici un exemple d'ACL étendue nommée :

            #Définition de l'ACL : [ACTION PROTOCOL SOURCE WILDCARD_SRC DEST WILDCARD_DST]

                >   ip access-list extended ACLfooname
                >   permit ip 10.1.0.0 0.0.255.255 10.81.0.0 0.0.0.255    
                >   permit ip 10.5.0.0 0.0.255.255 10.85.0.0 0.0.0.255
                >   exit

            #Application d'une ACL sur une interface

                >   interface Gi1/1/1
                >   ip access-group ACLfooname in|out   #(out n'est supporté que par les interfaces vlan)
                >   end

	------------------------
	SSH (avec clé)
	------------------------

        Pour faire fonctionner le server ssh sur un switch il faut au moins générer une paire de clé rsa sur le switch :

            > crypto key generate rsa exportable general-keys label myrsakey

            [choisir une longueur de 24 bits]

        On créer ensuite un utilisateur (obligatoire apparament) :

            > username myfoouser privilege 15 password mypwd
            
        Une fois fait il faudra faire en sorte que tous les mots de passe soient chiffrés :

            > service encryption-password

        Enfin on ajoute la clé public avec laquel on shouaite s'authentifier (bien copier l'intégralité de la clé avec toutes les infos dedans)
        (utiliser le même user que précedement)

            > ip ssh pubkey-chain
                username myfoouser
                    key-string
                        CLE A COPIER ENTIEREMENT ET SUR PLUSIEUR LIGNES (254 caractères au max)
                      exit
            > end

        On peut peaufiner la configuration du serveur :

            > ip ssh time-out 60
            > ip ssh authentication-retries 4
            > ip ssh version 2
            > ip ssh pubkey-chain

        Et enfin activer la connexion ssh :

            > line vty 0 10
            > login local
            > transport input ssh

        Vérifications :

            > show ip ssh
            > show ssh

	------------------------
	Ether CHANNEL
	------------------------

        TODO :

            > interface Port-channel
                ..

            > interface XX
                group channel ...

~~~~~~~~~~~~~~~~~~~~~~~~~~
R O U T E R
~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------
	SOUS-INTERFACE
	------------------------

                /!\ on utilise bien une sous interface f0/0.X

		>	interface f0/0.X
		>	encapsulation dot1q <$VLAN>
		>	ip address <$IP> <$MASK>
		>	no sh

	------------------------
	Activer le routage
	------------------------

		> 	ip routing
		>	ip classless

	------------------------
	SSH
	------------------------

		>	hostname $HOSTNAME
		>	ip domain-name $DOMAIN
		> 	crypto key zeroize RSA
		>	crypto key generate RSA general-keys modulus 1024
		>	username $USERNAME secret $PASSWORD
		>	aaa new-model
		>	line vty 0 4
		>	transport input ssh
		>	exit

	------------------------
	Relais DHCP
	------------------------

		>	interface $INTERFACE
		>	ip helper-interface $IP_SERVER_DHCP
		>	exit
		>	service dhcp

		(à faire sur chaque sous interface pour un routeur)
	
	------------------------
	NAT
	------------------------

		Il faut au préalable définir les interfaces en outside ou inside:

		> 	interface $INTERFACE
		>	ip nat inside|outside

			
		______________
		static:

		>	ip nat inside source static @IP_INSIDE @IP_OUTSIDE

			Note: la translation se fera dans les deux sens.

		Pour affiner ses règles de NAT, il est possible d'utiliser des ACLs:

		Exemple: On veut autoriser uniquement les IP local qui ne sont pas à destination d'aurte Ip locales à translater:

		> 	access-list 100 deny   ip 10.0.0.0 0.255.255.255 10.0.0.0 0.255.255.255
		> 	access-list 100 permit ip 10.0.0.0 0.255.255.255 any
		>	ip nat inside source list 100 interface fa0/1 overload


~~~~~~~~~~~~~~~~~~~~~~~~~~
A S A
~~~~~~~~~~~~~~~~~~~~~~~~~~
