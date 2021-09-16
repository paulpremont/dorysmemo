==================================================================
	P U R E 	F T P D
==================================================================

Link: 
	http://www.pureftpd.org/project/pure-ftpd/doc
	http://doc.ubuntu-fr.org/pure-ftp


~~~~~~~~~~~~~~~~~~~~~~~~~
INSTALL
~~~~~~~~~~~~~~~~~~~~~~~~~
>	apt-get install pure-ftpd pure-ftpd-common

ou voir section TLS pour compiler pure-ftpd à la main avec le support tls !

~~~~~~~~~~~~~~~~~~~~~~~~~
Les utilisateurs virtuels
~~~~~~~~~~~~~~~~~~~~~~~~~

Par défaut pure ftpd fonctionne avec PAM pour l'authentification
Plusieurs méthodes peuvent être choisient (Mysql, LDAP ...)

	---------------------
	CREATION
	---------------------

	>	groupadd FTPGROUP
	>	useradd -g FTPGROUP -d /dev/null -s /usr//sbin/nologin FTPUSER
	>	pure-pw useradd VIRTUALUSER -u FTPUSER -g FTPGROUP -d /PATH/TO/CHROOT
			-j : pour créer le répertoire chroot au passage
	>	pure-pw passwd VIRTUALUSER	#Pour changer le password
	>	pure-pw mkdb			#Recharger la conf

	on donnera les bon droit sur le dossier chrooté:

	>	chown -R FTPUSER:FTPGROUP /PATH/TO/CHROOT

	---------------------
	INFOS
	---------------------

	>	/etc/pureftpd.passwd		#fichier contenant les users
	>	pure-pw show USERNAME
	>	pure-pw list			#lister les utilisateurs

	---------------------
	ACTIVATION
	---------------------

	Il faut activer l'utilisation des utilisateurs virtuels:

	>	/etc/pure-ftpd/auth	#contient les liens vers les méthodes d'authentification
	
	Pour activer une méthode d'auth dans ce dossier, il faut créer un lien vers la méthode d'autj.
	Cette méthode est un path vers la base de donnée des utilisateurs.
	Voir /etc/pure-ftpd/conf

	Note: les lien sont numéroté pour définir l'ordre de préférence !
	Le choix se fait dans l'ordre croissant. 

	Pour supprimer les anciennes méthodes, il suffit de supprimer les liens symbolique présents.
	On rajoute ensuite notre lien:

	>	sudo ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/50pure

	---------------------
	CONVERTION
	---------------------

	On peut convertir les utilisateur système renseigné dans /etc/passwd
	en utilisateurs virtuels:

	>	pure-pwconvert >> /etc/pureftpd.passwd

~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~

	Pour avoir un aperçus des options de conf disponibles, si vous avez les sources, vous pouvez afficher le fichier suivant: 
	cat /PATH/TO/SOURCE/configuration-file/pure-ftpd.conf

	Voici un exemple de configuration (dans /etc/pure-ftpd/conf/)

	./PureDB
		/etc/pure-ftpd/pureftpd.pdb
	./PAMAuthentication
		yes
	./AltLog
		clf:/var/log/pure-ftpd/transfer.log
	./ChrootEveryone
		yes
	./MinUID
		1000
	./NoAnonymous
		yes
	./TLS
		2
	./UnixAuthentication
		no
	./PassivePortRange
		XXXXX XXXXX

	

~~~~~~~~~~~~~~~~~~~~~~~~~
TLS
~~~~~~~~~~~~~~~~~~~~~~~~~
	---------------------
	Install des paquets
	---------------------

	> apt-get install libssl-dev libmysqlclient-dev pure-ftpd-common

	> wget http://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-1.0.36.tar.gz
	
	Compilation avec la prise en compte du TLS:

	> ./configure --with-everything --with-mysql --with-peruserlimits --with-virtualchroot --with-tls --sysconfdir=/etc/pure-ftpd --prefix /usr/
	> make && make install

	# --with-everything: build a big server with almost all features turned on:
	altlog, cookies, throttling, ratios, ftpwho, upload script, virtual users
	(puredb), quotas, virtual hosts, directory aliases, external authentication,
	Bonjour and privilege separation.

	#Rajoutez les options que vous voulez surtout :p (./configure --help)
	#Si jamais vous ratez : make uninstall 
	#pour supprimer les fichiers crées

	Pour certain (Ce qui on fait des failed compil ...)
	Assurez vous d'avoir les bon path dans les variables PURE_PASSWDFILE et PURE_DBFILE

	> export PURE_DBFILE=/etc/pure-ftpd/pureftpd.pdb
	> export PURE_PASSWDFILE=/etc/pure-ftpd/pureftpd.passwd

	#Note : le prefix /usr c'est pour rendre utilisable pure-ftp avec pure-ftp-control et implémenter les fichiers de configurations.

	---------------------
	Activation du TLS:
	---------------------

	echo 2 > /etc/pure-ftpd/conf/TLS

	---------------------
	Création du certificat:
	---------------------

	> openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem

	> chmod 600 /etc/ssl/private/pure-ftpd.pem

	---------------------
	iptables
	---------------------

	Pour la requête MLSD, celle ci sort sur un port différent défini dans la conf ./PassivePortRange (voir plus haut)

	Il faut donc l'autoriser. (on autorisera aussi le ftp)

	iptables -A OUTPUT -p tcp --sport XXXXX:XXXXX -j ACCEPT
	iptables -A INPUT -p tcp --dport XXXXX:XXXXX -j ACCEPT


~~~~~~~~~~~~~~~~~~~~~~~~~
Messages d'acceuil
~~~~~~~~~~~~~~~~~~~~~~~~~

>	vim /PATH/TO/MESSAGE
>	chmod 644 $MESSAGE
>	vim /etc/pure-ftpd/conf/FortunesFile
		
		> $MESSAGE

> 	/etc/init.d/pure-ftpd restart

~~~~~~~~~~~~~~~~~~~~~~~~~
Redémarrage du démon
~~~~~~~~~~~~~~~~~~~~~~~~~

> pure-ftpd-control restart

Manuellement:

> pure-ftpd -l puredb:/etc/pure-ftpd/pureftpd.pdb -O clf:/var/log/pure-ftpd/transfer.log -u 1000 -E -B ...
(cette commande est récupérable en passant par pure-ftpd-control ou wrapper)
Elle se construi automatiquement grâce au script wrapper et les option définies dans le dossier de conf

~~~~~~~~~~~~~~~~~~~~~~~~~
Tools
~~~~~~~~~~~~~~~~~~~~~~~~~

> pure-ftpwho -v # liste les utilisateurs connectés

~~~~~~~~~~~~~~~~~~~~~~~~~
Coté client
~~~~~~~~~~~~~~~~~~~~~~~~~

	Choisir une connexion TLS explicit.

	Explicit = connexion sur le port d'origine (21) puis négociation en TLS
	Implicit = connexion sur un port différent (990) et négociation direct en TLS

	Il faudra ensuite accepter le certificat.

Suite au prochain épisode si il y a !

