# Créer son autorité de certification

## Links

* [linux-france](http://www.linux-france.org/prj/edu/archinet/systeme/ch24s03.html)
* [elao.com](http://www.elao.com/blog/linux/creer-une-autorite-de-certification-et-des-certificats-ssl-auto-signes.html)
* [batard.eu](http://www.batard.eu/2010/11/maitriser-les-certificats-avec-openssl/)
* [evilshit.wordpress](http://evilshit.wordpress.com/2013/06/19/how-to-create-your-own-pki-with-openssl/)
* [wiki.archlinux.org](https://wiki.archlinux.org/index.php/Create_a_Public_Key_Infrastructure_Using_the_easy-rsa_Scripts)
* [openxpki](http://www.openxpki.org/)
* [openxpki_docs](https://openxpki.readthedocs.org/en/latest/quickstart.html)
* [stackoverflow](http://stackoverflow.com/questions/11966123/howto-create-a-certificate-using-openssl-including-a-crl-distribution-point)

Voir aussi le memo openvpn qui peut aider.

## Le CA autosignée

1. Création de la clé privée du CA pour signer et attester les nouveaux certificats

On génère la clé en fonction des algorithmes qui vous semblent les plus sécurisés :

    openssl genrsa -des3 -out ca.key 2048

Entrez votre passphrase pour sécuriser votre certificat et surtout les demandes de signature.
Pensez à stocker votre clé sur un media safe.

2. Création du certificat racine

On génère le certificat de notre CA pour attester son identité :

    openssl req -new -x509 -days 3650 -key ca.key -out ca.crt

Entrez ensuite une passphrase et les infos relatives à votre autorité.

Pour lire son certificat :

    openssl x509 -in ca.crt -text -noout

## Une entité validée par notre CA

        On va maintenant créer tout ce qui peut être nécéssaire pour créer un certificat valide d'une entité:

1. Création de la clé privée de notre entité, exemple: site.com :

    openssl genrsa -des3 -out $domain.key 1024

Enlever le mot de passe de la clé (optionnel) :

    openssl rsa -in $domain.key -out $domain.key

2. Créer une demande de certificat :

    openssl req -new -key $domain.key -out $domain.csr

3. Signer une demande de certificat par le CA :

    openssl x509 -req -in $domain.csr -out $domain.crt -sha1 -CA ca.crt -CAkey ca.key -CAcreateserial -days 3650


## Coté client

Au niveau du client il faudra importer le certificat de notre CA pour qu'il puisse valider les certificats signés sans remonter d'alerte.

Par exemple, au niveau de firefox, on peut passer en clicodrome via 'preference/advanced/certificate/View certificate'
Puis importer le certificat et enfin cocher les options qui vont bien comme 'Attester les certificats signés par cette autorité ...'

On peut aussi importer le certificat de la CA dans les entités de confiance :

    cat ca.crt >> /etc/ssl/cert/ca-certificates.crt

Sur les autres distrib:

    Ubuntu/Debian - "/etc/ssl/certs/ca-certificates.crt",
    Fedora/RHEL - "/etc/pki/tls/certs/ca-bundle.crt",
    OpenSUSE - "/etc/ssl/ca-bundle.pem",
    OpenBSD - "/etc/ssl/cert.pem",
    MacOS - KeyChain
    Windows - http://support.microsoft.com/kb/295663

Plus proprement:

Mettre mon certificat dans /usr/share/ca-certificates/dossierDeMaCa

exemple:

    mkdir /usr/share/ca-certificates/monDossierCa
    echo "dossierDeMaCa/maCa.crt" >> /etc/ca-certificates.conf

puis on update:

    update-ca-certificates

## Révocation de liste

Créer un CRL :

    openssl ca -name CA_SubCA -gencrl -out crl/crl.pem -config openssl.cnf

Si vous avez une erreur du type :

    Error message: error while loading CRL number

Solution:

    echo '01' > ./SubCA/crlnumber

Révoquer un certificat:

    openssl ca -name CA_SubCA -revoke certs/user.crt -config openssl.cnf

Utiliser la CRL:

Il faut au niveau de la conf du CA rajouter ces lignes (avant de générer son CA) :

    vim /etc/ssl/openssl.cnf

      [ extensions_section ]
      crlDistributionPoints=URI:http://example.com/crl.pem


## Obtenir un certificat gratuit valide de confiance pour les navigateurs clients

Il est possible d'obtenir des certificats valide pour un domaine grâce à startssl.

### Links

[arscenic.org](https://technique.arscenic.org/ssl-securisation-des/article/startssl-utiliser-un-certificat)

### Créer un compte

[startssl_creation_compte](https://www.startssl.com/?app=32)

Un mail sera ensuite envoyé pour créer son certificat client permetant d'avoir accès à son panneau de configuration de startssl.

Il est donc très important de le sauvegarder !

[startssl_sauvegarde_cert](https://www.startssl.com/?app=25#4)

En gros, se rendre dans les préférences de son navigateur pour afficher les certificats et exporter ceux concernant startcom.

### Créer un certificat

1. Il faut se rendre dans le 'control panel'
2. Dans un premier lieu, il faut faire une demande de validation du domaine :

    Validations Wizard
    Selectionner Domain Name Validation

Et compléter.

Note: il faudra un mail attestant que le nom de domaine est à vous.

3. Puis dans Certificates wizard
sélécetionner 'Web/Server SSL/TLS' pour créer un certificat machine.
