==========================================================
                   P H A B R I C A T O R
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://secure.phabricator.com/book/phabricator/article/installation_guide/

    Voir aussis GitLab:

        https://about.gitlab.com/downloads/

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Un outils de revue de code et de gestion de projet orienté dev.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://povilasb.com/phabricator/install.html
    https://secure.phabricator.com/book/phabricator/article/installation_guide/

        --------------------------
        Via les scripts d'installation:
        --------------------------

            Via le script off:

                (utilise apache)

                > git clone https://github.com/phacility/phabricator/tree/master/scripts/install

                ou:

                #ubuntu like:
                > wget http://www.phabricator.com/rsrc/install/install_ubuntu.sh

                #redhat like:
                > wget http://www.phabricator.com/rsrc/install/install_rhel-derivs.sh

            Script non off (mais avec les packages nginx):

                > git clone https://github.com/povilasb-com/phabricator-install

        --------------------------
        Manuelle
        --------------------------

            #les packages:
                > apt-get install mysql-server nginx dpkg-dev \
                  php5 php5-fpm php5-mysql php5-gd php5-dev php5-curl php-apc php5-cli php5-json \
                  python-pygments

            #Projet git:
                https://github.com/phacility/phabricator

            #Clone des repo:

                > cd /opt
                > git clone https://github.com/phacility/libphutil.git
                > git clone https://github.com/phacility/arcanist.git
                > git clone https://github.com/phacility/phabricator.git

        --------------------------
        Update
        --------------------------

            http://www.phabricator.com/rsrc/install/update_phabricator.sh

            Stop des process:

                > service php5-fpm stop
                > service phabricator stop

            Sur chacun des projets (libphutil, aranist, phabrocator):

                > git pull

            Application des updates

                > phabricator/bin/storage upgrade

            Start des process:

                > service php5-fpm start
                > service phabricator start

        --------------------------
        LDAP
        --------------------------

            apt-get install php5-ldap

                Config: 
                    phabricator > Auth > LDAP

                Tester:
                    ./bin/auth ldap

                    User : monUser ldap
                    Pwd  : mon pwdUuser

                Importer des utilisateurs (facultafif, on peu aussi les lier à un compte local):

                    > phabricator > people > Import from LDAP

                        LDAP username : unUserLdap
                        Password      : pwdAssocié
                        LDAP query    : uid=* 

                Lier à un compte local

                    > Account > External Accounts
                    
        --------------------------
        Doc
        --------------------------

            > apt-get install libast2
            > /opt/phabricator/libphutil/scripts/build_xhpast.sh
            > ./bin/diviner generate

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Nginx
        --------------------------

            Non off mais pratique:

            sudo wget https://raw2.github.com/povilasb-com/phabricator-install/master/phabricator.localhost ./

            Fichier:

                server
                {
                    # Change to your real subdomain, e.g. phabricator.mysite.com
                    server_name phabricator.domain.fr;

                    # Update to the directory where you've installed Phabricator.
                    root      /opt/phabricator/phabricator/webroot;
                    try_files $uri $uri/ /index.php;

                    location /
                    {
                        index   index.php;

                        if ( !-f $request_filename )
                        {
                            rewrite ^/(.*)$ /index.php?__path__=/$1 last;
                            break;
                        }
                    }

                    location /index.php
                    {
                        fastcgi_pass unix:/var/run/php5-fpm.sock;
                        fastcgi_index index.php;

                        #required if PHP was built with --enable-force-cgi-redirect
                        fastcgi_param  REDIRECT_STATUS    200;

                        #variables to make the $_SERVER populate in PHP
                        fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
                        fastcgi_param  QUERY_STRING       $query_string;
                        fastcgi_param  REQUEST_METHOD     $request_method;
                        fastcgi_param  CONTENT_TYPE       $content_type;
                        fastcgi_param  CONTENT_LENGTH     $content_length;

                        fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;

                        fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
                        fastcgi_param  SERVER_SOFTWARE    nginx/$nginx_version;

                        fastcgi_param  REMOTE_ADDR        $remote_addr;
                    }
                }

        --------------------------
        Mysql
        --------------------------

            mysql --user root --password
            mysql> create user 'phabricator'@'localhost';
            mysql> grant all privileges on *.* to 'phabricator'@'localhost';
            mysql> set password for 'phabricator'@'localhost' = password('12345');

        --------------------------
        Phabricator
        --------------------------
            https://secure.phabricator.com/book/phabricator/article/configuration_guide/

             cd phabricator_dir
             ./bin/config set mysql.host localhost
             ./bin/config set mysql.port 3306
             ./bin/config set mysql.user phabricator
             ./bin/config set mysql.pass 12345

             ./bin/storage upgrade

             #lancement du daemon:
             ./bin/phd start

        --------------------------
        Mails
        --------------------------

            Outbound:

                https://secure.phabricator.com/book/phabricator/article/configuring_outbound_email/

                > /opt/phabricator/phabricator# ./bin/phd start

                Le reste de la config se fait via l'interface graphique dans Config/mail

                Choix d'un "adapter":

                    -Amazon SES
                    -SendGrid
                    -External SMTP (Gmail...)
                    -Local SMTP (sendmail, postfix ...)

                On choisi sont client SMTP avec 'metamta.mail-adapter'
                par défaut sur 'PhabricatorMailImplementationPHPMailerLiteAdapter' pour sendmail.

                __________________________
                Sendmail (default)

                __________________________
                PHPMAILER:

                    Dans config/mail:

                        metamta.mail-adapter : PhabricatorMailImplementationPHPMailerAdapter

                    Puis sur le serveur:
                        
                    ./bin/config set phpmailer.mailer smtps
                    ./bin/config set phpmailer.smtp-host ssl0.ovh.net
                    ./bin/config set phpmailer.smtp-port 465
                    ./bin/config set phpmailer.smtp-user mon_user@mon_domaine.fr
                    ./bin/config set phpmailer.smtp-password *******
                    ./bin/config set phpmailer.smtp-protocol ssl

                    ./bin/phd restart

                __________________________
                Tests:

                    phabricator/ $ ./bin/mail list-outbound             # List outbound mail.
                    phabricator/ $ ./bin/mail show-outbound --id monId  # Show details about messages.
                    phabricator/ $ ./bin/mail send-test --to user --subject truc < optional_file       # Send test messages.

            Inbound:

                https://secure.phabricator.com/book/phabricator/article/configuring_inbound_email/


        --------------------------
        Notifications
        --------------------------

            https://secure.phabricator.com/book/phabricator/article/notifications/

            Installation de nodejs:

                > apt-get install nodejs

            Installation du module ws:

                > phabricator/ $ cd support/aphlict/server/
                > phabricator/support/aphlict/server/ $ npm install ws

            Démarrage du service:

                phabricator/ $ bin/aphlict start

        --------------------------
        Security
        --------------------------

            https://secure.phabricator.com/book/phabricator/article/configuring_file_domain/


~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Daemons
        --------------------------

            https://secure.phabricator.com/book/phabricator/article/managing_daemons/

            Pour manager les daemons via la GUI:

                https://urlPhabricator/daemon/


            Sinon voir avec phd et aphflict

                phabricator/bin/phd start|stop|status
                phabricator/bin/aphlict start|stop|status


            Nécessite que le daemon php5-fpm soit up


        --------------------------
        Commandes admins
        --------------------------

            Toutes les commandes sont situées dans phabricator/bin:

                __________________________
                Modifier/Créer un compte:
            
                    > accountadmin COMPTE_A_EDITER

                    Rentrer ensuite le nom de l'utilisateur ...

                    Approuver un compte:

                        > phabricator > people > Appoval Queue
                

        --------------------------
        Importer un repo
        --------------------------

            > voir Diffusion > créer un repo

            Tests 
                ./bin/repository update --trace <callsign>

        --------------------------
        Syntaxe wiki et documents
        --------------------------

            Similaire à markdown et wiki markup:

                https://secure.phabricator.com/book/phabricator/article/remarkup/
                
        --------------------------
        Forcer le https
        --------------------------

            Si l'on force l'utilisation du https; il faudra changer l'uri de phabricator:

                > ./bin/config set phabricator.base-uri "https://phabricator.xx.fr"

        --------------------------
        Supprimer un projet
        --------------------------
            Récupérer le PHID:
                http://stackoverflow.com/questions/25753749/how-do-you-find-the-phid-of-a-phabricator-object

            > ./phabricator/bin/remove destroy PHID-PROJ-6i6ofxwwz4xybdvg7oa5


~~~~~~~~~~~~~~~~~~~~~~~~~~
Init script
~~~~~~~~~~~~~~~~~~~~~~~~~~

#!/bin/sh

### BEGIN INIT INFO
# Provides:          phd
# Required-Start:    $remote_fs $network $syslog php5-fpm nginx
# Required-Stop:     $remote_fs $network $syslog php5-fpm nginx
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6  
# Short-Description: starts|stops phd daemon for phabricator
# Description:       Starts|stops phd daemon for phabricator also provides way to upgrade phabricator totally
### END INIT INFO

ROOT='/opt/phabricator'
#PHABRICATOR_ENV=custom/myconfig

stop() {
  #sudo -u www-data PHABRICATOR_ENV=$PHABRICATOR_ENV  $ROOT/phabricator/bin/phd stop
  $ROOT/phabricator/bin/phd stop --force
  su -c "$ROOT/phabricator/bin/aphlict stop" -l phabricator
  #sudo -u phabricator ./$ROOT/phabricator/bin/aphlict stop
}

upgrade(){
  /etc/init.d/php5-fpm stop

  cd $ROOT/phabricator && git pull
  cd $ROOT/arcanist && git pull
  cd $ROOT/libphutil && git pull
  cd

  $ROOT/phabricator/bin/storage upgrade -f

  /etc/init.d/php5-fpm start
}

start() {
     #PHABRICATOR_ENV=$PHABRICATOR_ENV $ROOT/phabricator/bin/phd start
     $ROOT/phabricator/bin/phd start
     su -c "$ROOT/phabricator/bin/aphlict restart" -l phabricator
     #sudo -u phabricator ./$ROOT/phabricator/bin/aphlict start

     echo $(date) >> /tmp/phab.log
}

status() {
     $ROOT/phabricator/bin/phd status --local
     su -c "$ROOT/phabricator/bin/aphlict status" -l phabricator
}

log_begin_msg()
{
    echo $1
}

log_end_msg()
{
    echo $1
}

case "$1" in

  start)
    log_begin_msg "Starting phd daemon..."
    start
    log_end_msg $?
    ;;

  stop)
    log_begin_msg "Stopping phd daemon..."
    stop
    log_end_msg 0
    ;;

  restart)
    log_begin_msg "Restarting phd daemon..."
    stop
    start
    log_end_msg $?
    ;;

  status)
    log_begin_msg "Statusing phd daemon..."
    status
    log_end_msg $?
    ;;

  upgrade)
    log_begin_msg "Upgrading phd daemon..."
    stop
    upgrade
    start
    log_end_msg $?
    ;;


  *)
    echo "Usage: /etc/init.d/${basename $0} {start|stop|restart|upgrade|status}" >&2
    exit 1
    ;;
esac

exit 0


~~~~~~~~~~~~~~~~~~~~~~~~~~
Étendre le système de parsing
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Intérpréter les images html:

    (from davidou)

    > vim /opt/phabricator/phabricator/src/extensions/CustomInlineImageRule.php 

        ***************************************
        <?php

        final class CustomInlineImageRule extends PhabricatorRemarkupCustomInlineRule {

          public function getPriority() {
            return 200.0;  // Must be lower than 300 to over URL detection
          }

          public function apply($text) {
            return preg_replace_callback(
              '(<img (.*?)>)s',
              array($this, 'markupInlineImageBlock'),
              $text);
          }

          public function markupInlineImageBlock($matches) {
            $engine = $this->getEngine();

            $text = $matches[1];
            $element = new SimpleXMLElement("<element $text />");
            $attributes = array();
            foreach($element->attributes() as $k => $v) {
              $attributes[$k] = $v;
            }
            $source_body = phutil_tag('img', $attributes);

            return $engine->storeText($source_body);
          }

        }
        ***************************************

    Une version améliorée toujours from Davidou <3:

    > vim /opt/phabricator/phabricator/src/extensions/BonjourCustomInlineRule.php

        ***************************************
        <?php

        final class BonjourCustomInlineRule extends PhabricatorRemarkupCustomInlineRule
        {
             public function getPriority() {
                return 200.0;  // Must be lower than 300 to over URL detection
              } 

            public function apply($text)
            {
                return preg_replace_callback(
                  '({bonjour ([\w]+)})s',
                  array($this, 'bonjour'),
                  $text);
            }

            public function bonjour($matches)
            {
                $engine = $this->getEngine();
            
                $type   = $matches[1];
                $getter = 'bonjour'.ucfirst($type);
                
                if(method_exists($this, $getter))   
                    $src    = $this->$getter();
                else
                    $src = 'http://robot-x.org/sites/default/files/Gilles.png';

                //$img = $this->newTag('img', array('src' => $src));
                $img = phutil_tag('img', array('src' => $src));
                return $engine->storeText($img);
            }
            
            public function bonjourMadame()
            {
                $html = file_get_contents('http://www.bonjourmadame.fr');
                if(preg_match('/<img src="(.*)" alt="/', $html, $matches))
                {
                    if(isset($matches[1]))
                        return $matches[1];
                }
                return null;
            }
            public function bonjourMademoiselle()
            {
                $html = file_get_contents('http://www.bonjourmademoiselle.fr');
                if(preg_match('/<img src="(.*)" alt="/', $html, $matches))
                {
                    if(isset($matches[1]))
                        return $matches[1];
                }
                return null;
            }

            public function bonjourAurevoir()
            {
                $html = file_get_contents('http://www.aurevoirmadame.fr');
                if(preg_match('/<img src="(.*)" alt="/', $html, $matches))
                {
                    if(isset($matches[1]))
                        return $matches[1];
                }
                return null;
            }

            public function bonjourGeexy()
            {
                $html = file_get_contents('http://geexy.fr/');

                if(preg_match_all('/<div class="photo-post-image zoom" style="background-image: url\(\'(.*)\'\);">/', $html, $matches))
                {
                    return $matches[1][0]?:null;

                }
                return null;
            }

            public function bonjourAmish()
            {
                return sprintf('http://img.izismile.com/img/img4/20110916/640/unusual_amish_mugshots_640_high_0%d.jpg', (date('d')%8)+1);   
            }

            public function bonjourRandom()
            {   
                $methods = get_class_methods($this);
                $getters = array();

                while(list(,$method) = each($methods))
                {
                    if($method != 'bonjourRandom' && preg_match('/^bonjour.+/', $method))
                        $getters[] = $method;       
                }
                
                $getter = array_rand($getters);

                return $this->$getter();    
            }
            
        }
        ***************************************

        Il faudra update le cache dans Config > Garbage Collector

            gcdaemon.ttl.markup-cache

            ex: 3600

~~~~~~~~~~~~~~~~~~~~~~~~~~
TroubleShooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Error while updating the "example" repository
        --------------------------

            https://secure.phabricator.com/T6980
    
        --------------------------
        aphlict : The notification server should not be run as root. It no longer requires access to privileged ports
        --------------------------

            Lancer aphlict avec un user non root, ex 'phabricator'

            Et regarder l'erreur dumpée:

                Pour ma part:
                    '/var/tmp/aphlict/pid' does not exist

                    --> mkdir /var/tmp/aphlict/pid


~~~~~~~~~~~~~~~~~~~~~~~~~~
subtitle 1
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        subtitle 2
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
