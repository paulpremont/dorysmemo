DNS CACHING
========================

Liens
----------------

nscd/unscd :

* [possibilités](http://www.linuxtopia.org/online_books/linux_system_administration/debian_linux_guides/debian_linux_reference_guide/ch-gateway.en_012.html)
* [difference entre nscd et unsccd](http://www.ehow.com/info_10070262_difference-between-nscd-unscd.html)
* [tuto_unscd](https://www.it4it.fr/mettre-en-place-un-cache-dns-avec-unscd-sur-ubuntu/)
* [man_nscd](http://man7.org/linux/man-pages/man5/nscd.conf.5.html)

dnsmasq :

* [localhost dns cache](http://www.linuxjournal.com/content/localhost-dns-cache)
* [debian dnsmasq](https://wiki.debian.org/HowTo/dnsmasq)
* [archlinux dnsmasq](https://wiki.archlinux.org/index.php/dnsmasq)

bind9 :

* [tecmint](http://www.tecmint.com/install-dns-server-in-ubuntu-14-04/)

Plusieurs possibilités
----------------

*  Pour un simple caching de nom d'hôte en local, il vaut mieux se tourner vers nscd qui est plus simple (mais un peu deprecated ...)
* Pour faire du caching sur son hôte mais aussi avoir un système plus élaboré avec dhcp intégré et servir sur le réseau, voir dnsmasq
* Sinon pour un système orienté serveur avec plus de fonctionnalité DNS, voir bind9

nscd/unscd
----------------

unscd est la version améliorée et maintenu par la communauté Debian.
Il utilise le même schéma de configuration que nscd.
Attention à ne pas utiliser les deux conjointement. (Il faut choisir)

### Installation et configuration

    sudo apt-get install unscd

    vim /etc/nscd.conf

        ### General config for UNCD

        server-user unscd
        logfile /var/log/nscd.log
        debug-level 0
        reload-count unlimited
        paranoia no

        ### DNS cache configuration

        enable-cache            hosts       yes
        positive-time-to-live   hosts       86400
        negative-time-to-live   hosts       20
        suggested-size          hosts       211
        check-files             hosts       no
        persistent              hosts       yes
        shared                  hosts       no

    vim /etc/nsswitch.conf

        hosts:          files dns
        #ou par défaut sous ubuntu :
        hosts:          files mdns4_minimal [NOTFOUND=return] dns

Redémarrage du service :

    service unscd restart

Les bases sont stockées dans :

    /var/cache/nscd/

On peut y soustraire quelques informations avec strings :

    strings /var/cache/nscd/hosts

### Debug :

    sudo strace /usr/sbin/nscd -d -f /etc/nscd.conf


dnsmasq
----------------

### Installation

    apt-get install dnsmasq
    vim /etc/dnsmasq.conf

bind9
----------------

(voir partie caching)

### Installation

    apt-get install bind9
