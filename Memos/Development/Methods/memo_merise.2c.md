==========================================================
                       M E R I S E
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://fr.wikipedia.org/wiki/Merise_%28informatique%29
    http://www.commentcamarche.net/contents/merise-3951059520
    http://www.commentcamarche.net/contents/655-merise-initiation-a-la-conception-de-systemes-d-information


~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    C'est uné méthode d'analyse, de conception et gestion de projet informatique.
    Il s'emploi facilement dans le monde de la base de données.
    Pour la conception de programmes, il vaut mieux se tourner vers une méthode unifiée de type UML.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    La méthode Merise s'appliquer au travers de trois Niveaux:
        - Conceptuel
        - Logique
        - Physique

    Avec une séparation de l'anlyse des données et du traitement dans chaque niveau.
        

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        MCD - Modèle conceptuel des données
        --------------------------

            Consiste à modéliser se qui va être utile pour la base de données.
            Il faut que l'objectif de l'application soit clairement définit.
            Le MCD doit correspondre au réel.

            Il repose sur une notions d'entité et d'association. Il s'intéresse à la sémantique du domaine.

                __________________________
                L'entité.

                    L'entité est perçu comme un objet et bénéficie de plusieurs propriétés atomiques dont l'une est discriminante (l'identifiant).

                    exemple avec une entité chaise:

                        Chaise[ID, couleur, taille_dossier, ...]


            /!\ Le MCD ne doit idéalement pas les valeurs calculées.

                __________________________
                Relation/Associations

                    C'est un lien sémantique entre entités:
                    Une association peut contenir une propriété comme une date par exemple et comporte une information de cardinalité.
                    Elle est symbolisée par un verbe.

                        Nomination d'association:
                        ``````````````````````````

                            - Réflexive : entité reliées à elle-même.
                            - Binaire : une relation entre 2 entités.
                            - Ternaire : 3 entités reliées entre elles.
                            ...

                        Cardinalité
                        ``````````````````````````

                            C'est une indication sur le nombre min et max qu'un entité peut participer à une association.

                            0,1
                            1,1
                            0,n
                            1,n

                        Type d'association:
                        ``````````````````````````

                            - CIF (Contrainte d'intégrité fonctionnelle)
                                Elles sont binaire avec une cardinalité min à 0 ou 1 et une cardinalité max à 1 ou n.
                            - CIM (Contrainte d'intégrité multiple)
                                Elles ont toutes leur cardinalité max à n et peuvent porter des propriétés.

                    Exemple:

                        http://pagesperso.lina.univ-nantes.fr/~vailly-a/Enseignement/EMIAGE/Chantier/A354/Images/imagesB302/imglic54.gif
                        http://sqlpro.developpez.com/cours/bddexemple/images/mcdHotel.gif
                        http://blog.developpez.com/media/AGGIR_MCD_800.gif

                        CHAMBRE(CHB_ID, ...) <- 1,n -> coute[Tarif_CHB] <- 1,n -> TARIF(TRF_TAUX, TRF_DATE_DEBUT ...)

        --------------------------
        MCT - Modèle conceptuel de traitement
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
