==========================================================
                       T I T L E
==========================================================

    $openssl : outils relatif à la gestion du protocole ssl

        Links: http://www.networking4all.com/fr/support/certificats+ssl/manuels/openssl/commandes+openssl/

        Voir aussi tips_ca

        Chiffrer/déchiffrer un fichier:
        ``````````````````````````

            > openssl rsautl -encrypt -in FILE -inkey RSA_KEY -out FILE_CIPHER
            > openssl rsautl -decrypt -in FILE_CIPHER -inkey RSA_KEY -out FILE

        Certificat autosigné:
        ``````````````````````````

            openssl req -x509 -nodes -newkey rsa:2048 -keyout \
              /etc/ssl/private/pure-ftpd.pem \
                -out /etc/ssl/private/pure-ftpd.pem

            Note: le format pem comprend à la fois le certificat et la clé privée.

        Vérifier l'intégriter d'un fichier:
        ``````````````````````````

            CHiffrement SHA512
            > openssl dgst -r sha512 monfichier
            ou
            > sha512sum monfichier
    
            Chiffrement Whirlpool
            > openssl dgst -r -whirlpool monfichier

        Vérifier la concordance d'un certificat et d'une clé privée:
        ``````````````````````````
            Grâce au modulo:

            > openssl rsa -noout -modulus -in fichier.key
            > openssl rsa -noout -modulus -in fichier.csr

        Lire:
        ``````````````````````````
            un certificat:
                openssl x509 -in certificate.crt -text -noout

                        une clé privée: (pem)
                                openssl rsa -in <fichier> -text -noout

        Liste des protocol supportés
        ``````````````````````````
            openssl list-cipher-commands


        Contrôler:
        ``````````````````````````
            une clé privée:
                openssl rsa -in privateKey.key -check

            un csr:
                openssl req -text -noout -verify -in CSR.csr


        Génération d'une paire de clés
        ``````````````````````````
            openssl genrsa -out maCle.pem 1024

        Visualisation des clé RSA
        ``````````````````````````
            openssl rsa -in maCle.pem -text -noout

        Protéger la clé
        ``````````````````````````
            Avec DES:
                openssl rsa -in $key -des3 -out $key

        Extraire une clé
        ``````````````````````````
                openssl rsa -in $key -pubout -out "pub_$key"


        Chiffrement de fichier
        ``````````````````````````
            openssl rsautl -encrypt -in $file -inkey $key -out encrypt.bin  #clé priv
            openssl rsautl -encrypt -in $file -pubin -inkey "pub_$key" -out encrypt2.bin  #clé pub

            AES:
                openssl aes-256-cbc -in $file -e -k $key -out encryptAES.bin

                avec demande de mot de passe (sans l'option k):

                    openssl aes-256-cbc -in $file -e -out encryptAES_pass.bin

                avec mot de passe en argument:

                    openssl aes-256-cbc -in $file -pass file:pass.txt -out encryptAES2.bin
                    openssl aes-256-cbc -in $file -pass pass:password -out encryptAES2.bin

            RC4 (sans salt)

                openssl rc4 -pass pass:password -e -in $file -out rc4Pass.bin -nosalt
        

        Déchiffrement de fichier
        ``````````````````````````
            openssl rsautl -decrypt -in encrypt.bin -inkey $key -out decrypt.txt    #rsa
            openssl aes-256-cbc -in encrypt.bin -d -k $key -out file_aes.txt    #aes
            openssl aes-256-cbc -in encrypt.bin -d -out file_aes.txt        #demande de mot de passe

        Exportation de la clé publique
        ``````````````````````````
            openssl rsa -in maCle.pem -pubout -out maClePublique.pem

        Calcul de l'empreite
        ``````````````````````````

            openssl dgst -md5 -out empreinte file.txt

        Signer un document
        ``````````````````````````

            openssl rsautl -sign -in empreinte -inkey maCle.pem -out signature

        Vérifier la signature
        ``````````````````````````

            openssl rsautl -verify -in signature -pubin -inkey maClePublique.pem -out empreinte

        Génération d'un paire de clés protégée par mot de passe
        ``````````````````````````

            openssl genrsa -pass pass:password -out maCle.pem 1024

        Exportation de la clé
        ``````````````````````````
            openssl rsa -in maCle.pem -pubout -out maClePublique.pem -pass pass:password

        Etablir une requête
        ``````````````````````````
            openssl req -new -in req.cnf -key maCle.pem -text -out maRequete.pem -outform pem

        Note sur les formats et conversions
        ``````````````````````````

            -Le format par défaut est .pem (.pem, .crt, .cer, .key).
                Un fichier en ASCII avec les mentions ---- BEGIN CERT ---- et ---- END CERT ---
                La clé et le certificat est séparé dans cette forme.

            -Le format der est en binaire (.der, .cer): -outform der
            -Le format PKCS#7 (.p7b, .p7c) : contient uniquement les certifs (+intermédiaire) et les mentions BEGIN/END PKCS7 
            -le format PKCS#12 (.pfx, .p12) : contient les certifs (+intermédiaire) et la clé privée de l'hôte. Le fichier est écrit en binaire.

            Conversions:

                pem -> der
                > openssl x509 -outform der -in certificate.pem -out certificate.der
                
                pem -> p7b
                > openssl crl2pkcs7 -nocrl -certfile certificate.cer -out certificate.p7b -certfile CACert.cer

                pem -> pfx
                > openssl pkcs12 -export -out certificate.pfx -inkey privateKey.key -in certificate.crt -certfile CACert.crt

                der -> pem
                > openssl x509 -inform der -in certificate.cer -out certificate.pem

                p7b -> pem
                > openssl pkcs7 -print_certs -in certificate.p7b -out certificate.cer

                p7b -> pfx
                > openssl pkcs7 -print_certs -in certificate.p7b -out certificate.cer
                > openssl pkcs12 -export -in certificate.cer -inkey privateKey.key -out certificate.pfx -certfile CACert.cer

                pfx -> pem
                > openssl pkcs12 -in certificate.pfx -out certificate.cer -nodes


        Tester la connectivité:
        ``````````````````````````

            > openssl s_client -host hostname -port 636 -CAfile /etc/ssl/certs/ca-certificates.crt
            > openssl s_client -tls1 -connect myhost.com:443
            > openssl s_client -verify 2 -connect localhost:636


~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
subtitle 1
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        subtitle 2
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
