MkDocs
==============================

What is it ?
-----------------------------

MkDocs est un générateur de site de documentation web basé sur markdown et du python.
Ce nouveau site est dailleurs généré à partir de mkdocs.

Merci donc aux devs ! (ça m'a fait économisé pas mal de dimanche pluvieux).

Links
-----------------------------

### Site officiel

[mkdocs](http://www.mkdocs.org/#mkdocs)

### GitHub

[github](https://github.com/mkdocs/mkdocs)

How it works ?
-----------------------------

MkDocs est écrit en python et permet de builder un site facilement.
Parfait pour créer ses mémos en ligne ;) !!

L'outils permet de générer une arborescene avec les fichiers de base.
Tous les fichiers markdons placés dans le dossier docs seront consultables via le menu.
Les sous-dossiers apparaissant comme de sous-menus.

Enfin Mkdocs ajoute des fonctionnalités comme le sommaire automatique, la searchbar, des thèmes et la possibilité de générer à la volé un site web pré-construit.

Installation
-----------------------------

Checker les versions installées :

    $ python --version
    Python 2.7.2
    $ pip --version
    pip 1.5.2

Installer l'outils :

    pip install mkdocs
    mkdocs --version


Configuration
-----------------------------

### mkdocs

Le fichier de configuration principal se trouve à la racine du projet :

    mkdocs.yml

Exemple :

    site_name: Polo's Memos
    theme: readthedocs

### Thèmes

Il est possible de changer de thème simplement.
Soit en utilisant les thèmes déja dispo :

Exemple :

* readthedocs

Soit en important d'autres thèmes.

Exemple avec Material :

[mkdocs-material](http://squidfunk.github.io/mkdocs-material/)

    pip install mkdocs-material

**mkdocs.yml**

    theme: 'material'


Manipulations
-----------------------------

Obtenir de l'aide :

    mkdocs --help

Créer un nouveau projet :

    mkdocs new memos
    cd memos

Arborescence type d'un projet :

    mkdocs_project/
    ├── docs
    │   ├── sub_menu
    │   │   ├── foo.md
    │   │   └── subfolder
    │   │       └── yuyu.md
    │   ├── index.md
    │   └── foo_main.md
    └── mkdocs.yml

Lancer un webserver :

    mkdocs serve

Générer un siteweb prêt à l'emploi :

    mkdocs build

Si l'on souhaite supprimer les anciens fichier et avoir un site propre, utiliser --clean :

    mkdocs build --clean

Un dossier site se créer avec tous les fichiers constituant notre site web.
Pour versionner son projet il est conseillé d'ignorer les fichiers du site :

    echo "site/" >> .gitignore
