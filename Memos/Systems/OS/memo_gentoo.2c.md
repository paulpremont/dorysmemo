==============================================================================================
				G E N T O O
==============================================================================================

Vous trouverez ici un mémo sur l'installation et la gestion du système gentoo.
Pour les commandes plus globale au système linux en général, ce référer au mémo_linux

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
LINKS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	http://www.gentoo.org/doc/fr/handbook/handbook-x86.xml?full=1   (pour archi 32 bit)
	http://www.gentoo.org/doc/fr/handbook/handbook-amd64.xml?full=1 (pour archi 64 bit)
        http://www.gentoo.org/doc/en/handbook/handbook-amd64.xml?full=1 (souvent plus à jour)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PREPARATION DU LIVE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	---------------------------------
	Les types d'installation	
	---------------------------------

                -minimal (livecd) : Demande une connexion internet pour le téléchargement des paquets.

                -liveDVD : Ce DVD est mis à jour tous les 6 mois et contient bon nombre de paquets préinstallé.

                -stage3 : cette archive contient l'environnement minimal de Gentoo. (En gros c'est l'image du système Gentoo avec /dev, /bin ...).

		__________________
                Téléchargement:

                        Pour la suite j'ai choisi la version minimal, depuis laquelle on téléchargera notre stage3 pour la configurer avant de booter dessus.

                        Ceux-ci sont diponibles sur le site officiel de gentoo:

                        --> http://www.gentoo.org/main/en/where.xml
                        ou
                        --> http://www.gentoo.org/main/en/mirrors2.xml

                       Dans : releases/amd64/autobuilds/current-iso

                       ex: "install-amd64-minimal-20140116.iso"

		__________________
                Vérifications:

                        Télécharger en plus le .DIGESTS* et le .CONTENTS

                        sha512sum -c install-amd64-minimal-20140116.iso.DIGESTS 
                        sha512sum -c install-amd64-minimal-20140116.iso.DIGESTS.asc

                        Note: il va tester tout les hash présent dans le fichier DIGESTS, (Donc normal si il y a des failed. Etant donné qu'on test uniquement le hash SHA512)

                        Vérification de l'intégrité:

                        gpg --keyserver subkeys.pgp.net --recv-keys 96D8BF6D 2D182910 17072058
                        gpg --verify install-amd64-minimal-20140116.iso.DIGESTS.asc

		Il ne vous reste plus qu'à le graver et enjoyer.

	---------------------------------
	Boot du CD d'installation
	---------------------------------
		__________________
                Les types de noyau/kernel disponible (via F1) 

                        gentoo 		: noyau X.X --> support des multiprocesseurs. (par défaut)
                        gentoo-nofb 	: idem mais sans le support framebuffer 
                                (le frame buffer permet de bénéficier d'une couche graphique en console de façon indépendante du métèriel).
                        memtest86 : Pour les tests de mémoire.

		__________________
                Les options d'amorçage de l'iso (via F2)

                        Pour lister les options disponibles il faut appuyer sur F2 au démarrage.
                        Ensuite on peut les parcourir avec les touches F3 - F7

                        Si l'on souhaite ajouter des options il faut procéder ainsi:
                                > NOM_NOYAU OPTIONS

                                exemple:

                                > gentoo acpi=off doapm ...

                                Note: Les option "no" sont d'abord lues (Attention donc à l'ordre)

                                Ces options permettrons de lancer l'iso dans un certain environnement.
                                (Vous pouvez laissez tout par défaut, les options habituels sont déja selectionnées)

                                Exemple: dhcp / keymap ...

                                Si besoin, pour plus de détails sur les options:
                        
                                --> http://www.gentoo.org/doc/fr/handbook/handbook-amd64.xml?full=1#book_part1_chap2

                                Les options extraites du site officiel:

                                        Options concernant le matériel :
                                        `````````````````

                                        acpi=on
                                                Charge le support de l'ACPI et démarre le démon acpid. Cette option n'est pas requise par l'Hyperthreading.
                                        acpi=off
                                                Désactive complètement l'ACPI. Cela peut être utile sur les anciens modèles ou bien pour utiliser l'APM à la place. Cela désactivera l'Hyperthreading.
                                        console=X
                                                Configure un accès par câble série. Le premier argument est le nom du périphérique, typiquement ttyS0 sur x86, suivi d'options de connexion, séparées par des virgules. Le défaut est 9600,8,n,1.
                                        dmraid=X
                                                Permet de passer des options au sous-système device-mapper RAID. Les options doivent être entourées d'apostrophes.
                                        doapm
                                                Charge le pilote APM. Vous devez aussi spécifier acpi=off.
                                        dopcmcia
                                                Charge le support des matériels PCMCIA et Cardbus et démarre le cardmgr. Utile uniquement pour amorcer un système sur un périphérique PCMCIA/Cardbus.
                                        doscsi
                                                Charge le support matériel de la plupart des contrôleurs SCSI. Ce support est également requis pour démarrer sur un périphérique USB puisqu'ils utilisent le sous-système SCSI.
                                        sda=stroke
                                                Vous permet de partitionner la totalité du disque même si votre BIOS n'est pas capable de gérer les disques larges. Cette option n'est requise que si vous possédez un vieux BIOS. Remplacez sda par le périphérique qui a besoin de cette option.
                                        ide=nodma
                                                Force la désactivation du DMA dans le noyau. C'est requis par certains chipsets IDE et par quelques lecteurs de CD-ROM. Si votre système a du mal à lire votre CD-ROM, essayez cette option. Cela désactive également les réglages hdparm au démarrage.
                                        noapic
                                                Désactive l'APIC, présent sur les cartes mères récentes. L'APIC peut parfois poser problème avec les cartes plus anciennes.
                                        nodetect
                                                Désactive toutes les détections automatiques lancées au démarrage, y compris les détections du matériel et la configuration réseau par DHCP. Utile en cas de problème avec un CD ou un pilote.
                                        nodhcp
                                                Désactive la configuration DHCP sur les cartes réseaux qui ont été détectées. Utile lorsque votre réseau n'a pas de serveur DHCP.
                                        nodmraid
                                                Désactive le support du device-mapper RAID.
                                        nofirewire
                                                Désactive le chargement des modules Firewire.
                                        nogpm
                                                Désactive le support de la souris en console via GPM.
                                        nohotplug
                                                Désactive le chargement des services hotplug et coldplug au démarrage.
                                        nokeymap
                                                Désactive la sélection du clavier au démarrage.
                                        nolapic
                                                Désactive l'APIC Local pour les noyaux monoprocesseurs.
                                        nosata
                                                Désactive le chargement des modules Serial ATA. Utile si vous avez des problèmes avec le sous-système SATA.
                                        nosmp
                                                Désactive le SMP (multiprocesseurs).
                                        nosound
                                                Désactive le support du son et le réglage du volume sonore.
                                        nousb
                                                Désactive le chargement automatique des modules USB.
                                        slowusb
                                                Ajoute des pauses supplémentaires lors de l'amorçage du système pour les périphériques USB lents (comme le BladeCenter IBM).

                                        Gestion des volumes :
                                        `````````````````

                                        dolvm
                                                Active le support de Logical Volume Management de Linux.

                                        Autres options :
                                        `````````````````

                                        debug
                                                Ajoute du code pour déboguer. Attention, très verbeux.
                                        docache
                                                Copie entièrement le système du CD en RAM, vous permettant ainsi de démonter le CD-ROM pour en monter un autre. Cette option nécessite suffisamment d'espace mémoire disponible.
                                        doload=X
                                                Demande au système initrd de charger tous les modules listés ainsi que leurs dépendances. Remplacez X par les noms des modules séparés par une virgule.
                                        dosshd
                                                Démarre le service sshd.
                                        passwd=foo
                                                Permet de définir le mot de passe root du système.
                                        noload=X
                                                Empêche l'initrd de charger les modules listés (séparés par des virgules) lors du démarrage.
                                        nonfs
                                                Désactive le démarrage des services portmap et nfsmount.
                                        nox
                                                Empêche un LiveCD disposant d'un serveur X de démarrer celui-ci.
                                        scandelay
                                                Demande au CD de faire des pauses de 10 secondes lors de certains étapes du démarrage afin que les périphériques puissent démarrer.
                                        scandelay=X
                                                Définit le délai en question.

		__________________
                Note sur le cd d'installation

                        Par défaut le live cd tente de charger tout les modules du noyau nécessaire pour supporter le matèriel.
                        Si toutefois vous avez des problèmes de se coté;
                        Il faudra les ajouter à la main:

                        > modprobe MONMODULE

                        exemple donné par le site pour le support de certaines carte graphique:

                        > modprobe 8139too

		__________________
                Changer le keymap:

                        Passer en mode verbeux pendant l'installation : Alt+F1
                        Et enfin choisir sa langue

	---------------------------------
	Connexion à internet
	---------------------------------

		Pour la suite vous aurez besoin d'un accés au net (pour ceux qui on choisi l'iso minimal surtout) ou d'un autre PC qui dispose du net pour télécharger les sources ... 

		Si vous n'avez pas eu d'accès au réseau automatiquement via dhcp, voici comment résoudre le problème (Si toutefois votre carte est supportée).

		__________________
		ACCES AU RESEAU
			
                        Automatiquement
                        `````````````````
                                > net-setup INTERFACE #Mettez le nom de votre interface ;)
				#Le reste est inreractif.

                        Semi automatique
                        `````````````````
                                > ifconfig #Check de la config de son interface
                                > ls /sys/class/net #voir si ça concorde bien
                                > dhcpcd MON_INTERFACE

                                Note: Pour ma part j'ai eu un petit problème en passant par mon switch (l'état du lien ne voulant pas passer à RUNNING). En me connectant directement sur mon Routeur, le problème ne se manifeste pas. A voir pourquoi (Problème de négo ... ?!)

                        Manuellement
                        `````````````````

                                Si votre carte n'est pas listée dans ifconfig, il faudra charger le pilote:

                                Voir si le materiel est détécté et trouver un nom de driver

                                        lspci |grep 'Ethernet'

                                Chercher le votre dans:

                                        /lib/modules/$(uname -r)/kernel/drivers/net/...

                                        exemple:

                                                find /lib/modules |grep -iE '($DRIVER|realtek|...)''

                                Puis activez le:

                                        > modprobe MON_PILOTE #(sans le .ko)

                                Puis vérifiez si votre interface est présente dans :

                                        > ls /sys/class/net
                                        et
                                        > ifconfig

                                Enfin configurez vos paramètres IP:

                                        > dhcpcd MON_INTERFACE #pour avoir une Ip automatiquement auprès de votre serveur DHCP

                                        ou manuellement:

                                        > ifconfig $MON_INTERFACE 192.168.0.X/24 up
                                        > route add default gw 192.168.0.1 #par exemple

                                        et enfin le dns:

                                        > vi /etc/resolv.conf

                                Testez ensuite votre connectivité avec des pings.

                                Si toujours rien vous pouvez pleurer et chercher un pilote sur le net ou faire le votre ...

                                Maitnenant vous pouvez faire votre conf avec ifconfig ou via DHCP:


                        Wireless
                        `````````````````
                                iwconfig : afficher la configuration et les interfaces courantes

                                        INTERFACE essid NomSSID : connecter l'interface sur un AP
                                        INTERFACE key MaClé : configurer la clé WEP (hexa)
                                        INTERFACE key s:MAClé : configurer la clé WEP (ASCII)

                                
                                WPA : Il faut ici installer le package 'wpa_supplicant' ou une autre méthode en mode graphique type network manager (horrible).

                                        Le plus simple est de configurer le wifi en fin d'installation.
                                        Il vaut donc mieux se brancher en câble dans un premier temps.

		_________________
		ACCES A LA DOC EN LIGNE:

			Si vous n'avez pas le choix, il faudra passer par links:

			> links #Appuyez sur g pour lancer votre requête)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PREPARATION DU NOUVEAU SYSTEME
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	---------------------------------
	Partitionnement
	---------------------------------
		_________________
                Définir un plan de partitionnement:

                Vous pouvez utiliser parted ou fdisk pour partitioner vos disques.

                En gros il faut au moins deux partitions classiques (swap et systèmes)

                Il est plus courant, du moins d'après le manuel de faire un plan de partionnement en 4 :

                        Une partition pour le bootloader (GRUB) pour les données additionneles qui ne serait pas dans le MBR.
                        Une partition pour le boot (comprenant le noyau) du système.
                        Une partition pour le swap (extension de la mémoire vive)
                        et une pour le reste du système (root)

                Résumons:

                        Le bootloader: =~ 2M (Dans le cas ou GRUB à besoin de mettre des données additionnels, il est recommandé d'en créer une dans tout les cas)
                        La partition /boot : =~ 128 M
                        La partition de swap : =~ à 1 G (selon vos ressources)
                        La partition root : =~ à ce que vous voulez. 
                        
                        Vous pouvez bien entendu adapter ce schéma à votre convenance et en fonction de votre espace.

                        Note: je rappel que nous somme limité à 4 partition primaires (les partitions primaires étant écrite directement sur le MBR (Master Boot Record) faisant 512 bytes).

                        Comme Gentoo n'est pas le seul système installé sur ma machine,
                        J'ai crée une parition étendue segmentée de plusieurs partitions logiques.

                                Ce qui donnera sur ma partition étendu , 4 partitions logiques:
                                       bootloader, boot,swap et root

                                       (Je vous conseille de rajouter une partition home)

                       Note: La partition étendu prendra aussi une entrée dans le MBR comme une parition primaire. 

                       Voir le mémo sur parted et sur fdisk.
                       Ne pas oublier de formater avec mkfs:

                                Exemple:
                                        pour la partition de boot : mkfs.ext2 /dev/sdaX
                                        pour la partition root : mkfs.ext4 /dev/sdaX
                                        pour la partition de swap: mkswap /dev/sdaX ; swapon /dev/sdaX
		_________________
                Monter ses partitions:

                        exemple: (à adapter selon votre partionnement bien sûr) 

                                > mount /dev/sda3 /mnt/gentoo #root, à faire en premier
                                > mkdir /mnt/gentoo/boot # On créer le dossier de boot
                                > mount /dev/sda1 /mnt/gentoo/boot #on monte la partition de boot

	---------------------------------
	Régler l'heure
	---------------------------------

                Avant tout, il faut vérifier l'heure du système pour éviter de futur problèmes:
                > date

                Si ce n'est pas correct, la régler: date MMDDhhmmYYYY

	---------------------------------
	L'archive STAGE
	---------------------------------
		Cette archive représente globalement votre futur système avec tout les fichiers nécessaire pour construire votre arborescence. C'est donc les fondations de Gentoo ;).

		_________________
                Vérifier son type d'architecture:

                        > uname -m

		_________________
                Téléchargement de l'archive:


                        > cd /mnt/gentoo
                        
                        Puis trouvez votre archive grâce à ce lien: 

                        > links

                                http://www.gentoo.org/main/en/mirrors2.xml
                                ou
                                http://www.gentoo.org/main/en/mirrors.xml

                                        Par exemple dans:
                                                releases/amd64/autobuilds/
                                                ou
                                                releases/amd64/current-stage3/

                                        Prendre ensuite la dernière version avec les fichier d'intégrité

                        Récupérez la (wget ou links/lynx ...)

                                on devrait avoir quelque chose du type:

                                        stage3-amd64-20140116.tar.bz2
                                        //.CONTENTS.bz2
                                        //.DIGESTS.bz2
                                        //.DIGESTS.asc
		_________________
                Vérifications:

                       > openssl dgst -r -sha512 stage3-amd64-<release>.tar.bz2
                       > openssl dgst -r -whirlpool stage3-amd64-<release>.tar.bz2

                       > cat stage3-amd64-<release>.tar.bz2.DIGESTS.bz2

                       et comparer

                       Puis on vérifie que rien à été changé:

                       > gpg --keyserver subkeys.pgp.net --recv-keys 96D8BF6D 2D182910 17072058 (si ça n'a pas été fait au début)
                       > gpg --verify stage3-amd64-<release>.tar.bz2.DIGESTS.asc


		_________________
                Installation:

                        > tar xvjpf stage3-*.tar.bz2

	---------------------------------
	Portage
	---------------------------------
                Portage s'utilise courament avec la commande emerge
		_________________
                Configuration des options de compilations:

                        Ces options sont relatives à Portage, le gestionnaire de paquet et le coeur de Gentoo.
                        Elles définissent la manière dont Portage se comporte pour compiler par défaut.
                        Elles peuvent être définient via 'export' ou directement dans le fichier de conf de portage:

                        > nano /mnt/gentoo/etc/portage/make.conf

                                #On y trouve plusieurs variables comme:

                                CFLAGS="-march=native -O2 -pipe" 	#pour le C
                                CXXFLGAS="${CFLAGS}			#pour le C++
                                MAKEOPTS="-j4"				#Le nombre de compilation simultanée
                                CHOST=...				#Plateforme de compilation
                                USE=...					#Relatif au profil (voir plus bas)
                                GENTOO_MIRRORS=...			#Où portage va chercher ses paquets
                                SYNC=...				#idem via rsync

                        Quelque mini infos (voir le site off pour plus de détails !)

                                Pour CFLAGS et CXXFLAGS:

                                        Il permettent d'optimiser la config pour le compilateur gcc (C et C++)
                                        Le mieux étant encore de faire du cas par cas lors de l'install de programmes.

                                        march : Le type d'architecture sur lequel on veut effectuer la compilation.
                                        native : s'applique à l'architecture du pc actuel.
                                        -O : définie le type d'optimisation
                                                0 : pas d'optimisation
                                                1 à 3 : optimisation de la vitesse
                                        -pipe : Utilise les pipes au lieu de fichiers temporaires pour la communication entre chaque étape de compilation. (Plus gourmand en mémoire).

                                        voir --> http://www.gentoo.org/doc/fr/gcc-optimization.xml
                                        voir --> http://gcc.gnu.org/onlinedocs/

                                Pour le MAKEOPTS
                                        -j4 : Pour défnir le nombre d'instance parallèle lancée pour la compilation.
                                                On se calle sur le nombre de processeur généralement.

                                                > cat /proc/cpuinfo
		_________________
                Mirrors:

			concerne la variable GENTOO_MIRRORS:
				Vous pouvez mettre à jour vos mirroirs avec les commandes suivantes:

				>:      mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf

			Pour SYNC:	
				Idem:
				
				>:      mirrorselect -i -r -o >> /mnt/gentoo/etc/portage/make.conf

	---------------------------------
	CHROOT - Nouvel environnement	
	---------------------------------

		Nous allons définir un nouvel environnement pour ensuite se chrooter dedans et paramétrer son futur système:

		> cp -L /etc/resolv.conf /mnt/gentoo/etc	#Copie des infos relatives aux serveurs DNS

                Il faut rendre disponibles certain fichier pour que le nouvel environnement fonctionne correctement:

		> mount -t proc proc /mnt/gentoo/proc		#Montage de la partition /proc de l'hôte courant
		> mount --rbind /sys /mnt/gentoo/sys		#idem pour sys
		> mount --rbind /dev /mnt/gentoo/dev		#idem pour dev

		#Puis on se chroot

		> chroot /mnt/gentoo /bin/bash			#On se chroot et on lance un nouveau shell
		> env-update					#On met à jour notre environnement
		> source /etc/profile				#On appique notre profile
		> export PS1="(chroot) $PS1"			#On change notre prompt pour ne pas se tromper

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration et installation du nouveau système
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        > emerge vim : pour ceux qui en ont marre de nano !

	---------------------------------
	L'ARBRE de PORTAGE (snapshot)
	---------------------------------

                Il faut installer un snapshot de l'arbre de Portage (traduit instantané de portage ).

                Ce snapshot contient une collection de fichier, des méta-données disant à portage quels soft il peut installer et quels profils sont disponibles.

		> mkdir /usr/portage				#Point d'extraction pour les paquets d'installation (relatif à POSTDIR du make.conf)
		> emerge-webrsync				#Télécharger le snapshot d'un coup (utile pour la première éxécution)
		> emerge --sync --quiet 			#Mettre à jour l'arbre portage (le quiet c'est pour ceux qui ont un terminal un peu lent)
                        note: comme je n'avais rien récupéré avec la commande emerge-webrsync, le --sync peut être du coup utile même à la première exécution (mais plus lent)
		
		Si jamais Portage vous recommande de le mettre à jour:
		> emerge --oneshot portage

		Lors de la mise à jour de votre arbre,
		des notes sur les nouveaux changements important peuvent être téléchargées.

		Pour les lires:

		> eselect news list	#Afficher les notes
		> eselect new read	#Lire les notes

		_________________
		Le PROFIL:

			Le profil permet de determiner un environnement pour portage et influ notament sur les variable CFLAGS, USE ... donnant les options par défaut de compilation.
		
			> eselect profile list 		#Afficher les pofils dispo par défaut
			> eselect profile set N		#Choisir le profil N


			Les fichiers appartenant au profil sont contenus dans:
				/usr/portage/profiles/default/linux/$PROCESSOR_TYPE/$VERSION_GENTOO

			Plus généralement ;) :
				/usr/portage/profiles

                        On y trouve plein de fichiers de types package.use, use.mask qui définissent un ensemble de variable/configuration pour chaque profil.

                        Ils peuvent renvoyer aux configurations contenu dans:
                                /usr/portage/profiles/targets/...

                        Pour le moment j'ai laissé le profil par défaut:
                                default/linux/amd64/13.0
		_________________
		La variable USE:

                        C'est une des variables les plus importantes de Gentoo.

			Elle permet de définir pour un paquet, les options de compilations.
                        Comme le support gtk, SSL ... par exemple.

			Il existe plusieurs variable USE définient dans les fichiers make.defaults du profile selectionné. 
			La variable USE prend toutes les valeurs définient dans l'arborescence du profile de tout les fichiers make.defaults

			Pour enlever un paramètre, il faut rajouter un "-" devant l'option.

                        Les options par défaut de USE sont contenu dans:
                                make.defaults

                        le profil actif est normalement un lien symbolique dans le dossier de conf de portage:
                                /etc/portage/make.profile

                        Note:
                                Ne rien changer dans l'arbre de portage, les modifications seronts écrasée lors des mises à jour de l'arbre.

			Afficher les valeurs de USE disponibles et leurs significations:
				> less /usr/portage/profiles/use.desc

			Afficher la valeur de USE du profile courant:
				> emerge --info

			Changer la variable USE:
				> nano -w /etc/portage/make.conf

			PLus d'info:
				http://www.gentoo.org/doc/fr/handbook/handbook-amd64.xml?full=1#book_part2_chap2
                                http://www.gentoo.org/doc/en/handbook/handbook-amd64.xml?full=1#book_part2_chap2
	---------------------------------
	Système d'initialisation
	---------------------------------

                Par défaut gentoo utilise OpenRC.
                Il est possible de le changer pour systemd par exemple

                Systemd : todo (utile pour gnome 3.8)

                La suite concerne essentiellement OpenRC

	---------------------------------
	Heure Sytème
	---------------------------------

                https://wiki.gentoo.org/wiki/Localization/HOWTO
                http://www.tldp.org/pub/Linux/docs/HOWTO/translations/fr/html-1page/TimePrecision-HOWTO.html#why

                L'heure dépend du fuseau horaire et de l'horloge physique (défini en locale ou UTC)
                L'heure du système devient indépendant de celle du BIOS après l(avoir chargée.

		_________________
                Le Fuseau hoaire

                       OpenRC
                       ``````````````
                                Mettez votre gentoo sur le bon fuseau:

                                cp /usr/share/zoneinfo/$ZONE/$CITY /etc/localtime

                                echo 'Europe/Paris' > /etc/timezone

                                emerge --config sys-libs/timezone-data

                                Faire un date pour vérifier.

                                Pour la faire niveau utilisateur, il faut régler la variable TZ dans le .bash_profile:
                                        TZ="Europe/Paris".

                       systemd:
                       ``````````````
                                Voir timedatectl : todo

		_________________
                l'horloge physique

                        Elle sert de temps de base pour le système.

                       Manipuler l'heure de l'horloge physique:
                       ``````````````
                                hwclock --show : afficher l'heure materielle


                       Config de l'horloge physique:
                       ``````````````

                                vim /etc/conf.d/hwclock

                                        clock="local"
                                        ou
                                        clock="UTC"

                                        (Choisir en fonction de son horloge physique)

                                        Si vous n'avez que du Linux, UTC peut être le bon choix.
                                        Sinon définir en local. (Windows intéragissant directement avec l'heure du BIOS ...)


	---------------------------------
	Langue et environnement:
	---------------------------------

                https://wiki.gentoo.org/wiki/Localization/HOWTO
                https://wiki.gentoo.org/wiki/Localization/HOWTO/fr
                https://wiki.gentoo.org/wiki/UTF-8/fr
                http://unicode-table.com/en/

		_________________
                Locale et encodage:

                        Note sur l'encodage des caractères:

                                Ce sont des tables de conversion.
                                Votre ordinateur en a besoin pour retranscrire correctement les caractères en binaire.
                                Elles sont 'presque' toutes compatible ASCII (codé sur 7 bits + 1 bit de parité).
                                Un caractère ASCII fait donc 1 octet.

                                Les autres encodage comme du 8859-1 à 8859-15 utilisent le bit de parité pour y ajouter leurs motifs et laisser à chacun la possibilité d'implanter son langage.

                                C'est là où la norme Unicode est intervenu pour réaliser une table rassemblant toute les langues possibles.
                                Ce Unicode peut être découpé de différente manière.
                                L'UTF-8 (non ASCII) est en fait un mot de 8 bits qui permet déja d'avoir presque tout les caractères nécéssaires.

                       OpenRC
                       ``````````````
                                Afficher les locales:

                                        less /usr/share/locale/locale.alias
                                        less /etc/locale.gen

                                        locale : afficher les variables 'locales'
                                        locale -a : afficher celles qui sont disponibles.

                                Pour les paramétrer, il suffit de décommenter ceux qui nous interesses:
                                        nano /etc/locale.gen

                                Recharger ensuite la liste:
                                        > locale-gen 

                                Appliquer une locale:
                                        > eselect locale list
                                        > eselect locale set X

                                        Puis: env-update && source /etc/profile

                                Manuellement:
                                        nano /etc/env.d/02locale
                                                LANG="fr_FR.iso88591"

                                        On peut ici modifier chaque variables 'locale' 
                                        (voir > locale)

                                Pour chaque utilsiateur.
                                        Les locales peuvent être définit au niveau des utilisateurs:

                                        On mettra donc dans le .bashrc:

                                                export LANG="..."
                                                export LC_COLLATE="..."
                                                
                                Ajouter une locale UTF-8 qui n'existe pas:

                                        Il faut disposer de la librairie glibc

                                                find /usr/lib/ |grep glib

                                        nano /etc/locale.gen
                                                fr_FR.UTF-8 UTF-8

                                        localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
                                        ou
                                        locale-gen

                                        Modification de la variable d'environnement:
                                                LC_CTYPE
                                                        Voir: http://www.gnu.org/software/libc/manual/html_node/Locale-Categories.html#Locale-Categories
                                        ou
                                        LANG (pour le changement de langue)

                                        nano /etc/env.d/02locale
                                        LANG="fr_FR.UTF-8"

                                        Puis on met à jour notre environnement:

                                                en-update && source /etc/profile

                                        Il restera ensuite la conf des applications pour la prise en compte de l'UTF8

                                Plus de compatibilité:
                                        todo
                                        
                       Systemd
                       ``````````````
                                Voir:
                                        localectl list-locales
                                        localectl set-locale LANG="MON_ENCODAGE"
                                        localectl |grep 'System locale'
                       
		_________________
                Clavier:

                        OpenRC
                        ``````````````
                                Voir les agencement disponibles:

                                        /usr/share/keymaps/ARCHITECTURE/KEYBOARD_TYPE/*.map.gz

                                        Le nom de l'agencement est le préfixe de .map.gz

                                        exemple:

                                                /usr/share/keymaps/i386/azerty/fr-latin1.map.gz

                                Ajouter son agencement:

                                        vim /etc/conf.d/keymaps

                                                keymap="MON_AGENCEMENT"

                                                exemple:
                                                        keymap="fr-latin1"

                               Configurer son clavier en live:

                                        loadkeys MON_AGENCEMENT

                                        exemple:
                                                loadkeys fr-latin1
                        systemd
                        ``````````````

                                Voir: 
                                        localectl list-keymaps
                                        localectl set-keymap MY_KEYMAP
                                        localectl |grep "VC Keymap"


	---------------------------------
	KERNEL / NOYAU
	---------------------------------
		_________________
                Les sources:

                        Choisir les sources d'un noyau:
                        ``````````````
                                > emerge -s sources

                                Un petit guide pour le choix de ce noyau:	
                                        http://www.gentoo.org/doc/fr/gentoo-kernel.xml

                        Installation des sources du noyau:
                        ``````````````

                                Une fois votre choix fait, il va faloir installer les sources de votre kernel pour pouvoir ensuite le compiler.

                         (Gentoo met à disposition un noyau avec déja plein de fonctionnnalités: gentoo-sources)
                                > emerge $VOTRE_NOYAU

                                ex:
                                > emerge gentoo-sources  : celui indiqué par la doc pour du AMD64

                                Les source du noyau se trouve maintenant dans /usr/src
                
                                ls -l /usr/src/linux  #Affiche le lien pointant vers les sources du noyau

		_________________
                compilation du noyau:

                        Récupérer des infos sur son materiel:
                        ``````````````

                                > emerge pciutils 	#Installer les tools lspci...

                                Infos via:
                                > lspci  #Dump des infos sur les périphériques
                                > lsmod  #Dump des infos sur les modules du noyau
                                > dmesg  #Affiche les infos depuis le boot du système

                        Compilation manuelle
                        ``````````````
 	
                                > cd /usr/src/linux	#On retourne dans ses sources
                                > make menuconfig	#On lance la config du kernel (ça lance une interface ncurse)
                                
                                [*] : installe en dur dans le noyau

                                        Tout les pilotes nécessaires au démarrage doivent être en "dur" 

                                                Comme par exemple le AHCI, l'EFI, la prise en compte des différents systeme de fichier, les protocoles réseau, la prise en compte des ports USB ...

                                        Veuillez à ce que les FS soient bien pris en compte, que vos controleur de disque sont aussi en dur. 
                                                ex:
                                                
                                                File systems --->
                                                        <*> The Extendede 4 (ext4) filesystem  #Active la prise en charge de l'ext4
                                                
                                                Device Drivers --->
                                                        <*> Serial ATA and Parallel ATA drivers --->
                        <*> AHCI SATA support  #Active le support AHCI pour votre disque SATA 

                                [M] : installe en tant que module

                                        Note: Les modules pourront être rajoutés au noyau sans recompilation grâces aux commandes:

                                        > modprobe
                                        > insmod

                                        
                                Sauvegarder puis quittez.

                                Le fichier .config est crée.
                                
                                Vérifiez:
                                        > less .config

                                Et on compile !
                                        > make && make modules_install

                                On copie le noyau dans /boot (pour booter dessus)
                                        > cp arch/$PROC_TYPE/boot/bzimage /boot/kernel-$VERSION-gentoo

                                        (La version correspond au nom de dossier des source : /usr/src)
				
                        Compilation semi-automatique
                        ``````````````

                                Par contre moins customisé et surement plus lent à compiler car il prendra en compte plus d'options.
                                Note: Beaucoup d'option à décocher dans ce cas, à la limite bien pour une première fois ...
                                
                                > emerge genkernel 	#Install genkernel (notre outil de compilation)
                                > genkernel --menuconfig all

                                --lvm : ajouter le support du lvm

                                > ls /boot/kernel* /boot/initramfs*

		_________________
		initramfs

                        https://wiki.gentoo.org/wiki/Initramfs/HOWTO/fr


			Dans le cas ou vous utilisez une arborescence plus personalisée avec /var, /usr sur des partitions différentes, il faut que ces derniers se montent avec la partition de boot, il faudra alors créer un disque virtuel initramfs:

			> emerge genkernel
			> genkernel --install initramfs
			> # genkernel --lvm --mdadm --install initramfs Si besoin d'un support pour raid ou lvm 
                        > ls /boot/initramfs

		_________________
		modules

                        Il est souhaitable de configurer les modules qui sertont automatiquement chargé lors du démarrage.

                        Lister les modules disponibles:

                        find /lib/modules/<kernel version>/ -type f -iname '*.o' -or -iname '*.ko' | less

                        exemple:

                        find /lib/modules/3.10.25-gentoo/ -type f -iname '*.o' -or -iname '*.ko' | less

                        Editer/ajouter des modules:

                        nano /etc/conf.d/modules


	---------------------------------
	Configuratin du système
	---------------------------------
		_________________
                fstab

                        Elle contient tout les points de montage chargé au démarrage:

                        Il faut la configurer en fonction de son plan de partition défini au début
                        (un petit blkid pour se rafraichir la mémoire)

                        exemple:

                                /dev/sda6       /boot   ext2    noauto,noatime  0 2
                                /dev/sda8       /       ext4    noatime         0 1
                                /dev/sda7       none    swap    sw              0 0
                                /dev/sda2       /home   ext4    defaults,usrquota,grpquota  1 2
                                /dev/cdrom      /mnt/cdrom   auto   noauto,ro   0 0
                                /dev/fd0        /mnt/floppy  auto   noauto      0 0

		_________________
                network


                       Nom de machine:
                       ``````````````
                                /etc/conf.d/hostname

                                        hostname="HOSTNAME"

                       Nom de domaine:
                       ``````````````
                                /etc/conf.d/net

                                        dns_domain_lo="DOMAIN_NAME"
                                        nis_domain_lo="NIS_DOMAIN"

                                Voir aussi du coté de :

                                        /usr/share/doc/netifrc-*/net.example.bz2

                                        utiliser bzless pour le lire

                                        emerge openresolv : pour l'aide sur la configuration DNS/NIS


                       Message :
                       ``````````````
                                Si on n'utilise pas de nom de domaine, autiant l'enlever du message d'acceuil:

                                /etc/issue

                                voir man agetty pour les signification des raccourcie

                                        enlever \O

                       Réseau :
                       ``````````````

                                Configuration IP:
                                        dans: /etc/conf.d/net

                                                manuellement:
                                                        config_INTERFACE="@IP netmask MASK brd BROADCAST"
                                                        routes_INTERFACE"default via @IP_ROUTER"

                                                dhcp:
                                                        config_INTERFACE="dhcp"

                                                exemple:

                                                        config_eth0="192.168.0.5 255.255.255.0 brd 192.168.0.255"
                                                        routes_eth0="default via 192.168.0.1"

                                                        ou

                                                        config_eth0="dhcp"

                                                Voir les options disponibles:
                                                        bzless /usr/share/doc/netifrc-*/net.example.bz2

                                Démarrage automatique:

                                        cd /etc/init.d                  
                                        ln -s net.lo net.INTERFACE_NAME
                                        rc-update add net.INTERFACE_NAME default       #ajout au runlevel par défaut

                                        pour le supprimer au démarrage:
                                        rm /etc/init.d/net.INTERFACE_NAME
                                        rc-update del net.INTERFACE_NAME default

                                        rc-config list : pour vérifier

                                Résolution de nom:
                                        dans: /etc/hosts

                                                Rajouter son hostname au niveau des loop locales
                                                Et tout les hôtes qui ne seront pas résolu par le serveur DNS.

                                Pour les cartes PCMCIA (Personal Computer Memory Card International Association)
                                        (Les cartes d'extensions plates pour les pc portables notament)

                                        emerge pcmciautils
		_________________
                System-basics

                        Mot de passe root:
                       ``````````````
                                passwd

                        Configuration des services (démarrage et extinction)
                       ``````````````
                                vim /etc/rc.conf

		_________________
                System-tools

                        On va définir ici tout les outils qui ne sont pas présent dans le stage3:
                                                
                        Système de log (System logger):
                        ``````````````

                                Parmis c'est systèmes nous avons les plus courant (à ce jour):

                                       -sysklogd : c'est le système traditionel
                                       -syslog-ng : un système avancé
                                       -metalog : hautement configurable

                                       sysklogd et syslog-ng nécessite un méchanisme de rotation de log (pour ne pas surcharger la mémoire) : 
                                       Il faudra donc installer logrotate:
                                                emerge logrotate

                                       Ajout au runlvel par défaut: rc-update add SYSTEM_LOGGER default

                                exemple:
                                        emerge syslog-ng logrotate
                                        rc-update add syslog-ng default

                       Démon cron (Cron Daemon):                 
                        ``````````````
                                Pour l'éxécution des tâches prédéfinis

                                Nous avons au menu le choix entre différent démon:

                                        -bcron
                                        -dcron
                                        -fcron
                                        -vixie-cron
                                        -cronie : utilise des fonction avancée tel que la possibilité d'utiliser pam et SELinux.

                                        dcron et fcron nécessite une commande configuration en plus:
                                                crontab /etc/crontab (à entrer en dernier)

                                        Par défaut: 
                                                emerge cronie
                                                rc-update add cronie default
                                                # crontab /etc/crontab si on a choisi dcron ou fcron

                       Indéxation:                
                        ``````````````
                                Pour rechercher rapidement des fichiers avec locate par exemple:
                                (pasuet: sys-apps/mlocate)

                                emerge mlocate

                        Accès distant
                        ``````````````

                                Pour accéder à sa machine en ssh:

                                rc-update add sshd default

                                Pour les accès sur le port série (utile sur certain serveur):

                                        vim /etc/inittab (et décommenter les lignes SERIAL)

                                                #SERIAL CONSOLES
                                                s0:12345:respawn:/sbin/agetty 9600 ttyS0 vt100
                                                s1:12345:respawn:/sbin/agetty 9600 ttyS1 vt100
                        Outils FS
                        ``````````````

                                Pour vérifier l'intégriter des systèmes de fichier et en créer de nouveau;
                                il faut des outils de FS:
                                        
                                         -e2fsprogs : pour le ext2,3 et4 (déja installé par défaut)
                                         -xfsprogs : pour le XFS
                                         -reiserfsprogs : pour le ReiserFS
                                         -jfsutils : pour le JFS

                        Outils Réseaux
                        ``````````````

                                dhcp client:

                                        emerge dhcpcd

                                ppp :
                                        emerge ppp


	---------------------------------
	CHARGEUR DE DEMARRAGE (Boot loader)
	---------------------------------

                Voir:
                        http://www.gentoo.org/doc/en/handbook/handbook-amd64.xml?full=1#book_part1_chap10
                        http://www.gentoo.org/doc/fr/handbook/handbook-amd64.xml?full=1#book_part1_chap10

                Pour que notre système puisse booter, il faut installer un bootloader qui va charger notre noyau.

                        Pour une architecture type AMD64, nous avons:

                                -GRUB2
                                -LILO
                                -GRUB Legacy
		_________________
                framebuffer (fbdev):

                        http://fr.wikipedia.org/wiki/Framebuffer_Linux
                        http://wiki.gentoo.org/wiki/Uvesafb

                        =~ mémoire d'image;
                        Il permet d'afficher des éléments graphiques en console.

                        Si celui ci est supporté par le noyau (activé par défaut avec genkernel)
                        On peu en bénéficier en ajoutant vga et/ou video au fichier de config du bootloader:

                        Il faut connaitre son périphérique framebuffer
                        uvesafb (le driver framebuffer) à du être utilisé comme pilote VESA (Video Electronics Standards Association)

                        Pour le paramétrer on influ sur la variable video:
                                Les options sont dispo dans:
                                        /usr/src/linux/Documentation/fb/uvesafb.txt

                                ywrap : utilisation de la mémoire comme un tapis roulant
                                mtrr:X : option du registre MTRR (Memory type range register)
                                           Il permet de determiner la manière dont le CPU accèdes aux plages de mémoire en cache.
                                                0 - désactivé
                                                1 - pas de cache
                                                2 - write-back
                                                3 - write-combining
                                                4 - write-through

                                mode : permet de determiner la résolution, le tôt de rafraichissement ...
                                                RESOLUTION-COLOR@REFRESH

                       exemple:

                                video=uvesafb:mtrr:3,ywrap,1024x768-32@85

                       Cette ligne servira dans la conf du bootloader plus tard.

		_________________
		GRUB 2:
                        Choix par défaut

                        http://doc.ubuntu-fr.org/grub2
                        http://fr.openclassrooms.com/informatique/cours/apprenez-a-maitriser-grub/configurez-grub2
                        http://wiki.gentoo.org/wiki/GRUB2
			

			Installation:
                        ``````````````
				> emerge sys-boot/grub

			Configuration
                        ``````````````
                                Il faut installer les fichiers de grub2 sur le disque bootable:
                                par exemple sda:
                                        
                                        > grub2-install /dev/sda 

                                Par défaut, ils vont s'installer dans /boot/grub

                                Grub2 est très automatisé et va tout seul trouver le bon noyau sur lequel booter

                                Génération de la configuration basée sur:
                                        /etc/default/grub 
                                        et
                                        /etc/grub.d

                                        > grub2-mkconfig -o /boot/grub/grub.cfg 

                                        Note:
                                                Le nom du noyau a une importance
                                                Il doit être du type:
                                                        kernel-3.10.25-gentoo-custom


		_________________
		LILO: (pas testé)

                        Encore largement répendu pour certain problème de compatibilité, il dispose de moins de fonctionnalité que GRUB.

			Installation:
                        ``````````````
                                > emerge lilo

			Configuration
                        ``````````````

                                > vim /etc/lilo.conf

                                exemple du manuel gentoo:

                                        boot=/dev/sda             # Install LILO in the MBR
                                        prompt                    # Give the user the chance to select another section
                                        timeout=50                # Wait 5 (five) seconds before booting the default section
                                        default=gentoo            # When the timeout has passed, boot the "gentoo" section

                                        image=/boot/kernel-3.4.9-gentoo
                                          label=gentoo            # Name we give to this section
                                          read-only               # Start with a read-only root. Do not alter!
                                          root=/dev/sda4          # Location of the root filesystem

                                        image=/boot/kernel-3.4.9-gentoo
                                          label=gentoo.rescue     # Name we give to this section
                                          read-only               # Start with a read-only root. Do not alter!
                                          root=/dev/sda4          # Location of the root filesystem
                                          append="init=/bin/bb"   # Launch the Gentoo static rescue shell

                                        # The next two lines are only if you dualboot with a Windows system.
                                        # In this example, Windows is hosted on /dev/sda6.
                                        other=/dev/sda6
                                          label=windows

                                Rajoutez  append="ro" pour les FS JFS

                                Si on a utilisé initramfs:
                                          image=/boot/kernel-3.4.9-gentoo
                                          label=gentoo
                                          read-only
                                          append="real_root=/dev/sda4"
                                          initrd=/boot/initramfs-genkernel-amd64-3.4.9-gentoo

                                pour le framebuffer:
                                        append="video=uvesafb:mtrr,ywrap,1024x768-32@85"

                                pour les disques de grosse taille:
                                        sdX=stroke

                                SCSI devices: 
                                        doscsi

			Appliquer la configuration
                        ``````````````

                                > /sbin/lilo # à faire pour chaque nouveau noyau et modifications

		_________________
		GRUB Legacy (pas testé)

                        http://www.gnu.org/software/grub/grub-faq.html
                        http://www.gnu.org/software/grub/manual/


			Vocabulaire:
                        ``````````````
				Le grub identifie les partition en commenceant à 0.
				Le premier chiffre correspond à la lettre,
				Le deuxième au n° de partition.

				exemple:
					Système		GRUB

					/dev/sda1   =   hd0,0 
					/dev/sdb1   =   hd1,0 
					/dev/sdc2   =   hd2,1 

			Installation:
                        ``````````````

                                > emerge sys-boot/grub:0 (à ne pas utiliser pour le non-multibil)
                
                                pour les profil non-multilib:
                                        > emerge sys-boot/grub-static

			Configuration
                        ``````````````
                                Note: les périphériques sont assignés en fonction de la configuration du BIOS

                                > vim /boot/grub/grub.conf

                                exemple de conf du manuel (Le plan de partitionnement ne prend pas en compte Windows)

                                        # Which listing to boot as default. 0 is the first, 1 the second etc.
                                        default 0
                                        # How many seconds to wait before the default listing is booted.
                                        timeout 30
                                        # Nice, fat splash-image to spice things up :)
                                        # Comment out if you don't have a graphics card installed
                                        splashimage=(hd0,1)/boot/grub/splash.xpm.gz

                                        title Gentoo Linux 3.4.9
                                        # Partition where the kernel image (or operating system) is located
                                        root (hd0,1)
                                        kernel /boot/kernel-3.4.9-gentoo root=/dev/sda4

                                        title Gentoo Linux 3.4.9 (rescue)
                                        # Partition where the kernel image (or operating system) is located
                                        root (hd0,1)
                                        kernel /boot/kernel-3.4.9-gentoo root=/dev/sda4 init=/bin/bb

                                        # The next four lines are only if you dualboot with a Windows system.
                                        # In this case, Windows is hosted on /dev/sda6.
                                        title Windows XP
                                        rootnoverify (hd0,5)
                                        makeactive
                                        chainloader +1
        
                                Pour initramfs:
                                        title Gentoo Linux 3.4.9
                                        root (hd0,1)
                                        kernel /boot/3.4.9 real_root=/dev/sda4
                                        initrd /boot/initramfs-genkernel-amd64-3.4.9-gentoo

			Activation auto
                        ``````````````
                                
                                grep -v rootfs /proc/mounts > /etc/mtab
                                echo "(hd0)     /dev/vda" >> /boot/grub/device.map
                                grub-install --no-floppy /dev/sda

			Activation manuelle
                        ``````````````
                                        grub --no-floppy        
                                        grub> root (hd0,0)    (Indique où se trouve la partition /boot.)
                                        grub> setup (hd0)     (Écrit GRUB dans le MBR.)
                                        grub> quit            (Quitte le shell GRUB.)
                                        
	---------------------------------
	REBOOT
	---------------------------------
                
                Il suffit simplement de quitter le chroot et de démonter toute les partitions proprement.

                exit    #on quitte l'environnement rooté
                cd      #on se place ailleur que dans notre point de montage
                umount -l /mnt/gentoo/dev{/shm,/pts,}
                umount -l /mnt/gentoo{/boot,/proc,/home,}
                reboot

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FINALISATIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	---------------------------------
	TROUBLE
	---------------------------------

                Voir si un topic existe pour votre matos ;)

                        exemple:
                               http://gentoo-en.vfose.ru/wiki/Asus_P52Jc 
                        
                Au premier redémarrage:
                        si l'environnement n'est pas bien définit, il faut le recharger:        
                                soit en rebootant.
                                soit via : env-update && source /etc/profile

                clock skew : changer la conf de l'horloge:
                        /etc/conf.d/hwclock
                                CLOCK="local" par exemple et ajuster l'heure avec hwclock
                
                -Mauvaise date:
                        Revoir l'heure du bios et bien revérifier les fichiers timezones

                -Accent non gérés // clavier mal défini:
                        Un problème d'encodage, voir chapitre langue et environnement

		_________________
                Drivers manquant:

                        Exemples, drivers réseaux:

                        Voir si il y a un souci:
                                dmesg |grep -i net
                        
                        option 1: Revoir son noyau et activer les bon drivers
                                
                                lspci |grep -i net
                                lspci |grep -i wire


                                Pour mon chipset JMicron JMC250 , j'ai du revoir le noyau et rajouter son support:
                                        Device Drivers  --->
                                            [*] Network device support  --->
                                                    [*] Ethernet (1000 Mbit)  --->
                                                                <M> JMicron(R) PCI-Express Gigabit Ethernet support
                                
                                Et celui de ma carte wifi: Atheros AR9285
                                        Device Drivers  --->
                                            [*] Network device support  --->
                                                    Wireless LAN  --->
                                                                <*> Atheros Wireless Cards  --->
                                                                                <*> Atheros 802.11n wireless cards support
                                                                                                [*]   Atheros ath9k rate control


                                Activation/désactivation de la carte wifi:
                                        writing 1 or 0 to /sys/devices/platform/asus-laptop/wlan

                                Activation/désactivation de l'économie d'energie:
                                        iwconfig wlan0 power [on|off]


                        option 2: Voir si un module existe:

                                lspci |grep net
                                ls /lib/modules/$(uname -r)/kernel/drivers/net
                                find |grep MON_MODULE
                                modprobe MON_MODULE

                                vérifs:
                                        ifconfig
                                        ls /sys/class/net

                                Note: si aucun drivers ne correspond, il faut surement le télécharger et compiler les sources de ce dernier.

	---------------------------------
        Verouillage numérique
	---------------------------------

                > rc-update add numlock default

                        s'appui sur setleds pour afficher et activer le verouillage num
                         setleds -D +num : pour activer
                         setleds -D -num : pour desactiver

	---------------------------------
        INTERFACE GRAPHIQUE
	---------------------------------
		_________________
                Xorg : Serveur X Window
                        https://wiki.gentoo.org/wiki/Xorg/Configuration/fr
                        http://wiki.gentoo.org/wiki/Xorg.conf

                        Le systeme X Window, nommé X11 ou X est une norme visant à exploiter la partie graphique de l'ordinateur, largement répendu sur les systèmes Linux/UNIX.

                        Les interfaces graphiques se basent ensuite sur ces normes comme Xorg-X11.
                        Ces interfaces sont situés entre le materièl et l'application graphique exécutée.
                        Xorg peut faire véhiculer ses informations sur le réseau ce qui nous permet de visualiser directement une application d'un système hôte sur une autre machine.

                        
                        Préparer Xorg
                        ``````````````
                                -Le noyau doit prendre en charge les périphériques d'entrée (clavier...):

                                        Cela est rendu possible notament grâce à evdev (pilote générique)

                                                Device Drivers --->
                                                  Input device support --->
                                                    <*>  Event interface

                                -Le noyau doit prendre en charge la carte video:

                                        Les pilotes open-source s'appuient sur Kernel ModeSetting (KMS).
                                        Attention KMS peut générer des conflts avec des pilotes de tampon de trames patrimoniaux.

                                        Device Drivers --->
                                          Graphics support --->
                                              Support for frame buffer devices --->
                                                  ## (Désactivez tous les pilotes,  y compris VGA, Intel, nVidia, et ATI)
                                                   
                                               ## (Plus bas, activez la prise en charge de la console de base. KMS en a besoin.)
                                              Console display driver support --->
                                                         <*>  Framebuffer Console Support

                                        Il faut ensuite que bon pilote KMS de la carte graphique soit chargé:

                                        Pour les cartes Intel :

                                         Device Drivers --->
                                           Graphics support --->
                                               /dev/agpgart (AGP Support) --->
                                               <*>  Intel 440LX/BX/GX, I8xx and E7x05 chipset support
                                               Direct Rendering Manager (XFree86 4.1.0 and higher DRI support) --->
                                               <*>  Intel 8xx/9xx/G3x/G4x/HD Graphics
                                               [*]    Enable modesetting on intel by default

                                       Pour les cartes nVidia :

                                        Kernel configurationnVidia settings
                                        Device Drivers --->
                                          Graphics support --->
                                             Direct Rendering Manager (XFree86 4.1.0 and higher DRI support) --->
                                             <*>    Nouveau (nVidia) cards

                                       Pour les cartes AMD/ATI:

                                                Il faut installer le paquet 'radeon-ucode' ou 'linux-firmware' pour les cartes HD2000 et postérieures.
                                                voir: https://wiki.gentoo.org/wiki/Radeon#Firmware

                                                ## (Configurez le noyau pour utiliser le micro-code radeon-ucode )
                                                Device Drivers --->
                                                  Generic Driver Options --->
                                                  [*]  Include in-kernel firmware blobs in kernel binary
                                                  ## # ATI card specific, (see Radeon page for details of firmware to include)
                                                   (radeon/<YOUR-MODEL>.bin ...)
                                                  ## # all:
                                                    (/lib/firmware/) Firmware blobs root directory
                                                               
                                                ## (Enable Radeon KMS support)
                                                Device Drivers --->
                                                    Graphics support --->
                                                    <*>  Direct Rendering Manager --->
                                                    <*>    ATI Radeon
                                                    [*]      Enable modesetting on radeon by default
                                                    [ ]      Enable userspace modesetting on radeon (DEPRECATED)

                                                

                                -Portage devra être configuré pour compiler correctement Xorg.

                                        vim /etc/portage/make.conf

                                                VIDEO_CARDS="Pilote_Vidéo"

                                                exemples:

                                                        VIDEO_CARDS="nouveau" # pour nvidia
                                                        VIDEO_CARDS="radeon" # pour ATI/AMD
                                                        VIDEO_CARDS="intel" # pour intel

                                                INPUT_DEVICES="Pilote_périphériques_entrée"

                                                exemples:

                                                        INPUT_DEVICES="evdev"

                                                        Pour un pavé tactile synaptics: 
                                                        INPUT_DEVICES="evdev synaptics"

                                        Si ça ne convient pas, voir les options disponibles:
                                                emerge -pv xorg-drivers

                                -Activer l'option udev de la variable USE.:

                                        echo "x11-base/xorg-server udev" >> /etc/portage/package.use

                                        Il faudra peut être rajouter des options. 
                                        Lors de l'installation emerge vous préviendra alors des options à activer.

                        Installer Xorg
                        ``````````````

                                emerge --ask xorg-server
                                ou
                                emerge --ask xorg-x11  #plus lourd

                                env-update
                                source /etc/profile
                                
                        Configurer Xorg
                        ``````````````

                                Xorg détecte automatiquement les périphériques nécessaire et peut être lancé directement après l'installation viar 'startx'

                                Note: Si vous avez recompiler votre noyau, il faudra redémarrer dessus.

                                Les fichiers de conf sont dans:

                                        /etc/X11/xorg.conf.d/XX*.conf   #Le nombre indique la priorité
                                        ou
                                        /usr/share/X11/xorg.conf.d/XX*.conf
                                        ou
                                        /etc/X11/xorg.conf #Il n'a pas la priorité et cette méthode n'est plus recommandée.

                                Si le dossier de configuratio xorg.conf.d n'est pas présent dans /etc/X11, il faut copier celui qui est dans /usr/share/X11.
                                        Car ce dernier risque d'être modifié lors d'une prochaine mise à jour.


                                Exemples de conf:
                                        /usr/share/doc/xorg-server-VERSION/xorg.conf.example.bz2

                                Voir aussi man xorg.conf

                                voir aussi /etc/X11/xinit/xinitrc.d

                        startx
                        ``````````````
                                startx démarre le serveur X et lance une session X.
                                la session X permet de lancer les applications graphiques au dessus du serveur.
                                Il procèdes dans l'ordre:
                                        -lecture du fichier .xinitrc dans le home de l'utilisateur.
                                        -lecture de la variable XSESSION dans /etc/env.d/90xsession
                                                Cette variable définit le gestionnaire de fenêtre.

                                                exemple:
                                                        echo XSESSION="Xfce4" > /etc/env.d/90xsession


                                startx va d'abord voir si il existe un fichier .xinitrc dans le /home du user.
                                Sinon, il

                                startx a besoin d'un gestionnaire de fenêtre ou d'un environnement de bureau pour fonctionner correctement.

                                        emerge xclock
                                        emerge twm
                                        emerge xterm

                                Pour un gestionnaire plus complet voir Xfce:
                                        
                                        Se débarraser des ancien gestionnaires:
                                        emerge --unmerge twm xterm
                                                

                                Un petit ps faux peut aider à comprendre les processus qui ont été lancés.

                                        (voir les process en dessous de /bin/login -- )

                                Pour quitter le serveur X:
                                        killall xinit  #un peu bourrin mais ça part!

                        Configurer X
                        ``````````````

                                

		_________________
                Xfce
                        http://www.gentoo.org/doc/fr/xfce-config.xml
