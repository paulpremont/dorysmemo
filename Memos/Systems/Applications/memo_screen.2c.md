===========================================================
		Les Multiplexeur de terminaux
===========================================================

Les multiplexeurs de terminaux permettent de gérer plusieurs session de terminal au sein d'un seul terminal.
Chaque session est exécutée dans un processus indépendant du terminal "physique" sur lequel il est lancé.
La fermeture de ce dernier n'entrainera donc pas la mort du processus screen.
Il est aussi possible de partager des sessions, ce qui rend très utile la chose !

Note: la touche d'échappement sert à éxécuter tout les raccourcis cités dans la section Shortcuts
Note2: la touche "CTRL" équivaut au symbole "^"

~~~~~~~~~~~~~~~~~~~~~~~
SCREEN
~~~~~~~~~~~~~~~~~~~~~~~

	---------------
	Shortcuts (par défaut)
	---------------

        voir DEFAULT KEY BINDINGS du man !

                Catégorie		Explication			 Raccourcis             Commande (-X todo)

                Echappement             Sert à éxécuter un raccourci     ^a

                Aide                    Afficher une liste de raccourci  ?
                                                                        
                Nouveau/splitter:       Créer un nouveau terminal	 c 	                (screen)
                                        Split horizontal		 S 	                (split)
                                        Split Vertical			 | 	                (split -v)
                                                                        
                Se déplacer:		terminal précédent		 p 	                (prev)
                                        terminal suivant		 n                      (next)	
                                        Split suivant			 tab 	                (focus)
                                        Split haut			  	                (focus up)
                                        Split bas			  	                (focus down)
                                        scrollup			 Escp scrollup
                                        scrolldown			 Escp scrolldown
                                        Allez au Nième terminal		 0..9 	                (select 0-9)
                                        saisir le numéro du terminal	 '	                (select)
                                        liste les différents terminaux	 " 	                (windowlist -b)
                                        liste avec le nom des terminaux	 w 	                (windows)
                                        retourner à l'ancien terminal	 a                      (meta)
                                                                        
                Supprimer/Détacher:	Détacher la session		 d 	                (detach)
                                        Supprimer le split actif	 X	                (remove)
                                        Supprimer les split sauf actif	 Q	                (only)
                                        Tuer le terminal actuel	(exit)	 ^D 		        
                                        Détacher et fermer la session	 DD                     (pow_detach)	
                                                                        
                Renommer:		Renommer le terminal		 A 	                (title)

                Lancer des commandes:                                    :COMMAND

	---------------
        Links:
	---------------

                http://studio.jacksay.com/tutoriaux/systeme-linux/l-utilitaire-bash-screen
                http://www.jerri.de/blog/archives/2006/05/02/scripting_screen_for_fun_and_profit/

	---------------
        TIPS / COMMANDES
	---------------

                screen    : lancer dans un screen -> ouvre un nouveau screen dans un nouvel onglet.
                 -ls      : Afficher les différente instance de screen.
                 -r [PID OU NOM SESSION]    : Réouvrir une session screen
                 -wipe    : supprimer les sessions mortes b
                 -S NOM   : Donner un nom à la session screen
                 -X COMMAND: Permet d'éxécuter une commande de screen à travers différentes sessions/windows

                        avec l'option -p N, la commande s'appliquera sur la fenêtre N
                        avec l'option -S Y, la commande s'appliquera sur la session Y 

                echo $STY       : affiche le nom de session dans laquel on se trouve.

                        (voir partie scripting pour plus de détails)
	---------------
	SCROLL
	---------------

                Pour activer le scroll, il faut rentrer en mode copy:
                ^A Escp 
                Il est en suite possible de naviguer dans ce mode grâce aux raccourcis suivants:

                        h, j, k, l move the cursor line by line or column by column.
                        0, ^ and $ move to the leftmost column, to the first or last non-whitespace
                        character on the line.
                        H, M and L move the cursor to the leftmost column of the top, center or bottom
                        line of the window.
                        + and - positions one line up and down.
                        G moves to the specified absolute line (default: end of buffer).
                        | moves to the specified absolute column.
                        w, b, e move the cursor word by word.
                        B, E move the cursor WORD by WORD (as in vi).
                        C-u and C-d scroll the display up/down by the specified amount of lines  while
                        preserving  the  cursor  position. (Default: half screen-full).
                        C-b and C-f scroll the display up/down a full screen.
                        g moves to the beginning of the buffer.
                        % jumps to the specified percentage of the buffer.

                        PgUP et pgDown fonctionne aussi dans ce mode

	---------------
        Commandes SCREEN
	---------------

                Pour lancer une commande screen: "^a :MA COMMANDE"

                Les commandes sont les même que celles misent dans le fichier de conf screenrc.
                Voir la section CUSTOMIZATION du man de screen.

                source /PATH/TO/CONF/SCREENRC   : recharge la configuration de screenrc

                eval: permet d'éxécuter plusieurs commandes screen à la suite
                        eval "CMD1" "CMD2" ...

                stuff "cmd": permet d'envoyer des action à screen, telles que l'appui sur une touchet, l'envoie d'un texte ...

                layout save default : sauvegarder l'affichage du screen

                resize : changer la taille de la région (Attention au contexte)
                        N : définie la taille de la région actuelle
                        +N : augmente la taille de N
                        -N : diminue la taille de N
                        = : met toute les régions à la même taille (par rapport aux colonnes)
                        max : met la région au maximum de sa taille
                        min : met la région au minimum de sa taille

                        Note pour le "contexte":
                                -Appliqué dans une région non splitée : changera la taille en largeur
                                -Appliqué dans une région splitée : changera la taille en hauteur

	---------------
	CUSTOMIZATION
	---------------
                Note: Toutes les options de config sont présentes dans le man de screen ;).

                Configs:
                /etc/screenrc   : config générale appliquées à tout les utilisateurs
                $HOME/.screenrc : config de l'utilisateur (prioritaire)


	---------------
	KEYBINDING Avec Echappement
	---------------

                Tous les raccourcis listés dans cette section s'éxécute avec le caractère d'échappement
                ___________
                Syntaxe:
                        
                        bind [-c class] key [command [args]]

                        pour les raccourci octal mettre un "\" 
                                Voir ascii -o pour dumper les valeurs ascii en octal 
                                Le lien suivant peu aussi être util: 
                                http://www.asciitable.com/
                ___________
                Changer La touche d'échappement:

                        Il faut utiliser bindkey qui change directement l'interprétation des touches envoyées à screen sans passer par la touche d'échappement:

                                bindkey -k $RACCOURCI command

                                le raccouci peut être k0 correspondant à la touche F1 (voir le man section INPUT TRANSLATION pour avoir le tableau des avec le nom des touches / raccourci (termcap) de screen)

                                > bindkey -k k0 command

                ___________
                Supprimer un raccoucis

                        bind mon_raccourcis     #(Sans argument)

                        exemple:

                                > bind k
                                > bind ^k 

                                Va supprimer le raccourci Ctrl-k et k (apres avoir utilisé la touche d'échappement) par défaut.
                ___________
                Créer un raccourci simple

                        bind mon_raccourci ma_commande [mes_arguments]

                        exemple:

                ___________
                Créer un raccourci avec une classe


	---------------
	KEYBINDING Sans echappement 
	---------------

                La commande bindkey permet de lier une touche (un code plus précisément) à une commande.
                Pour cela screen dispose de sa propre table de correspondance.
                
                Pour voir les codes associés aux raccourcisi (termcap) , il faut éxécuter la commande suivante:

                > bindkey -d

                ou voir la section "INPUT TRANSLATION" du man

                En gros : 
                        Lorsqu'on appuie sur une touche, un code est envoyé à screen, celui-ci regarde sa table et éxécute la touche correspondante.
                        Pour envoyer une touche sur un screen détaché, on le fera avec stuff (voir coté scripting).

                Note :
                        Faite attention aux conflits avec votre terminal (celui qui éxécute votre session screen)

                ___________
                Syntaxe:

                        bindkey [-d] [-m] [-a] [[-k|-t] string [cmd args]]

                ___________
                Créer un raccourci de touche

                        > binkey -k $SCREEN_TERMCAP $SCREEN_COMMAND

                        (voir plus haut pour savoir ou se trouve les termcap et les commandes screen)

                        exemple:

                        > bindkey -k k2 title

                        Il suffira ensuite d'appuyer sur F2 pour changer le titre de sa fenêtre

                ___________
                Créer un raccourci d'un mot clé

                        > bindkey -t $keyword stuff $translation

                        Lorsqu'on tapera le $keyword, par exemple "banane", 
                        screen l'interprétera directement,
                        (le mot ne s'affichera même pas, dailleurs tout les mots commençant par b)
                        et écrira $stranslation, exemple "carotte".

	---------------
	STRING ESCAPE
	---------------

                %{=b}%H         : affiche le nom de la machine
                %{=s ky}%W      : affiche la liste des screen
                %{=b kg}        : surligner / mettre en évidence
                [%n %t]         : screen actif 
                %{=s}%c         : afficher l'heure

	---------------
	PARTAGER UN SCREEN
	---------------

	---------------
	SCRIPTING
	---------------

                Pour éxécuter des commandes au sein d'un screen via un script, 
                il faut passer par l'option -X de screen, permettant d'éxécuter les commandes screen.

                Si vous éxécuter la commande screen puis des commandes bash, celles-ci seront éxécutées après la session screen.
                        > #!/bin/bash
                        > screen 
                        > echo hello

                        => hello sera affiché dans le shell courant une fois la session screen finie.


                Note: Certaines commandes s'appliquent uniquement lorsque la session screen est attachée. 
                        (Exemple: split, wall ...) du moins je n'ai pas trouver d'autre manière de les éxécuter pour le moment ;).

                Forme générale du script:

                    °°°°°°°°°°°°°°°°°
                    screen -S NOM_SESSION -dm

                    sleep 1 && (
                        screen -S NOM_SESSION -X stuff "$(echo 'coucou')"
                        ...
                    )&

                    screen -r NOM_SESSION
                    °°°°°°°°°°°°°°°°°

                
                Voici un exemple de script jouant avec les sessions screen:

                °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
                #!/bin/bash
                 
                        #-X : Cette option sert à envoyer des commandes screen à des sessions screen
                        #-p : permet d'envoyer la commande à la bonne fenêtre
                        #-S : permet d'envoyer la commande à la bonne session
                  
                    

                        #on set des timers avant chaque éxécution de commandes envoyées à screen
                        #Cela évite beaucoup de problème de digestion !

                        cmd_timer="sleep 0.5"

                        #on créer une session détachée pour y envoyer des commandes
                            
                            screen -S $1 -dm    #optionnel dans cet exemple (car il peut être lancer à la fin) Mais peut servir dans d'autre contexte.

                       
                        #Ici le sleep permet d'éxécuter le bloque d'instruction entre () après s'être connécter à notre session screen.

                        sleep 2 && (

                               # stuff "cmd" pour envoyer du texte dans la console et le \015 permet de simuler un appuie sur la touche entrée
                                       screen -S $1 -p 0 -X stuff "$(echo -e 'ls\015')"
                                       $cmd_timer

                               # Je renomme ma fenêtre avec le nom de la commande éxecuté (pour le fun)
                                       screen -S $1 -p 0 -X title ls
                                       $cmd_timer

                               # Je créer un split horizontale, je m'y déplace et je lance une nouvelle fenêtre
                                       screen -S $1 -X split  
                                       $cmd_timer
                                       screen -S $1 -X focus down
                                       $cmd_timer
                                       screen -S $1 -X screen
                                       $cmd_timer

                               # J'applique un nouveau titre à mon shell pour plus de fun et je lance ma nouvelle commande
                                       screen -S $1 -p 1 -X title date
                                       $cmd_timer
                                       screen -S $1 -p 1 -X stuff "$(echo -e 'date\015')"
                                       $cmd_timer

                               # Puis toujours pour le fun, j'affiche un message qui apparait dans toute la session
                                       screen -S $1 -X wall "DONE!" 
                                       $cmd_timer
                        )&

                        screen -r $1    #On s'attache à la session.



                °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°

                Note: à voir si il y a une méthode plus simple pour éxécuter toute les commandes screen d'un seul bloque pendant la session...


	---------------
	Ma configuration
	---------------

                startup_message off     #supprime le message d'acceuil
                caption always "%{=b kg} [%n %t] %{=s ky}%W  %= %{=b}%H %{=s}%c " #Manipuler l'affichage de la barre d'activité.
                shelltitle ""           #Set le nom par défaut des onglets screen
                autodetach on           #(par défaut) garder les instances de screen en cas de détachement.
                defscrollback 5000      #Nombre de ligne gardées dans le buffer

#### Partager une session screen :

##### Connecté avec un même compte utilisateur

**Lancer un screen en background :**

    screen -d -m -S shared

**Afficher les sessions screen :**

    screen -ls

**Se rattacher au screen :**

    screen -x shared

##### Partagé avec d'autres utilisateurs

**Lancer un screen en background :**

    screen -d -m -S shared
    screen -r shared

**Activer le mode multiuser :**

    Ctrl-a :multiuser on
    Ctrl-a :acladd user2

**Se rattacher depuis un autre utilisateur :**

    screen -x user1/shared

~~~~~~~~~~~~~~~~~~~~~~~
TMUX
~~~~~~~~~~~~~~~~~~~~~~~

	---------------
	Shortcuts (par défaut)
	---------------

                Catégorie		Explication			 Raccourcis

                Echappement                                              ^b

                Aide                    
                                        
                Nouveau/splitter:      Nouveau shell                     c 
                                        
                                        
                Se déplacer:		
                                        
                                        
                Supprimer/Détacher:	
                                        
                                        
                Renommer:		

                Lancer des commandes:   

	---------------
        Links:
	---------------

                http://www.dayid.org/os/notes/tm.html


	---------------
        TIPS / COMMANDES
	---------------

                tmux ls         : lister les sessions tmux

~~~~~~~~~~~~~~~~~~~~~~~
BYOBU
~~~~~~~~~~~~~~~~~~~~~~~


	__________________
	$byobu : couche d'amélioration à GNU Screen/ TMUX (mais en plus facile à conf apparament)
	
	-S sessionName : ouvrir une nouvelle session
	-ls : voir les sessions byobu
	-r sessionName : ouvrir une session détachée
	-x sessionName : ouvrir une session non détachée
	-wipe : kill une session "dead"

Catégorie		Explication				byobu		byobu&screen	
								  
Creer:			Créer un nouveau terminal		F2 		CTRL+a c 	
			Split horizontal			SHIFT-F2 	CTRL+a S 	
			Split Vertical				CTRL-F2		CTRL+a | 	
								  
Se déplacer:		terminal précédent			F3		CTRL+a p 	
			terminal suivant			F4 		CTRL+a n	
			Split précédent				SHIFT-F3 			
			Split suivant				SHIFT-F4  	CTRL+a tab 	
			scrollup				alt-pgup  	CTRL+a Escp scrollup
			scrolldown				alt-pgdown  	CTRL+a Escp scrolldown
			Fusionner tout les split		SHIFT-F5  			
			Allez au Nième terminal					CTRL+a 0..9 	
			saisir le numéro du terminal				CTRL+a '	
			liste les différents terminaux				CTRL+a " 	
			liste avec le nom des terminaux				CTRL+a w 	
			retourner à l'ancien terminal				CTRL+a a 
								  
								  
Supprimer/Détacher:	Détacher la session			F6		CTRL+a d 	
			Détacher le terminal			SHIFT-F6			
			Supprimer le split			CTRL-F6		CTRL+a X	
			Supprimer les split sauf actuel				CTRL+a Q	
			Tuer le terminal actuel	(exit)		CTRL+a k	CTRL+D 		
			Détacher et fermer la session				CTRL+a DD 	
								  
Renommer:		Renommer le terminal			F8		CTRL+a A 	
								  
Menu/Mode		Recharger le profil			F5				
			Entrer en mode copy/scrollback		F7				
			Accès au Menu				F9				
			Vérouiller le terminal			F12				
			Reconnecter GPG et SSH			CTRL-F5 			
			Afficher le status détaillé		CTRL-a $ 			
			Recharger le  Profile			CTRL-a R  			
			raccourcis clavier on/off		CTRL-a !  			
			terminal buffer				CTRL-a ~  			
			Entrez en mode commande			CTRL+: <command>

				<Command>:
					resize : redimensionner la fenêtre courante
						resize +N : augmente de N lignes
						resize -N : diminue de N lignes
						resize N : dimensionne à N lignes
						resize = : mettre toute les fenêtre à la même taille
						resize max : dimensionne au max
						resize min : dimensionne au min


	
	Fichier de configuration:

	Dans le cas de screen, il est préférable de le configurer pour avoir un affichage plus simpatique:
		cp /etc/screenrc ~/.screenrc

		Décommenter les lignes qui sembles utiles:
		
		Ajouter:
			caption always
			caption string "%{kw}%-w%{wr}%n %t%{-}%+w"

		Afin d'avoir une étiquette en dessous du screen avec les sessions actives etc...

