# Erreur avec les certificats SSL (CA)

## The certificate has not yet been activated

Dans ce cas il m'a fallu régler l'heure du système.
La date n'étant pas cohérente avec la date de création des certificats.

Vérifier votre date et mettez la à jour :

    date

Soit manuellement avec date ou en configurant un client ntp.

## certificate is not trusted

Voir tout simplement si la CA a bien été ajoutée au système :

### Debian :

S'assurer que le paquet ca-certificates soit installé :

    apt-get install ca-certificates

Si vou savez le CA root, Copiez le dans /usr/share/ca-certificates  
Puis mettre à jour ces certifs :

    update-ca-certificates
