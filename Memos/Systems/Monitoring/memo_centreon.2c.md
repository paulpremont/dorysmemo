==========================================================
                       C E N T R E O N
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Site officiel:
        http://documentation.centreon.com/

    Documentation:
        http://documentation.centreon.com/docs/centreon/en/latest/

    Tutos:
        http://blog.nicolargo.com/2009/01/le-serveur-de-supervision-libre-part-3.html
        http://blog.nicolargo.com/2009/02/utilisation-de-centreon.html
        http://journaldunadminlinux.fr/installer-et-configurer-centreon-entreprise-server/

        #Très bien pour commencer:
        https://blog.centreon.com/mettre-en-place-sa-premiere-supervision-configuration/?lang=fr

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    C'est un système de monitoring à la base developpé sur le coeur de nagios pour y inclure une interface graphique.

    Maintenant le projet bénéficie de son propre coeur.

    Il existe encore le choix entre les 2 versions.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Depuis une archive
        --------------------------

            > apt-get update 

            > $ apt-get install sudo tofrodos bsd-mailx lsb-release mysql-server libmysqlclient15-dev apache2 apache2-mpm-prefork php5 php5-mysql php-pear php5-ldap php5-snmp php5-gd rrdtool librrds-perl libconfig-inifiles-perl libcrypt-des-perl libdigest-hmac-perl libdigest-sha1-perl libgd-gd2-perl snmp snmpd libnet-snmp-perl libsnmp-perl

            > vim /etc/apt/sources.list

                ajouter non-free à la fin des repo deb.

            > wget http://download.centreon.com/index.php?id=4314
            > mv index.php?id=4314 centreon.tar.gz
            > tar -xvf centreon.tar.gz

        --------------------------
        Depuis l'ISO
        --------------------------

            > wget http://download.centreon.com/index.php?id=4313

            #voir http://www.centreon.fr/Article-Telechargements/telechargement-centreon-enterprise-server

            Il ne reste qu'a lancer l'iso et suivre les instructions.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Les daemons
        --------------------------

            http://documentation.centreon.com/docs/centreon/en/latest/user/get_started.html#web-user-interface

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
