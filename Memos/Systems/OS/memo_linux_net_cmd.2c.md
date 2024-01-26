L I N U X - N E T W O R K - C O M M A N D S
==============================


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Quelques fichiers systèmes concernant le réseau:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Fichiers concernant vos interfaces ...
            ls /proc/net

    Voir les modules réseaux disponible:
            ls /lib/modules/$(uname -r)/kernel/drivers/net/

    Voir quelques info concernant le montage des interfaces ...
            dmesg |grep eth

    Voir quelque info concernant sa carte:
            lspci |grep -i ethernet

    Liste des protocols usuels:
            cat /etc/services

    Des info sur son interface physique:
        > lshw -c network -sanitize


Manipulation des interfaces réseaux
-----------------------------

* [wiki.debian.org/fr/NetworkConfiguration](https://wiki.debian.org/fr/NetworkConfiguration)

### Network Manager

* [NetworkManager](https://wiki.debian.org/fr/NetworkManager)

!!! note 
    Pour la config des interfaces réseaux, attention au network manager.

En effet le networkManager aura la main mise sur le redémarrage des interfaces et cassera donc la conf faite à la volée avec ifconfig.

Pour désactiver cette feature:

**vim /etc/NetworkManager/NetworkManager.conf**

    [main]
    plugins=ifupdown,keyfile

    [ifupdown]
    managed=true

!!! note
    Le fichier /etc/network/interfaces à quand même le dessus sur le networkManager:

    man interfaces

**vim /etc/network/interfaces**

    allow-hotplug eth0
    iface eth0 inet dhcp

Il est possible d'éxécutuer une commande pendant le montage ou démontage d'un interface (ifup ou ifdown) en écrivant directement dans le fichier d'interfaces :

* pre-up/down : lancement d'une commande avant que l'interface soit up/down
Si la commande échoue, l'interface ne sera pas montée.

* up/down : lancement d'une commande pendant le changment d'état à up ou down
Pas d'impacte si la commande échoue

* post-down/up : lancement d'une commande juste avant qu'elle soit down/up
Si la commande échoue après le démontage de l'interface, elle sera déconfigurée.

Exemple:

    pre-up iptables-restore < /opt/iptables.conf

##### $ip : outil permettant d'afficher, manipuler les routes, les périphériques et les règles de routing

Afficher les routes :

    ip route show

Afficher les interfaces :

    ip addr
    ip address show

Changer l'état d'un lien réseaux à up :

    ip link set INTERTFACE up

Ajouter une ip à un lien :

    ip addr add 10.100.1.254/24 dev INTERFACE

Nettoyer le cache arp :

    ip -s -s neigh flush all
  
### Initialiser sa conf:

		ifconfig INTERFACE 0
		dhclient INTERFACE


### Informations hardware

		____________
		$iwconfig : infos pour le wireless
		____________
		$ifconfig : infos sur toutes les interfaces
			ifconfig -a : affiche les infos sur toutes les interfaces
			arp : Pour vous aider aussi à s'assurer de la corresponde MAC/IP
		____________
		$ethtool -i <interface> : connâitre le module de l'interface (état ...)
		____________
		$ip link show : afficher les attribus des interfaces.
        ip a

        https://tty1.net/blog/2010/ifconfig-ip-comparison_en.html
		____________
    $mii-tool -vv INTERFACE : afficher l'état du lien ...


	------------------
	OUTILS PRATIQUES
	------------------

		____________
		$ethtool : manipuler la conf hardware des interfaces

                    Il peut y avoir des problème de négociation avec son interface.
                    Dans ce cas le link reste à down et il ne se passe rien au niveau de l'interface.

                    On peut alors lister les vitesses supportées par le lien.

                    > ethtool eth0

                    on peu ensuite setter la vitesse de l'interface et la negociation:

                    > ethtool -s eth0 speed 1000 duplex full autoneg on

                    Manuellement:

                    > ethtool -s eth0 speed 100 duplex full autoneg off

		____________
		$mii-tool : manipuler le status des interfaces

                    exemple, setter la vitesse de l'interface:
                    > mii-tool -F 100baseTx-FD eth0

	------------------
	Adresse IP
	------------------

		_________________
		Attribuer une IP temporaire :

    Note : le network manager risque de surchager les paramètres.
    Il est conseillé de le désactiver pour que la configuration puisse rester le
    temps de la session de travail.

			> ifconfig <interface> <ip> netmask <mask>
			> ifconfig <interface:sous_interface> <IP>/<Mask> up

      Sources : https://ubuntu.com/server/docs/network-configuration

      ip addr add <ip>/<mask> dev <interface>
		_________________
		Réinitialiser une IP

			> ifconfig <interface> 0
			> ifconfig <interface:sous-interface> down

		_________________
		Redémarrer le démon

			> /etc/init.d/networking restart

		_________________
		Révoquer la bail et renégocier une adresse IP:

			> dhclient

		_________________
		Redémarrer les interfaces:

			> ifconfig <interface> down|up
			> ifdown <Interface> : stopper une interface définie en conf
			> ifup <Interface> : démarrer une interface définie en conf


	------------------
	Adresse MAC
	------------------

		> ifconfig <interface> hw <class(ether)> <mac_address>

	------------------
	Debian
	------------------

		/etc/network/interfaces : fichier de configuration des interfaces.

		#Interface static
			auto eth1
			iface eth1 inet static  #ou dhcp pour adresse dhcp
			address 172.16.0.2
			network 172.16.0.0
			netmask 255.255.0.0
			broadcast 172.16.255.255
			gateway 172.16.0.254

		#Interface manuel, pratique pour du rejeu ou pour avoir des interfaces actives sans @IP.
			auto eth1
			iface eth1 inet manual
			up ifconfig $IFACE 0.0.0.0 up
			up ip link set $IFACE promisc on
			up ip link set $IFACE mtu 9000
			down ip link set $IFACE promisc off
			down ip link set $IFACE mtu 1500
			down ifconfig $IFACE down

		#Sous interface:  ethX:Y
			exemple:
				auto eth0:1
				iface eth0:1 inet dhcp

            Note : Pour éviter les erreurs de type 'FILE EXIST' alors que tout semble bien paramétré,
                Il faut n'avoir qu'une option gateway pour l'ensemble des interfaces montées.

        Exemple de conf :

            #Internet
            iface eth0 inet dhcp

            #lan1:
            iface eth1 inet static
            address 10.0.0.1
            network 10.0.0.0
            netmask 255.255.0.0
            gateway 10.0.0.254

            #lan1:1
            iface eth1:1 inet static
            address 10.1.0.1
            network 10.1.0.0
            netmask 255.255.0.0
            post-up route add -net 10.10.0.0/16 gw 10.1.0.254
            post-up route add -host 10.8.1.1 gw 10.1.0.254

	------------------
	RedHat
	------------------

		/etc/sysconfig/network-scripts/ifcfg-eth<X>
			DEVICE=eth1
			HWADDR=08:00:27:8f:02:ab
			NM_CONTROLLED=yes
			ONBOOT=yes
			#BOOTPROTO=dhcp
			BOOTPROTO=static
			IPADDR=192.168.1.6
			NETMASK=255.255.255.0
			GATEWAY=192.168.1.1

		/etc/sysconfig/network
			NETWORKING=YES
			HOSTNAME=kikou
			GATEWAY=10.1.1.1


		Pour une sous interface:
			DEVICE=ethX:Y

			exemple: vim ifcfg-eth0:1
				DEVICE=eth0:1
				...
	------------------
	Nommer une interface:
	------------------

                Pour changer le nom des interfaces, c'est du coté d'udev que ça se passe avec le fichier de config suivant:

                        > vim /etc/udev/rules.d/70-persistent-net.rules

                        Editer ensuite les variable "NAME"

                        Exemple :

                            KERNEL=="eth*", SYSFS{address}=="00:12:34:fe:dc:ba", NAME="eth0"

                        ou encore :

                            SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="e8:bd:5f:89:12:a5", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"

                        Note :

                            Il faudra le faire pour toutes les interfaces pour éviter les conflits.

                Pensez à mettre à jour les @MAC dans vos fichiers de config :

                    Exemples sous Redhat/Centos :

                        > vim /etc/sysconfig/network-scripts/ifcfg-eth0

                Prendre en compre les nouveaux changements:

                        > service udev restart  #Debian
                        > start_udev  #Redhat


                Il faudra ensuite redémarrer le service réseau.

                        > service networking restart    #Debian
                        > service network restart #Redhat

	------------------
	Changer le MTU
	------------------

                Le mtu par défaut est de 1500 octet
                Il est configurable au niveau de chaque interface et visible grâce à ifconfig ou ip

                Pour le changer:

                Sur sur Redhat:
                        > vim /etc/sysconfig/network-script/ifcfg-ethX
                        MTU="9000"
                        IPV6_MTU="9000" #Pour l'ipv6

                Sur une Debian:
                         > vim /etc/network/interfaces
                         mtu 9000

                Directement avec le noyau:
                        > ifconfig ethX mtu 9000 up

	------------------
	Setter une interface réseau
	------------------
		https://wiki.archlinux.org/index.php/Network_configuration
		__________________________
		Check du driver:

			lspci -v
			dmesg |grep -i MODULE_NAME

		__________________________
		Chargement du driver si besoin

			voir modules-load.d et modprobe.d
			see https://wiki.archlinux.org/index.php/Kernel_modules#Loading
		__________________________
		Nom de l'interface:

			ls /sys/class/net
			ip link
			/etc/udev/rules.d/10-network.rules

		TODO

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Multicast
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://doc.ubuntu-fr.org/multicast

    Tester le bon fonctionnement du multicast:

		__________________________
                $omping

                    > omping node1 node2 node3 ...

		__________________________
                $ssmpingd

                    sur le noeud 1:
                        > ssmpingd

                    sur le noeud 2:
                        > asmping MULTICAST@ @IP_noeud1


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cache arp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	____________
	$arp	: manipuler le cache arp

		-an : afficher le cache
		-d HOST : supprimer l'hôte du cache

~~~~~~~~~~~~~~~~~~~~~~~~~~
Wifi
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Charger un driver / Activer sa carte wifi
        --------------------------

		Si udev ne charge pas le module, on peu l'ajouter manuellement dans /etc/modprob.d/monModule.conf (à vérifier)

		Si il n'existe pas de version linux pour le driver, on peu le charger avec ndiswrapper:

		$ndiswrapper : module pour utiliser un pilote Microsoft
			-i DRIVER.INF : installation du pilote (/etc/ndiswrapper)
			-l :vérification
			-m : écriture du fichier de conf (/etc/modprobre.d/SOMETHING.conf)

		$depmod -a : regénération des dépendances entre modules
		$modprobe ndiswrapper : chargement du module
		$iwconfiug : vérification
		$ip link set INTERFACE up : exemple wlan0

		Si la carte est soft bloquée:

			$rfkill list
			$rfkill unblock all

        --------------------------
        Se connecter à un AP
        --------------------------

		iwlist wlan0 scan

		__________________________
		WEP:

			iwconfig wlan0 mode [mode] channel [canal] key [clé] essid [nom_reseau]

			Configuration du mode:
                        ``````````````````````````

				iwconfig wlan0 mode [mode]
					managed : AP
					ad-hoc : point à point
					master : se définir en tant qu'AP

			Configuration du canal:
                        ``````````````````````````
				iwconfig wlan0 channel [canal]

					entre 1 et 13 (en france)

			Spécification du chiffrement
                        ``````````````````````````
				# Codée en hexadécimal (10 ou 26 caractères hexadécimaux) :
				iwconfig wlan0 key 1234-5678-90
				# Texte (5 ou 13 caractères ASCII) :
				iwconfig wlan0 key s: ma-clé
				# Sans clé:
				iwconfig wlan0 key off

			Association au réseau
                        ``````````````````````````
				iwconfig wlan0 essid [nom_reseau]
		__________________________
		WPA:

			apt-get install wpa_supplicant

			vim /etc/wpa_supplicant.conf


					network={
					  ssid="mon-reseau"
					    psk="ma-clé"
					      priority=5
					      }
				ou WPA2-PSK

				 ctrl_interface=/var/run/wpa_supplicant
				  ctrl_interface_group=0
				   eapol_version=2
				    ap_scan=1
				     fast_reauth=1
				      network={
				      ssid="ssid du point"
					      psk="le mot de passe"
					      priority=5
				       }

				ou WPA TKIP

				 ctrl_interface=/var/run/wpa_supplicant
			 ctrl_interface_group=0
			 eapol_version=2
			 ap_scan=1
			 fast_reauth=1
			 network={
				ssid="ssid du point"
				scan_ssid=1
				psk="clé wpa"
				key_mgmt=WPA-PSK
				proto=WPA
				pairwise=TKIP
				group=TKIP
			}

				ou RADIUS

				network={
				ssid="ssid du point"
				key_mgmt=WPA-EAP
				eap=PEAP
				identity="votre loggin"
				password="le mot de passe"
			#	ca_cert="/etc/cert/ca.pem"
			#	phase1="peaplabel=1"
			#	phase2="auth=MSCHAPV2"
				priority=10
			}

				ou WPA2-AES:

			network={
				ssid="lalala-secure"
				key_mgmt=WPA-EAP
				eap=TTLS
				pairwise=CCMP
				group=CCMP
				phase2="auth=MS-CHAPV2"
				identity="LoGiNdElAmOrT"
				anonymous_identity="LoGiNdElAmOrT"
				password="MotDePasseDeLaMort"
			}

			Lancement du supplicant:

				wpa_supplicant -i wlan0 -c /etc/wpa_supplicant.conf
				-Dwext (avec le driver wext)

l				en tâche de fond:

				wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf

			On récupère une ip via le dhcp: (ou manuellemnt)

				killall dhcpcd
				dhcpcd wlan0

			On peut avoir une connexion automatique via les tools suivant:

			netctrl, wicd, networkManager


        --------------------------
        TOOLS
        --------------------------
		__________________________
		$iwlist: permet de récupérer des informations sur le wifi

			INTERFACE scan : lance un scan des réseau à porté.

		__________________________
		$iwconfig: permet de configurer son interface wireless

			Accrocher un wifi:

			> iwconfig $INTERFACE essid $MON_SSID
			> iwconfig $INTERFACE key $MY_KEY	#(en hexa)
			> iwconfig $INTERFACE key s:$MY_PWD	#(en ascii)

		__________________________
		$rfkill : outil d'activation/désactivation de la carte wifi
			unblock all : pour débloquer la carte wifi (si on ne peu pas passer par un bouton par exemple)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
IPV6
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	------------------
	Désactiver l'ipV6
	------------------

		Voir si déja activé: (0=activé)
			cat /proc/sys/net/ipv6/conf/all/disable_ipv6

		Ajouter dans /etc/sysctl.conf:
			net.ipv6.conf.all.disable_ipv6 = 1
			net.ipv6.conf.default.disable_ipv6 = 1
			net.ipv6.conf.lo.disable_ipv6 = 1

		Recharger la conf:
			sysctl -p

		Revérifier:
			cat /proc/sys/net/ipv6/conf/all/disable_ipv6

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Network Manager
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Permet de gérer automatiquement la configuration réseaux (route, connexion ...)

	nmcli nm : Vérifier l'état des connexions
	nmcli dev : Vérifier l'état des interfaces

	Pour arrêter le service:

	/etc/init.d/network-manager stop

	Pour les systèmes Centos essayez

	NetworkManager

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ROUTAGE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	_____________
	$route

		> route -n : afficher la table de routage
		> route add default gw <IP> netmask $NETMASK: ajoute la passerelle par défault <IP>
		> route add -net <NETWORK_IP> netmask <MASK_IP> gw <GW_IP> dev $INTERFACE: ajouter une route
		> route del -net <NETWORK_IP> gw $GATEWAY netmask <MASK> dev <INTERFACE>

            Pattern :

                > route del/add -net NETWORK/MASK [gw ...] [dev ...]

                (la notation CIDR fonctionne aussi pour les mask)

            Pour ajouter une route vers un hôte (= net et un netmask /32) :

                > route add -host monHost gw XXXX

            /!\ Pour avoir la réponse dans l'autre sens il faut faire attention à ses règles IPTABLES et activer le forwading :
            à faire sur la gw :

                > vim /etc/sysctl.conf
                    net.ipv4.ip_forward = 1

                > iptables -t nat -A POSTROUTING -s SON_IP -j MASQUERADE

	_____________
	$netstat -r : afficher la table de routage

	_____________
	Mode gateway:

		Debian:

			Redirection de paquet Ipv4:

			> 	vim /etc/sysctl.conf
					#uncoment
					net.ipv4.ip_forward=1

			Chargement de la conf:

			>	sysctl -p /etc/sysctl.conf

				ou

			>	/etc/init.d/procps.sh restart

			ou sans avtivation permanente:

			> 	sysctl -w net/ipv4/ip_forward=1


		Redhat:

			IP forwarding sans modid de /etc/sysctl.conf
			> 	sysctl -w net.ipv4.ip_forward=1

			Verifier prise en compte
			> 	cat /proc/sys/net/ipv4/ip_forward

		Pour les vérif (prise en compte par le noyau)
		Il faut taper:

			> sysctl net.ipv4.ip_forward

                Note pour le routage over vpn, il faudra surement NAT (ou voir au niveau de la conf openvpn)
                    > iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
	_____________
	$traceroute REMOTE_HOST : affiche tout les noeud parcouru jusqu'à la destination

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
VLAN
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	>	apt-get install vlan
	>	modprobe 8021q
	>	lsmod |grep 802

			ou manuellement

	> 	vim /etc/modules
	>		8021q

	------------------
	Debian
	------------------
		_____________
		Noyau: (manuelle)

			>	vconfig add ethX $VLAN
			>	ifconfig ethX.$VLAN up

		_____________
		Suppresion:

			>	vconfig rem eth0.X

		_____________
		Conf:

			> 	vim /etc/network/interface
			>
			>		auto eth0
			>		allow-hotplug eth0
			>		iface eth0 inet manual

			>		auto vlan100
			>		allow-hotplug vlan100
			>		iface vlan100 inet manual
			>			addres ..
			>			vlan-raw-device eth0

			Pour activer l'interface:

			>	sudo ifup vlan100

		Il suffira ensuite de redémarrer l'interface eth0 par exemple pour que les vlan apparaissent.
		Les vlan sont ensuite configurable comme des interfaces à part entières (mais toutes sortant sur l'interface vlan-rawx)

			Autre syntaxe:

			>	auto eth0.100
			>	iface eth0.100 inet manual
			>		vlan-raw-device eth0

			Redémarrage des interface:

			>	ifup eth0.100
			>	ifdown eth0 && ifup eth0

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Download et upload de fichiers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		_____________
        $wget : permet de récupérer le contenu d'une page web
                        Support de HTTP, FTP et HTTPS

                    -O file : output file

                        Téléchargement de fichiers spécifiques:

                                > wget -r -l1 -A.pdf "http://monSite"

                        Note: mettre les "" autour de son URL pour éviter les problèmes de parsing.

                        wget "MON URL"

            Aspirer un site:

                https://mementolinux.wordpress.com/2010/09/25/aspirer-un-site-avec-wget/

                > wget -r -k -E -np http://tar.get/wanted/directory/

                    -r : récursif
                    -k : concertir les liens en liens locaux
                    -E : convertir en html les fichiers php
                    -np: ne pas remonter l'arborescence
                    --user-agent= : Simuler un navigateur (pour fausser le type de navigateur)
                    --http-user : donner un user (en cas d'auth http)
                    --http-password : donner un mot de passe (en cas d'auth http)

                Si le site est protégé par un mot de passe (non http):

                    Le plus simple est de sauvegarder le cookie depuis son navigateur par exemple (voir curl) et d'éxécuter les commandes suivantes:

                    > wget -r -k -E -np --load-cookie cookies.txt --keep-session-cookies https://monsiteweb/mapage

                Exemple de cookie:

                    # *******************
                    # HTTP cookie file.
                    # Generated by Wget on 2015-05-22 20:18:11.
                    # Edit at your own risk.

                    .monsite.fr   TRUE    /   TRUE    1589998703  usr  bidul
                    .monsite.fr   TRUE    /   TRUE    1589998703  id   dhfqhfliqshflihflifhqizhfui
                    # *******************


		_____________
        $wput : permet d'uploader des fichier

		_____________
        $curl : ce petit utilitaire est un peu du même genre que wget mais en plus évolué,

            Il sert surtout à éxécuter des requête avec la possibilité de 'forger' son header et ses cookies en live.

            et avec plus de fonctionnalité.
            Il supporte plus de protocole comme SFTP, TFTP ...
            Il est bidirectionnel

            http://curl.haxx.se/docs/comparison-table.html

            Exemple de requête curl:

                curl 'https://siteweb:self/' -H 'Host: hostname.fqdn' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Cookie: usr=monusr; id=monid' -H 'Connection: keep-alive' --data '__csrf__=b&__form__=1&__dialog__=1&username=monusr&password=monpwd'


            Note depuis la console de debug du navigateur il est possible de générer la commande curl (clic droit sur la requête, copy as cURL)

		_____________
        $httrack: ce petit tool permet d'aspirer un site dans sa globalité.

            https://httrack.com/html/index.html

            Certain site se protège de ce genre d'outil en placant des liens pièges.

            > httrack MON_SITE

            Pour avoir l'interface graphique:

            > apt-get install webhttrack

            > webhttrack

                (http://hostname:8080/server/index.html)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DNS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	_____________
	$nslookup <HOSTNAME> : permet de voir l'adresse ip de l'hôte répondant au nom inscrit.

		(attention à la conf résolv.conf)

	------------------
	Vider le cache:
	------------------
		_____________
		/etc/init.d/dns-clean start : vider le cache dns (niveau système)

		_____________
		service nscd restart : vider le cache des services de nom. (Redhat)

			conf: /etc/nscd.conf

            Normalement les fichiers mis en cache doivent se trouver dans /var/db/nscd/ (selon sa conf)
            Pour flusher un de ces fichiers :

                > nscd --invalidate=FILE_TO_FLUSH

            Exemple :

                > nscd --invalidate=hosts

            Note : le reload/restart du service doit aussi flusher la base (voir le /etc/init.d/nscd)
                $DAEMON --invalidate passwd --invalidate group --invalidate hosts

		_____________
		service dnsmasq restart : (Pour ceux qui l'utilisent). dnsmasq permet de créer un cache pour les services DHCP et DNS.

		_____________
		rdnc restart : (Pour BIND)
			ou
		rdnc flushname XX
		rdnc flush lan	#Pour vider le cache de la vue lan

		_____________
		dscacheutil -flushcache : (Pout MAC / Unix )
		_____________
		lookupd -flushcache : (Pour MAC)

        _____________
        $dig : outils de recherche DNS très performant. voir man dig
            dig -t [TYPE d'ENREGISTREMENT] domain : affiche les enregistrement selon leur type pour un domaine donnée:

            exemple:
                dig -t mx google.com

            http://www.thegeekstuff.com/2012/02/dig-command-examples/

        _____________
        $host -la <DomainName>  : Affiche les entrées du DNS.

        _____________
        /etc/resolv.conf : fichier de config pour ajouter/consulter les server DNS

                    search monDomaine.org monautreDomain.org
            nameserver @IP_serveur_DNS
            nameserver @IP_serveur_DNS2

                    ...

            Selon les versions des packages installés, au lieu d'éditer le fichier resolv.conf pour rajouter les infos DNS, il est préférable d'éditer le fichier des interfaces:

            voir aussi man resolvconf

        _____________
        vim /etc/network/interfaces

            Pour les ips static (à voir si cela fonctionne pour les interfaces dhcp)

            dns-nameservers  10.10.1.1 8.8.8.8
            dns-search domain.local

             exemple:

                    auto eth0
                    iface eth0 inet static
                    address 10.10.1.2
                    network 10.10.1.0
                    netmask 255.255.255.0
                    gateway 10.10.1.254
                    dns-nameservers  10.10.1.25 8.8.8.8
                    dns-search domain.local


            Il suffira ensuite de redémarrer l'interface en question:
                    ifdown eth0 && ifup eth0

        _____________
        Via la conf de dhclient:

            vim /etc/dhclient.conf
            ou
            vim /etc/dhcp3/dhclient.conf

            Pour avoir un dns supplémentaire:

                prepend domain-name-servers 8.8.8.8, 5.5.5.5;

            Pour changer complétement de dns:

                supersede domain-name-servers 8.8.8.8, 5.5.5.5;

            On redémarre son interface.

                ifdown eth0 && ifup eth0


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Accès à un hôte distant
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------------------
        Tester la connectivité:
        --------------------------------------
                ______________________________
                $ping : Envoie des requêtes ICMP 'ECHO_REQUEST' à un hôte (classique :p)

                    -c X: envoyer X ping (idéal pour les scripts)
                    -n : pour supprimer la résolution inverse à chaque requête. (si jamais les pings vers un nom d'hôte sont longs)

                ______________________________
                $arping : Pour envoyer des requête ARP

        --------------------------------------
        Connexion avec un hôte:
        --------------------------------------
                ______________________________
                $ssh : connexion avec un hôte distant via ssh ;)

                    http://virologie.free.fr/documents/openSSH/ssh_configurations.html

                        -v : permet d'afficher toutes les infos de connexion (clé utilisée ...)


                        Install :
                        ``````````````````````

                            > apt-get install openssh-server  # Pour être en mode serveur (écouter sur le port 22)
                            sinon pour installer uniquement le client:
                            > apt-get insall openssh-client
                            > /etc/init.d/ssh reload  :  démarrer/ redémarrer... le démon.


                        Connexion Manuelle :
                        ``````````````````````

                            > ssh login@IP  :  se connecter sur un server ssh

#### Génération d'une clé SSH (coté client)

Attention à bien se mettre à jour côté algorithmes de chiffrement.

Sources : https://tutox.fr/2020/04/16/generer-des-cles-ssh-qui-tiennent-la-route/

Algos :

* ~~DSA -> à proscrire, ça n’est plus supporté depuis openssh v7~~
*  RSA -> éprouvé et conseillé avec une taille de clé de 4096 bits. Compatible partout.
*  ECDSA -> Conseillé par l’ANSSI mais a priori n’a pas la confiance de tout le monde
*  ED25519 -> le dernier arrivé et le meilleur en termes de sécu et de performance (distributions récentes).

Passable :

  ssh-keygen -t rsa -b 4096

Préférons : 

  ssh-keygen -t ed25519 -a 100 (source : https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54)


                        Connexion auto (coté client)
                        ``````````````````````

                            > ssh-keygen -t rsa  :  générer une clé privée et public dans ~/.ssh
                            > ssh-copy-id -i id_rsa.pub <login>@<ip>
                                ssh-copy-id -i id_rsa.pub "-p 14521 <login>@<ip>"  : si besoin du port

                            En fait cette manipulation copie la clé publique sur le serveur distant.
                            Cette clé est copié dans le fichier "authorized_keys"

                            Si on dispose déja d'une paire de clé privée et publique,
                            il faut faire un > ssh-copy-id -i de la clé publique
                            et renseigner dans le fichier "config" la clé privées avec lequel il faut chiffer les données
                            En ajoutant : IdentityFile clé_privée.

                            (voir plus bas pour un aperçu de la conf)


                            Pour le faire à la main (à faire sur l'hôte distant)

                                > scp id_rsa.pub login@host:.ssh/
                                > ssh login@host
                                > cd .ssh
                                > cat id_rsa.pub >> authorized_keys
                                > chmod 600 authorized_keys

                            know_hosts:

                                Ce fichier est automatiquement créer lorsqu'on se connecte sur un nouvel hôte.
                                Une confirmation d'ajout du finger print est demander lors de la première connection.
                                Il permet de s'assurer que l'hôte n'est pas corrompu.

                                On peut faire une confirmation automatique avec l'option suivante:

                                    -o StrictHostKeyChecking=no

                                    Ou dans le fichier de config:

                                        StrictHostKeyChecking no


                        Droits pour la connexion automatique
                        ``````````````````````

                            Évite les erreurs de type: "authentication refused: bad ownership or modes for directory"

                            > chmod go-w ~/
                            > chmod 700 ~/.ssh
                            > chmod 600 ~/.ssh/authorized_keys


                        Passphrase "automatique" (Agent SSH)
                        ``````````````````````

                            > ssh-add  :  permet de rentrer sa passphrase (si activée) et de la mémoriser.


                        Lancer une appli graphique distante :
                        ``````````````````````

                            > export DISPLAY=:0.0    : Lancer en mode graph un soft sur une machine distante

                        
#### Afficher les applications en mode graphique sur son poste :

Link : https://www.xmodulo.com/how-to-enable-x11-forwarding-using-ssh.html

```
# Côté serveur
apt-get install xauth

vim /etc/ssh/sshd_config
  X11Forwarding yes

# Côté client
vim $HOME/.ssh/config file
  ForwardX11 yes

ssh -X user@remote_server
```

Note : il est également possible (over ssh) de se rdp sur le poste.

                        Conf perso: ~/.ssh/config (client)
                        ``````````````````````

                            # s'executera à chaque appel de host[autre chaine]
                            HOST <host*>
                                User <root>
                                IdentityFile <~/.ssh/key.rsa>

**faire un rebond ssh :**

    HOST <cible>
        User <root>
        IdentityFile <~/.ssh/mykey.rsa>
        ProxyCommand ssh <bridge> ssh <output_host> /usr/sbin/sshd -i
        #ProxyCommand ssh <bridge> nc %h %p 2> /dev/null

Exemples :

    HOST 10.0.1.1
        User root
        IdentityFile ~/.ssh/hop_key.rsa #(placé sur le serveur de rebond)
        ProxyCommand ssh -tt serveur_bridge ssh 10.0.1.1 /usr/sbin/sshd -i

    HOST 10.0.1.2
        User root
        #ProxyCommand ssh serveur_bridge nc %h %p 2> /dev/null

Cette méthode a le désavantage de devoir stocker les clés sur tous les hôtes de rebond.  
Pour éviter ce problème, mieux vaut utiliser le ssh agent forwarding.
    


                        Conf globale: /etc/ssh/sshd_config (serveur)
                        ``````````````````````

                            PermitRootLogin  :  autorise la connexion en root, mettre no pour plus de sécurité.
                                            AllowUsers monUser user2 ...: filtrer les utilisateurs.

                                            Match User bidul Address 192.168.1.50
                                                PasswordAuthentication no

                            > /etc/init.d/ssh reload  : pour recharger la conf.

                        Message de connexion:
                        ``````````````````````
                            vim /etc/motd

                            Pour le rendre permanent, il faut casser le lien sur lequel il pointe.


                        Tunneling
                        ``````````````````````

                            http://doc.ubuntu-fr.org/ssh_avance

                            ssh permet de créer des tunnel chiffrés entre plusieurs hôtes.
                            Cette fonction est vraiment très pratique et peut être utilisé afin de faire passer des requêtes à un serveur de manière sécurisé. IL permet notament de contourner des firewall ;) .

                            Plusieurs types de tunnels s'offrent à nous:
                            (l'option -p est ici facultative, elle sert uniquement si vous avez changé le port d'écoute du server SSH)

                            1) Un tunnel qui lie le port local à un port distant :

                                > ssh -L Port_local:localhost:Port_distant -p PORT user@server_distant

                                On écoute sur le port local:
                                Les connexions établies avec le port local seront en fait établies avec le port distant.
                                Les requêtes envoyées sur le ports local transiterons dans le tunnel ssh et sortirons sur le port_distant.

                                HOST [PORT_LOCAL] ---> REMOTE [PORT_SSH(22)] ---> REMOTE |PORT_DISTANT]

                            2) Un tunnel qui lie le port distant à un port local :

                                > ssh -R [IP_DISTANTE:]Port_distant:localhost:Port_local -p PORT user@server_distant

                                On écoute sur le port distant

                                Les connexions établies sur le port_distant seront en fait établies avec le port local.
                                Les requêtes envoyées sur le port distant arriveront sur le port local via le tunnel ssh.

                                Note si l'on ne spécifie pas l'IP distante, si le mode Gateway n'est pas activé dans la config ssh,
                                la connexion se fera par défaut depuis le localhost du serveur distant.

                            3) On lie dynamiquement le port local avec les ports distant (pratique pour un mode socks proxy)

                                > ssh -D Port_local user@server_distant

                                Ici on écoute sur le port local:
                                Les connexion établies avec le port local seront établient avec un port sur le serveur distant "aléatoire" géré par l'application.
                                Les requêtes envoyées sur le port local arriveront sur un port distant du server aloué dynamiquement.
                                Ces ports sont configurable dans le fichier de configuration de ssh.

                                Ce mécanisme ce fait via le protocole SOCKS (v5 actuellement).
                                todo détailler le protocole

                            Des options pratiques pour le tunneling:

                                -f : pour passer la commande en tâche de fond
                                -n : pour envoyer l'output sur /dev/null
                                -N : Pour ne pas exécuter de commande distante
                                -q : mode silencieux
                                -T : désactive l'allocation d'un TTY

                            4) Un tunnel avec plusieurs noeuds:

                                Exemples:

                                    > ssh -L 9999:localhost:9999 host1 ssh -L 9999:localhost:1234 -N host2

                                    ou encore:

                                    > ssh -L 9998:host2:22 -N host1
                                    > ssh -L 9999:localhost:1234 -N -p 9998 localhost

                        Lenteur ouverture de session
                        ``````````````````````

                                        mettre 'UseDNS no' dans /etc/ssh/sshd_config
                                        ou rajouter l'addresse de l'hôte distant  dans /etc/host (plus contraignant)

                        Limiter les utilisateurs pam ssh
                        ``````````````````````

                                        > vim /etc/pam.d/ssh

                                            auth required pam_listfile.so sense=allow onerr=fail item=user file=/etc/loginusers

                                        > vim /etc/loginusers

                                            user1
                                            user2
                                            ...

                        Connexion par clé
                        ``````````````````````
                                > vim /etc/ssh/sshd_config

                                    AuthorizedKeysFile  .ssh/authorized_keys

                        REVERSE SSH
                        ``````````````````````

                            Cette méthode permet de passer par un hôte qui fera office de passerelle,
                            Pour se connecter directement vers un autre hôte accessible depuis la machine qui a lancer le reverse.

                            On l'utilise idéalement pour faire des ponts de connexion :

                            Exemple de layout :

                                GATEWAY_HOST <-> BRIDGE_HOST <-> PROXY_HOST

                                Lorsqu'on se connectra sur l'hôte Gateway, on tombera directement sur l'hôte Proxy.
                                Si on a initié le reverse depuis sa machine par exemple.
                                Celle ci fera office de bridge.


                            Première solution, en ouvrant un tunnel constant entre deux serveurs :

                                On se connecte ensuite sur un port spécifique du serveur d'accès.

                                Il faut pour cela ouvrir une connection depuis le serveur cible vers le serveur d'accès (la source).

                                    > ssh -R [socket_distant]:proxy_host:<port_local> user@serveur_passerelle
                                    ou
                                    > ssh -R <port_distant>:proxy_host:<port_local> user@serveur_passerelle


                                Exemple:

                                    https://www.howtoforge.com/reverse-ssh-tunneling

                                    > ssh -R 7777:localhost:22 user@gateway_server

                                    On pourra ensuite se connecter sur la source et accéder à notre environnement:

                                        > ssh gateway_server #Si l'on vient d'une autre machine
                                        puis
                                        > ssh -p 7777 localhost

                                Si l'on veut que la connexion ne se fasse pas uniquement via localhost, il faut publier le port vers l'extérieur en renseignant un socket :

                                    Pour ça, il faut activer le mode Gateway :

                                        - activer le mode gateway sur le serveur "passerelle" :

                                            > vim /etc/ssh/sshd_config

                                                GatewayPorts yes

                                    et/ou spécifier le socket de connexion distant :

                                        - bien publier vers toutes les IP :

                                            > ssh -R 0.0.0.0:2222:serveur_proxy:22 serveur_passerelle

                                    S'assurer que le packet forwarding est activé :

                                        > sysctl -w net/ipv4/ip_forward=1

                                        pour l'activer de façon permanente, éiter le /etc/sysctl.conf


                                    On pourra accéder en direct via :

                                        > ssh -p 2222 serveur_passerelle


                                Avec autossh :

                                        Todo:
                                            http://doc.ubuntu-fr.org/tutoriel/reverse_ssh
                                            http://wiki.kogite.fr/index.php/Reverse_ssh_:_Acc%C3%A9der_%C3%A0_un_serveur_derri%C3%A8re_un_NAT_-_Firewall
                                            http://geekfault.org/2011/02/19/reverse-ssh-acceder-a-un-serveur-derriere-un-natfirewall/
                                            https://wiki.archlinux.fr/Autossh

                            Deuxième solution le rebond :

                                Il suffit d'utiliser un serveur de rebond:

                                vim ~/.ssh/config

                                    HOST serveurFinal
                                        User monUser
                                        IdentityFile ~/.ssh/mykey.rsa
                                        ProxyCommand ssh serveurRebond ssh serveurFinal /usr/sbin/sshd -i

                            Troisième solution le SOCKS proxy :

                                https://wiki.archlinux.org/index.php/Tunneling_SSH_through_HTTP_proxies_using_HTTP_Connect

                                Un tunnetl ssh over http/https proxy avec SOCKS.

                            Autres solutions ?

                                ...a documenter

                        Issues
                        ``````````````````````

                            Lancer en mode debug:

                                > ssh -vv user@host

                            Permission denied avec le bon password et le bon user (root):

                                Vérifier la conf sshd:

                                > vim /etc/ssh/sshd_config

                                    PermitRootLogin yes

                                    # Il faudra supprimer les autres entée ex :PermitRootLogin without-password

                                > service ssh restart

                        Lancer une application graphique :
                        ``````````````````````

                            Pour lancer une appli graphique à travers ssh :

                                > ssh -X monHost

                                    Puis dans la session :

                                        > monAppliGraphique

                                Exemple :

                                    > ssh -X vmguest
                                    > virtualbox

		______________________________
		$telnet: se connecter à un serveur de façon non chiffrée

			``````````````````````
			Server:

                    > apt-get install telnetd xinetd

                    vim /etc/xinetd.d/telnet

                        service telnet
                        {
                                flags           = REUSE
                                socket_type     = stream
                                wait            = no
                                user            = root
                                server          = /usr/sbin/in.telnetd
                                log_on_failure  += USERID
                                disable         = no
                                only_from       = 127.0.0.1
                        }

					> service xinetd start

            Client:
                    > telnet HOSTNANE

                    Note: le telnet en root est par défaut fermé
                    le port par défaut est 23

		______________________________
		$expect : Utilitaire d'éxécution de commande distante (voir le memo bash)


	--------------------------------------
	Accès par cable série
	--------------------------------------

        Voir du coté du "tip_serial_console".

            Lancer dmesg |grep tty : pour afficher le tty utilisé.

		______________________________
		$minicom:  C'est un utilitaire intéractif pour les communications séries.
                        minicom -s : lancer la configuration intéractive de minicom

		______________________________
        $cutecom: Utilitaire graphique de connexion série.

		______________________________
        $putty: idem
		______________________________
		$screen:	Il est aussi possible de passer par screen pour initier des connexions.

			exemple:

				> screen /dev/ttyS0 9600
		______________________________
		$cu: 	Permet d'appeler un autre système (par exemple prendre la main via le port console)

			exemple:

				cu -l MON_DEVICE -s MON_BAUD


	--------------------------------------
	Montage distant
	--------------------------------------
		______________________________
		$sshfs : Montage distant de FS basé sur SSH.

			(necessite le paquet fuse)

			Montage manuel
			``````````````````````

				> sshfs user@host:dossier mountpoint : monter un dossier d'une machine distante

				(fonctionne avec la configuration ~/.ssh/config)

				exemple:

                    > sshfs MONHOST: /media/MOI/MONHOST -o follow_symlinks

				(voir la man pour toutes les options)

                    -o uid=xxx -o gid=xxx : permet de seter les owners.

                autre exemple:

                    > sudo sshfs user@nas:/partage /tmp/test/ -o allow_other

			Montage via fstab
			``````````````````````


				Pour l'ajouter dans la fstab:

					Exemple:

					sshfs#HOST:/PATH  /POINT/DE/MONTAGE  fuse  user,noatime,allow_other,follow_symlinks  0  0

						user : permet à n'importe qui de faire le montage
						noatime : Permet de gagner en temps d'accès (pas de maj des temps des accès des inodes ?) :p
						allow_other : Permet d'autoriser les autres users à utiliser le point de montage
						follow_symlinks: Permet de parcourir les liens.

				Il faut ensuite copier votre config ssh dans /root

				> cp -R ~/.ssh/* /root/.ssh/

				(Pour récup vos clé ...)

                exemple:
                    user@domain.org:/home/user  /media/user   fuse.sshfs    defaults,allow_other,_netdev    0  0

        > mount -a


			Montage par script au login:
			``````````````````````

				Rajoutez votre script dans /usr/bin par exemple:

				vim mount_HOST.sh

					#!/bin/bash

					sleep 5
					sshfs MONHOST: /media/MOI/MONHOST -o follow_symlinks

				Puis appeler le:

				vim ~/.bashrc

				à la fin mettre: mount_HOST.sh


			Montage via autofs
			``````````````````````

				Voir exemple dans la section autofs


			Démontage:
			``````````````````````

			> fusermount -u mountpoint : démonter un dossier sur une machine distante

		__________________
		$autofs : Script de montage de disque apportant des améliorations à la fstab. (Utilise automount)

			Ce dernier permet d'optimiser le montage des disques:
				-Montage des disques lorsque disponible.
				-Démontage des disques lorsqu'ils sont inactifs.

			Fonctionnement:

				1) Pour chaque type de montage (à determiner comme bon nous semble, exemple: NFS, SSHFS...);
				il faut ajouter une déclaration dans /etc/auto.master
				faisant référence au fichier qui contiendra tout les points de montage:

				vim /etc/auto.master:

					#/MONTAGE/PARENT /PATH/TO/FILE/auto.TYPE --OPTIONS

					exemple:

					/mnt /etc/auto.sshfs --ghost,--timeout=20

					#-- ghost = Le point de montage se créer à chaque accès.
					#--timeout = temps d'inactivité en seconde avant le démontage automatique.

				2) Puis on va éditer le fichier auto.TYPE de la même manière que la fstab.

				Contenant la syntaxe suivante:


					#NOM_PARTAGE -fstype=TYPE,OPTIONS HOST:/PATH/TO/SHARE

				(Le point de montage sera créé dans le "/MONTAGE/PARENT renseigné dans auto.master).

				exemple avec sshfs:

				> vim /etc/auto.sshfs

					#NOM_DE_MONTAGE -fstype=fuse,rw,allow_other,follow_symlinks  :sshfs\#login@IP:/your/share

					HOST	-fstype=fuse,rw,allow_other,follow_symlinks  :sshfs\#HOST:


				Note: utilisez des points de montage parent vide (sinon le montage se fera par dessus.)

					Dans le cas si dessus, sshfs utilise la conf dans ~/.ssh


				3) On redémarre le script:

				> restart autofs


	--------------------------------------
	Echange de fichier:
	--------------------------------------

		_____________________________
		$scp : copier des fichiers à travers le réseau sur un hôte distant

			> scp /path/file host:/path/file  : copiera le fichier en local sur l'hôte distant

			-r : mode récursive
			-3 : execute une copie en local entre 2 host (dans le cas d'une politique de sécurité qui n'autorise qu'un sens de transfert par exemple)

			> scp -3 host1:/path/file host2:  : copiera le fichier du host1 sur le host2 en passant par l'hôte local
                        > scp host1:/path/to/file host2:  : copiera directement le fichier du host1 vers le host2 (le tunnel se fait entre ces 2 hôtes)

		_____________________________
		$sftp: (ssh file transfer protocol)

			sftp est plus récent que scp et permet notament de passer en mode interactif pour les copie

			sftp user@host


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
inetd && xinetd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Ce démon permet d'écouter plusieurs ports définient dans /etc/services.
	Il s'occupe de gérer les demandes de connexion clientes vers les deamon internes.

        Après avoir controller la requête, il la redirige vers le bon service.
        Il fait office d'intermédiaire, et permet de centraliser les connexions.

	Le fichier /etc/inetd.conf contient la liste des services activés sur l'hôte.
	Il est maintenant remplacé par xinetd.conf.

	Ce dernier gère un fichier de conf par service dans /etc/xinetd.d/...

    config du deamon:

        > vim /etc/xinetd.conf

        defaults
        {
            instances = 70              #Nombre de connexion simultanées
            per_source = 15             #Nombre de connexion max pour un utilisateur
            log_type = SYSLOG authpriv  #Type de deamon chargé des logs
            log_on_success = HOST PID
            log_on_failure = HOST
            cps = 30 40                 #Connexion par secondes acceptées et timeout avant coupure
        }

        includedir /etc/xinetd.d


	exemple pour le service tftp: (/etc/xinetd.d/tftp)

                service tftp
                {
                    protocol        = udp
                    port            = 69
                    socket_type     = dgram
                    wait            = yes
                    user            = nobody
                    server          = /usr/sbin/in.tftpd
                    server_args     = /home/tftpboot
                    disable         = no
                }

	On peut aussi forcer l'écoute d'un service réseau sur une adresse spécifique
	bind		= @IP

	Il est possible de rediriger un socket:
	redirect	= @IP PORT


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
TCP Wrapper
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Permet de contrôller les demandes de connexion sur un hôte:

	deux fichiers de conf:

	/etc/hosts.deny  : pour interdire les hôtes

	exemple:

		in.ftpd:ALL	: interdit toute les connexion ftp

	/etc/hosts.allow  : pour autoriser les hôtes

	exemple:

		in.ftpd:host_bidon.lan


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SOURCES /etc/apt/source.list (voir http://doc.ubuntu-fr.org/sources.list)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		Structure du fichier:

	deb      http://fr.archive.ubuntu.com/ubuntu/     lucid     main restricted universe multiverse

	[deb] : type de paquets contenus dans ce dépot. (deb pour les paquet d'install et deb-src pour les paquets sources)
	[http://fr.archive.ubuntu.com/ubuntu/]  :  désigne l'url du serveur de paquets
	[lucid]  :  identifie notre version de linux
	[main restricted universe multiverse]  :  identifie les sections du dépots auxquelles on souhaite accéder.

		 ______________________________________________________________________
		|Sections:		        |équipe d'Ubuntu:	|utilisateurs d'Ubuntu:
		|			            |			        |
		|Logiciels libres 	    |main 			    |universe
		|Logiciels non-libres	|restricted 		|multiverse


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FTP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------
	Récupérer simplement un fichier over ftp:
	------------------

        Très simplement:

            > wget ftp://serveur/dir/file.txt --ftp-user=USER --ftp-password=PASS

        En construisant l'arborescence:

            > wget -r -l 0 ftp://serveur/dir/file.txt --ftp-user=USER --ftp-password=PASS -nH --cut-dirs=1

            Avec:
                -l : niveau de recursivité
                -nH : ne pas créer de dossier avec le nom du host
                --cut-dirs : profondeur

	------------------
	Ouverture de session ftp:
	------------------
        _____________
        $ftp

            > ftp -n
                >open [adress ftp:....]
                >user anonymous toto@gmail.com
                >cd ...
                >get [fichier à télécharger]
                >exit

	------------------
	Monter un partage ftp
	------------------

        La plupart des navigateurs de fichier propose cette fonctionnalité.

        _____________
        $curlftpfs : permet de monter des dossier en ftp:

            monter:

                > curlftpfs ftp.yourserver.com /mnt/ftp/ -o user=username:password
                > curlftpfs ftp.yourserver.com /mnt/ftp/ -o user=username:password,allow_other

                Au niveau de la fstab:

                    curlftpfs#USER:PWD@ftp.domain.org /mnt/mydomainorg fuse auto,user,uid=1000,allow_other,_netdev 0 0
                    ou
                    curlftpfs#nas.vas.advim.fr /mnt/advim_nas fuse auto,user=USER:PWD,uid=1000,allow_other,_netdev 0 0

            démonter:

                > fusermount -u /mnt/ftp

	------------------
	Monter un partage sftp
	------------------

        Voir sshfs

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
AFP  - Apple Filing Protocol
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install afpfs-ng

    Montage manuel:

        mount_afp afp://user:pwd@host/share /mount/point

    Montage autoamtique (fstab):

        > vim /etc/fuse.conf

            user_allow_other

        > vim /etc/fstab

        afpfs#afp://user:pwd@host/share /mnt/share fuse user=monUser,group=fuse 0 0

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Synchro sur hôte distant
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	_____________
	$lftp : permet de synchroniser ses fichiers sur un hôte distant via plusieurs protocole comme sftp, ftp...

		Sécuriser : rajouter "set ftp:ssl-protect-data true" dans le fichier de configuration .lftprc

		Exemple d'utilisation:

			Pour synchroniser à l'identique:

			FTP:

				> lftp ftp://USER:PWD@HOST -e "mirror -veLR /LOCAL/PATH /REMOTE/PATH ; quit"

			SFTP:

				> lftp sftp://USER@HOST:PORT -e "mirror -veLR /LOCAL/PATH /REMOTE/PATH ; quit"

				Le mot de passe vous sera demandé dans cette dernière.

				Si vous utilisez la conf ssh (ce qui est relativement mieux):

				> lftp sftp://HOST -e "mirror -veLR /LOCAL/PATH /REMOTE/PATH ; quit"

				Avec en conf local un truc du genre:

					HOST ftp.MON.HOST
						User MON_USER
						IdentityFile /PATH/TO/RSA/KEY
						Port MON_PORT


					ET sur l'hôte distant rajouter:

						.ssh/authorized_keys

						Avec votre clé dedans public ;) (Avec les bons droits :p).

                                                        ssh-rsa AAAAB... user@host

                                                chmod 644 .ssh/authorized_keys


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PORTS && Manipulation de flux réseaux && Analyse de son réseau (TODO: mieux segmenter)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Note:
                socket = PORT + IP
                socket client : PORT généré aléatoirement et > 1024 (le plus souvent)
                socket serveur : PORT généralement standarisé.

                Pour avoir des infos sur les protocoles, voir memo_protocols

	_____________
    Scanner les hôte de son réseau:

            Avec un script utilisant ping:

                > for n in $(seq 1 254); do ping -c 1 192.168.X.X && echo "192.168.X.X" is up ; done

                Fonctionne aussi avec nmap:

                exemples:

                    > nmap -sP 192.168.1.0/24
                    > nmap -T4 -sP 192.168.1.0/24
	_____________
	$nmap : scan de port, exploration réseau et sécurité

        Syntaxe:

            Plage d'IP:
                X.X.X.X-Y

            IP et Masque:
                X.X.X.X/MASK


        Scan des ports:

            Scan rapide des ports connus:
                -F

            De tout le réseau:
                > nmap ADRESSE_RESEAU/MASK : decouverte des hôtes sur le réseaux

            Avec ports UDP et TCP spécifiés:

                > -p U:53,111,T:21-25,80 ... #Scan de port précis

            -r : scan séquentiel (port dans l'ordre)

                Avec -sS, -sF, -sT et -sU pour activer le scan.
                (Voir man)

            -Pn : do not use ping.

            -unprivileg : pour indiquer que l'utilisateur n'a pas les droits au niveau du socket
                Permet d'éviter l'erreur de type route_dst_netlink: can't find interface ...

            Scanner un hôte de façon agressive :

                > nmap -A -T4 -Pn <@IP HOST>

        Scan par ping:

            > nmap -sP @NETWORK
            ou
            > nmap -sn @NETWORK

#### $nc (netcat)

Permet d'ouvrir des connexions TCP et UDP, envoyer des paquets, écouter, balayer des ports (Compatible IPv4 et IPv6)

**Ècoute sur un port spécifique :**

    nc -l mon_port

**Écoute et redirection de port :**

    nc -l 20000 | tee FILENAME | nc localhost 25000

Dans cet exemple, on écoute sur le port 20000, on écrit ce qui arrive sur ce port tout en le redirigeant vers un process locale sur le port 25000.
Ceci peut être pratique dans des phases de tests de certain processus.

**Debug de connexion**

Pour débug un socket, on peut utiliser cette commande afin de tester une connexion :

    nc -vz IP PORT

L'option -z permet de mettre fin automatiquement à la connexion. (pas d'envoi de données).


	_____________
	$socat : du même genre que nc mais avec plus de fonctionnalités!

		Le man est bien détaillé sinon voir cette page:
			Lien: http://www.dest-unreach.org/socat/doc/socat.html#EXAMPLES

		Il a l'avantage par rapport à nc, de laisser la possibilité à un processus père, de générér plusieurs processus fils:

			> socat tcp-listen:<portY>,fork tcp:localhost:<portX>

				--> on écoute sur le portY, on active l'option forl permetant de créer plusieurs processus fils, et on redirige sur le portX.
			> socat tcp-listen:10555 OPEN:/tmp/filename,creat,append

				--> ici on redirige le flux dans un fichier

	_____________
	$netstat: Afficher l'état des connexion réseaux:

        (apt-get install net-tools)

		-r : afficher la table de routage
		-n : afficher des adresses numériques (IP)
			--> -rn pratique pour les tables de routages

		-i : afficher les interfaces réseaux et leurs attributs
		-e : affichage détaillé
			--> -ie pratique pour afficher les infos sur les interfaces

		-u : afficher les connexions UDP
		-t : afficher les connexions TCP
		-a : afficher tous les socket (listening et non-listening)
			--> -utae pratique pour afficher toutes les connexions

		-p : afficher le PID responsable de la connexion
			--> netstat -tnp|grep <port> : permet d'affciher les connexions d'un process en particulier.

		-s : statistiques par protocoles
		-l : listen, affichage des connexions dans l'état listen.

		Etats des connexion: voir man : /state

		utile:
			>	netstat -laputen
			> 	netstat -tanpu

        Note sur RecvQ and SendQ :
            RecvQ correspond aux données en attentes d'être traitées sur le buffer du socket en question
            SendQ correspond aux données en attentes d'être ACK par une réponse TCP
	_____________
	$lsof -ni : Permet de fournir d'autres info concernant les connexion réseaux
		Pour afficher les connexion en temps réel:

		> watch lsof -i
	_____________
	$cutter: Couper une connecion tcp/ip

		> cutter @IP PORT  : interompra la connexion de l'hôte '@IP' communicant sur le port PORT

	_____________
	$tcpkill: du même acabit que cutter, il faut installer dsniff si vous ne trouvez pas le paquet.

		il fonctionne avec les filtres de tcpdump,
		exemple:

		> tcpkill -9 -i lo host 127.0.1.1 and port 53

		Celui-ci fonctionne en "live" sur un flux en cours de transite.

	_____________
	$mtr HOSTNAME: outil de diagnostique réseau se basant sur taceroute et ping pour analyser l'état du traffic entre deux hôtes




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FIREWALL
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	_____________
	$iptables : voir le mémo iptables


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CAPTURES DE TRAMES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	_____________
	$tcpdump: capturer/lire du traffic

		> tcpdump [OPTIONS]

		exemple:

                        > tcpdump -n -i <inteface> -w /tmp/file.pcap '<rools>'

                Quelques options:

			-i [interface] : choisir une interface
			-n : ne pas faire de résoution DNS
			-x : visualisation en hexadécimal
			-X : visualiser une trame au format ASCII
			-e : visualiser les adresses ethernet
			-s 0 :

		Filtres (exemples)

                        > man pcap-filter

			liens : 	or and not
			hôte: 		src host [IP] and dst host [IP] and port [N°]
			protocoles: 	tcp and udp ...
			Regroupement: 	host 8.8.8.8 and  \(port 80 or port 443\)

                        N'afficher ques les début et fin de connexion des sessions TCP:

                                tcpdump 'tcp[tcpflags] & (tcp-syn|tcp-fin) != 0'        #Ne pas oublier les quote !

                        Il est aussi possible de jouer avec les octets et les valeurs en bit,

                                Pour TCP, le 13° octet représente le bit de contrôl et contient donc 8 bits

                                FLAG:   CWR | ECE | URG | ACK | PSH | RST | SYN | FIN
                                BIT:    7   |  6  |  5  |  4  |  3  |  2  |  1  |  0
                                Dec:    128 | 64  |  32 |  16 |  8  |  4  |  2  |  1

                                Exemple:

                                |C|E|U|A|P|R|S|F|
                                |---------------|
                                |0 0 0 1 0 0 1 0|       => pour les SYN-ACK soit 18 en décimal
                                |---------------|

                        Le filtre précédent peut être écrit avec des valeur numérique:

                                tcpdump 'tcp[N°OCTET] & VALEUR DECIMAL du FLAG  != VALEUR DECIMAL de l'octet'

                                soit:

                                tcpdump tcp[13] & (2|1) != 0

                                En fait on le lit de cette manière:

                                        Sur l'octet 13 de mon segment TCP, si j'applique un ET logique sur le FLAG ACK ou FIN,
                                        le résultat en décimal doit être différent de 0.

                                Autre exemple,
                                SYN représente la valeur décimal 2 du 13ième octet,
                                Pour avoir uniquement les SYN flags il suffit d'appliquer le filtre suivant:

                                        tcpdump tcp[13] == 2

                                Maintenant si on veux tout les segment TCP contenant un SYN:

                                        On fait un ET logique entre tout les FLAGS et le SYN

                                        0 0 0 1 0 0 1 0
                                  AND   0 0 0 0 0 0 1 0
                                  AND   ...

                                  On aura toujours

                                  =     0 0 0 0 0 0 1 0  soit 2 en décimal

                                  On peut donc affirmer que pour chaque ET logique effectué avec ce dernier , le resultat sera 2

                                  Donc on l'écrit dans la même logique:

                                        tcpdump 'tcp[13] & 2 == 2'
                                    ou  tcpdump tcp[tcpflags] & tcp-syn == 2


                        Si votre paquet est encapsulé dans du 802.1Q,

                                Rajoutez le filtre 'vlan'

                                tcpdump 'vlan and ...'


		Pour lire un pcap:
                        > tcpdump -nr fichier.pcap

		Pour avoir une meilleur visibilité:

                        > tcpdump -Xvvvner fichier.pcap

		Sur les nouvelles version, tcpdump dump les fichiers au format pcapng.
		Pour dumper dans l'ancienne version (pcap) il faut utiliser dumpcap ou bien le reconvertir:
                        > tcpdump -r file.pcapng -w file.pcap

		Pour l'inverse:
                        > tshark -F pcapng -r file.pcap -w file.pcapng

		Pour dumpcap:
                        > dumpcap -P -i eth0 -w file.pcap

                On peu aussi convertir un fichier non pcap type snoop avec tshark:

                        > tshark -r foo.snoop -w foo.pcap


	_____________
	$tcpick : Cette outil est spécialisé dans la reconstitution de flux tcp

		tcpick offre en plus une touche de couleur ;).

		Lire un fichier:
                        > tcpick -C -r fichier.pcap    : équivaut à tcpdump -nt -r fichier.pcap

		Pour afficher le contenu:
                        > tcpick -C -yX -r fichier.pcap  : équivaut au tcpdump -Xvvvnr fichier.pcap

		Capturer un flux tcp (la capture s'arrête à la première session capturée)
                        > tcpick -i eth0 -wRu


	_____________
	$tcpprep: générer un cache avec les 2 sens de communication (Client/Serveur)


		> tcpprep -a <mode> -i <file.pcap(input)> -o <file.cache(output)>
		> tcpprep -I <file.cache> : permet d'afficher le contenu du fichier cache

	_____________
	$tcpreplay: Rejouer du traffic


		> tcpreplay -i <interface1> -I <interface2> -c <file.cache> <file.pcap>


                Améliorer les performance du rejeu:


                echo 524287 >/proc/sys/net/core/wmem_default
                echo 524287 >/proc/sys/net/core/wmem_max
                echo 524287 >/proc/sys/net/core/rmem_max
                echo 524287 >/proc/sys/net/core/rmem_default

	_____________
	$tcprewrite: Permet d'éditer et modifier les pcap.



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ANALYSES ET FILTRES SUR TRAFIC RESEAU (TRAMES/PAQUETS) Performances et statistiques
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    http://www.ubuntugeek.com/bandwidth-monitoring-tools-for-ubuntu-users.html

	_____________
	$wireshark-filter : Permet d'avoir des informations pour effectuer des filtres

	_____________
	$capinfo : Avoir un condenser des informations sur un pcap.


		> capinfo FILE.pcap

	_____________
	$ngrep : Permet d'appliquer des filtres de recherche sur une trace capturée (par exemple avec snoop. Fonctionne de la même manière qu'un grep. Protocoloes normalement supporté: (TCP, UDP, ICMP, PPP, SLIP, FDDI).

		> ngrep -I file.pcap : afficher (sans trier) le contenue du pcap

	_____________
	$tshark : Analyser le trafic réseau


	_____________
        $iptraf-ng : idem que precedement mais encore plus lux !

	_____________
        $cat /sys/class/net/eth3/statistics/* : afficher les statistics sur un port

	_____________
        $cat /proc/net/dev : afficher les stats globaux
        $cat /proc/net/tcp : infos TCP

                Tout /proc/net en général, voir tout les fichiers potentiellement intéréssant pour les mesures

	_____________
        iptables : voir le mémo iptables, il est possible de conter les paquets avec iptables

	_____________
        netstat -i : pour afficher les stats sur toutes les interfaces


        _____________
        $ethstatus - console-based ethernet statistics monitor

         _____________
        $iperf : outils d'analyse et de test de bande passante
        $jperf : iperf en mode graphique (en java)

            http://blog.nicolargo.com/2007/03/tester-la-performance-de-votre-reseau-avec-iperf.html

            utile notament pour tester la QoS, iperf permet de:

                générer du traffic réseau
                Mesurer la bande passante, pertes de paquets ...
                    délai de transit
                    gigue (variation du délai de transit)



         _____________
         $speedometer: Permet de tester les perf de son réseau.

         _____________
         $cacti: Interface Web de monitoring.


        --------------------------
        Bande Passante / bandwidth
        --------------------------

            http://www.binarytides.com/linux-commands-monitor-network/

            _____________
            $nload : voir le traffic entrant et sortant d'un coup d'oeil

                Page up et page-down pour faire défiler les différentes interfaces

            _____________
            $iftop : outils très pratique de mesure de bande passante.

                Assez simpliste mais permet d'avoir un aperçu rapide pour chaque connection.

                Note: ne permet pas d'avor l'ID du process en question mais permet de mettre des filtres ...

                -n : ne pas résoudre les noms

            _____________
            $iptraf : moniteur d'analyse de flux réseau

                    Iptraf permet de voir facilement ce qui se passe sur son interface réseau (en couleur !)

                    Exemple d'utilisation:

                            > sudo iptraf -d eth0 -L ~/testiptraf -B -t 1

                                    -d : donne des stats sur eth0
                                    -L : creer un fichier de log
                                    -B : se lance en arriere plan (pour ne pas voir le moniteur pas exemple)
                                    -t : timeout (durée de l'analyse)

                    Voir man iptraf pour plus de detail. Son utilisation est assez simple et pratique.

            _____________
            $nethogs : une sorte de top like mais pour le réseau (en fonction de la BP)

                Classé par PID et applications.

            _____________
            $bmon : outil de mesure de bande passante avec des statistiques assez poussées.

                Donne des valeurs globales avec des graphiques en mode console.

            _____________
            $slurm : Permet de voir les stats d'un interface avec un graphique coloré en mode ascii.

                > slurm -s -i eth0

            _____________
            $tcptrack : permet de voir toutes les connexions sur une interface et la bande passante utilisée.

                S'appuie sur la lib pcap et peut être utilisé avec des filtres

            _____________
            $vnstat : Daemon tournant en arrière plan pour générer des statistiques sur l'utilisation de la BP.

                #Lancer le service:
                    > service vnstat start|restart|status

                #Afficher les stats:
                    > vnstat

                #Visionner en temps réel:
                    > vnstat -l -i eth0

            _____________
            $bwm-ng : outil de mesure pour apprécier les performances de son réseau en temps réel.

                -I INTERFACE : sélectionner une interface
                -o curses2  : avoir un graphique

                 Le tool se conf simplement de façon interactif (appuyez sur h and look)

            _____________
            $cbm : outil très basic pour visionner la bande passante de ses interfaces en temps réel.

            _____________
            $speedometer : idem avec un graphique

                -r eth0 : en rx
                -t eth0 : en tx

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FORGER UN PAQUET
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	_____________
	$scapy : Permet principalement de forger des paquets, c'est un outils tres puissant et complet.

		En dev: scaperl (à surveiller, pour ceux qui préferent le perl) :p
		Voir aussi du coté de tcprewrite pour modifier les paquet lors de rejeu ...

		Plein d'info:
		http://wiki.spiritofhack.net/index.php/Scapy-usage

		Scapy est aussi scriptable ;)

		paquets utiles:
		>	 sudo apt-get install python2.7 tcpdump graphviz imagemagick python-gnuplot python-crypto python-pyx nmap python-scapy

		Scapy est un outil en python, il faut télécharger le paquet python2.5 (version minimum).

		Installation: (http://www.secdev.org/projects/scapy/doc/installation.html)
			> aptitude install python2.5 python-gnuplot python-crypto python-pyx
			> wget http://www.secdev.org/projects/scapy/files/scapy-latest.zip
			> unzip scapy-latest.zip
			> cd scapy-2.X
			> sudo python setup.py install
			> scapy

		Au prompt :

			Infos utiles:

				> ls() : permet de voir tout les protocoles gérés.
				> ls(PROTOCOLE) : permet de lister tout les champs disponible du protocole (utile pour la conf).

			Créer un paquet:

				On utilise le slash "/" pour insérer les différentes couches pour forger le paquet.

				> layer1 = Ether()
				> layer2 = IP(dst="192.168.1.2", ttl=64)
				> layer3 = Raw('hello its free')
				> packet = layer1 / layer2 / layer3

			Enregistrer un paquet:

				> wrpcap("/path/save.pcap", packet)

			Importer un paquet:

				> rdpcap("/path/pcap")

			Ouvrir un paquet directement avec wireshark

				> wireshark(packet)



	_____________
	$hping3 : Idem que scapy mais simplifié. Outil en ligne de commande.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BROWSER
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	_____________
	links : Navigateur internet en console !

		Vraiment très pratique !

		Quelque raccourcis:

			g : lancer une requête
			ESCP : Afficher le menu
			q : quitter


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GRAPH
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Cette partie n'est pas vraiment dédié seulement au réseau.
	TODO : tuto sur rddtool (génération de graphs)
	http://oss.oetiker.ch/rrdtool/

	voir cacti aussi

~~~~~~~~~~~~~~~~~~~~~~~~~~
subtitle 1
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        subtitle 2
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
