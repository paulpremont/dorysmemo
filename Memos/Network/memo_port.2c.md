========================================================
	               P O R T S                 	
========================================================

Note: Voir dans /etc/services pour avoir une liste de port d'écoute !

http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Définitions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Les ports servent aux applications à distinguer les différentes sources de données.
Comparable à des portes donnant accès au systeme. 
L'attribution des ports est faite par l'OS sur demande de l'application, l'OS s'assure que le port n'est pas déja pris.

Explication:

Un Soft à besoin pour communiquer sur un serveur distant, d'une porte de sortie correspondant au port source, et une porte d'entré sur l'hôte distant correspondant au port de destination.

Les ports ne sont pas figés et peuvent être changés, du moment que se soit cohérent entre le client et le serveur.
Il est même possible d'attribuer plusieur ports différents pour la même application.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Paramètres
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nb de port max : 65536 (2^16)
ports résèrvés : 0 à 1023 inclus

port codé sur 16 bits


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Liste des Ports par défaut
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://fr.wikipedia.org/wiki/Liste_des_ports_logiciels
http://www.frameip.com/liste-des-ports-tcp-udp/


N°              transport	Description

20              tcp             FTP (flux de données)
21              tcp             FTP (flux de contrôle)
22              tcp             SSH (Secure SHELL)
23              tcp             Telnet
25              tcp             SMTP
53              udp             DNS
67              udp             DHCP (Bootstrap Protocol Server)
68              udp             DHCP (Bootstrap Protocol Client)
69              udp             TFTP (Trivial File Transfer)
80              tcp             HTTP
110             tcp             POP3
119                             NNTP (Network News Transfer Protocol)
115             tcp             SFTP
123             udp             NTP (Network Time Protocol)
137             udp             NBNS (NetBIOS Name Service)
139             udp             SMB
143             tcp             IMAPv4 et IMAPv2
161             udp             SNMP
194             tcp             IRC
389             tcp             LDAP
636                             tcp LDAPS
443             tcp             HTTPS (with SSL)
445                             SMB
465             tcp             SMTPS
587             tcp             SMTP (submission)
993             tcp             IMAPS
6665-6669 	tcp             IRC extensions de ports

