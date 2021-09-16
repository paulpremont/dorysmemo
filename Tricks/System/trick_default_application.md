# Configurer les applications par défaut (Ubuntu)

Les applications par défaut sont gérées au niveau de

    /etc/alternatives

par des liens symboliques.

Il suffit de créer le lien symboloque avec le bon nom.

Pour faciliter cette création, on utilise sur ubuntu update-alternatives.

Afficher les applications par défaut :

    update-alternatives --get-selections

Définir des applications par défaut :

Exemples :

NAVIGATEUR WEB :

    sudo update-alternatives --config x-www-browser
    sudo update-alternatives --config gnome-www-browser

EDITEUR TEXTE

    sudo update-alternatives --config editor
