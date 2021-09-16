==========================================================
                       S G B D
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://fadace.developpez.com/sgbdcmp/
    http://fr.wikipedia.org/wiki/Syst%C3%A8me_de_gestion_de_base_de_donn%C3%A9es

    http://fr.openclassrooms.com/informatique/cours/administrez-vos-bases-de-donnees-avec-mysql
    http://dev.mysql.com/

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Un SGBD (Système de Gestion de Base de Données) ou un DBMS en anglais (Database Management System) est un système permetant de manipuler directement une base de données.
    C'est lui qui est responsable des opération de stockage et de mise à disposition des données en assurant leur pérennité.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Modèles
        --------------------------

            Les différents modèle permettent de traduire le réel dans le but de le faire fonctionner sur n'importe quel autre sgbd qui le supporte:

            Réel 
            -> Conceptuel (Indépendant du modèle de donnée et de la SGBD)
            -> logique (Relationnel, Objet ...) (dépendant du modèle de données et indé de la SGBD)
            -> Physique (Dépendant du modèle de données et de la SGBD)

        --------------------------
        Conception
        --------------------------

            Suivre une méthode de conception est très importante pour la bonne mise en oeuvre d'une base de données.

            Pour éviter des problèmes de redondances, de valeurs nulles , de gestion ...

                Exemple:
                    Merise, UMl, E/A

            /!\ aux termes employés au niveau conceptuel ou relationnel.

            Note: Merise est une méthode qui a l'avantage d'être orientée vers le relationnel, c'est une méthode d'analyse.

            Alors qu'UML est plus orienté objet et permet surtout de modéliser une application.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Il faut choisir un système de base de données.
    Il en existe plusieurs les requêtes peuvent différées pour certains élements.
    Mais la syntaxe globale reste casiment identique.

        --------------------------
        MysQL
        --------------------------

	    > apt-get install mysql-server

        --------------------------
        PostgreSQL:
        --------------------------

        --------------------------
        Oracle:
        --------------------------

            http://doc.ubuntu-fr.org/oracle
            https://docs.oracle.com/cd/E17781_01/index.htm


            Via l'iso Oracle Linux:

            Via la version allégée : Database 11 g:
                Lien rpm:
                    http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html

                Liens avec plus de produits:
                    http://www.oracle.com/technetwork/database/enterprise-edition/downloads/112010-linx8664soft-100572.html
                    http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

                    Docs:
                        http://www.oracle.com/technetwork/database/enterprise-edition/documentation/index.html

                    Doc X11 g2 r2:
                        https://docs.oracle.com/cd/E11882_01/index.htm

                    Install:
                        https://docs.oracle.com/cd/E11882_01/install.112/e24326/toc.htm#BHCJCGCB

                Tuto d'install ubuntu:
                    http://www.makina-corpus.org/blog/howto-install-oracle-11g-ubuntu-linux-1204-precise-pangolin-64bits

            Via docker:
                > docker search oracle |grep -i xe

                Exemple:

                    https://index.docker.io/u/wnameless/oracle-xe-11g 

                    docker-oracle-xe-11g
                        > docker pull wnameless/oracle-xe-11g

                    Run with 22 and 1521 ports opened: 
                        > docker run -d -p 49160:22 -p 49161:1521 wnameless/oracle-xe-11g

                    Connect database with following setting: 
                        hostname: localhost 
                        port: 49161 
                        sid: xe 
                        username: system
                        password: oracle

                    Password for SYS: 
                        oracle

                    Login by SSH: 
                        > ssh root@localhost -p 49160 password: admin 


~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        MysQL
        --------------------------

            Partie serveur:
                
                > vim /etc/mysql/my.cnf

                Ecouter sur toutes les interfaces:
                    bind-address 0.0.0.0

                Autoriser les connexions externes:

                    GRANT ALL ON *.* to root@'192.168.1.X' IDENTIFIED BY 'password';
                    FLUSH PRIVILEGES;

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        MysQL
        --------------------------
		
                __________________________
                Connexion:
                    mysql -u <user> -p

                        --> entrer ensuite le mot de passe

                __________________________
                Réinitialiser le pwd:

                    Plein de méthodes :p 

                    La méthode qui ne fonctionne pas:

                        > service mysql reset-password

                    Une autre:

                        > dpkg-reconfigure mysql-server-MA_VERSION 
                    
                    La pas sécure:

                        service mysql stop
                        mysql_safe --skip-grant-tables --skip-networking &
                        #(ou avec myslq)

                        mysql -h localhost
                            USE mysql
                            UPDATE user
                            SET password = password('$PASSWORD')
                            WHERE USER = 'root' AND host = 'localhost';
                            quit
                        mysqladmin shutdown
                        service mysql start

                    On peut aussi passer par l'utilisateur system debian:


                            Note: il existe un user system, mais par contre, voir son niveau de privilège:

                                    > cat /etc/mysql/debian.cnf
                                    > mysql -u debian-sys-maint
                                    > use mysql;

                    Pour supprimer le mot de passe root (très peu conseillé !)

                        > mysqladmin -u root -proot password ''
                        ou
                        > SET PASSWORD FOR root@localhost=PASSWORD('');

                __________________________
		Affichage:
			base : show databases;
			table : show tables;
			colonnes: show columns from <table>;

			ou describe <table>; -- ? à tester

                __________________________
		Charger un fichier sql:

			> source /path/to/file.sql;

                __________________________
                Exportation du schema:

                        > mysqldump -u root -p --no-data dbname > schema.sql

                __________________________
		Créer un utilisateur:

                        http://dev.mysql.com/doc/refman/5.0/fr/grant.html

			Avec tout les privilèges:

				GRANT ALL PRIVILEGES ON *.* TO 'USER'@'HOSTNAME'
                                IDENTIFIED BY 'PASSWORD' WITH GRANT OPTION;

			Sur une base seulement, remplacer le premier * par le nom de la base: mabase.*
                        Le hostname peut être localhost

                __________________________
		Supprimer un utilisateur:

                        REVOKE ALL PRIVILEGES,GRANT FROM username;

                        ou (version antérieur à Mysql 4.1.2)

                        REVOKE ALL PRIVILEGES FROM username;
                        REVOKE GRANT OPTION FROM username;

                __________________________
		Changer l'emplacement de votre base:

                        Stopper le démon:
                                /etc/init.d/mysql stop

                        On bouge la base dans son nouveau dossier:
                                mv /var/lib/mysql/mysql /new/location/mysql

                        On reconf le démon
                                vim /etc/mysql/my.cnf
                                        datadir = /new/location

                        Droits:
                               chmod -R mysql:mysql /new/location

                        Autre méthode: 
                                
                               Faire avec mount -o bind

                               backup:
                                       /etc/init.d/mysql stop
                                       mv /var/lib/mysql /var/lib/mysql_back
                                       mkdir /new/location
                                       cp -R /var/lib/mysql_back/* /new/location/
                                       mkdir /var/lib/mysql
                                       mount -o bind /new/location /var/lib/mysql
                                       chown -R mysql:mysql /var/lib/mysql
                                       /etc/init.d/mysql start

                __________________________
                Exporter une base:

                        Via mysqldump:
                        ``````````````````````````
                                exemple:

                                mysqldump -h localhost -u USER -p PASSWORD -rFICHIER_OUT.sql BASE_TO_EXPORT

                                Tout exporter:

                                        mysqldump -A > /backup/databases.sql
                                        ou
                                        mysqldump --alldatabases > databases.sql

                __________________________
                Importer une base:

                                mysql -h HOST -u USER -p PASS BASE < FICHIER

        --------------------------
        PostgreSQL:
        --------------------------

		Connexion:
			psql <base>
		
		Commandes utiles postgreSQL:

			\? : liste commandes postgreSQL
			\d : liste des tables
			\d <table> : description table
			\h : liste des commandes SQL
			\h <commande> : syntaxe de la commande
			\l : liste des bases
			\q : quitter
			\i fichier.sql : lit les instructions du fichier.sql

        --------------------------
        Oracle:
        --------------------------

            Il faut utiliser un client de type sqlplus pour se connecter à la base oracle.

		Connexion:
			rlwrap sqlplus <user>/<password>@<tnsname>

		Affichage:
			base: SELECT * FROM v$database; (Affiche toutes les vues disponibles)
			table: 	SELECT table_name FROM user_tables; (tables du schéma de l'utilisateur courant)
				SELECT table_name FROM all_tables; (tables accessibles par l'utilisateur)
				SELECT table_name FROM dba_tables; (Affiche toutes les tables, nécessite les droits admin)
			colonnes: Select COLUMN_NAME from USER_TAB_COLUMNS where TABLE_NAME = 'Nom_TABLE';
                __________________________
                Créaion de base de données:

                    Sous Oracle la base est propre à l'environnement de connexion.
                    Nous n'avons donc pas de création de base comme sous mysql.

                    https://docs.oracle.com/cd/B28359_01/server.111/b28310/create003.htm#ADMIN11074

                __________________________
                Création d'un nouvel utilisateur:

                    http://oracle.developpez.com/guide/administration/adminuser/

                    create user toto identified by motdepasse default tablespace sontablespace [temporary tablespace sontemp]

                    grant create session to toto;
                    ou
                    grant connect to toto;

                    exemples:
                        CREATE USER scott IDENTIFIED BY tiger;
                        GRANT connect, resource TO scott;

                    Modifier un mot de passe:
                        ALTER USER < login de l'utilisateur > IDENTIFIED BY < nouveau mot de passe > REPLACE < ancien mot de passe > 


                __________________________
                Importer une procédure, un fichier sql:

                    @/path/to/sql/file


        --------------------------
        Appeler une procédure
        --------------------------

            exec NOM_PROCEDURE("ARGUMENTS");
		
