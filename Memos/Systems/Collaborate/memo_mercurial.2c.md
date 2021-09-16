==========================================================
		M E R C U R I A L
==========================================================
~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://mercurial.selenic.com/guide
    http://mercurial.selenic.com/wiki/Tutorial

    UI:
        http://devblog.virtage.com/2011/04/en-mercurial-web-interface-up-and-running-in-5-minutes/

    Comparaison commandes avec git:

        http://mercurial.selenic.com/wiki/GitConcepts

~~~~~~~~~~~~~~~~~~~~~~~~~~
Layout
~~~~~~~~~~~~~~~~~~~~~~~~~~

         _______________  pull	 _______________   up	 _______________
        |  REPO EXTERNE	|----->	| REPO LOCAL    |-----> | WORKING DIR 	|
        | historique    | <-----| copie de l'   | <-----|Modifs locales |
        |   des sources | push  |   historique  |  ci   |               |


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Install du package
        --------------------------

                > aptitude install mercurial

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Editer .hg/hgrc de manière suivante:

        ou encore pour l'avoir au niveau de l'utilisateur:

        vim ~/.hgrc

        Note: ne pas mettre le path ! qui lui est différent pour chaque projet.

	#############################START####################################
	[paths]
	default = ssh://name@host//path/to/repository

	[ui]
	username = Prenom Nom <mail@webmail.xx>

	[diff]
	# Use the simpler and more accurate git format by default.
	# (keeps track of file mode changes, etc..)
	# /!\ Enable this if you plan to use Mercurial Queues (see below)
	git = True

	[extensions]
	#enable "hg glog" 
	hgext.graphlog = 
	# enable "hg rebase" 
	#hgext.rebase =
	# see [pager] below
	hgext.pager =
	# enable coloured output
	hgext.color =
	# If you want to use mqueues. Includes the "strip" command.
	# See http://mercurial.selenic.com/wiki/MqTutorial
	hgext.mq =
	# Enable "hg view" to display the repository in a Tk interface (very
	# similar to gitk
	#hgext.hgk =
	transplant =
	#hgk=/usr/lib/python2.7/dist-packages/hgext/hgk.py

	[hgk]
	path=/usr/share/mercurial/hgk

	[pager]
	# use less as a pager
	# - automatically quit if it fits on the screen (-F),
	# - do not wrap long lines (-S),
	# - allow ANSI colour escapes (-R),
	# - do not clear the screen on exit (-X, needed with -F)
	pager = less -FSRX
	# automatically pipe through $pager above for the following commands
	attend = log, glog, diff, gshow, tip, qdiff, blame

	[alias]
	# make an alias that behaves very much like git's "show".  There's
	# already a command named "show" in hg (that does something completely
	# different), so I'll name it "gshow".
	gshow = log -pr
	resolved = resolve -m
	# Handy Mq alias
	#qlist = qseries -s

	[color]
	status.modified = magenta bold
	status.added = green bold
	status.removed = red bold
	status.deleted = cyan bold
	status.unknown = blue bold
	status.ignored = black bold

	# Nice Mq qseries colours
	#qseries.applied = green
	#qseries.unapplied = black bold
	#qseries.missing = red

	#############################END####################################
        --------------------------
        Outils de gestion des merges
        --------------------------

            http://mercurial.selenic.com/wiki/MergeToolConfiguration

                __________________________
                Méthode interne avec les markers:

                    [ui]
                    merge = internal:merge
                __________________________
                Activer vimdiff pour les merges:

                    http://mercurial.selenic.com/wiki/MergingWithVim

                    [ui]
                    merge = vimdiff

                    [merge-tools]
                    vimdiff.executable = vim
                    vimdiff.args = -d $base $local $output $other +close +close

                    A essayer: (from http://jamesmurty.com/2011/05/06/vimdiff-three-way-merges-in-mercurial/)

                        [merge-tools]
                        vimdiff.executable = vim
                        vimdiff.args = -d -c "wincmd J" "$output" "$local" "$other" "$base"

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Repo
        --------------------------
                __________________________
                Créer un repo vierge:

                    > cd mon_repo
                    > hg init
                    
                __________________________
                Importation:

                    Importer le repo: 
                            hg clone ssh://user@host//path/to/repo

                            en locale:

                                > cd /home/repo
                                > hg clone repo_ext

                                Note: il n'existe pas de notion et bare et non bare avec mercurial.

                                Mais lorsqu'on initialise un repo avec hg init sur un serveur, on peu le considérer comme un repo bare.

                    Pour n'importer qu'une branche (et ses parentes):

                        > hg clone -b maBranche monRepo

                __________________________
                Update:

                    > hg up                 : permet d'appliquer les changements du dernier commit de la branche courante
                            -C              : permet de revenir sur le dernier commit de la branche courante en annulant les modifications
                            -r REVISION     : permet de se placer sur une révision particulière

                            Note: le numéro de révision peut être:
                                -un nom de branche
                                -un tag
                                -le premier numero d'un changeset
                                -un changeset
                                -un bookmark

                    Note pour se remettre en mode 'bare' (sans fichier sources à voir directement):

                        > hg up null

                __________________________
                Update du repo local (DOWN)

                    faire les vérifs de commit !

                    > hg pull [ssh://login@host//path]	pour down le dernier commit du repo racine
                    > hg up					pour prendre en compte les modifs
                    > hg merge				Si on a fait des modif, permet de fusioner 

                __________________________
                Update du repo racine (UP)

                    > hg status 					voir si il a des nouveaux files (entre dernier commit et la version en cours)
                    > hg add [FILE]					pour tracker/ajouter les nouveaux files, sans argument = ajoute tout les fichiers;
                    > hg addremove 					ajoute les nouveaux fichiers et enlève ce qui manquent.
                    > hg rm [FILE]					supprime les fichiers manquants.
                    > hg ci -m 'Messages' -v			créer un nouveau commit
                    > hg push [repo]				envoie le dernier commit au repo (si non renseigné, lit le fichier de conf)

                    (faire un hg up si différent du repo racine)

        --------------------------
        Branches
        --------------------------

            hg help branches 
                __________________________
                Se placer dans la bonne branche:

                    > hg branches : liste les branches disponibles
                    > hg branch : liste la branch dans lequel on se trouve
                    > hg up <branchName> : se placer dans la branche adéquate (généralement dev)

                __________________________
                Afficher les modifications:

                    Entre deux rev:

                            > hg diff -r REV1 -r REV2

                            exemple:

                            > hg diff -r 8617:e8d50dcd48bb 8420:c6b4408ad93d

                    Entre deux fichiers de deux revisions différentes:

                            > hg diff -r REV1 -r REV2 MON_FICHIER
                            
                            exemple:

                            > hg diff -r 8617:e8d50dcd48bb 8420:c6b4408ad93d file.pm

                    Note:
                            L'ordre des révision à un impacte sur la comparaison.
                __________________________
                Créer une branche:

                    hg branch NEW_BRANCH
                    hg ci -m "added NEW_BRANCH"
                    hg push --new-branch

                __________________________
                Supprimer une branche:

                    se placer sur la branche en question: ($branch)

                            > hg up $branch_to_delete
                            > hg ci --close-branch -m "close $branch"
                            > hg up -C other_branch
                            > hg push

                    Dans le cadre d'un remplacement d'un branche:

                        > hg up old_branch
                        > hg branch new_branch
                        > hg ci -m 'changing to new branch'
                        > hg up old_branch
                        > hg ci --close-branch -m 'this is the end'
                        > hg push --new-branch

                __________________________
                Merger:

                    Permet à une branche de récupérer tout les commits d'une autre autre branche.
                    /!\ Attention la commande merge peut générer des conflits et supprimer des fichiers qui n'existent plus entre la branche courante et la branche mergée.
                
                        #une branche avec une autre:

                            se placer sur la branche accueillant les merges:

                                > hg merge $other_branch

                            avec une révision:

                                > hg merge -r revisionToMerge

                        En cas de conflit:

                            Un fichier .orig est créer et contient le fichier d'origine.
                            Les fichier conflictuels comporte des marqueur à éditer directement.

                            A la main:

                                Editer les fichiers corrompus et enlever le morceau de code non souhaité (en enlevant les balises mercurial)

                __________________________
                Résoudre un merge:

                    > hg help resolve

                    #Afficher les fichier à résoudre:
                    > hg resolve -l 

                    #marquer commer résolu:
                    > hg resolve -m MonFichier

                __________________________
                Transplant

                    Ce module de mercurial permet de diffuser un commit sur plusieurs branches:

                    Il est très pratique pour diffuser seulement une feature sur d'autre branche sans faire de merging.

                    Configuration:

                            Il faut ajouter dans le fichier de conf hgrc la ligne suivante:

                            [extensions]
                            transplant=

                    Usage:

                            -s | --source : permet de puller les patchs d'un repo
                            -b | --branch : permet de puller les patchs d'une branche
                            -a | --all : permet de puller tout les changements (up) sur la branche
                            -p | --prune : passer outre une revision
                            -m | --merge  : merger un commit
                            --parent : parent à choisir lors de la transplantation
                            -e | --edit : permet d'éditer les messages des commits
                            --log : ajoute les infos de transplant au prompt
                            -c | --continue : permet de reprendre une transplantation apres avoir réparer les problèmes manuellement.
                            --filter : filtrer les commit à travers un FICHIER
                            --mq : opérer sur un repo particulier (?? pas testé :p)

                    Exemple:
                            
                            On commit sur une branche 2.0 et l'on souhaite récupérer ce commit sur la branche 3.0 :
                            
                            > hg glog 	        # on récupère le n° de commit (apres les ':' sur la ligne du changeset; exemple: c44a67e8e676)
                            > hg up 3.0 		# on se place dans la branch ou l'on veux récupérer le commit
                            > hg transplant c44a67e8e676   # on pull le commit

                            en cas de fail (patch failed to apply), il faut éditer le fichier qui a merdouillé (que l'on trouve à la ligne saving rejects to file FILE.rej) et appliquer les modifs contenues dans ce fichie.

                            Ensuite:

                            > hg transplant --continue   # on continue le dernier transplant après avoir réparer le problème
                            > hg ci			# Puis on commit le changement.
                            > hg glog        	# pour vérifier

                    Méthode plus safe:

                            > hg transplant N°COMMIT
                            > hg diff > /tmp/patch
                            
                            controler son patch, si on le modifie:

                            > hg up -C
                            > hg patch /tmp/patch

                            Puis on commit

                            > hg ci -m "MESSAGE"
                            > hg push

                            On vérifie:

                            > hg glob 
                __________________________
                Rendre actif une branche:

                    hg branch --active

        --------------------------
        Track
        --------------------------

            Tracker un fichier (l'ajouter au repo)

                > hg add monFichier

                tous:

                    > hg add

            Untracker un fichier du repo (supprimer du repo)

                > hg rm monFichier

                tous:

                    > hg rm -A 

        --------------------------
        Bookmarks
        --------------------------

            Les bookmark sont des références sur des commits pouvant être automatiquement mis à jour quand des commit ont lieu.

            On peut les utiliser comme alternartive aux branches nommées.

            Plus simplement un bookmark est une révision nommée.
            Permetant d'update et d'auditer plus facilement son code.

            /!\ le bookmark n'est pas pushé, il est personnel. (sauf si explicitement demandé)

            un bookmark ne créer pas de révision à contrario d'un tag ou d'un ci sur une branche nommée.

                __________________________
                Afficher les bookmarks:

                    > hg bookmarks
                __________________________
                Créer un bookmark:

                    sur le changeset courant:

                    > hg bookmark MON_BOOKMARK
                    > hg bookmark -r N° revision bookmark

                __________________________
                Se placer sur un bookmark:

                    > hg up monBookmark

        --------------------------
        Tags
        --------------------------
            /!\ http://mercurial.selenic.com/wiki/CvsConcepts#tag

            Un tag permet de mettre un label sur une revision.
                __________________________
                Créer un tag:

                    > hg up maBranche
                    > hg tag monTag
                    > hg tag -r maRevision monTag

                __________________________
                Afficher les tags:

                    > hg tags
                
        --------------------------
        Commit
        --------------------------

            Pour les commits, ne pas oublier de renseigner le champs [ui] dans le fichier hgrc
                __________________________
                Vérifications:

                    > hg in : voir si il y de nouveaux commit à puller (down du repo racine -> local)
                    > hg out : voir les commit qui seront pushés

                    > hg tip : voir le dernier commit du repo local (le dernier changeset)
                    > hg parent : voir le changeset actuel dans lequel on se trouve

                    > hg status : voir si il ya de nouveaux fichier sur le repo local actuel et le dernier commit local

                        Note: pour voir uniquement les fichiers impactés entre deux commit:

                            > hg status --rev 19:91dbdc19af3a --rev 22:22b88e14e6e6


                    > hg heads MY_BRANCH : affiche le dernier commit de la branche souhaitée.

                __________________________
                Logs:

                    Les logs concernes les modifications et dates de commits apportés dans le repo:

                    > hg log                        : dump tout les commits effectués
                            -p                      : afficher les modifs en plus (les patch)
                            --date 08/02/2013       : Trier par date de commit
                            -b                      : Filtrer sur une branche particulière
                            -b $BRANCH -l1          : voir le dernier commit d'une branche

                    Sur un seul fichier:

                        > hg log monFichier


                    > hg glog                       : idem que hg log mais avec l'arborescence des versions en plus

                __________________________
                Patcher:

                    > hg status : 				Pour ajouter les nouveaux fichiers
                    > hg add [FILE] :		                Si on veux ajouter les nouveaux fichiers
                    > hg diff : 				voir toute les modif (entre le dernier commit local et la version en cours)
                    > hg diff > tmp/patch_file  :  		pour avoir un fichier comprenant toutes les derniers modifs

                    Note: si le commit à déja été fait:

                        > hg diff -r Branch1 -r Branch2

                    Appliquer la patch:

                    > hg patch --no-commit /path_to_patch

                __________________________
                Envoyer un commit

                    > hg status (bon reflex à avoir)
                    > hg in (idem, pour vérifier qu'il n'y a pas eu déja de nouveaux commit et si bersoin, merge)
                    > hg ci -m 'Messages de notification à mettre'
                    > hg push  (utilisera le path du fichier de conf)

                    (au préalable regarder si il n'y a pas eu un autre commit entre temps ! Avec un hg in par exemple.)

                    Pour commiter uniquement un ou des fichier, il suffit de rajouter leur path:

                    > hg ci /monfichier1 /monfichier2 -m "blabla"
                    > hg push
                __________________________
                Backporter

                    le backport est différent selon chaque cas, dans le meilleur des cas un simple transplant suffit.

                    Backporter des éléments d'un FICHIER/FOLDER entre deux branches:

                            > hg up MA_BRANCHE_A_COMPARER (celle qui sert de référence)
                            > hg diff -r BRANCH_NAME FILE|FOLDER_NAME

                            exemple:

                            > hg up 1.0
                            > hg diff -r 2.0 /myfolder > /tmp/mon_patch

                            Il suffira ensuite d'éditer le patch et de l'appliquer à la branche 2.0. 
                            Puis on commit ;)
                __________________________
                Détruire le dernier commit

                    > hg strip n°changeset

                    Note le strip necessite d'activer l'extension mq.

                    Il ne s'applique pas au repo partagé, mais seulement aux modifs locales de son workdir.

                    Il vaut mieux utiliser rollback pour effectuer un 'add' dans l'historique.

                __________________________
                Annuler l'effet d'un ou plusieur commit

                    http://mercurial.selenic.com/wiki/Backout

                    > hg backout -r REV

                    cela va créer une nouvelle branche à partir du changeset donné dans les commit réalisé depuis cette révision.

                    =~ revert --all + merge


        --------------------------
        Backup
        --------------------------
                __________________________
                Supprimer un commit:
                    
                    > hg strip monCommit

                __________________________
                En cas d'erreur (être prudent avec cette commande car elle ne peut pas être annulé)

                    > hg rollback           : Permet de revenir sur la dernière "transaction" en date (commit, import, pull, push, unbundle)

                __________________________
                Annuler toutes les modifications depuis un changeset (attention ne change pas la version du ci actuel)

                    > hg revert [Fichiers]       : à pour effet d'annuler toute les modifications apporté au commit courant

                            --all           : s'applique à tous les fichiers du repo
                            -r              : permet d'annuler les modifications faites du commit actuel jusqu'au changeset donné.
                            -n              : permet de voir ce que ferait la commande.

                            Enfin il est possible de renseigner un File ou un Folder pour annuler les modifs et forcer la maj des fichier à l'identique du dernier commit.
                                    exemple:
                                    > 	hg diff > pasbien
                                    >	hg revert pasbien

                            exemple commun:

                                    > hg revert --all -r 4224e6ac891e
        --------------------------
        Subrepo
        --------------------------

            http://mercurial.selenic.com/wiki/Subrepository?action=show&redirect=subrepos
            http://www.fogcreek.com/kiln/training/using-mercurial-subrepositories/

            Ce module permet à mercurial de gérer les sous repo d'un repo.
            Cela peut être pratique pour découper de façon logique un projet.

            exemple de création de sous-repo:

            #création de l'arborescence:
                mkdir -p software/project
                mkdir software/libs

                /!\ cette vision n'est pas conseillée, il est préferable de mettre les sous au projet niveau de l'arborescence.

            #Initialisation des repo
                cd software && hg init
                cd project && hg init
                cd ../libs && hg init

            Création du fichier hgsub dans le repo parent:
                cd ../
                echo project = project > .hgsub
                echo libs = libs >> .hgsub
                hg add .hgsub
                hg ci -m 'add hgsub'

                Note, le fichier hgsub permet de connaître le path d'un repo.
                Il est possible d'utiliser la syntaxe avec ssh par exemple:

                vim .hgsub
                    lib = ssh://10.X.X.X//path/to/subrepo
                    
            On ajoute ensuite nos fichiers et effectuons nos commit:

                echo foo project/foo.c
                cd project && hg add foo.c
                hg ci -m 'add foo'
                ...

            Pour importer ensuite toute l'arborescence:

                hg clone software somewhere

            Exemples:

                #Ajout d'un sous-repo:

                hg clone /repo/project localproject
                cd localproject
                echo libs = /repo/libs > .hgsub
                hg clone /repo/libs libs
                hg add .hgsub
                hg ci -m'add subrepo'
                hg push

                Note: créer au niveau du serveur un repo:
                    hg init project/monSubRepo

        --------------------------
        Externals with deps
        --------------------------

            /!\ deprecated, utiliser subrepo à la place !

            http://mercurial.selenic.com/wiki/DepsExtension

            Pour gérer les dépendances externes vers d'autres repo (= svn externals),
            Il existe un module deps:

            __________________________
            Activer le module:

                [extensions]
                hgext.deps =
                # or, if deps.py is not in the hgext dir:
                # deps = /path/to/deps.py

            __________________________
            Création d'un alias:

                hg depalias -t DEP_TYPE aliasName /path/to/externals

                exemple:

                    hg depalias -t hg libfoo /path/to/libfoo

            __________________________
            Lister les alias:

                hg depaliases

            __________________________
            Ajouter une dépendance:

                hg dep aliasName /path/to/externals REVISION

                exemple:
                    hg dep libfoo path/to/foo 697673321305

            __________________________
            Supprimer une dépendance:

                hg depremove

            __________________________
            Voir l'état des dépendances:

                hg -v depstatus

            __________________________
            Commiter ses changements de dépendances:

                hg depci
            __________________________
            Update ses dépendances externes:

                hg depup


        --------------------------
        Hooks
        --------------------------

            http://mercurial.selenic.com/wiki/Hook
            http://hgbook.red-bean.com/read/handling-repository-events-with-hooks.html

            Les hooks permettent de déclencher des script lorsque on execute certaines actions sur le repo.

            On va pouvoir par exemple effectuer une mise à jour sur un outils externes lors d'un commit.
            
            Exemple:

                On place dans son fichier de conf hgrc la section hook et les directives:

                [hooks]
                commit = hookscript

~~~~~~~~~~~~~~~~~~~~~~~~~~
exemple d'arbre:
~~~~~~~~~~~~~~~~~~~~~~~~~~

    TODO

    Pour créer un arbre du type:

    Dev --> Client1 --> preprod
                    --> prod

    #Création de la branche dev
    hg branch dev
    hg ci -m 'added dev branch'
    hg push --new-branch
    hg up dev

    Ajouts de fichiers, ci...

    #Création de la branche client1
    hg branch client1
    hg ci -m 'added client1 branch'
    hg push --new-branch
    hg up client1

    ... 
    Depuis la branche client on merge avec dev.
    Dans chaque sous branche on effectue les merges avec la branche client1

    autre méthode: transplant
    
                    

    @    changeset:   9:8699881839eb
    |\   branch:      dev
    | |  tag:         tip
    | |  parent:      7:49d15a059c26
    | |  parent:      8:45111e5837d5
    | |  user:        paul Prémont
    | |  date:        Mon Oct 27 22:53:09 2014 +0100
    | |  summary:     add filey
    | |
    | o  changeset:   8:45111e5837d5
    | |  branch:      prod
    | |  parent:      6:b1f5027b3103
    | |  user:        paul Prémont
    | |  date:        Mon Oct 27 22:50:23 2014 +0100
    | |  summary:     add filey
    | |
    o |  changeset:   7:49d15a059c26
    |\|  branch:      dev
    | |  parent:      5:859a27a3ff88
    | |  parent:      6:b1f5027b3103
    | |  user:        paul Prémont
    | |  date:        Mon Oct 27 22:49:23 2014 +0100
    | |  summary:     merge
    | |
    | o  changeset:   6:b1f5027b3103
    | |  branch:      prod
    | |  parent:      3:d2b02339372b
    | |  user:        paul Prémont
    | |  date:        Mon Oct 27 22:48:18 2014 +0100
    | |  summary:     add head
    | |
    o |  changeset:   5:859a27a3ff88
    | |  branch:      dev  
    | |  user:        paul Prémont
    | |  date:        Mon Oct 27 22:43:58 2014 +0100
    | |  summary:     add foo.conf
    | |
    o |  changeset:   4:f33226ae5973
    |/   branch:      dev
    |    user:        paul Prémont
    |    date:        Mon Oct 27 22:39:55 2014 +0100
    |    summar

~~~~~~~~~~~~~~~~~~~~~~~~~~
Conversion
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        SVN to MERCURIAL
        --------------------------

            Deux manières:
                non off mais plutot chouette:
                    hgsubversion
                off:
                    ConvertExtension
                __________________________
                via hgsubversion:
                    http://mercurial.selenic.com/wiki/HgSubversion

                    hg clone http://bitbucket.org/durin42/hgsubversion/ ~/hgsubversion
                    vim ~/.hgrc
                        [extensions]
                        hgsubversion = ~/hgsubversion/hgsubversion

                    hg clone EXT_REPO REPO_CLONED

                __________________________
                via convertExtension:
                    http://mercurial.selenic.com/wiki/ConvertExtension

                    vim ~/.hgrc
                        [extensions]
                        hgext.convert =
                    
                    > apt-get install python-subversion
                    > svn co EXT_REPO LOCAL_REPO_SVN
                    > hg convert LOCAL_REPO_SVN LOCAL_REPO_HG

~~~~~~~~~~~~~~~~~~~~~~~~~~
ISSUES
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Si vous avez des problèmes de trust:

        http://mercurial.selenic.com/wiki/Trust

        Il suffit de rajouter les utilisateurs de confiance dans son fichier .hgrc:

            [trusted]
            users = alice, carl, dan
