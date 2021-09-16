==========================================================
                       P K I
==========================================================

Public Key Infrastructure

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Docs:
        http://fr.wikipedia.org/wiki/Infrastructure_%C3%A0_cl%C3%A9s_publiques
        https://www.openssl.org/docs/apps/x509v3_config.html#Authority_Key_Identifier_
        
    Solutions:
        http://www.ejbca.org/
        http://openxpki.readthedocs.org/en/latest/index.html
        https://pki.openca.org/projects/openca/

    Tutos:
        http://pki-tutorial.readthedocs.org/en/latest/advanced/
        http://evilshit.wordpress.com/2013/06/19/how-to-create-your-own-pki-with-openssl/#crl
        http://www.linux.com/community/blogs/133-general-linux/742528-pki-implementation-for-the-linux-admin
        http://wiki.cacert.org/FAQ/subjectAltName

    Voir serveur OCSP ou SCVP pour avoir une CRL instantanée:

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    C'est un système permettant de créer et d'assurer l'authenticité des certificats numériques.
    Basé sur le système de chiffrement asymétrique à clé publiques.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    La PKI est composées de plusieurs autorités (pouvant fonctionner en standalone):

    Typiquement dans une arborescence plus complexe (comme celle d'internet).
    On aura plusieurs CA attestant plusieurs Sous authorité et s'atestant entre elles.

        --------------------------
        CA - Certificate Authority
        --------------------------

            -Détient le certificat racine de confiance attestant tout les autres certificats (RootCA).
            scp crl
            -Elle signe les demandes de certficiats (CSR: Certificate Signing Request).
            -Elle signe les listes de révocations (CRL: Certification Revocation List).

            La CA peut déléguer son authorité à d'autre machine (SubCA).
                
        --------------------------
        RA - Registration Authority
        --------------------------

            Souvent couplé avec une VA (Validation Authorithy)

            -Créer les certificats et vérifie leur unicité, intégrité.

        --------------------------
        Repository 
        --------------------------

            -Stock les certificats et les listes de révocation (CRL)

        --------------------------
        Autorité de séquestre (Key Escrow)
        --------------------------

            -Stock les clés de chiffrement dans un but legislatif.
        
        --------------------------
        Clients End-entity
        --------------------------

            -Les clients doivent avoir le certificat racine dans leur magasin pour attester ses certificats.

        --------------------------
        CRL - Certificate Revocation list
        --------------------------

            S'occupe de la liste des certificats invalidés.
            On y accede le plus souvent http.
            Plusieurs protocoles existent aussi pour la gestion de certificats révoqués:
                OCSP et SCVP.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Solutions
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Voici quelques solutions pour mettre en place sa PKI:

        Customs:
            -openssl (en implémentant quelques script)
            -easyrsa/pkitool (les scripts disponibles avec openvpn s'appuyant sur openssl)
            -gnuTLS


        Packagées:
            -openXpki (écrit en perl)
            -ejbca
            -openca

        Il existe aussi bien d'autre tools écriten python, perl ...

~~~~~~~~~~~~~~~~~~~~~~~~~~
Openssl
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Installation
        --------------------------

            > apt-get install openssl

        --------------------------
        Configuration
        --------------------------

            Config par défaut: /etc/ssl/openssl.cnf

            Changer de conf:
                > openssl -config ma_config.cnf

            Choisir une extension de certificat:
                > openssl ... -extensions mon_extension 

                __________________________
                Elements de configuration:

                    pathlen:X  : Avec X le nombre de Sous CA dont on a autorité.
                        0 : signifie qu'il est possible de signer uniquement des certifs 'end user'.

                    Les blocks:

                        Chaque block peuvent être appelé soit directement par le script,
                        soit depuis la config même.

                        Dans les type de block, on trouve usuellement:
                            
                            -Les blocks de CA, avec tout les fichier concernant une CA.
                            -Les blocks d'extensions: Ajout d'élement dans les certificats x509.
                            -Les blocks d'attributs: Spécification de plusieurs variables pour un attribut. 


            Exemple de conf:

                ####################################################################
                # This definition stops the following lines choking if HOME isn't defined
                HOME            = $pki_dir
                RANDFILE        = \$ENV::HOME/.rnd

                ####################################################################
                [ ca ]
                default_ca      = CA_RootCA                     # The default ca section

                ####################################################################
                [ CA_RootCA ]
                dir             = $pki_dir/CA                   # Where everything is kept
                certs           = $dir->{ca}->{crt}             # Where the issued certs are kept
                crl_dir         = $dir->{ca}->{crl}             # Where the issued crl are kept
                database        = $path->{ca}->{db}             # database index file.
                new_certs_dir   = $dir->{ca}->{crt}             # default place for new certs.
                certificate     = $path->{ca}->{crt}            # The CA certificate
                serial          = $path->{ca}->{serial}         # The current serial number
                crlnumber       = $path->{ca}->{crl_number}     # the current crl number
                crl             = $path->{ca}->{crl}            # The current CRL
                private_key     = $path->{ca}->{key}            # The private key
                RANDFILE        = $path->{ca}->{rand}           # private random number file
                x509_extensions = user_cert                     # Default extentions to add to the client cert
                name_opt        = ca_default                    # Subject Name options
                cert_opt        = ca_default                    # Certificate field options
                default_days    = 3650                          # how long to certify for
                default_crl_days= 30                            # how long before next CRL
                default_md      = default                       # use public key default MD (Attention aux erreur su changement)
                preserve        = no                            # keep passed DN ordering
                policy          = policy_match                  # règles à appliquer sur les élements à renseigner (obligatoire...)

                ####################################################################
                [ CA_SubCA ]
                dir             = $dir->{domain}->{ca}          # Where everything is kept
                certs           = $dir->{domain}->{crt}         # Where the issued certs are kept
                crl_dir         = $dir->{domain}->{crl}         # Where the issued crl are kept
                database        = $path->{subca}->{db}          # database index file.
                new_certs_dir   = $dir->{domain}->{crt}         # default place for new certs.
                certificate     = $path->{subca}->{crt}         # The CA certificate
                serial          = $path->{subca}->{serial}      # The current serial number
                crlnumber       = $path->{subca}->{crl_number}  # the current crl number (comment to leave V1 CRL)
                crl             = $path->{subca}->{crl}         # The current CRL
                private_key     = $path->{subca}->{key}         # The private key
                RANDFILE        = $path->{subca}->{rand}        # private random number file
                x509_extensions = user_cert                     # The extentions to add to the cert
                name_opt        = ca_default                    # Subject Name options
                cert_opt        = ca_default                    # Certificate field options
                default_days    = 3650                          # how long to certify for
                default_crl_days= 30                            # how long before next CRL
                default_md      = default                       # use public key default MD
                preserve        = no                            # keep passed DN ordering
                policy          = policy_match

                ####################################################################
                # For the CA policy
                [ policy_match ]
                countryName             = match
                stateOrProvinceName     = match
                organizationName        = match
                organizationalUnitName  = optional
                commonName              = supplied
                emailAddress            = optional

                ####################################################################
                [ req ]
                default_bits            = 2048
                default_keyfile         = privkey.pem
                distinguished_name      = req_distinguished_name
                attributes              = req_attributes
                x509_extensions         = rootca_cert           #Extension for self-signed cert
                string_mask             = utf8only

                ####################################################################
                [ req_distinguished_name ]
                countryName                     = Country Name
                countryName_default             = FR
                countryName_min                 = 2
                countryName_max                 = 2
                stateOrProvinceName             = State or Province Name
                stateOrProvinceName_default     = Ile de france
                localityName                    = Locality Name
                localityName_default            = Paris
                0.organizationName              = Organization Name
                0.organizationName_default      = Mon entreprise
                organizationalUnitName          = Organizational Unit Name
                organizationalUnitName_default  = Mon équipe
                commonName                      = Common Name
                commonName_default              = $cn
                commonName_max                  = 64
                emailAddress                    = Email Address
                emailAddress_default            = $mail
                emailAddress_max                = 64

                ####################################################################
                [ req_attributes ]
                challengePassword       = A challenge password
                challengePassword_min   = 4
                challengePassword_max   = 20
                unstructuredName        = An optional company name

                ####################################################################
                [ rootca_cert ]
                subjectKeyIdentifier=hash
                authorityKeyIdentifier=keyid:always,issuer
                basicConstraints = CA:true, pathlen:1
                nsCertType = sslCA, emailCA
                nsComment               = "Rootca cert"
                subjectAltName=email:copy
                issuerAltName=issuer:copy
                crlDistributionPoints=URI:http://example.com/crl.pem

                ####################################################################
                [ subca_cert ]
                subjectKeyIdentifier=hash
                authorityKeyIdentifier=keyid:always,issuer
                basicConstraints = CA:true, pathlen:0
                subjectKeyIdentifier=hash
                nsCertType = sslCA, emailCA
                nsComment               = "Subca cert"
                subjectAltName=email:copy
                issuerAltName=issuer:copy
                crlDistributionPoints=URI:http://example.com/crl.pem

                ####################################################################
                [ user_cert ]
                basicConstraints=CA:FALSE
                keyUsage = nonRepudiation, digitalSignature, keyEncipherment
                subjectKeyIdentifier=hash
                authorityKeyIdentifier=keyid,issuer
                subjectAltName=email:move
                extendedKeyUsage        = clientAuth, emailProtection, codeSigning
                authorityInfoAccess     = caIssuers;URI:$url->{crt}
                crlDistributionPoints   = URI:$url->{crl}
                nsCertType              = client, email
                nsComment               = "User cert"
                nsCaRevocationUrl       = $url->{crl}
                crlDistributionPoints=URI:http://example.com/crl.pem

                ####################################################################
                [ server_cert ]
                basicConstraints        = CA:FALSE
                keyUsage                = nonRepudiation, digitalSignature, keyEncipherment, dataEncipherment
                subjectKeyIdentifier=hash
                authorityKeyIdentifier=keyid,issuer
                extendedKeyUsage        = serverAuth
                subjectAltName=email:move
                nsCertType              = server
                nsComment               = "Advim server cert"
                nsCaRevocationUrl       = $url->{crl}
                crlDistributionPoints=URI:http://example.com/crl.pem

        --------------------------
        Manipulations
        --------------------------

            Pour afficher les différents man d'openssl, se réferrer directement au script mentionné en bas du manuel.

            Exemple:

                > man ca, req, rand, genrsa ...
                __________________________
                CA:

                    On créer avec la méthode que l'on souhaite un certificat autosigné.

                    Exemple:

                        Création d'un nombre aléatoire pour durcir la clé rsa:
                            > openssl rand -out $rand 8192

                        Création de la paire de clé rsa:
                            > openssl genrsa -out rootca.key -aes256 -rand $rand [-passout pass:$pass] 2048

                        Création du certificat autosigné:
                            > openssl req -new -x509 -days 3650 -key rootca.key -out rootca.crt -config openssl.cnf [-passout pass:$pass -passin pass:$pass]

                            Note: l'extension est ajoutée automatiquement grâce à la conf (section: req/x509-extensions)

                __________________________
                SubCA:

                    Selon son schéma de pki, il peut être souhaitable de déléguer son authorité à d'autre sous CA.
                    Dans ce cas, on créer un certificat signé par notre CA avec une extension spécifique (pathlen=1 ...).

                    Exemple:

                        Génération de la paire de clé:
                            > openssl rand -out $rand 8192
                            > openssl genrsa -out subca.key -aes256 -rand $rand 2048

                        Création d'une demande de certificat:
                            > openssl req -new -key subca.key -out subca.csr -config openssl.cnf [-passin pass:$pass]

                        On signe la demande:
                            > openssl ca -name CA_RootCA -in subca.csr -out subca.crt -config fichier.cnf -extensions subca_cert

                        Note: l'extension peut être choisie au niveau de la demande ou de la signature.
                            Si on ne specifie pas de name lors de la signature, c'est la ca par defaut qui sera chargée.

                __________________________
                Certificat utilisateur ou machine:

                    Même principe que pour une sous Ca mais en changeant l'extension et l'authorité de certification:

                    Exemple:

                        On génère les clés;

                        Création d'une demande de certificat:
                            > openssl req -new -key server.key -out server.csr -config openssl.cnf

                        On signe la demande:
                            > openssl ca -name CA_SubCA -in server.csr -out server.crt -config openssl.cnf -extensions server_cert
                         
                __________________________
                Révoquer un certificat:

                    Il faut maintenir à jour sa liste de révocation. (et la publier)

                    Exemple:

                        Création d'une liste de révocation:

                            > openssl ca -name CA_SubCA -gencrl -out $crl -config $config    

                        Révoquer un certificat:

                            > openssl ca -name CA_SubCA -revoke $crt -config $config

                __________________________
                Publier les certificats:

                    Over http en donnant accès aux certificats et à la liste de révocation.

                    Exemple:

                        TODO
    
                        subtitle 4
                        ``````````````````````````
                __________________________
                Enlever le mot de passe d'une clé:
                    
                    > openssl rsa -in macle.key -out macle.key

                __________________________
                Exporter au format pkcs#12

                    > openssl pkcs12 -export -in $crt -inkey $key -out $p12 -name "$name" [-password pass:$pass -passin pass:$pass]

                __________________________
                Lire un certif:

                    > openssl x509 -text -in $crt

~~~~~~~~~~~~~~~~~~~~~~~~~~
EJBCA
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
OPENXPKI
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
OPENCA
~~~~~~~~~~~~~~~~~~~~~~~~~~
