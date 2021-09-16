==========================================================
                       S U P E R V I S O R
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://supervisord.org/installing.html
    http://supervisord.org/subprocess.html#nondaemonizing-of-subprocesses

~~~~~~~~~~~~~~~~~~~~~~~~~~
what is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Un gestionnaire

~~~~~~~~~~~~~~~~~~~~~~~~~~
installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Via les le gestionnaire de paquet
        --------------------------

            > apt-get install supervisor

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    /etc/supervisor/supervisord.conf #main conf
    /etc/supervisor/conf.d/*.conf  #custom conf

        --------------------------
        Ajouter un Programme
        --------------------------

            Tout les programmes doivent tourner en mode non deamonisé.
            (Foreground)

            [program:MON_PROG]
            command=/lancement/en/foreground

                __________________________
                D'autres directives:

                    autostart=true
                    autorestart=true
                    stderr_logfile=/path/log.err.log
                    stdout_logfile=/path/log.out.log

                    user=MON_USER
                    environnement=VAR="Value",VAR2="value2"
                __________________________
                Exemples

                        Apache
                        ``````````````````````````
                            [program:apache2]
                            command=/path/to/httpd -c "ErrorLog /dev/stdout" -DFOREGROUND
                            redirect_stderr=true

                        OpenLDAP
                        ``````````````````````````
                            [program:slapd]
                            command=/path/to/slapd -f /path/to/slapd.conf -h ldap://0.0.0.0:8888
                            redirect_stderr=true

                        Mysql
                        ``````````````````````````
                            [program:mysql]
                            command=/path/to/pidproxy /path/to/pidfile /path/to/mysqld_safe

                        xinetd
                        ``````````````````````````
                            [program:xinetd]
                            command=/usr/sbin/xinetd -pidfile /var/run/xinetd.pid -stayalive -inetd_compat -dontfork

                        tomcat7
                        ``````````````````````````

                            [program:tomcat7]
                            environment=JAVA_HOME="/usr/lib/jvm/default-java",CATALINA_HOME="/usr/share/tomcat7",CATALINA_BASE="/var/lib/tomcat7",JAVA_OPTS="-Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC",CATALINA_PID="/var/run/tomcat7.pid",CATALINA_TMPDIR="/tmp/tomcat7-tomcat7-tmp",LANG="en_US.UTF-8",JSSE_HOME="/usr/lib/jvm/default-java/jre/"
                            command=/usr/share/tomcat7/bin/catalina.sh start
                            stdout_logfile=/var/log/tomcat7/tomcat.log

                            
                            /!\ Avec une erreur au niveau du processus une fois lancé on ne peut voir son status ni le redémarrer sans killer le processus à la main ...

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Deamon
        --------------------------

            > service supervisor start

        --------------------------
        Options
        --------------------------

            supervisord 
                --help : affichje l'aide
                -c : MON_FICHIER_CONF
                -n : LANCEMENT EN FOREGROUND

        --------------------------
        Gérer les process avec supervisord
        --------------------------

            > supervisorctl status
            > supervisorctl restart monProcess

            ...

                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
