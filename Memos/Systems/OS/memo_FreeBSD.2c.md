=====================================================================
					U N I X - F R E E B S D
=====================================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les dossiers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    [/] : La racine du système. Tous les autres dossiers sont dedans.
    [/bin/] et [/sbin/] : Les programmes exécutables du système de base.
    [/boot/] : Les fichiers permettant le démarrage du système.
    /dev/] : Chacun des fichiers de ce dossier représente l'un de vos périphériques.
    [/etc/] : Des fichiers de configuration et tout ce qu'il faut pour gérer les DAEMONs. Vous n'avez pas fini d'en entendre parler ! ;)
    [/root/] : Dossier personnel du superutilisateur. :zorro:
    [/tmp/] : En général, les fichiers de ce dossier ne seront plus là au prochain démarrage.
    [/var/] : En quelque sorte le "journal de bord" de FreeBSD.
    [/usr/bin/] et [/usr/sbin/] : Fichiers exécutables des applications préinstallées.
    [/usr/include/] : Bibliothèques pour programmer en langage C.
    [/usr/home/] : Les dossiers personnels des utilisateurs. C'est là qu'ils rangeront tous leurs documents.
    [/usr/local/] : Les applications que vous avez installées. Lui-même est subdivisé en sous-dossiers [/usr/local/bin/], [/usr/local/etc/], [/usr/local/include/], etc.
    [/usr/src/] : Les code-sources de FreeBSD et des logiciels installés.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les utilisateurs et les groupes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$pw useradd : ajouter un utilisateur.
$pw userdel : supprimer un utilisateur.
$pw usershow : afficher les caractéristiques d'un utilisateur.
$pw usermod : modifier un utilisateur.
$pw groupadd : ajouter un groupe.
$pw groupdel : supprimer un groupe.
$pw groupshow : afficher les caractéristiques d'un groupe.
$pw groupmod : modifier un groupe.
	exemples : 	pw useradd martin -s csh -m  (-m : créer un dossier personnel)
			pw usermod martin -g wheel
			pw usermod martin -s sh


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Système
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$date ou $grdc : date du système


$shutdown -p now : éteindre
$reboot : redémarrer
$halt : hiberne, redémarrable avec le clavier


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Variables d'environnement : 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    LANG : langue de l'interface
    USER : Votre nom d'utilisateur (votre login, si vous préférez).
    EDITOR : Votre éditeur de texte préféré. Faites votre choix et, dans le fichier .login, affectez à EDITOR la valeur ee, vi, vim ou emacs.
    CDROM : Le fichier représentant votre lecteur de CD-ROM. Il se trouve dans le dossier /dev.
    MACHTYPE : Le type de microprocesseur de votre ordinateur.
    SHELL : Votre shell favori (/bin/csh).
    PATH est une liste de dossiers. Les programmes exécutables situés dans ces dossiers peuvent être appelés à tout moment en tapant juste leur nom (ex : pwd, ls, ee, echo, etc.)


Configuration :
	~/.cshrc : fichier de conf, les commandes écritent sans ce fichier sont automatiquement éxécutées à chaque fois qu'on se logue.
	/etc/csh.cshrc : fichier de config globale (s'applique à tous les cshrc)
	d'auter fichier de conf comme .login et .profile sont dispo mais pour ne pas s'éparpiller, on rassemblera les info dans le cshrc.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation de programmes :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	---------------------------------------------------------------------
	catalogue des ports (programmes dispos pour freeBSB):
	---------------------------------------------------------------------

		$portsnap fetch extract (à executer la premiere fois)
		$portsnap fetch update   

	---------------------------------------------------------------------
	Les installateurs: (éviter les mélanges)
	---------------------------------------------------------------------
		$pkg_add : download les binaires et les install au bon endroit. (plus rapide)

		$make install : systèmes des ports, il download le code-source puis le copile et installe les binaire au bon endroit. (plus adapté et maj)

		sysinstall : ajout de binaires à partir du DVD de FreeBSB (à éviter)

		Nous même : download manuel des binaires qui se trouvent tous dans le même dossier.

	---------------------------------------------------------------------
	Installer un paquet : voir http://www.freshports.org pour trouver les prorgammes appropriés:
	---------------------------------------------------------------------

	---------------------------------------------------------------------
	avec pkg
	---------------------------------------------------------------------
		$pkg_add -r <paquet> : installer un paquet
		$pkg_delete <paquet> : supprimer le paquet (écrire le nom du paquet tel que pkg_info)
		$pkg_info : chercher les infos sur un paquet
	---------------------------------------------------------------------
	avec les ports
	---------------------------------------------------------------------
		$make install clean : installer un paquet
			exemple:
				$cd /usr/port/nom_paquet && make install clean (installer un paquet)
			ou : 
				$whereis <paquet> : donne l'emplacement du port
				$cd /XX
				$ls : ce dossier contient un fichier Makefile
				$make install clean	(

		$make install clean BATCH=yes : installe le paquet avec les options par défaut
		$make config : ajuster les options avant la compilation
		$make rmconfig : supprime la config
		$make deinstall : désinstall le programme
		$make clean : permet de faire le "ménage", à utiliser si on intéromp une installation par exemple.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Environnement Graphique
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$pkg_add -r xorg : installation du mode graphique
$cd /usr/ports/x11/xorg/ && make install clean : idem, installation du mode graphique
$/usr/local/bin/Xorg -configure : configurer Xorg (créer un fichier de configuration xorg.conf.new dans le dossier /root, il est préférable de copier se fichier dans /etc/X11/xorg.conf)

$/usr/local/bin/startx : lancer l'interface graphique pour la premiere fois
$startx : lancer l'interface graphique

Activer HAL (Hardware ACtivation Layer qui s'assure de la communication entre le hardware et certaines applications) et dbus (permet à certains processus dont HAL de s'échanger des informations)
	vim /etc/rc.conf
		-> hald_enable="YES"
 		-> dbus_enable="YES

 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Recherche
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

$find : trouve n'importe quel fichier (peut être long)
$which : explore les dossiers de la variables PATH à la recherche d'éxecutables.
$locate : trouve immédiatement les fichiers répertoriés dans sa base de données.
$/usr/libexec/locate.updatedb : maj la base de données de locate.
$whereis : affiche l'emplacement d'une commande...
