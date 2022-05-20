G I T
==============================

What is it ?
-----------------------------

Git est un DVCS au même titre que mercurial (ou d'autre)
Il permet de gérer les version d'un soft de façon décentralisée.

Links
-----------------------------

* [Site officiel](http://git-scm.com/)
* [Très bon tuto GIT](https://fr.atlassian.com/git/)
* [Comparaison avec hg](https://github.com/sympy/sympy/wiki/Git-hg-rosetta-stone)
* [Infos utilisation](http://githut.info/)
* [commandes mis en opposition avec mercurial](https://www.mercurial-scm.org/wiki/GitConcepts)

How it works ?
-----------------------------

Le coeur de Git est écrit en C.

Git utilise un repo bare qui sert de référence pour les developpeurs et duquel on peu cloner un repo non-bare en local sur sa propre machine.

Le principe du DVCS est de pouvoir travailler en local sur son poste et commiter directement les changements sur le clone du repo.
Puis de pousser les changements sur le repo bare centralisé.


Installation
-----------------------------

Redhat like :
    yum install git

Debian like :
    apt-get install git


Configuration
-----------------------------

### Fichiers de config

* Chaque repo git contient un fichier **.git/config**?
* Il est possible d'avoir un fichier par utilisateur dans **~/.gitconfig**.

        --------------------------
        Créer sa configuration git
        --------------------------

              > git config --global user.email "you@example.com"
              > git config --global user.name "Your Name"

              Ces commandes modifierons le contenu de ~/.gitconfig

        --------------------------
        Exemples
        --------------------------

            #Au niveau d'un repo :

                > vim .git/config


                    #Adresse du serveur :

                    [remote "origin"]
                        fetch = +refs/heads/*:refs/remotes/origin/*
                        url = ssh://remote_hostname//home/repository/monrepo.git

                    [branch "dev"]
                        remote = origin
                        merge = refs/heads/dev

            #Connexions

                #Cache http pour retenir le mdp :

                    > git config --global credential.helper cache
                    > git config --global credential.helper 'cache --timeout=3600'

                #Pour garder en mémoire les credentials :

                   > git config --global credential.helper store
                   > ls ~/.git-credentials

                   Attention car stock en clair les infos de connexion

                #Ssh :

                    Config habituel d'un client ssh.

        --------------------------
        Ajouter un alias vers un repo
        --------------------------

            > git config --add remote.origin.url HOST:/PATH/TO/REPO

            origin est à remplacer par le nom du remote souhaité.

            ensuite on pourra push par exemple:

                > git push --all origin

        --------------------------
        Ajouter un repo externe pour pousser ses changements
        --------------------------

            git remote add alias remote_repo

            Ex :

                > git remote add origin https://github.com/...

            Pour pousser ensuite de façon automatique dessus, on peut lancer :

                git push -u mon_repo ma_branche

                Ex :

                    > git push -u origin master

Manipulations
-------------------

**Afficher l'aide :**

    git maCommande -h

### Gestion des repos

#### Créer un repo

**Repo non bare (repo locale surtout) :**

    git init

**Repo bare (repo central qui ne peut pas servir de working dir) :**

    git init --bare $BARE_REPO_NAME

#### Clonner un repo existant :

    git clone ssh://HOST//PATH_TO_REPO

#### Pusher dans un autre repo :

Méthode from scratch :

1. créer un nouveau repo bare et récupérer son url
2. copier le repo d'origine, et se placer dedans
3. git remote rename origin upstream
4. git remote add origin URL_TO_GITHUB_REPO
5. git push --all origin master

Duppliquer un repo simplement :

    git push REMOTE --mirror

ou

    git push REMOTE --all
    #+
    git push REMOTE --tags


Pour ensuite push dans deux repo, il faut :

les ajouter au niveau de la config git :

    git remote add remote_alias git@REMOTE...

et push (soit distinctement, soit en créan un alias avec les deux url)

    git push
    git push remote_alias

ou si on a créer un alias "both" avec les deux url : 

    git push both

ou pour faire plus simple :

    git remote set-url --add --push origin git@REMOTE_origine
    git remote set-url --add --push origin git@REMOTE_other_repo
    git push


### Gestion des branches
                __________________________
                Créer une branche :

                    On créer le plus souvent une nouvelle branche pour une nouvelle feature,
                    que l'on merge une fois que la feature est validée.

                        > git checkout -b maBranche
                        ou
                        > git branch maBranche
                        > git checkout maBranche

                __________________________
                Lister les branches :

                    #L'actuelle :

                        > git branch

                    #Toutes :

                        > git branch -a

                    #Sur le serveur distant :

                        > git remote show origin

                        (origine pouvant être subsitué par l'alias définit en conf)

                __________________________
                Importer les commit d'une branche :

                    > git checkout BRANCH
                    > git pull

                    Note :

                        UN git pull équivaut à un :

                        > git checkout maBranche
                        > git fetch
                        > git merge

                    ou

                    > git pull ssh://HOST:PORT//PATH $VERSION 	(où $VERSION peut être une branche ou un commit)
                __________________________
                Exporter toutes les branches :

                    > git push --all ssh://HOST//PATH_TO_REPO

                    Note:

                        Pour pull, l'option --all va seulement pull sur tous les remotes.

                        Pour pusher des branches sur un repo distant, il faut au préalable les avoir activées via un checkout.

                        Si lorsque vous exécutez git branch -a et que certaine branches sont notées "remotes/..." c'est qu'elles n'ont pas été checkout.

		                Supprimer le "remotes/origin/" de la branche pour checkout.
                        Ensuite avec un push --all , toute les branches "actives" seront pushées.

#### Supprimer une branche :

**Localement :**

    git branch -d <branch_name>

**Sur le remote :**

    git push origin --delete <branch_name>

**Reset une branche :**

    git branch -f maBranche


### Gestion des commits

#### Patcher

Patcher permet d'appliquer des changements opérés sur un répo.
On peut générer un patch de plusieurs manières :

##### Création d'un patch

    git diff rev2 rev1 >> /tmp/mon_Patch

ou plus proprement avec plus d'information dont les infos de commits :

    git format-patch ma_rev

##### Application d'un patch

Vérifications :

    git apply --stat monPatch
    git apply --check monPatch    #pas d'output = ok

Application :

    git apply --apply monPatch

Appliquer un patch et son commit (génnéré avec format-patch)

    git am monPatch

##### L'historique


Afficher tout l'historique :

    git log

Afficher le dernier commit :

    git show --summary
    git log -1

Pour afficher tout les commit et leurs branches associées :

    git log --all --graph --source

                __________________________
                Récupérer les derniers commits d'une branche :

                    > git checkout mBranche
                    > git pull

                    /!\ le pull merge en même temps, git le fera automatiquement.
                __________________________
                Afficher les modifications apportées

                    Lister les nouveaux fichiers :

                        > git status
                        > git status -s #Pour avoir un meilleur affichage

                    Voir la différence entre les nouvelles modif et le dernier commit :

                        > git diff --staged

                    N'afficher que les fichiers impactés par un commit :

                        > git diff --name-only

                    On peut voir les modifications apportées par un commit uniquement :

                        > git show <monCOMMIT>

                        Cela revient au même que de faire un diff entre le commit et son précedent.

                    Voir la diff avec le dernier commit :

                        > git diff HEAD

                __________________________
                Stager de nouveaux fichiers (stage) :

                    On ajoute les fichiers dit 'staged', c'est à dire prêt à être commité.

                    #Tout les fichier à partir du path actuel :
                        > git add .

                    #Un fichier en particulier :
                        > git add FICHIER

                __________________________
                Unstager de nouveaux fichiers (unstage) :

                    #Annuler le stage :

                        > git reset

                    On retire les fichier que l'on ne souhaite plus gérer par git.

                        > git reset monFichier

                    Si l'on veut retrouver le fichier comme il était au dernier commit, on peut utiliser :

                        > git checkout -- monFichier

                    Supprimer un fichier mais 'stager' la suppression :

                        > git rm my_File
                        > git commit -m "remove my_File"
                __________________________
                Commiter :

                    > git commit #puis saisir un message
                    ou
                    > git commit -m 'MESSAGE'

                    Pousser les nouveaux commits sur le repo :

                        > git push

                    #Sur gerrit :

                        > git push origin HEAD:refs/for/master

                __________________________
                Modifier un commit :

                        Réediter le dernier commit
                        ``````````````````````````
                            > git commit --amend

                __________________________
                Taguer :

                    Taguer un commit c'est lui donner un alias pour simplifier les identifier plus facilement.

                        Ajouter
                        ``````````````````````````
                            > git tag -a VERSION -m "MESSAGE"

                        Lister
                        ``````````````````````````
                            > git tag -l

                __________________________
                Backporter / Merger :

                    Pour transposer les changements d'un commit sur une autre branche :

                        > git checkout mabranche
                        > git cherry-pick <branchname> <commit>

                    Pour fusionner deux historiques, on utilisera merge :

                        > git checkout mabranche
                        > git merge <branchname> <commit>

                        Note :

                            On importe les modifs sur la branche en cours :

                                > git checkout master
                                > git merge maFeature
                                > git branch -d maFeature

                    Supprimer une branche sur un dépôt distant :

                        git push origin :branch_to_delete

                __________________________
                Modifier un ancien commit :

                    Plusieurs solutions :

                        Via rebase :

                            http://www.kevinsubileau.fr/informatique/astuces-tutoriels/git-modifier-ancien-commit.html

                            faire un rebase de son ancien commit :

                                > git rebase --interactive <COMMIT>

                            Effectuer ses changements puis les recommiter :

                                > git commit -a --amend --no-edit

                            Restaurer ses anciens commit :

                                > git rebase --continue

                __________________________
                Mettre de côté des changements non commités :

                    > git stash

                    Pour afficher tous les stash :

                        > git stash list

                    Pour réappliquer un stash :

                        > git stash pop

### Hooks

[hooks](https://git-scm.com/book/it/v2/Customizing-Git-Git-Hooks#Client-Side-Hooks)
[tuto_hooks](https://www.digitalocean.com/community/tutorials/how-to-use-git-hooks-to-automate-development-and-deployment-tasks)

Les hooks permettent d'automatiser des actions avant ou après certaines commandes git.

Les hooks peuvent être écrits au niveau serveur :

voir **mon_repo/hooks**

et client :

voir **.git/hooks**

Voir le tableau


### Utilisation d'un proxy socks :

Exemple :

```
ALL_PROXY=socks5://127.0.0.1:8080 git $ARGS'
```

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Erreur
        --------------------------
                __________________________
                Logs:

                __________________________
                Description:

                __________________________
                Résolution:



~~~~~~~~~~~~~~~~~~~~~~~
MAJ DE REPOS
~~~~~~~~~~~~~~~~~~~~~~~

	_____________________
	Forcer le checkout d'une branche:

		Dans le cas d'un push par exemple ou pour écraser toute les modifs non commitées:
		Attention cette commande est à éxécuter avec précotion!

		Il vaut mieux faire un stash avant:

            > 	git stash
            >	git reset --hard HEAD

        Dans le cas où l'on push une même branche active sur un repo non bare, par défaut, git interdit cette opération.
        Pour autoriser cette action: (à faire sur le repo distant)

            >	git config receive.denyCurrentBranch ignore

	_____________________
	Vérouiller un fichier contre le checkout.

        >	git update-index --assume-unchanged config/databases.yml
        >	git status
        >	git update-index --skip-worktree config/databases.yml
        >	git status

        #git config receive.denyCurrentBranch ignore

	_____________________
	Se placer sur une révision particulière:

        > git checkout $REVISION        #pour se placer sur ce commit
        > git clean -nxd                #pour voir les fichiers non trackés (et qui seront supprimés)
        > git clean -fxd                #pour appliquer le nettoyage


~~~~~~~~~~~~~~~~~~~~~~~
INFORMATIONS SUR UNE BRANCHE
~~~~~~~~~~~~~~~~~~~~~~~

	_____________________
	Voir l'état des nouveaux fichiers:

        >	git status


~~~~~~~~~~~~~~~~~~~~~~~
MODIFICATION DE BRANCH
~~~~~~~~~~~~~~~~~~~~~~~
	_____________________
	Se placer sur un commit/branche particulier(e):

        >	git checkout COMMIT

	_____________________
	Importer une branche particulière:

        >	git checkout BRANCH

            # en plus d'importer la branche, les fichiers seront maj

	_____________________
	Annuler des modifications

        Par rapport au dernier commit et aux fichiers actifs:

        Remettre les fichiers dans l'état du dernier commit

            > git checkout .

        Pour annuler les modifs d'un seul fichier :

            > git checkout mon Fichier

        Initialiser au même état que le repo distant :

            > git reset --hard origin/master

        Supprimer un commit en local:

            Le dernier commit:

                > git reset --soft HEAD^

            Exemple avec les 3 dernières versions:

                > git reset --hard HEAD~3

        Supprimer un commit définitvement :

            Attention : sur gitlab il faudra configurer le repo en mode "unprotect"

                > git reset --hard HEAD~1
                > git push --force
                
	_____________________
	Mettre de coté des fichiers modifiés

        >	git stash
        >	git stash pop	#pour les reprendre
