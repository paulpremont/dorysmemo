==========================================================
	Version         Control         Systems
==========================================================
ou encore
	Source          Code            Management

Ces VCS permettent de gérer de façon intélligente des fichiers en les versionnant et en concervant leurs modifications.
Ils fonctionne généralement avec un système de repository où sont stockés toutes les dernières versions commités de chaque developpeur.
Le but étant d'y stocker les sources d'un programme.



Il existe en fait plusieurs type de VCS qui sont:

        LVCS (Local version control system)

                Dans cette famille nous retrouvons "rcs",
                permettant de stocker localement différente version d'un fichier à partir d'une base local.
                (En fait il sauvegarde des "patch" qui contiennent les différences entre chaque versions)

        CVCS (Centralized Version Control Systems)

                La démarche est presque similaire au LVCS, sauf qu'il permet de travailler de façon collaboratif.
                Les différentes versions étant stockées sur un serveur centralisé.
                Chaque développeur travail directement avec cette base.
                Sont principal inconvénient est qu'il peut être facilement corrompue et se doit d'être opérationnel h24!

        DVCS (Distributed version control systems)

                Ce dernier permet de mixer à la fois le LVCS et CVCS (voir le schéma mercurial)
                On y retrouve  git et mercurial(hg).

                Le but étant de centraliser toutes les versions sur un serveur qui sert de base référence.
                Mais chaque dev garde en local une copie des versions.

                Plus précisément, on importe en local la base stockée sur le serveur central, puis on traite directement avec elle (toujours en local), ce qui évite de casser la base distante (repo distant).
                Une fois que le dev est finis, on le commit en local puis on l'envoie au serveur distant.

Référence:

        http://git-scm.com/book/en/Getting-Started-About-Version-Control 
