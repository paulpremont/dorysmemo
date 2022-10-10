I P T A B L E S
==============================

What is it ?
-----------------------------

Iptables est l'outil de référence de gestion de firewall sous Linux.  
C'est une interface à NetFilter.

Links
-----------------------------

### Official

* [NetFilter](http://www.netfilter.org/)

### Tutos

* [Guide OVH](http://guides.ovh.com/FireWall)
* [DDoS Protection](https://javapipe.com/blog/iptables-ddos-protection/)

How it works ?
-----------------------------

    man iptables

Iptables fonctionne de paire avec netfilter et permet de définir de façon structuré les règles liées aux traitement du flux réseau.  
Netfilter quand à lui définie une structure en chaine au niveau de la pile réseau.  
Il autorise les modules noyau à éxécuter des fonctions de rappel sur ces chaînes pour chaque paquet qui y transite. (Nos règles de filtrages)  
Ces 2 softs font patie intégrante du même framework (d'autres en font partie).


### Les tables

		___________________
		FILTER: Filtre les paquets, il contient 3 chaînes:

			-INPUT: paquets arrivant sur l'hôte
			-OUTPUT: paquets sortant de l'hôte
			-FORWARD: paquets redirigés sur une autre interface

		___________________
		NAT: sert à la translation d'IP, contient 3 chaînes:
		(NAT = Network Address Translation : consiste à modifier un paquet pour changer l'adresse IP source)

			-PREROUTING: traite les paquets arrivant de l'extérieur avant d'être routés.
			-POSTROUTING: traite les paquets après la décision de routage, avant que les paquets ne soients envoyés.
			-OUTPUT: même principe que PREROUTING mais pour les paquets générés par le localhost

		___________________
		MANGLE: sert à modifier les paquet (notion de QoS), comporte 2 chaînes:
		(QoS = Quality Of service, consiste à donner des priorités en bande passante pour certain flux)

			-PREROUTING: permet de modifier les paquets avant d'être routés.
			-OUTPUT: permet de modifier les paquets avant leur re-routage vers leur destination


		Chacune de ces chaînes (INPUT, OUTPUT, FORWARD) peuvent donner plusieurs réponses possibles pour chaque paquet:

			ACCEPT: le paquet est accepté
			DROP: le paquet est supprimé (on ne précient pas l'expéditeur)
			REJECT: le paquet est supprimé (mais on prévient l'expéditeur)
			LOG: permet de loguer sans supprimer le paquet

		Chaque chaîne possède une police par défaut "policy" qui définit l'action par défaut appliquée sur les paquets.

### Schéma

```

                    Paquets entrant sur le noeud
                             |
                             v
                             |
                     P R E R O U T I N G
                             |  (Règles appliquées avant le routage du paquet)
                             v
                           ROUTING
                             |	(Applique la décision de routage)
                     ________|_______
                    |               |
                    |	              |
                    v 	            |
                 I N P U T          |
    (flux à destination de l'hôte)  |
                    |	              |
                    |            F O R W A R D
                    v	              | (Pour la redirection de paquet)
                 Système 	          | (Fonction de routage)
               (local process)      |
                    |	              |
                    v	              |
                 O U T P U T        |
                  (flux sortant)    |
                    |	              |
                    v               v
                    P O S T R O U T I N G
                      | (Règles appliquées après le routage du paquet)
                      |
                      v Paquets qui sortent du noeud

```

### Les Options

        ----------------
        Informations - Listing :
        ----------------

                -nvL --line-numbers     : lister les règles (sauf NAT)
                -t nat -L -n -v         : affiche les règles de nat (non visibles par défaut)
                -L                      : liste des règles
                -n                      : supprimer la résolution de nom
                --line-numbers          : affiche les numéros des règles (L'ordre est important)
                -v                      : rajoute le mode verbeux

                Avec le tool "netstat-nat" il est aussi possible de voir la table de NAT

                > netstat-nat -n        #Afficher les connexions nattées
                > netstat-nat -S        #SNAT
                > netstat-nat -D        #DNAT


                Voir aussi ce fichier pour avoir une traces des connexions:
                        > cat /proc/net/ip_conntrack | less

        ----------------
        Opérations sur les règles:
        ----------------

                -F <chain>              : initialise toutes les règles de la chaine indiquée
                -A <chain>              : ajoute une règle en fin de liste pour la "chain" indiquée
                -D <chain> <rulenum>    : supprime la règle (indiquer son N°)
                -l <chain> <rulenum>    : insère la règle au N° indiqué (laissé vide = placé tout en haut)
                -R <chain> <rulenum>    : remplacer une règle
                -P <chain> <regle>      : modifie la règle par défaut pour la chain.
                -X <chain>              : supprimer une chaine
                -N chain                : ajouter une chaine

                exemples:

                        Suppression d'une règle:

                        >	iptables -D INPUT -s 192.168.5.5 -j DROP
                        >	iptables -D INPUT 12


        ----------------
        Opérations sur IP/ports
        ----------------

                -s      : selection IP source
                -d      : selection IP destination
                --dport : port de destination    (Necessite -p)
                --sport : port source            (Necessite -p)
                -p      : protocole
                -i      : interface d'entrée
                -o      : interface de sortie

	        Range de ports:

                         --source-port|sport port:port
                         --destination-port|dport port:port

                Plusieurs ports:

                        -m multiport --dports XX,YY

                Range d'IPs:

                        -m iprange --src-range @IP-@IP
                        -m iprange --dst-range @IP-@IP

                Dans une règle de NAT:

                        --to-source|--to-destination @IP-@IP

                        Avec un range de port:

                        --to-source @IP:port-port

            L'opérateur not: '!'

                Exemple:

                    -s ! MON_IP

### Les états

* [connection-state](http://www.iptables.info/en/connection-state.html)

            -m conntrack                            #Appel du module gérant le cache de connexion.
            --ctstate RELATED,ESTABLISHED,NEW ...   #Référence à l'état de la connexion.

            exemples:

                #Permettre à une connexion déja ouverte de recevoir du traffic
                iptables -A INPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

                #Pour les anciennes versions:
                iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT

            RELATED:        connexion liée à une autre session (ESTABLISHED)
            ESTABLISHED:    connexion établie (Réponse SYN/ACK)
            NEW :           nouvelle demande de connexion (Envoie d'un paquet SYN)
            INVALID:        paquet non identifié, aucun état connu.

            voir : http://www.inetdoc.net/guides/iptables-tutorial/tcpconnections.html
                http://linux.developpez.com/iptables/?page=machine-etat

        ----------------
        Les logs
        ----------------

            http://www.inetdoc.net/guides/iptables-tutorial/logtarget.html
            http://www.thegeekstuff.com/2012/08/iptables-log-packets/

            En créant sa chaine:

                Paquets entrants droppés:

                    iptables -N LOGGING
                    iptables -A INPUT -j LOGGING
                    iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
                    iptables -A LOGGING -j DROP

                Paquets sortants droppés:
                    iptables -N LOGGING
                    iptables -A OUTPUT -j LOGGING
                    iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
                    iptables -A LOGGING -j DROP


                Tout les paquets droppés:
                    iptables -N LOGGING
                    iptables -A INPUT -j LOGGING
                    iptables -A OUTPUT -j LOGGING
                    iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
                    iptables -A LOGGING -j DROP
        ----------------
        Filtre utilisateurs
        ----------------

            Pour autoriser/interdir certain utilisateur,
            on utilise le module uid-owner:

            Exemple:
                iptables -A OUTPUT -p tcp -m multiport --dport 80,443 -m owner --uid-owner monUser -j ACCEPT

        ----------------
        Pour renseigner à la foi udp et tcp:
        ----------------

            iptables -N ACCEPT_TCP_UDP
            iptables -A ACCEPT_TCP_UDP -p tcp -j ACCEPT
            iptables -A ACCEPT_TCP_UDP -p udp -j ACCEPT

            iptables -A ma_chaine -d 1.2.3.0/24 -j ACCEPT_TCP_UDP

            ou si il n'y a pas de port spécifié, il suffit d'enlever l'option -p

### NAT

* [NAT HOWTO](http://www.netfilter.org/documentation/HOWTO/NAT-HOWTO-6.html)

Ou comment modifier l'IP source/destination ou de port source/destination avant ou après routage.

!!! note 
    Fonctionne sur TCP/UDP uniquement.

#### Destination NAT (DNAT)

Avant la décision de routage (PREROUTING).
On l'utilise par exemple pour rediriger du flux venant de l'extérieur vers une IP local de son réseau.

Client Externe --> Firewall publique/privée --> Serveur privée

On change les infos du destinataire (IP et/ou port de destination) :

    # Change destination addresses to 5.6.7.8
    iptables -t nat -A PREROUTING -i eth0 -j DNAT --to 5.6.7.8

    # Change destination addresses to 5.6.7.8, 5.6.7.9 or 5.6.7.10.
    iptables -t nat -A PREROUTING -i eth0 -j DNAT --to 5.6.7.8-5.6.7.10

    # Change destination addresses of web traffic to 5.6.7.8, port 8080.
    iptables -t nat -A PREROUTING -p tcp --dport 80 -i eth0 -j DNAT --to 5.6.7.8:8080

#### Source NAT (SNAT)

Après le routage (POSTROUTING).
Juste avant d'envoyer le paquet, on peut changer la source du paquet pour que la réponse soit envoyer à une autre IP.

Client privée --> Firewall privée/publique --> Serveur Publique

    # Change source addresses to 1.2.3.4.
    iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to 1.2.3.4

    # Change source addresses to 1.2.3.4 or 1.2.3.5 or 1.2.3.6
    iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to 1.2.3.4-1.2.3.6

    # Change source addresses to 1.2.3.4, ports 1-1023
    iptables -t nat -A POSTROUTING -p tcp -o eth0 -j SNAT --to 1.2.3.4:1-1023

#### Masquerade

Masquerade est un raccourci pour la chaîne de POSTROUTING.  
Il a été crée pour fonctionner avec les IP DHCP et ne nécessite pas de spécifier l'IP source à NATer.  
Le but étant que toutes les adresses privées d'un réseau utilise la même ip publique pour sortir vers l'éxtérieur.

    #Nater un réseau privée
    iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j MASQUERADE

    #Nater directement ce qui arrive sur une interface en direction d'un autre réseau avec eth1 l'interface wan.
    iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

Activer le routage et le NAT simplement sur sa machine (avec eth0 l'interface ayant accès au net):

    echo 1 > /proc/sys/net/ipv4/ip_forward
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

Ne pas oublier d'ajouter la route sur l'hôte utilisant la gw :

    route add default gw IP_ROUTER


### Purger ses règles

    #Accepter toutes les connexions (-P : Policy)
    iptables -P INPUT ACCEPT
    iptables -P FORWARD ACCEPT
    iptables -P OUTPUT ACCEPT

    #Supprimer les règles (-F) et chaînes (-X) custom.
    iptables -F
    iptables -X
    iptables -t nat -F
    iptables -t nat -X
    iptables -t mangle -F
    iptables -t mangle -X
    iptables -t raw -F
    iptables -t raw -X

Manipulations
-----------------------------

### TODO : trier le how to et les manips, tout reconvertir en mkdown

### Exemple

	#================
	# INIT
	#================

	iptables -F <chain> 		#(INPUT,OUTPUT,FORWARD)
	iptables -t nat -F <chain>	#(POSTROUTING,PREROUTING)

	#================
	# POLICY
	#================

	iptables -P <chain> <rule>	#(DROP,ACCEPT ...)

	#================
	# NAT (ROUTING)
	#================

		-s $IP : correspond à la source d'orgine
		-d $IP : corresponf à la destination d'origine
		--to-source : correspond à la source apres translation
		--to-destination : correspond à la destination après translation

		#================
		# PREROUTING (avant le routage)
		#================

		#________________
		#port

		iptables -t nat -A PREROUTING -j DNAT -p tcp --dport XX --to-destination <IP>

			# -t : utiliser la table "nat"
			# -A : ajouter une règle à la chaine "PREROUTING"
			# -j : spécifie quoi faire du paquet (cible de la règle) DNAT (Destination NAT)
			# -p : protcole tcp (ou udp)
			# --dport : port de destination
			# --to-destination : Hôte de destination

			# Cette commande redirigera les paquets tcp à destination du port XX sur l'hôte correspondant à l'IP.

			# Pour indiquer un range de port:
				--dport portA:portY

		#________________
		#IP

            iptables -t nat -A PREROUTING -d <IP> -j DNAT --to-destination <IP>

			# même princique que précédement mais en fonction d'une IP au lieu d'un port

		#================
		# OUTPUT
		#================

        iptables -t nat -A OUTPUT -d <IP> -j DNAT --to-destination <IP>

		#================
		# POSTROUTING (après le routage)
		#================

		iptables -t nat -A POSTROUTING -s <IP/MASK> -j SNAT --to-source <IP>
		ou

		iptables -t nat -A POSTROUTING -o <interface_output> -s <IP/MASK> -j MASQUERADE

			# Ces deux commandes auront pour effet de translater l'adresse source de l'option -s en une autre adresse source (option --to-source ou l'ip de l'interface output pour le cas du MASQUERADE)

	#================
	# FILTER
	#================

		#================
		# INPUT
		#================

		#dhcp
		iptables -A INPUT -p udp --dport 67 -j ACCEPT

		#loopback
		iptables -A INPUT -i lo -j ACCEPT

		#ssh
		iptables -A INPUT -p tcp --dport ssh -j ACCEPT

        #Pour un réseau ou un IP seulement :
        iptables -A INPUT -p tcp --dport ssh -s 10.1.0.0/16 -j ACCEPT


		#================
		# OUTPUT
		#================

		#dhcp
		iptables -A OUTPUT -p udp --dport 68 -j ACCEPT

		#loopback
		iptables -A OUTPUT -o lo -j ACCEPT

		#ssh
		iptables -A OUTPUT -p tcp --sport ssh -j ACCEPT

        #Pour un réseau ou un IP seulement :
        iptables -A INPUT -p tcp --sport ssh -d 10.1.0.0/16 -j ACCEPT

		#================
		# FORWARD
		#================

		#enable forwarding:
		echo 1 > /proc/sys/net/ipv4/ip_forward

		#http:
		iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
		iptables -A FORWARD -p tcp --sport 80 -j ACCEPT

        #________________
        #garder les connexions établies:

                iptables -A <chain> -m state --state RELATED,ESTABLISHED -j ACCEPT


### Activation de modules:

module de gestion du filtrage de paquets:
    modprobe netfilter_dev

module d'intéraction entre filtrage et iptables:
    modprobe iptables

module gérant la table d'états des connexions:
    modprobe ipt_state

module gérant les connexions TCP:
    modprobe ipt_tcp

idem mais pour udp:
    modprobe ipt_udp

idem mais pour les logs:
    modprobe ipt_LOG

module gérant le réassemblage des paquets fragmentés:
    modprobe ipt_defrag

module gérant la mise en mémoire des demandes de connexions:
    modprobe ip_conntrack

idem mais pour le ftp
    modprobe ip_conntrack_ftp

module gérant la table nat:
    modprobe ip_nat

idem mais pour le ftp
    modprobe ip_nat_ftp


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Organiser ses règles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

iptables -N <chainName>

Ainsi on creer un chaine avec le nom que l'on veut.
Il faudra ensuite lors de la création d'une règle mettre -j <chainName>


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Appliquer les règles au démarrage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    ## Via un script init :

        > vim /etc/init.d/myiptables

        -->	#!/bin/bash

                 <Inscrire les commandes iptables que l'on souhaite>

                 exit 0

        Pour faire un script propre, utilisez case:

                case "$1" in
                start)
                        # My rules
                exit 0
                ;;

                stop)
                        # Flush rules
                exit 0
                ;;
                *)
                echo "Usage: /etc/init.d/iptables_script {start|stop}"
                exit 1
                ;;
                esac

        Pour l'activer sous Debian :

            > chmod +x /etc/init.d/myiptables
            > update-rc.d myiptables defaults

        Pour l'activer sous Redhat :

            > chkconfig --level 3 iptables_script on
            > chkconfig --level 6 iptables_script off


    ## Debian, via le fichier des interfaces réseaux :

        IL est aussi possible d'enregistrer les règles courante:

            > iptables-save >  iptables.rules

        Et rajouter pre-up dans la conf des interfaces

            > vim /etc/network/interfaces
                eth0 ...
                pre-up iptables-restore < iptables.rules

    ## Via le service (Fonctionne sous redhat) :

        https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/3/html/Reference_Guide/s1-iptables-saving.html

        > /sbin/service iptables save

        Ce qui a pour effet de sauvegarder les règles courantes dans /etc/sysconfig/iptables

        Restauré au reboot ensuite par /sbin/iptables-restore


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Méthode de count des paquets
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        > iptables -I OUTPUT -o eth0
        > iptables -I INPUT -i eth0

        > iptables -L -vxn (-Z pour reset les compteurs)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Exemple de script:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        #!/bin/bash

        #----------------- DEFAULT ------------------------

        cmd='iptables'

        #hosts
        host='Y.Y.Y.Y'
        proxy=''
        irc=''
        dns=''

        #Network
        dmz='X.X.X.X/24'
        labs='.../24'
        lan='.../24'

        #interfaces
        iwan='vmbrX'
        idmz='vmbrX'
        ilan='vmbrX'
        ilabs='vmbrX'


        echo "setting [$cmd] rules"

        #----------------- POLICY ------------------------
        echo 'init'

        $cmd -F INPUT
        $cmd -F OUTPUT
        $cmd -F FORWARD

        $cmd -t nat -F PREROUTING
        $cmd -t nat -F POSTROUTING

        #POLICY
        echo 'policy'

        $cmd -P INPUT DROP
        $cmd -P OUTPUT DROP
        $cmd -P FORWARD DROP

        #----------------- FILTER ------------------------

        echo 'filter'

            echo 'loopback'
            $cmd -A INPUT -i lo -j ACCEPT
            $cmd -A OUTPUT -o lo -j ACCEPT

            echo 'ssh'
            $cmd -A INPUT -p tcp --dport ssh -j ACCEPT
            $cmd -A OUTPUT -p tcp --sport ssh -j ACCEPT
            $cmd -A OUTPUT -p tcp --dport ssh -j ACCEPT

            echo 'icmp'
            $cmd -A INPUT -p icmp -j ACCEPT
            $cmd -A OUTPUT -p icmp -j ACCEPT

            echo 'web'
            $cmd -A INPUT -p tcp --dport 80 -j ACCEPT
            $cmd -A INPUT -p tcp --dport 443 -j ACCEPT
            $cmd -A OUTPUT -p tcp --dport 80 -j ACCEPT
            $cmd -A OUTPUT -p tcp --sport 80 -j ACCEPT
            $cmd -A OUTPUT -p tcp --dport 443 -j ACCEPT
            $cmd -A OUTPUT -p tcp --sport 443 -j ACCEPT

            echo 'dns'
            $cmd -A OUTPUT -p udp --dport 53 -j ACCEPT

            echo 'git'
            $cmd -A OUTPUT -p tcp --dport 9418 -j ACCEPT

            echo 'mail'
            $cmd -A OUTPUT -p tcp --sport 110 -j ACCEPT #pop
            $cmd -A OUTPUT -p tcp --dport 25 -j ACCEPT #smtp
            $cmd -A OUTPUT -p tcp --dport 587 -j ACCEPT #smtp
            $cmd -A OUTPUT -p tcp --dport 465 -j ACCEPT #smtps

            #KEEP CONNECTION
            echo 'keep connection'

            $cmd -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
            #$cmd -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

        #----------------- FORWARD ------------------------
        echo 1 > /proc/sys/net/ipv4/ip_forward

            echo 'Forwarding'

            #labs | wan

            $cmd -A FORWARD -s $labs -i $ilabs -o $iwan -j ACCEPT
            $cmd -A FORWARD -i $iwan -o $ilabs -d $labs -j ACCEPT

            #dmz | lan

            $cmd -A FORWARD -s $lan -d $dmz -j ACCEPT
            $cmd -A FORWARD -s $dmz -d $lan -j ACCEPT

            #dns
            $cmd -A FORWARD -s $dns/32 -p udp --dport 53 -i $ilan -o $iwan -j ACCEPT
            $cmd -A FORWARD -i $iwan -o $ilan -d $dns/32 -j ACCEPT

            #dmz | wan

            $cmd -A FORWARD -s $dmz -i $idmz -o $iwan -j ACCEPT
            $cmd -A FORWARD -i $iwan -o $idmz -d $dmz -j ACCEPT

        #----------------- ROUTING / NAT ------------------------

            #Routing DMZ TO WAN (from vmbrX)

            $cmd -t nat -A POSTROUTING -s $dmz -o $iwan -j MASQUERADE

            #DNS (id only in lan)

            $cmd -t nat -A POSTROUTING -s $dns/32 -p udp --dport 53 -o $iwan -j MASQUERADE

            #Routing LABS TO WAN (from vmbrX)

            $cmd -t nat -A POSTROUTING -s $labs -o $iwan -j MASQUERADE

            #Routing LAN TO WAN (from vmbrX)

            $cmd -t nat -A PREROUTING -j DNAT -p tcp -s $lan --dport 80 --to $proxy:3128
            $cmd -t nat -A PREROUTING -j DNAT -p tcp -s $lan --dport 443 --to $proxy:3128


            #Routing WAN TO DMZ (from vmbrX)

            $cmd -t nat -A PREROUTING -j DNAT -p tcp -d $host --dport 80 --to-destination $proxy
            $cmd -t nat -A PREROUTING -j DNAT -p tcp -d $host --dport 443 --to-destination $proxy

        #----------------- DUMP CONF ------------------------

        $cmd -nvL --line-numbers
        $cmd -nvL --line-numbers -t nat

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Changer le flux à la volée
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Changer le champs DSCP:

        iptables -t mangle -A OUTPUT -p tcp -j DSCP --set-dscp 56

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Protection basique :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    N'autoriser que les demandes de connexion venant de sont hôte vers l'extérieur.
    On drop tout par défaut.
    On n'autorise que les connexions qui sont en relation avec une demande de son hôte.

    Default iptables :

  # Generated by iptables-save
  *filter
  :INPUT DROP [40:6428]
  :FORWARD DROP [0:0]
  :OUTPUT DROP [4:852]
  -A INPUT -i lo -j ACCEPT
  -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
  -A OUTPUT -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
  -A OUTPUT -o lo -j ACCEPT
  COMMIT


    Pour l'appliquer :

        > iptables-restore monFichier

    Une manière simple de l'appliquer de manière permanente :

  - via l'installation du paquet iptables-persistent

  ou en lançant le script au démarrage (avec systemd par exemple).

## iptables-legacy

Depuis les dernières versions d'ubuntu, au moins à partir de la 21.10

Le firewall installé est ufw. C'est une surcouche simplifiée mais ne permettant pas de faire du firewalling avancé.
Sinon nftables a remplacé iptables (via la commande iptables) et l'ancien iptables est paramétrable via iptables-legacy.

Pour passer à nftables, voici une possibilité

Lien : https://www.liquidweb.com/kb/how-to-install-nftables-in-ubuntu/

```
iptables-restore-translate -f iptables-rules.txt > iptables-nft.rules

```
