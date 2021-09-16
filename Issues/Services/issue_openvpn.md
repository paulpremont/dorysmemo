# Openvpn's issues

## Erreur :

Message :

    Unable To Get Local Issuer Certificate

### Résolution :

Openvpn ne s'appuie pas sur le magasin de certificat de /etc/ssl/certs/ca-certificates.

Dans le cas où l'on dispose de subca, il faut l'ajouter dans le même fichier que le certificat utilisateur.
On mettra la rootca comme ca. (Voir memo openvpn).
