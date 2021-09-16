# Apache's issues

## Erreur "fqdn"

Message :

  Could not reliably determine the server's fully qualified domain name

### Résolution :

[itx-technologies.com](http://itx-technologies.com/blog/56-apache-genere-could-not-reliably-determine-the-servers-fully-qualified-domain-name)

    vim /etc/apache2/apache2.conf

<!-- vim -->

    ServerName "NomDeDomaine.com"
