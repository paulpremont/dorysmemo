===========================================
HOW TO ADD A PROGRESS BAR TO A DD COMMAND
===========================================

~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~

    http://www.cyberciti.biz/faq/linux-unix-dd-command-show-progress-while-coping/

~~~~~~~~~~~~~~~~~~
How it work
~~~~~~~~~~~~~~~~~~

    pv : permet de monitorer la progression de données à travers un pipe.
    dialog --gauge : permet de visualiser en mode graphique une progress bar.

~~~~~~~~~~~~~~~~~~
Examples
~~~~~~~~~~~~~~~~~~

    Pour copier /dev/sdb vers /dev/sdc par exemple :

        > pv -tpreb /dev/sdb | dd of=/dev/sdc bs=64M

        ou 

        > pv -tpreb /dev/sdb | dd of=/dev/sdc bs=4096 conv=notrunc,noerro

        Avec pour pv :
            
            -t : activation du chrono (timer)
            -p : activation de la progress bar
            -r : activation du compteur de vitesse
            -e : permet de calculer combien de temps le transfert va durer
            -b : total en byte

        Note :

            pv fonctionne par via un pipe, 
            Il récupère les donnée en input pour créer sa barre de chargement et les renvoie en output de la même manière qu'un cat.

            pour dd, si l'on ne specifie pas de if= , il récupéra les données envoyées en input.

    Pour activer la barre de chargement en graphique :

        > (pv -n /dev/sdb | dd of=/dev/sdc bs=128M conv=notrunc,noerror) 2>&1 | dialog --gauge "Running dd command (cloning), please wait..." 10 70 0

