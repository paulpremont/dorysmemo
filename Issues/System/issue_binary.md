# Binary's issues

## Erreur "no such file or directory"

Si vous avez un 'no such file or directory' lors de l'execution d'un binaire:

### Lien :

[stackoverflow](http://stackoverflow.com/questions/2716702/no-such-file-or-directory-error-when-executing-a-binary)

### Résolution :

Vérifier les dépendances:

    readelf -a maCommande |grep prog

Il devrait y avoir quelque chose du type:

    [Requesting program interpreter: /lib/ld-linux.so.2]

En fonction de son architecture et des lib manquantes:

    apt-get install libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1
