==========================================================
                       R E D M I N E
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~
LINKS
~~~~~~~~~~~~~~~~~~~~~~~~~

	http://www.redmine.org/projects/redmine/wiki/RedmineInstall
	http://www.redmine.org/projects/redmine/wiki/Guide
	http://www.gogolek.co.uk/blog/2012/09/writing-redmine-2-x-plugins-tutorial/
	http://doc.ubuntu-fr.org/redmine
	http://www.redmine.org/projects/redmine/wiki/Plugins

~~~~~~~~~~~~~~~~~~~~~~~~~
What is it ?
~~~~~~~~~~~~~~~~~~~~~~~~~

	Une plateforme web de gestion de projet écrite en ruby.

~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~

	Redmine est présent dans les repo officiels.
	Le hic c'est qu'il est surement pas du tout à jour, c'est pourquoi la suite concerne l'installation manuelle.

        --------------------------
        Prérequis
        --------------------------
                __________________________
                ruby via rvm:
			
			Adapter la version de ruby en fonction du site off.

				version='1.9.3'
				sudo='sudo'

				curl -sSL https://get.rvm.io | $sudo bash -s stable
				source ~/.rvm/scripts/rvm 
                #ou
                source /etc/profile.d/rvm.sh
				rvm install $version
				rvm use $version --default

			Vérifier si ruby fonctionne:

				ruby -v

                __________________________
                mysql:

			apt-get install mysql-server mysql-client

			mysql -uroot -p
				> CREATE DATABASE redmine CHARACTER SET utf8;
				> GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost' IDENTIFIED BY 'my_password';

                __________________________
                bundler:

			Il va nous permettre d'installer les gem recquis par redmine.

			gem install bundler
                __________________________
		Some libs:

			Avec apache:

			libs="libmagickwand-dev libmysqlclient-dev gcc build-essential zlib1g zlib1g-dev zlibc libzlib-ruby libssl-dev libyaml-dev libcurl4-openssl-dev libapr1-dev libxslt-dev checkinstall"

			apt-get install $libs

        --------------------------
        Redmine
        --------------------------
                __________________________
		Archive:

			wget http://www.redmine.org/releases/redmine-2.5.1.tar.gz
			tar -xvf redmine-2.5.1.tar.gz

                __________________________
		database.yml

			redmine="redmine-2.5.1.tar.gz"
			cd $redmine/config

			cp database.yml.example database.yml
			vim database.yml

				production:
				  adapter: mysql
				  database: redmine
				  host: localhost
				  username: redmine
				  password: "my_password"

                __________________________
		gems:

			On vérifie si gem est installé:

				gem -v

			Install de rdoc: (à vérifier)

				gem install rdoc

			On install les gems via bundler et le Gemfile qui se trouve à la racine du dossier redmine.
			Il est conseillé de lancer bundler en tant qu'user no root.
			En cas de souci durant l'installation, bien vérifier la syntaxe (les guillement par exemple) de database.yml
			Et enfin il peut manquer quelque lib à ajouter à la main.

				cd $redmine
				bundle install --without development test


			Note: si l'on souhaite installer des gems additionnel, il faut les placer dans un fichier Gemfile.local qui sera automatiquement lu.
			
                __________________________
		secret token:

			Utilisé pour chiffrer les cookies de session
			
			rake generate_secret_token

                __________________________
		Schéma de la base:

			RAILS_ENV=production rake db:migrate
                __________________________
		Peuplement par defaut de la base:

			RAILS_ENV=production rake redmine:load_default_data
			On demandera ensuite la langue à installer.

			On peut la setter via REDMINE_LANG pour une install silencieuse:

			RAILS_ENV=production REDMINE_LANG=fr rake redmine:load_default_data
			
                __________________________
		l'arborescence:


			mkdir -p tmp tmp/pdf public/plugin_assets
			chown -R www-data:www-data files log tmp public/plugin_assets
			chmod -R 755 files log tmp public/plugin_assets

			Note: certain préferons avoir un utilisateur dédié:
				addgroup redmine
				adduser redmine --no-create-home --ingroup redmine

                __________________________
		Test de l'application

			ruby script/rails server webrick -e production

			On peu ensuite y accéder via le port 3000

			http://monServer:3000

			se loguer ensuite en admin/admin

			Note:
				Le serveur web par défaut s'appel webrick.


~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~

	cp config/configuration.example.yml config/configuration.yml

        --------------------------
        Apache et passenger
        --------------------------

		Il est recommendé en production de passer par un serveur web plus veloce tel qu'apache, nginx...

		Il existe plusieurs méthode pour éxécuter des application ruby via ces serveurs web.
		
		Celle que j'ai retenu (surement la plus simple), est celle ce passenger.

		Passenger va servir à lancer des applications ruby rails depuis apache.

                __________________________
                install des paquets et passenger

                    pkg="apache2-mpm-prefork apache2-prefork-dev"
                    apt-get install $pkg

                    gem install passenger
                    passenger-install-apache2-module

                __________________________
                config

                        module passenger
                        ``````````````````````````
                            à adapter avec les paths dumpés à l'étape d'avant

                            il faut ensuite reprendre les lignes dumpées par le script d'install.
                            Sinon se débrouiller avec locate.

                            exemple:

                                vim /etc/apache2/mods-available/passenger.load
                                    LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.3-p545/gems/passenger-4.0.41/buildout/apache2/mod_passenger.so

                                vim /etc/apache2/mods-available/passenger.conf
                                    PassengerRoot /usr/local/rvm/gems/ruby-1.9.3-p545/gems/passenger-4.0.41
                                    PassengerDefaultRuby /usr/local/rvm/gems/ruby-1.9.3-p545/wrappers/ruby
                                    PassengerDefaultUser www-data

                            On active le module:
                                > a2enmod passenger
                                > service apache2 restart

                            On vérifie:
                                > ps aux |grep -i passenger
                                > apache2ctl -M	#Note (apache2ctl prend en compte l'environnement définit dans envvars)

                            Note: Avec passenger, pas besoin de s'occuper du module cgi et de toucher aux fichiers htaccess et dispatch.fcgi

                                    vhost apache
                                    ``````````````````````````
                            ln -s /dosier/install/redmine/public /var/www/redmine

                            > a2enmod ssl

                            exemple de vhost:

                                <VirtualHost *:443>
                                    ServerAdmin webmaster@localhost
                                    Servername redmine.domain.fr

                                    DocumentRoot /var/www/redmine   

                                    <Directory /var/www/redmine>
                                        #Options FollowSymLinks -Multiviews
                                        Options -Multiviews
                                        AllowOverride all
                                        #Order allow,deny
                                        allow from all
                                        RailsEnv production
                                        RackBaseURI /redmine
                                        PassengerResolveSymlinksInDocumentRoot on
                                    </Directory>

                                    ErrorLog ${APACHE_LOG_DIR}/error_redmine.log
                                    LogLevel warn
                                    CustomLog ${APACHE_LOG_DIR}/access_redmine.log combined

                                    #security
                                    SSLEngine on
                                    SSLCertificateFile    /path/to/ca.crt
                                    SSLCertificateKeyFile /path/to/ca.key
                                </VirtualHost>

                            > service apache2 restart

                                    Droits systèmes
                                    ``````````````````````````

                            Bien veiller à ce que le repertoire public soit accessible par l'utilisateur apache.

        --------------------------
        Logs
        --------------------------

		Les logs concernant redmine sont écrits directement dans redmine/log/NOM_ENVIRONNEMENT, exemple: log/production.log

		Pour ne pas exploser son quota de log, on peut mettre en place logrotate ou passer par additionnal_environment.rb
                __________________________
		via additionnal_environment.rb

			cp additional_environment.rb.example additional_environment.rb
			vim additional_environment.rb 

				#Logger.new(PATH,NUM_FILES_TO_ROTATE,FILE_SIZE)
				config.logger = Logger.new('/opt/redmine/log/redmine.log', 2, 1000000)
				config.logger.level = Logger::INFO

				Note: il faut surtout que l'utilisateur 'www-data' ait les droits d'écriture.

			

        --------------------------
        Backup
        --------------------------

		Pour backup redmine, on backup son dossier et sa base.
		Note: (le principal étant le dossier des pièces jointes)

                __________________________
		Database

			/usr/bin/mysqldump -u <username> -p<password> <redmine_database> | gzip > /path/to/backup/db/redmine_$(date +%y_%m_%d).gz


                __________________________
		Attachments

			rsync -a /path/to/redmine/files /path/to/backup/files

        --------------------------
        Mails
        --------------------------

                On peut configurer l'envoie de mail via sendmail ou directement via la conf de redmine avec ActionMailer.
		
                __________________________
		Config smtp ActiMailer

                    Les paramètres smtp sont dispo dans configuration.yml

                    exemple de config:

                    vim config/configuration.yml

                    default:
                      # Outgoing emails configuration (see examples above)
                      email_delivery:
                        delivery_method: :smtp
                        smtp_settings:
                          tls: true
                          enable_starttls_auto: true
                          #address: smtp.advim.fr
                          address: ssl0.ovh.net
                          #port: 587
                          port: 465
                          domain: mon.domain.fr
                          authentication: :plain
                          user_name: "login@mon.domain.fr"
                          password: "monPasswd"

                        Voir si il faut rajouter 1a ligne suivante:
                        config.action_mailer.perform_deliveries = true

                __________________________
		Config smtp sendmail

                         production:
                           email_delivery:
                             delivery_method: :sendmail

                Note: Attention à l'indentation et aux espaces. Ne pas utiliser de tabulation.

        --------------------------
      	Settings
        --------------------------
		
		La plupart de la configuration se fait ensuite au clic via l'ihm dans Administration/Settings
                __________________________
		Pour forcer le login sur la page d'accueil, rdv dans settings:
		
			Administration/Settings/Authentication/
			Cocher Authentication required
                __________________________
		Changer le hostname
			
			Pour que les mails arrivent sous la bonne forme, il faut penser à changer le champs 'Host anme and path' dans l'onglet general de settings et mettre le fqdn du site à la place.

~~~~~~~~~~~~~~~~~~~~~~~~~
Plugins
~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~
Update
~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~
Migration
~~~~~~~~~~~~~~~~~~~~~~~~~
    http://www.redmine.org/projects/redmine/wiki/HowTo_Migrate_Redmine_to_a_new_server_to_a_new_Redmine_version

        --------------------------
      	Copie des fichiers importants
        --------------------------

            redmine/files
            ou de toutes l'arborescence si on garde la même version
            (on peu aussi le faire via git et commiter ses changements)

    
        --------------------------
      	La base
        --------------------------

            export:
                mysqldump --user=${USER} --password=${PWD} --skip-extended-insert $DB > redmine.sql

            import:

                On recréer la base puis:
                    mysql --user=${USER} --password=${PWD} $DB < redmine.sql
                    cd redmine
                    rake db:migrate RAILS_ENV=production

        On prendra soint de réinstaller tous les packages et services comme passenger pour remettre redmine dans son état d'origine.

~~~~~~~~~~~~~~~~~~~~~~~~~
Balises Redmine (formatage des tickets)
~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
      	Textile (default markup language)
        --------------------------
            https://www.redmine.org/help/en/wiki_syntax_detailed.html

            Dumper du code :
                <pre> mon code </pre>

            Cacher un contenu pour le faire apparaitre ensuite via un bouton :

                {{collapse('titre....')
                ton texte à collapser
                ...
                }}

            TODO...
