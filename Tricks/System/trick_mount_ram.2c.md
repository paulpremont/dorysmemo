=====================================
Créer un point de montage en RAM pour augmenter les performances de lecture/écriture
=====================================

~~~~~~~~~~~~~~~~
LINKS
~~~~~~~~~~~~~~~~
        http://www.generation-linux.fr/index.php?post/2009/05/04/tmpfs-%3A-utiliser-sa-ram-comme-repertoire-de-stockage
        http://www.thegeekstuff.com/2008/11/overview-of-ramfs-and-tmpfs-on-linux/

~~~~~~~~~~~~~~~~
METHODES
~~~~~~~~~~~~~~~~
        -------------------
        Ramfs
        -------------------

                La taille est gérée dynamiquement ce qui peut être très pratique lorsqu'on ne connait pas à l'avance la taille des fichiers à y mettre.
                Cette méthode n'utilise pas le swap et donc aucun ralantissement à prévoir, par contre moins permissif pour le coup.

        -------------------
        Tmpfs
        -------------------

                Utilise un espace de stockage fix et peut swaper les données.
        
~~~~~~~~~~~~~~~~
FIGHT
~~~~~~~~~~~~~~~~

        -------------------
        TMPFS
        -------------------
                __________________
                Création du folder:

                        >: mkdir /tmpfs
                __________________
                Montage du tmpfs

                        >: mount -t tmpfs -o size=XXM tmpfs /tmpfs

                __________________
                MOntage automatique dans la fstab

                        tmpfs /tmpfs tmpfs defaults,size=1g 0 0

        -------------------
        RAMFS
        -------------------
                __________________
                Création du folder:

                        >: mkdir /ramfs
                __________________
                Montage du tmpfs

                        >: mount -t ramfs -o size=XXM ramfs /ramfs

                __________________
                MOntage automatique dans la fstab

                        ramfs   /ramfs     ramfs  defaults   0     0
