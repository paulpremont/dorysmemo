# AUTOSTART

Lancer une application au démarrage d'une session.

Plusieurs méthodes (en fonction de son gestionnaire de bureau) :

* graphique
* CLI

## Links

[askubuntu](http://askubuntu.com/questions/48321/how-to-start-applications-at-startup-automatically)
[doc.ubuntu.fr](http://doc.ubuntu-fr.org/tutoriel/application_demarrage)

## Xfce

Note : le principe reste le même sur n'importe quel Ubuntu.

### Graphique

    xfce4-session-settings

### CLI

Ajouter une fichier .desktop dans :

* /etc/xdg/autostart : Surtout pour les application de l'environnement graphique des barres des tâches.
* /etc/xdg/xdg-xubuntu/autostart : Application propres à l'environnement graphique de xubuntu (xfce).
* /usr/share/autostart : Application divers pour tout les utilisateurs.
* ~/.config/autostart : Application divers de l'utilisateur courant.

#### Modèle :

    [Desktop Entry]
    Type=Application
    Name=<Nom de l'application qui sera affichée>
    Exec=<Commande à exécuter>
    Icon=<Path vers une image>
    Comment=<Commentaires (optionel)>
    X-GNOME-Autostart-enabled=true			#Ajoute l'autodémarrage
    OnlyShowIn=<ENVIRONNEMENT: XFCE, GNOME>		#Si on veut que ça ne s'applique qu'à un desktop particulier

Exemple avec xchat :

    vim ~/.config/autostart/xchat.desktop

        [Desktop Entry]
        Encoding=UTF-8
        Version=0.9.4
        Type=Application
        Name=xchat
        Comment=autostart xchat
        Exec=xchat
        OnlyShowIn=XFCE;
        StartupNotify=false
        Terminal=false
        Hidden=false
