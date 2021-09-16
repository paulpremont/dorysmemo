===============================================================
	F A I L 2 B A N 
===============================================================

Fail2ban permet d'ajouter des règles iptables automatiquement en fonction des authentification érronées sur hôte.
Il check les logs d'un service pour determiner si il ya une erreur ou non d'auth.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

#Présent sur les repo officiels

> apt-get install fail2ban


~~~~~~~~~~~~~~~~~~~~~~~~~~
Deamon
~~~~~~~~~~~~~~~~~~~~~~~~~~

#Vérifier le status:
> 	/etc/init.d/fail2ban status

#Controler le server fail2ban:
> 	fail2ban-client -v -x start 

#Recharger la conf
> 	/etc/init.d/fail2ban reload

Commandes utiles
> 	fail2ban-client reload
> 	fail2ban-client stop [prison]
> 	fail2ban-client start
> 	fail2ban-client status [prison]

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

>	vim /etc/fail2ban/jail.conf

	-----------------------
	Les prisons (jails)
	-----------------------

	Les prisons servent à définir les paramètres de ban en fonction de chaque service:


	bantime = temps de ban ;)

	exemple ssh:

	 [ssh]                                                                         
	 enabled = true
	 port    = ssh
	 filter  = sshd
	 logpath  = /var/log/auth.log
	 maxretry = 6

	-----------------------
	Les filtres
	-----------------------
	
	Chaque service dispose d'un fichier de conf dans filter.d:

	Ceux-ci heberges les règles relativent à un banissement.
	En fonction des regex donné,des grep sont effectué dans un fichier de log du service en question. 
	Ainsi fail2ban est capable de savoir quand il y a une erreur d'authentification.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Vérification
~~~~~~~~~~~~~~~~~~~~~~~~~~

Pour voir une règle instaurée par fail2ban:

>	iptables -L fail2ban-$SERVICE

exemple:
>	iptables -L fail2ban-ssh

~~~~~~~~~~~~~~~~~~~~~~~~~~
Déban
~~~~~~~~~~~~~~~~~~~~~~~~~~

> 	itables -L : pour voir les châine
> 	iptable -D NOM_CHAINE N°ligne

exemple :
> 	iptables -D INPUT -s XX.YY.WW.ZZ -j DROP
> 	fail2ban-server restart
