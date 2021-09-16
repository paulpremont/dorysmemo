=====================================================================
			Memo CSS
=====================================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Compatibilité
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Compatibilité des navigateurs et du css : www.caniuse.com et normansblog.de

~~~~~~~~~~~~~~~~~~~~~~~~~~
Appliquer du css
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Sur des balises
        --------------------------

                balise, balise2...
                {
                        propriété: valeur;
                        //...
                }

                Pour ne pas tout entasser on peu mettre les différents élements les un sur les autres:

                balise1,
                balise2,
                balise3 {
                        CodeCss
                }

        --------------------------
        Sur des classes
        --------------------------

                .class
                {...}

                Note:
                        Pour bien clarifier la classe sur un élément on peu écrite:

                                element.class

                        exemple:
                                
                                h3.maClass { CODE_CSS; }

        --------------------------
        Sur des ids
        --------------------------

                #id
                {...}

        --------------------------
        Selecteurs
        --------------------------

                *
                {...} /* selectionne tout */
                
                balise1 balise2
                {...} /* selectionne les balise2 contenu dans la balise1 */
                
                balise1 + balise2
                {...} /* selectionne la premiere balise2 située apres une balise1*/
                
                balise[Attribut]
                {...} /*selectionne toute les balises "balise" qui possedent l'attribut "Attribut"*/
                
                balise[Attribut="valeur"]
                {...} /*idem en plus d'avoir exactement la valeur "valeur" */
                
                balise[Attribut*="word"]
                {...} /* idem mais cette fois l'attribut dois seulentment contenir le mot 'word' peu importe sa position */ 

                #id.class1.class2
                {...} /* Selectionne la balise avec un id et des classes de même niveau */

                d'autre selecteur : http://www.w3.org/Style/css3-selectors-updates/WD-css3-selectors-20010126.fr.html#selectors


        --------------------------
        Apparence dynamique
        --------------------------

                Survol:
                        balise:hover
                        {...} /*S'applique lorsque la souris survol la balise*/
                Au clic
                        a:active
                        {...} /*S'applique lorsque l'on clic sur la balise, utilisé surtout pour les liens*/
                Selection
                        balise:focus
                        {...} /*S'applique lorsque la balise est séléctionné (une fois cliqué le lien reste selectionné par exemple, fonctionne avec tab sur Chrome*/
                Visité
                        a:visited
                        {...} /*S'applique à un lien vers une page déja vue*/

~~~~~~~~~~~~~~~~~~~~~~~~~~
Commentaire
~~~~~~~~~~~~~~~~~~~~~~~~~~

        /* Commentaire */

~~~~~~~~~~~~~~~~~~~~~~~~~~
Propriétés css
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Désactiver une propriété
        --------------------------

                Le plus communément, il suffit de mettre la valeur 'none' à la proprité CSS:

                propriété: none;

        --------------------------
        Texte
        --------------------------
                __________________________
                Couleur
                
                        color : white;/*(white,silver,grey,black,red,maroon,lime,green,yellow,olive,blue,navy,fuchsia,purple,aqua,teal)*/
                        color : #FFFFFF; /*(notation hexadecimale)*/
                        color : rgb(XX,YY,ZZ); /*notation Red Green Blue);*/

                __________________________
                Taille du texte

                        font-size: 1.0em; /* valeur à faire varier = 100%; */

                                XXpx; /* n'est pas conseillé (n'est pas modulable) */ 
                                xx-small : minuscule
                                x-small : très petit
                                small : petit
                                medium : moyen
                                large : grand
                                x-large : très grand
                                xx-large : énorme

                __________________________
                Polices

                        Note: il vaut mieux cumuler plusieurs polices dans le cas où le navigateur ne reconnais pas les premières.

                        font-family: police1, police2..., serif;
                                        Arial
                                        "Arial Black"
                                        "Comic Sans MS"
                                        "Courier New"
                                        Georgia
                                        Impact
                                        "Times New Roman"
                                        "Trebuchet MS"
                                        Verdana

                        Les polices personnalisées:
                        ``````````````````````````

                                @font-face { /* Définition d'une nouvelle police nomé NP */
                                        font-family: 'NP';
                                        src: url('NP.ttf') format('truetype'), /*IE9 et autres browser*/
                                             url('NP.eot') format('eot'), /*IE uniquement*/
                                             url('NP.otf') format('otf'), /*pas sur IE*/
                                             url('NP.svg') format('svg'), /*Pour Iphone et Ipad*/
                                             url('NP.woff') format('woff'); /*Nouveau format pour tout les browser*/
                                        }
                                        
                                balise
                                {
                                        font-family: NP, serif;
                                }
                                                        
                                d'autres police libres sur : fontsquirrel.com, dafont.com, Google Web Fonts 

                __________________________
                Styles

                        font-style: normal;
                        font-style: italic;

                __________________________
                Poids

                        font-weight: bold; (mettre en gras)
                __________________________
                Décoration

                        text-decoration: underline; /* souligné */
                                         line-through; /* barré */
                                         overline; /* ligne au dessus */
                                         blink; /* clignotant */
                                         none ; /* normal (par défaut) */

                __________________________
                Ombres sur du texte

                        text-shadow: Xpx Ypx Zpx color; /*idem que pour les boîtes*/
                __________________________
                Débordement de texte (couper du texte)

                        word-wrap: break-word;
                                   pre : pour la laisser telle quelle.

        --------------------------
        Blocks
        --------------------------
                __________________________
                Alignement du texte

                        text-align: left; /* par défaut */
                                    center;
                                    right;
                                    justify;

                        Tableaux
                        ``````````````````````````
                                caption
                                {
                                        caption-side: top; /* changer la position d'un titre de tableau */
                                                        bottom;
                                                        left;
                                                        right;	
                                }

                __________________________
                Indenter du texte:

                        text-indent: Xpx;

                        Fonctionne sur les bloc type "relative, absolute, fixed"

                __________________________
                Flottants (fonctionne sur inline et block)

                        float: left;
                               right;
                               
                        Arreter un flottant
                        ``````````````````````````
                                clear: both;
	
                __________________________
                Fond / Background


                        Couleur
                        ``````````````````````````
                                background-color : black; /*ou méthode hexa et RGB*/

                        Image
                        ``````````````````````````
                                background-image : url("image.png");

                                Empiler des images de fond:

                                        background: url("image.png") fixed no-repeat top right, url("fond.png") fixed; /*La premiere image est placés par-dessus...*/

                        Déplacement du fond
                        ``````````````````````````

                                background-attachment: fixed; /*l'image reste fixe*/
                                                       scroll; /*l'image défile avec le texte*/

                        Répétition du fond
                        ``````````````````````````
                                background-repeat: no-repeat; /*image unique à la page*/
                                                   repeat-x; /*repetion horizontale*/
                                                   repeat-y; /*repetition vertivale*/
                                                   repeat; /*repetition en mosaïque (par déf)*/

                        Position du fond
                        ``````````````````````````
                                background-position: Xpx Ypx; /*Xpixels gauche et Ypixels haut*/
                                                     top right;
                                                     bottom left;
                                                     center center; /*...*/

                        Taille du fond
                        ``````````````````````````
                                background-size: Xpx;

                        Forme compact:
                        ``````````````````````````
                                background: url("image.png") fixed no-repeat top right;

                        Dégradé linéaire:
                        ``````````````````````````
                                Link: http://css.mammouthland.net/css3/degrades-sans-image.php

                                background-image:linear-gradient(white, black); #Dégradé de haut en bas;
                                background-image:linear-gradient(to right, white, black); #Dégradé de gauche à droite
                                background-image:linear-gradient(60deg, white, black); #Dégradé en fonction d'un angle

                                Pour la compatibilité:

                                        background-image:-moz-linear-gradient(30deg, white, black);
                                        background-image:-webkit-linear-gradient(30deg, white, black);
                                        background-image:-o-linear-gradient(30deg, white, black);
                                        background-image:linear-gradient(60deg, white, black);

                        Dégradé radial:
                        ``````````````````````````
                                background-image:radial-gradient(white, black);

                        Transparence RGBa
                        ``````````````````````````
                                background-color: rgb(255,0,0); /*pour les anciens browser*/
                                background-color: rgba(255,0,0,0.5); /*pour les browsers actuel*/

                __________________________
                Transparence

                        Note: s'applique à tout les élements du bloque.

                        opacity: 0.5; /* 1 = opaque ; 0 = transparent ; s'applique en plus au contenu de cet élément, il faut préférer la notation RGBa */
                        
                __________________________
                Bordures

                        Modèle
                        ``````````````````````````

                                border Npx COLOR STYLE;

                                exemple:
                                        border: 5px green solid;

                        Les styles
                        ``````````````````````````

                                border-style: STYLE;

                                none; /*pas de bordure (par def)*/
                                dotted; /*pointillés*/
                                dashed; /*tirets*/
                                double; /*bordure double*/
                                groove; /*en relief*/
                                ridge; /*autre effet relief*/
                                inset; /*effet 3D enfoncé*/
                                outset; /*effet 3D surélevé.*/

                        Sélection de la bordure:
                        ``````````````````````````

                                border-top: ....;
                                border-bottom:...;
                                border-left:...;
                                border-right:...;

                        Arrondi
                        ``````````````````````````
                                border-radius: Xpx; /*s'applique à tous les angles*/
                                border-radius: Wpx Xpx Ypx Zpx; /*Whaut_gauche Xhaut_droite Ybas_droite Zbas_gauche*/

                        Elliptiques
                        ``````````````````````````
		
                                border-radius: Xpx / Ypx; /*tester pour voir l'effet :)*/

                        Tableau
                        ``````````````````````````
                                table
                                {
                                        border-collapse: collapse; /* Les bordures du tableau seront collée */
                                }

                __________________________
                Ombres

                        box-shadow: Xpx Ypx Zpx color <inset>; /*X : décalage verticale
                                                        Y : décalage horizontale
                                                        Z : adoucissement du dégradé
                                                        color : couleur de l'ombre
                                                        inset : pour que l'ombre soit à l'intérieur*/
						
                __________________________
                Taille

                        width: X%; /*largeur (ou exprimé en px)*/
                        height: X%; /*hauteur*/
                        
                        min-width: /*largeur min*/
                        min-height: /*hauteur min*/
                        max-width:
                        max-height: 
		
                __________________________
                Marges


                        padding: Xpx;/*marge intérieure*/
                        margin: Xpx;/*marge extérieure*/
                        
                        padding-top: Xpx; /*marge intérieure en haut*/
                        ...
                        
                        margin: Wpx Xpx Ypx Zpx; /*Whaut, Xdroite, Ybas, Zgauche*/
                        padding: Xpx Ypx; /*X haut et bas, Y gauche et droite*/
                        
                        
                        Centrer un bloc
                        ``````````````````````````
                                width: Xpx; /*il faut donner une largeur au préalable*/
                                margin: auto;
		

                __________________________
                Couper un bloc:

                        S'applique lorsque le contenu dépasse le contenant.

                        overflow: hidden;       couper le contenu
                        overflow: auto;         couper le contenu avec barre de défilement
                        
	
                __________________________
                Affichage:
	
                        display: inline; /*Se placent les uns à côté des autres*/
                        display: block; /*Se placent les uns en-dessous des autres et peuvent être redimensionnés*/
                        display: inline-block; /*Elements se placent les uns à coté des autres et qui peuvent être redimensionnés.*/
                        display: none; /*Element non affiché*/
	
	
                        compatibilité du inline-block avec IE < 8, créer un nouveau fichier css
                        ``````````````````````````
                                <head>
                                         <!--[if lte IE 7]>
                                          <link rel="stylesheet" href="style_ie.css" />
                                         <![endif]-->
                                </head>
                                
                                /*éditer le nouveau fichier*/
                                balise
                                {
                                        display: inline;
                                        zoom: 1;
                                }
	
                __________________________
                Positions

                        position: absolute;     #Pour positionner par rapport au cadre du navigateur.
                        position: fixed;        #Pour positionner par rapport au cadre du navigateur mais le block reste fix.
                        position: relative;     #Pour positionner par rapport au point d'origine du bloc. (Haut gauche)

                        Régler la poistion:
                        ``````````````````````````
                                
                                left: Xpx ou X%;
                                right: Xpx ou X%;
                                top: Xpx ou X%;
                                bottom: Xpx ou X%;

                        Gérer la priorité d'affichage:
                        ``````````````````````````
                                z-index: X;     #Le dernier est le plus fort
	
                __________________________
                Tableaux

                        Alignement vertical reservé aux tableaux et aux "inline-bloc"
                        ``````````````````````````
                                vertical-align: top; /*aligne en haut*/
                                                baseline; /*aligne la base de l'élément avec celle de l'élement parent (par def)*/
                                                middle; /*aligne au milieu*/
                                                bottom; /*aligne en bas*/
                                                Xpx ou X%; /*aligne à X distance de la ligne de base (baseline)*/
                __________________________
                Listes à puces
	
                        Link:
                        ``````````````````````````
                                http://www.w3schools.com/cssref/pr_list-style-type.asp

                        Modèle
                        ``````````````````````````
                                list-style-type: STYLE;

                        Styles
                        ``````````````````````````
                                square: carré
                                none: pas d'effet

                        Mettre une image à la place
                        ``````````````````````````
                                list-style-image:
                                list-style-position:
