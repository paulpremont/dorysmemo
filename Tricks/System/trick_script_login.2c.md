todo:

Pour les cript commun à tout les utilisateurs:

    il suffit de placer son script dans /etc/profile.d 

En passant par pam:

    > vim /etc/pam.d/session
        session optional pam_exec.so /bin/bash /tmp/test.sh

Au niveau de chaque utilisateur:

    Dans ~/.bashrc
        ~/.profile 
        ...

/!\ Pour les montages automatique, 
    se raprocher de udisks (pour l'execution en non root)
    et de pam_mount

    Avec pam_mount:
        
        > apt-get install libpam-mount

    /!\ pour les montages d'utilisateur ldap uniquement
        Il vaut mieux voir du coté de ldap + autofs.

    Sinon il y aura toujourts un forcage d'un mount même pour les users non présen dans ldap.

