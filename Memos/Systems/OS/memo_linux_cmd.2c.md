Linux commandes courantes
==============================


Normes et standards
-----------------------------

### POSIX


Il est définit par l'IEEE (Institute of Electrical and Electronics Engineers).  
C'est une famille de standard permettant de décrire un ensemble d'interfaces utilisateurs, logiciels, de scripts ainsi que des commandes, services et utilitaires.  
Ce dernier étant payant, certan système se rabatte sur SUS.

### SUS (Single Unix Specification)

Basé sur POSIX, il y ajoute quelques élements et certifie qu'un OS est un UNIX.


Arborescence type
-----------------------------

        /
        ├── bin     #Contient les exécutables utilisés par tous les utilisateurs
        ├── boot    #Fichiers permettant le démarrage du système
        ├── dev     #Fichiers représentants les périphériques
        ├── etc     #Fichiers de configuration du système et des services
        ├── home    #Répertoires personnels des utilisateurs
        ├── lib     #Contient les bibliotèques partagées (généralement des .so) pour les programmes.
        ├── media   #Prévu pour les points de montage des périphériques de stockage amovibles
        ├── mnt     #Prévu pour les points de montage divers
        ├── opt     #Répertoire prévu pour les extensions de programmes ou des sources de programme.
        ├── proc    #Contient les informations en temps réel du système
        ├── root    #Dossier personnel de l'utilisateur root
        ├── run     #Contient les fichiers PID des services en cours d'exécution.
        ├── sbin    #Contient les programmes système vitaux.
        ├── sys
        ├── tmp     #Fichiers à usage temporaire
        ├── usr     #Où s'installe les programmes demandés par l'utilisateur
        ├── var     #Dossier contenant des fichiers dont le contenu change dans le temps, comme des fils d'attentes, des logs, ou encore les fichiers de mails, d'impression...
                    #On y place aussi par convention les sites webs.

Les consoles/terminaux
-----------------------------

### Accèder aux consoles virtuelles (/dev/tty*)

#### Raccourcis clavier

* Ctrl + Left Alt + F1 à 6 : terminal 1 (tty1) à 6 (on peut tout de même aller jusqu'à 12)
* Ctrl + Left Alt + F7 : Retour au mode graphique

#### Changer de terminal (Ne fonctionne qu'en mode console système)

* $ chvt <ttX> : Permet de changer de terminal virtuel (pour bouger de console en console)

Exemple : 

    Ctrl + Left Alt + F2
    chvt 4


### Opérations sur les Shells

Les shells permettent d'étendre les fonctionnalitées des terminaux et notamment respecter les normes comme POSIX.

* $ bash	: lancer un shell de type "GNU Bourne-Again SHell"
* $ tty : Affiche le path du terminal actuel

Exemple de redirection de sortie vers un autre terminal :

    echo "hello" > /dev/ttyX

* $ xterm : programme d'émulation de terminal

On peut l'éxécuter avec un shell en particulier :

    xterm bash
    xterm sh

                __________________
                $xterm : lancer un nouveau terminal 
                        xterm SHELL : lancer le terminal dans le shell souhaité

                __________________
                $tput: initialiser un terminal

                __________________
                $reset : réinitialiser l'affichage du shell
                $tset

                    = tput reset

        --------------------------
        Clavier
        --------------------------
                __________________________
                Raccourcis : 

                        Affichage & Déplacements
                        ``````````````````````````

                            [Ctrl + l] : efface le contenu de la console.
                            [Shift + pgUp] : permet de remonter dans les messages.
                            [Shift + pgDn] : permet de redescendre.
                            [Ctrl + a] : ramene le curseur au début de la commande.
                            [Ctrl + e] : ramene le curseur à la fin de la commande.
                            [Ctrl + u] : supprime tout ce qui se trouve à gauche du curseur.
                            [Ctrl + k] : supprime tout ce qui se trouve à droite du curseur.
                            [Ctrl + w] : supprime le premier mot à gauche du curseur.
                            [Ctrl + y] : remet le texte supprimer precedement.
                            [Escp + f] : avance d'un mot
                            [Escp + b] : reculer d'un mot

                        Aide et Debug
                        ``````````````````````````

                            [Ctrl + r] : rechercher une commande déjà entrée.
                            [Ctrl + d] : interrompt une saisie (ferme la console si vide).
                            [Ctrl + c] : interrompt un programme (le termine)
                            [Ctrl + z] : met en pause l'execution d'une commande

                __________________________
                Automatiser une saisie clavier:

                    __________________
                    $xvkbd : Simuler une touche:

                __________________________
                Changer la disposition du clavier:

                    __________________
                    $loadkeys ID_pays : permet de changer de type de clavier en fonction du pays

                            > loadkeys fr : passera le clavier en azerty


        --------------------------
        Multiplexeur
        --------------------------
                Voir memo_multiplexeur_terminaux


        --------------------------
        Prompt
        --------------------------
                __________________________
                Symboles usuels:

                    $ : mode utilisateur
                    # : mode root

        --------------------------
        Invocation et Confguration d'un shell
        --------------------------

            See man bash, partie INVOCATION

                __________________________
                Charger un fichier bash ou un fichier tcl (Tool Command Language) :

                    __________________
                    $source FILE : interpréte un fichier comme un script tcl

                        Raccourci: 

                            > . FILE

                        exemple:
                        > 	source .bashrc
                        >	. .bashrc

                            --> rechargera la conf du bashrc

                __________________________
                shell de connexion (Login Shell) : 

                    __________________
                    $bash --login

                    Un login shell est un shell dont l'argument 0 équivaut à - ou lancé avec l'option --login.

                    Le fichier de configuration est un script shell, une séquence de commandes ayant pour but de configurer l'environnement utilisateur

                        Ordre d'exécution des fichiers à la connexion (=> mon_shell --login) :

                            - /etc/profile
                            - ~/.bash_profile
                            - ~/.bash_login
                            - ~/.profile

                        à la déconnexion :

                             - ~/.bash_logout


                        Note sur les sources login :
                        ``````````````````````````

                            En mode graphique:
                                source ~/.profile

                            A l'ouverture d'un terminal (sauf gnome et screen) 
                                source ~/.bash_profile

                            Dans un shell non login (ssh, scp, sudo (sans -i), su (sans -l): 
                                source ~/.bashrc
                                
                                #Très utile pour les variables d'environnement.

                __________________________
                shell interactif : 

                    Un shell lancé sans option.
                    __________________
                    $bash ou $bash -i

                    ordre d'execution:

                        - /etc/bash.bashrc      # Fichier de configuration global de la console
                        - ~/.bashrc             # Fichier de configuration de la console (activer les couleurs ...)

                __________________________
                shell non-interactif : 

                    Lancé Typiquement lors de l'éxecution de script.
                    Il essayera de charger la variable BASH_ENV comme un fichier de conf.

                __________________________
                Alias
                    __________________
                    création d'alias : 

                        alias nouvelle_commande = 'commande -paramètres'

                        exemple : 

                            > alias ll ='ls -l'

                __________________________
                Options de configurations :

                    __________________
                    $set: activer/désactiver une option du shell

                            +OPTION : désactiver l'option
                            -OPTION : activer l'option

                            Options:

                            a : Toutes les variables seront automatiquement exportées.
                            u : Par défaut le shell traite les variables inexistantes comme des châines vides. Cette option produit une erreur si la variable n'existe pas
                            x : Affiche toutes les commandes au fur et à mesure de leur exécution: (pratique en début de script).
                            o vi : Manipulation de la ligne de commande avec la syntaxe de vi.
                            o emacs : Manipulation de la ligne de commande avec la syntaxe de emacs.
                            C : Interdit les redirections en sortie si le fichier existe déjà.
                            history : Autorise la gestion de l'historique

                            Sans argument, la variable procède comme 'env' et liste toute les variables.


        --------------------------
        Naviguer dans un Shell
        --------------------------
                __________________
                $pwd : affiche le dossier actuel.

                __________________
                $ls : lister les fichiers et dossiers.
                        -a : afficher tous les fichiers et dossiers cachés.
                        -F : indique le type d' élément.
                                / : repertoire
                                * : executable
                                @ : lien symbolique
                        -l : liste détaillée
                        -h : afficher la taille en Ko...
                        -t : trier par date de dernière modification.
                        -c : idem mais par date de changemen d'état
                        -u : idem mais par date d'accès
                        -r : inverser l'odre de sortie
                        -i : Affiche l'inode
                        -1 : affiche sur une colonne
                        -d : sur un folder : précise le folder et non son contenu
                        -r : inverser l'ordre d'affichage

	
                __________________
                $dir : même fonction que ls 
	
                __________________
                $cd <monDossier> :  changer de dossier

                    Sans argument: retout dans le dossier personnel:

                        ~ ou encore $HOME
                __________________
                $pushd <monDossier> :  Sauvegarder le path d'un dossier dans la pile de dossier
                $popd : se deplacer dans le dossier du haut de la pile de dossier
	
        --------------------------
        Wildcards
        --------------------------

                !		        : Rappeler une commande
                * 		        : représente n'importe quel caractère.
                ? 		        : représente un seul caractère.
                [abcde] 	    : représente un caractère défini entre crochets.
                [a-e] 		    : représente un caractère compris entre les 2 caractères (de a à e).
                [!abcde] 	    : représente tout les caractères qui ne sont pas listés;
                {debian,linux} 	: représente un des mots listé;
                ()              : grouper un résultat
                !()             : afficher l'inverse (necessite l'option extglob)

                exemple:

                    >	ls [A-Z]*.txt

                        --> affichera tout les fichier.txt commençant par une majuscule

                
                Pour grouper le résultat et afficher l'inverse :

                    > ls $HOME/Documents/!(*.pdf)

                Note :

                    Le groupement fonctionne avec l'option extglob de bash :

                    Pour l'afficher :

                        > shopt extglob

                    Pour l'activer :

                        > shopt -s extglob

                    Pour le désactiver :

                        > shopt -u extglob

        --------------------------
        Historique
        --------------------------
                __________________
                $history : voir les dernieres commandes

                        Cette commande va regarder dans le fichier /home/user/.bash_history

                        history -c : supprime l'historique des commandes

                        Il peut y avoir d'autre commandes stockées dans ~/.bash_history:
                        "> ~/.bash_history" : pour tout supprimer.

                __________________
                ![CODE] : ce wildcard permet de rappeler une commande contenu dans l'historique (voir $history)

                        !! : rappel la derniere commande
                        !n  : rappel la commande N°n 


        --------------------------
        Chaîner les commandes
        --------------------------
                __________________
                | : chaîner les commandes (utilise le résultat de la commande précedente)

                    exemple : cut -d , -f 1 noms.txt | sort > noms_tries.txt

                    Utilise le principe des canaux, il redirige directement le canal de sortie d'une commande vers le canal d'entrée d'une autre.
                            
                __________________
                <cmd1> ; <cmd2>   : execute une la commande 1 puis la 2 ...
                    
                    Attention lorsque l'on utilise le groupement de commande en mettant en arrière plan les processus. Ils tourneront en parallèle.

                    exemple: 
                        ls | grep file > result.txt & ; pwd > result.txt&

                        Il risque d'y avoir un conflit. 
                        Dans ce cas, il vaut mieux utiliser les parenthèses:

                        (<cmd1> ; <cmd2>) > result.txt &

                        Les commandes placées entre parenthèses sont lancées par un sous-shell et exécutées séquentiellements. La redirection concerne ainsi l'ensemble des commandes. 
                
                        Il est possible de grouper les commandes en les executant dans le shell actif avec les accolades: (finir par un ";")

                        { uname -a; pwd ; ls -l;} > result $

                __________________
                <cmd1> && <cmd2>  : si la commande suivante est éxécuté uniquement si le code erreur de la commande précédente = 0.
                <cmd1> || <cmd2> : idem mais si le code d'erreur est != 0

        --------------------------
        Personnaliser
        --------------------------
                __________________________
                Couleurs :

                    Voir > less /usr/share/doc/xterm/ctlseqs.txt.gz

                    exemple:
                            echo -e '\e ... todo
                __________________________
                Prompt :


        --------------------------
        Variables
        --------------------------
                __________________________
                Variables d'environnement:

                    __________________
                    $env : lancer un processus dans un environnement particulier

                        Sans argument: affiche les variables d'environnement courante.
                        env var1=XX var2=YY commande : Redéfini l'environnement du processus à lancer en changeant les variables définient en arguments. 


                        Variables Systèmes :
                        ``````````````````````````

                           $SHELL:      Indique le type de shell en cours d'utilisation
                           $PATH:       liste de répertoires (séparés par des ":") contenant les binaires, les commandes externes et scripts que le shell peut executer.
                           $EDITOR:     Editeur de texte par défaut
                           $HOME:       Le path du repertoire personnel
                           $PWD:        Le dossier dans lequel on se trouve
                           $OLDPWD:     Le dossier dans lequel on se trouvait auparavant
                           $PS1:        Prompt String 1, chaîne représentant le prompt standard affiché à l'écran par le shell en attente de saisie de commande

                                        Note: PS1 interprete directement son contenu.
                                        On peut donc mettre un script à l'interieur.
                                        Il sera évalué à chaque appel de la variable.

                                        exemple:
                                            
                                            PS1=$(perl -e "system('tput setaf ' .int(rand(8)))")

                           $PS2:        Prompt String 2, idem que PS1 mais pour un prompt secondaire dans le cas où la saisie doit être complétée. 
                           $PS3:        Définit l'invite de saisie pour un select.
                           $IFS:        Internal Field Separator, liste des caractères séparant les mots dans une ligne de commande. Par défaut il s'agit de l'espace, de la tabulation et du saut de ligne.
                           $MAIL:       Path et fichier contenant les messages utilisateur.
                           $LANG:       Définition du type d'encodage pour le shell courant
                           $USER:       Nom de l'user en cours
                           $LOGNAME:    Nom du login utilisé lors de la connexion
                           $HISTFILE:   Nom du fichier historique, généralement $HOME/.sh_history.
                           $HISTSIZE:   Taille et nombre de lignes de l'historique
                           $RANDOM:     Génère et contient nombre aléatoire entre 0 et 32767
                           $TERM        Affiche le type de terminal dans lequel on se trouve
                __________________________
                Variables bash :
		  
                    $? : Code de retour de la dernière commande exécutée.
                    $$ : PID du shell actif
                    $! : PID du dernier processus lancé en arrière plan
                    $- : liste des options du shell
                __________________________
                Exporter une variable :

                   Une variable n'est, par défaut, accessible que depuis le shell où elle a été définie. 
                   Il faut utiliser la commande "export" pour la rendre accessible aux sous-shell ainsi qu'aux différents scripts.
                   Les modifications apportées à la variable sont locales et n'affectent pas sa valeur d'origine (dans le cas ou elle est modifiée par un script ou un sous-shell)

                    __________________
                    $export <variable> : exporte la variable afin que son contenu soit visible par les sous-shells.

                        exemple:

                        > kikou="hello"
                        > set |grep kikou

                            Affichera la variable kikou=hello

                        > bash
                        > set |grep kikou 

                            La variable ne sera pas présente

                        > exit 	# (on sort du sous shell)
                        > export kikou 
                        > bash
                        > set |grep kikou

                            Affichera la variable kikou=hello

                        Ici on voit clairement qu'a l'aide d'export la variable sera disponible dans les sous shell crées.


                        -n <variable> : permet d'enlever le marquage d'export d'une variable (pour qu'elle ne soit plus exportée).


                        export : sans argument, affichera toute les variables (declare -x) qui seront exportées.


~~~~~~~~~~~~~~~~~~~~~~~~~~
GUI
~~~~~~~~~~~~~~~~~~~~~~~~~~
        __________________________
        redemarrer l'interface graphique:

                Ctrl + Alt + Backspace

                ou pour xfce : 
                
                    > /etc/init.d/lightdm restart

        __________________
        $xvfb: serveur X framebuffer virtuel

            idéal pour lancer des application graphique depuis la ligne de commande.
            $xvfb-run COMMANDE: lancer une commande en mode graphique.

            exemples d'utilisation:

                Xvfb :21 -screen 0 1024x768x24 -extension RANDR &

~~~~~~~~~~~~~~~~~~~~~~~~~~
L'aide
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        RTFM
        --------------------------
                __________________
                $man <commande>: afficher le manuel d'une commande
                        -k : permet de faire une recherche thématique (voir apropos)

                        Structure d'un man:
                        ``````````````````````````

                                [NAME] : le nom de la commande dont vous êtes en train d'afficher le manuel, ainsi qu'une courte description de ce à quoi elle sert. 
                                [SYNOPSIS] : c'est la liste de toutes les façons d'utiliser la commande.
                                [DESCRIPTION] : une description plus approfondie de ce que fait la commande. On y trouve aussi la liste des paramètres et leur signification. C'est en général la section la plus longue. 
                                [AUTHOR] : l'auteur du programme. Parfois, il y a de nombreux auteurs, c'est souvent le cas d'ailleurs avec le logiciel libre. 
                                [REPORTING BUGS] : si vous rencontrez un bug dans le logiciel, on vous donne l'adresse de la personne à contacter pour rapporter le bug. 
                                [COPYRIGHT] : le copyright, c'est-à-dire la licence d'utilisation de la commande. La plupart des programmes que vous utilisez sont certainement des programmes open-source sous licence GPL, ce qui vous donne le droit de voir la source et de redistribuer le programme librement. 
                                [SEE ALSO] : cette section vous propose de "voir aussi" d'autres commandes en rapport avec celle que vous êtes en train de regarder.

                        syntax du SYNOPSIS:
                        ``````````````````````````

                                gras : taper le mot exactement comme indiqué
                                souligné : remplacer le mot souligné par la valeur qui convient.
                                [-x...] : toutes les options entre corchets sont facultatives.
                                a | b : signifie a ou b
                                option... : les points de suspension indiquent que l'option peut être répétée à volontée.

                        sections:
                        ``````````````````````````

                            Il existe aussi plusieurs sections dans un man concernant une thématique bien définis.

                            $man X <commande> :

                                Avec X le numéro de la section:

                                1  Commandes shell et éxecutables
                                2  Appels/fonctions systèmes
                                3  Appels des librairies
                                4  Fichiers spéciaux (exemple : /dev)
                                5  Formats des fichiers
                                6  Jeux
                                7  Divers
                                8  Commandes d'administration utilisées sous root principalement
                                9  Concernant les routines du noyau (non standard)    

                        Location manpage:

                                Les manpages sont situés dans /usr/share/man et sont rangés par catégories. On y trouve aussi certain man traduit dans différentes langues selon ce qu'on a installé.

                        Modifier le path des manpages:

                                Il est possible de modifier, rajouter des path pour accéder aux manuels:

                                        Il suffit d'éditer le fichier de conf de man:

                                                >vim /etc/manpath.config

                                        Il est préférable de mettre ses manpages dans /usr/local/man

                                        Pour plus de détail sur la syntaxe du fichier:

                                                >man manpath

	__________________
	$apropos : trouver une commande

	__________________
	$whatis : manuel très abrégé d'une commande

	__________________
	$info : sorte de manuel avancé
		$info coreutils : résumé des principales commandes sous linux

~~~~~~~~~~~~~~~~~~~~~~~~~~
Debug
~~~~~~~~~~~~~~~~~~~~~~~~~~
	__________________
    $gdb : GNU Debugger

        Permet de voir ce qui se passe à l'intérieur d'un programme et notament ce qui n'a pas fonctionné avant qu'il crash.

        voir http://doc.ubuntu-fr.org/gdb et le man

        > gdb MON_PROGRAMME

        Les commandes:

            run: lance le programme
            continue: relance le programme

    __________________
    $strace : permet de voir les appels et les signals du systeme d'un processus en cours:

        -p PID : permet de renseigner le processus à écouter
        -f : permet d'écouter aussi les processus fils.

    __________________
    $ltrace : Intercept les appels de libs et les signaux d'un process jusqu'à ce qu'il s'arrête.

        > ltrace monProg

    __________________
    $valgrind : donne un set d'outils permettant de debuguer un programme.

    __________________
    $apport : set d'outils de debug avec reporting au système de bug tracking de la distribution.

        apport-bug
        apport-collect


~~~~~~~~~~~~~~~~~~~~~~~~~~
Fichiers
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Types et Encoding
        --------------------------

                - : Fichier simple (contenant des données)  [exemple: /etc/hosts]   
                d : Répertoire (diretory)       [exemple: /home]
                s : Socket (Connexion réseau)   [exemple: /var/run/acpid.socket=]
                b : Fichier spécial de type bloc (concerne les périphériques de stockage) [exemple: /dev/sd*]
                c : Fichier périphérique (Character device) (ne stocke pas de données) [exemple: /dev/tty*]
                l : lien symbolique  [exemple: /dev/cdrom]
                p : tube (pipe) : permet d'envoyer et recevoir du flux par ce fichier: 

                                mkfifo fifo
                                cat fifo
                                echo hello > fifo
	
            __________________
            $file FILE : permet de determiner le type de fichier et son encoding

                    -i : permet de connaître le MIME-TYPE

            __________________
            $iconv : changer l'encoding d'un fichier :

                Exemple convertir un fichier utf8 en ascii :

                    > iconv -f utf8 -t ascii /mon/fichier

        --------------------------
        Création
        --------------------------
            __________________
            $touch : créer un nouveau fichier
                    
                            Il est aussi possible d'utiliser les canaux pour créer un nouveau fichier:

                            exemple:
                                    
                                    ":> monfichier"  #Créera monfichier

                                    (Note les ":" sont optionnels)

            __________________
            $mkdir : créer un nouveau dossier
                -p : créer tout les dossiers intermédiraires si ils n'existent pas
            
            __________________
            $ln : créer un lien physique (uniquement sur fichier) (lien sur le même contenu, le même inode)
                -s : créer un lien symbolique (lien sur un fichier ou dossier avec un inode différent)

                (préférez les chemin absolu pour cette commande)
            __________________
            $mktemp : générer un fichier temporaire aléatoire
                -d : générer un repertoire temporaire aléatoire

            __________________
            $mkfifo : permet de créer une fichier de type pipe

            __________________
            $gnome-desktop-item-edit : créer un raccourci bureau
                --create-new /PATH/TO/DIR

                Les raccourcis bureau sont des fichiers avec une syntax particulière et portant souvent l'extension .desktop.

                sous gnome:

                    [Desktop Entry]
                    Version=1.0
                    Type=Application
                    Terminal=false
                    Icon[en_US]=icedove
                    Name[en_US]=icedove
                    Exec=icedove
                    Comment[en_US]=Client Mail
                    Name=icedove
                    Comment=Client Mail
                    Icon=icedove

        --------------------------
        Suppression
        --------------------------
            __________________
            $rm : supprimer un fichier
                -i : demande confirmation
                -f : forcer la suppression
                -v : mode verbeux
                -r : supprimer un dossier et son contenu
            
                Attention toutefois à cette commande qui supprime définitivement le fichier. La seul manière de récupérer les données est d'utiliser des softs de récupération de données (qui sont souvent peu performant). 
            
                On peut protéger les fichiers en mettant un tiret devant leur noms.
                exemple : "-fichier"
            
                La commande rm sera alors inéficace interprétant le fichier comme un paramètre.
                    Pour supprimer ce fichier il faudra utiliser le l'option "--" ou "./" qui signifie fin des options.
                
                    exemple:
                        rm -- -fichier
                    ou	rm ./-fichier			
            __________________	
            $rmdir : supprimer un dossier (non recursif)

            __________________
            $shred : Réecrire le contenu d'un fichier et le supprimer (optionnellement)

                Fonctionne sur les fichiers et permet de supprimer un fichier sans qu'il puisse être récupérable (ou plus difficilement)

                -f force
                -u supprimer après avoir modifier le contenu
                -z Ajouter un 0 pour cacher le shreding
                -v mode verbose

                > shred -ufzv monFichier 

        --------------------------
        Affichage
        --------------------------

            __________________
            $cat <MonFichier> : afficher le contenu d'un fichier

                    -n : affiche les numéros de lignes.

                    Il est aussi possible d'afficher le contenu de l'entrée via des chevrons et un mot clé (celui qu'on veut):

                    cat <<MESSAGE

                        mon Message 
                        sur plusieurs lignes

                    MESSAGE
                        

            __________________
            $nl : affiche le contenu d'un fichier et les numéros de lignes

            __________________
            $tac : affiche le fichier à l'envers

            __________________
            $hexdump : affichage en hexadécimale, decimale, octale et ASCII.

                    -c : pour afficher les caractère de façon plus visuel

                    Pratique pour la manipulation de châine et voir les caractères spéciaux en ascii

                    exemple: 

                    >	cat fichier |grep string |hexdump -c
            __________________
            $xxd : afficher en hexadecimal et en binaire
                    -b : afficher la valeur de chaque bit (binaire)
                    
            __________________
            $od : afficher un fichier sous forme octale
                    Voir le man pour les autres possibilités

            __________________
            $od : afficher un fichier sous forme octale

            __________________
            $bc : faire des conversions de base

                Exemple, convertir du decimal en binaire :

                    > base='2'
                    > nb='5'
                    > echo "obase=$base;$nb" | bc
                    
            __________________
            $pr : formater le fichier pour impression
            
            __________________
            $less : affiche le fichier page par page
                    +F : idem que pour un tail -f (mais il est possible de revenir plus loin dans le fichier à tout moment!)
                            Pour couper un less +F il faut utiliser "CTRL + C"
                            Pour revenir dans le mode d'affichage en temps réel, utilisez "F"
                    -R : permet d'interpréter les caractère de contrôle (notament la couleur ...)

                    Touches			Effets

                     h			Affiche l'aide
                    Espace			Affiche la suite du fichier 
                    Entrée			Affiche la ligne suivante
                    d			Affiche les 11 lignes suivantes
                    b			Retourne en arrière d'un écran
                    y			Retourne en arrièere d'une ligne
                    u			Retourne en arrière de 11 lignes
                    q			Quitte l'affichage.
                    =			Indique où l'on se trouve
                    /REGEX			recherche de haut en bas
                    ?REGEX                  recherche de bas en haut
                    n			Permet d'aller à la prochaine occurrence d'une recherche
                    N			idem que « n » mais pour revenir en arrière
                    F			Retourner en mode lecture dynamique (Ctrl C pour abort)
            
            __________________
            $more : afficher page par page ($less est plus récent)
            $pg : idem
            __________________	
            $head : afficher le début d'un fichier (les 10 premieres lignes par défaut)
                    -n X: affiche les X premières lignes.
                    -c N : affiche les N premiers octets
            
            __________________
            $tail : affiche la fin d'un fichier. (les 10 dernières lignes par défaut)
                    -n X : affiche les x dernières lignes.
                            +X : affiche à partir de la Xième ligne
                    -f : suit le fichier au fur et à mesure de son évolution (Ctrl + C pour arreter la commande)
            __________________
            $figlet : créer de gros texte formatés en ASCII:

                figlet -f script mon_texte

                exemple:
                     > watch -n1 "date '+%D%n%T' |figlet -k"

            __________________
            $toilet : Du même genre que figlet mais avec de la couleur:

                exemple:
                    echo "gay life" |toilet -f term -F border --gay
                    

        --------------------------
        Copier
        --------------------------
            __________________
            $cp : copier un fichier
                -R : copier des dossiers
		
        --------------------------
        Renommer/Déplacer
        --------------------------
            __________________
            $mv : déplacer/renommer un fichier/dossier

            __________________
            $rename [OPTIONS] [EXPR] : renommer un ou des fichiers selon une expression:
                    -v : mode verbose
                    -n : ne pas appliquer , juste afficher le résultat

                            rename -vn 's/amm//' amm*      : Supprimera le mot amm de tout les fichiers comportant ce nom
                            rename -v 's/bibo/bobi/' *      : remplacera bibo par bobi pour tout les fichiers

		
            __________________
            Exemple de renommage, change d'extension de plusieurs files

                En utilisant rename:

                    rename 's/\.example$/\.else/' *.txt

                En utilisant les fonctions du shell:

                    for i in *.txt;do mv $i ${i%.example}.else ;done 


        --------------------------
        Comparer et patcher
        --------------------------
            __________________
            $diff : comparer des fichiers et indiques les modifications à apporter.

                -b : ignorer les espaces
                -r : check les sous dossiers

                > diff -r dir1 dir2

                trois types de messages:

                    -APPEND (a)
                    -DELETE (d)
                    -CHANGE (c)

                exemple:

                    > diff file1 file2

                    -->
                        2a5,6 : À la ligne 2 du file1, ajouter les lignes 5 et 6 de file2 pour que leurs contenus soient identiques.
                        1,6d0 : Les lignes 1 à 6 du file1 sont à supprimer, elles ne sont pas présentes à partir de la ligne 0 du file2
                        4c5 : la ligne 4 de file1 doit être échangé contre la ligne 5 de file2 pour que leurs contenus soient identiques.
                        > XXX : ligne manquante dans fichier1
                        < XXX : ligne manquante dans fichier2

                Créer un patch:

                    On redirige simplement la sortie du diff dans un fichier

                    > diff -u version1 version2 > update.patch

            __________________
            $patch : appliquer un patche (créer avec diff par exemple)

                -pN : avec N le nombre de slash avant que le préfixe ne soit supprimer sur les nom de fichier du patch.

                exemple:

                    Appliquer le patch simplement:

                        > patch -p0 < update.patch

                    Si l'on shouaite garder un nom de fichier à partir du deuxième slash:

                        /u/howard/src/blurfl/blurfl.c

                        > patch -p2 < update.patch

                            Le path deviendra: howard/src/blurfl/blurfl.c

            __________________
            $cmp : compare les fichiers caractère par caractère.

                La commande s'arrête dès qu'elle trouve une erreur.

                -l : liste toutes les différences trouvées
                    1ere colonne : représente la position du caractère
                    2eme colonne : la valeur octale du carctère du premier fichier
                    3eme colonne : idem pour le second fichier

                -s : retourne uniquement le code d'erreur. (visible avec $?)
            __________________
            $rdiff : Calcul et applique les différences de fichiers à base de signature


        --------------------------
        Editer
        --------------------------
            __________________
            $editor : ouvre l'éditeur de texte par défaut

                Pour changer l'éditeur par défaut sur une ubuntu, se référer à update-alternatives
                
                Sinon changer les variables d'environnements:
                    EDITOR=/path/to/editeur
                    VISUAL=/path/to/editeur

            __________________
            $nano : ouvre l'éditeur nano

                -m autorise l'utilisation de la souris
                -i indentation automatique
                -A : active le retour intelligent au début de ligne 

                utilisez vim ou emac pour avoir un éditeur plus complet (voir memo_vim)

            __________________
            Changer l'éditeur de texte par défaut:

                    Voir le lien 'editor' présent dans 
                            /usr/bin/editor

                    vim ~/.bashrc
                            export VISUAL=/usr/bin/vim
                            export EDITOR=/path/bin/vim

                    update-alternatives --config editor

                    tester: 
                            editor

        --------------------------
        Rechercher
        --------------------------

            __________________
            $locate FILE: faire une recherche rapide d'un fichier sur la base de données construite par updatedb

            __________________
            $slocate : idem que locate mais vérifie les droits sur le fichier avant de le lister.

            __________________
            $updatedb : met à jour la base de donnée de fichiers selon une série de chemin spécifiés dans un fichier de config

                Cette commande est généralement lancée par la crontab.

                fichier de config dans /etc/sysconfig/locate
                base dans /var/lib/locatedb
                

            __________________
            $find : faire une recherche approndie d'un fichier

                    $find [OÙ] QUOI [QUE FAIRE AVEC] 
                        autrement dit:
                    $find [PATH] CRITÈRES [OPTIONS]
                    
                        (seul le paramètre « quoi » est obligatoire)
                
                -print : permet d'afficher sur l'écran le résultat (implicite sur la plupart des Unix)
                
                -name "NOM": faire une recherche exact du nom renseigné
                    exemple: find . -name "memo*" -print
                    
                -type TYPE : Selectionne par type de fichier
                    
                    Type: 
                        - : Fichier simple (contenant des données)
                        d : Répertoire (diretory)
                        s : Socket (Connexion réseau)
                        b : Fichier spécial de type bloc (concerne les périphériques de stockage)
                        c : Fichier périphérique (Character device) (ne stocke pas de données)
                        l : lien symbolique
                        p : tube (pipe) : permet d'envoyer et recevoir du flux par ce fichier:
                                mkfifo fifo
                                cat fifo
                                echo hello > fifo
                        
                    exemples: 
                                        find . -name "*s" -type d

                -user USER ou ID : recherche les fichiers appartenants à l'utilisateur cité.
                -group GROUP ou ID : recherche les fichiers appartenants au groupe spécifié.
                    exemple: find / -type f -user paul -group paulos 
                
                -size SIZE: recherche à partir de la taille
                    -empty : = -size 0
                
                    Size:
                        b : (par défaut) bloc de 512 octets
                        c : en octets (= 1 caractère)
                        w : 2 octest (= mot au sens ancien)
                        k : kilo octets
                        M : Méga octets
                        
                        ...
                
                    exemples : 
                        find ~ -size +10M : recherche les fichiers de + de 10 Mo 
                        find . -size -152c : recherche les fichiers de moins de 152 octets
                        
                     
                -atime : recherche à partir de la date de dernier accès : 
                -mtime : recherche sur la date de dernière modification
                -ctime : recherche la date de changement (du numéro d'inode)
                
                    Ces 3 derniers critères travaillents qu'avec des jours:
                        0 : même jour
                        1 : hier (entre 24 et 48h)
                        ...
                        
                    exemple:
                        -mtime 1 : fichier modifié hier
                        -mtime -4 : modifié il y a moins de 4 jours
                        -mtime +4 : modifié il y a plus de 4 jours
                        
                -newer, -anewer -cnewer : prennent comme paramètre un fichier, find trouvera les fichiers plus récent que celui précisé.
                        
                -printf : afficher les fichiers de façon formatée. 
                    exemple : find -name «op» -printf «%p - %u\n »
                    
                -delete : supprime les fichiers trouvés.
                
                -exec : appeler une commande

                            Note: xargs semble bien plus rapide !

                -ok : idem que exe mais avec la confirmation
                
                    Explications:
                        {} : remplacé par le nom du fichier recherché
                        \;  obligatoire pour finir la saisie.
                        
                    exemple : find ~ -name «*.jpg » -exec chmod {} \;
                        
                -perm : recherches sur les autorisations d'accès (en base 8)
                    exemple : -perm -111 : recherche les fichiers dont les permission sont infèrieur à cette valeur.
                    
                -links : recherche par nombre de hard link (fonctionne avec + et -)
                    1 lien = 1 fichier normal
                    2 liens = 1 dossier
                    
                -inum : recherche par N° d'inode 
                
                -ls : affiche des infos détaillées sur les fichiers trouvés
                    (coorespond à un ls -dils)
                
                
                Combinaisons d'options:
                    -a, -and : AND, ET logique
                    -o, -or : OR, OU logique
                    ! : négation
                    
                    Exemples:
                        find . -name "*mot1*" -o -name "*mot2*"
                        find ! -name "*file"  

                        Usefull:

                                find mondossier -type d -exec chmod 755 {} \;
                                find mondossier -type f -exec chmod 644 {} \;

            __________________	
            $whereis BINAIRE: recherche dans les path de fichier binaires, du manuel et des sources les fichiers correspondant à la recherche
                    
                -b : uniquement pour les binaires
                -m : uniquement pour les manuels
                -s : uniquement pour les sources
                
                Par défaut recherche dans 
                /{bin,sbin,etc}
                /usr/{lib,bin,old,new,local,games,include,etc,src,man,sbin,X386,Tex,g++-includes}
                /usr/local/{X386,Tex,X11,include,lib,man,etc,bin,games,emacs}
                
            __________________
            $which : connaître l'emplacement d'une commande.
                
                recherche une commande dans le PATH et fournis la première qu'elle trouve	
                
                -a : afficher toutes les correspondances
                    (la première est celle exécuté par défaut)

        --------------------------
        Vérifier
        --------------------------

            Pour vérifier l'intégriter d'un fichier, il est souvent possible de comparer le résultat du hash md5:

            __________________
            $md5sum <FILE> : affiche le résultat du hash md5 sur le fichier.

                Plusieurs méthodes de hash sont utilisables:

                exemple:
                    $sha512
            __________________
            $gpg --keyserver <@_server> --recv-keys <Id> : permet d'importer la clé (public) gpg pour procéder ensuite à la vérification de la signature:

                gpg --verify <signature_importé> <fichier téléchargé>

        --------------------------
        Exécuter / Ouvrir
        --------------------------

            De façon générique:

                > $monProgramme monFichier
            __________________
            $gnome-open fichier : ouvrir un fichier avec le programme par défaut

        --------------------------
        Diviser
        --------------------------
            __________________
            $split : (plus pratique)

                    $split [-l N] [-b N[bkm] [FILE [PREFIXE]]
            
                    -l N : découpe le fichier (input) en plusieur fichier contenant N lignes (output)
                    -b [bkm] : découpe en fonction de la taille en octet (bytes), kilo, mega octets

                    Découpe:

                    > split -d -b <Taille_En_Mega_Octet>m <Fichier à découper> <préfixe>

                    Réassemblage:

                    > cat <préfixe>* > <Fichier à réassembler.iso>

        --------------------------
        ISO
        --------------------------
                ____________________
                $osirrox : extraire le contenu d'une iso

                    > apt-get install xorisso

                    > osirrox -indev /path/to/iso -extract / /full-iso-contents

                Voir mount pour monter une iso et extraire son contenu.
            

~~~~~~~~~~~~~~~~~~~~~~~~~~
Archives
~~~~~~~~~~~~~~~~~~~~~~~~~~
		
        --------------------------
        Copier
        --------------------------
                ____________________
                $cpio OPTIONS FILES: permet de copier les fichier depuis et vers des archives.
                                        (il supporte le format tar)

                        -o : création à partir des entrées et sortie standard
                        -i : consultation et extraction à partir de l'entrée standard
                        -p DIR : copie des fichiers de l'entrée standard dans le repertoire.
                ____________________
                Copier vers un repetoire:

                        $tar fromdir;tar cd -. |(cd todir;tar xpf -)

        --------------------------
        Ajouter
        --------------------------
                ____________________
                Ajouter un fichier à une archive: (.tar)

                        $tar -rvf <Archive.tar> <fichier à insérrer>
                                r : append (ajouter)
        --------------------------
        Création
        --------------------------
                ____________________
                $tar -cvf <Nom_archive.tar> <Folder ou fichiers à archiver/>
                        c : créer une archive
                        v : mode verbeux
                        f : utiliser un fichier d'archive

        --------------------------
        Visualisation
        --------------------------
                ____________________
                $tar -tf <Archive.tar>
                    t : lister le contenu de l'archive

        --------------------------
        Désarchiver / Extraire
        --------------------------
                ____________________
                $tar -xvf <Archive.tar>
                        x : extraire

        --------------------------
        Utilitaires de compression/décompression
        --------------------------
            __________________
            $gzip (le plus courant) (.gz)

                $gzip <archive.tar> : comprésser
                $gunzip <archive.tar> : décompresser

                $tar -zcvf <New_archive.tar.gz> <folder/> : archive et compresse
                $tar -zxvf <Archive.tar.gz> <target>: Décompresse et extrait le dossier spécifié
                $tar -ztf <Archive.tar.gz> : pour gzip : Afficher le contenu
                $tar -zxvf fichier.tar.gz -C /path/to/decompress : Décompresse et extrait vers le path donné.
                
                $zcat <fichier.gz> : lire le fichier compréssé
                $zmore <fichier.gz> : idem (équivalent à more)
                $zless <fichier.gz> : idem (équivalent à less)

            __________________
            $bzip2 (meilleur compression mais plus lent) (.bz2)

                $bzip2 <Archive.tar> : comprésser
                $bunzip2 <Archive.tar.bz2> : décomprésser

                $tar -jcvf <New_archive.tar.bz2> <folder/> : archive et compresse
                $tar -jxvf <Archive.tar.bz2> <New_folder> : décompresse et extrait
                $tar -jtf <Archive.tar.bz2> : Afficher le contenu
            __________________
            $lzma (meilleur compression que bzip mais peut prendre encore plus de temps)

                $lzma | $xz -z FILE

                $tar -Jcvf <Archive.tar.xz> <New_folder> : archive et compresse
                $tar -Jxvf <Archive.tar.xz> <New_folder> : décompresse et extrait
			
            __________________
            $zip (.zip)
                
                $zip -r <New_Archive.zip> <file_to_zip> : comprésser
                $unzip <Archive.zip> : décompresser
                $unzip -l <Archive.zip> : voir le contenu de l'archive
			
            __________________
            $rar (.rar)
                
                $unrar e <Archive.rar> : décomprésser
                $unrar l <Archive.rar> : Afficher le contenu
		
            __________________
            $7zip (.7z) (activer les dépôts universe pour l'installer)
                
                $p7zip -d <archive.7z> : décompresse l'archive
                $7z : décomprésser/compressé ...
                    7z x <archive>: décompresse
                    7z a <archive> <fichiers> : comprésser

        --------------------------
        Découpage et Réassemblage
        --------------------------
                __________________
                $tar :
                        
                    Découpe:

                        > tar -c -M --tape-length=<Taille en Octet> -f <Nom_Archive>.tar <Fichier à découper>
                                Il faudra ensuite renseigner chaque nom :   n <nom_Archive2...>.tar

                    Réassemblage: 

                        > tar -x -M -f <NomArchive>.tar
                                Il faudra ensuite renseigne chaque partie à réassembler: n <NomArchive2...>.tar

                __________________
                $rar :
                        
                    Découpe:

                        > rar a -v<Taille_En_Mega_Octet>m <NomVolume> *.avi

                        Il sera découpé ainsi: <NomVolume>.partX.rar 

~~~~~~~~~~~~~~~~~~~~~~~~~~
Redirection de flux
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Filtres et substitution
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Authentification
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        PAM (Pluggable Authentication Modules)
        --------------------------

            Gère les statégies d'authentification des services tel que samba, sudo ...


                __________________________
                L'aide :

                    > man pam.d



                __________________________
                Configuration :

                    Anciennement la configuration ce faisait dans /etc/pam.conf
                    Il est préférable de placer un fichier de conf par service dans /etc/pam.d
                    Par défaut c'est le fichier de conf "other" qui est appliqué.

                    Ce qu'on peut trouver dans un fichier de conf:

                        - le type de module: 

                            auth: 
                                Vérifie l'identité de l'utilsateur (demande de password).
                                Donne les droits à l'utilisateur.

                            account:
                                utilisé pour la non-authentification
                                surtout pour restreindre et permettre les accès aux service momentanément.

                            password:
                                Mettre à jour les token d'auth

                            session:
                                Les actions à faire avant ou après le démarrage d'un service.
                                (exemple: montage de dossier ...)
                                        


                        - Les modules : comprend les modules executables

                            Ils sont contenus dans /lib/security/pam_*.so	

                            exemples de modules:

                                pam_access: login access control
                                pam_cracklib: contrôler le password
                                pam_debug: debug des couches pam
                                pam_deny: bloquer PAM
                                pam_echo: afficher une message text
                                pam_env: set/unset variables d'env
                                pam_exec: appeler une commande externe
                                pam_faildelay: changer le timeout
                                pam_filter: module de filtre
                                pam_ftp: pour les accès anonymes
                                pam_userdb: s'authentifier sur une base
                                pam_warn: loguer
                                pam_wheel: permet le root aux membres du groupe wheel
                                pam_xauth: faire suivre le xauth entre users


                            Pour avoir plus d'info sur les modules :

                                Voir les conf dans /etc/security
                                Et des infos dans /usr/share/pam

                        - les contrôles 

                            En fonction du résultat des modules, il permet de définir comment réagir:

                                required: 
                                    Si le module réussi, PAM continue d'évaluer les sous entrée du groupe managé.
                                    Si le module échou, PAM continue l'évaluation mais retourne une erreur.

                                requisite:
                                    Si réussi, PAM évalue les entrée suivantes.
                                    Sinon il arrête.

                                sufficient:
                                    En cas de réussite, retourne success.
                                    Sinon il continue l'évaluation.

                                optional:
                                    PAM ignore le résultat du module sauf si c'est le seul pour le groupe managé.

                                include:
                                    PAM inclus le contenu du fichier spécifié et execute ses entrées.

                                substack:
                                    Comme include mais continue d'évaluer même si le fichier spécifier renvoie une erreur.

                                Syntaxe custom:

                                    On peut spécifier ses propres contrôles manuelleent:

                                    [MES CONTROLS]

                                    Avec comme fonction:

                                            success, open_err, symbol_err, service_err, system_err, buf_err,
                                            perm_denied, auth_err, cred_insufficient, authinfo_unavail,
                                            user_unknown, maxtries, new_authtok_reqd, acct_expired, session_err,
                                            cred_unavail, cred_expired, cred_err, no_module_data, conv_err,
                                            authtok_err, authtok_recover_err, authtok_lock_busy,
                                            authtok_disable_aging, try_again, ignore, abort, authtok_expired,
                                            module_unknown, bad_item, conv_again, incomplete, and default.

                                    Avec comme valeurs possibles:

                                        ignore, bad, die, ok, done, reset, N

                                    Exemple:

                                        auth [success=X default=ignore] pam_unix.so nullok_secure
                                            #Si l'authentification réussi on saute X lignes et on execute la suivante.


                                        #Ecrire un message au moment de l'authentification 'su':

                                        > vim /etc/pam.d/su

                                            auth optional pam_echo.so file=/file/to/print

                                    Correspondance:

                                       required
                                           [success=ok new_authtok_reqd=ok ignore=ignore default=bad]

                                       requisite
                                           [success=ok new_authtok_reqd=ok ignore=ignore default=die]

                                       sufficient
                                           [success=done new_authtok_reqd=done default=ignore]

                                       optional
                                           [success=ok new_authtok_reqd=ok default=ignore]



                                Executer un script pendant l'authentification:
                                ``````````````````````````

                                    http://blog.stalkr.net/2010/11/login-notifications-pamexec-scripting.html

                                    Exemple avec les variables PAM:

                                    > vim /etc/pam.d/common-session

                                        session optional pam_exec.so /bin/bash /tmp/test.sh

                                    > vim /tmp/test.sh

                                        #!/bin/sh
                                        [ "$PAM_TYPE" = "open_session" ] || exit 0
                                        {
                                          echo "User: $PAM_USER"
                                          echo "Ruser: $PAM_RUSER"
                                          echo "Rhost: $PAM_RHOST"
                                          echo "Service: $PAM_SERVICE"
                                          echo "TTY: $PAM_TTY"
                                          echo "Date: `date`"
                                          echo "Server: `uname -a`"
                                        } | mail -s "`hostname -s` $PAM_SERVICE login: $PAM_USER" root


~~~~~~~~~~~~~~~~~~~~~~~~~~
Utilisateurs
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Sessions
        --------------------------
            __________________
            $su USER : changer d'utilisateur (nécessite les permissions root)
                su - USER : change d'utilisateur et charger son environnement.

            __________________
            $sudo : endosser les droits pendant l'execution d'une commande
                    sudo su - : devenir root et charger son environnement

                -i : garder son environnement ($PATH ...)

                    Rajouter un utilisateur sudo
                    ``````````````````````````

                        (vérifier le groupe sudoer dans /etc/sudoers)

                        > adduser MON_USER sudo
                        ou
                        > usermod -G sudo -a USER

                        (le nom de groupe peut aussi être admin)
                        Voir /etc/group

                    Aide
                    ``````````````````````````
                        http://www.sudo.ws/
                        man sudoers

                    Configuration
                    ``````````````````````````

                        Dans /etc/sudoers

                        On utilise visudo qui vérifie en plus l'intégrité du fichier.

                        > sudo visudo
                        ou pour forcer l'utilisation d'un éditeur spécifique:
                        > sudo VISUAL=/usr/bin/mousepad visudo #(par exemple)

                        On peut aussi changer l'éditeur via:

                        > update-alternatives --config editor

                                #NOTE:
                                # l'ordre a de l'importance, 
                                # les entrées en aval surpassent celles en amont.

                                Defaults        env_reset,env_keep=PATH

                                #Some alias
                                Cmnd_Alias NETWORK_CMDS = /sbin/ifconfig, /bin/netstat

                                #Users privileges
                                root ALL=(ALL) ALL

                                #Group privilege
                                %my_group   ALL=NOPASSWD:NOEXEC: NETWORK_CMDS
                                %sudo ALL=(ALL) ALL
                                %my_group_override

                    Redirection de flux
                    ``````````````````````````

                        Note sur la redirection de flux avec sudo:

                        Il faut executer la commande dans un shell:

                        sudo sh -c 'echo foo > /tmp/something'

                    Donner les droits sur un daemon via service:
                    ``````````````````````````

                        > adduser MonUser sudo
                        > visudo

                            MonUser ALL = NOPASSWD: /usr/sbin/service MonService *

            __________________
            $gksudo : idem que précedement avec une surcouche graphique.
                Cela permet d'afficher un prompt graphique, ça peut être plus 
                visible pour un utilisateur!

        --------------------------
        Configurations
        --------------------------
            __________________
            /etc/passwd: Fichier contennant la liste des utilisateurs system

                Syntaxe:
                    pseudo:password(chiffré = x le plus souvent):UID:GID:commentaire:repertoire_personnel:l'executable au login

                A savoir:

                    Root: UID et GID = 0
                    User pour démon et application (non lié à un login sur le système) UID et GID < 500
                    User sous Linus : UID et GID > 500

                    Pour le password:
                        x = pwd contenu dans shadow
                        * = interdit toute connexion
                        !! = pwd à définir
            __________________
            /etc/login.defs : 
                Contient la définition des variables de configuration pour la création des logins

            __________________
            $chfn : changement du nom de l'utilisateur et d'autre infos comme les commentaires.
                
            __________________
            $chsh : changer le shell de connexion


            __________________
            $gpasswd : permet d'administrer /etc/group et gshadow
                -a USER GROUP : ajouter l'utilisateur dans un groupe
                -d USER GROUP : supprimer l'utilisateur du groupe


            __________________
            /etc/group : ficher contenant la liste des groupes du système:

                syntaxe:
                    nom_groupe:password:GID:Membres du groups (pour qui le groupe est secondaire)
	

        --------------------------
        Informations
        --------------------------
            __________________
            $groups USER : affiche les groupes auxquels appartient l'user

            __________________
            $finger USER : affiche les informations sur un utilisateur

            __________________
            $whoami : affiche sur quel user on est logué

            __________________
            $id : affiche les ids utilisés (gid, uid ...)

        --------------------------
        Création
        --------------------------
            __________________
            $adduser : ajouter un utilisateur (mode interactif non scriptable)

                Ajouter un nouvel utilisateur:

                    > adduser USER

                Ajouter un groupe à un utilisateur rapidement:

                    > adduser USER GROUP

            __________________
            $useradd : idem mais sans mode interactif
                -g GROUPNAME -d DEFAULT_DIR USER

                exemple:

                    openssl passwd -crypt mypassw0rd
                    useradd -m -g GROUPNAME -d /home/USERNAME -s /bin/bash -p fiAS3mstReHq. USERNAME

            __________________
            $addgroup : ajouter un groupe (groupadd sinon)


        --------------------------
        Suppresion
        --------------------------
            __________________
            $deluser : supprime un compte (par le répertoire personnel associé)
                --remove-home user : supprime l'user et son home)

                Supprimer un groupe d'un utilisateur :

                    > deluser <USER> <GROUP_TO_DEL>

            __________________
            $userdel : idem mais non interactif
                -r USER

            __________________
            $delgroup : supprimer un groupe
            $groupdel GROUPNAME : idem

        --------------------------
        Modification
        --------------------------
            __________________
            $usermod : modifier un utilisateur

                -l : renomme l'utilisateur (pas le r épertoire personnel associé)
                -g : change de groupe
                -G : placer l'utilisateur dans plusieurs groupes
                -a : conserver les anciens groupes d'appartenance de l'utilisateur

                exemple:
                >	usermod -G GROUP1,GROUP2 -a USER

            __________________
            $passwd USER : changer le mot de passe

        --------------------------
        Mots de passe
        --------------------------
            __________________
            /etc/shadow : comprend les mot de passes des utilisateurs chiffrés.

                syntaxe:
                    pseudo:
                    password chiffré:
                    timestamp:
                    durée en jour de validité du pwd:
                    Le nombre de jour apres lequel le pwd doit être changé:
                    Le nombre de jour avant l'avertissement d'expiration du pwd:
                    Le nombre de jour avant la désactivation du compte:
                    timestamp de la désactivation du compte
            __________________
            /etc/gshadow : comprend les mot de passes des groupes chiffrés

                Syntaxe:
                    Nom_groupe:password_chiffré:Admin_du_groupe:Les membres du groupe (pour qui le groupe est secondaire)
            __________________
            $passwd USER : Définir / modifier le mot de passe

        --------------------------
        Droits
        --------------------------
            __________________
            $chown : changer le propriétaire d'un fichier
                    chown user:groupe : change le groupe propriétaire d'un fichier
                    -R : affecte récursivement les sous-dossiers
                    -h : changer les droits d'un lien symbolique.
                    -P : ne pas traverser les liens symboliques.

            __________________
            $chgrp : changer le groupe propriétaire d'un fichier

            __________________
            $chmod : modifier les droits d'accès (chmod "absolu ou verbeux" + "nombre + fichier)
                    -R : affecte récursivement les sous-dossiers...

                découpage des droits : u|g|o

                    r : read = 4		u = user
                    w : write = 2		g = group
                    x : execute = 1		o = other

                    chmod relatif :	 	+ ajouter droit
                                        - supprimer droit 
                                        = affecter droit

                    exemple : chmod g+w,o-w test.txt
                    ou	chmod 775 test.txt

                        
                sticky-bit:
                `````````````````

                    Valeur :

                        T : 1000

                    Il corresponde au caractère t ou à la valeur numérique 1000 ou encore T si les droits d'éxécution ne sont pas définis sur le fichier.

                    -Sur un fichier executable, il sert à garder le programme en mémoire vive (empechera l'écriture sur le SWAP par exemple)
                    Ceci apporte une notion de priorité dans un besoin d'éxécution ultèrieur.

                    -Sur un Répertoire, seul le propriétaire d'un fichier pourra supprimer ses fichiers.
                    Il est présent par défaut sur /tmp, ainsi chaque user peut écrire dans /tmp sans qu'une autre personne puisse supprimer son dossier.

                    Pour un /tmp il est courant de mettre un chmod 1777

                    
                Droits d'endossement
                `````````````````
                    http://www.linuxnix.com/2011/12/sgid-set-sgid-linuxunix.html
                    http://www.linuxnix.com/2011/12/suid-set-suid-linuxunix.html

                    But:

                        Endosser les droits d'un utilisateur ou d'un groupe lors de l'éxécution d'un fichier ou d'un dossier.

                        Sur un executable :

                            On ne donne pas les droits d'accès au fichier même mais on les donne à une commande.
                            Ainsi le kernel, au moment de l'execution de la commande endosse l'identité du propriétaire ou du groupe de la commande.
                            Donc l'accès au fichier se fait par le biais de la commande et non pas directement.

                        Sur un dossier :

                            Les fichiers et dossiers heriterons des droits du groupe

                        Déclinaisons :

                            SUID : droits utilisateur
                            SGID : droits du groupe

                    Effets et application :

                        SUID = 4000

                            > chmod u+s file1.txt
                            ou
                            > chmod 4750 file1.txt


                        SGID = 2000

                            > chmod g+s file1.txt
                            ou
                            > chmod 2750 file1.txt

                    Représentation :

                            s : sur un fichier executable.
                            S : sur un fichier non executable.

                Récapitulatif sur les droits:
                `````````````````

                    1 (x) sur un dossier permet de l'ouvrir. (exemple avec cd)
                    2 (w) sur un dossier permet de contrôler lui et son contenu. (exemple avec rm et mv)
                    4 (r) sur un dossier permet de lister son contenu. (exemple avec ls)

                    1 (x) sur un fichier permet de l'éxécuter. (exemple avec bash)
                    2 (w) sur un fichier permet de le modifier. (exemple avec nano)
                    4 (r) sur un fichier permet de le consulter. (exemple avec cat)

                __________________
                $umask : affiche le masque de l'utilisateur actif
                        
                    Le masque de protection umask définis les permissions non accordés aux fichiers et répertoires lors de leur création.

                    Il se soustrait aux permissionx max 777 pour un folfer, 666 pour un fichier.

                    $umask -S : forme symbolique

        --------------------------
        RUN AS
        --------------------------

                Lancer une commande en tant qu'un autre utilisateur:

                __________________
                $runuser : permet de lancer une commande en tant qu'un autre user (depuis root uniquement)

                    -l USER : changer d'utilsiateur
                    -c 'COMMAND' : executer une commande


                __________________
                $su : idem et possibilité de se loguer.

                    -|-l : chargement de l'environnement utilisateur (si on utilise la forme - , il doit être la dernière option)

                    -c 'COMMAND' : lancer une commande

                    -s SHELL : changer de shell par défaut (peut être utile dans le cas où il est à false dans /etc/passwd)

                    exemple:
                            su -l nagios -c 'ls /tmp' -s /bin/bash

                __________________
                $sudo : idem mais avec l'utilisation de son password (pour andosser les droits root)


~~~~~~~~~~~~~~~~~~~~~~~~~~
Processus
~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~
Services
~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~
Librairies
~~~~~~~~~~~~~~~~~~~~~~~~~~
                __________________
                $ldd : Afficher les dépendances de lib.

                    Exemple :

                        > ldd -r -v /usr/bin/htop

~~~~~~~~~~~~~~~~~~~~~~~~~~
Packages
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Un package est un fichier qui contient le produit à installer et des règles comme:
                -la gestion des dépendances : le produit ne sera installé que si les produits qui lui sont nécessaires sont déja présent
                
                -Pré-installation: des actions sont à prévoir avant de pouvoir installer le produit (changer des droits, créer des répertoires, etc ...)
                -Post-installation : des actions sont à prévoir après l'installation du produit (paramétrage d'un fichier de configuration, compilation annexe, etc...). 
                
                
        Attention : RPM et DPKG contrôle les dépendances des packages pour autoriser ou non leur installation, mais ne les gèrent pas.
        Il faut si on n'utilise que ces commandes, au préalable installer les dépendances ou indiquer sur la même ligne le path de tout les packages.
        De même, pour les fichiers de conf.

	--------------------------------------
	DEBIAN
	--------------------------------------
		__________________
		$dpkg : gestionnaire de paquets sans gestion des dépendances.

			$dpkg --get-selections : liste les paquets installés
			$dpkg -l <recherche> : liste les paquets correspondants à la recherche
			$dpkg -i <paquet.deb> : installer un paquet.deb
				$apt-get -f install : installe les dépendances (à faire apres)
			$dpkg -r <paquet> : supprimer un paquet
			$dpkg -P <paquet> : supprimer un paquet et ses fichiers de conf
			$dpkg --force-all --purge <paquet> : Suppression totale du paquet
                        --listfiles PACKAGE : liste les fichier installés concernant le package
                        --search : Rechercher un paquet installé.

                        DPKG Installation package.deb
                        ``````````````````````````
                                dpkg -I <package.deb> : donne les infos sur le paquet.
                                dpkg -i <package.deb>
                                dpkg -R <folder de packages> : permet d'installer tout les packages du folder (utiles quand il faut installer en plus des dépendances)

                                Pour forcer l'installation d'un package 32 bit sur une version 64 bit, il faudra utiliser l'option suivante:

                                exemple:

                                    > dpkg -i --force-architecture aksusbd_7.32-1_i386.deb

                                Au préalable il faudra charger la lib de compatibilité 32 bit:

                                exemple sur une Debia 8.1 :

                                    > apt-get install lib32z1

                        DPKG réinstaller un package
                        ``````````````````````````

                            > dpkg --purge mypackage
                            > dpkg -i mypackage

                        DPKG voir la liste des packages installés:
                        ``````````````````````````
                                pas d'option -F comme RPM pour DPKG
                                dpkg -l <package> | grep ^ii : les paquets installé commencent par li

                        DPKG : supression d'un paquet:
                        ``````````````````````````
                                dpkg -r <package>
                                dpkg -P <package> : supprime tout même les fichiers de confs.
                                dpkg --force-all --purge <package> : force la supression totale du paquet

                        DPKG Base de données - requêtes
                        ``````````````````````````

                                dpkg -l : lister les paquets
                                dpkg -l | grep ^ii : liste les paquets installés

                                il se peut que la console soit trop petite pour tout afficher:
                                utiliser alors la commande ainsi:

                                COLUMNS=160 dpkg -l | awk '{print $2}'
                                ou
                                dpkg --get-selections [| grep <package>]

                        DPKG Trouver un paquet contenant un fichier
                        ``````````````````````````
                                dpkg -S <path> : exemple : /usr/bin/basename

                        DPKG Lister le contenu d'un paquet
                        ``````````````````````````
                                dpkg -L <package>

		__________________
		$apt : gestionnaire de paquets par défaut d'une debian (surcouche à dpkg gérant les dépendances.)

			$apt-get update : mettre à jour le cache, la liste des paquets.
			$apt-cache search <paquet> : chercher un paquet
			$apt-cache show <paquet> : afficher les infos conernant un paquet.
                        $apt-cache showpkg <paquet> : voir les différentes versions disponibles.

            $apt-cache policy <package> : afficher certaines info dont le repo sue lequel se trouve le paquet.
            $apt-cache depends <package> : voir la liste des dépendance d'un paquet.

			$apt-get install <paquet> : Installer un paquet

                            (Permet aussi de mettre à jour un paquet)

                            #Choisir sa version:
                            > apt-get install monPaquet=maVersion

			$apt-get upgrade : mettre à jour ses paquets

			$apt-get remove <paquet> : supprimer un paquet
			$apt-get autoremove <paquet> : supprime un paquet et ses dépendances.

			$add-apt-repository ppa:<DEPOT> : ajouter un dêpot
				(fonctionne aussi avec $apt-add-repository)
			$apt-add-repository --remove ppa:<DEPOT> : supprimer un dêpot


			Voir tips pour récupérer l'adresse d'un paquet, sinon pour juste le dl:
			$apt-get download <paquet>

			A savoir qu'il est aussi possible d'afficher la source avec l'option --print-uris
			$apt-get install --print-uris <paquet>
			
			repo: /etc/apt/sources.list
			
				Syntaxe du fichier:
				
				exemple:
					1		2								3			4
					deb		http://security.debian.org/		squeeze 	main
				
				1er bloc
					deb : représente les paquets d'installation.
					deb-src : représente les sources (dans le cas ou l'on veut compiler)
				2eme bloc:
					http... : url vers le repo
				3eme bloc
					squeeze : à remplacer par la version de l'hôte (lsb_release -a)
				4eme bloc
					nom de la section:
						main: softs libres maintenus par l'équipe officiel
						universe: softs libres maintenues par les utilisateurs
						restricted: softs non-libres maintenus par l'équipe officiel
						multiverse: softs non-libres maintenus par les utilisateurs

                        Ajouter un clé publique d'un repo:
                                > wget http://my.key
                                > apt-key add - < my.key


                        Note concernant les repos :

                                Il est possible de segmenter les repos dans des fichiers dans sources.list.d
                                Ces fichiers doivent finir par ".list"

                        APT les dépôts:
                        ``````````````````````````
                                fichier : /etc/apt/sources.list

                                genbasedir : créer un dépôt

                                Syntaxe:

                                        deb url distrib composant1 ...

                                                url : path de la racine du repo
                                                distrib : nom de la distrib
                                                composants : nom des repos (sous dossiers)
                                         
                                        apt se charge tout seul de reconstituer le path complet grace à ces infos.
                                        Dans ces arborescences on trouve des fichiers de type Release, Packages.gz, Packages.bz2.
                                        Ils contiennents les informations ncessaires pour installer le package (le vrai path, les dépendances ...)

                        APT installation de packages:
                        ``````````````````````````

                                apt-get install <package>
                                apt-get install -s : simuler une installation pour voir ce que apt ferais en cas d'install
                                apt-get install -f : essaye de fixer les problèmes de dépendances (ajout de packages)

                        APT: mise à jour / updates
                        ``````````````````````````

                                mettre à jour le cache des sources:

                                        > apt-get update
                
                                puis mettre à jour les packages du systeme:

                                        > apt-get upgrade

                                Mettre à jour la distribtion:
                
                                        > apt-get dist-upgrade

                                Mettre à jour un paquet uniquement

                                    sudo apt-get --only-upgrade install <packagename>
	

                        APT rechercher un paquet:
                        ``````````````````````````
                            > apt-cache search <package>

                        Afficher les meta packages :
                        ``````````````````````````
                            > apt-cache search . | grep -i "metapackage\|meta-package"
		__________________
		$aptitude : idem mais en plus récent et des dépendances un peu mieux gérées.

		__________________
        $debconf : programme de configuration pour les paquets debian

            necessite le package debconf-utils
		__________________
        $debconf-get-selections : lister la base debconf

            Permet de construire un fichier de réponse debconf (debconf.ans)

            exemple:
                > debconf-get-selection |grep ldap > debconf_ldap.ans
		__________________
        $debconf-set-selections : importer des infos dans la base debconf

            exemple:
                > cat debconf_ldap.ans |debconf-set-selection
                > apt-get install ...
		
	--------------------------------------
	REDHAT
	--------------------------------------

		__________________
		$rpm:

                        Conf
                        ``````````````````````````
                                base de données rpm dans /var/lib/rpm
                                        -> regroupe toutes les informations concernant les softs installés, leurs versions, leurs fichiers et droit, et leurs dépendances. 
                                        (Ne pas la modifier à la main, il faut utiliser l'outil rpm).

                                nomenclature fichiers rpm:
                                        -> nom-version-edition.architecture.rpm
                        Options
                        ``````````````````````````
                                --force : forcer l'installation même si il y a un conflit.
                                --nodeps : force l'installation même si il y a un problème de dépendances.

                        Installation
                        ``````````````````````````
                                rpm -i <package.rpm> : installe le paquet
                                        -v : affiche le nom du paquet en cours d'installation
                                        -h : affiche la progression de l'installation

                        Mise à jour
                        ``````````````````````````
                                supprime les anciens paquets, garde les fichiers de conf avec l'extension .rpmsave

                                rpm -U <new_package.rpm>
                                        -F : même fonction mais n'installe pas le paquet si il n'est pas déja présent.

                                RPM maj du noyau:

                                        -Installer le nouveau noyau avec rpm -i
                                        -Redémarrer sur le nouveau noyau et tester
                                        -Editer /boot/grub/grub.conf et modifier "default" pour démarrer sur le new noyau

                                Pour les systèmes RHEL, (étant un système payant);
                                         l'accès aux maj se fait à l'aide d'up2date' avec une licence et une inscription à RHN.

                        Suppression
                        ``````````````````````````
                                rpm -e <nom_package> : supprime le paquet, il faut indiquer son nom.

                        Requêtes vers la base rpm (-q)
                        ``````````````````````````
                                rpm -qa : liste de tous les packages installés
                                rpm -qi <package>: Résumé du package
                                rpm -ql : liste des fichiers installés par un rpm
                                rpm -qf <file> : trouve le package du fichier renseigné
                                rpm -qp <package.rpm> : rechercher dans le package donné
                                rpm -qR <package> : voir les dépendances

                                rpm -qpil MY_PACKAGE.RPM : pour avoir un max d'infos !
                                
                                exemple:
                                        rpm -qip <package.rpm> : donnera toutes les infos sur ce paquet (dont le dernier commit)

                                --requires : dépendances du package
                                --provides : ce que fournit le package
                                --scripts : scripts executés à l'installation et la suppression.
                                --changelog : historique du package
	
                        RPM vérification des packages
                        ``````````````````````````

                                rpm -V <File> : Affiche les informations de modification du fichier
                                        "." : étape de vérification ok
                                        5 : la somme MD5 ne correspond plus
                                        T : la date de modif n'est plus la même
                                        U : le propriétaire a été modifié
                                        G : le groupe propriétaire a été modifié
                                        L : le lien symbolique a été modifié
                                        M : les permissions ou le type du fichier ont été modifiés
                                        D : le périphérique a été modifié
                        
                                        c : indique que c'est un fichier de conf
                        
                                Les fichiers RPM sont souvent signés par l'éditeur, pour vérifier l'intégrité d'un package, il faut utiliser une clé publique GPG:
                                gpg --import <RMP_GPG_KEY>
                                rmp --import <RPM_GPG_KEY>
                                rpm --checksig <package.rpm>

                        RPM Gestion des dépendances:
                        ``````````````````````````
                                rpm ne prend pas en compte la gestion des dépendances.
                                des outils comme yast, apt ou yum s'en chargerons.
                                Anciennement (<RHEL v4) on pouvait utiliser rpm -ivh --aid <package.rpm>
                                (necessite que toutes les dépendances soient au même endroit)


		__________________
		$yum : gestionnaire de paquet avec gestion des dépendances


                config des repos:
                ``````````````````````````

                    Dans /etc/yum.repo.d

                    Syntaxe:

                        name : nom du repo, détaillé
                        baseur1 : URL du repo (local : file:// ou distante : http:// ou ftp://. l'url doit pointer sur un répertoires contenant les info des repo dans le folder "repodata")
                        gpgcheck : demande une vérification de la signature GPG du repo
                        enable : repo actif ou non
                        gpgkey : path de la public key GPG

                        Des valeurs comme gpgcheck peuvent être par défaut pour tout les repo dû au fichier de conf /etc/yum.conf -> section [main]

                    Exemple:

                        [nom_repo]
                        name=RHEL 5.7 repo
                        baseurl=http://@IP/iso-RHEL57
                        enabled=1
                        gpgcheck=0

                        YUM rafraichir le cache
                        ``````````````````````````
                                yum met à jour son cache si le délai d'expiration est dépassé à chaque appel de la commande. Voir la ligne "metadata_expire=" dans le fichier de conf

                                $yum makecache : force la maj du cache
                                $yum clean all : nettoie le cache pour qu'il soir reconstruit à la prochaine commande yum
	
                        YUM Lister les packages installés
                        ``````````````````````````
                                yum list <options> :
                                        all : liste tout (par défaut)
                                        available : package disponibles pour l'installation
                                        updates : les packages pouvant être mis à jour.
                                        installed : les packages maj
                                        obsoletes : les packages systemes dépassés par des nouvelles versions.
                                        recent : les derniers packages ajoutés dans les repos.
                        
                                exemple : lister les noyaux disponibles:
                        
                                        yum list available kernel\* 

                        YUM informations sur un package:
                        ``````````````````````````

                            > yum info <package> : donne les infos sur ce paquet, commande ...

                            On peu appliquer les mêmes options que pour yum list:

                            exemple:

                                >	yum info installed <package>

                        YUM historique / logs
                        ``````````````````````````

                            Pour avoir un full historique de ce qui a été appliqué lors de l'installation d'un paquet :

                                > yum history info <monPackage>
                                > yum history summary <monPackage>


                        YUM installation des packages
                        ``````````````````````````
                                yum install <package>

                                        --nogpgcheck : ne pas vérfier la signature
	
                        YUM UPDATE
                        ``````````````````````````
                                > yum check-update :vérifier la présence de maj.
                                > yum update [<package>] : maj d'un package ou de tous si rien est précisé
                                > yum upgrade [<package>] : maj de tout le système et supprime les paquets obsolètes.

                                --exclude : permet d'exclure des packages

                                exemple:

                                    > yum list -exclude=kernel\* update
                                     exclude= php* kernel* ...

                                Downgrade un paquet :

                                    > yum downgrade <MyPackage>
			
                        YUM rechercher un package
                        ``````````````````````````
                                yum search <package>

                                ou 

                                yum provides <myFileName/pkg_name>
                                yum whatprovides <pkg_name>

                                Exemple, trouver le paquet qui donne scp :

                                    > yum provides */scp
                                    > yum install openssh-clients

                        YUM supprimer un package 
                        ``````````````````````````

                            Supprimer un package mais garder ses fichiers de configuration :

                                > yum remove <package>
                                > yum erase <pckage>

                            Supprimer l'intégralité des fichiers d'un paquet :

                                > yum purge <package>

                        YUM lister les dépendances d'un paquet:
                        ``````````````````````````
                                yum deplist <package>
	
                        YUM installer un paquet non signé:
                        ``````````````````````````
                                > vim /etc/yum.conf
                                        gpgcheck=0

                                        ou passer par l'option --nogpgcheck

	------------------------------------
	Convertion
	------------------------------------
		__________________
        $alien : convertir des paquet vers un autre manager de paquet.

                alien : permet de convertir des paquets rpm et dpkg

                alien -d <package.rpm> : converti en .deb
                        -> n'inclut pas les scripts de pré et post installation. Péciser le paramètre --scripts :
                alien --scripts -d <package.rpm>

                -k : garder la version original (au lieu d'incrémenter).


	------------------------------------
	Compiler les sources
	------------------------------------

		Tout logiciel libre est fourni avec ses sources, il est donc possible de le recompiler soit même.
		Une archive source est souvent au format compressé, gzip, bz2... .

		il contient le code source (.c, .h, .opp ...)
		parfois un fichier makefile qui permet d'automatiser la compilation. 
		un fichier .configure permettant de generer un fichier makefile personalisé.

		Note: 	Les softs compilés ne sont pas gérés par les gestionnaies de paquets. 
			Pour les désinstalle, il faudra donc le faire manuellement en rm le path d'installation par exemple.

		__________________
        $make: Gérer les sources
	
                Pré-requis et dépendances:
                ``````````````````````````
                        -vérifier la précense de make
                        -précense des compilateurs (au moins gcc)
                        -précense des dépendances: bibliothèques, interpréteurs ... 

                        ./configure : fournis les dépendances manquantes et leur version : pour qu'on puisse installer les packages manquants.

                Installation:	
                ``````````````````````````

                        exemple d'installation:

                                -Décompresser l'archive : tar xvjf <archive.tar.bz2>
                                -Se déplacer dans le dossier décompréssé
                                - ./configure --help
                                        l'option --prefix : définit l'emplacement de l'installation une fois le produit compilé. (par défaut dans /usr/local/)
                                -./configure || Ou cmake
                                        Si une bibliothèque est manquante:
                                                -> installer depuis les sources ou le gestionnaire.
                                                -> ou ne pas l'installer mais peut générer des problèmes de police par exemple...

                                -relancer ensuite la commande ./configure
                                 -> le fichier makefile est créer et contient les règles, les chemins et les options de compilation.
                                 
                                 -make 			#se base sur le fichier makefile (dumpé par configure) pour compiler et générer les binaires. 
                                                                Il va ensuite dumper un fichier 'install' qui servira à mettre ces nouveaux binaires au bon endroit.
                                 -make install          #pour agencer correctement les nouveaux binaires fraichement crées.

                                 -Optionnelement : make clean   #Pour supprimer les fichiers inutils (après avoir compilé et placé les binaires)

                Nettoyage des sources après compilation:
                ``````````````````````````

                        > make clean
                Désinstallation
                ``````````````````````````

                        > make uninstall 

                Bases de Makefile:
                ``````````````````````````

                        Un fichier makefile est utilisé par make pour éxecuter un ensemble d'actions comme la compilation.

                        compiler "à la main":
                                gcc -o <file.o> -c <file.c>
                
                        Le makefile est composé des règles qui ont la structure suivante:

                                Cible : dépendances
                                commandes 


                        exemple:$ cat Makefile
                                bonjour: bonjour.o main.o
                                        gcc -o bonjour bonjour.o main.o
                                bonjour.o: bonjour.c
                                        gcc -o bonjour.o -c bonjour.c
                                main.o: main.c bonjour.h
                                        gcc -o main.o -c main.c
                

                                premiere règle: pour executer la règle bonjour, il faut disposer des fichiers bonjour.o et main.o. Si on les a, il faut exécuter la commande gcc -o bonjour bonjour.o main.o
                
                                La commande make determine quelles sont les règles applicables, l'ordre et les appliques dans l'ordre des dépendances.

                Le makefile intermédiaire
                ``````````````````````````

                        (permet par rapport au makefile précedent, de compiler plusieurs binaires, nettoyer les fichiers temporaires(.o) apres la compil, et permet de forcer la recompil du projet).

                        Pour ajouter ces fonctionnalités, on ajoute des règles:

                        quelques règles:
                                all : génère n règles;
                                clean : nettoie les .o ;
                                mrproper : apelle clean et supprime les binaires
                        
                        exemple:$ cat Makefile
                                all : bonjour

                                bonjour: bonjour.o main.o
                                        gcc -o bonjour bonjour.o main.o
                                bonjour.o: bonjour.c
                                        gcc -o bonjour.o -c bonjour.c
                                main.o: main.c bonjour.h
                                        gcc -o main.o -c main.c
                
                                clean:
                                        rm -rf *.o

                                mrproper: clean
                                        rm -rf bonjour


                        on peut ensuite executer: 
                                make clean
                                make mrproper
                                make all
                
                Makefile et variables utilisateur:
                ``````````````````````````

                        On peut définir des variables internes prédéfinies:
                
                        exemple:$ cat Makefile
                                CC=gcc
                                CFLAGS=-W -Wall -ansi -pedantic
                                LDFLAGS=
                                EXEC=bonjour

                                all: $(EXEC)

                                bonjour: bonjour.o main.o
                                        gcc -o bonjour bonjour.o main.o $(LDFLAGS)
                                bonjour.o: bonjour.c
                                        gcc -o bonjour.o -c bonjour.c $(CFLAGS)
                                main.o: main.c bonjour.h
                                        gcc -o main.o -c main.c $(CFLAGS)
                                clean:
                                        rm -rf *.o
                                mrproper: clean
                                        rm -rf $(EXEC)

                Makefile et variables internes:
                ``````````````````````````

                        $@: nom de la cible
                        $< : nom de la premiere dépendance
                        $^ : liste des dépendances
                        $? : dépendances plus récentes que la cible.
                        $* : nom du fichier sans le suffixe


                        exemple:$ cat Makefile
                                CC=gcc
                                CFLAGS=-W -Wall -ansi -pedantic
                                LDFLAGS=
                                EXEC=bonjour

                                all: $(EXEC)

                                bonjour: bonjour.o main.o
                                        gcc -o $@ $^ $(LDFLAGS)
                                bonjour.o: bonjour.c
                                        gcc -o $@ -c $< $(CFLAGS)
                                main.o: main.c bonjour.h
                                        gcc -o $@ -c $< $(CFLAGS)
                                clean:
                                        rm -rf *.o
                                mrproper: clean
                                        rm -rf $(EXEC)

                Règles d'inférence:
                ``````````````````````````

                        Il est possible d'utiliser des raccourcis qui permettent de générer des cibles en fonctions du nom de fichier C et objet : %.o %.c ...


                        exemple:$ cat Makefile
                                CC=gcc
                                CFLAGS=-W -Wall -ansi -pedantic
                                LDFLAGS=
                                EXEC=bonjour

                                all: $(EXEC)

                                bonjour: bonjour.o main.o
                                        gcc -o $@ $^ $(LDFLAGS)
                                %.o: %.c
                                        gcc -o $@ -c $< $(CFLAGS)
                                main.o: bonjour.h

                                clean:
                                        rm -rf *.o
                                mrproper: clean
                                        rm -rf $(EXEC)

~~~~~~~~~~~~~~~~~~~~~~~~~~
Kernel
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Modules
        --------------------------
            __________________
            $lsmod : permet de voir les modules actifs du noyau

            __________________
            $modprobe : permet d'ajouter et de supprimer les modules actifs du noyau

            __________________
            $insmod : permet d'ajouter un module au noyau

            __________________
            $rmmod : supprimer un module du noyau

        --------------------------
        Drivers
        --------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~
Périphériques
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Gestion
        --------------------------
        --------------------------
        D'entrée, clavier/souris
        --------------------------
        --------------------------
        Imprimante
        --------------------------
        --------------------------
        Audio
        --------------------------


        --------------------------
        Vidéo
        --------------------------
        --------------------------
        Média externes
        --------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~
Mémoire
~~~~~~~~~~~~~~~~~~~~~~~~~~

        > cat /proc/meminfo

        --------------------------
        RAM
        --------------------------

            $demidecode -t memory
            $lshw -C memory
            $free -h

        --------------------------
        SWAP
        --------------------------

        --------------------------
        Disque Dur
        --------------------------
                __________________________
                Partitioner
                __________________________
                Formater
                __________________________
                Monter
                __________________
                $du : taille occupée par les dossiers
                        -h : taille en Ko...
                        -a : affiche la taille des fichiers cachés.
                        -s : avoir juste le grand total

~~~~~~~~~~~~~~~~~~~~~~~~~~
Logs
~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~
Système d'initialisation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        __________________________
        Phase de démarrage du système

                Link: http://come-david.developpez.com/tutoriels/boot-linux/
                Voir memo_boot

*****************************************************************************
                            RESTRUCTURATION
****************************************************************************

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CONFIGURATION
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	--------------------------------------
	NANO
	--------------------------------------
		__________________
		Files

		   ~/.nanorc : fichier de configuratin de nano
		   /etc/nanorc : fichier global de configuratino de nano (pour tout les user)

		__________________
		Options

			   set mouse : active la souris
			   set autoindent : active l'indentation automatique
			   set smarthome : active le retour intelligent au début de ligne


	--------------------------------------
	Changer le hostname
	--------------------------------------

		__________________
		$hostname : Sans argument : affiche le hostname
			> hostname HOSTNAME : change le hostname (non permanent)

			Note: il faut penser à réediter son fichier host pour changer et changer les anciennes valeurs par le nouveau hostname.

			De manière permanente:

			Debian:
				> vim /etc/hostname			#changez votre hostname
				> /etc/init.d/hostname.sh start 	#appliquer le changement 


			Redhat:
				> vim /etc/sysconfig/network
					#HOSTNAME="bidule"
				> /etc/rc.d/rc.sysinit			#appliquer le changement


			Kernel:
				> sysctl kernel.hostname		#affiche le hostname
				> sysctl kernel.hostname=bidule		#changer le hostname


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
MANIPULATION DES BINAIRES / EXECUTABLES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	--------------------------------------
	LES COMMANDES PAR DEFAUTS
	--------------------------------------
		__________________
		$update-alternatives : permet de modifer les liens symboliques de certaines commandes contenues dans le PATH  
			Les liens pointent sur la commande par défaut contenue elle même dans un binaire.

			Exemple avec editor:

			Editor permet d'ouvrir l'éditeur par défaut.
			Celui-ci est un lien symbolique présent dans "/usr/bin/editor"
			Pointant sur "/etc/alternatives/editor*"

			Pour visualiser les différentes possibilitées:

				update-alternatives --list editor

			Pour le modifier:

				update-alternatives --set editor /usr/bin/vim.basic


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FILTRES, TRIE, SUBSTITUTION DE DONNEES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	__________________
	$grep : filtrer les données.

		grep [Options] modèle [FIles]
		
		-i : ne pas tenir compte de la casse
		-c : retourne uniquement le nombre de lignes trouvées
		-l : dans le cas de fichiers multiples, indique dans quel fichier la ligne a été trouvée.
		-n : afficher les N° de lignes
		-v : inverser la recherche
		-r : rechercher dans les sous-dossiers
		-E : utiliser les expressions régulières
		     ou utiliser $egrep
		-F : Grep rapide simpliste dans le cas de critères de recherche simple ou utiliser $fgrep
                -H : afficher les nom de fichiers matchant (par défaut)
                -l : afficher uniquement les noms de fichiers matchant
                -L : affiche uniquement les noms de fichiers ne matchant pas 
        -A X : affiche X lignes après chaque match
        -B X : idem mais avant
        -C X : idem mais avant et après

        /!\ Pour éviter d'avoir le processus grep dans lorsqu'on grep sur la sortie de l'outil ps:

            Il faut placer des crochets sur la première lettre de notre recherche par exemple:

                > ps faux |grep "[u]ser"

        Note :

            Pour filtrer en fonction du résultat d'une commande, l'utilisation de perl peut être très pratique :

            Exemple :

                > perl -ne 'print if grep {$_>1000} /(\d{3,})/g' $mylog
		
	__________________
	$egrep : même fonction que grep mais accepte les regex en entrée.

		egrep 'REGEX'

		il est possible de mettre plusieurs pattern avec un OU:

		egrep "patter1|patter2"

		exemple:

			egrep -v "^$|^#" $file

			--> élimiera toutes les lignes vides et commençant par # du fichier

		Caractère	Signification

		.		Caractère quelconque
		^		Début de ligne
		$		Fin de ligne
		
		--> Voir le memo sur les regex pour plus de details!

	__________________
	$fgrep : idem que grep mais sur des critères simples (plus rapide que grep)
		
		
	__________________
	$sed : éditeur de flux (filtre et substitut le texte), il est très complet !

[https://github.com/learnbyexample/Command-line-text-processing](https://github.com/learnbyexample/Command-line-text-processing)

        -n : fait les traitements sans afficher
        's/BRE/replace/[gp]' : substituer
        -r : activer les expressions étendues
        -e : délimite un script

		sed -re '<cmd>' FILE

        Il n'est pas obligatoire, dans ce cas, sed interprete le premier élement qui n'est pas une option comme le script à éxécuter.
		
		Souvent utiliser pour substituer:

			s/ancien/nouveau/[gp] : (g pour global)
                                p : affiche la dernière séquence

	        Réutiliser une partie du match dans la séquence de remplacement:

                & : correspond au dernier match complet. (la chaine entière)
                    exemple: sed -n 's/root/&p/p' <<< /etc/passwd
                \n :  avec n le numéro de la séquence de match (entre parenthèse)

		
		Exemple de cmd :

			> sed -e 's/NOM/Paul/g' FILE_CV
			
				Remplacera "NOM" par Paul dans le fichier FILE_CV
			
			> sed -re '/^ *$/d' FILE
			
				Supprimera toute les lignes vides ou ne contenant que des espaces.

		On peut travailler sur un champs à l'aide d'une valeur numérique:
		
			> echo polo | sed -re "s/\(polo\)/salut \1 biz/"
			
				donne: salut polo biz

            Afficher des champs particulier:
            ``````````````
                > sed -n Xp fichier	#Affichera la Xième ligne
                > sed -n X,Yp fichier	#Affichera de la Xième à la Yième ligne
                > sed -n '$ p' fichier	#Affichera la dernière ligne du fichier

            Supprimer des champs particulier:
            ``````````````
                > sed Xd		#Supprimera la Xième ligne
                > sed $d		#Supprimera la dernière ligne

            Pour subsituer dans un fichier et le réecrire:
            ``````````````

                -i[PREFIX] '<cmd>'

                Si vous mettez un préfix, le fichier source sera backupé avec le nom préfixé.
                Dans tout les cas le fichier original est réecrit !

                exempe:

                        sed -i.back -e 's/yum/apt/g' mon_fichier

                                il mettre le contenu d'origine dans mon_fichier.back
                                mon_fichier sera réedité avec les nouvelles valeurs.

            Supprimer les débuts et fins de lignes
            ``````````````
                > sed -re 's/^\ *//;s/\ *$//'

            Supprimer la dernière ligne d'un fichier :
            ``````````````
                > sed -i '$ d' monfichier.txt

            todo: faire un memo complet pour sed !

	__________________
	$sort FILE: trier un fichier (par défaut: ordre croissant)
		séparateur = tabulation ou au moins un espace par défaut

		-k N : trie la Nième colonne
		  -k N.M : trie à partir du Mième caractère du Nième champs
		-o FILE: écrire le résultat dans un fichier
		-b : ignore les espaces en début de champs
		-d : trie dictionnaire (lettres, chiffres et espaces)
		-f : ignorer la casse
		-r : trie décroissant
		-R : trie aléatoire
		-n : trie numérique
		-tDELIMITEUR : indiquer un nouveau délimiteur

	__________________
	$wc : compter le nombre de lignes
		 nombre de lignes / nombre mots / nombre d'octets
		-l : compter le nombre de lignes
		-w : compter le nombres de mots
		-c : compter le nombres d'octets
		-m : compter le nombres de caractères

	__________________
	$uniq : supprimer les doublons (d'un fichier déjà trié)
		-c : compter le nombre d'occurences
		-d : afficher uniquement les lignes présentes en double.
		
			exemple:
				cut -d: -f4 FILE.txt | sort -n | uniq


	__________________
	$cut : selectionne des colonnes, des champs dans un fichier

		colonne = position d'un caractère dans la ligne.
		
		-c N: selectionner le Nième caractère:
			N- : du Nième caractère à la fin d'une ligne
			N-M : Selectionne du Nième au Mième
			-N : Selectionne du 1 au Nième caractère
			
			On peut cumuler les options avec des ","
		
			exemple : cut -c -3,5,8-10 text.txt
				    
		-d : indiquer un délimiteur
		-f N: idem que pour -c mais pour le Nième champs
			
			
	__________________
	$tr "SET1" ["SET2"]: transforme ou supprime des caractères (substitue):
		N'accepte que les données provenant du canal d'entrée standard

		-d : supprime tout les caractères du SET1
		-s : remplacera toute les occurence du SET1 (même si elles se repetent) par un seul caractère du SET2
		
		exemples d'utilisations:
		
			> tr "[a-z]" "[A-Z]" << EOF
			> converti le texte 
			> en majuscule
			> EOF
			
			> cat FILE | tr "old" "new" 
				--> remplacera toute les occurences old par new
			
			> cat FILE | tr -d " " 
				--> supprimera tout les espaces

			> cat FILE | tr -s " " ":"
				--> remplacera tout les espaces par un :

	__________________
	$expand : convertit les tabulations par des espaces
	$unexpand : convertit les espaces en tabulation
	
	__________________
	$basename : garde uniquement le nom de fichier sans le path complet.
	$dirname  : inversement, ne garde que le path
	$readlink : affiche la valeur d'un lien symbolique ou d'un nom de fichier canonique
	
	--------------------------------------
	base 64
	--------------------------------------

		$base64 : décoder/encoder en base64
			-d : décoder
			exemple:
				> echo "paul" | base64  	--> cGF1bAo=
				> echo "cGF1bAo=" | base64 -d  	--> paul

	--------------------------------------
	Jointures de deux fichier - comparaisons
	--------------------------------------
		__________________
		$join : jointure sur deux fichiers en fonctions des colonnes
			Nécessite de triers les 2 fichiers au préalables.
			
			Séparateur par défaut : espaces, tabs

			Cette commande permet entre autre de voir les correspondances entre 2 fichiers en fonction des colonnes données en arguments.

			-1 N : Indique la Nième colonne du premier fichier 
			-2 N : Indique la Nième colonne du deuxieme fichier
			-t DELIMITEUR : changer le délimiteur

			exemple:
				> join -1 2 -2 2 city1 city2

				--> affichera chaque lignes des 2 fichier pour lequel la valeur de la colonne 2 est identique.

		__________________
		$paste : Regroupe N fichiers en 1, concatène les lignes de chaque fichier en une seule ligne.
			Séparateur par défaut : tabulation
			
			-d DELIMITEUR : changer le délimiteur

			exemple:
				> paste -d; file1 file2 file3

				--> affichera sur une ligne les premieres lignes de chacun des fichier séparé par un ";", idem pour la seconde etc ...




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FLUX DE REDIRECTION && CANAUX
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	--------------------------------------
	Link
	--------------------------------------

                http://www.catonmat.net/download/bash-redirections-cheat-sheet.pdf
                http://www.catonmat.net/blog/bash-one-liners-explained-part-three/

	--------------------------------------
	rediriger les canaux
	--------------------------------------

                <commande> <redirection> <fichier>

                IL faut savoir que la redirection se lit de droite à gauche.
                (Le fichier se créer avant l'éxécution de la commande).

                C'est pourquoi il faut respecter un ordre précis lorsque on redirige le canal de sortie et d'erreur en même temps.
                Il faut dabord rediriger la canal d'erreur puis le canal de sortie.
                        Voir les exemples plus bas.

                Il existe 3 canaux standard:
                        canal d'entrée (stdin) : 0 (0< = <) 
                        canal de sortie (stdout) : 1 (1> = >)
                        canal d'erreur (stderr) : 2

                Les canaux sont des sortes de fichiers dans lequel on peut lire et écrire.

                        > : rediriger dans un nouveau fichier (l'écrase s'il existe déja)
                                exemple : cut -d , -f 1 fichier.txt > fichier2.txt
                                 
                        >> : rediriger à la fin d'un fichier

                        2> : redirige les erreurs dans un nouveau fichier 

                        2>> : redirige les erreurs à la fin d'un fichier 

                        2>&1 : redirige les erreurs au même endroit et de la même façon que la sortie standard.

                                exemple :  
                                        -	cut -d , -f 1 fichier > fichier2.txt 2>&1

                                        on peu aussi rediriger la sortie standard vers la sortie d'erreur:
                                                1>&2

                                        Ceci peut être utilse dans le cas où l'on veut envoyé une saisie érroné dans le canal d'erreur.

                        > /dev/null 2>&1  : redirige dans le "vide" (permet de ne laisser aucune trace)

                        < : envoie le contenue d'un fichier à une commande.

                        << : passe la console en mode saisie du clavier, ligne par ligne. Toutes ces lignes seront envoyées à la commande lorsque le mot-clé de fin aura été écrit. 
                                exemple : $ sort -n << EOF > nombres_tries.txt 2>&1
                                                > 18
                                                > 27
                                                > 1
                                                > EOF

                                exemple2:
                                        
                                        >	cat /etc/passwd 2> /dev/null > /passwd || echo "mon message d'erreur"
                                        > 	(cat /etc/passwd > /passwd) 2> /dev/null || echo "mon message d'erreur"


                Rediriger la sortie standard et la sortie d'erreur:

                        &>MON_FICHIER  OU  >&MON_FICHIER 

                        En version longue: >MON_FICHIER 2>&1

                Pour ajouter, même principe:

                        &>>MON_FICHIER

                        Version longue:  >>MON_FICHIER 2>&1

                Rediriger vers un terminal:

                        Vous pouvez rediriger n'importe quelle sortie vers un autre terminal

                        exemple:
                               
                               w #: affichera les terminaux en cours d'utilisation
                               echo wtf /dev/pts/4  #: affichera 'wtf' dans le terminal °4

                Rediriger les sortie d'une commande vers l'entrée d'autre processus/commandes différents:

                        exemple:

                                command > >(CMD_STDOUT) 2> >(CMD_STDERR)

                Une petite finte pour dupliquer sont canal:

                        cat file_fantome 2>(tee -a error.log)

                        #l'erreur sera afficher sur le terminal et écrite dans error.log

	__________________
	$exec : permet d'ouvrir d'autre canaux (de 3 à 9 en entrée et sortie)
		exemple:
			exec 4> FILE
			pwd >&4
			
			cat FILE : donnera le chemin indiqué par pwd
			
			exec 4>&- : permet ensuite de fermer le canal
			
		- : représente le canal de fermeture

                Exemple de recouvrement dans un script:

                        #!/bin/bash

                        #Je redirige mes canaux stdout vers ok.log et stderr vers nok.log
                        exec 2> >(tee -a nok.log) 1> >(tee -a ok.log)

                        echo ok         #ecrira "ok" dans ok.log
                        echi nok        #ecrira "command not found" dans nok.log

	__________________
	$tee FILE : duplique le canal de sortie dans un fichier
			exemple:
				cat /etc/passwd | grep paul | tee paul.txt | wc -l
					--> écrira la sortie de la commande grep dans le ficheir paul.txt

                    tee -a FILE : rajouter à la fin du fichier FILE au lieu d'en recréer un.
	
	__________________
	$xargs : utilise la sortie d'une commande
		exemple : find luc | xargs rm   (supprimera les fichiers luc)
	

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SURVEILLER SON SYSTEME
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	--------------------------------------
	Les démons
	--------------------------------------
                __________________
		$syslogd : Permet de dumper des logs systèmes.
                        Sur les nouvelles distributions, syslogd est remplacé par rsyslogd
		
                        Conf présente dans /etc/syslog.conf

                        Fonctionnement à approfondir : todo

                __________________
                $rsyslogd : "reliable and extended syslogd"
                        rsyslog est un autre projet de syslog et apporte plusieurs nouveautés tels que:
                                -multi-thread
                                -amélioration de la sécurité et de la fiabilité
                                -Un bon nombre de fonctionnalité

                        Voir sa liste de fonctionnalité:
                                http://www.rsyslog.com/doc/features.html

                        Il est le concurent direct de syslog-ng:
                                http://www.rsyslog.com/doc/rsyslog_ng_comparison.html


	--------------------------------------
	Les LOGS
	--------------------------------------

        /var/log/syslog
		/var/log/messages : infos sur les services et démons
		/var/log/secure : infos sur les connexions
		/var/log/lastlog : voir les dernières connexions
			s'utilise avec la commande lastlog
		/var/run/utmp : contient aussi des infos de connexion
			La commande who l'utilise
		/var/log/wtmp : infos sur les connexions établies
			Voir last et who


        $logstash: (+kibana + elasticsearch: solution de traitement de log)
        $syslog : centralisation et traitement des logs

	--------------------------------------
	OS distribution version:
	--------------------------------------

        Les fichiers:
            /etc/*-release

		__________________
		$uname : donne des informations system tel que la version du kernel, l'archi du processeur ...
			-r : Noyau
			-o : OS
			-p : processor

			IL est possible de voir les différentes versions des noyau installées grâce au fichier /boot/vm* :
				ls -l /boot/vm*
				
		__________________
		$lsb_release -d : donne le nom de développement du système 
                        -a : donne toutes les infos de version de l'OS

                        le fichier se trouve dans /etc/os-release

                            PRETTY_NAME="Debian GNU/Linux 7 (wheezy)"
                            NAME="Debian GNU/Linux"
                            VERSION_ID="7"
                            VERSION="7 (wheezy)"
                            ID=debian
                            ANSI_COLOR="1;31"
                            HOME_URL="http://www.debian.org/"
                            SUPPORT_URL="http://www.debian.org/support/"
                            BUG_REPORT_URL="http://bugs.debian.org/"

		__________________
		$cat /etc/issue : permet de connâitre la version de son OS et sa distribution.
		__________________
        $cat /proc/version : voir la version de son noyau
        __________________
        Afficher directement depuis un fichier:

            $cat /etc/lsb-release : voir la version de son système
            $cat /etc/redhat-release
            $cat /etc/SuSE-release
            $cat /etc/slackware-version

            $cat system-release
            $cat system-release-cpe

	--------------------------------------
	Voir l'activité du système
	--------------------------------------
		__________________
		$lastlog : visualiser les derniers logs de connexion

		__________________
		$w : savoir qui fait quoi sur le pc

		__________________
		$date : affiche la date

			 Personnaliser l'affichage de la date:
             (voir le man)

             Heure avec secondes :
                > date "+%H:%M:%S"

            Heure et date :
                > date "+[%D %H:%M:%S]"

            Timestamp :
                > date "+[%s]"

		__________________
		$uptime : savoir depuis quand le pc est allumé. 

		__________________
		$who : liste des utilisateurs connecté (un peu similaire à w)
			Ce fichier consulte /var/run/utmp

            > who -b : voir le dernier boot de la machine

		__________________
		$last: 	permet de visualiser les connexions, les arrêts et les reboots du système.

			Cette commande va regarder dans le fichier /var/log/wtmp
				
				si logrotate est installé, on aura les logs depuis le début du mois sinon depuis l'installation du système.

            > last reboot : voir les dates derniers reboot du système

		__________________
        $lastb : permet d'afficher les tentatives de connexion echouées.

		__________________
		/var/log/auth.log

			Ce fichier repertorie toutes les tentatives de connexion au système. (local, ssh, telnet, sudo ...)


		__________________
		$dmesg : afficher les messages du noyau du buffer (concernant le boot)
			messages récupérés dans /proc/kmsg
		
			> dmesg |less

			Très utile pour débugué !
			Par exemple, si votre interface réseaux ne se monte pas ou n'est pas présente;
			Faite un grep sur eth0 par exemple et véifiez les lignes correspondantes.

		__________________
		$watch : permet de visionner (refresh) une commande en temps réel, en plein écran.
			-n X : avec W l'intervalle de refresh en seconde.

			exemple:
				watch -n1 "ps faux|grep 10005"
				watch -n0.2 "..."
		__________________
        $nmon : Tools complet pour monitorer la plupart des ressources de sa machine.

            Outil interactif.

            Récupérer le résultat dans un fichier:

            exemples:

                > nmon -f -s 30 -c 120
                > nmon -fT -s 30 -c 120

	--------------------------------------
	Date système
	--------------------------------------
                Voir timezone (locale)/date/ntp
                http://doc.ubuntu-fr.org/ntp
                http://doc.ubuntu-fr.org/ntpdate
              

                Seter l'heure du system via ntpdate
                        TODO
        
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CHIFFREMENT et HASH
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	__________________
	$encfs : chiffrer simplement un dossier:

		aptitude install fuse-utils encfs

		Création d'un répertoire:
			
			encfs /path/folder/chiffré /to/path/folder/clair

		Lors de la création, choisir le mode p (paranoiaque) et saisir un mot de passe.
		Ce mot de passe sera demandé chaque fois que l'on monte un répertoire en clair.

		Démonter un répertoire en clair:

			fusermount -u /path/folder/clair

		Note:
			Les fichiers placés dans le répertoire en clair sera copier automatiquement dans le dossier chiffré.

	__________________
	$cryptsetup : chiffrer une partition (utilitaire utilisé par disk utility sous ubuntu)

            Voir aussi gnome-disk-utility

                exemple de montage manuel:

                    Dans la fstab:
                        /dev/mapper/media /mnt/media ext4 user,atime,noauto,rw,dev,exec,owner
                    mkdir /mnt/media
                    cryptsetup luksOpen /dev/sdc1 media
                    umount /dev/media
                    cryptsetup luksClose media

            LUKS : pour chiffrer sa partition:
            `````````````````
                todo

                cryptsetup luksFormat /dev/VolGroup00/guest01-crypt

                Redimensionnement:
                    http://www-01.ibm.com/support/knowledgecenter/linuxonibm/liaat/liaatsecencryptexp.htm
                
	__________________
	$gpg : gnuPG, permet de chiffrer/déchiffrer à l'aide clé gpg / rsa ...

        http://fedoraproject.org/wiki/Creating_GPG_Keys

		--gen-key : générer une paire de clé
		--list-keys : lister les clés présentes
		--armor --output KEY_PUB -export KEY_NAME 
		--import KEY : permet d'importer une clé
		--armor --output FILE_CIPHER --encrypt FILE : permet de chiffrer un fichier
		--output FILE --decrypt FILE_CIPHER : permet de déchiffrer un fichier
		-u : indiquer un path vers une autre clé

        Créer une nouvelle cléf :

            > gpg --gen-key

            Note : pour générer de l'entropy facilement :

                Voir $rngd et le package rng-tools

        Pour ajouter un niveau de trust à une clé :

            Mode interactif :

                > gpg --edit-key KEY_NAME  #peut être l'ID de la clé.
                 - trust
                 - 5    #(ou un autre niveau)
                 - y
                 - quit

            Manuellement :


                #Récupérer le nom de sa clé :
                > gpg --list-keys

                #Récupérer le KEY_ID
                > gpg --list-keys --with-colons KEY_NAME

                #(C'est la deuxième suite alphanumérique à la ligne pub) 
                # Ex : pub:u:4096:1:A6359H7599Y2835D:3836711089:::u:::scESC:
                #l'id sera A6359H7599Y2835D

                #Chiffrement d'un fichier pour forcer le trust de façon permante :
                > touch /tmp/sample.txt
                > gpg -e -r KEY_NAME --yes --trusted-key KEY_ID /tmp/sample.txt

            Via la conf :

                #Récupérer le KEY_ID
                #Puis ajouter la clé trustée :

                > vim /root/.gnupg/gpg.conf
                    
                    trusted-key A6359H7599Y2835D

            Vérifier le niveau de trust :

                > gpg --edit-key KEY_NAME

	__________________
	$rngd : Générer de l'entropy
    $rngtest : contrôle comment générer de l'entropy

        > apt-get install rng-tools
        ou
        > yum install rng-tools

        > rngd -r /dev/urandom
	__________________
	$gpgsm : fonctionne comme gpg, avec le support des certificat x.509 et du protocole CMS

	__________________
	$openssl : outils relatif à la gestion du protocole ssl

        > Voir memo_openssl et tips_ca et pki
	__________________
	$certtool: générer facilement des certificats
		(normalement dispo avec gnutls)		

		certtool --generate-privkey --outfile key.pem
		certtool --generate-self-signed --load-privkey key.pem --outfile cert.pem

	__________________
	$md5sum : créer un hash md5

		echo "hello" |md5sum
		echo -n "hello" |md5sum
	
	__________________
	$sha512sum : créer un hash sha

		idem
	__________________
	$mkpasswd : générer des pass sous forme de hash...
		mkpasswd -m METHOD [MON_PWD]

		Attention mkpasswd utilise le SALT pour avoir un hash différent à chaque fois.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROCESSUS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

processus = programmes en cours d'éxécution + tout son environnement d'éxécution (mémoire, état, identification, propriétaire, père...)

	Lorsque l'on execute une commande, le shell créer un nouveau processus qui devient un processus enfant du shell.

	--------------------------------------
	Identification d'un processus
	--------------------------------------

		[PID] (Process ID) : Identifiant unique du processus.
			le premier processus lancé est 1 et correspond généralement à init.
		[PPID] (Parent Process ID) : Correspond au PID du processus père.
			Un processus peut lancer d'autres processus (Child processus), c'est pourquoi chaque enfant dispose du PPID père.
		[UID] ,[GID] de l'utilisateur qui a lancé le processus. 
			Nécéssaire pour vérifier les droit d'éxecution d'un processus. Les processus enfants heritent des ces informations. Celle ci sont modifiables par la suite.
		[C] : plus la valeur est élevé plus la priorité est élevé
		[STIME] : Heure de lancement du processus
		[TTY] : Nom du terminal depuis lequel le processus a été lancé
		[TIME] : durée de traitement du processus
			La durée de traitement correspond au temps d'exécution écoulé depuis le dernier réveil du processus. Dans un environnement multitâche, ce temps est partagé entre plusieurs processus.
		[CMD] : Commande exécutée.
		[F] : Drapeaux du processus
		[S] : État du processus
		[PRI] : priorité du processus
			Les processus sont traités par ordre de priorité. La priorité d'un processus inactif augmente afin qu'il ai une chance d'être exécuté. L'inverse se produit pour les processus actifs.
			C'est le scheduler (l'ordinnanceur de tâche) qui gère les priorités et les temps d'exécution.
		[NI] : NIce, incrément pour le scheduler
		-Répertoire de travail actif: Correspond au répertoire courant depuis lequel le processus a été lancé. Ce répertoire servira de base pour les chemins relatifs.
		-Fichiers ouverts (table des descripteurs des fichiers ouverts): Par défaut on retrouve les 3 canaux standard (0, 1 et 2). A chaque ouverture de fichiers ou canaux, la table se remplit.
			Lorsque le processus est fermé, les descripteurs se ferment
		-Autres infos: 
			-taille de la mémoire allouée
			-UID, GID effectifs et réel 

	--------------------------------------
	États d'un processus
	--------------------------------------

		-user mode: exécution en mode utilisateur
		-kernel mode: exécution en mode noyau
		-waiting: en attente E/S
		-sleeping: endormi
		-runnable: prêt à l'exécution
		-mémoire virtuelle: endormi dans le swap
		-nouveau processus
		-zombie: fin de processus (= defunct)

	--------------------------------------
	Tâche de fond
	--------------------------------------
		__________________
		$<cmd> & : lance la commande en arriere plan et donne son PID
			Attention: 
				Le processus est rataché au shell, il ne faut donc pas le fermer.
				Le processus ne doit pas attendre de saisie.
				Le processus ne doit pas afficher de résultats sur l'écran.

			exemple:

			>	ssh $blade "cd /usr/local/repo && hg up && commande_verbeuse.pl" > /dev/null 2>&1 &

			Cette ligne permet d'exécuter une commande en arrière plan sans afficher la sortie standard et d'erreur.
		
		__________________
		[ctrl + Z] : suspendre l'execution d'une commande (un processus)
		[ctrl + c] : arreter un procéssus lancé en console.

		__________________
		$jobs : voir la liste des processus en arrière plan (Running ou Stopped)

			Cette commande ne voit uniquement que les processus ratachés au shell courant.

			-l : permet de voir le PID

			(wd: FOLDER) -> indique le repertoire dans lequel le processus en background travail.

		__________________
		$fg %[job]: remettre au premier plan un processus suspendu

		__________________
		$bg %[job] : relance en arrière plan un processus suspendu
		
		__________________
		$nohup <cmd> : lance la commande en arriere plan et détache le processus du shell
				(ignore le hang up)

			Par défaut les canaux de sortie et d'érreurs standards sont redirigés vers le fichier nohup.out

                        Pour ne pas bloquer le script en cours, il faut rajouter le '&' à al fin de la commande:

                                nohup COMMAND &

                        Pour ne pas avoir la sortie dans un nohup.out et être au max silencieu:

                                nohup COMMAND >/dev/null 2>&1 &

                                exemple sur un enchainement de commande:

                                        > nohup $command1 >/dev/null 2>&1 && $command2 & 
		__________________
		$setsid <cmd> : lance la commande en arriere plan et détache le process du parent.

            Presque identique à nohup mais sans l'output de la commande lancée en background.

		__________________
        $disown: empecher un process de s'arrêter lorsqu'on quitte le tty

            -h %X : avec X le n° de process donné par jobs

            Exemple:

                > monScript
                > CTRL + Z
                > jobs
                > bg
                > disown -h %1
                > exit

	--------------------------------------
	Liste des processus
	--------------------------------------
		__________________
		$ps : liste des processus statique
			no argument: affiche les processus en cours lancé par l'user depuis le shell
			-f : donne plus de details
			-e : infos sur tous les processus en cours
			-ejH : afficher les processus en arbre
			-u USER[,USER2,USER3...] : lister les processus lancés par un utilisateur
			-q GROUP : idem mais pour les groupes
			-l : plus d'infos techniques:

			Syntax (plus courante car utilisé sur BSB)

			ax : liste tout les processus
			aux : liste tout les processus de l'utilisateur courant

			Favoris:

			faxj : liste les process en arbre.
			flax : idem mais avec plus de renseignement. 
			
			Commande très complete, voir le man pour plus de details

		__________________
		$top : lister les processus de façon dynamique
			liste de commande dans top : 
				q : ferme top
				h : affiche l'aide, et donc la liste des touches utilisables
				B : met en gras 
				f : ajoute ou suprime des colonnes dans la liste
				F : change la colonne selon laquelle les processus sont triés
				u : filtre en fonction de l'utilisateur que l'on veut
				k : tuer un processus en fonction de son PID
				s : change l'intervalle de temps entre chaque rafraichissement

				[MAJ] + [1] : Afficher les stats de tout les coeurs

			-c : permet d'afficher les noms des programmes
			-d : changer la fréquence de refresh (en seconde)
				exemple
					-d 0.1

		__________________
		$htop : idem que top mais cet utilitaire bénéficie d'un affichage plus pratique.

	--------------------------------------
	Arrêter un processus - envoie de signaux
	--------------------------------------

		Le signal est l'un ds moyens de communication entre les processus. Lorsqu'on envoie un signal à un processus, celui-ci doit l'intercepter et réagir en fonction.
		Certains signaux peuvent être ignorés, d'autres non. Le nombre de signaux disponibles diffère selon l'Unix.
		__________________
                $pidof PROCESS : donner le pid d'un process

                    Ex:
                        pidof firefox

		__________________
		$kill [OPTIONS] PID : envoyer un signal au processus.
			Sans options: tue le processus.
			-l : voir la liste des signaux

			-1 N°PROCESSUS : réinitialise le processus
			-9 N°PROCESSUS : Arrêt brutal du processus

			Quelques signaux (les numéros peuvent être différent selon le system):

				1 SIGHUP: (Hang Up = raccrocher/pendre en fr). Ce signal est envoyé par le processus père à tous ses enfants lorsqu'il se termine.

				2 SIGINT: Intérruption du processus (= [Suppr] ou [Ctrl + c])

				3 SIGQUIT: idem que SIGINT avec la génération d'un core dump (fichier de debug)

				9 SIGKILL: Signal ne pouvant être ignoré, force le processus à finir brutalement (ne peut être trappé)

				15 SIGTERM: (Par défaut), demande au processus de se terminer normalement. 

				SIGCHLD : signale envoyé pour réveiller un processus dont un des fils est mort.

			exemple:

				> kill -9 45500 
					-->  tue brutalement le processus de PID=45500

		__________________
		$killall : même fonction que kill mais en fonction du nom du processus.
			-r REGEX : tuera tous les processus correspondand à la REGEX.


		__________________
		Notes:	Lorsque le shell est quitté, le signal SIGHUP est envoyé aux enfants pour qu'ils se terminent. Ainsi tous les processus fils ratachés au shell seront tués.

		__________________
                Note sur les processus zombies:

                        Quand un fils se termine, il envoie un signal SIGCHLD à son père. 
                        Le père doit obtenir auntant de SIGCHLD qu'il a eu de fils ou émis de SIGHUP.
                        Si le signal SIGCHLD n'est pas reçu par un processus père, et que ses processus fils sont pourtant terminé, alors ces derniers deviennent des processus zombi (defunct).
                        autre exemple:
                                Si le père se termine avant que les fils se terminent, ceux-ci deviennent des zombies: le signal SIGCHLD n'est pas reçu.
                        Le processus zombie ne consomme pas de ressource et ne peut pas être tué, puisqu'il est "mort".
                        Il continue cependant à occuper une entrée dans la table de processus. 
                        C'est init qui le récupère
                        Init execute périodiquement l'appel wait pour tuer les zombies fils.

	--------------------------------------
	Gérer la priorité d'un processus
	--------------------------------------
		__________________
		$nice : permet de lancer une commande avec une priorité plus faible. Afin de permettre à d'autres processus de tourner plus rapidement. (Et vice-versa :p )

			nice [VALUE] <cmd> [arguments]

			la valeur de priorité est comprise entre 20 et -20
				valeur négative = plus haute priorité (si autorisé)
				valeur positive = priorité plus basse

				exemple:
					> nice -10 ls -lR / >big_list.txt 2>/dev/null&
					> ps -l
						--> NI = 10

		__________________
		$renice : idem que nice mais modifie la priorité en fonction d'un user, group ou d'un PID. La commande doit donc être déja lancée.
			(nécéssite d'être en sudo pour augmenter la priorité)

			renice [OPTIONS] ID
				-n [-20 - 20 ]: PRIORIT2
				-p PID
				-g GID
				-u UID

		__________________
		$wait : permet d'attendre un processus avant de changer d'état.
			Par exemple le père attend ses processus fils avant de reprendre son execution.


	--------------------------------------
	/PROC : infos des processus pour le kernel
	--------------------------------------

		Voir man proc pour plus de détails.

		Pour chaque PID, il y à un dossier associé comportant toutes les information nécéssaire pour le systeme, comme la consomation CPU ...


	__________________
	$exec process:	Cette commande a pour principal but de remplacer le processus courant par un nouveau processus.
			(on recouvre le processus père)

		Ceci est utile dans plusieur cas:
		Pour les systèmes, on créer à l'aide d'un fork un processus fils identique au père qui va executer un process à l'aide d'exec.
			Cette méthode permet d'avoir le contrôle sur le processus sans en être dépendant.

		Pour le coté admin, cela permet de recouvrir le processus en cours et ainsi de l'arrêter.

		exemple:

			>	exec echo "erreur, end of process"
			
			

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PERFORMANCES & ANALYSES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	__________________
	$time <cmd>: mesure la durée d'exécution d'une commande
		retourne trois valeurs:
			
			real: durée totale d'exécution de la commande
			user: durée du temps CPU nécessaire pour exécuter le programme
			system: durée du temps CPU nécessaire pour exécuter les commandes liées à l'OS (appels système au sein d'un programme).

	__________________
	$top : voir section "processus", cependant cette commande nous permet d'avoir un bref aperçus des ressources consomées.

	__________________
	cat /proc/cpuinfo : permet d'avoir des infos précisses sur les CPUs, (à refresh!)

	__________________
	/dev/shm : Chemin d'accès en écriture en RAM.
		Permet notament de copier des fichiers pour qu'ils soient exécutés plus vite.

	__________________
	$free : Permet de voir rapidement la quantité de mémoire disponible et utilisée.

        Il est possible que votre mémoire soit saturé dû aux données stockées en cache:

                Pour vider le cache entièrement:

                        echo 3 > /proc/sys/vm/drop_caches ;

                        
	__________________
    drop cache:

                To free pagecache:

                # echo 1 > /proc/sys/vm/drop_caches

                To free dentries and inodes:

                # echo 2 > /proc/sys/vm/drop_caches

                To free pagecache, dentries and inodes:

                echo 3 > /proc/sys/vm/drop_caches
                
	__________________
	$swapon et swapoff : permettent d'activer/désactiver le SWAP

	__________________
    $acpi -t : checker la température
    $sensors : idem (apt-get install lm-sensors)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ARRET ET REDEMARRAGE DU SYSTEME
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	__________________
	$shutdown: contrôler l'arrêt du système

		-h -time 60    : éteindre avec un timer (temps en minutes)
		-h +20 "Arrete du systeme pour maintenance"  : éteind dans 20 minute le poste avec un message d'arret.
		-c : annule une programation d'arrêt.
		-r 12:30  : reboot à 12h30

			si il y a des bips, essayer:  xset -b  (pour couper les "bip" systeme)
					
		-h now arreter le systeme
		-r now : rebooter le systeme

		Envoie le signal SIGTERM aux processus, et notifie le processus INIT du changement du runlevel ( init 0 : arret; init 1: maintenance, init 6 : reboot)

					
	__________________
	$poweroff: arreter complet du système (signal the PSU to disconnect main power)
    $shutdown -P

	__________________
    $halt : arrêt partiel du système (CPU)
    $shutdown -H

	__________________
	$reboot : reboot le systeme.
    $shutdown -r

	__________________
	$pm-suspend : suspendre la session

	__________________
	$pm-hibernate : passer en mode hibernation

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RUNLEVEL et SERVICES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	Ils dépendent de la distribution et définissent le niveau d'execution du système.
	Un run level définie en fait un environnement de processus autorisé à exister.

    /!\ au type de système init employé, certaines commandes peuvent varier 
    Notament depuis la migration de sysVinit vers Systemd

    https://fedoraproject.org/wiki/SysVinit_to_Systemd_Cheatsheet
    https://wiki.debian.org/systemd

	__________________
	$init : permet de lancer le système dans un runlevel particulier
	__________________
	$telinit : à préférer à init, il communique avec ce dernier et permet de changer de niveau sans redemmarrage.


		Pour une distrib type Debian:
			init 0 : arrets
			init 1 : single-user (mode minimal)
			init 2 - 5 : multi-user (Avec interface graphique)
			init 6 : reboot

			par défaut il lance le niveau 2

	__________________
	$runlevel : Afficher les états du runlevel
		Sans argument: affiche le runlevel courant

		Il utilise /var/run/utmp

	__________________
	Default runlevel:

		Le runlevel par défaut est définit dans

		/etc/inittab pour une Debian 
                ou
                /etc/init/rc-sysinit.conf

			--> id:2:initdefault:

		/etc/init/rc-sysinit.conf

			--> env DEFAULT_RUNLEVEL=2
	__________________
	Personnalisation du runlevel

		On peu modifier directement les scripts présents dans /etc/init.d/
		Cela affectera le mode d'éxecution du service même lors du démarrage.

		Si l'on souhaite éditer le script de lancement d'un service à la main, 
		un modèle est présent dans:
			/etc/init.d/skeleton

		On peut ensuite activer/désactiver à la main les service en ajoutant un lien symbolique dans 
		/etc/rcX.d	#X correspondant au runlevel.

		Tout les services d'un runlevel sont présent dans ces dossiers.
		Ce sont des liens vers /etc/init.d/SERVICE_NAME

	__________________
	$update-rc.d : permet de mettre à jour les liens d'un runlevel.

		En relation avec /etc/rcX.d et /etc/init.d

		Exemple de désactivation d'un service:

		> update-rc.d pure-ftpd disable

		Ajout d'un script au run level: (ce dernier doit être présent dans /etc/init.d/)

		> update-rc.d SERVICE defaults

		ou

		> update-rc.d SERVICE start XX 2 3 4 5 . stop XX 0 1 6 .

			XX : est à remplacer par une valeur déterminant son positionnement d'execution (Ordre croissant). 
			Chaque service est numéroté.

			Les autres numéros correspondent au runlevel. 
			start = activation
			stop = désactivation


                        Votre script devra comprendre un en-tête type:

                                #!/bin/bash
                                ### BEGIN INIT INFO
                                # Provides:          daemon concerné ou nom du script
                                # Required-Start:
                                # Required-Stop:
                                # Default-Start:     2 3 4 5
                                # Default-Stop:      0 1 6
                                # Short-Description: ma description
                                # Description:
                                ### END INIT INFO

                        Voir le README placé dans init.d


		Note dénomination du /etc/rcX.d (avec X un n° de runlevel)
			^K : non activé
			^S : activé

        En cas de problème avec insserv:
            > insserv -d /etc/init.d/mon_script

		__________________
        $insserv:  insserv - boot sequence organizer using LSB

	----------------------
	Les systèmes d'initialisation :
	----------------------

    ### SYSTEMD

      Depuis les dernnières versions Centos, Debian...

      "C'est un ensemble de programmes destiné à la gestion système, conçu pour le noyau Linux"
      Source : http://lea-linux.org/documentations/Systemd
      __________________
      $systemctl : permet de contrôler systemd et le service manager:

        
        systemctl : afficher l'état des services managés

        --disable SERVICE : désactiver un service
        --enable SERVICe : activer un service

              Lister les services (équivalent du chkconfig --list) :

                  systemctl list-unit-files --type=service 

        Exemple désactivation d'un service au démarrage :

            #Affichage des services activés ou non :
            service --status-all
            #ou
            systemctl list-unit-file

            #Désactivation d'un service
            sudo systemctl disable nginx

            #Vérification :
            #Dans votre runlevel courant (taper runlevel), vérifier que le lien symbolique soit marqué "K0X"
            #Exemple :
            runlevel
            ls /etc/rc5.d
            #K01nginx -> ../init.d/nginx*

    ### init System V (SYSVINIT)

      Anciennement par défaut pour Debian
      __________________
      $sysv-rc-conf : gestionnaires de service comme chkconfig.
        Lancé sans argument = mode interactif lux
        sysv-rc-conf SERVICE_NAME on|off

        Il permet d'activer/désactiver un service selon le niveaux d'execution

    ### Upstart

        Anciennement par défaut pour Ubuntu

            Ubuntu s'appuie sur upstart un successeur de system V .

            Les script d'initialisation se trouvent dans le /etc/init au lieu de /etc/init.d

            Pour désactiver/activer un service au démarrage voir les lignes des scripts correspondant à:
                start on (runlevel [3]
                stop on runlevel [0126]
        __________________
        $initctl [Options]:
            list : lister les process actifs

	----------------------
	Gestionnaires de service
	----------------------

		__________________
    $update-rc.d : idem que chkconfig mais pour Debian et Ubuntu

		__________________
		$chkconfig : Outils de gestion des services à démarrer en fonction du runlevel (RedHat)

            --list : Afficher tout les services gérés par chkconfig. (Affichage des runlevel et du service lié)
			--add SERVICE : ajouter un service
            --del SERVICE : supprimer un service
			--level [123456] SERVICE on|off
		
		__________________
		$ntsysv : interface interfactive pour chkconfig


	----------------------
	Gentoo
	----------------------
		__________________
		$rc-update

		to see : 
			http://lea-linux.org/documentations/Admin-admin_boot-daemons

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GESTION AVANCE DU SYSTEME
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ----------------------
        Initialisation du système:
        ----------------------

            http://www.debian.org/doc/manuals/debian-reference/ch03.en.html

            Premier process après le chargement du noyau

           (OpenRC, systemd : todo)
            __________________
            $init (sysvinit)

                http://wiki.openwrt.org/doc/techref/initscripts
            __________________
            $upstart : utilisé par ubuntu

                Utilise les fichier de conf dans /etc/init

        ----------------------
        Périphériques:
        ----------------------

                __________________
                $udev : Gestion dynamic des périphériques (nodes) de /dev

                    Lien :

                        http://doc.ubuntu-fr.org/udev

                    Description :

                    C'est le nouveau système de gestion de /dev remplaçant Devfs.
                    Il fait le lien entre les infos données par sysfs et les règles utilisateurs dans le but de créer et nommer les périphériques.
                    Il s'appui sur Sysfs pour exporter les infos des périphériques et créer les nodes.

                        Nodes :
                        `````````````````
                            nodes = fichier represésantant un périphérique

                            Chaque nodes (définit dans /dev) peuvent être utilisés par les programmes pour utiliser un périphérique.

                            Par exemple le serveur X va lire /dev/input/mice pour afficher le curseur au bon endroit.
                                Si on fait :

                                    > xxd -b  /dev/input/mice
                                    
                                et que l'on bouge sa souris, on verra les lignes de code correspondante au deplacement s'afficher (en binaire).

                            Il est possible d'appliquer des règles sur les périphériques grâce à udev:

                                - Modifier leur nom (comme l'interface de sa carte réseau)
                                - Modifier leurs permissions
                                - Modifier leurs propriétés
                                - Lancer des scripts personnalisés


                            Les règles sont définit dans: /etc/udev/rules.d/XX-NAME_RULES.rules
                            Les règles s'appliquent à des périphériques déja existant.

                        Nom persistant :
                        `````````````````

                            Chaque périphérique dispose d'un nom:
                            Ce nom est un lien symbolique vers les fichiers spéciaux faisant référence dirrectement au périphérique.

                            exemple:

                                > ls -lR /dev/disk #affiche les noms persistants des media de données.

                        Créer une règle :
                        `````````````````

                            Ordre d'application :

                                Par ordre alphabétique (dans /etc/udev/rules.d)
                                Il applique toutes les règles concernant un périphérique (il ne s'arrête pas à la première trouvée)


                            Syntaxe :

                                Minimum :
                                    
                                    Clé_Correspondance=="...", Clé_d'assignation="..."

                                    Avec :

                                        Clé_Correspondance : Nom d'entrée (Cible)
                                        Clé_d'assignation : Quoi faire (Actions)

                                    Exemple :

                                        KERNEL=="hdb", NAME="my_disk"

                                        => Si le kernel attribue le nom hdb à un périphérique, alors le renommer "my_disk".

                                Quelques clés :

                                    Correspondance :

                                        KERNEL : Nom donnée par le noyau
                                        SUBSYSTEM : Nom du sous système contenant le périph
                                        DRIVER : Nom du pilote du périph

                                    Assignation :

                                        NAME : Nom du périphérique "node"
                                        SYMLINK : Liens symbolique / Noms alternatifs

                                Attributs sysfs :

                                    TODO

                            Exemples de règles :

                                TODO

                        Redémarrer udev :
                        `````````````````

                            > service udev restart
                            ou
                            > udevadm control --reload-rules ; udevadm trigger

                __________________
                $sysfs (/sys) : Permet d'obtenir les informations sur les différents types de systèmes de fichiers.

                    Il est géré directement par le noyau et permet de donner les informations de base sur les périphériques.

                    Ce sysfs est monté directement dans /sys
                                         
                __________________
                $devfs : l'ancetre de udev


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
EXECUTION DE PROGRAMMES EN DIFFERE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	__________________
	$at : executer une commande à une heure précise (une seule fois)

		> at <time> <commande à executer> : éxécute la commande au temps indiqué
                > at <time> : idem mais de façon interactif

		CTRL + d : mettre fin à la commande.
		
		rajouter pm ou am pour le format anglais:
		
                        $at 2:05pm tomorrow
                        $at now +5 minutes
                        $at now +2 years
                        $at 12h00pm 11/15/08

		Le démon atd lit /var/spool/at* pour exécuter les tâches ponctuelles

		On peut limiter son utilisaton via /etc/at.deny
			
	__________________
	$atq : lister les jobs en attente
	__________________
	$atrm : supprimer un jobs en attente (lancer atq avant)
		$atrm <Nombre donné par atq>
		
	__________________
	$sleep : faire une pause
		$sleep 10 : faire une pause de 10s
		$sleep 1m : faire une pause de 1 minute...
		
	__________________
	$crontab : Permet d'éxécuter une commande régulièrement

        Note: de manière générale la crontab est éditable manuellement dans:
            /etc/crontab ou /etc/cron.d

        Via l'éditeur 'crontab -e' les fichiers sont stockés dans /var/spool/cron/crontabs

		-e : modifier la crontab    #changer l'éditeur: export EDITOR=vim
		-l : affiche la crontab 
		-r : supprimer la crontab

		syntaxe de la crontab:

                        Temps:

                                m : minutes
                                h : heures (0-23)
                                dom : (day of month)
                                mon : month
                                dow : (day of week)
                                    0 ou 7 : dimanche
                                    6 : samedi
			
                        valeurs:

                                <Nombre> : s'execute lorsque le champ prend la valeur du Nombre
                                * : s'execute pour chaque valeurs du champ possible
                                X,Y,Z : s'execute pour X ou Y ou Z
                                X-Y : s'execute de X à Y
                                */X : s'execute pour chaque multiple de X

                                exemples:
                                        */5 : s'éxecute toutes les 5 unités (5,10,15)
                                        0-10/2 : s'éxécute toutes les 2 unités, de 0 à 10 (0,2,4,6,8,10)
			
			Modèle:

                | #minute hour    mday    month   wday    who     command
                |
                | 0 15 * * * scp file.txt user@host:~/ >> /logs/scp_ron.log 2>&1
                | 20 * * * * rm -R folder > /dev/null 2>$1 

		
			Si on ne veut rien récupérer, il faut rediriger la sortie de la commande dans /dev/null (avec les erreurs)


                        Gestion des mails et des alias
                        ``````````````````````````
                            
                            Pour que la crontab puisse envoyer des mails dans /var/mail/root en cas de fail d'une commande.
                            Il faut ajouter MAIL=root dans /etc/crontab
                            (supprimer pour désactiver)

                            et éditer le fichier alias:

                            > vim /etc/aliases

                                #Alias de base:

                                mailer-daemon:  postmaster
                                postmaster: root

                            Note: se base sur /bin/mail pour envoyer des mails en local

                                > apt-get install mailutils


        __________________
        $anacron : En complément à cron, il sert à éxécuter les tâches qui n'ont pas été lancée durant l'arrêt de la machine.

                -f : force l'éxécution d'anacron sans tenir compte des timestamp
                -u : mettre à jour les timestamp sans éxécuter les commandes
                -s : permet de lancer une tâche une fois que la précédente est complètement fini
                -d : afficher la sortie standard
                -t anacrontab : Utiliser un autre fichier anacrontab
                -n : permet de lancer les tâches tout de suite sans prendre en compte les délai (nécéssite -s)

                Par défaut, cron lance anacron toutes les 7h30, voir dans /etc/cron.d/anacron
                Il est tout de même éxécuté à chaque démarrage de la machine (fonctionnant comme un service)
                Il se base sur les timestamp des fichiers contenu dans /var/spool/anacron pour éxécuter les commandes dans /etc/cron.XX qui n'ont pas été lancées.

                La configuration d'anacron se fait normalement dans /etc/anacrontab comptenant ces entrées:

                        | # /etc/anacrontab: configuration file for anacron
                        |
                        | # See anacron(8) and anacrontab(5) for details.
                        |
                        | SHELL=/bin/sh
                        | PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
                        | HOME=/root
                        | LOGNAME=root
                        |
                        | # These replace cron's entries
                        | 1       5       cron.daily      run-parts --report /etc/cron.daily
                        | 7       10      cron.weekly     run-parts --report /etc/cron.weekly
                        | @monthly        15      cron.monthly    run-parts --report /etc/cron.monthly

                Avec:
                        La 1ere collone éxprimant l'intervalle en jours entre 2 éxécutions d'une tâche
                        La 2ème, le délai en minutes entre 2 tâche exécutées par anacron
                        La 3ème, L'étiquette inscrite dans les logs (voir /var/log/syslog)
                        La 4ème, la commande à éxécuter

        __________________
        $watch : executer une commande à intervalle régulier et affiche la sortie standard (à la manière de top)
            -nX : Durée de l'intervalle en seconde (0.1) = 0.1 seconde

            exemple:
            >	watch -n0.2 "ps faux |grep fire"

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PERIPHERIQUES - HARDWARE - PARTITIONNEMENT
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	http://doc.ubuntu-fr.org/connaitre_son_materiel
    http://www.binarytides.com/linux-commands-hardware-info/
	__________________
	$lscpu : Pour afficher les infos CPU
		cat /proc/cpuinfo
		cat /proc/asound/cards
	__________________
	$mknod : Permet de créer des blocks ou des fichiers spéciaux

	__________________
	$lspci : lister tout les périphériques sur les bus PCI et AGP

            -knn : voir man

	__________________
	$lsscsi : lister tout les disques scsi
	__________________
	$lshw : lister le materiel

                -short : pour avoir un résumé
		-html : sortie au format html
		-C Type : seulement un type donné
			-C memory
	__________________
    $lsusb : Lister les périphériques usb

                -t : permet un affichage hiérarchique plus clair

	__________________
    dmidecode : Permet de décoder la table DMI (Desktop Management Interface) souvent appelé SMBIOS.
                Elle contient une description des composants hardware du syteme.

                -q : décroitre la verbosité
                -t TYPE : afficher les entrées d'un type particulier, 

			-t bios
			-t memory
			...

	__________________
	$lsscsi : afficher les périphériques SCSI (sata, usb, firewire ...)
	__________________
	$mkfs : permet d'appliquer un fs sur un media
                $mkfs.type_file /dev/sdXX : formater avec le type de fichiers
		(utilise mke2fs)

		exemples:
			mkfs.ext4 /dev/sda3
                        mkreiserfs /dev/sdaX
                        mkswap /dev/sdaX

                -L LABEL : nommer une partition

	__________________
	$mkswap PARTITION: initialiser la partition de swap

		exemple:
			mkswap /dev/sda2

		Il faudra penser à activer le swap avec swapon 

		> swapon /dev/sda2
	
	__________________
	$df : voir les périphériques montés.

		-h : pour voir en taille "humaine"
		-T : Afficher les types de file system de chaque partition
                -a : Afficher aussi les partition "morte"
                -B BLOCK_SIZE : afficher en fonction de la taille d'un bloc

                Pour connaitre la taille d'un bloc:

                        blockdev --getbsz /dev/sdaXX
                        ou                       
                        dumpe2fs /dev/sda3 | grep -i 'block size'

	__________________
	cat /proc/mounts : voir les aussi tout les périphéiques montés (sans traitment)

	__________________
	$dumpe2fs : permet d'afficher des info sur le fs courant:

		> dumpe2fs /dev/sdbX | grep -i 'Block size'  #Permet d'afficher la taille d'un block du fs.

	__________________
	$fdisk : utilitaire de partionnement et montage de disque

            Je conseil de lancer un blid avant d'utiliser fdisk pour voir clairement les types de partitions déja montées.

			-l : identifier les périphériques (en sudo)
			/dev/sdX : partitionner de façon interactive:

                        Pour les tables de partitions GUID (GPTs) ou encore les partition de très grande taille(> 2To) , il vaut mieu utiliser parted, fdisk n'étant pas compatible.

				m : afficher l'aide:

				d : mode suppression

				n : mode ajout d'une partition
					-> p : partition primaire
					-> e : partition étendue
						
						Définir la taille (apres le choix du premier cylindre):
							+32M 
							+300G ...

				p : afficher la table de partition

				a : choisir la partition bootable

				t : choisir le type de partition 
					-> l : lister les types. (à faire pour les cas particulier comme swap)

				w : enregistrer les modificiations

				Exemple:
                                ````````````

					> fdisk -l 		#Affiche les media disponibles
					> fdisk /dev/sdX	#Pour configurer le media choisi

                                                Créer une partition Bootloader:

                                                        n : nouvelle partition
                                                        p : partition primaire
                                                        1 : n° de partition
                                                        2048 : premier secteur
                                                        +2M : taille

                                                        t : application d'un fs type
                                                        2 : choix de la partition
                                                        ef : EFI

                                                Créer une partition de boot:

                                                        n
                                                        p
                                                        2
                                                        [enter]
                                                        +128M

                                                Créer une partition de swap:

                                                        n
                                                        p
                                                        3
                                                        [enter]
                                                        +512M

                                                        t
                                                        3
                                                        82

                                                Créer une partition root:

                                                        n
                                                        p
                                                        4
                                                        [enter]
                                                        [enter]

                                                 Finaliser

                                                        p : afficher le résultat
                                                        w : appliquer les modifications

                                                        Enfin il faudra formater les partition avec mkfs ou mk2fs et activer le swap avec mkswap.

	__________________
	$gdisk : utilitaire de partionnement et montage de disque plus avancé avec GPT.

	__________________
    Afficher les labels d'un disque: voir /dev/disk/by-label et 'blkid'
	__________________
	$cfdisk : idem que fdisk mais en plus conviviale

	__________________
	$sfdisk : fonctionne en interfactif (ou non) précis mais compliqué apparament.

	__________________
	$parted : permet de faire des opération avancées (comme le redimmensionnement

                -l : lister les partitions

		/dev/sdX : partitionner le disque sdX:

			help : afficher l'aide

			print : afficher la configuration courante

			rm X : supprimer la Xième partition

                        unit : définir une unité de données par défaut.

			mkpart PARTITION_TYPE [FS] SIZE_RANGE : Créer une partition:

                        name N°PARTITION NAME : donner un nom à votre partition

				exemples:

                                        unit mib

                                        Partition de bootloader:
                                                mkpart primary 1 3
                                                name X grub
                                                set X bios_grub on

					Partition de boot:
						mkpart primary ext2 3 131
                                                name X boot

					Swap:
						mkpart primary linux-swap 131 643
                                                name X swap

					Partition restante:
						mkpart primary ext4 643 -1
                                                name X rootfs
						
	__________________
	$gparted : idem mais en mode graphique.

	__________________
	$mount : monter un périphérique
		/dev/sdXX /Acces_au_montage (exemple : /media/usb)? (creer le dossier)
		-a : permet de monter tout les périphériques de la fstab
		-t : permet de définir un type de file system (ext2, ntfs ...)

                -o : donner des options de montages

                    exemple de remontage en rw:
                        -o remount,rw

		monter une iso:

		-o loop fichier.iso /path_to_mount

		Dans un environnement chrooté (ou autre situation), 
		il peut être utile de monter un dossier pointant sur un autre dossier:

		mount --bind /PATH/TO/SOURCE /PATH/TO/DEST

		Dans la fstab ça donne:

		/path/to/source /path/to/dest none bind 0 0

	__________________
	$umount : démonter le périphérique
		/Acces_au_montage

	__________________
	$fuser : voir quel processus utilise une partition.

		(utilse lorsque le systeme ne veut pas démonter le périphérique)
		-v : mode verbeux
		-m /point/de/montage : voir le processus attaché
		-k -TERM -v -m /point/de/montage : tuer le process attaché.

                -u : afficher l'utilisateur l'utilisant



                


        --------------------------
        Partitionnement
        --------------------------
            __________________
            $lvm : voir section LVM, pour le partitionnement logique (très pratique)


        --------------------------
        Divers
        --------------------------
            __________________
            $eject : permet d'ouvrir fermer le lecteur cd:
                -t : pour fermer le lecteur

        --------------------------
        Listings
        --------------------------
            __________________
            $hardinfo : soft graphique pour le listing de périphériques

            __________________
            $blkid : affiche tout les UUID des medias connectés
                
                blkid /dev/XXX : affichera l'UUID du périphérique en question.

                        voir aussi /dev/disk/by-uuid ou byid
                                Contient les UID de chaque partitions

                        Affiche les type de file system (fs)

            __________________
            $lsof : permet de voir tout les fichiers ouverts par le systeme.

                -t : ne liste que les PID utilisant le fichier
                
                exemple d'utilisation:

                >	lsof /media/flashDrive

                    COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
                    bash     2447 polo  cwd    DIR   8,17     4096   72 /media/flashDrive/folder
                    lsof    32235 polo  cwd    DIR   8,17     4096   72 /media/flashDrive/folder

                Cette commande donner la liste des processus utilisant le fichiers monté.
        --------------------------
        Montage
        --------------------------
            __________________
            /etc/mtab: Concerne tout les points de montages en cours

            __________________
            /etc/fstab : fichier contenant les points de montages automatiques

                        voir: man mount et man fstab pour les options

                template d'une ligne de conf:

                [UUID] ou [Point_de_montage]	type_de_fs	mount_options		dump	pass

                -L'UUID ce trouve à l'aide la commande blkid
                -Le point de montage sera le chemin vers lequel le media pointra
                -Le type de fs correspond au file system du media à monter
                -Les options:
                    defaults : correspond à rw,suid,dev,exec,auto,nouser et async
                    auto : montage automatique lors de l'utilisation de mount -a
                    nouser : seul root peut monter/démonter le media
                                user : les utilisateurs peuvent monter le media
                                noatime : les temps d'accès ne sont pas enregistré (conseillé sur les lecteur à état solide type SSD) 
                                discard : permet à la commande TRIM d'effacer les block non utilisé pour les mémoire flash (accroit les performances des mémoire type SSD)
                    sw : pour le swap
                    
                -dump correspond à l'archivage des données (utilisé par dump) [pas forcement utilisé]
                                1 : dump sauvegardera le système de fichier
                                0 : système de fichier ignoré.
                -pass correspond à l'odre de vérification effectuté au démarrage si le le système ne c'est pas éteind correctement: (utilisé par fsck)
                    0 : pour swap et windows (+ cdrom et floppy)
                    1 : pour la racine
                    2 : autres partitions UNIX

                exemple:
                    # MEDIA
                    UUID=1E9272B863C1C2F3	/media/Media	ntfs	auto,users,permissions	0	0
                    #ou
                    /dev/data/media	/media/Media	ntfs	auto,users,permissions	0	0

                                Note: voir aussi du coté de autofs (coté memo_linux_network)

                        exemple d'une fstab sous gentoo:

                                <fs>            <mountpoint>    <type>          <opts>                  <dump/pass>
                                /dev/sda3       /boot           ext2            noauto,noatime          1 2

        --------------------------
        Réparation logique
        --------------------------
            __________________
            $fsck : permet de vérifier l'intégrité d'un volume
                fsck /dev/sdX       #Le périphérique ne doit pas être utilisé.

            __________________
            $badblocks : Recherche des les blocks corrompu sur un périphérique dans le but de retirer les secteurs défaillant

                https://wiki.archlinux.org/index.php/badblocks

                Note: un secteur corrompu peut modifier certaines données (ex: transformation de lettre)
                    Et peut engendrer des erreurs de types: segmentation fault

                -w : destructive test (read-write)
                -n : non destructive test (read-write)
                -sv : afficher la progression en cours
                -o OUTPUT_FILE : indiquer un fichier de sortie pour le résultat de badblocks
                -f : forcer (si la fstab est erroné, sinon ne pas utiliser !)

                Dump un fichier utilisable par fsck

                    > fsck -t FSTYPE -l bad-blocks_FILE /dev/PARTITION
			
	--------------------------------------
	LVM (Logical Volume Manager)
	--------------------------------------

            Voir:
                http://doc.ubuntu-fr.org/lvm
                http://linux.developpez.com/lvm/

		LVM permet la manipulation aisé des partitions et de faire abstraction de l'emplacement physique des données.

                En plus de pouvoir créer une multitude de partition, on peu les redimensionner, snapshoter ... Sans craindre de perdre des données.

                Installation:
                ``````````````````````````
                    > apt-get install lvm2

                Une recompilation du noyau peut être nécessaire:
                ``````````````````````````
                    
                    [*] Multiple devices driver support (RAID and LVM)
                    <M> Logical volume manager (LVM) support

                Vocabulaire:
                ``````````````````````````
                    
                    PV (Physical Volume) : concerne les partitions du disque (ou un disque entier) que l'on rend gérable par LVM.
                    VG (Volume Group) : ensemble de volumes physique formant un ensemble logique (obligatoire pour LVM)
                    LV (Logical Volume) : l'espace logique découpée (ou non) sur le VG pour accueillir le FS.
                    PE (Physical Extend) : Determine la taille du plus petit LV pouvant être crée.
                    LE : Nombre de PE contenu dans un LV

                Layout:
                ``````````````````````````

                    Partition(s) de disque LVM
                        |----> Physical Volume
                            |----> Volume Group
                                |----> Logicals Volumes
                                    |----> système de fichiers

                /!\ il est encore déconseillé de mettre /boot sur le LVM.

                Partition LVM:
                ``````````````````````````

                    > fdisk /dev/XYZ

                        #Création de la partition:
                        p                   #Afficher la table de partition
                            n               #Nouvelle partition
                                p           #type primaire
                                    1       #1ere partition
                                    X       #1er secteur
                                    +XXXXM  #Enter
                        #Typer en LVM
                        p                   #On affiche la table
                            t               #typer une partition
                                L           #On affihe les types dispo
                                [X]         #Numéro de partition si + de 1
                                8e          #LVM
                                w           #Enregistrement des modifs

                Etendre un lv:
                ``````````````````````````

                    voir: http://tldp.org/HOWTO/LVM-HOWTO/extendlv.html
                        http://blogit.madpellzo.fr/index.php?article28/lvm-etendre-un-volume-groupe-par-ajout-d-un-nouveau-disque-dur

                    On étend d'abord son vg:
                        
                        > vgextend

                    Puis le lv

                        > lvextend

                    Et enfin le FS:

                        > resize2fs

                Diminuer un lv:
                ``````````````````````````

                    exemple:

                        Réduire le fs:
                            
                            > fsadm resize /dev/mapper/vg_data-lv_home 50G

                        Réduire ensuite la taille du lv:

                            > lvreduce -L -10G /dev/vg_something/vg_data/lv_home

                                
		__________________
        $system-config-lvm : interface graphique de config pour lvm

		__________________
		$pvcreate: création de volumes physique pour LVM:

                    on démarre avant lvm :
                        /etc/ini.d/lvm2 start

                    C'est la première étape:

                    ex:
                        > pvcreate -vvv /dev/sdc1

                    Note: si une erreur de type 'not found or ignored by filtering' apparaît, vérifier la table de partition ou même l'écraser:

                        > dd if=/dev/zero of=/dev/cciss/c1d0 count=1

                    Voir aussi coté des filtres dans:
                        /etc/lvm/lvm.conf

		__________________
		$pvdisplay : afficher les volumes physiques lvm

		__________________
        $pvscan : afficher les volumes physique de manière condensé.

                            
		__________________
        $vgcreate : créer un groupe de volume.

                    vgcreate VG_NAME PV1 [PV2 ...]

		__________________
		$vgdisplay : afficher les groupes de volumes

		__________________
        $vgscan : afficher les groupes de volumes de manière condensé.

		__________________
        $lvcreate : créer un volume logique

                lvcreate -n NOM_VOLUME -L TAILLEg VGname

                ensuite on créer les FS, ex:
                    
                    mkfs -t ext4 /dev/VG/LV1
                    mkdir /mnt/test
                    mount /dev/VG/LV1 /mnt/test

		__________________
        $lvdisplay : Afficher les LV
                    
                -v /dev/VG/LVX  : affiche les info sur un lV précis
		__________________
        $lvscan : afficher les volumes logiques de manière condensé.

		__________________
        $lvremove : Supprimer un volume logique

                lvremove /dev/Vol1
		__________________
        $lvreduce : Diminuer la taille d'une partition:

                -r : resize le fs en même temps
                -L XXG : la nouvelle taille du lv
                -v : verbose

		__________________
        $vgextend : rajouter un volume au groupe

                    vgextend NOM_VG /dev/XYZ

                $pvmove
                $pvdate
                $vgchange
                $vgexport
                $lvchange
                $lvconvert
                $lvresize
                $vgreduce
                $pvremove
                    ...

	--------------------------------------
	FS (File system)
	--------------------------------------

	Le FS peut être structuré en différents élements contenant chacun des infos spécifics:

		-superbloc:
			*taille des blocs
			*droits
			*listes des blocs
			*type inode ...

		-bloc d'inodes (concerne tout les types fichiers)
			*Le type
			*bits de sécurité
			*nombre de liens pour les fichiers
			*nombre de sous répertoires pour les répertoires
			*l'UID du propriétaire
			*le GID
			*la taille du fichier (octets et blocs)
			*date de création
			*date de modification 
			*les adresses des blocs de données

			Chaque bloc de 1Ko comprend 8 inodes rangés dans une table.
			
		Plus particulièrement, un inode veut dire "noeud d'index" et corespond à une structure de données contenant toute métadonnées des fichiers stockées dans un FS.
		Chaque FS dispose de structures différentes, et donc la structure de l'inode peut varié en fonction du FS (si ce dernier l'intègre)


		-bloc de données
			*Contient le contenu des fichier 
			*N°d'inode pour les répertoires.
		-bloc d'indirection
			*Permettent d'accéder par adressage indirectes aux fichiers/reperoires volumineux

                Connaitre la taille d'un bloc:
                        blockdev --getbsz /dev/sdaXX

	--------------------------------------
	RAID (Redundant Array of Independent Disk)
	--------------------------------------

		Les raids peuvent se gérer de façon logique mais consomme énormément en ressource, attention donc.

	Voir du coté de 
		
		__________________
		$fdisk
		$mkraid
		$raidstart
		/etc/raidtab


	--------------------------------------
	Manipulation de bas niveau
	--------------------------------------
		__________________
		$hdparm : manipuler les périphériques disques gérés par libata (SATA, ATA (IDE) et SAS)

			Informations:

			-i /dev/XXX : Récupère les infos depus le noyau et obtenues au moment du boot.
			-I /dev/XXX : Intéroge directement le disque pour nous donner plein d'info (à préférer de -i)
			-g : affiche la géométrie du disque
			-T : bench de lecture du cache dique
			-t : bench de lecture du dique (hors cache)

			Modifications:

			-c : modifier la largeur du bus de transfert EIDE sur (0=16, 1=32, 3=32 bits) 
			-d : utilisation du DMA (1 ou 0 (actif ou non))
			-x : modifie le mode DMA
			-C : status de l'economie d'energie
			-r : passe le disque en lecture seule

		__________________
		$sdparm : idem que pour hdparm mais sur du SCSI

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SAUVEGARDE ET MÉMOIRE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	__________________
	$rsync : Copie/synchronisation de fichier (en fonction des modifs aportées)

            Une synchro locale:

                rsync -av /tmp/src /tmp/dst

            Une synchro over ssh:

                Push vers le serveur (inverser l'ordre pour pull)

                > rsync -avP -e 'ssh -i /path/to/key' Local_Backup server:/backup

                Note : -z pour la compression des données lors du transfert 

            Une synchro avec le daemon rsync (port par défaut: 873)

                #config:
                    > man rsyncd.conf
                    > mkdir /etc/rsyncd
                    > vim /etc/rsyncd/rsyncd.conf 

                        uid     = synchro
                        gid     = synchro
                        use chroot = no
                        max connections = 4
                        syslog facility = local5
                        pid file = /var/run/rsyncd.pid

                        [backup_px1]
                         comment = pull it
                         path = /mnt/recovery
                         read only = yes
                         list = yes
                         hosts allow = remoteHostname
                         auth users = synchro
                         secrets file = /etc/rsyncd/rsyncd.secrets

                    > vim /etc/rsyncd/rsyncd.secrets

                        synchro:synchro

                    > vim /etc/rsyncd/.secret

                        secret

                    > chmod 600 /etc/rsyncd/*

                        #Note : Droits à setter sinonle daemon ne voudra pas démarrer.

                #Lancement du daemon

                    > rsync --daemon --config=/etc/rsyncd/rsyncd.conf

                #Synchro (coté client)

                    > vim synchro.sh

                        #!/bin/bash

                        src='synchro@proxmox2::backup_px2'
                        dst='/mnt/advim-server/recovery/proxmox2/backup'
                        pid='/var/run/rsyncd.pid'
                        pass='/etc/rsyncd/.secret'

                        [[ -f $pid ]] && touch $pid

                        rsync -avz --password-file=$pass $src $dst

	__________________
	$fallocate : permet d'allouer une quantité de mémoire pour un fichier:

		-l : permet de définir la taille en octet

		exemple:

		>	fallocate -l 512m /opt/file.swap

			Allouera 512 Mo au fichier "file.swap"

	--------------------------------------
	SWAP
	--------------------------------------

		__________________
		$mkswap : permet de créer une zone de swap.

			exemple:

			mkswap /dev/sdXX

                        Le swap permet d'étendre la mémoire vive du systeme.

                        Ne pas oublier swapon pour activer ensuite le swap.

		__________________
		$swapon : activer le swap:
			
			-s : permet de voir ou le swap se trouve;
			-a : pemet d'activer toutes les zones de swap de la fstab;

			swapon /dev/sdXX : active le swap sur le périphérique désigné.

		__________________
		$swapoff : désactive la zone de swap

			-a : désactive toutes les zones de swap de la fstab.

			swapoff /dev/sdXX : désactive le swap sur le périphérique désigné.

	--------------------------------------
	Quota
	--------------------------------------

		Il est possible de définir un nombre limité de bloc mémoire pour les utilisateurs.

                Il faut pour cela activer les quota sur une partition:
                        exemple: 
                                > vim /etc/fstab
                                #rajouter les options usrquota,grpquota sur la partition concernée.

                                > mount -o remount /MonPointDeMontage : pour prendre en compte les modifs.
		__________________
		$quotacheck FileSystem: Permet de créer/checker les fichiers de quota.

                        Si les fichiers quota ne sont pas créer, quotacheck le fait automatiquement.

                        -b : faire un backup des fichier quota en cas de réecriture
                        -v : mode verbose
                        -g : concerne uniquement les groupes listés dans /etc/mtab
                        -u : idem mais pour les utilisateurs
                        -m : ne pas remonter des partition en read only. (par opposition à -M)

		__________________
		$quotaon  FileSystem: permet d'activer les fichiers de quota.
		__________________
		$quotaoff : permet de désactiver les fichiers de quota.
		__________________
		$edquota : Permet de gérer les quotas

                        -u USER : pour un utilisateur
                        -g GROUP : pour un groupe

                        syntaxe:
                                hard limit = limite stricte qu'on ne peut pas dépasser.
                                soft limit = Limite temporaire atteignable pendant la 'grace period'.
                                grace period = les données sont supprimées au dela de cette période.

                                blocks: nombre de block occupée actuellement
                                les 2 premiers soft et hard: limites en blocks
                                inodes: nombre de fichiers de l'utilisateur
                                les 2 derniers soft et hard: limites en nombre de fichiers (inodes)

                        Voir > df -Bk /MaPartition (ou Bm ..) pour afficher le nombre block dispo
                        

		__________________
		$quota : Permet d'afficher les limites d'utilisation d'une partition 
                        (Pour l'utilisateur courant)

		__________________
		$repquota : Permet d'afficher un résumé des quotas.

                        -s : données sur des unités plus lisibles
                        -i : ignorer les partitions monter par automounter
                        -a : concerne toutes les partition de /etc/mtab

	--------------------------------------
	Copier une partie d'un disque
	--------------------------------------
		__________________
		$dd : permet de copier, tout, un segment d'un disque.

			base:

			>	dd if=<source> of=<cible> bs=<taille des blocs> skip= seek= conv=<conversion>

			Créer un "faux fichier" :

			>	dd if=/dev/zero of=/mnt/san/toto bs=1024 count=10000

                Créera 10000 bloc de 1024 bit.

			Cloner un disque entier:

			> 	dd if=/dev/sda of=/dev/sdb conv=notrunc,noerror

            Cloner une clé usb

                Bien démonter toutes les partitions avant :

                    > umount /dev/sdb1 ... /dev/sdc1 ...
                
                Puis lancer la copie :

                    > dd if=/dev/sdb of =/dev/sdc bs=4M

			Réaliser l'iso d'un cd:

			> 	dd if=/dev/hdc of=/home/user/moncd.iso bs=2048 conv=notrunc

			Rendre une clé usb bootable:

			>	dd if=fichier.iso of=/dev/flash_drive

                        Voir aussi du coté du tips_usb_bootable

            Note: il est aussi possible de créer une pseudo partition (pour des tests par exemple)
                il faudra ensuite appliquer un fs sur ce fichier.

	--------------------------------------
	Récupération de données
	--------------------------------------
            http://fr.wikihow.com/r%C3%A9cup%C3%A9rer-un-disque-dur-d%C3%A9fectueux

        __________________
        $testdisk : Permet de recréer la table de partitionnement.

                    > testdisk /log

        __________________
        $photorec : permet de récupérer les données même si la table de partiion est defectueuse.

            (fait partie du package testdisk)

            > photorec /log IMAGE_FICHIER -d OUTPUT_DIR


	--------------------------------------
	Des tools:
	--------------------------------------

		A vérifier/tester:

			dump : dumper des fichiers du système
			restore : restaurer ces fichiers

			star ; voir ? 

    --------------------------------------
    Graver un cd
    --------------------------------------
        __________________
        $wodim (ou peut s'appeler cdrecord):

            wodim dev=/dev/srX /path/to/iso/file

                exemple:

                    wodim dev=/dev/sr0 install-amd64-minimal-20140116.iso

		__________________
        Sinon passer par un soft graphique tel que K3B, Xfburn
                                

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
IMPRESSIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    -------------------------------------
    le deamon
    -------------------------------------

            __________________
            $cupsd: C'est le scheduler de cups, il permet d'implémenter le IPP (Internet Printing Protocol)

                -F : pour le lancer en background

                Le fichier de conf par défaut est /etc/cups/cupsd.conf

                Par défaut le port d'écoute est le 631

                La configuration de cups est ensuite accessible bia http://localhost:631

                Cups est généralement le système d'impression par défaut des distribution Linux et Mac.

                Il traite en fifo les fichiers dans /var/spool/cups

                Les spécificités des imprimantes sont écrites dans les fichiers PPD (Postscript Printer Description) dans /etc/cups/ppd pour chaque imprimante.
                    On y trouve les config de type : format, recto-verso ...)

                Pour autoriser un utilisateur à ajouter une imprimante, il faut l'ajouter au groupe :
                    
                    lpadmin

    -------------------------------------
    Some tools
    -------------------------------------

        __________________
        $lpstat: permet d'afficher certaine info de cups

            -p [PRINTER] : afficher les infos sur une imprimante ou toutes les lister si non spécifié
            -d : afficher l'imprimante par défaut

        __________________
        $lpr : permet d'imprimer un fichier

            -P PRINTER : permet d'imprimer sur l'imprimante spécifiée
            -# NOMBRE_COPIES : permet d'imprimer plusieurs copies
        __________________
        $lp : permet aussi d'imprimer des fichiers.

            -i JOBS_ID : permet de spécifier  un jobs à modifier
            -q [1-100] : instaurer une priorité

            La différence, c'est qu'il est en frontend par rapport à lpr.
            il invoque donc lpr pour imprimer

            Il dispose cependant de plus d'option et permet de modifier les impressions en attente.
            Ainsi que de contrôller plus spécifiquement la manière d'impression

            D'après le man il n'est pas mentionné de problème de compatibilité avec cups, alors que lpr oui.

        __________________
        $lpq : lister le pool d'impression

            -P PRINTER : spécifier l'imprimante
            -l : augmenter la verbosité
        __________________
        $lprm [JOBS IDS]: permet d'annuler une impression 

            Si rien est spécifié: pour l'impression en cours sur l'imprimante par défaut
            - : permet d'annuler toutes les impressions
            -P PRINTER : permet d'annuler pour l'imprimante spécifiée
                        
        __________________
        $cancel : idem que lprm, il sert à annuler un job en cours

            -a : pour annuler les impressions sur toutes les imprimantes

            les options sont à peu près similaire à lpr
                

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Alias
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Un alias est un raccourcis commande.
	Ecrire les alias dans le .bashrc pour les garder en mémoire. 

	__________________
	$alias : liste les alias disponibles

	Créer un raccourci : alias <Nom_Raccourci>='<commande>'
		exemple:
			alias path='pwd'
			alias hello='echo "hello world"'

		

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ENCODAGE // ASCII // UNICODE // UTF
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        http://unicode-table.com/en

        voir locales (gentoo)

        [ CTRL + MAJ + u  ]  N°HEXA_UNICODE : permet de saisir un caractère spécial de la table Unicode

        __________________
        $ascii : affiche la table des caractères en ascii

        __________________
        $locale  : affiche divers informations concernant les formats de l'environnement local.

               -a : Affiche toutes les valeurs possible.

               Par exemple pour changer l'encodage du shell courant:
                
                        > locale -a  #Choisir la valeur souhaitée
                        > LANG="Ma valeur choisie"
        __________________
        $dos2unix : permet de convertir un fichier sous format unix (suppression des caractère dos cachés)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GUI
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  	__________________
	$notify-send 	: Envoyer un message d'information sur le bureau
			-i : selectionner un icone
			-t : définir le temps d'affichage (en ms)

		exemple!

		> notify-send -i gtk-dialog-info -t 9000 "Warnings" "Hello"
	
             

===================================================================================
MANUEL SYSTEME LINUX in works.. will be merge with commands linux
===================================================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DRIVERS 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	$ndiswrapper : permet d'utiliser les pilotes windows pour linux
			
		-i pilote.inf  	#installer un pilote
		-l 		#liste les pilotes supportés
		-m		#Générer le fichier de conf /etc/ndiswrapper/...

		On lance généralement un depmod -a pour regénérer les dépendances entre modules.
		Puis un modprobe ndiswrapper pour le charger.
		
		Pour une carte wifi, on vérifiera avec iwconfig
		

	Site internet de base de données de compatibilité materielle linux:

	 Liste de compatibilité Novell : http://cdb.novell.com/index.php?LANG=en_UK 
	 Liste de compatibilité openSUSE : http://en.opensuse.org/HCL 
	 Imprimantes : http://www.linuxprinting.org 
	 Scanners : http://sane-project.org/ 
	 Périphériques USB en général : http://www.qbik.ch/usb/devices/ 
	 Cartes son : http://www.alsa­project.org/ 
	 Les cartes Wi­Fi : http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/ 
	 Modems internes ou externes de type Windomem : http://linmodems.org/ 
	 Webcams : http://www.linux.com/howtos/Webcam­HOWTO/hardware.shtml 


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
LES DISTRIBUTIONS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Debian : distribution réputé, stable et 100% open source. Elle utilise APT comme logiciel d'installation qui est tres pratique et performant. Elle a par contre l'inconvénient de ne pas être tres à jour.

Ubuntu : dérivé de Debian, elle est simple et permet une utilisation graphique poussée. C'est une distribution faite pour les débutants.

RHEL : Red Hat Enterptise Linux, fait pour les professionnels et les gros serveurs, c'est une version stable mais payante (facture du support) 100% libre.

Fedora : basé sur du Red Hat, Fedora est utilisé plus par le grand public.

Mandriva : Dérivé aussi de Red Hat, une version qu'on retrouve plus dans la portabilité.

openSUSE : basé sur Slackware, tres grande simplicité d'installation, d'administration et d'utilisation. libre et gratuite. Une version stable est proposée tout les 8 mois environ

Et encore plein d'autres ...


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
L'AIDE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<commande> --help   : donne une aide propre à la commande (parfois trop dépouillée)

help <commande>     : idem mais cette fois l'aide viens du shell

man commande        : donne le manuel de la commande (complet)

	------------------------------------
	Manuel:
	------------------------------------
	
	forme d'un manuel:

	Nom : nom et rôle de la commande. 
	Voir aussi : liste des commandes liées au programme qui peuvent intéresser l’utilisateur.

		Synopsis : syntaxe générale, paramètres et arguments acceptés. 

		Description : mode d’emploi détaillé du fonctionnement de la commande et des arguments principaux. 

		Options : description détaillée de chaque paramètre possible, généralement sous forme de liste. 

		Exemples : le manuel peut fournir des exemples concrets d’utilisation de la commande. 

		Environnement : le fonctionnement de la commande peut réagir différemment si des variables du shell sont positionnées à certaines valeurs. 

		Conformité : la commande est conforme à des recommandations ou normes (par exemple POSIX).
		 
		Bogues : la commande peut parfois rencontrer des dysfonctionnements dans des cas ponctuels qui peuvent être énumérés à cet endroit. 

		Diagnostics/retour : la commande, selon son résultat, peut retourner des codes d’erreurs significatifs dont la valeur permet de déterminer le type de problème (fichier en argument absent, etc.). 
		
		____________________
		Section d'un manuel:

		Par défaut lorsqu'on fait un man d'une commande, il va ouvrir la section 1.

		pour utiliser une autre section:
		man <N°section> <commande>


			Section 	Contenu 
			
			1  		Instructions exécutables ou commandes du shell 
			2 		Appels système (API du noyau...) 
			3  		Appels des bibliothèques (fonctions C...) 
			4  		Fichiers spéciaux (contenu de /dev comme sd, hd, pts, etc.) 
			5  		Format des fichiers (/etc/passwd, /etc/hosts, etc.) 
			6  		Les jeux, économiseurs d’écran, gadgets, etc. 
			7  		Divers, commandes non standard, ne trouvant pas place ailleurs 
			8  		Commandes d’administration du système Linux 
			9  		Sous­programmes du noyau (souvent vide)
			

		man -k <occurence> : recherche toute les commandes liées à cette occurence.






~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NAVIGUER
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

barre d'espace   : défile une page complète
[Entrée]         : défile ligne par ligne
[Haut] et [Bas]  : défile d'une ligne
[Début] et [Fin] : début et fin :-)
[Pageup] [Pagedown] : défile d'une demi/page
/<mot_recherché> : faire une recherche
[q]              : quitter

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
KERNEL
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------------------
	MODULES
	------------------------------------

                http://doc.ubuntu-fr.org/tutoriel/tout_savoir_sur_les_modules_linux
		____________________
		$lsmod : affiche les modules actif du noyau

		____________________
		$modprobe MODULE : active un module 

                        -a : charger tout les modules correspondant
                        -r : décharger un module
                        -l : lister les modules
		
		____________________
                $depmod : recharger la carte des dépendances des modules
			-a regénérer les dépendances entre modules


		____________________
                $modinfo MODULE: donner des infos sur un module noyau

		____________________
                Modules au démarrage:
                        
                        vim /etc/modules
                                et ajouter ses modules

                        Note: attention à l'ordre, il sont chargé de haut en bas

		____________________
                Blacklister des modules:

                        vim /etc/modprobe.d/blacklist.conf

                                #blacklist MON_MODULE

                        > update-initramfs -u   : pour prendre en compte les changements

		____________________
                Lier un module

                        Pour lier un module à un périphérique pour qu'il se charge automatiquement dès sa detection:
                                vim /etc/modprobe.conf

                                alias DEVICE MODULE

                                exemple:
                                        alias eth0 jme

		____________________
                $modconf : utilitaire de configuration des modules

		____________________
                $module-assistant : permet de créer des packages de modules.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bibliothèques partagées "Shared Objects (.so)"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        librairies, library, lib

        Les bibliothèques sont des fichiers regroupant une liste d'ensembles de fonctions, ou API utilitaires utilisable par tout les programmes.
        Ces fonctions contiennent du code utile que l'on ne désire pas avoir à réécrire à chaque foi (exemple: calcul de cosinus, inversion d'une matrice...)
        Les bibliothèques regroupes les fonctions par domaine (traitement d'image, accès à uune base de données ...)

        Un ensemble de fonctions proposées par une ou plusieurs bibliothèques partagées forme une API (Application Programming Interface), et son parfois regroupées au sein d'un framework donnant une solution complète pour un domaine donné.

        Un lien est établi entre le programme et la bibliothèque lors de l'édition des liens par l'éditeur de liens (ld), appelé par le compilateur gcc avec l'option -l<lib>

        Il est aussi possible que le programme utilise la fonction "C dlopen" pour ouvrir la bibliothèque et accéder aux fonctions grâce à des pointeurs de fonctions.

        Il est aussi possible qu'une bibliothèque dispose de plusieurs versions. Cette version peut être précisée lors de l'édition des liens.

	------------------------------------
	LIEU DE STOCKAGE 
	------------------------------------

                /lib : bibliothèques system de base, vitale;
                /usr/lib : bibliothèques utilisateur de base, (pas nécessaire au boot);
                /usr/local/lib : bibliothèques locales aux produits de la machine;
                /usr/X11R6/lib : bibliothèques de l'environnement X window;
                /opt/kde3/lib : bibliothèques de KDE ... 
                
                la bibliothèque la plus importante est celle du "C" :
                        libc.so
                        
                Les répertoires des SO contiennent beaucoup de liens symboliques pour gérer les versions et la compatibilité entre ces versions.
	
	------------------------------------
	Bibliothèques liées 
	------------------------------------

                Pour connaître les bibliothèques liées à un programme
                        $ ldd <soft>
                        
                Si une bibliothèque est manquante, la mention "not found" s'affichera, le programme ne sera pas executable.
	
	------------------------------------
	Cache de l'éditeur de liens 
	------------------------------------
	
                Le binaire fournit le nom des bibliothèques à lier à l'execution.
                Il utilise le bibliothèque ld.so pour connaitre les path des bibliothèques.
                Tout programme est lié au chargeur de lien ld.so (ld-linux.so)
                
                ld.so recherche les bibliothèques dans cet ordre:
                        -Les path précisés dans la variable d'environnement LD_LIBRARY_PATH (séparé par des ":")
                        -dans /etc/ld.so.cache qui contient une liste compilée des bibliothèques trouvées dans les path prédéfinis;
                        -Les repertoires /lib et /usr/lib
                        
                        
                ld.so propose un cache que l'on peut modifier, il se refere au contenu du fichier /etc/ld.so.conf (contient la liste des repertoires contenant les SO) et la commande ldconfig 
                
                Plutôt que de modifier ce fichier, on peut rajouter un fichier dans /etc/ld.so.conf.d qui contiendra les paths des nouvelles bibliothèques.
                        --> il faut ensuite regénérer le cache avec ldconfig:
                        
                ldconfig:
                        -met à jour le cache pour les chemins dans /etc/ld.so.conf et associés, ainsi que pour /usr/lib et /lib;
                        -maj les liens symboliques sur les bibliothèques;
                        -peut lister les bibliothèques contenues dans le cache
                
 
		____________________
                $ldconfig 
                        -v : mode verbeux
                        -N : Ne reconstruit pas le cache
                        -X : Ne met pas à jour les liens
                        -p : Liste le contenu du cache (liste les bibliothèques connues de l'éditeur de liens.)
                        
                        pour voir ce que ferait ldconfig sans rien mettre à jour: $ ldconfig -N -X -v
                        
                        pour maj et voir le résultat: ldconfig -v
		
		
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SHELL
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------------------
	L'invite de commande
	------------------------------------

Le shell est un interpréteur de commande et fonctionne au sein d'un terminal.
Un terminal dispose d'une invite de commande (= prompt = ligne de saisie) où l'on entre les instructions au clavier. Cette ligne affiche plusieurs informations:

	User@Host:Path$ ou > ou #
		
		>, $: droit d'utilisateur
		#: droit root
		
	------------------------------------
	Raccourcis && commande
	------------------------------------
		
	voir le memo_commandes pour un aperçu des commandes et des raccourcis

	------------------------------------
	Commandes internes et externes
	------------------------------------
	
	externes: commandes de type binaires et lancé en tant que processus
	internes: comme cd, pwd et echo, ces commandes sont propres au shell.
	alias: raccourcis d'une commande
	
	>type <commande> : permet de différencier le type de commande.


	------------------------------------
	Historique
	------------------------------------
	
	Utiliser les flèches du haut ou du bas pour voir les dernières commandes.

	L'historique se trouve dans le fichier .bash_history
	
	affichage avec 'history'
	
	ou
	
	>fc -l (affiche les 15 dernières commandes)
	>fc -l -XX (affiche les XX dernières commandes)
	>fc -s <N°commande> : lance la commande indiqué
	>fc -s fc=<commande> <N°commande> : remplace l'ancienne commande du N° indiqué par la nouvelle.
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Audio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    player (console)

        mpg132
        mplayer

    player graphique:
        
        audacity
        vlc
        gnome-mplayer 
        ...

    Tester:
        speaker-test

    Convertir:
        soundconverter
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Gestion des fichiers 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Il faut savoir que linux & Unix sont des FS (File system) orienté fichier, c'est à dire que tout (ou presque) est représenté par un fichier (périphériques, données, sockets ...).

Attention, l'extension des fichiers n'est pas un critère de reconnaissance pour Linux!

	------------------------------------
	Les types de fichiers
	------------------------------------

		____________________
		fichiers ordinaires
		
                        textes; image; audio; binaires compilé; script; bas de données; bibliothèques ...
                        
                        >file <fichier> : permet de différencier le type de fichier.
		____________________
		catalogues
		
                        repèrtoires : permet de créer une hiérarchie 
                        
                        C'est en fait un fichier particulier qui contient la liste des fichiers contenus.
		
		____________________
		fichiers spéciaux

                        Principalement dans /dev
                        
                        Ils servent généralemnt d'interface pour les divers pépiphériques et redirige directement les accès en écritures ou lectures.
                        Par exemple si on redirige un fichier d'onde (wave) vers le fichier représentant la sortie de la carte son, ce son devrait être audible!
		
	------------------------------------
	Nomenclature des fichiers
	------------------------------------

                Ne pas dépasser 255 caractères (actuellement)
                Linux respecte la casse
                Eviter d'utiliser des symboles qui ont une signification pour le shell comme &, ", ~ ...
	
	------------------------------------
	Les chemins (path)
	------------------------------------
		____________________
		chemin relatif

                        path depuis sa position courante
                        
                        . : représente sa position courante
                        .. : représente le répertoire de niveau inférieur
		
		____________________
		chemin relatif
		
                        path depuis la racine /
		
	~ : représente le repertoire personnel
	identique à $HOME
	
	> cd : (sans argument, il ramène directement au repertoire personnel)
	
	------------------------------------
	Fin d'arguments
	------------------------------------
	
	Certaine commandes comme rm ne peuvent pas traiter les fichiers qui commencent par un "-", celui ci sera interprété comme une option.
	
	Il faut donc utiliser l'option
	
	"--" ou "./" qui signifie la fin des paramètres
	
	exemple:
		rm -f -- -file
		rm -f ./file
	
	
	------------------------------------
	Liens Symbolique
	------------------------------------
		
	Le lien symbolique est un alias qui pointe sur n'importe quel fichier (existant ou non (exemple : une clé usb)). Ce lien est interprété de la même manière que le fichier sur lequel il pointe.
	La suppression du lien ne supprimera pas le fichier d'origine.
	
		repéré par un "l" (lors un ls -l)
		
	------------------------------------
	Wildcards (caractères de substitution)
	------------------------------------
	(voir aussi mémo sur les regex)
	
	Voici comment le shell interpréte ces caractères:
	
	* : Remplace une chaîne de longueur variable, même vide
	? : Remplace un caractère unique quelconque
	[...] : Une série ou une plage de caractères
	[a-b] : Un caractère parmi la plage indiquée (de a à b inclus)
	[!...] : Inversion de la recherche
	[^...] : Idem	
	
	
	exemple: 
		ls *[!s] : affiche tout les fichiers qui ne terminent pas par "s"
		cp Documents/*/README : copie tout les README des sous-dossiers de Documents.	
		
	------------------------------------
	Vérouillage des caractères 
	------------------------------------
	
	\ : verouille un caractère unique:
		ls hello\ *.txt : liste tout les fichiers contenant un espace apres hello et finissant par .txt
		
	"..." : les guillement permetent d'intèrpréter les caractères spéciaux comme des variables ... au sein d'une chaîne
	
	'...' : les apostrophes vérouillent tous les caractères spéciaux dans une châine ou un fichier. 
	
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Images/Vidéos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	------------------------------------
	Webcam
	------------------------------------
		____________________
        $cheese : un outil pour prendre des vidéos et des photos avec une webcam

                voir:
                        ffplay -f v4l2 -i /dev/video0
                        gstreamer-properties
                        gnome-media


	------------------------------------
	Imagemagick
	------------------------------------

        http://doc.ubuntu-fr.org/imagemagick

        apt-get install imagemagick

        Un package contenant plusieurs outils pour la retouche d'image

		____________________
        $display : afficher une image
        
		____________________
        $convert : convertir une image
		
		____________________
        $mogrify : modifier/resizer une image
		
		____________________
        $identify : donne des infos sur l'image

		____________________
        $import : capture d'écran

		____________________
        $animate : visualiser/diapo d'image

		____________________
        $compare : créer une image à partir de deux autres

		____________________
        $composite: assembler des images

	------------------------------------
	Vidéos
	------------------------------------
		____________________
        $ffmpeg : conversion/manipulation de vidéos

            Via les sources:

                > sudo git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg
                > sudo ./configure --help
                > sudo make
                > sudo make install

            Par le PPA:

                > sudo add-apt-repository ppa:jon-severinsson/ffmpeg && sudo apt-get update -qq
                > apt-get install ffmpeg

            http://doc.ubuntu-fr.org/ffmpeg
            http://korben.info/ffmpeg-pour-les-nuls.html

		____________________
        $avconv : for du projet ffmpeg

            http://doc.ubuntu-fr.org/avconv

            > apt-get install libav-tools


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Représentation des Disques
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Chaque disque/partition est représenté par un fichier spécial de type bloc.

        IDE: hdx
        SCSI, SATA, USB, FIREWIRE ...: sdx
        Il existe des cas spéciaux qui ne respectent pas cette nomenclature (RAID ...)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulation de bas niveau
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Avec la commande hdparm, il est possible d'effectuer des manipulations sur les périph géré par la lib: libata. (SATA, ATA (IDE) et SAS.
	Pour les disques SCSI, voir la commande sdparm.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Choisir un système de fichier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	formater = créer sur un support de mémoire, l'organisation logique des données.
		Sous linux on parle plutôt de système de fichier!

	La représentation à pour but de donner à l'utilisateur une vision structurée de ses données.

	Méta-données: ce sont les propriété d'un fichier (inode pour linux)
		On y trouve:
			-les droits, les détes d'accès et modif, le propriétaire et le groupe, la size, nbre de blocs utilisés,
			le type de fichier, le compteur de liens, un arbre d'adresses de blocs de données.

	Nom de fichier: longueur max: 255 carac
		Les noms de fichiers linux sont placés dans une table de catalogue.
	MIME type: il est défini dans les premiers octets du fichier et indique le contenu d'un fichier (l'extension)

	Le journal:	trace tout les changements intervenus avant de les effectuer réellement. En cas de coupure du systeme,
			le système pointe les enregistrements du journal et vérifie si les opérations ont été effectuées. Eventuellement, 
			il les rejoue. Le journal contient des informations atomique (n opération indivisibles) et donc même si celui-ci
			est incomplet, la cohérence des données est assurée soit par complétion du journal si c'est possible, ou
			par retour en arrière.

	Les filessystems:
		ext2:	le premier system de fichier dev pour linux, (il n'est pas journalisé)
			Rapide et nécéssite peu d'écriture. (peu être utilse pour les SSD)
			taille max d'un fichier: 2To, partition: 32To

		ext3: successeur du ext2, il est journalisé (les tailles fichier et partitions sont identiques.)

		reiserfs: Premier system de fichier intégré à Linux avant ext3
			Sa force vient surtout de l'organisation indéxée des entrées des répertoires.
			(Les tables catalogues contenant les association inodes/fichiers) et la manipulation
			des fichiers de petite taille.
			Très bonne performance en présence de milliers de fichiers, de faible à moyen volume.
			Size file max: 8To, partition; 16To , nom de 4032 carac max (mais limité par le VFS de linux à 255 carac)
			[VFS = Virtual Filesystem Switch]

			C'est un filesystem sous utilisé, notament car on ne peut pas le convertir en ext2/3

		xfs:	Le plus ancien des FileSystem journalisés sous Unix:
			Des capacités de stockage énorme. 
			Défragmentation en ligne (à chaud et au fur et à mesure des écritures)
			Snapshots possibles (figer l'état d'un filesystem à un instant t pour le restaurer plus tard)
			Taille max d'un fichier: 8 Eo, partition de 16Eo

		vfat:	(Virtual File Allocation Tablep) : regroupe les diverses version de FAT
			adapté aux petits volumes.
			Simple à adapter
			Compatible entre différentes plateform.
			System de fichier qui se retrouve fortement fragmenté car il tente de regrouper les données d'un fichier
			sur le plus de clusters contigus du support (infos stockés sur une table unique)
			Plus le support à une taille importante, plus FAT est lent (il doit vérifier toute la table pour trouver des clusters dispo)
			FAT : pas de notion de droits 
			Taille max d'un fichier : 4Go
			
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Partitionnement
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	------------------------------------
	Découpage logique
	------------------------------------

		Le partitionnement consiste en un découpage logique du disque.
		Le disque réel est fractionné en plusieurs disques virtuel indépendant.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Systemes d'initialisation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        TODO

	------------------------------------
        System V
	------------------------------------

	------------------------------------
        Systemd
	------------------------------------

                
	------------------------------------
        OpenRC
	------------------------------------
		
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
En cours
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Delta-rpm:

fournis dans le package les différences d'une version à une autre


Commandes:

Dates:

	date : affiche la date actuel
	cal  : affiche un calendrier


Reconfigurer un paquet:

	dpkg-reconfigure <nom_paquet>


Test mémoire:

	utiliser l'outils memtest+  (tester les barettes une par une, le test est assez long)




Association des programmes (Mimetypes):

	copier et éditer le fichier /usr/share/applications/defaults.list
	dans --> /etc/skel/.local/share/applications/mimeapps.list


Désactivation de certains support usb:

	éditer le fichier /etc/modprob.d/blacklist.conf
	--> ajouter une ligne "blacklist <usb_device>"
	--> exemple : blacklist usb_storage

	et dans /etc/rc.local (optionnel)

	ajouter: "rmmod usb_storage"


        --------------------------
        Ecran:
        --------------------------

            Rotation:

                xrandr --output LVDS1 --rotate right (left inverted normal)
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````

            Afficher un programme sur le bon écran:

                DISPLAY=2.0 monProg

==========================================================
                       T I T L E
==========================================================


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
