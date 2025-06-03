# MEMO WORDPRESS

## Sources

- [Wordpress download](https://fr.wordpress.org/download/)
- [Wordpress hosting](https://wordpress.org/documentation/article/hosting-wordpress/)
- [Wordpress forum install](https://wordpress.org/support/forum/installation/)
- [Tuto hostinger](https://www.hostinger.com/fr/tutoriels/wordpress-nginx)

## Installation


**Installation des paquets :**

```
apt install nginx mariadb-server wget
```

**Installation de wordpress :**

```
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz -C /var/www
chown -R www-data: wordpress/
```

**Sécurisation de la base de données :**

```
sudo mysql_secure_installation
```

**Création de la base :**

```
mysql -uroot -p
#press enter if no password set

CREATE DATABASE wp;
GRANT ALL PRIVILEGES ON wp.* TO 'wpuser'@'localhost' IDENTIFIED BY 'F00P@ssw0rd' WITH GRANT OPTION;
show databases;
exit
```

**Installation php :**

Installation des paquets php (version à adapter, faire un search avant pour voir quelle version est disponibble)

```
sudo apt install php8.2-cli php8.2-fpm php8.2-mysql php8.2-opcache php8.2-mbstring php8.2-xml php8.2-gd php8.2-curl
```

## Configuration

**Configuration du vhost nginx :**

```
server {
        listen 80;
        server_name monsite.fr;
        root /home/monsite/www;

        client_max_body_size 50M;

        location / {
                index index.php index.html;
        }

        location /wp-* {
                return 301 https://$server_name$request_uri;  # enforce https
        }

        location ~ \.php$ {
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_pass php-handler;
                fastcgi_index index.php;
                include fastcgi_params;
        }
}

server {
        listen 443 ssl;
        server_name monsite.fr;
        root /home/monsite/www;

        ssl_certificate /etc/ssl/website/monsite.fr;
        ssl_certificate_key /etc/ssl/website/monsite.key;

        client_max_body_size 50M;

        location /wp-admin {
                index index.php;
        }

        location ~ \.php$ {
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_pass php-handler;
                fastcgi_index index.php;
                include fastcgi_params;
                fastcgi_param PHP_VALUE "
                        post_max_size = 50M
                        upload_max_filesize = 50M 
                ";
        }
}
```

## Initialisation Wordpress

Il suffit maintenant de se connecter au site du vhost :

exemple via son IP : 10.0.0.1

Puis suivre les instructions en saisissant les informations de connection à la base de données.



	-------------------------
	Ajout d'un Vhost
	-------------------------

        Exemple avec Nginx:

 

	-------------------------
	HTTPS
	-------------------------

        Protéger les pages wp-*

        Au niveau de la conf du VHOST mais aussi au niveau de la conf de wordpress:

            > vim wp-config.php

                define('FORCE_SSL_LOGIN', true);
                define('FORCE_SSL_ADMIN', true);

        Si vous voulez tout en full https (optionnel):

            Dans Réglages/Général:
                
                au niveau des URL mettre 'https' au lieu de 'http'
               

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Erreurs connues
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	ALERT - script tried to increase memory_limit ...
	-------------------------

        Dans ce cas, WP serait légerment trop gourmand par rapport au seuil limite de mémoire de php.
		________________
        Résolution:

                        Il faut que WP_MAX_MEMORY_LIMIT ne dépasse pas la valeur 'memory_limit' initiée au niveau de php:

                        > cat /etc/php5/apache2/php.ini |grep memory_limit

                        Au niveau de la racine de votre wordpress:

                        > grep -Ri WP_MAX_MEMORY_LIMIT *

                        Editer le bon fichier (par défault la valeur est set à 256 M)
                        et abaissé la:

                        > vim wp-includes/default-constants.php

                        ou la placer dans wp-config.php

                                define( 'WP_MAX_MEMORY_LIMIT', '40M' );

	-------------------------
	Fatal error: Allowed memory size of XXXXX bytes exhausted
	-------------------------

                Il faut bien ici bien ajuster les seuil (voir le problème précedent)

                        Et mettre un seuil cohérant par rapport à cette limite dans 

                        /etc/php5/apache2/php.ini
                                memory_limit = 64M 

                        ou dans 
                        wp-admin/php.ini
                                memory_limit = 64M 



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Some tips
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	-------------------------
	Ajuster la consommation de mémoire de php
	-------------------------

        http://codex.wordpress.org/Editing_wp-config.php#Increasing_memory_allocated_to_PHP

        exemple de config:

                wp-config.php:

                        define('WP_MEMORY_LIMIT', '64M');
                        define( 'WP_MAX_MEMORY_LIMIT', '128M' );

                /etc/php5/conf.d/suhosin.ini
                        suhosin.memory_limit = 256M

                /etc/php5/apache2/php.ini
                        memory_limit = 256M


	-------------------------
	Ne pas passer par ftp ou autre protocole pour ajouter des thèmes plugins ...
	-------------------------

                vim wp-config.php 
                        define('FS_METHOD', 'direct');

                Ajouter les droits d'écriture dans wp-content et wp-content/plugins/ 

                        chmod +w wp-content wp-content/plugins/
        
	-------------------------
    Changer de langue
	-------------------------

                (Par exemple en fr ;) )

                Modification de la variable WPLANG:
                        
                        vim wp-config.php
                         define(‘WPLANG’, ‘fr_FR’)

                Téléchargement du pack de langue:

                        http://www.wordpress-fr.net/telechargements/

                        cd /wp-content
                        mkdir languages && cd languages

                        wget http://i18n.svn.wordpress.org/fr_FR/branches/3.8/messages/fr_FR.mo
                        wget http://i18n.svn.wordpress.org/fr_FR/branches/3.8/messages/admin-fr_FR.mo
                        wget http://i18n.svn.wordpress.org/fr_FR/branches/3.8/messages/admin-network-fr_FR.mo
                        wget http://i18n.svn.wordpress.org/fr_FR/branches/3.8/messages/continents-cities-fr_FR.mo
	-------------------------
    Mettre à jour wordpress
	-------------------------

                http://codex.wordpress.org/fr:Mettre_a_Jour_WordPress
                http://codex.wordpress.org/fr:Details_de_mise_a_jour

	-------------------------
	Changer la taille d'upload des medias
	-------------------------

                Il suffit d'influer sur les paramètres PHP:

                        post_max_size et upload_max_filesize essentiellement

                Exemple sous nginx:

                    client_max_body_size 100M;

                    fastcgi_param PHP_VALUE "
                            post_max_size=100M
                            upload_max_filesize=100M
                            memory_limit = 100M
                            file_uploads=On
                    ";

                Si jamais le php.ini à le dessus, alors régler ces valeurs dans 

                        /etc/php5/cgi/php.ini

	-------------------------
	Migration
	-------------------------

                1: sauvegarde de l'arborescence du site
                2: sauvegarde la base (via mysqldump par exemple)
                3: Migration vers un autre serveur

                        Si l'adresse du site change, il faudra le changer dans le fichier .sql
