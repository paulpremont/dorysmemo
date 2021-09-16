==========================================================
                T E CH N O    D U       W E B 
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Architecture
        --------------------------

            Note sur le fonctionnement moderne des applications Web:

            Avant:

                [Server (BE)]                                           [Client (FE)]
                                        requette http
                   php,...              <---------          1: demande de la page à visualiser

               2: Calcul du code html  html/javascript      3: visualisation du code html, calcul du js
                                        --------->               

            Plus moderne:

                [Server (BE)]               AJAX/AJAJ                     [Client (FE)]

                                        requette http
                 php,nodejs             <---------           1: demande d'information sous format JSON,XML ...

               2: Récupération et            json/xml        3: calcul de la vue
                formatage des donnnées  --------->              chargement des données dans la page existante.


                Note: 
                    il existera tout de même une première initialisation où le serveur enverra au client le code du site web avant de répondre sous forme json/xml.


            Websocket et catalogue de service (todo)

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
