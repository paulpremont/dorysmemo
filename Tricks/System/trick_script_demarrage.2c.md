======================================================
Lancer un script au démmarage
======================================================

Comment ça marche?

    Le daemont init va lancer les script init correspondant au runlevel de démarrage.
    Le lancement des script dans un runlevel particulié est determiné par des liens symbolique
        se trouvant respectivement dans /etc/rcX.d avec X le numéro du runlevel.


---------------------
Debian
---------------------

    1) Création du script dans /etc/init.d

            #!/bin/bash
            ### BEGIN INIT INFO
            # Provides:          daemon concerné ou nom du script
            # Required-Start:
            # Required-Stop:
            # Default-Start:     2 3 4 5
            # Default-Stop:      0 1 6
            # Short-Description: ma description
            # Description:
            ### END INIT INFO

            source fichiers_à_charger
            PATH=...

            case "$1" in
                start)
                    echo "Starting script..."
                    ...
                    ;;
                stop)
                    echo "Stopping script..."
                    kill ...
                    ;;
                restart)
                    $0 stop
                    sleep 1
                    $0 start
                    ;;
                status)
                    ...
                    ;;
                *)
                    echo "Usage: $0 {start|stop|restart|status}"
                    exit 1
                    ;;
            esac

        > chmod +x mon_script

    2) Tester son script:

        Lancer les différentes commandes du script.

    3) activation du script au runlevel souhaité:

            Via un utilitaire:

                Sous Debian, c'est update-rc.d qui va s'occuper de mettre à jour les liens symboliques dans rcX.d

                > sysv-rc-conf

            Manuellement:

            Via xinetd:

