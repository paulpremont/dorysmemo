======================================================================
                        O W N   C L O U D
======================================================================
~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~

        https://owncloud.org/
        https://doc.owncloud.org/


~~~~~~~~~~~~~~~~~~~
Distribution testée
~~~~~~~~~~~~~~~~~~~

        Debian 7.0

~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~

        ----------------
        Manuelle
        ----------------
                Voir http://doc.owncloud.org/server/6.0/admin_manual/

                Pour l'installation manuelle.
                doc.owncloud.org/server/6.0/admin_manual/installation/installation_source.html

                A voir absolument en fonction de votre serveur web, des exemples de conf vous sont donnés.

                wget http://download.owncloud.org/community/owncloud-6.0.0a.tar.bz2
                tar -xjf path/to/downloaded/owncloud-x.x.x.tar.bz2

                chown -R www-data:www-data /path/to/your/owncloud/install/data


        ----------------
        Automatique
        ----------------

                Pour une Debian (mode auto)
                http://software.opensuse.org/download.html?project=isv:ownCloud:community&package=owncloud

                L'installation ce fait par défaut dans le dossier /var/www/owncloud
                Des fichiers de confs se créent pour apache dans /etc/apache2/conf.d/owncloud.conf 
                et l'install des modules php5_cgi.conf php5_cgi.load dans /etc/apache2/mods-available#

                Si le path par défaut ne vous convient pas:

                        mv /var/www/owncloud /OTHER/PATH

        
~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~

        ----------------
        NGINX
        ----------------

                vim /etc/nginx/sites-available/owncloud

                ##################################################

                upstream php-handler {
                server 127.0.0.1:9000;
                #server unix:/var/run/php5-fpm.sock;
                }

                server {
                        listen 80;
                        server_name cloud.example.com;
                        return 301 https://$server_name$request_uri;  # enforce https
                }

                server {
                        listen 443 ssl;
                        server_name cloud.example.com;

                        ssl_certificate /etc/ssl/nginx/cloud.example.com.crt;
                        ssl_certificate_key /etc/ssl/nginx/cloud.example.com.key;

                        # Path to the root of your installation
                        root /var/www/;

                        client_max_body_size 10G; # set max upload size
                        #fastcgi_buffers 64 4K;

                        rewrite ^/caldav(.*)$ /remote.php/caldav$1 redirect;
                        rewrite ^/carddav(.*)$ /remote.php/carddav$1 redirect;
                        rewrite ^/webdav(.*)$ /remote.php/webdav$1 redirect;

                        index index.php;
                        error_page 403 /core/templates/403.php;
                        error_page 404 /core/templates/404.php;

                        location = /robots.txt {
                            allow all;
                            log_not_found off;
                            access_log off;
                        }

                        location ~ ^/(data|config|\.ht|db_structure\.xml|README) {
                                deny all;
                        }

                        location / {
                                # The following 2 rules are only needed with webfinger
                                rewrite ^/.well-known/host-meta /public.php?service=host-meta last;
                                rewrite ^/.well-known/host-meta.json /public.php?service=host-meta-json last;

                                rewrite ^/.well-known/carddav /remote.php/carddav/ redirect;
                                rewrite ^/.well-known/caldav /remote.php/caldav/ redirect;

                                rewrite ^(/core/doc/[^\/]+/)$ $1/index.html;

                                try_files $uri $uri/ index.php;
                        }

                        location ~ ^(.+?\.php)(/.*)?$ {
                                try_files $1 = 404;

                                include fastcgi_params;
                                fastcgi_param SCRIPT_FILENAME $document_root$1;
                                fastcgi_param PATH_INFO $2;
                                fastcgi_param HTTPS on;
                                fastcgi_pass php-handler;
                        }

                        # Optional: set long EXPIRES header on static assets
                        location ~* ^.+\.(jpg|jpeg|gif|bmp|ico|png|css|js|swf)$ {
                                expires 30d;
                                # Optional: Don't log access to assets
                                access_log off;
                        }

                }
                ##################################################
        ----------------
        PHP
        ----------------

               C'est surtout au niveau de xcache qu'il faut agir:

               Veuillez a ce que ces valeurs correspondent (à peu près):

               vim /etc/php5/mods-available/xcache.ini

                       xcache.admin.enable_auth = Off
                       xcache.admin.user = "mOo"
                       xcache.admin.pass = "un password en md5" #créer en un avec echo "monpass" |md5sum
                       xcache.size  =                100M
                       xcache.var_size  =            100M

        ----------------
        MySQL
        ----------------

                Pour ceux qui ont l'intention de se passer de sqllite

                mysql -uroot -p
                create database owncloud;
                GRANT ALL PRIVILEGES ON owncloud.* TO 'owncloud'@'localhost' IDENTIFIED BY 'MON_PASS' WITH GRANT OPTION;
                quit;

        ----------------
        Owncloud
        ----------------

                Enfin redémarrer ses services:
                        (nginx, php)

                Accéder à votre site web et continuez la configuration via votre browser

                Développez advanced pour configurer les accès à la base.
                
                ___________________
                Augmenter la taille d'upload

                        éditer votre php.ini (/etc/php5/cli/ et cgi)

                        Et modifiez ces valeurs :

                                upload_max_filesize
                                post_max_size 



~~~~~~~~~~~~~~~~~~~
Synchroniser ses données
~~~~~~~~~~~~~~~~~~~
                        
~~~~~~~~~~~~~~~~~~~
Maintenir à jour
~~~~~~~~~~~~~~~~~~~

    https://doc.owncloud.org/server/8.0/admin_manual/maintenance/upgrade.html#manual-upgrade-procedure

    /!\ Il faut effectuer une upgrade par version majeur. 
    C'est à dire si l'on passe de la 6.0 à la 8.2, il faudra upgrader d'abord vers la 7.0, puis vers la 8.0 ...

        1 : Mettre owncloud en mode maintenante et en loglevel 0 (debug)

            > vim owncloud/config/config.php

                <?php
                $CONFIG = array (
                  'version' => '8.1.4.2',
                    ...
                  'loglevel' => 0,
                  'maintenance' => true,
                );


        2 : Eteindre de préférence le daemon web (optionnel)

            
            > service nginx stop


        3 : Télécharger l'archive owncloud et la décomprésser

            voir : https://owncloud.org/install/#instructions-server
                https://owncloud.org/changelog/

            Exemple :

                > wget https://download.owncloud.org/community/owncloud-8.2.2.tar.bz2
                > tar - xjfv owncloud-8.2.2.tar.bz2

        4 : Backuper ces données

            voir : https://doc.owncloud.org/server/8.0/admin_manual/maintenance/backup.html
            > rsync -Aax owncloud/ owncloud-dirbkp_`date +"%Y%m%d"`/
            > mysqldump --lock-tables -h [server] -u [username] -p [db_name] > owncloud-sqlbkp_`date +"%Y%m%d"`.bak


        5 : switcher les dossiers

            Exemple :

                > mv my.actual_owncloud owncloud.back
                > mv my.new_owncloud owncloud

        6 : Copier config.php et /data du précédent dossier

            > cp config/config.ph ../owncloud/config
            > cp -Rv data ../owncloud/data

        7 : Changer les droits

            > sudo chown -R web-user: owncloud
            
        8 : redémarrer le daemon et accéder à la page pour effectuer l'upgrade

            Enlever le mode maintenance :

                'maintenance' => false,

            > service nginx start

~~~~~~~~~~~~~~~~~~~
Ajouter des plugins
~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~
Trouble shooting
~~~~~~~~~~~~~~~~~~~

    TYpe d'erreur:

        PHP Fatal error:  Call to a member function...

        Apparut avec l'install d'une application (owncloud dans les choux après install d'une apps)

        Il faut désactiver l'application en question via la base:

            exemple:
                UPDATE oc_appconfig SET configvalue = 'no' WHERE configkey = 'enabled' AND appid = 'music';
