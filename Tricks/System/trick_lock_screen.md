# Raccourci pour vérouiller son écran

## Liens

[tuto](http://dev.petitchevalroux.net/linux/verrouiller-ecran-ligne-commande-linux.246.html)

## Procédé

**Sous KDE :**

Pour toutes les versions 3.x de KDE :

    dcop kdesktop KScreensaverIface lock

Pour la nouvelle version 4.x de KDE

    qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock

**Sous Gnome :**

    gnome-screensaver-command --lock

**Sous Xfce :**

    pcr@home:$ xscreensaver-command -lock
