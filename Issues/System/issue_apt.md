# Apt's issues

## Erreur " Clé gpg not found"

  Clé gpg not found après un apt-get update

### Lien

[ubuntu-apt-key](http://doc.ubuntu-fr.org/apt-key)

### Résolution

ouvrir le port 11371

    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com votre_n°_de_clé

ou sans ouvrir le port :

    sudo add-apt-key -k hkp://keyserver.ubuntu.com:80 votre_n°_de_clé
