==========================================================
                       R A I D
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://raid.wiki.kernel.org/index.php/Linux_Raid
    http://www.cyberciti.biz/tips/raid-hardware-vs-raid-software.html

    Tuto imagé :

        http://www.jmax-hardware.com/forum/index.php?topic=3360.0

    Différence entre Raid10 et Raid01 :

        http://www.commentcamarche.net/forum/affich-953505-raid-0-1-raid-10

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Les différents types de raid:

        Légende :

            ( disque ) 
            | : séparation d'une grappe de disques

        RAID 0 :

            ++ lecture
            ++ écriture
            ++ espace (100%)
            -- securité (pas de redondance)

            Ecriture des données étalées sur plusieurs disques.

            ( A ) ( B )

        RAID 1 : 
        
            +  lecture
            -- écriture
            -- espace (50%)
            ++ securité

            Mirroring des données sur plusieurs disques.

            ( A ) ( A )

        RAID 3 et 4 :

            +  lecture
            -- écriture
            -- espace (50%)
            ++ securité

            La parité est isolée sur une grappe de disque.

            ( A ) ( P )
    
        RAID 5 :

            +  lecture
            -  écriture (écriture pénalisée par le calcul de la parité)
            +  espace (n - 1 disque par grappe (dédié à la parité)
            +  securité
            
            Ajout de la parité sur chacune des grappes pour recalculer les infos manquantes en cas de crash d'un disque dur.

            Nécessite au moins 3 disques.

            ( A ) ( P ) | ( P ) ( B ) | ( C ) ( P )


        RAID 6 :

            - lecture
            - écriture (écriture pénalisée par le calcul de la parité)
            - espace (double redondance de la paritée)
            ++ securité

            ( A ) ( P1 ) ( P2 ) | ( P2 ) ( B ) ( P3 ) | ( P1 ) ( P3 ) ( C )
            


        RAID 01 (0 + 1) :

            - ++ perf
            - + securité

            Ecriture des données étalées sur deux disques.
            Réplication à l'exactitude sur une autre grappes de disques

            ( A ) ( B ) | ( A ) ( B )

        RAID 10 (1 + 0) :

            - ++ perf
            - ++ securité

            Ecriture étalées sur deux grappes de diques.
            Chacune des grappes disposent de deux disques ayant la même données :

            ( A ) ( A ) | ( B ) ( B )

        RAID 51

        RAID 15

        X RAID 

        TODO

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
