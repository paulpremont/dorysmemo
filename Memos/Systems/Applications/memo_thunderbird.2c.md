==========================================================
                T H U N D E R B I R D
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Un client de messagerie

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install thunderbird

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Grouper les messages par thread
        --------------------------

            Menu / View / Sort By / Threaded

~~~~~~~~~~~~~~~~~~~~~~~~~~
Plugins
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Enigmail
        --------------------------

                __________________________
                Installation:

                    https://addons.mozilla.org/fr/thunderbird/addon/enigmail/

                    Chiffrer ces mails grâce à PGP et le module enigmail:


                    Téléchargement du module:
                    ``````````````````````````

                        > wget https://addons.mozilla.org/thunderbird/downloads/latest/71/addon-71-latest.xpi?src=dp-btn-primary

                    Installation du module:

                        > MENU / Add-Ons / Settings / Install From File

                    Upgrade gpg:
                    ``````````````````````````
                        Enigmail requiert maintenant d'avoir la version 2 de gpg :

                            > apt-get install gnupg2

                    Importation des clés gpg:
                    ``````````````````````````

                        > cd monDossierDeClé
                        > gpg --import *

                    Générer une paire de clé:
                    ``````````````````````````

                        Il est possible de générer sa paire de clé depuis le menu enigmail / Key management

                    Chiffrement/Déchiffrement des clés
                    ``````````````````````````

                        Le chiffrement est proposé automatiquement lorsque enigmail trouve une clé correspondant à l'adresse du destinataire.

                        Sinon pour utliliser une autre clé publique:

                            Il faudra créer de nouvelles règles dans Enigmail/Edit Per-Recipient rules

                        Idem le déchiffrement est ensuite proposé avec votre clé privée ou la clé privée associée avec la clé publique utilisée pour le chiffrement.




        --------------------------
        Conversation
        --------------------------

            Regrouper les mails par conversation (gmail like)

            https://addons.mozilla.org/fr/thunderbird/addon/gmail-conversation-view/

            Ce plugin est très éfficace pour trier ses mails !

            Pas de configuration nécessaire, il faut juste passer par le Menu Add-ons de thunderbird pour être sur qu'il soit compatible avec sa version d'Enigmail par exemple.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Toubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        GPGV2
        --------------------------

                __________________________
                Logs:

                    Gnome Keyring hijack the connection to GPG Agent

                __________________________
                Description:

                    Après l'update de gpg en v2, il se peut qu'il y ait des problèmes, où du moins des messages d'erreur qui popup lorsqu'on chiffre/déchiffre nos email.
                    Il faut donc voir ce qu'il se passe au niveau des logs (voir le menu enigmail/debug)

                __________________________
                Résolution:

                    https://wiki.gnupg.org/GnomeKeyring
                    http://ubuntuforums.org/showthread.php?t=1655397

                    Attention, ne pas supprimer le paquet entierement, car il peut être utilisé par d'autres applications.

                    Désactiver le gpg-agent de Gnome keyring

                        > sudo dpkg-divert --local --rename --divert /etc/xdg/autostart/gnome-keyring-gpg.desktop-disable --add /etc/xdg/autostart/gnome-keyring-gpg.desktop 

                    (Cette méthode n'a pas fonctionné sur mon système), juste changer les droits sur le binaires par exemple :

                        > sudo chmod 400 /usr/bin/gnome-keyring-daemon
