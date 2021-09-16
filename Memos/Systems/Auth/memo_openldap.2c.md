==========================================================
                       O P E N L D A P
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Docs:
        http://www.openldap.org/doc/admin24/
        http://www-sop.inria.fr/members/Laurent.Mirtain/ldap-livre.html
        https://www.centos.org/docs/5/html/CDS/ag/8.0/Creating_Directory_Entries-LDIF_Update_Statements.html

    Tutos:
        http://doc.ubuntu-fr.org/openldap-server
        https://help.ubuntu.com/lts/serverguide/openldap-server.html
        http://www.zytrax.com/books/ldap/ch1/
        http://www-lor.int-evry.fr/~michel/LDAP/SASL/ActivationSASL.html#config-slapd-conf
        http://www.freebsd.org/doc/en/articles/ldap-auth/client.html
        http://varrette.gforge.uni.lu/download/polys/Tutorial_LDAP.pdf
        http://pegasus45.free.fr/index.php?title=Ubuntu_10.04:_Installation_d%27un_serveur_OpenLDAP_2.4.21
        https://wiki.debian.org/LDAP#Using_LDAP
        https://wiki.debian.org/LDAP/OpenLDAPSetup
        https://wiki.debian.org/LDAP/PAM
        https://wiki.debian.org/LDAP/NSS

    Issues:
        http://www.openldap.org/faq/data/cache/157.html
        http://stackoverflow.com/questions/19537319/change-basedn-in-openldap

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    LDAP ( Lightweight Directory Access Protocol ) est un protocol permettant la consultation et la modification d'annuaire.
    Il a aussi pour but d'uniformiser les mécanismes de service d'annuaire.

    Fonctionne sur les réseau TCP/IP basé sur le schéma client/serveur.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Les clients interogent les serveurs LDAP qui renvoient directement l'information ou une redirection (referrals) vers un autre serveur.
    L'annuaire est un arbre hierarchique de données représenté par le DIT (Directrory Information Tree).

        --------------------------
        Les modèles
        --------------------------

            LDAP s'organise au travers de 5 modèles de références:

                __________________________
                1) Modèle informationnel:

                    Définit les types de données:

                        -les entrées:
                        ``````````````````````````
                            Constituées d'un ensemble d'attributs;

                        -Les attributs:
                        ``````````````````````````
                            Correspondent à un couple clé/valeur (clé: valeurs) et doivent appartenir à une classe d'objet.

                Exemple d'une entrée avec deux attributs:

                    dn: cn=Nom lambda,dc=domaine,dc=com
                    cn: cn= Nom lambda
                    givenName: lambda

                    Note: l'attribut "dn" n'est en fait pas considéré comme tel. Il faut le voir comme l'identifiant de l'entrée.

                        -Les classes d'objets:
                        ``````````````````````````
                            Elles Définissent leurs propres structures et les attributs qui la compose.

                            Caractérisées par :

                                    -Un nom unique;
                                    -Un OID (ObjectIdentifier);
                                    -Des attributs obligatoires (MUST);
                                    -Des attributs facultatifs (MAY)
                                    -un type :

                                        °abstraite: héritage seul possible, non instanciable 
                                        °structurelle: instanciable, création d'entrées possible.
                                        °auxiliaire: non instanciable, ajout possible d'attributs à une classe structurelle.

                            Exemple layout de classes:

                                            top (abstract)
                                    
                                    taxi (structuré)	taxi_company (auxilaire)
                            
                            taxi_garage (structuré)

    
                            La classe taxi hérite de la classe top;
                            Les attributs de top sont disponibles;
                            La classe taxi_company hérite de la classe top;
                            La classe taxi_company complète la classe taxi (pas d'instanciation)
                            La classe taxi_garage herite de la classe taxi;
                            Les attributs de taxi sont disponibles.


                Voici un petit layout pour représenter tout ça:
                    http://www.zytrax.com/books/ldap/ch2/index.html#basic

                Et un petit tableau pratique recensant quelques attributs et classes:
                    http://www.zytrax.com/books/ldap/ape/

                __________________________
                2) Modèle de nommage

                    Définit le DIT (organisation) et les normes de référencement.

                                L'arborescence se nomme DIT (Directory Information Tree) 
                                        -décrit par l'entrée rootDSE (root Directory Specific Entry)
                                        -sa racine est la root entry
                                        -chaque noeuds équivaut à une entrée DSE (Directory Service Entry)
                                        -Chaque noeud et entrée est unique mais leur classe d'objet peut être réutilisée.

                                        DIT Layout: 


                                        (.dc=net)<-----(.dc=fr).---->(.dc=com)		[Root domain]	
                                                        |
                                                        |
                                                        v
                                                --------(.dc=premont)			[Organisation]
                                                |		|
                                                |       	|
                                                v		v
                                                (.ou=users)	(.ou=computers)		[Organisation Unit]
                                                |
                                                |
                                                v
                                                (.uid=dupont)				[Persons]

                                Pour accéder à une entrée, on passe par le DN (Distinguished Name) qui correspont au path (ce dernier peut être relatif "RDN").

                                Quelques attributs pour éxprimer un dn:

                                        dc = domain component (les éléments qui composents le domaine)
                                        ou = organisation unit (les branches de l'arbre soumisent à des règles spécifics)
                                        cn = common name: contient le nom d'un objet, souvent le nom entier d'une personne.
                                        o = organisation name
                                        sn = surname (nom de famille d'une personne)
                                        dn = distinguished name
                                        uid = user identifier

                                Exemple:

                                        pour accéder à l'entrée bidul, voici ce que pourrait donner le path:

                                                dn:cn=bidul,ou=pilote,dc=roissy,dc=fr

                                        Dans le cas d'un path relatif, si nous nous trouvons au niveau de dc=roissy,dc=fr, le path serait;
                        
                                                rdn:cn=bidul,ou=pilote
				
                __________________________
                3) Modèle fonctionnel

                    Définit l'accès et la manipulation des données.

                    Voici quelques opération:

                            search:  	Rechercher avec critère
                            compare: 	Comparer deux objets.
                            add:		Ajouter une entrée.
                            modify:		Modifier une entrée.
                            rename:		Renommer une entrée.
                            bind:		Se connecter à un serveur.
                            unbind:		Pour se déconnecter
                            abandon:	Arrêter une opération.
                            extended:	Créer une opération.

                __________________________
                4) Modèle Sécuritaire

                    Définit les modes d'authentification et de chiffrement.

                        Il définit les protocoles à utiliser et des règlees de sécurité pour les aspects suivant:

                        -authentification
                        -signature
                        -chiffrement
                        -filtrage réseau
                        -ACL d'accès aux données
                        -logs

                __________________________
                5) Modèle de réplication:

                    Définit la répartition du schéma au niveau des différents serveurs.

                    Réplication:
                        Copie de l'annuaire sur des serveurs esclaves.
                        Voir deamon slurpd.

                    Distribution:
                        Répartition du schéma de l'annuaire sur plusieurs serveurs.

        --------------------------
        Le format LDIF
        --------------------------

                        LDIF (LDAP Data Interchange Format).
			Ce format permet de représenter les donées LDAP sous un format texte afin qu'elles puissent être manipulées plus facilement. 
			L'importation et l'exportation de celles-ci se font par l"intérmédiaires de script.


			Quelques règles:

				# en début de fichier pour les comment
				un espace en début de ligne correspond à la suite de la précedent.
				Chaque entré est séparée par un espace


        --------------------------
        Le client (Linux)
        --------------------------

            Les postes linux ont besoins des outils pour intérroger le serveur LDAP mais aussi de configurer NSS et PAM.
                __________________________
                PAM: (Pluggable Authentication Module)

                    PAM sert à configurer les modules d'authentifications possibles.
                    Il sert pour l'authentification, l'autorisation et le changement de mot de passe.

                __________________________
                NSS: (Name Service Switch)

                    NSS permet d'indiquer où sont stockées les différentes sources d'informations pour les fichier unix usuel type /etc/passwd ...

                    Par exemple indique que /etc/passwd peut se trouver en local mais aussi sur le serveur ldap.

                    On configure le fichier nsswitch.conf pour ordonner les sources d'authentification.
                        
                        Ce fichier à la forme:
                            
                            fichier: type_auth1 type_auth2 [options]

                __________________________
                SSSD: System Security Services Daemon

                    Solution à voir fournissant les modules PAM et NSS.
                    Avec le support du caching et du mode offline.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Lexique
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Schéma d'annuaire = ensemble de toutes les classes d'objets et d'attributs disponibles.
		C'est le pilié de la structure logique de l'annuaire.

	GDS : Global Directory Service = Service répondant à des requêtes clientes afin de fournir différente sortes d'informations contenues dans des dossiers. Ils permettent d'avoir une vision uniforme sur les données. Les GDS se basent généralement sur la norme X.500

	X.500 : C'est une norme sur lequel s'appuie les GDS et inclue plusieurs protocols (DAP, DSP, DISP, DOP)  

	DSA: Directory Service Agent : Représentes un serveur pouvant stocker des éléments du DIT.


	dit = directory information tree (Il contient toute les infos de notre structure, il représente l'arbre dans sa globalité)
	directory entries = tout les noeud composant l'arbre
	objectClass = contient les attributs (spécificités) de chaque entrées (directory entries)


        frontend:
            Réference à l'annuaire même, il traite les requêtes clientes et les envois au backend.

        backend:
            Référence à la config/base de données de l'annuaire.
            Il traite avec la base de données (= une instance du backend)
            Par défaut le backend est hdb, une variante de bdb (BerkeleyDB).

~~~~~~~~~~~~~~~~~~~~~~~~~~
Install
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Coté serveur
        --------------------------
                __________________________
                Packages:

                    Dépôts source si non présent:

                        echo"
                        deb      http://ftp.debian.org/debian/ squeeze main contrib non-free
                        deb-src  http://ftp.debian.org/debian/ squeeze main contrib non-free
                        deb      http://ftp.debian.org/debian/ squeeze-updates main contrib non-free
                        deb-src  http://ftp.debian.org/debian/ squeeze-updates main contrib non-free
                        ">> /etc/apt/sources.list
                        > apt-get update


                        Debian:

                            > packages="slapd ldap-utils"
                            > apt-get install $packages

                            (Au prompt, choisir un mot de passe admin)

                            > reconfigurer en cas d'erreur:
                            > dpkg-reconfigure -plow slapd

                        Sur une redhat:

                            > yum install openldap-servers openldap openldap-clients

                __________________________
                PowerDNSSetup (todo)

                    Pour l'install du serveur DNS sur un backend LDAP

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Quelques attributs
        --------------------------
            Quelques directives:

                olcIdleTimeout : Définir le temps d'inactivité de la connexion cliente avant de la fermer. (0 = disable)

                olcLogLevel : Définir le niveau de verbosité des logs.

                olcReferral : Sert au cas ou le server LDAP ne peut pas répondre à une requête, il demandera au client de la faire suivre à l'URL fournis à cette directive.


                olcAttributeTypes : Définit les types d'attributs.
                olcObjectClasses : Définit les classes d'objets.

            TODO

        --------------------------
        Coté serveur
        --------------------------

            Port d'écoute par défaut: 389.

            Il est déconseillé d'éditer directement les fichier de conf.
            Il vaut mieux utiliser ldapadd, ldapdelete, ldapmodify.

                __________________________
                Configuration en arbre (cn=config)

                    La nouvelle version d'openldap (>2.3) utilise slapd.d
                        > man slapd-config
				
                    L'avantage est de pouvoir changer la conf à la volée sans redémarrer le démon.

                    Elle se présente sous la forme d'un DIT:

                    slapd.d/
                    ├── cn=config
                    │   ├── cn=module{0}.ldif #(ajout des modules)
                    │   ├── cn=schema #(Schemas du système)
                    │   │   ├── cn={0}core.ldif
                    │   │   ├── cn={1}cosine.ldif
                    │   │   ├── cn={2}nis.ldif
                    │   │   └── cn={3}inetorgperson.ldif
                    │   ├── cn=schema.ldif #(conf globale du schema)
                    │   ├── olcBackend={0}hdb.ldif
                    │   ├── olcDatabase={0}config.ldif
                    │   ├── olcDatabase={-1}frontend.ldif
                    │   └── olcDatabase={1}hdb.ldif
                    └── cn=config.ldif #(config globale)


                    Il est possible de donner un ordre d'application des configuration via {N°}.

                    Les objets commençant par olc (OpenLdap Configuration) font références à l'ancien système de configuration.


                __________________________
                Pré config:

                    Sur l'ancienne conf: (slapd.conf):
                        > chown -R openldap:openldap /var/lib/ldap

                    Démarrage du service:
                        > service sldap start

                    Afficher la conf:
                        > ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config dn

                __________________________
                Peuplement:


                        Chargement des schemas pour le support SAMBA
                        ``````````````````````````

                            /!\ Il sont peut être déja présent ! (facultatif)
                            Vérifier d'abord si les fichiers:
                                /etc/ldap/schema/samba.schema
                                /etc/ldap/slapd.d/cn=config/cn=schema
                            sont présents.

                            > apt-get install samba-doc
                            > zcat /usr/share/doc/samba-doc/examples/LDAP/samba.schema.gz > /etc/ldap/schema/samba.schema

                            > vim schemas.conf
                                °°°°°°°°°°°°°°°°°°°°°°°°°°
                                include          /etc/ldap/schema/core.schema
                                include          /etc/ldap/schema/cosine.schema
                                include          /etc/ldap/schema/nis.schema
                                include          /etc/ldap/schema/inetorgperson.schema
                                include          /etc/ldap/schema/samba.schema
                                °°°°°°°°°°°°°°°°°°°°°°°°°°

                            # on créer le fichier ldif correspondant:

                                > mkdir /tmp/slapd.d
                                > slaptest -f schemas.conf -F /tmp/slapd.d/
                                > cp "/tmp/slapd.d/cn=config/cn=schema/cn={4}samba.ldif" "/etc/ldap/slapd.d/cn=config/cn=schema"
                                > chown openldap: '/etc/ldap/slapd.d/cn=config/cn=schema/cn={4}samba.ldif'
                                > service slapd restart

                            # Vérifications:

                                > ldapsearch -LLLQY EXTERNAL -H ldapi:/// -b cn=schema,cn=config "(objectClass=olcSchemaConfig)" dn


                            Pour inclure des schemas à la volée:

                                > ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/cosine.ldif
                                > ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/nis.ldif
                                > ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/inetorgperson.ldif

                        Config du backend:
                        ``````````````````````````

                            à interpréter, avec suppression éventuelle des anciennes entrées:
                            voir directement le fichier en question olcDatabase={1}hdb,cn=config

                            >vim backend.mondomain.ldif

                                °°°°°°°°°°°°°°°°°°°°°°°°°°
                                dn: olcDatabase={1}hdb,cn=config
                                changetype: modify
                                replace: olcSuffix
                                olcSuffix: dc=mondomain,dc=root
                                -
                                replace: olcRootDN
                                olcRootDN: cn=admin,dc=mondomain,dc=root
                                -
                                replace: olcRootPW
                                olcRootPW: {SSHA}password_generated_by_slappasswd
                                -
                                delete: olcAccess
                                olcAccess: {0}to attrs=userPassword,shadowLastChange by self write by anonymous auth by dn="cn=admin,dc=nodomain" write by * none
                                -
                                add: olcAccess
                                olcAccess: {0}to attrs=userPassword,shadowLastChange by self write by anonymous auth by dn="cn=admin,dc=mondomain,dc=root" write by * none
                                -
                                delete: olcAccess
                                olcAccess: {2}to * by self write by dn="cn=admin,dc=nodomain" write by * read
                                -
                                add: olcAccess
                                olcAccess: {2}to * by self write by dn="cn=admin,dc=mondomain,dc=root" write by * read

                            Appliquer le fichier:
                                
                                > ldapmodify -Y EXTERNAL -H ldapi:/// -f backend.mondomain.ldif

                            Note, pour créer un mot de passe:

                                > slappasswd

                            /!\ Laisser userPassword tel quel, c'est bien un attribut.

                        Amélioration de l'indexation:
                        ``````````````````````````

                            > vim improve_indexing.ldif

                                °°°°°°°°°°°°°°°°°°°°°°°°°°
                                dn: olcDatabase={1}hdb,cn=config
                                changetype: modify
                                add: olcDbIndex
                                olcDbIndex: cn pres,sub,eq
                                -
                                add: olcDbIndex
                                olcDbIndex: sn pres,sub,eq
                                -
                                add: olcDbIndex
                                olcDbIndex: uid pres,sub,eq
                                -
                                add: olcDbIndex
                                olcDbIndex: displayName pres,sub,eq
                                -
                                add: olcDbIndex
                                olcDbIndex: default sub
                                -
                                add: olcDbIndex
                                olcDbIndex: uidNumber eq
                                -
                                add: olcDbIndex
                                olcDbIndex: gidNumber eq
                                -
                                add: olcDbIndex
                                olcDbIndex: mail,givenName eq,subinitial
                                -
                                add: olcDbIndex
                                olcDbIndex: dc eq
                                °°°°°°°°°°°°°°°°°°°°°°°°°°

                            > ldapmodify -Y EXTERNAL -H ldapi:/// -f improve_indexing.ldif

                        Autoriser le changement de login et gecos (infos dans /etc/passwd):
                        ``````````````````````````
                            = commandes chsh et chfn

                            > vim access_control.ldif

                                °°°°°°°°°°°°°°°°°°°°°°°°°°
                                dn: olcDatabase={1}hdb,cn=config
                                changetype: modify
                                add: olcAccess
                                olcAccess: {1}to attrs=loginShell,gecos
                                  by dn="cn=admin,dc=example,dc=com" write
                                  by self write
                                  by * read
                                °°°°°°°°°°°°°°°°°°°°°°°°°°

                            > ldapmodify -Y EXTERNAL -H ldapi:/// -f access_control.ldif

                        Autoriser le changement de mot de passe:
                        ``````````````````````````
                            > vim access_control.ldif

                                °°°°°°°°°°°°°°°°°°°°°°°°°°
                                dn: olcDatabase={1}hdb,cn=config
                                changetype: modify
                                add: olcAccess
                                olcAccess: {0}to attrs=userPassword,shadowLastChange
                                  by dn="cn=admin,dc=example,dc=com" write
                                  by self write
                                  by anonymous auth
                                  by * none
                                °°°°°°°°°°°°°°°°°°°°°°°°°°

                            > ldapmodify -Y EXTERNAL -H ldapi:/// -f access_control.ldif


                        Création du DIT (frontend):
                        ``````````````````````````

                            > vim fe_dit.ldif

                                °°°°°°°°°°°°°°°°°°°°°°°°°°
                                # ==========================
                                # D I T
                                # ==========================
                                # ---------------------
                                # D C (top-level)
                                # ---------------------
                                dn: dc=domain,dc=fqdn
                                objectClass: top
                                objectClass: dcObject
                                objectclass: organization
                                o: domain
                                dc: domain
                                description: LDAP domain
                                 
                                # ---------------------
                                # Admin / Manager
                                # ---------------------
                                dn: cn=admin,dc=domain,dc=fqdn
                                objectClass: simpleSecurityObject
                                objectClass: organizationalRole
                                cn: admin
                                description: LDAP administrator
                                userPassword: {SSHA}****

                                # ---------------------
                                # OU
                                # ---------------------
                                dn: ou=users,dc=domain,dc=fqdn
                                objectClass: organizationalUnit
                                ou: users

                                dn: ou=groups,dc=domain,dc=fqdn
                                objectClass: organizationalUnit
                                ou: groups

                                dn: ou=servers,dc=domain,dc=fqdn
                                objectClass: organizationalUnit
                                ou: servers

                                # ---------------------
                                # Groups
                                # ---------------------
                                dn: cn=sudodomain,ou=groups,dc=domain,dc=fqdn
                                objectClass: posixGroup
                                cn: sudodomain
                                gidNumber: 2000

                                dn: cn=usersdomain,ou=groups,dc=domain,dc=fqdn
                                objectClass: posixGroup
                                cn: usersdomain
                                gidNumber: 2001
                                 
                                # ---------------------
                                # Users
                                # ---------------------
                                dn: uid=cjesus,ou=users,dc=domain,dc=fqdn
                                objectClass: inetOrgPerson
                                objectClass: posixAccount
                                objectClass: shadowAccount
                                uid: cjesus
                                sn: christ
                                givenName: jesus
                                cn: Jesus Christ
                                displayName: Jesus Christ
                                uidNumber: 5000
                                gidNumber: 2000
                                userPassword: password
                                gecos: Jesus Christ
                                loginShell: /bin/bash
                                homeDirectory: /home/cjesus
                                shadowExpire: -1
                                shadowFlag: 0
                                shadowWarning: 7
                                shadowMin: 8
                                shadowMax: 999999
                                shadowLastChange: 10877
                                mail: cj@domain.fqdn
                                #postalCode:
                                l: city
                                o: orgname
                                #mobile:
                                #homePhone:
                                title: System Administrator
                                #postalAddress: 
                                initials: CJ
                                °°°°°°°°°°°°°°°°°°°°°°°°°°

                        Chargement du fichier:

                            > ldapadd -x -D cn=admin,dc=sub-domain,dc=root-domain -W -f frontend.ldif

			
                        Vérifications:

                            #Afficher les dn:
                                > ldapsearch -x -LLL -H ldap:/// -b dc=sub-domain,dc=root-domain dn 

                            #Afficher le DIT:
                                > ldapsearch -x -b 'dc=example,dc=com' '(objectclass=*)'
                            #Dumper la base:
                                > slapcat

                __________________________
                Activer les logs:

                    > ldapmodify -Y EXTERNAL -H ldapi:///


                        dn: cn=config
                        replace: olcLogLevel
                        olcLogLevel: stats

                        [CTRL + D]

                    Note: avoir les privilèges lors d'un modify:

                        Rajouter l'option:
                            -D cn=admin,cn=Administrators,cn=config -w -

                    On vérifie:
                        > grep olcLogLevel cn=config.ldif
                        ou
                        > ldapsearch -LLL -Y EXTERNAL -H ldapi:/// -b cn=config |grep -i loglevel

                    > service slapd restart

                    #A vérifier:

                        #> vim /etc/rsyslog.conf
                        #   # Log Openldap
                        #  local4.*        /var/log/slapd.log
                        #
                        #> vim /etc/init.d/slapd
                        # SLAPD_OPTIONS="-s 256 -l LOCAL4"

                        # Puis on redémarre le démon syslog:
                        #    > service rsyslog restart

                __________________________
                Chiffrement SSL/TLS:

                    > vim /etc/default/slapd
                        SLAPD_SERVICES="ldap://127.0.0.1:389/ ldaps:/// ldapi:///"

                    > vim ssl.ldif
                        dn: cn=config
                        changetype: modify
                        add: olcTLSCACertificateFile
                        olcTLSCACertificateFile: /path/to/ca.pem
                        -
                        add: olcTLSCertificateKeyFile
                        olcTLSCertificateKeyFile: /path/to/ldap.pem
                        -
                        add: olcTLSCertificateFile
                        olcTLSCertificateFile: /path/to/ldap.pem

                    > ldapmodify -Y EXTERNAL -H ldapi:/// -f ssl.ldif

                    > chown -R openldap:openldap /path/to/ssl 
                    > chmod 550 /path/to/ssl
                    > chmod 440 /path/to/ssl/*

                    ou ajouter au groupe qui a le droit de lire ce dossier. (ssl-cert) par exemple.

                    Notes: 
                        Les certifs ce doivent pas avoir de mot de passe.
                        Si erreur type main: TLS init def ctx failed: voir si droit ok et mot de passe des clés sont supprimés.
                        En fonction de la distrib peut provenir du non support par défaut de TLS ...
                        /!\ Pour les certif chainés, mettre les subca dans le fichier CAroot. (à la suite)
                        Port d'écoute par défaut: 636

                    Tester:

                        > openssl s_client -verify 2 -connect hostname:636

                    Pour demander un certificat client, il faut rajouter:
                        olcTLSVerifyClient: allow


                __________________________
                Changement du port d'écouter:

                    Pour changer le socket et ou le port le d'écoute:

                    > vim /etc/default/slapd

                        SLAPD_SERVICES="ldap://127.0.0.1:389/ ldaps:/// ldapi:///"

        --------------------------
        Coté client
        --------------------------
            
            Quelques paquets:
                > apt-get install ldap-utils openssl

                __________________________
                PAM:
                        
                        Install:
                        ``````````````````````````

                            #Debian:

                                Comme pour nss, il existe deux variantes

                                > apt-get install libpam-ldap   #utilise le module pam_ldap
                                ou
                                > apt-get install libpam-ldapd  #utilise le module pam_unix (pam_ldap peut être utilisé pour le changement de mot de passe)

                                Il n'y a pas de meilleur solution mais la seconde est souvent préférée et à l'avantage d'utiliser le même fichier de conf que nslcd dans le cas où on choisira libnss-ldapd (voir NSS).

                                Note:

                                    l'utilisation de pam_ldap uniquement est assez limitée. À éviter donc.

                            #Redhat:

                                > yum install pam_ldap


                        Config
                        ``````````````````````````
                            
                            #Debian autoconf:

                                > pam-auth-update #Avec libpam-ldapd

                                    Génère les fichier pam /etc/pam.d/common*

                                > dpkg-reconfigure libpam-runtime

                                    Permet de lier les fichier précedent avec pam_unix et pam_ldap
                                    voir aussi /usr/share/pam-configs/ldap

                            #Redhat autoconf:

                                > authconfig
                                ou en version graphique:
                                > authconfig-gtk

                            #Manuellement avec libpam-ldap:

                                > vim /etc/pam.d/...

                                Varie en fonction de la distrib

                                Exemple sur une redhat:

                                    password-auth:
                                        auth        sufficient    pam_ldap.so use_first_pass
                                        account     [default=bad success=ok user_unknown=ignore] pam_ldap.so
                                        password    sufficient    pam_ldap.so use_authtok
                                        session     optional      pam_ldap.so

                                    password-auth-ac:
                                        auth        sufficient    pam_ldap.so use_first_pass
                                        account     [default=bad success=ok user_unknown=ignore] pam_ldap.so
                                        password    sufficient    pam_ldap.so use_authtok
                                        session     optional      pam_ldap.so

                                    system-auth:
                                        auth        sufficient    pam_ldap.so use_first_pass
                                        account     [default=bad success=ok user_unknown=ignore] pam_ldap.so
                                        password    sufficient    pam_ldap.so use_authtok
                                        session     optional      pam_ldap.so

                                    system-auth-ac:
                                        auth        sufficient    pam_ldap.so use_first_pass
                                        account     [default=bad success=ok user_unknown=ignore] pam_ldap.so
                                        password    sufficient    pam_ldap.so use_authtok
                                        session     optional      pam_ldap.so

                                Exemple sur une Debian:

                                    common-account:
                                        account  [success=ok new_authtok_reqd=done ignore=ignore user_unknown=ignore authinfo_unavail=ignore default=bad]    pam_ldap.so minimum_uid=5000
                                    common-auth:
                                        auth    [success=1 default=ignore]  pam_ldap.so minimum_uid=5000 use_first_pass
                                    common-password:
                                        password    [success=1 default=ignore]  pam_ldap.so minimum_uid=5000 try_first_pass
                                    common-session:
                                        session  [success=ok default=ignore] pam_ldap.so minimum_uid=5000
                                    common-session-noninteractive:
                                        session   [success=ok default=ignore] pam_ldap.so minimum_uid=5000

                            #Création du home lors de la première connexion (via skeleton):

                                > vim /etc/pam.d/system-auth #ou common-session pour les Debian

                                    session required        pam_mkhomedir.so skel=/etc/skel/  umask=0022


                            #Configurer pam_ldap #si choix libpam-ldap

                                > vim /etc/pam_ldap.conf

                            Note: 

                                Attention aux doublons dans votre configuration Pam qui peux faire répéter des opérations comme la saisie du login plusieurs fois ...


                        Caching LDAP credentials (optionnel):
                        ``````````````````````````
                            Pour les laptops génerallement:

                            > apt-get install libpam-ccreds

                            voir la conf /usr/share/doc/libpam-ccreds/

                            et mettre au minimum ces infos:

                            > vim /etc/pam.d/common-auth

                                auth sufficient /lib/security/pam_unix.soV
                                auth [authinfo_unavail=ignore success=1 default=2] /lib/security/pam_ldap.so use_first_pass
                                auth [default=done]     /lib/security/pam_ccreds.so action=validate use_first_pass
                                auth [default=done]     /lib/security/pam_ccreds.so action=store
                                auth [default=bad]      /lib/security/pam_ccreds.so action=update

                            Il est aussi possible de feinter en mettant un utilisateur avec le même uid en local.

                                

                __________________________
                LDAP et support du TLS (pour les tools surtout)

                    > vim /etc/ldap/ldap.conf

                        BASE dc=sub-domain,dc=root-domain
                        URI ldap://Y.Y.Y.Y
                        HOST Y.Y.Y.Y

                    Support du TLS :

                        TLS_CACERT /etc/ssl/certs/ca-certificates.crt
                        TLS_REQCERT demand  #comportement par défaut

                    Note:
                        Mettre l'url liée au certificat

                    Rajouter les accès client si le serveur souhaite authentifier le client:

                        TLS_CERT ...
                        TLS_KEY ...


                __________________________
                NSS:
                        
                        Install:
                        ``````````````````````````

                            #Debian:

                                > apt-get install libnss-ldap
                                ou
                                > apt-get install libnss-ldapd (Plus récent et amélioré)

                                En mode interactif:
                                    
                                    Selectionner les fichiers à maper:

                                    usuelement:
                                        passwd, shadow, group

                                Non interactif:

                                    > DEBIAN_FRONTEND=noninteractive apt-get install -y libnss-ldapd

                                Relancer la conf interactive:

                                    > sudo dpkg-reconfigure libnss-ldapd
                                    ou (à vérifier:)
                                    > sudo dpkg-reconfigure ldap-auth-config

                            #Redhat:

                                > yum install nss_ldap

                            Note :
                                Il va peut être faloir rm le paquet: audit-2.2 ... pour éviter les conflit avec un paquet plus récent dépendant de nss_ldap

                        Config:
                        ``````````````````````````

                            #Le deamon nslcd: (LDAP name service daemon) avec libnss-ldapd
                                (/etc/libnss-ldap.conf pour libnss-ldap)
                                avec le password admin: /etc/ldap.secret

                                nslcd utilise nscd pour le caching.

                                > vim /etc/nslcd.conf

                                    # Your LDAP server. Must be resolvable without using LDAP.
                                    uri ldap://Y.Y.Y.Y

                                    # The distinguished name of the search base.
                                    base dc=sub-domain,dc=root-domain

                                Si SSL:
                                    
                                    uri ldaps://URL_SERVER

                                    ssl on
                                    tls_reqcert demand
                                    tls_cacertfile /etc/ssl/certs/ca-certificates.crt

                                    #On rajoutera notre certificat racine dans ce fichier.

                            #nsswitch
					
                                > vim /etc/nsswitch.conf

                                    passwd:         compat ldap
                                    group:          compat ldap
                                    shadow:         compat ldap

                                    hosts:          files dns ldap
                                    networks:       files ldap

                                    Note: compat pour compatible permet de supporter la syntaxe spécial qui se trouvait directement sur les fichiers type passwd. (Ancienne version)

                        Caching offline (optionnel):
                        ``````````````````````````
                            Permet de garder temporairement les données recherchées sur le serveur LDAP.
                            Pour les nomades surtout:

                            > vim /etc/nscd.conf    

                                reload-count            unlimited
                                #positive-time-to-live   <service>          #number of second
                                positive-time-to-live   passwd          2592000
                                positive-time-to-live   group           2592000

                            #Nettoyer le cache lors d'un retour online:

                                > nscd -i passwd
                                > nscd -i group

                                À automatiser ou voir nss-updatedb et sss

                        Lancement du daemon en mode debug:
                        ``````````````````````````
                            > service nscd stop
                            > service nslcd stop
                            > nslcd -d

                __________________________
                Pour SSH en utilisant l'auth PAM:
                    
                    vim /etc/ssh/sshd.conf

                        UsePAM yes

                __________________________
                TESTS:

                    SSL:
                        > openssl s_client -connect LDAP_SERVER_FQDN:636 -showcerts -state -CAfile PATH_TO_CA_CRT

                        debug:

                            > openssl s_client -verify 2 -connect HOSTNAME:636
                            > openssl s_client -host hostname -port 636 -CAfile /etc/ssl/certs/ca-certificates.crt
                            > openssl s_client -connect HOSTNAME:636 -showcerts -state -CAfile /etc/ssl/certs/ca-certificates.crt

                    LDAP:

                        > ldapsearch -H "ldaps://HOSTNAME" -b "dc=domain,dc=fqdn" -x

                        > ldapsearch -h <ldapserver> -b dc=<your>,dc=<domain> -x uid=<username>
                        > ldapsearch -h Y.Y.Y.Y -x -b "dc=sub-domain,dc=root-domain" cn="leo way"
                        > ldapsearch -h Y.Y.Y.Y -x -b "dc=sub-domain,dc=root-domain"

                        > authconfig --test
                        > getent passwd 

                            Note: getent fonctionne indépendament de pam

                        Devrait afficher toutes les infos de votre annuaire ...

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
    > apt-get install ldap-utils

        --------------------------
        Générer un fichier ldif:
        --------------------------

            Depuis un fichier de conf:

                > slaptest -f monFichier.conf -F /out_dir
                éditer ensuite la sortie et importer la:
                > ldapadd -Y EXTERNAL -H ldapi:/// -f /out_dir/monFichier.ldif

        --------------------------
        EXPORTER/IMPORTER LDIF
        --------------------------

            Grâce à cette méthode on peut facilement importer un DIT entier ou tout simplement quelques objets du moments que c'est du ldif.

            Export:

                    > service slapd stop
                    > slapcat > export.ldif

            Import:

                    > service slapd stop
                    > slapadd -b "MON_dn" -l export.ldif
                    > slapindex
                    > service slapd start

                   méthode rapide:

                       > slapadd < file.ldif

                       Note: attention à l'utilisateur employé lors de l'import.

                       Refaire un chown sur /var/lib/ldap (openldap:openldap)

        --------------------------
        Rechercher dans l'annuaire
        --------------------------

                __________________________
                ldapsearch:

                    http://docs.oracle.com/cd/E19450-01/820-6169/ldapsearch-examples.html
                    http://publib.boulder.ibm.com/infocenter/domhelp/v8r0/index.jsp?topic=%2Fcom.ibm.help.domino.admin.doc%2FDOC%2FH_EXAMPLES_EXPORTING_THE_CONTENTS_OF_AN_LDAP_DIRECTORY_2804_STEPS.html

                        Les options
                        ``````````````````````````

                            Les plus courantes:

                            -x :                            auth simple à la place de SASL.
                            -W :                            s'authentifier avec saisie du mot de passe
                            --hostname |-h $HOSTNAME:       spécifie le serveur ldap 
                            --port | -p $PORT:              spécifie le port 
                            --baseDN | -b $DN:              spécifie le point de départ de la requête
                            -D $USER:                       utilisateur ayant le droit de consulter l'annuaire

                            Composition classique de la recherche:

                                > ldapsearch -h monHost -b "dc=domain,dc=fr" -D "user@domain.fr" -W "(filtre)" attributs

                                exemple:

                                    > ldapsearch -x -h 10.1.1.121 -D "admin@domain.demo" -W -b "cn=users,dc=domain,dc=demo" "(sAMAccountName=admin)" cn memberOf


                        Quelques filtres:
                        ``````````````````````````

                            Tous les objets de l'annuaire:

                                "(objectclass=*)"

                            Un utilisateur particulier:

                                "(cn=bidul bidouil)"

                            Avec des attributs spécifiques:

                                "(cn=bidul bidouil)" mail sAMAccountName

                            Un filtre composé:

                                & : AND
                                | : OR
                                ! : NOT

                                exemples:

                                    - deux attributs doivent apparaitres:

                                        "(&(sn=foo) (l=fifoo))"


        --------------------------
        Générer un mot de passe
        --------------------------

            > slappasswd [-h {MON_HASH}] -s MON_PWD

            exemple:

                > slappasswd -s secret  #par défaut SSHA
                > slappasswd -h {SMD5} -s secret

        --------------------------
        Modifier
        --------------------------
                __________________________
                Une entrée:

                    Création d'un fichier de modification:
                    
                        dn: MON_DN_A_MODIFIER
                        changetype: modify
                        replace: mon_attribut
                        mon_attribut: NEW_VALUE

                    > ldapmodify -v -D cn=admin,dc=sub-domain,dc=root-domain -W -f modify.txt

                    Pour ajouter, même principe mais avec la syntaxe suivante:
                        Attribut_seul = suppression
                        +Attribut=valeur : ajoute un attribut

                    Si l'entrée comporte plusieurs instance d'un même attribut, il faut supprimer ceux que l'on veut changer:

                        dn: MON_DN_A_MODIFIER
                        changetype: modify
                        delete: mon_attribut
                        mon_attribut: old_value

                        add: mon_attribut
                        mon_attribut: new_value

                    Exemple:
                        dn: cn=Barney Fife,ou=People,dc=example,dc=com
                        changetype: modify
                        delete: telephonenumber
                        telephonenumber: 555-1212
                        -
                        add: telephonenumber
                        telephonenumber: 555-4321

                    Note: le '-' sert à indiquer qu'il s'agit toujours de la même entrée. (le saut de ligne étant interprété comme une nouvelle entrée).
                

        --------------------------
        Supprimer
        --------------------------
                __________________________
                Vider la base (méthode brutale):

                    > rm -rf /var/lib/ldap/*
                    ou encore
                    > dpkg-reconfigure slapd

                __________________________
                Pour supprimer une entrée:
			
                    > ldapdelete -x -D cn=admin,dc=sub-domain,dc=root-domain -W "My_DN"

        --------------------------
        Migration tools
        --------------------------

            > apt-get install migrationtools

            go dans /usr/share/migrationtools
                __________________________
                migrer les utilisateurs locaux:

                    exemple:

                    ./migrate_passwd.pl /etc/passwd >> /etc/ldap/ldif/users

        --------------------------
        Ajouter un utilisateur dans plusieurs groupes
        --------------------------

            Pour ce faire on rajoute l'attribut 'memberUid' au sein d'une entrée groupe.

            Exemple:

                dn: cn=mongroup,ou=group,dc=example,dc=com
                objectClass: posixGroup
                objectClass: top
                cn: mongroup
                memberUid: tic
                memberUid: tac
                memberUid: nuts
                gidNumber: 5001

~~~~~~~~~~~~~~~~~~~~~~~~~~
Migration des utilisateurs locaux
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Il est possible de migrer ses utilisateurs locaux facilement par l'intérmédiaire d'un script:

        voir: migrate_passwd.pl

~~~~~~~~~~~~~~~~~~~~~~~~~~
Montage NFS
~~~~~~~~~~~~~~~~~~~~~~~~~~
    https://wiki.debian.org/LDAP/AutoFSSetup
    https://help.ubuntu.com/community/AutofsLDAP
    http://jotdownux.blogspot.fr/2012/09/openldap-nfs-automount-complete.html
    http://www.admin-linux.fr/?p=1843

    Il peut être très pratique de centraliser le montage des homes des users pour qu'ils puissent accéder à leur fichiers sur n'importe quel hôte.

        --------------------------
        Avec autofs
        --------------------------

            Autofs à l'avantage d'être relativement simple à configurer et surtout de gérer les accès aux points de montages automatiquement.
            
            On va pouvoir monter uniquement les dossiers utilisateurs lorsuqu'ils se connecte.
            Le démontage est effectué au bout d'un certain temps d'inactivité.

                __________________________
                Install des packages

                    > apt-get install autofs5 autofs5-ldap

                __________________________
                Ajout du nouveau schema

                    > vim /etc/ldap/schema.conf

                        include         /etc/ldap/schema/core.schema
                        include         /etc/ldap/schema/cosine.schema
                        include         /etc/ldap/schema/autofs.schema

                    > mkdir /etc/ldap/slaptest
                    > slaptest -f schema.conf -F /etc/ldap/slaptest

                    Le fichier ldif autofs doit être modifié pour ressembler à celui-ci:

                    > vim /etc/ldap/slaptest/cn=config/cn=schema/cn\=\{5\}autofs.ldif

                        dn: cn=autofs,cn=schema,cn=config
                        objectClass: olcSchemaConfig
                        cn: autofs
                        olcAttributeTypes: {0}( 1.3.6.1.1.1.1.25 NAME 'automountInformation' DESC 'Inf
                         ormation used by the autofs automounter' EQUALITY caseExactIA5Match SYNTAX 1.
                         3.6.1.4.1.1466.115.121.1.26 SINGLE-VALUE )
                        olcObjectClasses: {0}( 1.3.6.1.1.1.1.13 NAME 'automount' DESC 'An entry in an 
                         automounter map' SUP top STRUCTURAL MUST ( cn $ automountInformation $ object
                         class ) MAY description )
                        olcObjectClasses: {1}( 1.3.6.1.4.1.2312.4.2.2 NAME 'automountMap' DESC 'An gro
                         up of related automount objects' SUP top STRUCTURAL MUST ou )

                    > ldapadd -Y EXTERNAL -H ldapi:/// -f cn\=\{5\}autofs.ldif

                __________________________
                Configuration des mappages:

                    Exemple:

                    > vim automounttree.ldif

                        ####### MON OU AUTOMOUNT
                        dn: ou=automount,dc=mondomaine,dc=com
                        ou: automount
                        objectClass: top
                        objectClass: organizationalUnit

                        ####### MON OU CONTENANT LES POINTS DE MONTAGES RACINES
                        dn: ou=auto.master,ou=automount,dc=mondomaine,dc=com
                        ou: auto.master
                        objectClass: top
                        objectClass: automountMap

                        ####### LE POINT DE MONTAGE ROOT:
                        #/!\ ce point de montage sera reservé à automount.
                        #il contient aussi les options de montage
                        #Note: --ghost spécifie que le point de montage est reservé et que de cette manière les sous montages sont effectués uniquement lorsqu'on y accede.
                          
                        dn: cn=/ldap_users,ou=auto.master,ou=automount,dc=example,dc=com
                        cn: /ldap_users
                        objectClass: top
                        objectClass: automount
                        automountInformation: ldap:ou=auto.home,ou=automount,dc=mondomaine,dc=com --timeout=60 --ghost

                        ####### MON OU CONTENANT LES POINTS DE MONTAGES UTILISATEURS
                        dn: ou=auto.home,ou=automount,ou=admin,dc=example,dc=com
                        ou: auto.home
                        objectClass: top
                        objectClass: automountMap

                        ####### LE PONT DE MONTAGE DE MES UTILISATEURS (/ correspond à *)
                        # il faudra peut être échapé le / => \/ .

                        dn: cn=/,ou=auto.home,ou=automount,dc=mondomaine,dc=com
                        cn: /
                        objectClass: top
                        objectClass: automount
                        automountInformation: -fstype=nfs,rw,soft,intr,sec=sys    serverLdap:/ldap_users/&

                    > sudo ldapadd -D cn=admin,dc=example,dc=com -W -f automounttree.ldif

                    /!\ veillez à changer le home path pour les utilisateurs concernés

                __________________________
                Coté client:

                    exemples:

                    > vim /etc/default/autofs

                        MASTER_MAP_NAME="ou=auto.master,ou=automount,dc=mondomaine,dc=com"
                        LOGGING="verbose"
                        LDAP_URI="ldap://192.168.x.x"
                        SEARCH_BASE="ou=automount,dc=mondomaine,dc=com"

                        MAP_OBJECT_CLASS="automountMap"
                        ENTRY_OBJECT_CLASS="automount"
                        MAP_ATTRIBUTE="ou"
                        ENTRY_ATTRIBUTE="cn"
                        VALUE_ATTRIBUTE="automountInformation"

                    > vim /etc/autofs_ldap_auth.conf

                        <autofs_ldap_sasl_conf
                                usetls="no"
                                tlsrequired="no"
                                authrequired="no"
                        />

                    /!\ Les droits sur ce fichier doivent être en lecture uniquement pour root:

                    > chmod 600 /etc/autofs_ldap_auth.conf

                    > vim /etc/nsswitch.conf

                        automount:      files ldap

                    > vim /etc/ldap/ldap.conf

                        BASE    dc=mondomaine,dc=com
                        URI     ldap://ldap.example.com

                        #If using TLS:
                        TLS_CACERT /usr/share/ca-certificates/mondomaine.com/cacert.pem

                    redémarrage du daemon:

                        > service autofs restart

                __________________________
                skeleton:

                    Par défaut je n'ai pas vu de mécanisme de création de skeleton.
                    J'ai donc rajouter un script à exécuter au niveau de pam:

                    > vim /etc/pam.d/commmon-session

                        session optional pam_exec.so /bin/bash /usr/share/autoskel.sh

                    > vim /usr/share/autoskel.sh

                        ************************************
                        #!/bin/bash

                        log="/var/log/$(basename $0).log"
                        home="/ldap_users/$PAM_USER"
                        local_user="$(grep $PAM_USER /etc/shadow)"

                        echo "Launching by $PAM_USER" >> $log

                        #Wait for automounting if the user is not local and there is no skel files
                        [[ ! $local_user && ! -f $home/.bashrc ]] && echo "waiting for mount process" >> $log && sleep 3

                        #Check if the user dir is already mounted, and if the user is not local
                        if [[ ! $local_user && $PAM_USER && $(df |grep $home) ]]
                        then
                            echo "matching $PAM_USER" >> $log

                            for file in $(find /etc/skel -name '.*')
                            do
                                [[ ! -f $home/$(echo $file| cut -d/ -f4) ]] && cp $file $home && echo "set $file" >> $log
                            done

                        fi

                        exit 0
                        ************************************
                    
        --------------------------
        Avec pam_mount
        --------------------------

        --------------------------
        Avec pam_exec
        --------------------------

            Il est aussi possible de créer son point de montage manuellement via un script:


            exemple:

                Avec au niveau de pam.d/commin-session
                    session optional pam_exec.so /bin/bash monScript.sh
                
                mount -t nfs -o v3 192.168.1.73:/volume1/vmusers/$PAM_USER /home/$PAM_USER

            /!\ il faudra penser à gérer les démontages.

            Note


~~~~~~~~~~~~~~~~~~~~~~~~~~
GUI - Interface Graphique
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Plusieurs outils sont à notre disposition:

        -luma
        -php_ldap_admin
        -webmin
        -ldap_account_manager

    Le plus répandu à l'air d'être php_ldap_admin,
    Il permet notament de d'avoir une interface graphique complete accessible depuis n'importe quel browser.

        --------------------------
        PHP LDAP ADMIN
        --------------------------

            http://www.jouvinio.net/wiki/index.php/Installation_phpLDAPAdmin
            http://phpldapadmin.sourceforge.net/wiki/index.php/Main_Page
            https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-openldap-and-phpldapadmin-on-an-ubuntu-14-04-server
            
                __________________________
                Installation:

                    Très simplement depuis les packages:

                    > apt-get install phpldapadmin

                    /!\ ce package install apache.

                    Un lien est crée dans:
                        /etc/apache2/conf.d/phpldapadmin


                    Le site phpldapadmin est maintenant disponible:

                        http://@IPSERVER/phpldapadmin

                __________________________
                Configuration:

                    Un peu de config à faire au niveau de /etc/phpldapadmin/config.php

                    exemples:

                        $servers->setValue('server','name','MY LDAP');
                        $servers->setValue('server','base',array('dc=mondomaine,dc=com')); 
                        $servers->setValue('login','bind_id','cn=admin,dc=mondomaine,dc=com');

                        Filtrer les utilisateurs pouvant se connecter:

                        $servers->setValue('login','allowed_dns',array(
                        'cn=admin,dc=ejnserver,dc=fr',
                        '(&(uid=*)(memberof=cn=ldapAdmin,ou=groups,dc=ejnserver,dc=fr))'
                        ));

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshout
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Si jamais un problème d'accès 'denied from unknown ( @IP )'

    Rajouter dans /etc/hosts.allow

        slapd: @IP

        (même si vous avez un ALL: ALL)

~~~~~~~~~~~~~~~~~~~~~~~~~~
Tips
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Intéroger un serveur AD avec ldapsearch:

        Exemples:

            > ldapsearch -x -h @IP -D "user@domain.demo" -W -b "ou=comptes,dc=domain,dc=demo" -s sub "(cn=*)" cn mail sn
            > ldapsearch -x -h @IP -D "administrateur@domain.demo" -W -b "cn=users,dc=domain,dc=demo" -s sub "(cn=*)" cn mail sn
