==========================================================
                       B I N D 9
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

        http://coagul.org/drupal/node/140/
        http://doc.ubuntu-fr.org/bind9
        http://www.commentcamarche.net/contents/internet/dns.php3
        https://wiki.debian.org/Bind9

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it ?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Bind9 est un serveur dns opensource lux

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Types d'enregistrement
        --------------------------

            Enregistrement          : Correspondance

            A <@IP>                 :  IP -> Nom de machine
            CNAME <alias>           : Nom de machine -> Nom de machine
            MX <priorite> <alias>   : Nom de machine -> Serveur de mail
            NS <alias>              : Nom de machine -> Serveur de nom (on peut définir plusieurs serveurs)
            SOA <sid> <admin mail>  : Start Of authority (indique le dns ayant authorité sur la zone)
            PTR                     : Pointeur sur une autre partie du dns

            Exemple:

                @   IN  SOA dns.domain.lan. admin.domain.lan. (
                                  2     ; Serial
                             604800     ; Refresh
                              86400     ; Retry
                            2419200     ; Expire
                             604800 )   ; Negative Cache TTL
                ;
                @   IN  NS  dns.domain.lan.  ;
                dhcp    IN  A   10.1.1.1    ;
                web IN  A   10.1.1.10   ;
                wordpress IN  CNAME   web     ;

        --------------------------
        Modes de fonctionnement
        --------------------------

                __________________________
                Serveur cache: 
                    
                    Place les réponses DNS en cache (permet de gagner de la bande passante)
                __________________________
                Serveur maître:

                    Contient l'ensemble des enregistrements d'un nom de domaine (= zone)

                __________________________
                Serveur esclave:

                    Permet de servir certaine zones et de gagner en repartition de charge ...

                __________________________
                Serveur Hybrides:

                    Combines les configurations présentées.

                __________________________
                Serveurs furtifs:

                    C'est la configuration d'un serveur maître ou esclave mais de façon à n'être visible que depuis le lan.

                __________________________
                Serveurs Récursifs / Non récursifs 

                    Par défaut Récursif sous Bind9, ils interrogent tour à tour les serveurs DNS nécessaires jusqu'à obtenir la réponse, et la transmettre à leur client.
                Dans l'autre cas, le serveur DNS délègue la résolution du nom de domaine à un autre serveur DNS.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install bind9

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Vérifications préalables
        --------------------------


            L'ordre des requêtes:

                vim /etc/host.conf

                    order hosts, bind
                    multi on

            Nom du serveur:

                vim /etc/hosts

                    127.0.0.1   localhost
                    192.168.1.2 ns.polo-domain.lan

            Les autres serveur de noms (dans le cas ou il ne trouve pas de corrspondance)

                vim /etc/resolv.conf

                    domain polo-domain.lan  #Nom du domaine.
                    search polo-domain.lan  #Nom ajouter lors de la résolution de nom
                    nameserver 192.168.1.2  #(Ip du DNS primaire)
                    #nameserver X.X.X.X     (Ip du DNS secondaire)

        --------------------------
        Fichiers de conf
        --------------------------

            cat /etc/bind/named.conf

                include "/etc/bind/named.conf.options";         #options globales du serveur
                include "/etc/bind/named.conf.local";           #Définit les zones et leur mode de fonctionnement
                include "/etc/bind/named.conf.default-zones";   #Zones par défauts

        --------------------------
        Zones
        --------------------------
                __________________________
                Définition du mode de fonctionnement et des fichiers de zones:

                    > vim /etc/bind/named.conf.local

                        zone “polo-domain.lan” {                #Indique le nom du domaine
                            type master;                    #Indique le type serveur de Bind
                            file “/etc/bind/db.polo-domain.lan”;        #fichier de correspondance Ip/Noms
                        };

                        #Résolution inverse
                        zone “0.168.192.in-addr.arpa” {
                            type master;
                            file “/etc/bind/db.192”;
                            notify no;
                        };

                __________________________
                Enregistrements:

                    > cp /etc/bind/db.local /etc/bind/db.polo-domain.lan

                        $TTL    604800
                        @   IN  SOA ns.polo-domain.lan. admin.polo-domain.lan. (
                                    2011121502  ; Serial    #A changer à chaque modifications (Date US + 01)
                                    604800      ; Refresh   #Délai avant que les esclave vérifie vérifie la présence du maitre
                                    86400       ; Retry
                                    2419200     ; Expire
                                    604800 )    ; Negative cache TTL        #Durée de vie minimum du cache
                        ;
                        @   IN  NS  ns.polo-domain.lan.     ; permet au serveur de se reconnaître
                        ns  IN  A   192.168.1.2             ; idem
                        dhcp    IN  A   192.168.1.3         ; Nom correspondant au serveur dhcp

                    
                    #résolutin inverse:
                    Copier le fichier db.127 → db.192

                        $TTL    604800
                        @   IN  SOA ns.polo-domain.lan. admin.polo-domain.lan. (
                                    2011121502  ; Serial            
                                    604800  ; Refresh        
                                    86400       ; Retry         
                                    2419200 ; Expire
                                    604800 )    ; Negative cache TTL    
                        ;
                        @   IN  NS  ns.
                        2   IN  PTR ns.polo-domain.lan.         ; #1er Chiffre à remplacer par le dernier Octet de l'IP du serveur.

        --------------------------
        Options
        --------------------------

            vim /etc/bind/named.conf.options

            #Autoriser la récursivité pour tout les hôtes:

                allow-recursion { any; };
                        

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Le deamon:

            service bind9 restart|reload ...

        Les logs:

            tail -50 /var/log/syslog

        Tests:

            ping ns

            named-checkzone polo-domain.lan /etc/bind/db.polo-domain.lan
            named-checkzone polo-domain.lan /etc/bind/db.192

            host ns
            host 192.168.1.2 

            nslookup ns
            nslookup 192.168.1.2 
            
            dig 0.168.192.in-addr.arpa.    AXFR
            dig ns.polo-domain.lan
            dig -x 192.168.1.2 

                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
