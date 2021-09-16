==========================================================
                    A N G U L A R
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    site off:

        https://angularjs.org/

    Courses:

        http://campus.codeschool.com/courses/shaping-up-with-angular-js/level/1/section/1/video/1

    Guide:

        https://docs.angularjs.org/guide

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Angular est un framework Javascript coté Client (Front End).
    Il permet d'indiquer au code HTML quand exécuter du javascript grâce à des directives.

    Il agit niveau Frontend et s'utilise dans les cas suivants:

        - dès que l'on a besoin d'organiser son code JS, 
        - Si l'on souhaite ajouter de la responsivity (un site web réactif en temps réel).
        - Il se mari bien avec Jquery.
        - Facile à tester.

    Voir memo_web pour voir plus de détails sur l'architecture Frontend/Backend over WebSocket.
    Cette dernière permet d'établir de vrai applications web réactives.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > wget https://code.angularjs.org/1.3.14/angular-1.3.14.zip

    voir: https://code.angularjs.org/

    On pourra ensuite utiliser angularjs grâce à la balise script dans son fichier HTML:

        Exemple:

            <script type="text/javascript" src="angular.min.js"></script>


~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Angular utilise un système de tag au sein du code html (directives) 
    et l'interpréte ensuite grâce aux controllers (fonctions) écrits par nos soins et de leur portée (scope).

        --------------------------
        Controllers
        --------------------------

            Les controllers vont nous permettre de décrire le comportement de nos applications en définissant les fonctions à implémenter pour interpréter des objets JS.

            Exemple de définition d'un controller:

            Au niveau du JS:

                function FirstController(){
                    alert('Mon premier controller !');
                }

            Au niveau du code HTML:

                <body ng-controller="FirstController">
                    ...
                </body>

            Dès l'ouverture de la page un popup apparaitra "Mon premier controller!".


        --------------------------
        Directives
        --------------------------

            https://docs.angularjs.org/guide/directive

            Les directives permettent d'indiquer à Angular quoi substituer et quel modules/fonction js il doit implémenter.

            Ces directives sont des mots clé de type:

                - ng-controllers            #Appeler un controller
                - ng-app                    #Insérer un module
                - ng-show                   #Afficher un élement si 'true'
                - ng-hide                   #Inversement
                - ng-repeat                 #Répéter l'affichage
                ...

        --------------------------
        Modules
        --------------------------

            Les modules vont permettre d'ajouter de la segmentation logique dans le code.
            On va pouvoir y écrire des parties de nos applications angular.
            Et les dépendances de nos applications.

            Exemple de déclaration d'un module:

                var app = angular.module('APP_NAME', [DEPENDENCIES]);

            à placer dans son fichier js:

                Pour inclure ce fichier on utilise la balise script dans son HTML:
                Le chargement du module se fera grâce à la directive 'ng-app'

                    <html ng-app="APP_NAME">

                        <script type="text/javascript" src="app.js"></script>

                    </html>


        --------------------------
        Expressions
        --------------------------

            Les expressions sont substituées au sein du code html.

            On les place entre double accolades:

            {{ mon expression }}

            Exemple:

                <body>
                    <p>
                        {{ 5 + 10 }}
                        {{ "coucou" + "toi" }}
                    </p>
                </body>

        --------------------------
        Filtres
        --------------------------

            Permettent de traiter et de former l'output des données.

            template:
                
                {{ data* | filter:options* }}

            exemples:

                {{ product.price | currency }}              #chiffres avec deux décimales et le $
                {{ timestamp | date:'MM/dd/yyyy @ h:mma'}}  #Formatage de la date
                {{ 'string' | uppercase }}                  #Majuscules
                {{ 'blabla' | limitTo:3 }}                  #3 premières lettres

            Peut fonctionner sur les paramètres founits à une directive:

                exemple:

                    <li ng-repeat="product in store.products | limitTo:3">
                    <li ng-repeat="product in store.products | orderBy:'-price'">   #price pour un tri croissant.



        --------------------------
        Tableau
        --------------------------

            exemple

                var object = [
                    {
                        tableau: [
                            {
                                key: value,
                                ...
                            },
                            ...
                        ],
                        ...
                    }
                ]

                ng-src="{{object.tableau[X].key}}"       #donnera value

            /!\ a l'implémenter dans une directive pour éviter que le navigateur essaye de charger du contenur avant l'évaluation de l'expression.

            Connaitre la taille d'un tableau:

                tableau.length (renvoie false si vide)

        --------------------------
        Services Angular
        --------------------------

            Todo:

                $scope: 
                $http


~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Insérer Angular
        --------------------------

            <head>
                <script type="text/javascript" src="angular.min.js"></script>
                ...
            </head>

        --------------------------
        Insérer/Créer un module
        --------------------------

            On appel la directire ng-app:

            Exemple:
                __________________________
                html:

                    <html ng-app="appName">       #appel du module:

                        <head>
                            ...
                            <script type="text/javascript" src="app.js"></script>
                            ...
                        </head>

                    </html>


                __________________________
                js (app.js):

                    var app = angular.module('appName', []);

                    #ou encore il est conseillé de délimiter son app avec une fonction:

                    Exemple:

                        (function(){
                            var app = angular.module('appName', [ ]);

                            app.controller('myController', function(){

                                #Propriétés ...
                                
                            });

                            #Variables ...

                        })();

        --------------------------
        Insérer une fonction
        --------------------------

            grâce à la directive ng-controller

            exemple:

                __________________________
                html:

                    <body ng-controller="StoreController">
                        ...

                __________________________
                js:

                    function StoreController(){
                        alert('Welcome, Gregg!');
                    }

        --------------------------
        Créer un controller
        --------------------------


            On définit au niveau du contrôleur des propriétés qui seront disponibles dans notre code HTML.

            Il est possible de définir un alias lors de l'incusion d'un contrôleur dans sa page HTML pour l'appeler plus facilement par la suite.

            /!\ Attention au scope d'application d'un contrôleur.
            Il s'applique uniquement sur à l'intérieur des balises où il est déclaré (et les balises enfantes)

            Exemple:

                __________________________
                js:

                    #-- module:
                    (function(){
                        var app = angular.module('store', [ ]);

                        #-- controller:

                        app.controller('StoreController', function(){

                            #-- définir une propriété du conteneur (product)
                            this.product = gem;

                        });

                        #-- objet:
                        var gem = {
                            name: 'Dodecahedron',
                            price: 2.95,
                            description: '...',
                        }

                    })();

                __________________________
                html:

                    <div ng-controller="StoreController as store">
                        <h1> {{store.product.name}} </h1>
                        <h2> {{store.product.price}} </h2>
                        <p> {{store.product.description}} </p>
                    </div>

                    Note: on peut définir un alias avec le mot clé 'as' placé au niveau de la directive.

                    /!\ la directive ng-controller définit un scope, c'est à dire qu'elle s'applique uniquement dans le conteneur où elle est définit (par exemple le div sur l'exemple ci-dessus)

        --------------------------
        Afficher un élément avec condition:
        --------------------------

            en utilisant un booléen:

                __________________________
                js:

                    app.controller('StoreController', function(){
                        this.product = gem;
                    });

                    var gem = {
                        ...
                        canPurchase: true
                    }

                __________________________
                html:

                    Si l'élement est 'True'

                        <button ng-show="store.product.canPurchase"> Add to Cart </button>

                    Si l'élément est 'False' (ou rajoute '!')

                        <button ng-show="!store.product.canPurchase"> Add to Cart </button>

            Autre exemple:

                En fonction de la taille d'un tableau:

                {{tags.length>1?'On vient!':'Je viens!'}}

        --------------------------
        Boucler sur un élément:
        --------------------------
                __________________________
                js:

                    app.controller('StoreController', function(){
                        this.products = gems;
                    });

                    var gems = [
                        {
                            name: "bidul",
                            price: 5,
                        },
                        {
                            name: "boudiou",
                            price: 10,
                        }...
                    ];

                __________________________
                html:

                    <body ng-controller="StoreController as store">
                        <div ng-repeat="product in store.products">
                            <h1> {{product.name}} </h1>
                            <h2> {{product.price}} </h2>
                        </div>
                    </body>

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
