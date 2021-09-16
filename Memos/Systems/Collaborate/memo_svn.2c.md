==========================================================
                S U B V E R S I O N
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    apt-get install subversion

~~~~~~~~~~~~~~~~~~~~~~~~~~
Repos
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Création
        --------------------------

            svnadmin create repository

        --------------------------
        Importation
        --------------------------

            svn checkout URL_REPO MON_REPO

        --------------------------
        Mettre à jour un repo
        --------------------------

            svn update MON_REPO
            svn update -r REVISION # Changer de révision

        --------------------------
        Logs
        --------------------------

            svn log -v

~~~~~~~~~~~~~~~~~~~~~~~~~~
Commit
~~~~~~~~~~~~~~~~~~~~~~~~~~

        svn commit -m 'monMEssage' [REPO]

        --------------------------
        Fichiers
        --------------------------

            svn add FICHIER
            svn movre FICHIER DEST
            svn copy FICHIER DEST
            svn delete FICHIER

            Vérouiller un fichier pour ne pas qu'il soit changé:

                svn lock FICHIER
                svn unlock FICHIER

            Copier un fichier d'une autre révision:

                svn copy -r XX /PATH_TO_EXT_REPO/FICHIER /LOCAL_REPO/FICHIER

        --------------------------
        Merge
        --------------------------

            Automatique (lorsque les données ne se recoupent pas)

            Manuel:
                Editer manuellement les fichiers qui posent problème
                svn resolved FICHIER
                svn commit -m 'Merge done'

        --------------------------
        Vérifications
        --------------------------

            svn status  #Afficher les fichiers modifiés
            svn diff FICHIER #Afficher les modifications apportées sur un fichier

                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
