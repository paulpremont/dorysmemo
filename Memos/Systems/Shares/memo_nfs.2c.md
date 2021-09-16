==========================================================
                        N F S
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RPC (Remote Procedure Call)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Protocole permetant des échanges client/serveurs;
	Associe des applications à un port;
	map = enregistrement base de données;

        La librairie rpc permet aux programme C de faire des appels sur les autres hôtes du réseau;
        En premier lieu, le client appel une procédure pour envoyer des données sur le serveur.
        Lors de la reception du paquet, le serveur appel une routine de distribution (dispatch routine) pour effectuer la demande du client et lui répondre.

        Fonctionne au niveau de la couche session du modèle OSI

        RPC est un protocole permetant de faire des appels de procédures sur hôte distant.
        Il utilise le modèle client-serveur pour assurer la communication.

	rpcinfo [IP_REMOTE_HOST] : Permet de faire des appels RPC

		-p localhost : voir le mappage de port
		-u localhost ypserv : regardera l'état du programme et donnera plus d'information.

~~~~~~~~~~~~~~~~~~~~~~~~~~
NFS (Network File Sytem)
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://formation-debian.via.ecp.fr/nfs.html
    http://nfs.sourceforge.net/nfs-howto/ar01s05.html
    https://help.ubuntu.com/community/NFSv4Howto
    http://archive09.linux.com/feature/138453
    http://www.slashroot.in/how-do-linux-nfs-performance-tuning-and-optimization


	Notes: 

            lorsqu'on exporte un FS coté client, les UID, GID des fichiers (au niveau des droits) seront consultés dans le fichier passwd du client
            Aussi il faut s'assurer que les informations coté serveur et coté client soient identiques.

            Les version 1 et 2 ne sont pas sécurisées et fonctionnent over UDP
            La version 3 utilise TCP
            La version 4 est complètement réecrite pour intégrer:
                - de la sécurité (kerberos5 + certs SPKM et LIPKEY)
                - de la montée en charge 
                - reprise sur incidents
                - Maintenance simplifiée

            /!\ Les performance de NFS4 sont presque de moitié moins performant que la v3.
                Cependant on gagne au niveau de la pérénité des données en cas de crash.


        --------------------------
        Install
        --------------------------
                __________________________
                Coté serveur:

                    > apt-get install nfs-kernel-server nfs-common rpcbind

                    /!\ Pour la version v4, voir ce lien:
                        https://help.ubuntu.com/community/NFSv4Howto


        --------------------------
        Config
        --------------------------
                __________________________
                Coté serveur:

                    > vim /etc/exports

                        /PATH/SHARE host(options)

                    exemple:

                        /home/bidule *(rw)
                        /home/share     ordiX.org(rw,no_root_squash) 10.2.6.5/24(rw,sync,no_subtree_check)
                            
                            #root_squash : le root de l'hôte distant n'a pas les droits root sur le dossier partagé.
                            #no_root_squash : cette fois le root a les droits.

                            #rw : read write
                            #ro : read only
                             voir 
                                > man exports

        --------------------------
        Manipulations
        --------------------------
                __________________________
                Coté serveur:

                    On démarre les services:

                        > service rpcbind restart
                        > service nfs-kernel-server reload

                    > exportfs -a               #appliquer les nouveaux changements.
                    > showmount -e localhost    #Vérifier l'application du partage.

                __________________________
                Coté client:

                    > showmount -e SERVER      #voir les dossiers partagés sur un serveur.
                    > mount -t nfs SERVER:/PATH /PATH_TO_MOUNT #monter un dossier distant.

                        Exemple:

                             > mount -t nfs server1.org:/home/ftp /media/test

                    En cas d'erreur de type access denied:
                        
                        - Bien vérifier le hostname /ip autorisé
                        - Rajouter au besoin la version du protocole:

                        Exemple:

                            >  mount -t nfs -o v3 10.1.1.1:/mnt/share /mnt/nfs

                            ou encore:
                            >  mount -t nfs4 10.1.1.1:/mnt/share /mnt/nfs

                    Au niveau de la fstab:

                        exemples:

                            server1.org:/home/ftp  /media/test   nfs    soft,timeo=5,intr,rsize=8192,wsize=8192  0  0
                            serverZ:/home/share /mnt/share nfs rw,nfsvers=3 0 0


                    tips : trouver les hôtes partageant des ressources nfs:

                            for i in $(nmap -sP X.X.X.X-Y |grep X |cut -d"(" -f2 |cut -d")" -f1); do clear; nmap $i ; sleep 4 ; done

        --------------------------
        Behind firewall
        --------------------------

            http://doc.ubuntu-fr.org/nfs-ufw
            https://wiki.auf.org/wikiteki/NFS
            http://www.cyberciti.biz/faq/centos-fedora-rhel-iptables-open-nfs-server-ports/
            https://wiki.debian.org/SecuringNFS
            https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Storage_Administration_Guide/s2-nfs-nfs-firewall-config.html
            http://www.systutorials.com/39625/fixing-ports-used-by-nfs-server/


            /!\ rpcbind utilisera des ports dynamiques pour les fonctions suivantes :

                - RQUOTAD_PORT
                - MOUNTD_PORT
                - LOCKD_TCPPORT
                - LOCKD_UDPPORT
                - STATD_PORT

            Il est cependant possible de les fixer :

                #Debian like :

                    vim:

                        > /etc/default/nfs-kernel-server
                            #RPCMOUNTDOPTS=--manage-gids
                            RPCMOUNTDOPTS="-p 32767"

                        > /etc/default/nfs-common
                            STATDOPTS="--port 32765 --outgoing-port 32766"

                        > /etc/default/quota
                            RPCRQUOTADOPTS="-p 32769"

                        > /etc/modprobe.d/local.conf
                            options lockd nlm_udpport=32768 nlm_tcpport=32768
                            options nfs callback_tcpport=32764
                #Red hat like :

                    > vim /etc/sysconfig/nfs

                        RQUOTAD_PORT=32764
                        LOCKD_TCPPORT=32765
                        LOCKD_UDPPORT=32766
                        MOUNTD_PORT=32767
                        STATD_PORT=32768

                On redémare les services:

                    service nfs-common restart
                    service nfs-kernel-server restart
                    invoke-rc.d nfs-kernel-server restart
                    service rpcbind restart

                Vérifiez:

                    > rpcinfo -p

                On conf le firewall:

                    iptables -A INPUT -p tcp --dport 2049 -j ACCEPT
                            -A INPUT -p tcp --dport 111 -j ACCEPT
                            -A INPUT -p tcp --dport 32764:32769 -j ACCEPT
                            // -p udp

        --------------------------
        Tests de performance:
        --------------------------
            http://www.tldp.org/HOWTO/NFS-HOWTO/performance.html

            > mount -a
            > cd monPointDeMontage
            > time dd if=/dev/zero of=testfile bs=16k count=16384

        --------------------------
        Troubleshooting :
        --------------------------
            __________________________
            mount.nfs: rpc.statd is not running but is required for remote locking.

                --> start du daemon rpcbind:

                    > /etc/init.d/rpcbind start

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NIS (version 2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Permet de centraliser les infos concernant notament /etc/passwd, /etc/group, /etc/hosts ...
        C'est un complément à NFS.
	Nécessite les paquets rpcbind et ypserv (coté serveur)

	Server:

		vim /etc/sysconfig/network : éditer le fichier pour renseigner le nom de domaine ...
		domainname
		vim /var/yp/Makefile : éditer le fichier comme voulu

		domainname : vérifier que le nom de domaine NIS soit exact
		sinon domainname NIS_DOMAIN_NAME
		
		service ypserv restart
		service rpcbind restart

		rpcinfo -p localhost

	Client:

		paquet: ypbind

		configuration des priorités dans /etc/nsswitch.conf
		configuration du client nis dans /etc/yp.conf
		configuration du nom de domain NIS dans /etc/sysconfig/network
			aussi : domainname NIS_SERV_DOMAIN_NAME

		service ypbind restart
		rpcinfo -p localhost
		rpcinfo -p NIS_SERVER

		ypwhich : serveur associé au client
		ypcat MAP_NAME: consultation des maps
		ypmatch : recherche sur les maps
		yppasswd : changement du mot de passe

		Pour ensuite se loguer avec un user défini sur le serveur, ne pas oublier de monter un partage NFS avec le /home des users.
		(redefinir le Makefile)

		YOU WIN !!!

