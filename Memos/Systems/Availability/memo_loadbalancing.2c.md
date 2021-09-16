==========================================================
                L O A D  B A L A N C I N G
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://www.lartc.org/autoloadbalance.html

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Ce sont les méthodes visant à équilibrer la charge sur plusieurs noeuds.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Les types de répartition de charge:

        Round-Robin : Une requête envoyé à chaque noeud du cluster.
        // pondéré : Les noeud de poid fort prennent d'avntage de charge.
        Moins de connexions : Envoie les requêtes au noeud le moins chargé.
        // pondéré : idem mais en tenant compte du poid du noeud.
        Hachage de destination : Répartition en fonction d'une table de hash basée sur les @IP des destinataires.
        Hachage de source : idem mais en fonction de l'emetteur du flux.
        ...

    Protocoles associés:

        VRRP ...


        

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
