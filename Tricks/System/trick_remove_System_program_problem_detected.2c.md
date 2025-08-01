https://chrisjean.com/fix-system-program-problem-detected-messages-from-ubuntu/

Les messages d'erreurs sont écrits dans :

    /var/crash

Il suffit des les purger si l'on veut se débarasser des popup d'alertes :

    > rm /var/crash/*

Ces messages sont générés par le service apport

On peut le désactiver via son fichier de conf :

    > sudo vim /etc/default/apport
        enabled=0
