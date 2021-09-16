=====================================================================
				V I M
=====================================================================


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Tutoriel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    lancer:
            > vimtutor

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Aide
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Affichez le help avec la touche F1
    (:q) pour la quitter

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Editer/créer un fichier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim <NomDuFichier>  : créer ou éditer un fichier

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Comparer 2 fichiers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    vim -d <NomDuFichier1> <NomDuFichier2>  : Comparer les 2 fichiers
        (ctrl + W pour switcher)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Déplacements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Curseur: h (left)       j (down)       k (up)       l (right)

    ________________
    mots :

        w : début du mot suivant
        e : fin du mot suivant
        b : mot précédent

    ________________
    fichiers :

        gg : début du fichier (ou :0)
        G : fin du fichier (ou :$)

    ________________
    lignes :

        0 : début de ligne
        $ : fin de ligne
        :<N> : aller à la ligne N (ou <N>G)
    ________________
    caractères :

        :goto <N> : aller à au carctère numéro N

        % : aller à l'accolade fermante (délimite un bloc)
        * : aller à la prochaine occurence
        # : aller à l'occurence précédente

        f<lettre> : aller jusqu'à la "lettre" suivante (compris)
        t<lettre> : aller jusqu'à la "lettre" suivante (s'arrete juste avant)

        % <(,),[,],{, ou}> : se placer à l'autre symbole correspondant
            -exemple : si on execute % au niveau d'une parenthese "("
                    le curseur se déplacera à la parenthese fermante : ")"

    ________________
    quantifier :

        Toute ces commandes peuvent être "quantifiées":
            exemple:
                2w : allé au deuxieme mots ...


    ________________
    Changer d'emplacement/Défiler :

        <CTRL>+<f> : Avance d'un écran
        <CTRL>+<b> : Recule d'un écran

        <CTRL>+<o> : revenir à son ancien emplacement
        <CTRL>+<i> : revenir à un emplacement plus récent


        <CTRL>+<g> : affiche la ligne courante
        <numéro ligne>+<G> : se placer au numéro de la ligne entrée.

    ________________
    Ecrans splités :

        <CTRL>+<w> (*2) : naviguer d'une fenêtre à l'autre si écran splité ...
        <CTRL>+ <-- ou --> : naviguer de gauche à droite lors d'un écran splité ou d'une comparaison de fichier

        Reesizer ses fenêtres :

            http://vim.wikia.com/wiki/Resize_splits_more_quickly

            :resize X
            :vertical resize X

            X étant compris entre 0 et 100%


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Tabulations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    >> : insérer une tabulation
    << : inversement

    Pour remplacer les tabulations par des espaces :

        :set tabstop=2 shiftwidth=2 expandtab
        :retab

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Insérer du texte (mode insertion)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    i : insertion au niveau du curseur
    I : insertion au début de ligne
    a : insertion au caractere suivant le curseur
    A : insertion à la fin de la ligne
    o : insertion sur une nouvelle ligne (down)
    O : insertion sur une nouvelle ligne (up)

    Quitter le mode insertion : <ESC>


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Quitter/Sauvegarder
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    :q! : quitter et annuler tout les changements
    ZZ : sauve et quitte
    :wq : idem
    :x : idem
    :w <NomFichier> : sauvegarder avec un nouveau nom de fichier
    :w !sudo tee % : sauvegarde en root (si jamais on n'a oublier de l'éditer avec les droits)
    :X,Yw filename : sauve de la ligne X à Y dans le fichier "filename"


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Remplacer un caractere/un mot (mode replace)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    r <Lettre à remplacer> : se placer sur le caractere à remplacer
    R : remplace les caractères tant qu'on ne quitte pas le mode "replace" (<ESC>)

    cw : Remplace le mot courant
    c$ : Remplace jusqu'à la fin de la ligne
    c0 : Remplace jusqu'au début de la ligne
    cf<lettre> : Remplace jusqu'au prochain caractère
    c/<Recherche> : Remplace jusqu'à la prochaine occurence de la "Recherche"


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Suppression
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    x : supprime le caractère sous le curseur
    X : supprime le caractère devant le curseur
    dw : supprime un mot
    d$ : supprime du curseur à la fin de la ligne
    D : idem
    d0 : supprime du curseur au début de la ligne
    dd : supprime toute la ligne

        -S'utilise de la manière suivante:
            operateur <Nombre> mouvement

        -exemple : d5w : supprimer les 5 mots suivants


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Annulation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

u : annule la derniere modification
	U : annule toutes les modifications d'une ligne
		<CTRL>+<r> : annule une annulation


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Copier/Coller/Selectionner
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	couper : utiliser la suppresion (dd coupe une ligne ...)

	p : colle la derniere selection

	y : copier
	yy : copier une ligne
	y2w : copier 2 mots ...

	v : mode selecton, il faut ensuite déplacer le curseur avec les fleches pour selectionner
        V : sélectionner une ligne entière
	Shift + v : idem mais commence par séléctionner toute la ligne.
	Ctrl + v : Selection en block.
        gv : reselectionner le dernier block

		exemple :
                -v pour selectionner
				-y pour copier
				-p pour coller la selection

        Note: pour insérer des caractères dans une section, on utilisera:
            SHIFT + I
            suivi des mots que je souhaite copier
            et enfin ESCP pour copier.

	<CTRL>+y : copier la ligne du dessus (caractère par caractère)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Indenter
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Il faut utiliser les cheuvrons:

	< : indenter à gauche
	> : indenter à droite

	En mode visual:

		En mode visuel, il faut suffit de séléctionner plusieurs ligne et d'indenter:
		X> 	#indent X fois à droite (X étant facultatif)

	Sans le mode visuel:
		X>> 	#indent X lignes une fois à droite


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rechercher
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	/<mot à rechercher>  : nous envoie à la premiere occurrence trouvée apres le curseur.

	Le systeme de recherche fonctionne comme les regex
		exemple:
			/[PpBb]ol : Pol, pol Bol, bol

	n : chercher l'occurrence suivante
	N : chercher l'occurrence précédente

	?<mot à rechercher> : fait de même que "/" mais cherche les occurence avant le curseur (dans l'autre sens)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Substitution
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	:s/old/new : substitue la prochaine occurence, trouvées sur la ligne, "old" par "new"
	:s/old/new/g : substitue toutes les occurences, de la ligne, "old" par "new"
	:#,#s/old/new/g : substitue toutes les occurences, de la ligne # à la ligne #, "old" par "new"
	:%s/old/new/g : substitue toutes les occurences de tout le fichier
	:%s/old/new/gc : de même que précedement mais avec la confirmation

	On peut choisir jusqu'ou on va faire la substiution en mettant un numéro apres c
		c <Nombre> <mouvement>
			exemple:  :%s/old/new/gc2w  (procede jusqu'au deuxieme mots)
			ou 	  :%s/old/new/gc$   (procede jusqu'à la fin de la ligne)

		Note: On peut aussi utiliser les regex.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Executer une commande
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	:!<commande à executer>  : execute la commande

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Lire/Ajouter le contenu d'un autre fichier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    :r <nomFichier> : écrit le contenu du fichier apres  l'emplacement du curseur
    :r! <commande> : écrit le contenu de la commande apres l'emplacement du curseur

    :e <File> : Charge le fichier "File" pour édition
    :é# : Commute entre les divers fichiers ouverts

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Fenêtrage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    <CTRL + w> s : diviser horizontalement
    <CTRL + w> v : diviser verticalement
    <CTRL + w> w : passer à la fenêtre suivante
    <CTRL + w> n : ouvrir un nouveau fichier dans une nouvelle fenêtre

        Suivie de la commande   :e ./
        Il suffit ensuite de se déplacer pour ouvrir un fichier et éxécuter des copier/coller entre fenêtre.

    <CTRL + w> q : fermer la fenêtre


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Aide
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    :help ou <F1> : lancer l'aide de vim
    :help <commande> : lancer l'aide sur la commande

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
AutoComplémentation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Commande:

        <début de commande> <CTRL>+<d> : affiche le complément possible au texte entré.
        Utiliser Tab pour l'autocomplémentation d'une commande

    Texte (en mode insertion):

        <CTRL>x + <CTRL>f : autocomplémente en utilisant le path
        <CTRL>x + <CTRL>n : autocomplémente en utilisant les mots présents dans le fichier

            Peut s'utiliser sans le CTRL + x

        <CTRL>x + <CTRL>l : autocomplémente la ligne entière


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration/Options vimrc
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

éditer .vimrc dans son dossier personnel
	vim ~/.vimrc

Fichier de congiguration pré-établi:

 :r $VIMRUNTIME/vimrc_example.vim

Si on veut plus de renseignement sur ce fichier pré-fait:
	:help vimrc-intro

________________
Some options:

        set all			: affiche les options possibles

        exemple:

               " ----  General
               set number          " line number
               syntax on           " Activ syntax color
               set history=50      " keep 50 lines of command line history
               set ruler           " show the cursor position all the time
               set showcmd         " display incomplete commands
               " ----  Search
               set hlsearch        " highlight search
               set ignorecase      " ignore the case in a search
               set incsearch       " do incremental searching
               " ----  Cursor
               set cursorcolumn
               set cursorline
               highlight cursorcolumn ctermbg=black
               highlight cursorline cterm=none ctermbg=black
               highlight Number ctermfg=186 cterm=none
               set background=dark
               " ----  Backup
               set backup
               set backupdir=$HOME/.vim/backup/
               " ----  Indent Part
               set expandtab
               set shiftwidth=4   "When pressing '>' and '<'
               set softtabstop=4  "When pressing tab and backspace
               set autoindent     "Keep indent from previous line
               "set smartindent    "Indent in some cases
               "set cindent        "Stricter and more custom as smartindent

               if has ("autocmd")
                   " File type detection. Indent based on filetype. Recommended.
                       "filetype plugin indent on
               endif

               if has('mouse')
                   set mouse=a  "Activation de la souris
               endif"

    ________________
    Enlever une option:

        Rajouter le suffix "no" :
            set nonumber : désactive la numérotation des lignes


            Beacoup d'autre options intéressante mais déja présente dans le fichier vimrc_example.vim
    ________________
    Modifier la coloration syntaxique:

            set filetype=LANGAGE

            exemple:

            set filetype=sh

    ________________
    Affichage:

        :list   : voir les caractères cachés

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Encodage et format
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Exemples:

            Il peut y avoir des petit problème d'encodage,
            Un moyen de reformater son fichier:

            :set fileformat=unix

            Pour l'encodage:

            :set fileencoding=utf8

        Note pour supprimer les caractère génant type ^M
        Il est possible d'utiliser la substitution:

                :1;$ s/\r//g
                :% s/^M/\r/g
                :% s/\r/\r/g

        Afficher les caractères cachés:

                set list |set nolist

                Jouer avec la variable listchars pour le formatage

          Exemple :

            :set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
            :set list

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CHIFFRER
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Note:

    Attention à la sécurité de vim, effectivement entre le backup, le swp et la mémorisation du dernier emplacement, ce dernier n'est pas très sécurisé par défaut.
    Il est possible de supprimer tous ces mécanismes et inclure un chiffrement:


    TODO:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
TIPS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    ________________
    Commenter/Décommenter plusieurs lignes:

        On selection avec CTRL + v
        On passe en mode insert avec SHIFT + I
        On écrit #
        Puis on termine avec ESCP

        Le caractère # s'écrit sur toutes les lignes selectionnées.

        Note: pour décommenter, il suffit de selectionner avec CTRL + v et apuuyer sur 'x' pour supprimer.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plugins
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Lien avec des plugins simpa :

        http://artisan.karma-lab.net/vim-plugins-indispensables

    Pour ajouter un plugin, il suffit d'ajouter les fichiers correspondant dans :

        ~/.vim/plugin
        ~/.vim/doc

    Tocdown : Un plugin pour avoir les headlines mkdown sur un écran splité :

        http://www.vim.org/scripts/script.php?script_id=3856

        Voir aussi le projet :

            https://github.com/plasticboy/vim-markdown#commands

    Taglist :

        Pour avoir le support des sommaires de plusieurs langages sur un écran splité :

            http://vim.sourceforge.net/scripts/script.php?script_id=273
