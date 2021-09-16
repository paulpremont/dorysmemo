Terminator
==============================

What is it ?
-----------------------------

Une application permettant de lancer plusieurs terminaux GNOME.
Les terminaux peuvent être splittés, nommés ...


Links
-----------------------------

* [terminator_blog](http://gnometerminator.blogspot.fr/p/introduction.html)
* [terminator_ubuntu_doc](https://doc.ubuntu-fr.org/terminator)


How it works ?
-----------------------------

Installation
-----------------------------

### Debian

    apt-get install terminator

Configuration
-----------------------------

### Main conf

    vim ~/.config/terminator/config

### Layouts

Un des gros avantages est que vous pouvez à tout moment sauvegarder et configurer votre layout actuel.
C'est à dire le titre et la disposition des terminaux.
(CLic droit/Preferences/Layouts)


Manipulations
-----------------------------

Lancer terminator :

    terminator

En choisissant un layout directement :

    terminator -l monLayout

Selectionner un layout :

    terminator -s

L'idéal est donc de se configurer plusieurs environnement, les sauvegarder et éditer les commandes.
Puis de se faire un raccourci clavier vers : terminator -s (CTRL + ALT + S par exemple)
