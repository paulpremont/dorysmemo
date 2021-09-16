==========================================================
			I R C 
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
LINKS
~~~~~~~~~~~~~~~~~~~~~~~~~~
	Aide sur le choix des technos et serveurs
		http://about.psyc.eu/Comparison
		http://en.wikipedia.org/wiki/Comparison_of_Internet_Relay_Chat_daemons
		https://gaglers.com/blog/2013/04/27/xmpp-group-chat-versus-irc/
		http://www.irc.org/tech_docs/ircnet/faq.html

	Docs sur ircd-hybrid
		http://www.codeography.com/2012/09/23/howto-irc-server.html
	Docs sur ircd
		https://help.ubuntu.com/10.04/serverguide/irc-server.html

	Docs sur inspircd
		https://wiki.debian.org/InspIRCd
		http://wiki.inspircd.org/Modules/1.2/permchannels
		http://www.inspircd.org/wiki

	Tuto sur les commandes irc:
		http://www.irchelp.org/irchelp/irctutorial.html

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works
~~~~~~~~~~~~~~~~~~~~~~~~~~

        IRC pour Internet Relay Chat , basé sur un modèle client-server. Différents serveur peuvent être linké faisant transité les messages de serveur en serveur pour atteindre le destinataire visé.
	
~~~~~~~~~~~~~~~~~~~~~~~~~~
Coté serveur
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Make a choice:
        --------------------------

		Il existe un tat de serveur IRC différent, dont ircd, ircd-hybrid, ngIRcd, unrealIRCd, inspIRCDd ...

		Pour faire son choix, voir le lien wikipedia dans links.

		inspiIRCd me semble une bonne alternative en terme de feature, de protocol, de documentation, et de communauté.
			
        --------------------------
        inspIRCd
        --------------------------
            __________________________
            Installation:

                Via git:
                ``````````````````````````
                                    git clone git://github.com/inspircd/inspircd.git
                                    git branch -a
                                    git checkout insp20

                Prérequis
                ``````````````````````````
                    http://www.inspircd.org/wiki/System-Requirements.html

                    > apt-get install gcc g++ gnutls-bin libgnutls-dev pkg-config make
                            
                Compile:
                ``````````````````````````
                                    SSL:
                                    
                                            Il est conseillé d'utilisé gnutls qui se veut apparament plus performant qu'openssl.

                                            (apt-get install gnutls-bin)
                                            voir https://help.ubuntu.com/community/GnuTLS


                                    ./configure #(conf interactive)
                                    voir ./configure --help  #Pour plus d'option 

                                    make && make INSTUID=irc install

                                    Note: Si le make est lancé en root, il peut y avoir un problème avec l'uid. 
                        Il faut donc soit reconfigurer avec l'option --uid, 
                        soit relancer le make install avec INSTUID 
                        ou encore, le lancer avec le user 'irc'

                __________________________
                Configuration:

                    Si les paths par défaut n'ont pas été changés, tout est installé dans le folder run à la racine du folder inspircd:


                        Configuration:
                        ``````````````````````````

                            Copy des fichiers:

                                > cp run/conf/examples/{inspircd*,rules*,opers*,motd.*,modules.conf*} run/conf

                            on renome les fichiers:

                                for file in $(ls); do mv $file ${file%.example}; done #Ou avec rename ... 

                            Il ne reste qu'a éditer les fichiers de configurations.

				
                        Définir un socket d'écoute
                        ``````````````````````````
                                On le fait via bind:

                                > vim inspircd.conf

                                <bind
                                      address="@IP_server"
                                      port="PORT_ECOUTE"
                                      type="clients"
                                      ssl="gnutls"  #pour activer le support ssl
                                >

                                Il faut ensuite lier une connection à un socket:
                                Les clauses connect gère une grosse partie de la conf des canaux IRC.

                                <connect 
                                        name="maine"
                                        ...
                                >

                                <connect
                                      name="local"
                                      parent="main" #
                                      port="6667"
                                      allow="*"
                                      password="myPassWD"
                                >

                        SSL
                        ``````````````````````````

                                Rajouter l'option ssl='MODE' dans la clause bind:

                                      ssl="gnutls"  #pour activer le support ssl

                                Dans inspircd.conf:
                                <gnutls cafile="" crlfile="" certfile="/etc/ssl/irc/cert.pem" keyfile="/etc/ssl/irc/key.pem" dh_bits="1024"> #(pour gnutls)

                                Il faut ensuite générer ses certificats:

                                        > openssl req -x509 -nodes -newkey rsa:1024 -keyout key.pem -out cert.pem

                                On active le module:
                                        <module name="m_ssl_gnutls.so">

                        Chan permanent
                        ``````````````````````````

                                Dans module.conf:

                                <permchannels channel="#chan1" modes="P" topic="Texte d'intro">

                        Activation de module
                        ``````````````````````````
                                Il suffit de décommenter les modules dans modules.conf pour les utiliser

                __________________________
                Lancement du démon:

                    Pour rendre l'utilisateur irc plus confortabkle:

                        > usermod -d /opt/inspircd irc
                        > chsh -s /bin/bash irc

                    On se connecte:

                        > su - irc
                            > ./inspircd start|restart|stop

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Coté client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	De nombreux clients existent, en mode graphique nous avons xChat, que j'aime tout particulièrement, 
	Des clients multiprotocoles type pidgin, empathy, ekiga ...
	En mode console : Weechat, irssi ...

	Je vais vous présenter ici irssi (Les clients en mode graphique sont configurable facilement :p)

        -----------------------
        IRSSI
        -----------------------
                __________________________
                Links

                    http://www.antonfagerberg.com/archive/my-perfect-irssi-setup
                    http://irssi.org/documentation
                    http://quadpoint.org/articles/irssi/
                    https://github.com/guyzmo/notossh

                __________________________
                Install

                    > apt-get install irssi 

                __________________________
                KeyBindings

                    ^x      : Changer de serveur
                    ^n      : Aller au channel suivant
                    ^p      : Aller au channel précedent

                    Alt [0-9] : se déplacer sur un chan spécifique

                __________________________
                Commandes useful
                        
                    /help                           #Afficher les commandes irssi
                    /quit                           #Quitter irssi
                    /nick                           #changer son pseudo
                    /names                          #Afficher les gens connectés au channel
                    /join #$CHANNEL                 #Rejoindre un channel
                    /msg NICKNAME                  #Envoyer un message privé
                    /save                           #Enregristrer sa configuration courante
                    /script load MYSCRIPT.pl       #Charger un script (voir : http://scripts.irssi.org/)
                    /set theme MyTheme             #Charger un theme
                    /notice PSEUDO message          #Envoyer un message personnel au PSEUDO
                    /part                           #quitter un chan
                    /ping PSEUDO                    #Donne une estimation du temps pour joindre la personne
                    /whois PSEUDO                   #Donner plus d'info sur un pseudo

                    Pour 'surligner' envoyer une notification, il suffit de mettre le pseudo devant sa réponse:

                    Exemple:

                        pseudo_bidul, Ok bien reçu !


                __________________________
                Config

                    Il n'est pas conseillé d'éditer la configuration à la main.
                    Celle ci est mise à jour grâce aux commandes irssi.

                    Il est aussi conseillé de lancer son irssi au sein d'un screen ce qui va accroite les possibilités de configuration et nous permettre d'éxécuter notre chat sur un processus indépendant du shell courant.

                    Voici un exemple de configuration from scratch:

                    Note: 
                        Attention à bien sauvegarder sa config ;)
                        > /save

                        Choisir un thème (facultatif):
                        ``````````````````````````

                            go: http://irssi.org/themes

                            > wget irssi.org/themefiles/xchat.theme  #Récupération du theme
                            > cp xchat.theme ~/.irssi/               #Copie dans son dossier de config

                            > /set theme xchat                        #On charge ensuite le theme

                        Choisir son pseudo: 
                        ``````````````````````````
                            > /nick $my_nickname

                        Connexion automatique
                        ``````````````````````````

                            > /server ADD -auto -network $NetworkName $MyServer $MyPort
                            > /channel ADD -auto #$CHANNEL $NetworkName $Password

			Nicklist splitée
                        ``````````````````````````

				> wget http://scripts.irssi.org/scripts/nicklist.pl
				> cp nicklist.pl ~/irssi/scripts

				> /script load nicklist.pl
				> /nicklist screen              #Il faut avoir éxécuter irssi dans un screen!

			Colorer les nicknames
                        ``````````````````````````
				> wget http://dave.waxman.org/irssi/xchatnickcolor.pl
				> /script load xchatnickcolor

			Avoir un oeil sur les mp
                        ``````````````````````````

				> /window new split
				> /window name hilight
				> /window size 10

				> wget http://scripts.irssi.org/scripts/hilightwin.pl
				> cp hilightwin.pl .irssi/scripts

				> /script load hilightwin.pl

			Customiser sa barre de controle de fenêtre:
                        ``````````````````````````

				> wget http://anti.teamidiot.de/static/nei/*/Code/Irssi/adv_windowlist.pl
				> cp adv_windowlist.pl ~/.irssi/scripts

				> /script load adv_windowlist.pl
				> /set awl_display_key $Q%K|%n$H$C$S

			Absence automatique
                        ``````````````````````````

				> wget http://scripts.irssi.org/scripts/screen_away.pl
				> cp screen_away.pl ~/.irssi/scripts

				> /script load screen_away.pl
				> /set screen_away_active ON
				> /set screen_away_message
				> /set screen_away_nick

			Notification
                        ``````````````````````````

				> apt-get install libnotify-bin
				> wget http://irssi-libnotify.googlecode.com/svn/trunk/notify.pl 
				> cp notify.pl ~/.irssi/scripts

				> /script load notify.pl 

				OVER SSH:

                                Lancer sa connexion via l'option -X

                                Note: 
                                       Pour ceux qui n'ont pas la possibilité de mettre de nouveauxc modules perl au niveau du remote, il est possible de passer par une autre méthode:

                                        > wget http://www.leemhuis.info/files/fnotify/fnotify
                                        > scp fnotify REMOTE:.irssi/script/fnotify.pl

                                        (ou voir https://gist.github.com/matthutchinson/542141)

                                        Sur le remote:

                                        > /script load fnotify

                                        En local:

                                        Laissez tourner le script suivant:

                                        °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°

                                                #!/bin/bash                     
                                                                                
                                                host=$1                         
                                                                                
                                                ssh -t $host "trap \            
                                                        'echo Exit Irssi Notify; > ~/.irssi/fnotify; exit 0' \
                                                        SIGINT SIGTERM SIGKILL; \
                                                        tail -f .irssi/fnotify" \
                                                |sed -u 's/[<@&]//g' \      
                                                |while read heading message                                                                                         
                                                do                              
                                                      notify-send -i gtk-dialog-info -t 9000 -- "$heading" "${message}"
                                                done

                                        °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°

			Sauvegarde
                        ``````````````````````````
				> /save

			SSL (todo)
                        ``````````````````````````
	-----------------------
	BITLBEE
	-----------------------
	-----------------------
	Kiwiirc
	-----------------------

		C'est un client web très pratique.
                __________________________
		Installation:

			Install de nodejs et npm (Node Packaged Modules)
                        ``````````````````````````
                            https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager

                            Via apt:

                                > curl -sL https://deb.nodesource.com/setup | sudo bash -
                                > apt-get install nodejs npm

                            Via les sources:

                                    sudo apt-get update
                                    sudo apt-get install git-core curl build-essential openssl libssl-dev
                                    git clone https://github.com/joyent/node.git && cd node
                                    ./configure
                                    make
                                    sudo make install
                                    node -v
                                    cd

			Install du repo Kiwiirc
                        ``````````````````````````

                                cd /opt #ou autre
                                git clone https://github.com/prawnsalad/KiwiIRC.git && cd KiwiIRC
                                npm install #install des dépendances
                                cp config.example.js config.js
                                vim config.js
                                ./kiwi build

                __________________________
		Configuration:

                        La conf est plutot bien expliquée

			Le client IRC:
                        ``````````````````````````
                                En fonction des paramètres du serveur:

                                conf.client = {
                                    server: '@IP_server',
                                    port:    PORT_ECOUTE,
                                    ssl:     true|false,
                                    channel: '#chan1,#chan2',
                                    channel_key: '',
                                    nick:    '',
                                    settings: {
                                        theme: 'relaxed',
                                        channel_list_style: 'tabs',
                                        scrollback: 250,
                                        show_joins_parts: true,
                                        show_timestamps: false,
                                        use_24_hour_timestamps: true,
                                        mute_sounds: false,
                                        show_emoticons: true,
                                        count_all_activity: true
                                    },
                                    window_title: 'Kiwi IRC'
                                };

			Restreindre le client:
                        ``````````````````````````
                                Ces paramètres ne pourront être changés par le client web.

                                conf.restrict_server = "127.0.0.1";
                                conf.restrict_server_port = 6667;
                                //conf.restrict_server_ssl = false;

                __________________________
		Démarrage du démon:

                        ./kiwi start
                                -f : lancer en fond

                        écoute par défaut sur http://localhost:7778

                __________________________
		Ajout d'un socket local au niveau du serveur IRC (optionnel)

                        Si le client web se trouve sur le serveur IRC, on peut utiliser un socket local (rajouter bind et connect) pour inspiIRC.

                __________________________
		Config du reverse proxy (optionnel)

                        Il faut que le reverse proxy puisse servir du Websocket.

			Nginx:
                        ``````````````````````````

                            Au niveau de nginx, il semblerait que cela fonctionne nativement:
                                location / {
                                    proxy_set_header Host $host;
                                    proxy_set_header X-Real-IP $remote_addr;
                                    proxy_set_header x-forwarded-for $proxy_add_x_forwarded_for;

                                    proxy_pass http://localhost:7778/;
                                    proxy_redirect default;

                                    # Websocket support (from version 1.4)
                                    proxy_http_version 1.1;
                                    proxy_set_header Upgrade $http_upgrade;
                                    proxy_set_header Connection "upgrade";
                                }

			Apache:
                        ``````````````````````````

                            Apache peut poser quelques problème, il faut ajouter le module mod_proxy_wstunnel:

                __________________________
		Ajout de modules:

                        TODO !
                                
	-----------------------
	Commandes IRC
	-----------------------

                Note: certaines commandes peuvent surement être propre au serveur IRC installé.

                Note2 : le resultat des commandes peut aussi être dumpé dans le fenêtre principal de son client IRC et non dans les chans.
                __________________________
		Commandes de base

                    /HELP  : afficher les commandes valables
                            -l : afficher plus de details

                    /SERVER irc_server : se connecter à un serveur irc

                    /NICK NickName : Changer son nickname

                    /LIST : lister les chan irc

                    /NAMES #monChan : afficher les nickanmes d'un chan

                    /WHOIS nickName : afficher les info sur un user

                    /AWAY message : écrire un message d'absence temporaire
                            Sans argument: supprime le message en cours

                    /QUIT : quitter IRC

                __________________________
                Commandes de chat
                
                        Accéder à un chan:
                        ``````````````````````````

                                /JOIN #chan : joindre un chan

                                /ME is_message : message d'action (dire ce que l'on fait)

                                /LEAVE : quitter un chan

                        Messages privés:
                        ``````````````````````````

                                /MSG nickName message : envoyer un message privé
                                /QUERY nickName :  ouvrir une nouvelle fenêtre de conversation avec une personne en particulier

                        Transfert de fichier:
                        ``````````````````````````

                                /DCC SEND nickName monFichier : envoyer un fichier

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bonus, les script init
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    inspircd:

            #!/bin/bash
            ### BEGIN INIT INFO   
            # Provides:          inspircd
            # Required-Start:
            # Required-Stop:
            # Default-Start:     2 3 4 5
            # Default-Stop:      0 1 6      
            # Short-Description: irc daemon
            # Description: 
            ### END INIT INFO

            case "$1" in
                start)
                    echo "Starting inspircd"
                    su -l -c './inspircd start' irc
                    ;;
                stop)
                    echo "Stoping inspircd"
                    su -l -c './inspircd stop' irc
                    ;;
                restart)
                    echo "Restarting inspircd"
                    su -l -c './inspircd restart' irc
                    exit
                    ;;
                *)
                    echo "Usage: $0 {start|stop|restart}"
                    ;;
            esac


    kiwiirc:

            #!/bin/bash
            ### BEGIN INIT INFO   
            # Provides:          kiwi irc
            # Required-Start:
            # Required-Stop:
            # Default-Start:     2 3 4 5
            # Default-Stop:      0 1 6      
            # Short-Description: kiwi irc web interface
            # Description: 
            ### END INIT INFO

            case "$1" in
                start)
                    echo "Starting kiwiirc"
                    /opt/KiwiIRC/kiwi start
                    ;;
                stop)
                    echo "Stoping kiwiirc"
                    /opt/KiwiIRC/kiwi start
                    ;;
                restart)
                    echo "Restarting kiwiirc"
                    /opt/KiwiIRC/kiwi restart
                    exit
                    ;;
                *)
                    echo "Usage: $0 {start|stop|restart}"
                    ;;
            esac
