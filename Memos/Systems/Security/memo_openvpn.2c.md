==========================================================
                       O P E N V P N
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Documentation:

        http://openvpn.net/index.php/open-source/documentation/howto.html#vpntype
        http://openvpn.net/index.php/open-source/documentation/miscellaneous/77-rsa-key-management.html
        http://openvpn.net/index.php/open-source/documentation/howto.html
        http://searchsecurity.techtarget.com/feature/Tunnel-vision-Choosing-a-VPN-SSL-VPN-vs-IPSec-VPN
        https://www.bestvpn.com/blog/4147/pptp-vs-l2tp-vs-openvpn-vs-sstp-vs-ikev2/

    Tutos:

        http://doc.ubuntu-fr.org/openvpn
        http://www.drazzib.com/docs:admin:openvpn
        http://www.linux-france.org/prj/edu/archinet/systeme/ch24s03.html
        http://blog.nicolargo.com/2010/10/installation-dun-serveur-openvpn-sous-debianubuntu.html
        http://15minutesoffame.be/nico/blog2/?article16/creer-un-serveur-openvpn
        https://community.openvpn.net/openvpn/wiki/BridgingAndRouting
        http://www.bgconsultant.net/wiki/?page=OpenVPN
        http://openmaniak.com/fr/openvpn.php

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Un système de VPN permetant de chiffrer les paquets entre deux noeuds.
    Idéal pour la joinction de clients vers un réseau d'entreprise.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Protocols
        --------------------------

            Les VPN actuels offres plusieurs méthodes de chiffrement et d'authentification. Le principal étant IPsec.

            Ils sont évalués sur des critères tels que :

                * Le niveau de chiffrement 
                * L'authentification
                * L'intégrité des données
                * Les Débits garanties 
                * La compatibilité entre plateforme/OS

                __________________________
                SSL/TLS (utilisé par OpenVPN) :

                    Agit au niveau des couches hautes (couche 4.5)

                    1 Négociation, protocoles à utiliser pendant le transfert
                    2 Partage des clés
                    3 Alert (messages d'erreurs si nécessaire)
                    4 Record (transfert des données chiffrées via la clé paratgée)

                    Pour l'utilisation en mode VPN, on chiffre tout le paquet et on le réencapsule.

                __________________________
                IPsec :

                    IPsec est un standard englobant plusieurs protocoles (IKE, AH, ESP)
                    Il intervient au niveau de la couche 3 ce qui le rend indépendant des couches applicatives.

                    Etapes :

                        1 : Échange de clés :
                            - ISAKMP (Internet Security Association and Key Management Protocol)
                        2 : Authentification :
                            - PSK ou certificats

                        3 : Association de sécurité (SA) :
                            - Information de sécurité partagée pour maintenir la communication.
                            
                        4 : Transfert de données :
                            - AH (Authentication Header) pour l'intégrité et l'authentification.
                            - ESP (Encapsulating Security Payload), fournit la confidentialité (le chiffrement).

                    Modes de fonctionnement :

                        mode transport :

                            Seule la partie payload est chiffrée, le routage reste inchangé
                            Nécessite l'utilisation de NAT-T dans le cas où l'on utilise du NAT pour sortir vers l'extérieure et ne pas corrompre le hash d'en tête (AH)
                            Utilisé pour les communication d'hôte à hôte.

                        mode tunnel :

                            Tout le paquet IP est chiffré et réencapsulé dans un nouveau paquet IP. C'est, finalement ce mode qu'on emploira pour le VPN.

                    Algos de chiffrement :

                        HMAC-SHA1-96
                        AEC-CBC
                        Triple DES-CBC

                __________________________
                L2TP/IPsec :

                    C'est un protocol avancé pour le tunneling fournissant une double encapsulation.
                    Il utilise Ipsec pour la partie chiffrement et authentification.
                    Aproprié plutôt pour faire du client to network avec login.


                __________________________
                PPTP :

                    C'est en extension du protocole PPP à l'époque crée par un consortium lui même fondé par Microsoft.
                    Il opère sur la couche 2 du modèle OSI.
                    Par défaut PPTP n'offre pas de chiffrement.
                    Il faut alors se tourner vers MPPE utilisant du RSA RCQ 128 bits.

                    Niveau de sécurité assez faible mais rapide.
                    Port par défaut : 1723

                __________________________
                SSTP :

                    S'appuie sur SSL pour la transmission chiffrée de données.
                    Pour les connexions, il utilisera PPP ou L2TP.

        --------------------------
        Main Features
        --------------------------

            OpenVpn permet de :

                * Tunneliser des sous-réseaux IP ou une carte réseau Ethernet virtuelle sur un port UDP ou TCP.

                * Utilise OpenSSL pour la partie chiffrement, authentification et certificats.

                * Choisir entre clés statiques ou clés publiques issus du mécanisme de certificats.

                * D'échanger des clés via TLS.

                * De créer des Tunnels orientés connexion, (stateful) sans utiliser de règles spécifiques au niveau du Firewall.

                * Possibilité d'utiliser une interface NAT

                * Création de ponts Ethernet via des interfaces TAP

        --------------------------
        Fonctionnement
        --------------------------

            OpenVPN s'appuie essentiellement sur OpenSSl pour la partie Authentification et Chiffrement. Attention donc de ne pas le confondre avec un VPN IPsec ou PPTP.

            L'avantage d'utiliser OpenSSl, est la portabilité, la facilité de configuration et la compatibilité avec du NAT ou des adresses dynamiques.

            Attention aussi à ne pas confondre avec les VPN SSL qui sont plus orientés web.

            Le modèle de sécurité d'OpenVPN est basé sur SSL/TLS pour l'authentifcation des sessions et ESP d'IPsec pour sécuriser les tunnel over UDP. Il Supporte le système de certificat X509 PKI pour l'authentification, TLS pour l'échange de clés, OpenSSL pour le chiffrement.

        --------------------------
        SSl requirements
        --------------------------

            Requirements :

                PKI:

                    Un clé pub pour le serveur
                    Une clé priv pour chaque user
                    Un CA et des clés pour signer et identifier chaque certif client et serveur

                Le client doit authentifier le certif serveur et vis versa.

                    -Le serveur n'a besoin que de ses propres certificats/clés.
                    -Le serveur n'accepte que les clients dont le certif est signé par le CA
                    -Si une clé privée est compromise, il faut l'ajouter au CRL (Liste de revocation)

        --------------------------
        Interfaces virtuelles
        --------------------------

            Le VPN créer une interface virtuelle faisant office de porte vers la connexion chiffrée. Tout les paquets transitant sur cette interface sont acheminés de façon cryptée jusqu'au serveur (ou client).

            Communément appelée tunX, tapX (tun0 ...)

        --------------------------
        Layout
        --------------------------
            
                __________________________
                openvpn sur la gateway

                         +--------------------------------+
                         |            FIREWALL            |
              (public IP)|                                |192.168.0.1
 {INTERNET}=============={eth1                        eth0}=============<internal network / 192.168.0.0/24>
                         |   \                        /   |
                         |    +----------------------+    |
                         |    | iptables and         |    |
                         |    | routing engine       |    |
                         |    +--+----------------+--+    |
                         |       |*1              |*2     |
                         |     (openvpn)-------{tun0}     |
                         |                    10.8.0.1    |
                         +--------------------------------+

   *1 Only encrypted traffic will pass here, over UDP or TCP and only to the remote OpenVPN client
   *2 The unencrypted traffic will pass here.  This is the exit/entry point for the VPN tunnel.

    Exemple de règles appliquées à ce schéma:

            # Allow traffic initiated from VPN to access LAN
            iptables -I FORWARD -i tun0 -o eth0 \
                 -s 10.8.0.0/24 -d 192.168.0.0/24 \
                 -m conntrack --ctstate NEW -j ACCEPT

            # Allow traffic initiated from VPN to access "the world"
            iptables -I FORWARD -i tun0 -o eth1 \
                 -s 10.8.0.0/24 -m conntrack --ctstate NEW -j ACCEPT

            # Allow traffic initiated from LAN to access "the world"
            iptables -I FORWARD -i eth0 -o eth1 \
                 -s 192.168.0.0/24 -m conntrack --ctstate NEW -j ACCEPT

            # Allow established traffic to pass back and forth
            iptables -I FORWARD -m conntrack --ctstate RELATED,ESTABLISHED \
                 -j ACCEPT

            # Notice that -I is used, so when listing it (iptables -vxnL) it
            # will be reversed.  This is intentional in this demonstration.

            # Masquerade traffic from VPN to "the world" -- done in the nat table
            iptables -t nat -I POSTROUTING -o eth1 \
                  -s 10.8.0.0/24 -j MASQUERADE

            # Masquerade traffic from LAN to "the world"
            iptables -t nat -I POSTROUTING -o eth1 \
                  -s 192.168.0.0/24 -j MASQUERADE

                __________________________
                openvpn ailleurs que sur la gateway:

                          +-------------------------+
               (public IP)|                         |
  {INTERNET}=============={     Router              |
                          |                         |
                          |         LAN switch      |
                          +------------+------------+
                                       | (192.168.0.1)
                                       |
                                       |              +-----------------------+
                                       |              |                       |
                                       |              |        OpenVPN        |  eth0: 192.168.0.10/24
                                       +--------------{eth0    server         |  tun0: 10.8.0.1/24
                                       |              |                       |
                                       |              |           {tun0}      |
                                       |              +-----------------------+
                                       |
                              +--------+-----------+
                              |                    |
                              |  Other LAN clients |
                              |                    |
                              |   192.168.0.0/24   |
                              |   (internal net)   |
                              +--------------------+


   Au niveau du routeur:
        route add -net 10.8.0.0/24 gw 192.168.0.10

        En plus du nat et de l'autorisation du forwarding du vpn vers un autre sous-réseau.

   Au niveau du serveur:
        On active simplement le routage:

            sysctl -w net.ipv4.ip_forward=1

            ou vim /etc/sysctl.conf
                  net.ipv4.ip_forward = 1

            Note pour le routage, lorsqu'on utilise openvpn comme passerelle de routage, il faut penser à NAT la sortie:

                > iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE

        --------------------------
        Modes de fonctionnement
        --------------------------
                __________________________
                Bridge (VPN Ethernet) :

                    Si l'on souhaite mettre en relation des réseaux entre eux.
                    Faire un pont ethernet entre deux réseau.

                    Lie l'interface VPN et LAN.

                    -Necessite d'être en mode TAP.
                        Le TAP permet l'envoie de trames directement (layer 2)

                        TAP = interface ethernet virtuelle

                    -Pour être dans le même domaine de broadcast.
                    -Accéder directement au serveur DHCP ...

                __________________________
                Routing (VPN IP) :

                    Si l'on souhaite lier des machines entres elles.

                    -Fonctionne en mode TUN (layer 3) et TAP

                        TUN = Point d'accès point à point

                    -Transporte uniquement les paquets à l'attention du client concerné.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install openvpn


~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Création des clés via les scripts fournis par openvpn
        --------------------------

                Note: les clés sont par défaut crées dans keys.

                __________________________
                1) Importation des scripts (s'appuient sur openssl)

                    > mkdir /etc/openvpn/easy-rsa 
                    > cp -r /usr/share/doc/openvpn/examples/easy-rsa/2.0 /etc/openvpn/easy-rsa

                __________________________
                2) Variables d'environnements pour la création des certifs

                    > vim /etc/openvpn/easy-rsa/vars
                        
                        export KEY_COUNTRY="FR"           
                        export KEY_PROVINCE="ile de france"
                        export KEY_CITY="paris"           
                        export KEY_ORG="yourcorporation"  
                        export KEY_EMAIL="admin@my_domain.fr"

                    > source ./vars

                    voici un exemple complet de vars après génération de la ca:

                        export EASY_RSA="`pwd`"
                        export OPENSSL="openssl"
                        export PKCS11TOOL="pkcs11-tool"
                        export GREP="grep"
                        export KEY_CONFIG=`$EASY_RSA/whichopensslcnf $EASY_RSA`
                        export KEY_DIR="$EASY_RSA/keys"
                        export PKCS11_MODULE_PATH="dummy"
                        export PKCS11_PIN="dummy"
                        export KEY_SIZE=1024
                        export CA_EXPIRE=3650
                        export KEY_EXPIRE=3650
                        export KEY_COUNTRY="FR"
                        export KEY_PROVINCE="Ile de france"
                        export KEY_CITY="Paris"
                        export KEY_ORG="COMPANY_NAME"
                        export KEY_EMAIL="admin@DOMAINE"
                        export KEY_EMAIL=mail@host.domain
                        export KEY_CN=changeme
                        export KEY_NAME=changeme
                        export KEY_OU=changeme
                        export PKCS11_MODULE_PATH=changeme
                        export PKCS11_PIN=1234

                __________________________
                3) Génération des clés:

                    (Necessite de sourcer vars)

                        CA
                        ``````````````````````````

                            > ./clean-all
                            > ./build-ca

                        Serveur
                        ``````````````````````````

                            > ./build-key-server $(hostname)

                        Client
                        ``````````````````````````

                            > ./build-key NOM_CLIENT 
                            ou
                            > ./build-key-pass CLIENT #Avec mot de passe


                            On pourrait aussi créer les certifs coté client:

                                Client:

                                -On génère sa clé privé:
                                
                                    > openssl genrsa 1024 > $(hostname).key
                                
                                -On créer la demande crt:

                                    > openssl req -new -key $(hostname).key > $(hostname).csr

                                -On envoie le csr au serveur ca (méthode de votre choix)

                                    > scp $(hostname).csr monserver:csr   (Copiez le dans /etc/openvpn/easy-rsa/keys)		
                                
                                Serveur:

                                -On signe la demande avec le ca (coté serveur)

                                    > ./sign-req HOSTNAME_DU_CSR (que nous appelerons par la suite CLIENT)
                                    Le nouveau fichier correspondant au nom du csr est dumpé dans keys/CLIENT.crt

                                -On envoie le certif signé (par la méthode de son choix)
                                
                                    Le mieux je pense pour l'automatisation et pour la simplification,
                                    C'est d'envoyer le crt via un serveur smtp (en smtps de préférence)
                                
                                    Voici un exemple avec le tools msmtp pour avoir une petite idée mais là c'est un peu sal :-):

                                        > apt-get install msmtp sharutils
                                        > vim ~/.msmtprc
                                            account default
                                            tls on
                                            host smtp.gmail.com
                                            port 587
                                            from YOUR_NAME@gmail.com
                                            auth on
                                            user YOUR_NAME@gmail.com
                                            password YOUR_PASSWORD
                                            tls_starttls on
                                            tls_certcheck on
                                            tls_trust_file /etc/ssl/certs/ca-certificates.crt

                                        > chmod 600 ~/.msmtprc
                                    
                                        > clientmail=$(openssl req -noout -text -in CLIENT.csr |grep mail |cut -d= -f7)
                                        > (echo "Subject:CRT" && cat CLIENT.crt) |msmtp $clientmail

                                L'utilisateur recevra son certficat signé :-) !

                __________________________
                4) Durcir la sécurité:

                        Diffie-Hellman
                        ``````````````````````````
                            Pour la génération de la master clé pour les sessions.
                            > ./build-dh

                        Clé static pour auth tls
                        ``````````````````````````
                            > openvpn --genkey --secret keys/ta.key

                            Cette clé devra être partagé sur le serveur et tout les clients.

                        Prison pour locker le FS
                        ``````````````````````````

                            > mkdir /etc/openvpn/jail

                            Cela permet aux clients de ne pas pouvoir écrire en dehors du folder jail.
                __________________________
                5) Récupération des clés

                    > cp keys/dh*.pem keys/ca.crt keys/server.{crt,key} keys/ta.key /etc/openvpn/mykeys
                    (backup les données dans un endroit safe)

                __________________________
                6) Configuration:

                    Voir partie configuration

        --------------------------
        Daemon
        --------------------------

            > service openvpn start
                    
~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Configuration du serveur (en mode routing)
        --------------------------

            > cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz /etc/openvpn/
            > gunzip /etc/openvpn/server.conf.gz

            exemple de configuration: (voir man openvpv)

            > vim etc/openvpn/server.conf

                    #-----Network:
                    port 1194                                           #port d'écoute
                    proto tcp                                           #transporteur
                    dev tun                                             #mode de fonctionnent (Tunnel IP routé)
                    server 10.8.0.0 255.255.255.0			#Adresse réseau du tunnel (délivrage automatique des adresses)
                    ifconfig 10.8.0.1 255.255.255.0                     #Donner une ip au serveur
                    topology subnet                                     #Permet d'allouer une IP par client IP/MASK

                    #-----Etat et optimisation
                    comp-lzo					        #Compression des données transitants dans le tunnel
                    keepalive 10 120				        #Vérifier l'état du VPN (ping toutes les 10sec avec un timeout de 120sec)

                    #-----Certificats et chiffrement:
                    ca ca.crt					        #path du certif ca
                    cert server.crt					#path du certif serveur
                    key server.key					#path de la clé priv du serveur
                    dh dh1024.pem					#path des paramètres hellman
                    tls-auth ta.key 0				        #clé partagés sur le serveur et les clients
                    cipher AES-256-CBC				        #méthode de chiffrement
                    tls-server                                          #Endosse le rôle de serveur lors de la négociation TLS.

                    #-----Routes générales (pour tout les clients)
                    push "dhcp-option DNS 208.67.222.222"		#Pousser la conf du DNS. (push = envoyer la directive sur les clients)
                    push "route 10.0.0.0 255.0.0.0"                     #Ajouter une route coté client vers le tunnel.
                    route 192.168.1.0 255.X.X.X 10.8.X.X                #Route vers les réseaux externes aux serveurs

                    #-----Clients
                    ifconfig-pool-persist ipp.txt			#path des enregistrements clients
                    max-clients 3					#nombre de client maximum utilisant le vpn
                    client-to-client                                    #authoriser les clients vpn à communiquer entre eux.
                    client-config-dir ccd                               #Créer un fichier de conf par client dans le dossier ccd
                    ccd-exclusive                                       #Permet de n'autoriser que les clients listés dans ccd

                    #-----Utilisateurs
                    user nobody					        #owner du démon openvpn (lors de l'initialisation)
                    group nogroup					#group du démon openvpn

                    #-----Logs et sécurité
                    persist-key					        #permet de garder quelque états en mémoires pour les redémarrages du tunnel
                    persist-tun
                    status openvpn-status.log			        #écris un bref status de l'état d'openvpn dans le path spécifié
                    log-append  /var/log/openvpn.log		        #ajout des logs dans le path spécifié
                    chroot jail					        #Racine du fs dans lequel le client peut lire les données. (/!\ avec ccd, voir ci-dessous)
                    verb 3						#niveau de verbosité

            #Faire fonctionner chroot et client-config-dir:
                exemple:

                    > mkdir -p /etc/openvpn/client_access/ccd
                        client-config-dir ccd
                        chroot  client_access

            #Pour segmenter les conf clientes:

                > vim /etc/openvpn/client_access/ccd/cn_client1

                    ifconfig-push 10.X.X.X 255.X.X.X                #Donner une IP précise au client.
                    iroute 10.X.X.X 255.X.X.X"                      #spécifie le réseau interne au client (derrière)
                    push "route 10.X.X.X 255.X.X.X"                 #route vers le serveur.
                    #push "redirect-gateway def1"                    #Change la gateway par défaut du client vers le vpn

            #Une config plus élaborée:
                
                Il est possible d'utiliser des conditions au sein même de la configuration.
                exemple:

                    if mode server:
                        push " ...."
        
        --------------------------
        Le réseau
        --------------------------
                __________________________
                Forwarding:
	
                    > sysctl -w net/ipv4/ip_forward=1

                    Pour le rendre permanent décommentez dans /etc/sysctl.conf

                        net.ipv4.ip_forward=1
                __________________________
                NAT:

                    Le NAT est nécessaire uniquement si l'on n'a pas activé le routage des sous réseaux:
                        (pas d'iroute par client ...)

                    > iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE

                    Appliquer les rules iptables au démarrage:

                        > iptables-save > /etc/network/iptables.rules

                    Rajouter au niveau de votre interface d'écoute:

                        > vim /etc/network/interfaces

                            pre-up iptables-restore < /etc/network/iptables.rules
                __________________________
                Ip static:

                    > mkdir /etc/openvpn/jail/ccd
                    > vim /etc/openvpn/jail/ccd/CLIENT

                        ifconfig-push 10.8.0.10 10.8.0.11	#Avec l'ip du client et l'ip du serveur :-)

                    > chown -R nobody:nogroup /etc/openvpn/jail

                    Ensuite dans la conf serveur rajoutez les lignes suivantes:

                        client-config-dir ccd       
                        route 10.8.0.0 255.255.255.0 

        --------------------------
        Test de la configuration
        --------------------------

            > openvpn server.conf &
            > tail -10 /var/log/openvpn.log

            Vérifiez qu'il y à à la fin de la séquence:

            "Initialization Sequence Completed"

        --------------------------
        Préparation des configuration clientes:
        --------------------------

            > mkdir -p /etc/openvpn/clientconf/CLIENT
            > cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf /etc/openvpn/clientconf/CLIENT/

            > vim client_MON_CLIENT.conf


                #-----General
                client				#Indiquer que c'est une conf cliente
                persist-key
                persist-tun
                comp-lzo
                verb 3

                #-----Network
                dev tun				#Mode de l'interface
                proto tcp
                nobind				#Ne pas lier un port local
                remote @IP_MON_SERVEUR 1194	
                resolv-retry infinite		#Résolution infinie du nom du serveur VPN

                #-----Certifs et clés
                ca ca.crt
                cert CLIENT.crt
                key CLIENT.key
                tls-auth ta.key 1
                cipher AES-256-CBC

            Copiez tout les certif/clé nécéssaire:
            > ls 

                ca.crt  client_CLIENT.conf  CLIENT.crt  ta.key
                client_CLIENT.ovpn  CLIENT.key

                (le .ovpn est une copie de la conf cliente pour la compatabilité avec windows).

            > tar -zcvf CLIENT.tar.gz /etc/openvpn/clientconf/CLIENT

            Ensuite il faudra envoyé l'archive comme vous le souhaité:

            via mail / via scp ... 

        --------------------------
        Pile de certificat
        --------------------------

            Dans le cas où l'on souhaite spécifier plusieur ca sans lien hiérarchique:
                
                > cat ca1.crt ca2.crt >> stacked.crt

            Niveau conf:
                
                ca stacked.crt

        --------------------------
        Chaines de certificats
        --------------------------

            Si l'on dispose de sous-ca, procéder comme tel:

                > cat client.crt subca.crt >> chained.crt

            Niveau conf:

                ca rootca.crt
                cert chained.crt

~~~~~~~~~~~~~~~~~~~~~~~~~~
Coté client (récupération de l'archive)
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Installation
        --------------------------

            > apt-get install openvpn

        --------------------------
        Config et vérifs
        --------------------------
	
            on décompresse l'archive récupérée:
                > tar -zxvf CLIENT.tar.gz -C /etc/openvpn

            on se place dans le nouveau repertoire décompréssé et on peut exécuter lancer la connexion:
                > openvpn --client --config client_CLIENT.conf

            Si tous se passe bien, vous devriez avoir en dernières ligne:
                "Initialization Sequence Completed"

            On vérifie les nouvelles routes:

                > route -n

                    Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
                    0.0.0.0         10.8.0.1        128.0.0.0       UG    0      0        0 tun0

            Note: Si vous avez deux routes par défaut, hesitez pas à la supprimer:

                > route del -net 0.0.0.0 gw X.X.X.X

                __________________________
                Forcer la mise à jour de resolv.conf pour les postes linux:

                    /!\ les scripts suivant utilise /sbin/resolvconf pour mettre à jour le dns.

                    A rajouter sur la config cliente:
	
                        script-security 2	#Autoriser l'execution
                        up update-resolv-conf	#Execution après connexion
                        down update-resolv-conf	#Execution après déconnexion

                    Il faudra recréer l'archive avec le script suivant:

                        ###################################################
                        #!/bin/bash

                        [ -x /sbin/resolvconf ] || exit 0

                        case $script_type in

                        up)
                            for optionname in ${!foreign_option_*} ; do
                                option="${!optionname}"
                                echo $option
                                part1=$(echo "$option" | cut -d " " -f 1)
                                if [ "$part1" == "dhcp-option" ] ; then
                                    part2=$(echo "$option" | cut -d " " -f 2)
                                    part3=$(echo "$option" | cut -d " " -f 3)
                                    if [ "$part2" == "DNS" ] ; then
                                        IF_DNS_NAMESERVERS="$IF_DNS_NAMESERVERS $part3"
                                    fi
                                    if [ "$part2" == "DOMAIN" ] ; then
                                        IF_DNS_SEARCH="$IF_DNS_SEARCH $part3"
                                    fi
                                fi
                            done
                            R=""
                            for SS in $IF_DNS_SEARCH ; do
                                R="${R}search $SS"
                            done
                            for NS in $IF_DNS_NAMESERVERS ; do
                                R="${R}nameserver $NS"
                            done
                            echo -n "$R" | /sbin/resolvconf -a "${dev}.inet"
                            ;;
                        down)
                            /sbin/resolvconf -d "${dev}.inet"
                            ;;
                        esac
                        ####################################################

                    Nouveau script:

                        ####################################################
                        #!/bin/bash
                        # 
                        # Parses DHCP options from openvpn to update resolv.conf
                        # To use set as 'up' and 'down' script in your openvpn *.conf:
                        # up /etc/openvpn/update-resolv-conf
                        # down /etc/openvpn/update-resolv-conf
                        #
                        # Used snippets of resolvconf script by Thomas Hood and Chris Hanson.
                        # Licensed under the GNU GPL.  See /usr/share/common-licenses/GPL. 
                        # 
                        # Example envs set from openvpn:
                        #
                        #     foreign_option_1='dhcp-option DNS 193.43.27.132'
                        #     foreign_option_2='dhcp-option DNS 193.43.27.133'
                        #     foreign_option_3='dhcp-option DOMAIN be.bnc.ch'
                        #

                        [ -x /sbin/resolvconf ] || exit 0
                        [ "$script_type" ] || exit 0
                        [ "$dev" ] || exit 0

                        split_into_parts()
                        {
                            part1="$1"
                            part2="$2"
                            part3="$3"
                        }

                        case "$script_type" in
                          up)
                            NMSRVRS=""
                            SRCHS=""
                            for optionvarname in ${!foreign_option_*} ; do
                                option="${!optionvarname}"
                                echo "$option"
                                split_into_parts $option
                                if [ "$part1" = "dhcp-option" ] ; then
                                    if [ "$part2" = "DNS" ] ; then
                                        NMSRVRS="${NMSRVRS:+$NMSRVRS }$part3"
                                    elif [ "$part2" = "DOMAIN" ] ; then
                                        SRCHS="${SRCHS:+$SRCHS }$part3"
                                    fi
                                fi
                            done
                            R=""
                            [ "$SRCHS" ] && R="search $SRCHS
                        "
                            for NS in $NMSRVRS ; do
                                    R="${R}nameserver $NS
                        "
                            done
                            echo -n "$R" | /sbin/resolvconf -a "${dev}.openvpn"
                            ;;
                          down)
                            /sbin/resolvconf -d "${dev}.openvpn"
                            ;;
                        esac

                        ####################################################
