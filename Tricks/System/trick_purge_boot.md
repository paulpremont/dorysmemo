Nettoyer son /boot
==============================

Quand?
-----------------------------

Lors d'un dist-upgrade par exemple, vous pouvez avoir le message :

    No space left on device

Comment?
-----------------------------

### Debian/Ubuntu

#### Automatiquement

    sudo apt-get autoremove

#### Manuellement

Checker la version du kernel :

    uname -r

Supprimer les autres images :

    ls -l /boot
    sudo apt-get purge linux-image-XXXXXXX-generic

Mettre à jour le grub :

    sudo update-grub2 

Continuer le nettoyage :

    sudo apt-get clean
    sudo apt-get autoremove

Puis faire ses upgrades :

    sudo apt-get install <LIST OF PKGS KEPT BACK>
ou
    sudo apt-get dist-upgrade
