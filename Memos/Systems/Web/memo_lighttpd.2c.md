======================================================
	L I G H T T P D
======================================================
~~~~~~~~~~~~~~~~~~~~
Link
~~~~~~~~~~~~~~~~~~~~

     http://redmine.lighttpd.net/projects/lighttpd/wiki/MigratingFromApache   

~~~~~~~~~~~~~~~~~~~~
Install
~~~~~~~~~~~~~~~~~~~~

> aptitude install lighttpd


Pour redémarrer ...:

> /etc/init.d/lighttpd restart


~~~~~~~~~~~~~~~~~~~~
Conf
~~~~~~~~~~~~~~~~~~~~

> cd /etc/lighttpd


	----------------
	lighttpd.conf
	----------------

		server.document-root : chemin de la racine des sites webs
		server.module : contient tout les modules activables par lighttpd

        Quelques options:

            server.follow-symlink       = "enable"  #suivre les liens symboliques.
            dir-listing.activate        = "enable"  #lister les fichiers

			(Note: il est possible d'activer directement un module par la commande: lighty-enable-mod)


	----------------
	Tester la conf:
	----------------

        lighttpd -t -f /etc/lighttpd/$fichier_de_conf

	----------------
	Nouveau modèle
	----------------

                lighttpd est décomposé en conf-available et conf-enable.
                Il suffit maintenant de rajouter un lien symbolique de available vers enable pour activer les modules.

                et de recharger la conf:

                > service lighttpd force-reload

                On peu activer/désactiver un module via ces commandes:

                > lighty-enable-mod [NOM_MODULE]  #sans le .conf et le numero devant
                > lighty-disable-mod [NOM_MODULE]

~~~~~~~~~~~~~~~~~~~~
Installation de PHP (et du support mysql)
~~~~~~~~~~~~~~~~~~~~

    > aptitude install php5-cgi php5-gd php5-mysql
    > lighty-enable-mod fastcgi fastcgi-php 

    (si l'activation du module ne fonctionne pas: ou que vous avez une erreur 403 ...)

    rajouter dans le fichier de conf lighttpd.conf le module mod_fastcgi (old version)

            > server.modules = { "mod_fastcgi", }

    > /etc/init.d/lighttpd force-reload

~~~~~~~~~~~~~~~~~~~~
Créer un Vhost
~~~~~~~~~~~~~~~~~~~~

    $HTTP["host"] =~ "(^|\.)monSite\.fr$" {
        server.document-root = "/home/lighttpd/monSite.fr/http"
        server.errorlog = "/var/log/lighttpd/monSite.fr/error.log"
        accesslog.filename = "/var/log/lighttpd/monSite.fr/access.log"
        server.error-handler-404 = "/e404.php"
    }

    On oubliera pas de seter les bons droits:

        Par exemple:

            chown -R lighttpd:lighttpd  /home/lighttpd/home/monSite.fr/http
            chown -R lighttpd:lighttpd  /var/log/lighttpd
