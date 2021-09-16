Impress.js
==============================

What is it ?
-----------------------------

Un outils de présentation à la prezi entièrement gratuit.
Ecrit en html, css et javascript !

Links
-----------------------------

Site off

* [bartaz_github](http://bartaz.github.io/impress.js/#/bored)
* [Github](https://github.com/bartaz/impress.js/)
* [mozilla](https://developer.mozilla.org/en/CSS/transform)

Interface Web :

* [strut](http://strut.io/editor/index.html)


How it works ?
-----------------------------

### Les briques

* Le coeur en javascript pour les mouvements
* Le contenu en html
* La forme en css

### La planche

On créer en faite une planche constituée de points.

On note les coordonnées de chaque point au niveau du html même.

* data-x pour l'axe des abscisses
* data-y pout l'axe des ordonnées
* data-z pour la hauteur

Note: les coordonnées représente le point central de l'image.

Ces points font références à des blocs <div> et contenant nos élements de présentation.

Il faut donc s'assurer que chaque élément soit correctement espacé.

C'est ensuite le coeur en js qui s'occupe d'aller de point en point.
On indique le type de transition entre chaque point au niveau du html.


Installation
-----------------------------

### Impress js :

    git clone https://github.com/bartaz/impress.js

### Progress Bar :

Pour avoir la progressbar :

    git clone https://github.com/m42e/impress.js-progress

Il faut ensuite placer le code suivant avant la div impress :

    <div class="progressbar"><div></div></div>
    <div class="progress"></div>

En rajoutant l'en tête css :

    <link href="css/impress-progress.css" rel="stylesheet" />

Et le script js juste avant le script impress :

    <script src="js/impress-progress.js"></script>

Modifier dans le code js :

    vim js/impress.js

        - triggerEvent(root, "impress:init", { api: roots[ "impress-root-" + rootId ] });
        + triggerEvent(root, "impress:init", { api: roots[ "impress-root-" + rootId ], steps: steps });

### Substep :

[Github](https://github.com/bartaz/impress.js/pull/215)

Note sur ce site: affichez le code et récupérer les codes qui vous interessent:

[substeps](http://lipen.co/impress.js-substeps/#/step-1)

Effectuer ensuite un git diff pour voir les modifications apportées.

### Interface STRUT avec impress

    sudo npm install -g grunt-cli
    sudo apt-get install nodejs-legacy

    git clone git://github.com/tantaman/Strut.git
ou
    git clone https://github.com/tantaman/strut

version 2 en cours :

    git clone https://github.com/tantaman/Strut2

    cd strut
    sudo npm install
    grunt server

=> enjoy localhost:9000

Manipulations
-----------------------------

### Le code

Il faut placer ses <div> entre la div impress:

    <div id="impress">
        <div id="ma_slide" class="type_slide" MES PARAMETRES>

        </div>
    </div>

Note sur l'id :

Il est optionnel, par défaut les slides sont notés #/step-X

### Les transitions

#### Duréer de transition:

Exprimé en ms:

    data-transition-duration="2000"

Par défaut à 1000 (1s)

#### Gestion de la perspective:

[mozilla_perspective](https://developer.mozilla.org/en/CSS/perspective)

Permet de gérer le niveau de perspective

Par défaut à 1000:

    data-perspective="500"

0 = pas d'effet 3D

#### transition normal:

On espace juste deux élements successifs à un endroit différent :

    <div id="step1" class="step slide" data-x="-1000" data-y="-1500">
        <q>CONTENU</q>
    </div>

    <div id="step2" class="step slide" data-x="1000" data-y="-1500">
        <q>CONTENU</q>
    </div>

Dans ce cas les slides sont juste espacés de 1000 px sur l'axe des abcisses X.

#### Changement d'échelle:

Pour changer de taille de slides, on joue sur le paramètre scale

    <div id="title" class="step" data-x="0" data-y="0" data-scale="4"> ... </div>

la 'slide' suivante sera 4 fois plus grosses.

Par défaut data-scale="1"

#### zoomer:

Il suffit de mettre une div plus loin (profond) sur l'axe de hauteur Z.

    <div id="zoom" class="step" data-x="0" data-y="0" data-z="-500" ... > CONTENU </div>

Le contenu sera placé à -500 de profondeur.

Il faut juste bien positionner x et z.

#### dezoom:

idem mais à l'inverse.

Exemple :

    <div id="dezoom" class="step" data-x="0" data-y="0" data-z="1000" data-rotate="0" data-scale="1">

#### rotation

On joue avec le paramètre data-rotate :

    rotation à 90° : data-rotate='90'

    data-rotate => data-rotate-z

Pour avoir un effet de rotation 3D, on créer une rotation autour des autres axes :

   data-rotate-y="5"
   data-rotate-x="10"

 Par défaut la rotation se fait sur l'axe z.
