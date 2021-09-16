==========================================================
		Memo HTML
==========================================================
~~~~~~~~~~~~~~~~~~~~~~~~~~
Références html
~~~~~~~~~~~~~~~~~~~~~~~~~~

        http://www.w3schools.com/tags/
	
~~~~~~~~~~~~~~~~~~~~~~~~~~
Le code minimaliste
~~~~~~~~~~~~~~~~~~~~~~~~~~
	
		<!DOCTYPE html>
		<html>
		    <head>
			<meta charset="utf-8" />
			<link rel="stylesheet" href="style.css" />
			<link rel="icon" type="image/png" href="pictures/tab_picture.png" /> <!-- icone de l'onglet (facultatif) -->
			<title>MyWebSite</title>
		    </head>

		    <body>
		    </body>
		</html>

~~~~~~~~~~~~~~~~~~~~~~~~~~
Appliquer du css (mise en forme)
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Sur une balise même
        --------------------------

                <balise style="CODE CSS">

        --------------------------
        Dans un fichier
        --------------------------

                à placer dans le <head>:

			<link rel="stylesheet" href="CSS_FILE" />

        --------------------------
        Dans une balise style
        --------------------------

                <style type="text/css">
                        Mon CSS
                </style>

~~~~~~~~~~~~~~~~~~~~~~~~~~
Commentaires
~~~~~~~~~~~~~~~~~~~~~~~~~~

        <!-- Commentaires -->

~~~~~~~~~~~~~~~~~~~~~~~~~~
Les balises block
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Une balise de type block créer un retour à la ligne.

        --------------------------
        Paragraphes
        --------------------------

                <p> paragraphe </p>

        --------------------------
        Listes
        --------------------------

                <ul> liste non ordonnée <!-- délimite la liste -->
                        <li>liste à puce</li>  <!-- délimite un élement de la liste -->
                </ul>

                <ol> liste ordonnée
                        <li>liste à puce</li>
                </ol>

                <dl> Liste de définition
                        <dd> Terme </dd>
                                <dt> Définition </dt>
                </dl>

        --------------------------
        Les figures
        --------------------------

                sert à marquer une figure, à y attacher de l'importance.

                <figure>
                        <img src="image.jpg" alt="image" />
                        <figcaption>Définition de l'image</figcaption>
                </figure>

        --------------------------
        Universelle
        --------------------------

                <div>
                        <!-- contenu -->
                </div>

        --------------------------
        Exemple de structure
        --------------------------

                <body> <!-- corps de la page -->	
                        <header>
                                <!-- Contenu de l'en-tête de la page
                                        <h1>My Web Site</h1> -->
                        </header>
                
                        <nav>
                                <!-- Principaux liens de navigation (exemple menu)
                                        <ul>
                                                <li><a href="index.html">Accueil</a></li>
                                        </ul> -->
                        </nav>
                
                        <section> <!-- Regroupe le contenu en fonction de leur thématique 
                                        <h1>Ma section de page</h1>
                                        <p>Bla bla bla</p> -->
                        
                                <aside>
                                <!-- Informations complémentaires au document que l'on visualise -->
                                </aside>
                        
                                <article>
                                <!-- Englobe une portion autonome de la page (exemple un article)
                                        <h1>Mon article</h1>
                                        <p>Bla bla bla</p> -->
                                </article>
                
                        </section>
                        
                        <footer>
                                <!-- Contenu du piede de page -->
                        </footer>
                </body>

        --------------------------
        Tableaux
        --------------------------

                <table>
                        <caption> Titre du tableau (facultatif) </caption>
                
                        <thead> <!-- En tête du tableau (pour gros tableau)-->
                
                                <tr> ligne d'en tête (facultatif)
                                        <th> Nom tête colonne </th>
                                </tr>
                        </thead>
                
                        <tfoot> <!-- Pied de tableau -->
                                <tr>
                                        <th> Nom Piede de colonne </th>
                                </tr>
                        </tfoot>
                
                        <tbody> <!-- Corps du tableau -->
                                <tr> une ligne
                                        <td> Nom colonne </td>
                                </tr>
                        </tbody>		
                </table>

                __________________________
                Fusion des lignes:

                        fusion de colonnes : colspan
                        fusion de lignes : rowspan


                        exemple:

                                <table>
                                        <tr>
                                                <td>..</td>
                                                <td>..</td>
                                                <td>..</td>
                                        </tr>
                                        <tr>
                                                <td>..</td>
                                                <td colspan="2">..</td>
                                        </tr>
                                </table>

                        ou encore:

                                <table>
                                        <tr>
                                                <th>Titre</th>
                                                <td>..</td>
                                                <td>..</td>
                                                <td rowspan="2">..</td>
                                        </tr>
                                        <tr>
                                                <th>Titre</th>
                                                <td>..</td>
                                                <td>..</td>
                                        </tr>
                                </table>

~~~~~~~~~~~~~~~~~~~~~~~~~~
Les balises inline
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Doivent être contenu dans un block

        --------------------------
        Mises en valeurs
        --------------------------

                <em>Normal</em>                 mise en valeur normal (italique)
                <strong>Fort</strong>           mise en valeur forte (gras)
                <mark>marquer</mark>            ressortir le texte (surligné)


        --------------------------
        Liens hyperlink
        --------------------------

                Lien vers un autre site:
                        <a href="http://SiteWeb" title="infobulle" target="_blank">Lien site</a> <br />
	
		Lien vers une page interne:
                        <a href="page2/html">Lien page</a> <br />
	
		Lien vers une ancre (id="Mon_ancre"):
                        <a href="#mon_ancre">Lien ancre</a> <br />
		
		Lien vers une ancre dans une autre page:
                        <a href="page.html#mon_ancre">Lien page/ancre</a> <br />
	
		Lien pour envoyer un mail
                        <a href="mailto:boitemail@domaine.com">Lien mail</a> <br />
	
		Lien pour télécharger un fichier
                        <a href="fichier.zip">Lien fichier</a>
	
		Lien mort
                        <a href="#">Lien mort</a>


        --------------------------
        Images
        --------------------------

		formats : jpg (photos), png (tout le reste), gif (images animés)
                        <img src="image.jpg" alt="description" title="infobulle"/>
	
		html supporte les images en base64:
                        <img src="data:image/png;base64,FICHIER_BASE64" />

		faire des images liens (pour miniature par exemple)
                        <a href="image.jpg"><img src="miniature_image.jgp" alt="image"/></a>

        --------------------------
        Universelle
        --------------------------

		...<span>blablabla</span>...

~~~~~~~~~~~~~~~~~~~~~~~~~~
Identifiants
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        ids
        --------------------------

                Les id ne peuvent être utilisé qu'une fois.

                <balise id="nom_label"> </balise>

        --------------------------
        class
        --------------------------

                Les class peuvent être utilisé antant de fois que l'on veut.

                    <balise class="nom_label"> </balise>

                Avec plusieurs classes:

                    <balide class="label1 label2 label3" .. >


~~~~~~~~~~~~~~~~~~~~~~~~~~
Compatibilité
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        IE
        --------------------------

                <!-- à l'aide d'un script javascript placé dans le head -->
                <head>
                         <!--[if lt IE 9]>
                                 <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
                         <![endif]-->
                </head>
			
~~~~~~~~~~~~~~~~~~~~~~~~~~
Conformité
~~~~~~~~~~~~~~~~~~~~~~~~~~

	<p>
		<a href="http://validator.w3.org">
		</a>
	</p>

~~~~~~~~~~~~~~~~~~~~~~~~~~
Formulaires
~~~~~~~~~~~~~~~~~~~~~~~~~~


        <form method="get ou post" action="path_to_processing.php">

                <!-- fieldset&legend pour regrouper par concordance de champ (facultatif) -->
                <fieldset>
                                <legend>Titre fieldset</legend>
                                
                                        <p> zone de texte monoligne
                                        <!--(le for du "<label>" doit être = à l'id du "<input>")-->
                
                                        <label for="nom_zone">Entrez votre texte :</label>
                                                <input type="text" name="nom_zone" id="nom_zone" />			
                                        </p>
                </fieldset>
                <fieldset>
                                <legend>Autre Titre fieldset</legend>
                                
                                        <p> Zone de texte multiligne
                
                                        <label for="multiligne">Ecriver un roman: </label>
                                                <textarea name="multiligne" id="multiligne">Texte par défaut?</textarea>
                                
                                        <!-- On peut appliquer width et height au textarea ou utiliser rows et cols en attributs -->
                                        </p>
                </fieldset>
        </form>
                
        --------------------------
        Listes d'attributs
        --------------------------

                
                <label for="autres attributs">Des attributs: </label>
                
                        <input 	type="text"
                                        name="nom_zone"
                                        id="nom_zone"
                        
                        
                                        placeholder="indication du contenu du champ"
                                        value="Valeur par défaut du champ"
                                        size="20" <!--taille du champ-->
                                        maxlength="20" <!--nombre de cartères max-->
                                        autofocus <!--sera placé sur le champs lors du chargement du formulaire-->
                                        required <!--champs obligatoire-->
                                        invalid <!--champs invalide-->
                        />
                        
                        
                        <!-- Pour le CSS mettre ":" devant required, invalid ... 
                                exemple :required{ background-color: red; } -->
                
        --------------------------
        Zones de saisie
        --------------------------

                __________________________
                Password
                       <input type="password" />
                __________________________
                Email
                        <input type="email" />
                __________________________
                URL
                        <input type="url" />
                __________________________
                N°téléphone 
                        <input type="tel" />
                __________________________
                Nombre
                        <input type="number" 
                                                min="valeur minimale"
                                                max="valeur maximale"
                                                step="pas"
                                        />
                __________________________
                Curseur
                       <input type="range"
                                                min="valeur minimale"
                                                max="valeur maximale"
                                                step="pas"		
                                        />
                __________________________
                Couleur 
                        <input type="color" />
                __________________________
                Date
                                
                        <input type="date" />  <!-- exemple : 04/08/1989/ -->
                        <input type="time" /> <!-- exemple : 12h00 -->
                        <input type="week" /> <!-- semaine -->
                        <input type="month" /> <!-- mois -->
                        <input type="datetime" /> <!-- date et heure avec décalage horaire -->
                        <input type="datetime-local" /> <!-- date et heure sans décalage horaire -->
                                
                __________________________
                Recherche
                        <input type="search" />
                                
                
        --------------------------
        Options
        --------------------------
                
                
                __________________________
                Cases à cocher:

                        <input type="checkbox" name="choix1" id="choix1" />
                                <label for="choix1">Choix1</label> <br />
                        <input type="checkbox" name="choix2" id="choix2" checked />
                                <label for="choix2">Choix2</label>
                                        
                __________________________
                Zone d'options: (mettre le même name)

                        <input type="radio" name="zone_options" value="choix1" id="choix1" />
                                <label for="choix1">Choix1</label> <br />
                        <input type="radio" name="zone_options" value="choix2" id="choix2" checked />
                                <label for="choix2">Choix2</label>
                                        
                        <!-- cocher par défaut = checked -->
                        
                __________________________
                Liste déroulante:

                        <label for="liste">Liste déroulante</label> <br />
                                <select name="liste" id="liste">
                                        <option value="choix1">Choix1</option>
                                        <option value="choix2" selected>Choix2</option>
                                </select>

                        <!-- séléctionner par défaut = selected -->	
                                
                __________________________
                Avec des groupes:

                        <label for="liste">Liste déroulante avec groupes</label> <br />

                        <select name="liste" id="liste">
                                <optgroup label="Groupe1">
                                        <option value="choix1_g1">Choix1</option>
                                        <option value="choix2_g1" selected>Choix2</option>
                                </optgroup>
                                <optgroup label="Groupe2">
                                        <option value="choix1_g2">Choix1</option>
                                        <option value="choix2_g2" selected>Choix2</option>
                                </optgroup>
                        </select>
                
        --------------------------
        Boutons d'envoi
        --------------------------
                
                <input type="submit" value="Envoyer" /> <!-- envoie le formulaire -->
                <input type="reset" value="Remise à zero" /> <!-- Remet à zero le formulaire -->
                <input type="image" src="path_image" />  <!-- idem que pour submit avec une image -->
                <input type="button" value="générique"/> <!-- bouton sans effet -->
                        
~~~~~~~~~~~~~~~~~~~~~~~~~~
Audio
~~~~~~~~~~~~~~~~~~~~~~~~~~

        <audio src="path_to_music_file.mp3" controls>Texte à afficher si non supporté</audio>

        --------------------------
        Les formats
        --------------------------

		-MP3: un des plus compatibles
		-AAC: Apple
		-OGG: Libre
		-WAV: à éviter
	
        --------------------------
        Attributs
        --------------------------
	
		controls: ajouter les boutons de commande
		width: largeur de l'outil audio
		loop: jouer en boucle
		autoplay: jouer au chargement de la page
		preload: indique l'option de préchargement de l'audio:
			auto: le browser choisi si il précharge ou pas
			metadata: charge uniquement les métadonnées (durées ...)
			none: aucun préchargement (gain en rapidité)
	
        --------------------------
        Plusieurs formats
        --------------------------
	
                <audio controls>
                        <source src="music.mp3"></source>
                        <source src="music.ogg"></source>
                </audio>
	
~~~~~~~~~~~~~~~~~~~~~~~~~~
Video
~~~~~~~~~~~~~~~~~~~~~~~~~~

	<video src="path_to_video.webm" controls poster="image_représentative.jpg" width="600">Texte si non affichable</video>
	
        --------------------------
        Les formats
        --------------------------

                Les formats conteneur : AVI,MP4,MKV ...

		codecs audio: voir precedement
		codec video conseillé:
			-H.264: Un des plus utilisé et des plus puissants (pas 100% gratuit dans certain cas).
			-Ogg Theora: gratuit et libre (moins puissant que h.264)
			-WebM: gratuit et libre, récent et proposé par Google. Serieux concurent du h.264.			
        --------------------------
        Attributs
        --------------------------

		poster: image à afficher à la place de la video quand elle n'est pas lancée.
		controls: ajouter les boutons de commande
		width: largeur de la video
		height: hauteur (garde les proportions)
		loop: jouer en boucle
		autoplay: video jouée dès le chargement de la page
		preload: options de préchargement de la video:
			auto: le browser choisi
			metadata: charge uniquement les métadonnées (Durées, dimmensions ...)
			none: pas de préchargement

        --------------------------
        Plusieurs formats
        --------------------------
                
                <video controls poster="sample.jpg" width="600">
                        <source src="video.mp4" />
                        <source src="video.webm" />
                        <source src="video.ogv" />
                </video>
		
		
~~~~~~~~~~~~~~~~~~~~~~~~~~
Un menu déroulant
~~~~~~~~~~~~~~~~~~~~~~~~~~

        <ul class="lvl1">
                <li>
                        <ul class="lvl2">
                                <li>
                                        <ul class="lvl3">
                                                <li>...</li>
                                        </ul>
                                </li>
                        </ul>
                </li>
        </ul>

        ul ul {display: none; position: absolute; left: YYYpx; top: 0; margin: 0; padding: 0;}
        li {list-style-type: none; position: relative; width: XXXpx; background-color: #YYYY;}
        li:hover ul.lvl2, li li:hover ul.lvl3 {display: block;}
	
