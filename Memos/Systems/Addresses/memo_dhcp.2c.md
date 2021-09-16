==========================================================
                       D H C P
==========================================================
Dynamic Host Configuration Protocol

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://doc.ubuntu-fr.org/dhcp3-server

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it work
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Requêtes
        --------------------------
            
            Port écoute serveur: 67
            Port écoute client 68

            DHCP DISCOVER
                Le client configuré en mode dhcp, envoie une requête DISCOVER en broadcast, contenant son adresse MAC à destination du port 67, afin de trouver un serveur dhcp et bénéficier d'une adresse IP.

            DHCP OFFER
                Le(s) serveur(s) DHCP recevant la requête DISCOVER, envoie(nt) à leur tour une requête OFFER en unicast contenant une adresse IP, le masque réseaux et l'adresse IP du serveur sur le port 68 du client.

            DHCP REQUEST
                Le client prend en compte la premiere configuration qu'il lui a été envoyé par un OFFER, il émet ensuite en broadcast une demande d'utilisation, contenant l'IP du serveur et celle qui lui a été proposée.

            DHCP ACK
                Le serveur DHCP, envoie en unicast une confirmation au client avec l'adresse IP, la durée du bail, ainsi que d'autres informations (configurable sur le DHCP) telles que l'adresse IP de la gateway, l'adresse du DNS ... 

        --------------------------
        Bail
        --------------------------

            Lorsque la durée du bail atteint les 50% (par défaut) le client redemande son IP (par DHCP REQUEST) auprès du serveur qui lui a attribué son adresse. Si le serveur l'autorise, le bail est renouvelé.
            Au bout de 87.5 % si le bail n'a pas été renouvelé, le client renouvelle le processus de demande d'IP (DHCP DISCOVER …).

            Coté serveur, à la fin du bail si le client n'a renouvelé sa demande, le serveur emet un DHCP NACK pour avertir le client que son bail arrive à expiration.
            Si le client ne demande pas redemande pas de renouveller le bail, le serveur libèrer alors l'adresse.

        --------------------------
        Modes de fonctionnement
        --------------------------

            automatique: bail infinie
            max-lease-time 0xffffffff;  
                
            dynamique: classique avec bail 
            etendue: association MAC/IP

~~~~~~~~~~~~~~~~~~~~~~~~~~
Install
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install dhcp3-server
    ou
    > apt-get install isc-dhcp-server

~~~~~~~~~~~~~~~~~~~~~~~~~~
Config
~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    > vim /etc/dhcp3/dhcpd.conf
    ou
    > vim /etc/dhcp/dhcpd.conf

        --------------------------
        Interfaces d'écoutes
        --------------------------

            > vim /etc/default/dhcp3-server
            ou
            > vim /etc/default/isc-dhcp-server

                INTERFACES="eth0 eth1 ..."

            Redhat:

                /etc/sysconfig/dhcpd
                    DHCPDARGS="ethX"

        --------------------------
        Paramètres globales
        --------------------------

            Note: ces paramaètres peuvent se retrouver dans la conf d'un sous réseau:

            server-name "dhcp.domain.lan";
            #deny unknown-clients;
            log-facility local7;
            default-lease-time 600;
            max-lease-time 7200;
            option subnet-mask 255.255.255.0;
            option domain-name-servers 192.168.1.1, 192.168.1.2;
            option domain-name "domain.lan";
            option ntp-servers 192.168.1.254;
            option netbios-anme-server 192.168.1.1; #POur les clients windows (serveur WINS)
            authoritative;

        --------------------------
        Sous réseau
        --------------------------

            subnet 10.0.0.0 netmask 255.255.255.0 {
                range 10.0.0.100 10.0.0.200;
                range ...;
                option broadcast-address 10.0.0.255;
                option routers 10.0.0.254;
                allow-unknown-clients;      #Dont les adresses MAC ne sont pas connues
            }

        --------------------------
        IP fixe
        --------------------------

            Peut être incluse dans un subnet.

            host clientBidul {
                hardware ethernet DD:GH:DF:E5:F7:D7;
                fixed-address 10.0.0.12;
            }

                        subtitle 4
                        ``````````````````````````
~~~~~~~~~~~~~~~~~~~~~~~~~~
Daemon
~~~~~~~~~~~~~~~~~~~~~~~~~~

        > service dhcp3-server start
        ou
        > service isc-dhcp-server start

        --------------------------
        Debug
        --------------------------

            dhcpd -d

~~~~~~~~~~~~~~~~~~~~~~~~~~
Routeur Relai
~~~~~~~~~~~~~~~~~~~~~~~~~~

    à mettre sur le routeur.

    --------------------------
    Install
    --------------------------

        > apt-get install dhcp3-relay
        ou
        > apt-get install isc-dhcp-relay

    --------------------------
    Conf
    --------------------------

        > vim /etc/default/dhcp3-relay  #ou isc-dhcp-relay

        Fichier de conf:
        
            #Server DHCP
            SERVERS="172.16.1.1"
        
            #Interfaces du relais
            INTERFACES="eth0 eth1 eth2"
        
            #Options
            OPTIONS=""

    --------------------------
    Daemon
    --------------------------

        > /etc/init.d/dhcp3-relay start

    --------------------------
    Redirection de paquets
    --------------------------

        > vim /etc/sysctl.conf
            #uncoment
            net.ipv4.ip_forward=1

            (note : il faudra surement redémarrer les démons)

        > ou sysctl -w net/ipv4/ip_forward=1


        Sur une Redhat:

            activer IP forwarding sans modifier le fichier de conf /etc/sysctl.conf
            # sysctl -w net.ipv4.ip_forward=1

            Verifier prise en compte 
            # cat /proc/sys/net/ipv4/ip_forward

    --------------------------
    Iptables
    --------------------------

        En plus d'accepter les paquet dans la chaine FORWARD,
        Il faut penser à laisser passer les paquets du relay au serveur dhcp:

        > iptables -A OUTPUT -p udp -o INTEFACE_LAN --dport 67:68 --sport 67:68 -j ACCEPT

~~~~~~~~~~~~~~~~~~~~~~~~~~
Clients
~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    > dhclient INTERFACE
