Redémarrer son interface graphique plantée
===================

Liens
-------------

* [http://blog.hikoweb.net/index.php?post/2010/04/14/Que-faire-quand-Ubuntu-plante](http://blog.hikoweb.net/index.php?post/2010/04/14/Que-faire-quand-Ubuntu-plante)
* [http://doc.ubuntu-fr.org/environnements](http://doc.ubuntu-fr.org/environnements)

En fonction des environnements graphique
-------------

### Démarrer l'interface :

    startx

### GDM (Ubuntu) :

    sudo /etc/init.d/gdm restart

### XFCE :

    service lightdm restart

Si votre session est bloquée (l'écran de veille qui reste sur fond noir).
Essayer :

    loginctl list-sessions
    loginctl unlock-session [id]

### KDE

    sudo invoke-rc.d kdm restart
