==========================================================
                      S Q U I D
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Site officiel:
        http://www.squid-cache.org/

    SquidGuard:
        http://irp.nain-t.net/doku.php/220squid:060_squidguard

    Doc sur les différents type de proxy:
        http://secureleaves.com/tag/reverse-proxy/

    Tutos squid:
        http://www.systemx.fr/linux/squid/squidconf.html

    Tutos squid transparent:
        https://stux6.net/unix/linux/proxy-transparent-linux-squid
        http://wiki.alpinelinux.org/wiki/Setting_up_Transparent_Squid_Proxy
        

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Squid est un serveur proxy et reverse proxy pour le flux http(s), ftp et gopher.
    Il permet de mandater les requêtes des clients vers l'exterieur mais aussi vers son réseau local (reverse proxy).
    Il sert principalement de cache pour accélerer les réponses aux requêtes clientes mais aussi de filtre web (squidGuard).

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install squid3 squidguard [apache2]

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Générale
        --------------------------

            > vim /etc/squid3/squid.conf
            > mv /etc/squid3/squid.conf /etc/squid3/squid.conf.back
            > egrep -v "^#|^$" squid.conf.back > /etc/squid3/squid.conf

                __________________________
                Exemple de conf:

                    #------------DEFAULT ACL-------------------
                        #C'est ici que l'on nomme les différents élements pour ensuite être utilisé par squid!

                    acl manager proto cache_object
                    acl localhost src 127.0.0.1/32 ::1
                    acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
                    acl SSL_ports port 443
                    acl Safe_ports port 80		# http
                    acl Safe_ports port 21		# ftp
                    acl Safe_ports port 443		# https
                    acl Safe_ports port 70		# gopher
                    acl Safe_ports port 210		# wais
                    acl Safe_ports port 1025-65535	# unregistered ports
                    acl Safe_ports port 280		# http-mgmt
                    acl Safe_ports port 488		# gss-http
                    acl Safe_ports port 591		# filemaker
                    acl Safe_ports port 777		# multiling http
                    acl CONNECT method CONNECT

                        #bigfoo regroupera toutes les ips commençant par 10.X.X.X
                    acl bigfoo src 10.0.0.0/8

                    #------------DEFAULT ACCESS-------------------
                    http_access allow manager localhost
                    http_access deny manager
                    http_access deny !Safe_ports
                    http_access deny CONNECT !SSL_ports
                    http_access allow localhost

                        #On autorise notre acl déclaré precedement à sortir sur internet
                    http_access allow bigfoo

                    #http_reply_access allow all (default)

                        #Enfin on refuse tout le reste
                    http_access deny all

                    #------------SQUIDGUARD-------------------
                        #Cette partie active squidguard, il fonctionne de manière indépendante.
                    redirect_program /usr/bin/squidGuard -c /etc/squid3/squidGuard.conf
                    redirect_children 5

                    #------------PORT-------------------
                        #Correpond aux différents port d'écoutes:
                    
                        #requêtes clientes:
                    http_port 3128
                        #Intercache Communication Protocol servant aux serveurs de cache à échanger des infos
                    icp_port 0
                        #Hyper Text Caching Protocol servant à la découverte de serveurs cache ...
                    htcp_port 0


                    #------------CACHE-------------------
                    positive_dns_ttl 1 day
                    negative_dns_ttl 1 hour

                    #------------OTHER-------------------
                    visible_hostname squid
                    access_log /var/log/squid3/access.log

                    hierarchy_stoplist cgi-bin ?
                    coredump_dir /var/spool/squid3
                    refresh_pattern ^ftp:		1440	20%	10080
                    refresh_pattern ^gopher:	1440	0%	1440
                    refresh_pattern -i (/cgi-bin/|\?) 0	0%	0
                    refresh_pattern .		0	20%	4320


        --------------------------
        Transparent
        --------------------------

            #http_port 3128 transparent
            #ou pour les version plus récentes > 3.1
            http_port 3128 intercept
            http_access allow all

            Il faudra ensuite configurer le firewall pour rediriger les flux sur le proxy

            exemple:
                    iptables -t nat -A PREROUTING -j DNAT -p tcp -s $lan --dport 80 --to $proxy:3128
                    iptables -t nat -A PREROUTING -j DNAT -p tcp -s $lan --dport 443 --to $proxy:3128

            Si l'on souhaite rediriger d'autre type de flux, il faudra les router au niveau du proxy:

                echo 1 > /proc/sys/net/ipv4/ip_forward
                iptables -t nat -A POSTROUTING -o MON_INTERFACE -j MASQUERADE

        --------------------------
        SquidGuard
        --------------------------

                __________________________
                Récupération d'une blacklist

                    Pour le filtre des URL, l'université de Toulouse met à disposition une base de données:

                    > wget ftp://ftp.univ-tlse1.fr/pub/reseau/cache/squidguard_contrib/blacklists.tar.gz

                    > tar zxvf blacklists.tar.gz -C /var/lib/squidguard/db/
                    > mv /var/lib/squidguard/db/blacklists/* /var/lib/squidguard/db/
                    > rm -Ri /var/lib/squidguard/db/blacklists

                __________________________
                Exemple fichier de conf:

                    > vim /etc/squid/squidGuard.conf

                    #--------CONFIG FILE--------------
                    #Définitions des fichiers de configuration
                    dbhome /var/lib/squidguard/db
                    logdir /var/log/squid

                    #------------SOURCES-------------
                    #on définit ici les source (comme acl pour squid)

                    src foo {
                        ip		10.0.0.0/8
                    }

                    #------------CLASSES-------------
                    #on défini les bloques qui serviront de filtre:

                    dest adult {
                        domainlist	adult/domains
                        urllist		adult/urls
                        expressionlist	adult/expressions
                    }

                    #------------ACL-------------
                    #on applique les acl sur les sources définies précedement:

                    acl {
                        foo {
                            pass	 !adult any
                            redirect http://127.0.0.1/cgi-bin/squidGuard.cgi?clientaddr=%a&srcclass=%s&targetclass=%t&url=%u
                        }

                    }

        --------------------------
        Clients
        --------------------------

            En mode non transparent:
                Rajouter au niveau du browser les infos:
                    Port d'écoute: 3128
                    IP du proxy

            Et jouer avec les règles de firewall pour rediriger le flux sur le proxy.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Daemon
        --------------------------

            service squid3 reload|restart ....
    

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


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Authentification 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	todo

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Reverse proxy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	todo


