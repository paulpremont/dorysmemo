# Se donner les droits sur une commande avec sudo à l'aide de sudoers

* [Manuel d'utilisation de sudoers](http://www.sudo.ws/sudo/man/1.8.4/sudoers.man.html)

## Procédure

1. Éditer le fichier /etc/sudoers (Attention lire la suite!)

Pour cette manipulation, il faut éditer le fichier ainsi:

1.1. Choisir un editeur de texte (facultatif)

    sudo update-alternatives --config editor

ou

    export EDITOR="vim" (Ubuntu 8.04)
    select-editor (Ubuntu 8.10)

Par défault, l'éditeur est nano

1.2. Éditer le fichier

    sudo visudo

Cette manipulation permet en cas d'erreur dans l'édition du fichier de ne pas se trouver dans une facheuse situation (Ne plus pouvoir rien faire sur sa machine)

Note: visudo vérifie l'intégrité du fichier.

Cette étape est facultative si on n'a pas froid aux yeux.

2. Rajouter un User_Alias

    <User_Alias>=<NomUser>

3. Rajouter un Cmnd_Alias

    <Cmnd_Alias>=<commande1>, <commande2>

4. Rajouter Les privilèges avec les valeurs définis précedements:

    <User_Alias> ALL=(ALL) NOPASSWD:<Cmd_Alias>

Attention de bien mettre cette ligne à la fin du fichier.

(Ou bien vérifier que d'autres spécifications ne viennent pas s'éxecuter apres notre nouvelle ligne.)

5. Bonus

rajouter un Alias dans votre bashrc pour executer la commande sans mettre sudo devant:

exemple pour halt:

    alias halt='sudo halt'

## Exemple de fichier sudoers :

    # /etc/sudoers
    #
    # This file MUST be edited with the 'visudo' command as root.
    #
    # See the man page for details on how to write a sudoers file.
    #

    Defaults	env_reset

    # Host alias specification

    # User alias specification
    User_Alias VIP=ppremont

    # Cmnd alias specification
    Cmnd_Alias TCP=/user/bin/tcpprep, /user/bin/tcpreplay
    Cmnd_Alias HALT=/sbin/halt

    # User privilege specification
    root	ALL=(ALL) ALL

    # Allow members of group sudo to execute any command
    # (Note that later entries override this, so you might need to move
    # it further down)
    %sudo ALL=(ALL) ALL
    #
    #includedir /etc/sudoers.d

    # Members of the admin group may gain root privileges
    %admin ALL=(ALL) ALL

    # Perso:

    VIP ALL=(ALL) NOPASSWD:TCP
    me	ALL=NOPASSWD:HALT
