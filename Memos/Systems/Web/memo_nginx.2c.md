===========================================================
		N G I N X
===========================================================

Testé sur une Debian GNU/Linux 7.2

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
LINKS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://nginx.org/en/docs/
    http://wiki.nginx.org/FcgiExample
    http://neokraft.net/2010/03/20/serveur-web-nginx-php-mysql
    http://redmine.lighttpd.net/projects/spawn-fcgi/wiki
    http://xcache.lighttpd.net/
    http://php-fpm.org/
    http://www.howtoforge.com/installing-php-5.3-nginx-and-php-fpm-on-ubuntu-debian
    http://www.howtoforge.com/nginx_php5_fast_cgi_xcache_ubuntu7.04

    https://www.packtpub.com/books/content/using-nginx-reverse-proxy

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Nginx
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        ----------------------
        Installation
        ----------------------

                > apt-get install nginx

        ----------------------
        Manipulation
        ----------------------

                service nginx [reload|start|stop|restart]

        ----------------------
        Comment c'est foutu?
        ----------------------

                Toute la configuration découle d'une arborescence commenceant dans le fichier nginx.conf par le bloc http.
                Ce bloc va ensuite inclure quelques variables et surtout les fichiers de conf présent dans sites-enabled

                On retrouvera du coup une configuration globale du type:

                http {
                        MES CONFIG GENERALES
                        server {
                                MA CONFIG DE VHOST
                        }

                }

        ----------------------
        Créer un Vhost:
        ----------------------

                vim /etc/nginx/sites-available/MON_SITE

                server {
                        MA CONFIG;
                }

                Voici un listing de quelques directives avec pour chacune un exemple:

                Voir aussi: http://wiki.nginx.org/NginxHttpCoreModule
                _______________ 
                listen : définit le port d'écoute:
                        
                        listen 80; #pour l'ipv4
                        listen [::]:80; #pour ipv6
                _______________ 
                server_name: définit le fqdn du site
                        
                        server_name localhost;
                        
                _______________ 
                location: c'est un bloc définissant la configuration pour un dossier particulier

                        location / {
                                Config du dossier racine
                        }

                        location /images {
                                Config du dossier images
                        }

                        il est possible d'utiliser des regex:

                        location ~ MaREGEX {
                                ...
                                exemple de regex: \.(gif|jpg|png)$
                        }
                _______________ 
                root: définir le dossier racine du site ou bien d'un contenu
                        On peu le voir comme un lien.

                        root /data/www;

                        si on le rajoute à la close location, la racine prendra effet dans ce block:

                                location /images/ {
                                        root /data;
                                }

                                Lorqu'on accédes aux dossier images (http://localhost/images/example.png)
                                on sera en fait renvoyer dans le dossier racine data, soit:
                                        /data/images/example.png

                _______________ 
                index: définir les fichiers index

                        index index.html index.htm;

                _______________ 
                proxy pass: Définit une redirection vers un proxy

                        proxy_pass http://localhost:8080/;

                        voir nginx-naxsi et nginx-naxsi-ui

                        Note:
                            Attention proxy pass réécrit l'url !
                            Il faut donc bien veiller à rediriger sur une url dans le cas d'un serveur hebergeant plusieur vhost.

                _______________ 
                access_log: Permet d'écrire les logs relatifs au site

                        access_log /var/log/nginx/localhost.access
                _______________ 
                include: pour inclure le contenu d'un autre fichier

                        include /etc/nginx/naxsi.rules

                _______________ 
                autoriser ou interdire des IP:

                        allow: pour autoriser.
                        deny: pour interdire.

                        location ~ /\.ht {
                               allow 127.0.0.1;
                               deny all;
                        }
                _______________ 
                error_page : définit la page d'erreur à fournir

                        error_page 404 /404.html;

                _______________ 
                fastcgi : permet la communication entre un logiciel tiers et un serveur HTTP.
                        c'est une évolution de cgi (Common Gateway Interface)
                        Il est usuellement associé au contenu dynamique des pages.

                        include fastcgi_params; #include les paramètres cgi.
                        
                        fastcgi_split_path_info ^(.+\.php)(/.+)$;
                        fastcgi_pass 127.0.0.1:9000; #permet de rediriger vers un socket.
                        fastcgi_index index.php; #permet de spécifier les fichier index fcgi
                        fastcgi_param MonPARAM SaValeur; #permet d'inclure des paramètres spécifiques

                _______________ 
                alias: permet de substituer un path

                        location ~ ^/download/(.*)$ {
                          alias /home/website/files/$1;
                        }

                _______________ 
                autoindex : autoriser le parcours de fichiers

                    location /somewhere {
                        autoindex on;
                    }

        ----------------------
        Utilisateur:
        ----------------------

                l'utilisateur par défaut: www-data
                voir: cat nginx.conf |grep -i user

        ----------------------
        un VHOST en https
        ----------------------
                http://nginx.org/en/docs/http/configuring_https_servers.html

                _______________ 
                Forcer le https:

                        server {
                                listen 80;
                                server_name MonDomaine;
                                return 301 https://$server_name$request_uri;  # enforce https
                        }

                _______________ 
                Paramètres ssl

                        server {
                                    listen              443 ssl;
                                    server_name         www.example.com;
                                    ssl_certificate     www.example.com.crt;
                                    ssl_certificate_key www.example.com.key;
                                    ssl_protocols       SSLv3 TLSv1 TLSv1.1 TLSv1.2;
                                    ssl_ciphers         HIGH:!aNULL:!MD5;
                                    ...
                        }

                _______________ 
                N'avoir qu'une partie de son site en https:

                exemple avec wordpress:

                        server {
                                listen 80;
                                server_name Mon_FQDN;
                                root /path/to/root;

                                location / {
                                        index index.php index.html;
                                }

                                location /wp-admin {
                                        return 301 https://$server_name$request_uri;  # enforce https
                                }

                                location ~ \.php$ {
                                        fastcgi_split_path_info ^(.+\.php)(/.+)$;
                                        fastcgi_pass 127.0.0.1:9000;
                                        fastcgi_index index.php;
                                        include fastcgi_params;
                                }
                        }

                        server {
                                listen 443 ssl;
                                server_name Mon_FQDN;
                                root /path/to/root;

                                ssl_certificate /path/to/file.crt;
                                ssl_certificate_key /path/to/file.key;

                                location / {
                                        return 301 http://$server_name$request_uri;
                                }

                                location /wp-admin {
                                        index index.php;
                                }

                                location ~ \.php$ {
                                        fastcgi_split_path_info ^(.+\.php)(/.+)$;
                                        fastcgi_pass 127.0.0.1:9000;
                                        fastcgi_index index.php;
                                        include fastcgi_params;
                                }
                        }

        ----------------------
        Activer/Désactiver un site:
        ----------------------

                ln -s .../sites_available/MON_SITE .../sites_enable/MON_SITE

                ou via les commandes:

                > ngxensite
                > ngxdissite

        ----------------------
        Accès par mot de passe:
        ----------------------

                _______________ 
                exemple avec un fichier .ngpasswd contenant les loging:mdp

                
                    #On interdit l'accès aux fichiers commençant par .ng:
                    location ~ \.ng {
                            deny all;
                    }

                    #On demande l'auth pour le dossier choisi: (ici la racine '/'):
                    location / {
                        try_files $uri $uri/ /index.html;

                                auth_basic      "Entrez votre mot de passe";
                                auth_basic_user_file $document_root/lock/.ngpasswd;

                                location ~ \.php$ {
                                        fastcgi_split_path_info ^(.+\.php)(/.+)$;
                                        fastcgi_pass php-handler;
                                        fastcgi_index index.php;
                                        include fastcgi_params;
                                }
                    }

                    #Note: ne pas oublier d'imbriquer les fichier .php dans le dossier à sécuriser.

                _______________ 
                Script de génération de mot de passe:

                    ****************************
                    #!/usr/bin/perl
                    use File::Basename;
                    my $script = basename $0;
                    if (! scalar @ARGV ) {
                            print "Usage: $script passwordfile user password\n";
                            print "(this program automatically creates the pw file if needed.)\n";
                            exit 0;
                    }
                     
                    @saltsource = ('a'..'z', 'A'..'Z', '0'..'9','.','/');
                    $randum_num = int(rand(scalar @saltsource));
                    $salt = $saltsource[$randum_num];
                    $randum_num = int(rand(scalar @saltsource));
                    $salt .= $saltsource[$randum_num];
                     
                    $outf=$ARGV[0];
                    $user=$ARGV[1];
                    $passwd=$ARGV[2];
                     
                    if ($user && $passwd) {
                            $encrypted = crypt($passwd, "$salt");
                     
                            if (-f $outf) {
                                    open(OUT, ">>$outf") || die "htpasswd-b error: $!\n";
                            } else {
                                    open(OUT, ">$outf") || die "htpasswd-b error: $!\n";
                            }
                            print OUT "$user:$encrypted\n";
                            close(OUT);
                     
                            exit 0;
                    }
                    ****************************

                    ou encore:

                    ****************************
                    #!/usr/bin/perl
                    use strict;
                    chomp(my $username=$ARGV[0]);
                    chomp(my $password=$ARGV[1]);
                    print $username.":".crypt($password,$username)."\n";
                    ****************************

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PHP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Voir aussi:
        http://jorge.fbarr.net/2010/08/20/nginx-php-mysql-and-wordpress-continued/

        Le dialogue avec PHP se fait par l"intermédiaire de FastCGI.

        ----------------------
        Installation
        ----------------------

                apt-get install php5-cgi spawn-fcgi php5-xcache
                ou
                apt-get install php5-fpm php5-xcache

                (spawn-fcgi peut être remplacé par php5-fpm (Voir le 5ème liens pour le configurer à la place de spawn))
                        Un comparatif existe sur:
                        http://vpsbible.com/php/php-benchmarking-phpfpm-fastcgi-spawnfcgi/

                Dans tout les ca spawn-fcgi, php5-fpm servent à gérer les processus FCGI de façon optimale.


        ----------------------
        par spawn-fcgi
        ----------------------
                _______________ 
                Pour lancer php au démarrage:

                On créer le script init:

                        vim /etc/init.d/php5-fcgi

                        #!/bin/sh

                        ### BEGIN INIT INFO
                        # Provides:       php5-fcgi
                        # Required-Start: $remote_fs $syslog
                        # Required-Stop:  $remote_fs $syslog
                        # Default-Start:  2 3 4 5
                        # Default-Stop:   0 1 6
                        # Short-Description: PHP5 FastCgi Spawned processes
                        ### END INIT INFO

                        COMMAND=/usr/bin/spawn-fcgi
                        ADDRESS=127.0.0.1
                        PORT=9000
                        USER=www-data
                        GROUP=www-data
                        PHPCGI=/usr/bin/php5-cgi
                        PIDFILE=/var/run/fastcgi-php.pid
                        RETVAL=0

                        PHP_FCGI_MAX_REQUESTS=500
                        PHP_FCGI_CHILDREN=2

                        start() {
                            export PHP_FCGI_MAX_REQUESTS PHP_FCGI_CHILDREN
                            $COMMAND -a $ADDRESS -p $PORT -u $USER -g $GROUP -f $PHPCGI -P $PIDFILE
                        }

                        stop() {
                            /usr/bin/killall -9 php5-cgi
                        }

                        case "$1" in
                            start)
                              start
                              RETVAL=$?
                          ;;
                            stop)
                              stop
                              RETVAL=$?
                          ;;
                            restart|reload)
                              stop
                              start
                              RETVAL=$?
                          ;;
                            *)
                              echo "Usage: fastcgi {start|stop|restart}"
                              exit 1
                          ;;
                        esac
                        exit $RETVAL

                        _______________ 
                        On l'active au démarrage:

                                chmod +x php5-fcgi
                                update-rc.d php5-fcgi defaults
                        _______________ 
                        Socket

                                Le socket par défaut du serveur FCGI est 127.0.0.1:9000
                                Il suffit de changer les variables du script init pour changer ce dernier

                        _______________ 
                        On lance le processus:
                        
                                /etc/init.d/php5-fcgi start
                        _______________ 
                        Implémentation Nginx:

                _______________ 
                Conf: /etc/php5/cgi

                        /etc/php5/cgi/php.ini
                                

        ----------------------
        par PHP-FPM
        ----------------------

                Après l'installation du packet php5-fpm, un script init ce créer automatiquement.

                Pour l'activer au démarrage:

                > update-rc.d php5-fpm defaults
                _______________ 
                Socket:

                        Par défaut:
                                 unix:/var/run/php5-fpm.sock
                                 et/ou
                                 127.0.0.1:9000
                _______________ 
                Conf: /etc/php5/fpm
                        

                        /etc/php5/fpm/php-fpm.conf
                        /etc/php5/fpm/php.ini

        ----------------------
        Optimisation du cache
        ----------------------

                vim /etc/php5/conf.d/N0-xcache.ini      #N étant votre propre valeur decimal (ou dans mods-available)

                                                        # A vous de voir pour l'optimiser et voir en fonction de votre RAM
                xcache.size  =                64M
                xcache.var_size  =            64M

        
        ----------------------
        On l'implémente à Nginx:
        ----------------------
                _______________ 
                Au niveau de la cong de nginx:

                        vim /etc/nginx/fastcgi_params

                                # PHP only, required if PHP was built with --enable-force-cgi-redirect
                                fastcgi_param  REDIRECT_STATUS    200;

                                #Custom:
                                fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;

                                #Pour Ubuntu 12.04:
                                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name; #pour Ubuntu 12.04
                                fastcgi_param PATH_INFO $fastcgi_path_info;

                _______________ 
                Au niveau de son site:

                        vim /etc/nginx/sites-available/MON_SITE


                                location ~ \.php$ {                                                       
                                        fastcgi_split_path_info ^(.+\.php)(/.+)$;
                                        fastcgi_pass 127.0.0.1:9000; #selon le socket!
                                        include fastcgi_params;
                                } 

                _______________ 
                Centraliser la conf du handler php 

                        Il suffit de définir un groupe de server grâce à la directive upstream permetant d'être utilisé par proxy pass, fastcgi pass et memcached pass

                        vim /etc/nginx/nginx.conf

                        exemple:

                                upstream php-handler {
                                        server 127.0.0.1:9000;
                                        #server unix:/var/run/php5-fpm.sock;
                                }

                        puis au niveau de son Vhost:

                                fastcgi_pass php-handler;

                _______________ 
                Modifier des paramètres php

                        exemples:

                        fastcgi_param PHP_VALUE "
                                upload_max_filesize = 600M
                                post_max_size = 600M
                                ";


                        Pour suprasser les valeurs init_set de php, il faut utiliser PHP_ADMIN_VALUE:

                        fastcgi_param PHP_ADMIN_VALUE "
                                upload_max_filesize = 600M
                                post_max_size = 600M
                                ";
                        
                        Note sur php:

                                Il est possible de configurer les directives de php grace à ini_set:

                                        <?php
                                        ini_set('register_globals', 0);
                                        ini_set('upload_max_filesize', '20M');
                                        ini_set('max_execution_time', 600);
                                        ?>

                        Note sur l'upload:

                                Il faut penser à conf la directive client_max_body_size

                                        client_max_body_size 200M;

                        Note sur spawn-cgi:

                                Il se peut que spawn-cgi ne supporte pas cette feature.
                                Dans ce cas, installer php-fpm.

        ----------------------
        Redémarrage du démon
        ----------------------

                service nginx restart

        ----------------------
        Testez
        ----------------------

                si vous avez fait vos test sur le vhost par défaut:

                vim /usr/share/nginx/www/index.php

                        <?php phpinfo(); ?>

                Enregistrez et renommer l'original: 
                        mv /usr/share/nginx/www/index.html /usr/share/nginx/www/index.html.back

                Lancez votre browser et enjoyez !

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Passenger
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://www.phusionpassenger.com/
    http://openmymind.net/2010/7/1/Installing-Nginx-with-Passenger-on-Linux/
    http://wyeworks.com/blog/2009/1/28/setting-up-passenger-in-linux

    C'est un serveur web et d'application supporté qui supporte ruby (initialement prévu à cet effet), python et node.js.
    Il s'interface communément avec Apache ou Nginx ou peut être exécuté en standalone.

        Quelques packages:
        ``````````````````````````
            > apt-get install bundler


        Avec Nginx:
        ``````````````````````````

            > apt-get install nginx

            > sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
                # (Sur le port 11371)

            > sudo apt-get install apt-transport-https ca-certificates

            Ajout des repos open sources:

                > vim /etc/apt/sources.list.d/passenger.list

                    ##### !!!! Only add ONE of these lines, not all of them !!!! #####
                    # Ubuntu 15.04
                    deb https://oss-binaries.phusionpassenger.com/apt/passenger vivid main
                    # Ubuntu 14.04
                    deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main
                    # Ubuntu 12.04
                    deb https://oss-binaries.phusionpassenger.com/apt/passenger precise main
                    # Debian 8
                    deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main
                    # Debian 7
                    deb https://oss-binaries.phusionpassenger.com/apt/passenger wheezy main
                    # Debian 6
                    deb https://oss-binaries.phusionpassenger.com/apt/passenger squeeze main

                > sudo chown root: /etc/apt/sources.list.d/passenger.list
                > sudo chmod 600 /etc/apt/sources.list.d/passenger.list
                > sudo apt-get update

            Install des packages:

                > sudo apt-get install nginx-extras passenger

            Config de Nginx:

                > vim /etc/nginx/nginx.conf

                    #Décommentez passenger_root et passenger_ruby

                    passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
                    passenger_ruby /usr/bin/passenger_free_ruby;

                > sudo service nginx restart

                #Note:

                    Si il n'y a pas les lignes passenger_root ... , vous pouvez les générer:

                        > /usr/bin/passenger-config --root

                        Puis on réutilise la sortie de la commande:

                        > passenger_root MY_PREV_OUTPUT;

            Vérifs:

                > ps faux |grep -i passenger



## Quick install

```bash
# NGINX :
apt install nginx
systemctl start nginx
systemctl enable nginx

# PHP + modules :
apt install php php-fpm php-cli php-mysql php-curl php-json
php --version
systemctl start php7.4-fpm
systemctl enable php7.4-fpm

# config example :
vim /etc/nginx/sites-available/example

server {
        listen 80;
        server_name test.example.com;
        root /var/www/html;
        index info.php;

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
    }
}
```
