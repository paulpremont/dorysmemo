R E V E A L . J S 
==============================

What is it ?
-----------------------------

Reveal.js est un framework JS pour créer des présentation over HTML à la manière d'un power point.  
Il est du même genre que impress.js mais plus statique et plus simple à utiliser.

Links
-----------------------------

### Official

* [Site web](http://lab.hakim.se/reveal-js/#/)
* [Projet Git et documentation](https://github.com/hakimel/reveal.js/)

### Tutos

* [tuto](https://github.com/hakimel/reveal.js/wiki/Articles-&-Tutorials)

### Autre

* [IHM en ligne](http://slides.com/)

How it works ?
-----------------------------

### Structure de l'arborescence de reveal :

* css/ Core styles without which the project does not function
* js/ Like above but for JavaScript
* plugin/ Components that have been developed as extensions to reveal.js
* lib/ All other third party assets (JavaScript, CSS, fonts)

### Structure de base

    <html>
        <head>
            <!-- LOAD FEATURES -->
            <link rel="stylesheet" href="css/reveal.css">
            <link rel="stylesheet" href="css/theme/white.css">
        </head>
        <body>

            <!-- SLIDES CONTENT -->
            <div class="reveal">
                <div class="slides">
                    <section>Slide 1</section>
                    <section>Slide 2</section>
                </div>
            </div>

            <!-- JAVASCRIPT INIT -->
            <script src="js/reveal.js"></script>
            <script>
                Reveal.initialize();
            </script>
        </body>
    </html>

Chaque section définit un nouveau slide.  
Des classes css sont prêtes à l'emploi et peuvent être insérées dans les balises de section par exemple.

Installation
-----------------------------

### Reveal.js :

    git clone https://github.com/hakimel/reveal.js.git
    cd reveal.js
    npm install

### Exemple en mode serveur (optionnel) :

#### Node.js

voir :  

* [Site de nodejs](https://nodejs.org/en/)
* [Download nodejs](https://nodejs.org/en/download/package-manager/)

    curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
    apt-get install nodejs

#### Grunt :

    npm update -g npm
    npm install -g grunt-cli


#### Accès :

    grunt serve [--port 8001]

**http://localhost:8000**


Configuration
-----------------------------

* [configuration](https://github.com/hakimel/reveal.js#configuration)

On place la configuration de reveal juste avant la balise de fin "body" :

Exemple :

    <script>

      Reveal.initialize({
        controls: true,
        progress: true,
        history: true,
        center: true,
        transition: 'slide',
        slideNumber: true,
        ...
      });

    </script>

La configuration peut être mise à jour après l'initialisation avec la méthode .configure :

    Reveal.configure( {foo: X} );

Le theme en revanche, se configure entre les balises "head" :

    <link rel="stylesheet" href="css/theme/sky.css" id="theme">

### Auto-sliding

    // Slide every five seconds
    Reveal.configure({
      autoSlide: 5000
    });

    // Eteindre l'auto-sliding :
    Reveal.configure({ autoSlide: 0 });

Manipulations
-----------------------------

### Raccourcis

* ESCP : mode navigation ou quitter le mode plein écran
* o : mode navigation
* s : mode speaker
* f : full screen
* Up, Down, Left, Right: Navigation
* b ou . : mode pause

### Mode speaker

* [Notes speaker](https://github.com/hakimel/reveal.js#speaker-notes)

à mettre dans la section concernée :

    <aside class="notes">
      Pressez 's' pour voir vos notes perso.
    </aside>

### Disposition des slides (Plan)

Reveal.js fonctionne sur un axe x (horizontal), y (vertical).

    <section>Single Horizontal Slide</section>
    <section>
        <section>Vertical Slide 1</section>
        <section>Vertical Slide 2</section>
    </section>


### Support du markdown

* [readme](https://github.com/hakimel/reveal.js#markdown)

Il est possible d'introduire du markdown directement entre balises script :

Exemple :

    <section data-markdown>
        <script type="text/template">
        <!-- .slide: data-background="#ff0000" -->
            ## Markdown content
            
        </script>
    </section>

Si l'on souhaite ajouter une page à part.
Il est possible de le faire mais si on configure un serveur web local (voir nodejs) :

    <section data-markdown="example.md"  
         data-separator="^\n\n\n"  
         data-separator-vertical="^\n\n"  
         data-separator-notes="^Note:"  
         data-charset="iso-8859-15">
    </section>

### Fragment 

Pour faire apparaître par morceau des infos dans le slide même :

Exemple :

    <section>
      <p class="fragment grow">grow</p>
      <p class="fragment shrink">shrink</p>
      <p class="fragment fade-out">fade-out</p>
      <p class="fragment fade-up">fade-up (also down, left and right!)</p>
      <p class="fragment current-visible">visible only once</p>
      <p class="fragment highlight-current-blue">blue only once</p>
      <p class="fragment highlight-red">highlight-red</p>
      <p class="fragment highlight-green">highlight-green</p>
      <p class="fragment highlight-blue">highlight-blue</p>
    </section>

### Stretch

Pour resizer simplement un élément pour qu'il tienne dans le slide, comme par exemple une image :

    <img data-src="images/foo.png" class="stretch"/>


Template
-----------------------------

    <!doctype html>                                                                               
    <html lang="en">
     
      <head>
        <meta charset="utf-8">
     
        <title>reveal.js – The HTML Presentation Framework</title>
     
        <meta name="description" content="A framework for easily creating beautiful presentations using HTML">
        <meta name="author" content="Hakim El Hattab">
     
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
     
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
     
        <link rel="stylesheet" href="css/reveal.css">
        <link rel="stylesheet" href="css/theme/black.css" id="theme">
     
        <!-- Theme used for syntax highlighting of code -->
        <link rel="stylesheet" href="lib/css/zenburn.css">
     
        <!-- Printing and PDF exports -->
        <script>
          var link = document.createElement( 'link' );
          link.rel = 'stylesheet';
          link.type = 'text/css';
          link.href = window.location.search.match( /print-pdf/gi ) ? 'css/print/pdf.css' : 'css/print/paper.css';
          document.getElementsByTagName( 'head' )[0].appendChild( link );
        </script>
     
        <!--[if lt IE 9]>
        <script src="lib/js/html5shiv.js"></script>
        <![endif]-->
      </head>

    <body>
      <div class="reveal">
        <div class="slides">
          <section>Slide 1</section>
          <section>Slide 2</section>
        </div>
      </div>
    </body>


Reveal-md : support complet du markdown
-----------------------------

Sources : [reveal-md](https://github.com/webpro/reveal-md)

Ce projet permet d'écrire entièrement vos présentations en markdown :

    sudo aptget install npm
    sudo npm install -g reveal-md

Ecrire sa présentation en markdown puis la builder :

    reveal-md path/to/my/slides.md
