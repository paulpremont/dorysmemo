===========================================================
		P I W I K
===========================================================

Piwik est une plateforme d'analyse ouverte très performante permetant d'avoir un maximum de détails sur l'activité d'une pateforme web par exemple.

http://piwik.org/docs/

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Prérequis
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://piwik.org/docs/requirements/

	-------------------------
	Versions
	-------------------------
                -Un serveur Web
                -PHP >= 5.3.2 
                -Mysql >= 4.1

                activer pdo : http://fr2.php.net/pdo
                actier pdo_mysql : http://fr2.php.net/pdo_mysql

	-------------------------
	Création de la base
	-------------------------

                > mysql -uroot -p

                $ mysql -uroot -p
                mysql> CREATE DATABASE piwik;
                mysql> CREATE USER 'piwik'@'localhost' IDENTIFIED BY 'password';
                mysql> GRANT ALL PRIVILEGES ON piwik.* TO 'piwik'@'localhost' WITH GRANT OPTION;

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
http://piwik.org/docs/installation/

	-------------------------
	Récupération de l'archive
	-------------------------

                wget http://builds.piwik.org/latest.zip
                unzip latest.zip

                chown -R www-data:www-data piwik

	-------------------------
	Configuration du vhost
	-------------------------

                Selon votre serveur http.
                mettre en https de préférence !

	-------------------------
	Finition de l'installation
	-------------------------

                La suite de l'installation se fait interactivement par interface web.
                à la fin un code en JS est donné pour le mettre sur ses pages web pour que piwik puisse obtenir des statistics.
                Le code doit être placé sur chaque page avant le <body>


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        TODO
