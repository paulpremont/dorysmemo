Systemd
==============================

What is it ?
-----------------------------

Systemd est le nouveau système d'initialisation et de gestion de service de Linux qui vient remplacer petit à petit systemV (SysVinit) et Upstart.
Il permet de lancer, au démarrage, plusieurs services parallélement contrairement à SystemV qui le fait séquentiellement.
Il bénéficie d'amélioration multiple dans la gestion des services mais reste assez controversé notament par son mécanisme qui ne respecterai pas la philosophie KISS.

Links
-----------------------------

### Official

* [Systemd sur Archlinux](https://wiki.archlinux.fr/Systemd)

### Tutos

* [Guide général sur les logs](https://www.loggly.com/ultimate-guide/linux-logging-with-systemd/)

### Infos

* [Article sur systemd et l'init](http://linuxfr.org/news/systemd-l-init-martyrise-l-init-bafoue-mais-l-init-libere)
* [Autre article sur systemd vs upstart et system V](http://connect.ed-diamond.com/GNU-Linux-Magazine/GLMF-153/Systemd-vainqueur-de-Upstart-et-des-scripts-System-V)

### Alternatives

* [Un site qui prône l'anti systemd et les distributions qui en l'utilise pas](http://without-systemd.org/wiki/index.php/Main_Page)
* [OpenRC côté Gentoo](https://wiki.gentoo.org/wiki/OpenRC)
* [Userlessd, le fork de systemd](http://uselessd.darknedgy.net/)


How it works ?
-----------------------------

Systemd est écrit en C et regroupe une collection de binaires (systemd, journalctl, udev, systemctl ...)

Il permet notamment de :

* Allouer finement les ressources aux services
* Ajoute une couche de log (journald) sans nécessité d'installer syslog. (mais il est possible de faire cohabiter les deux)
* Meilleure surveillance (cgroup ...)
* Démonisation simplifiée pour tous processus
* Séparation distincte entre services de la distribution et celui de l'administrateur.
* Système de templating


Installation
-----------------------------

Configuration
-----------------------------

Manipulations
-----------------------------
