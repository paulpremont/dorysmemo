=======================================================
	A P A C H E    M y S Q L    P H P 	(AMP)
=======================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

https://help.ubuntu.com/community/ApacheMySQLPHP
http://httpd.apache.org/docs/2.4/
http://httpd.apache.org/docs/2.4/howto

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation et activations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	> apt-get install apache2 mysql-server libapache2-mod-auth-mysql php5-mysql libapache2-mod-php5 phpmyadmin
	> a2enmod php5

	#note: pour phpmyadmin, l'installation est interactive, faite votre choix ;) .

=======================================================
                	A P A C H E 
=======================================================

        Apache2 fonctionne avec un coeur traitant les requêtes web cliente et s'occupe de gérer les erreurs ...
        Des modules dynamiques sont disponible et se gréffent au coeur pour bénéficier de plus de fonctionnalité.
        Note:
                Il faut avoir compilé le noyau avec le module mod_dso pour bénéficier des modules dynamiques.


	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	ARBORESCENCE
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                /usr/lib/apache2/modules: contient les modules dynamiques.

                /var/log/apache : fichiers de logs

		/etc/apache2/
                        apache2.conf : contient la configuration globale du serveur.
                        conf.d : contient divers fichiers de conf optionnel ou qui n'ont pas de rapport direct avec la config du serveur.
                        envvars : contient les variables d'environnements nécéssaire pour la config d'apache.
                        magic : Concerne les données pour le module mod_magic_mime (Définissant les MIME Type des fichiers)
                        mods_available : contient toutes configurations des modules dynamiques installés.
                        mods-enable : contient les liens vers les modules actifs (.load)
			ports.conf : contient les ports/interfaces d'écoutes d'apache (ainsi que des modules).
			sites-available : contient tous les sites (vhosts).
			sites-enable : contient les liens vers les sites activés. (passer par a2ensite).

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	COMMANDES
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		> service apache2 reload|restart|...	: recharge, redémarre le serveur apache ...
		> a2ensite $SITE_NAME  : Active le site contenu dans "site-available"
		> a2dissite $SITE_NAME : Désactive le site //
		> a2dismod / a2enmod    : Désactiver / Activer un module.

                > apache2 -l : lister les modules compilés
                        -t -D DUMP_MODULES : afficher les modules chargés dynamiquement au démarrage du démon.
                        -M : dumper tout les modules actifs



	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	LES VHOSTS
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Les vhost servent à définir les règles de sécurités et permettent d'avoir plusieurs sites sur le même serveur. 
                Ils sont définis dans des blocs "<VirtualHost>" où toutes les règles qui leurs sont propres sont inscrites.

		-----------------------
		Template:
		-----------------------

			Voici la syntaxe générique:

			NameVirtualHost $LISTENING_INTERFACE:$PORT	#: @IP et le port d'écoute du Vhost
										Pour l'ipv6 mettre [@IP] entre crochet
										Il faut répéter cette directive pour chaque IP/Interface sur laquel on veut écouter.
										(présent dans ports.conf).

			<VirtualHost $LISTENING_INTERFACE:$PORT> 	#: doit être identique au NameVirtualHost
				ServerName www.$NOM_SITE.$DOMAIN 	#: URL complete du site (C'est par cette URL que le vhost sera accessible).
				ServerAlias $NOM_SITE.$DOMAIN ...	#: Autres URL(raccourcis) permettant d'accéder au site
				DocumentRoot $ROOT_FOLDER		#: Dossier Racine du site 
			</VirtualHost>


		-----------------------
		Exemple:
		-----------------------

			NameVirtualHost *:80    #dans ports.conf
						#Ligne obligatoire pour plusieurs Vhost
						#Sur un même port d'écoute.
			Listen 80


			<VirtualHost *:80>
				ServerName www.websiteA.fr
				ServerAlias websiteA.fr
				DocumentRoot /var/www/websiteA
			</VirtualHost>
			<VirtualHost *:80>
				ServerName www.websiteB.fr
				ServerAlias websiteB.fr
				DocumentRoot /var/www/websiteB
			</VirtualHost>

			Le client pourra accéder au site A en tapant simplement websiteA.fr dans son navigateur.
			Il faut quand même que celui ci ai son fichier host ou son dns bien configuré !

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	ALIAS
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Il servent simplement à substituer un path et d'y accéder plus simplement:

                        Alias /mon_alias /real/path

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	SSL
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		ports.conf:

		<IfModule mod_ssl.c>
		    NameVirtualHost *:443 #Pour avoir plusieurs Vhost sur le même port
		    Listen 443
		</IfModule>


		TODO

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Redirection HTTP vers HTTPS
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		<VirtualHost *:80>                                
			ServerName monsite.mondomaine              
			RewriteEngine on                          
			RewriteRule (.*) https://monsite.mondomaine%{REQUEST_URI}
		</VirtualHost>

		<IfModule mod_ssl.c>                              
			<VirtualHost *:443>  
			...
			</VirtualHost>
                </IfModule>


	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	HTACCESS - Authentification
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		

		-----------------------
		Link:
		-----------------------
			http://httpd.apache.org/docs/current/howto/htaccess.html

		-----------------------
		What is it?
		-----------------------

		Les fichiers htaccess permetent de rajouter/modifier des élements s de configuration au niveau d'un repertoire.
		(Cela est indentique à mettre de la configuation entre balise <Directory>.
		Ceux-ci sont reccursifs et s'appliquent aux dossiers enfants.
		Les enfants peuvent avoir leur propre htaccess, celui-ci sera prioritaire par rapport au parent.

		Le fichier .htaccess est à placer à la racine du dossier souhaité (votre site).

		Note:
			Les fichiers htaccess ne sont pas conseillés dans la mesure où ils font consommer d'avantages de ressources au serveur, (dû à la recherche et au chargement en mémoire de ces fichiers) et qu'ils peuvent poser des problèmes de sécurité (changement de la conf par l'utilisateur...).
		
		-----------------------
		Conf Apache:
		-----------------------

			Activer la prise en compte du fichier htaccess:

			| <Directory ...>
			| 	AllowOverride XX 	#Directive qui permet de limiter l'impact des htacess. XX est à remplacer ;) (ex: All pour ne pas filtrer)?
			| </Directory>
			|
			| AccessFileName .newName 	#Définir un autre nom que htaccess


		-----------------------
		Fichier htacess:	
		-----------------------

			Voici quelques directives:
			
			vim /var/www/monsite/.htaccess

                                | AuthUserFile /path/to/.passwords
                                | AuthGroupFile /path/to/.groups
                                | AuthName "Protect access"		#Ce qui sera affiché
                                | AuthType Basic			#Type d'auth, ici basic (mdp en clair)

                        Il peut être possible de limiter l'accès à certain utilisateurs:

                                | <Limit POST>
                                |       require valid-user
                                |       require user MON_USER1 MON_USER2 ...
                                |       require group MON_GROUP1 MON_GROUP2 ...
                                | </Limit>

                        Syntaxe du fichier passwords:

                                | bidul:pass_hashé(via crypt)

                                Le plus simple est de passé par le tool d'apache:

                                > htpasswd -c MON_FICHIER MON_USER

                        Pour les fichiers groupes:

                                | MON_GROUPE: USER1 USER2 ...


		-----------------------
		Se protéger des htacess:
		-----------------------
			
			-En limitant le champ d'action d'AllowOverride

				Pour ne pas autoriser tout type de configuration, on peu ajouter des "filtres" sur la directive AllowOverride:

				All : autorise tout
				Options : todo
		http://httpd.apache.org/docs/current/mod/core.html#allowoverride
		
			-En surpassant la configuration avec les balises <Location>

				todo

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Changer d'utilisateur
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		-----------------------
                De façon global:
		-----------------------

                        Il suffit d'étider les variables d'environnement d'apache:

                        vim /etc/apache2/envvars

                                export APACHE_RUN_USER=MON_USER
                                export APACHE_RUN_GROUP=MON_GROUP

                        Puis de créer son utilisateur et on groupe:

                                useradd -g MON_GROUP MON_USER

                        Et enfin de changer le owner du fichier de lock d'apache:

                                chown -R MON8USER:MON_GROUP /var/lock/apache2

                        Plus qu'a redémarrer le démon:

                                service apache2 restart


		-----------------------
                Pour chaque vhost:
		-----------------------

                        Installation des nouveaux modules:

                                apt-get install apache2-mpm-itk

                        Au niveau du Vhost:

                                AssignUserId MON_USER MON_GROUP

                Pensez ensuite à exporter les variables pour pouvoir vous servir des commandes apaches sans erreur:

                        > export APACHE_RUN_USER=MON_USER
                        > export APACHE_RUN_GROUP=MON_GROUP

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	SSI (Server Side Include)
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                http://httpd.apache.org/docs/2.4/howto/ssi.html

                Le SSI est un ensemble de directives interprété par le serveur au moment où il répond à une requête.
                On l'utilise généralement pour afficher quelques informations système de type date ... . 
                Si la plupart du site est dynamic, le SSI n'est pas forcement la bonne solution.
                Mieux vaut se tourner vers un langage complet tel que php ou autre ...

		-----------------------
                Activer la prise en charge du SSI:
		-----------------------

                        |Options +includes      #Autorisation d'analyser les fichiers pour les directives SSI
                        
                        Il faut ensuite dire à apache quoi évaluer ?

                        Soit via une extension, exemple shtml (par défaut):
                                
                                |AddType text/html .shtml 
                                |AddOutputFilter INCLUDES .shtml 

                        Soit sur les fichiers executable (Ne fonctionne pas sur Windobe)
                                
                                |XBitHack on

                                (chmod +x monfichier pour le rendre exécutable :P )

                        Il n'est bien évidement pas conseillé de mettre l'extension html pour la première solution au risque de ralentir votre serveur.


		-----------------------
                Les directives:
		-----------------------

                        ____________________
                        Template:

                                <!--#function attribute=value attribute=value ... -->

                        ____________________
                        Exemples:
                        
                                afficher la date:
                                <!--#echo var="DATE_LOCAL" -->

                                Customiser l'affichage de la date:
                                <!--#config timefmt="%A %B %d, %Y" -->

                                Date de modification d'un fichier:
                                <!--#flastmod file="MON_FICHIER.html" -->

                                Afficher le résultat d'un programme CGI: 
                                <!--#include virtual="/cgi-bin/counter.pl" -->

                                Fonctionne aussi pour n'importe quel fichier html:
                                <!--#include virtual="footer.html" -->

                                Exécuter une commande:
                                <!--#exec cmd="ls" -->


                        ____________________
                        Ajouter des variables:

                                <!--#set var="MA_VARIABLE" value="MA_VALEUR" -->
                                <!--#set var="date" value="${DATE_LOCAL}_${DATE_GMLT}" -->

                        ____________________
                        Les conditions

                                Voir surtout ce lien pour avoir un aperçu de la syntaxe:
                                http://httpd.apache.org/docs/2.4/mod/mod_include.html

                                et celui ci pour avoir la liste des tests (conditions)
                                http://httpd.apache.org/docs/2.4/expr.html

                                <!--#if expr="test" -->
                                Do something
                                <!--#elif expr="test2" -->
                                Do something else
                                <!--#else -->
                                or else do that thing
                                <!--#endif -->

	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	CGI (Common Gateway Interface)
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                Le CGI définit la manière dont il va intéragir avec des morceau de programmes écrit dans d'autre langage tel que le Perl, le C ...

                On les appel des programmes CGI.

		-----------------------
                Activer CGI
		-----------------------

                        ____________________
                        Prérequis:

                                Le module cgi doit être activé:

                                > apache2 -M 

                                Sinon l'activer:

                                > a2enmod cgi ...

                        ____________________
                        Quoi interpéter?

                                On peut définir les alias vers les folder contenant les scripts cgi:

                                        | ScriptAlias /cgi-bin /usr/local/apache2/cgi-bin/

                                        Toutes les requêtes vers le path /cgi-bin aboutirons en fait dans le folder /usr/local...

                                        Par exemple:
                                                 http://www.example.com/cgi-bin/test.pl
                                                 Ira en fait piocher le script dans:
                                                 /usr/local/apache2/cgi-bin/test.pl

                                Ou bien en fonction de l'extension du fichier:

                                        | <Directory /home/*/public_html >
                                        |       Options +ExecCGI
                                        |       AddHandler cgi-script .cgi .pl ...
                                        | </Directory>

                                        Ainsi tout les fichiers avec l'extension pl et cgi des dossier public_html sertont interprétés comme des fichier CGI.
                                                
                                         ou pour traiter l'intégralité d'un dossier:

                                        | <Directory /home/*/public_html/cgi-bin >
                                        |       Options +ExecCGI
                                        |       AddHandler cgi-script
                                        | </Directory>

                        ____________________
                        Ecrire un programme CGI:

                                -Renseigner systématiquement le MIME Type du fichier (Content-type: text/html)
                                -L'output doit être en html

                                Exemple pour un script perl affichant les variablesd d'env:

                                        | #!/usr/bin/perl
                                        | use strict;
                                        | use warnings;
                                        | print "Content-type: text/html\n\n";
                                        | foreach my $key (keys %ENV) {
                                        |       print "$key --> $ENV{$key}<br>";
                                        | }

                                Mettre les bon droits d'éxécution:

                                        > chmod a+x MON_FICHIER.cgi

                                Quelque petite chose à vérifier:
                                        -Assurez vous que vos variables d'env utilisées dans le script soit passées à Apache. 
                                                Sinon passer par le fichier envvars ou voir http://httpd.apache.org/docs/2.4/env.html; 
                                                voir http://www.ietf.org/rfc/rfc3875 pour avoir une liste exhaustive de ces variables.

                                        -Essayez vos scripts avant même de les utiliser avec apache.
                                        -Utilisez le module Suexec si vous voulez lancer vos script avec différents droits : http://httpd.apache.org/docs/current/fr/suexec.html
                                        -utilisez les librairies CGI disponibles pour vos langages

                                STDIN:
                                        Pour récupérer les variables envoyées via un POST ou un GET, 
                                        C'est dans la variable QUERY_STRING que l'on récupère ces infos.
                                        Attention à leur format, les caractères spéciaux comme les espaces sont en hexa, exemple %20 pour un espace.
