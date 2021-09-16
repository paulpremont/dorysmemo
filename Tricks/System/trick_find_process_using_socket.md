# Trouver un processus qui utilise un socket

Ce dernier pouvant empêcher son arrêt ou l'arrêt d'un autre processus.

## Links :

[cyberciti](http://www.cyberciti.biz/faq/what-process-has-open-linux-port/)

## Procédé

On va chercher le processus coupable et l'arrêter.

Récupérer le nom du processus :

    netstat -laputen |grep $PORT

Ou obtenir le PID :

    fuser $PORT/tcp
    fuser $PORT/udp
    ls -l /proc/$PID/exe

On peut approfondir la prise d'information :

    ps faux |grep $PID
    man $PROG
    whatis $PROG

Ou encore obtenir le PID via lsof :

    lsof -i :portNumber
    lsof -i tcp:portNumber
    lsof -i udp:portNumber
