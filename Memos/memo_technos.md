Technos/protocoles triés par thèmes
=============================

Il y aussi le mémo sur les protocoles avec plus de précisions :
[protocoles](http://memo.premont.fr/Memos/Network/memo_protocoles)

Links
---------------------

[Open Source Guide](http://www.open-source-guide.com/Solutions/Applications)

Messagerie
---------------------

### Protocoles

* POP
* IMAP
* SMTP
* AMQP (interlogiciel)

### Solutions

* postfix
* zimbra
* open xchange
* RabbitMQ

Chat
---------------------

### Protocoles

* XMPP - Jabber
* IRC

### Solutions

* KiwiIRC
* IRC
* Zimbra

Wiki - docs
---------------------

### Solutions

* mediawiki
* dokuwiki
* pmwiki
* wikkawiki
* twiki
* Xwiki
* mkdocs

Cloud
---------------------

### Solutions

* openstack
* cloudstack

Conteneurs
---------------------

### Solutions

* lxc
* lxd
* docker
* openvz

Partage de fichiers
---------------------

### Protocoles

* DFS
* NFS
* NIS
* SSHFS
* FTP
* CIFS
* TFTP
* SFTP
* WebDAV
* UPnP
* Smb

### Solutions

* Samba
* DFS
* owncloud
* sparkleshare
* iFolder
* Syncany

Haute Disponibilité
---------------------

### Solutions

* HA proxy

Données/Stockage
---------------------

### Protocoles

* NAS
* SAN
* iSCSI
* FCoE
* RAID

### Solutions

* FreeNAS

CI - Intégration Continue
---------------------

### Solutions

* jenkins
* Travis CI

Ordonnanceurs
---------------------

### Solutions

* rundeck
* Jobscheduler

WEB
---------------------

### Protocoles

* HTTP
* HTTPS
* FTP
* SSL/TLS

### Solutions

* Ngninx
* Apache
* CMS : WordPRESS, Joomla ...

Interconnexion/Liaison
---------------------

### Protocoles

* VPN
* TLS
* Ipsec
* SSH
* Ethernet
* Token Ring
* PPP
* HDLC
* Frame Relay
* RNIS (ISDN)
* ATM
* Wi-Fi
* Bluetooth
* ZigBee
* irDA
* MPLS
* FrameRelay
* ADSL

Connexion
---------------------

### Protocoles

* SSH
* Telnet

Tolérance de panne
---------------------

### Techniques

* Réplication
* Redondance
* Faile-over

Redondance
---------------------

### Techniques

* HSRP (Host Standby Router Protocol)
* VRRP (Virtual Router Redundancy Protocol): redondance de routeur virtuel.
* CARP (Common Adress Redundacy Protocol) : partage d'une adresse IP pour plusieurs hôtes (plus évolué que VRRP)
* Stack : méthode de regroupement de plusieurs hôte physique en un seul virtuel.

Basculement - Fail-over
---------------------

### Techniques

* HA (Hight Availability) : Haute disponibilité
* actif/actif =~ load-balancing
* actif/passif =~ Equipement de secours en veille.
* fall-back : Solution alternative
* hearbeat : pour vérifier l'état de vie d'un process

Répartition de charge - Load balancing
---------------------

### Protocoles

* GLBP (Gateway Load Balancing Protocol) : (Propriétaire Cisco) + Redondance.
* CARP (Common Address Redundancy Protocol) : Partage d'une même IP pour un groupe d'hôte + Redondance aussi.

### Techniques

* Round-Robin : chaque hôtes recoivent une reqûete chacun leur tour.
* Round-Robin pondéré : les serveur de poid fort recoivent plus de requête.
* Moins de connexion/less connection : répartie les requêtes sur les hôtes les moins solicités.
* Moins de connexion pondéré : idem mais avec gestion du poid.
* Hashage de destination : Répartition en fonction d'une table de hashage contenant les adresse Ip des serveurs.
* Hashage de source : Idem mais en fonction de l'Ip de la source de transmission.


Téléphonie
---------------------

### Protocoles

* VOIP / TOIP
* SIP

### Solutions

* Asterisk
* elastix

Sécurité
---------------------

### Protocoles

* TLS/SSL
* PGP
* SSH
* IpSEC
* MD5
* AES
* PKI

### Solutions

* openssh
* openvpn
* pfSense
* ejbca
* Shorewall
* snort (sonde réseau)
* honeyd (pot de miel)
* iptables (firewall)
* fail2ban (ban actif)
* ossec (Detection System)
* kerio control
* fortinet

Authentification
---------------------

### Protocoles

* Kerberos
* TLS
* Radius
* Diameter
* SASL
* LDAP
* NTLM

Transport
---------------------

### Protocoles

* TCP
* UDP
* SCTP
* SPX
* ATP

Supervision
---------------------

### Informations

[Termes actifs/passif, interne/externe](https://wooster.checkmy.ws/2014/05/monitoring-interne-externe-actif-passif/)

### Protocoles et techniques

* SNMP
* ICMP
* NRPE

### Solutions

* Nagios
* Icinga
* Shinken
* Canopsis
* Centreon
* librenms
* ntop
* Zabbix
* munin

#### Orientées graphiques/visualisation métriques

* cacti
* grafana
* graphite

Stockage Métrologie
---------------------

### Solutions

* influxDB
* RRDtool

Collisions
---------------------

### Techniques

* CSMA/CA
* CSMA/CD

Adressage
---------------------

### Protocoles

* IPv4
* IPv6
* VLAN
* ARP
* VLSM/CIDR
* DHCP
* DNS
* IGMP

### Solutions

* dhcpd (isc-dhcpd-server)
* bind9
* powerdns

Routage
---------------------

### Protocoles

* NAT
* PAT
* DR
* WCCP
* IGRP
* EIGRP
* RIP
* BGP
* EGP
* OSPF

### Solutions

* iptables
* route

Virtualisation
---------------------

### Solutions

* ESXi
* Citrix
* Vmware
* VirtualBox
* VPS
* OpenStack
* UML : linux comme un simple process classique avec un FS custom
* Qemu : simul tout (simulation de ARM, micro contrôleur)
* Kvm : simulation du matèriel et exploitation du processeur physique
* Xen : Hyperviseur qui gère les accès matèriel.
* Lxc : Conteneurs (cgroups etc ...)
* Démarrage de groupe de process
* OpenVZ : Hyperviseur qui gère des containers

Temps
---------------------

### Protocoles

* NTP

Requêtes spécifiques
---------------------

### Protocoles

* RPC

Système de logs
---------------------

### Solutions

* syslog
* logstash/kibana/elasticSearch
* rsyslog

Gestion de configuration/provisioning
---------------------

### Protocoles et techniques

* SSH
* SSL
* AES
* Push/Pull

### Solutions

* ansible
* puppet
* chef
* salt
* foreman
* serverspec

BDD Behavior Driven Development
---------------------

Méthode agile de collaboration entre developpeurs, responsable et exploitants.

### Solutions

* cucumber

Automatisation End User Experience
---------------------

[Ubuntu-GUI-Scripts](http://doc.ubuntu-fr.org/gui_scripts)
[Wikipedia-GUI-Tools](http://en.wikipedia.org/wiki/List_of_GUI_testing_tools)

* autoit
* sikuli
* xnee
* cuttlefish
* selenium (web)
* watir (web)

Couches OSI
---------------------

COUCHE | Protocoles
------ | ------
Application  | BGP · DHCP · DNS · FTP · Gopher · H.323 · HTTP · IMAP · IRC · NNTP · POP3 · RTSP · SILC · SIMPLE · SIP · SMTP · SNMP · SSH · TCAP · Telnet · TFTP · VoIP · XMPP · WebDAV
Présentation | AFP · ASCII · ASN.1 · MIME · NCP · SSP · TDI · TLV · Unicode · UUCP · Vidéotex · XDR
Session | AppleTalk · DTLS · H.323 · RSerPool · SOCKS · TLS
Transport | DCCP · RSVP · RTP · SCTP · SPX · TCP · UDP
Réseau | ARP · Babel · BOOTP · CLNP · ICMP · IGMP · IPv4 · IPv6 · IPX · IS-IS · NetBEUI · OSPF · RARP · RIP · X.25
Liaison | Anneau à jeton · ARINC 429 · ATM · AFDX · Bitnet · CAN · Ethernet · FDDI · Frame Relay · HDLC · I²C · IEEE 802.3ad (LACP) · LLC · LocalTalk · MIL-STD-1553 · PPP · STP · Wi-Fi · X.21
Physique | 4B5B · ADSL · BHDn · Bluetooth · Câble coaxial · Codage bipolaire · CSMA/CA · CSMA/CD · DSSS · E-carrier · EIA-232 · EIA-422 · EIA-449 · EIA-485 · FHSS · IEEE 1394 · HomeRF · IrDA · ISDN · Manchester · Manchester différentiel · Miller · MLT-3 · NRZ · NRZI · NRZM · Paire torsadée · PDH · SDH · SDSL · SONET · T-carrier · USB · VDSL · V.21-V.23 · V.42-V.90 · Wireless USB · 10BASE-T · 10BASE2 · 10BASE5 · 100BASE-TX · 1000BASE-T
