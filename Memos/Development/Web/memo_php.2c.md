PHP
===================

http://fr.php.net/manual/fr/langref.php

C'est quoi ? 
-----------------

Le PHP est un langage de haut niveau permettant (surtout) de scripter ses pages web.
Executé côté serveur, le PHP est largement répandu dans le monde du net.
Mais il souffre de sa simplicité, souvent utilisé pour débuté et n'est pas des plus performant.

Créer un serveur Web rapidement
-----------------

    php -S localhost:8000

Insérer du codez PHP
-----------------


    <?php  code php à insérer entre ces 2 balises ?>


Inclure une page
-----------------

    <?php include("page.php"); ?>

Variables
-----------------

Le PHP est un langage peu ou pas typé.
Il va choisir lui même quel type de variable assigner en fonction du motif de déclaration de la variable.

### Déclarer une variable

    <?php $Nom_variable = value; ?>

Où la valeur peut être, en fonction du type de données :

- une chaîne interprétée (string) : "ma_chaîne"
- une chaîne non interprétée  : 'ma_chaîne'
- un booléen : true|false
- un chiffre entier (int) ou decimal (float) : X|X.X
- une variable vide : NULL

#### Variables globales

Par défaut les variables déclarées en dehors des fonctions sont globales.
On peut les récupérer à l'intérieur de nos fonctions grâce au tableau associatif GLOBALS:

$GLOBALS['ma_variable'];

#### Variables superglobales

- Crées automatiquement par PHP à chaque fois qu'une page est chargée.
- Écritent en majuscules
- Commencent par "_" (sauf exceptions)
- Sont souvent des array
- Accessibles partout

Quelques variables:
    
$_SERVER: valeurs renvoyées par le serveur:
    --> $_SERVER['REMOTE_ADDR'] = IP du client.
$_ENV: variables d'environnements
$_SESSION: variables stockées sur le serveur temporairement (le temps de la visite)
$_COOKIE: valeurs des cookies enregistrés sur le client.
$_GET: données envoyées dans l'URL
$_POST: informations transmisent par un formulaire
$_FILES: liste des fichiers envoyés

Afficher
-----------------

### Commentaires et échappement

    // Commentaire sur une ligne
    /* Commentaire sur plusieurs ligne */
    \" échapper des caractères

### echo

    <strong>
    <?php echo "$Coucou>"; ?>
    </strong>

#### Concaténer

On utilise des points '.'

    <?php
    echo $text1 . $text2 ;
    ?>

Calculer
-----------------
PHP prédispose de fonctions mathémaiques de base :

    $resultat = ($x + 10) * $y;
    $modulo = $x % 2;

### in/décrémenter
	
    <?php
    $incrémentation++;
    $décrémentation--;
    ?>

Pointeurs
-----------------

Comme en C, il est possible de pointer sur l'adresse d'une variable :

    $pointeur = &$variable;

Conditions
-----------------

### Symboles usuels

==, <, >, != ...
|| (ou OR)
&& (ou AND)
! (not)

### if

    <?php

        if ($variable < 5 && $variable > 0) {
            echo 'la valeur de la ' . $variable . ' est inf à 5';
        }
        elseif ($varianle) {
            echo "true"
        }
        else {
            echo 'false';
        }
    ?>

### switch

    <?php
    switch ($norme)
    {
    case "RFC791":
        echo "IPV4";
        break;
    case "RFC2460":
        echo "IPV6";
        break;
    default:
        echo "Unknown RFC";
    }
    ?>

### Ternaires

Condition sur une ligne :

    <?php
    $adulte = ($age > 21) ? "adulte" : "enfant";
    ?>
	
Boucles
-----------------

### while
	
    <?php
    while ($condition)
    {
        echo "$instructions";
    }
    ?>

### For
	
    <?php
    for ($compteur = 1; $compteur <= 100; $compteur++)
    {
        echo 'compteur est à' . $compteur;
    }
    ?>
	
Fonctions
-----------------

### Declaration
	
    <?php
    function NomFonction($variable_to_treat)
    {
        echo 'variable à traiter:' . $variable_to_treat;
    }
    ?>

### Appel
	
    <?php
    mafonction();
    ou
    NomFonction('arg1', 'arg2', ... );
    ou
    $result = mafonction(...);
    ?>

### Chaînes
	

#### strlen() : donne le nombre de caractères d'une chaîne

    $nombre_caracteres = strlen($chaine);
		
#### str_replace() : remplacer une chaîne de caractères
		
    $NewString = str_replace('caractère_à_remplacer', 'caractère _de_remplacement', 'chaîne_à_modifier');
		
#### str_shuffle() : mélanger les caractères d'une châine.
		
    $MixString = str_shuffle($stringToMix);
		
#### strtolower() : mettre les caractères d'une chaîne en minuscule.
		
    $minuscule = strtolower($string);
		
### System values
			
#### date() : récupérer la date
		
H : Heure
i : Minute
d : Jour
m : Mois
Y : Année
		
    $year = date('Y');

Les Tableaux
-----------------
			
### tableaux numérotés (array simple)

Commence toujours pas 0.

    $tableau = array ('valeur1', 'valeur2', 'valeur3', ...);
    //ou
    $tableau[0] = 'valeur1';
    $tableau[1] = 'valeur2';
    $tableau[2] = 'valeur3';

    //Afficher
    echo "$tableau[0]";

### tableaux associatifs
	
    $tableau = array (
            'champ1' => 'valeur1',
            'champ2' => 'valeur2',
            'champ3' => 'valeur3'
            ); 

    //ou
    $tableau['champ1'] = 'valeur1';

    //afficher
    echo $tableau['champ1'];

### Parcourir

#### Avec for:
		
    <?php
        $table = array ('value1', 'value2', ...)

        for ($case = 0; $case < 5; $case++)
        {
            echo $table[$case] . '<br />';
        }
    ?>

#### Avec foreach:

    <?php
        $table = array ( ... )

        foreach($table as $element)
        {
            echo $element . '<br />';
        }
    ?>

#### Avec foreach:

    foreach($table as $key => element)
    {
        echo '[' . $key . '] => ' . $element . '<br />';
    }
		
#### Avec print_r

print-r permet d'afficher rapidement un tableau sans formatage. Les balises <pre> permettront d'ajouter les retours à la ligne pour un meilleur visuel:


    <?php
        $table = array ( ... )

        echo '<pre>';
        print_r($table);
        echo '</pre>';
    ?>

### Rechercher dans un tableau

#### Une clé existe?

    array_key_exists('keyword', $table);

Renverra true si la clé existe ou false sinon.

#### Une valeur existe?

    in_array('value', $table)
		
#### Récupérer une clé ou un indice

    $result = array_search('value', $table);

Renverra le nom de la clé (si c'est un tableau associatif) ou l'indice du tableau ou se trouve la valeur recherchée.


### Envoyer un tableau à une fonction


L'envoie d'un tableau à une fonction se fait de la même manière qu'une variable.

Cependant il peut être préférable de changer directement sa valeur pour ne pas retourner en fin de fonction encore un tableau.
On utilise le plus souvent un pointeur.


Exemple :

    <?php
        foo($Ttable, $other);


    //Récupération du tableau:

        function foo(&Ttable, $other)
        {
            $Ttable['value'] = "something";
        }
    ?>

Transmettre des données entre pages
-----------------

### Via l'URL ($GET)

#### Mise en forme

http://URL/Nom_page?parametre=valeur&parametre2=value

le "?" sert à délimiter l'envoie de paramètres

Il est conseillé de ne pas dépasser 255 caractères dans l'URL (selon la RFC).

#### Lien avec des paramètres

    <a href="page.php?parametre=value&amp;parametre2=value">Lien envoyant 2 paramètres à page.php </a>

#### Récupérer les paramètres

On peut récupérer les paramètres avec l'array $_GET

    <?php echo $_GET['parametre1'] . ' ' . $_GET['parametre2']; ?>

#### Tester les paramètres

Tester la présence des paramètres

    <?php
        if (isset($_GET['parametre']))
        {
            echo "ok"
        }
        else
        {
            echo "nok"
        }
    ?>

Convertir une variable en entier

Cette conversion est nécessaire si le paramètre attendu est un entier et que l'on souhaite tester celui-ci.
Si le paramètre n'est pas un entier, la fonction (int) renverra un 0.

    <?php
        $_GET['parametre'] = (int) $_GET['parametre'];
    ?>

### Via un formulaire ($POST)

#### Base d'un formulaire

Voir le mémo sur le html.

Remplir un formulaire et créer les variables à envoyer :

texte:

    <input type="text" name="VARIABLE"/>
    VALUE = texte entré par l'utilisateur

zone de texte:

    <textarea name="VARIABLE" rows=...>
        VALUE
    </textarea>

liste déroulante:

    <select name="VARIABLE">
        <option value="VALUE">option1</option>
    </select>

cases à cocher:

    <input type="checkbox" name="VARIABLE" id="IDEM"/>
    VALUE = "on" (si la case a été coché)

Les boutons d'options:

    <input type="radio" name="VARIABLE" value="VALUE" />

Les champs cachés:

    <input type="hidden" name="VARIABLE" value="VALUE"/>

#### Méthodes

On peut choisir entre deux méthodes :

POST ou GET

- get: les données transitent par l'URL. Cette méthode est peut utilisée car on ne peut pas envoyer beaucoup d'informations. 
Les infos sont ensuite récupérable avec l'array $_GET

- post: les données transitent de façon "transparente", on peut envoyer autant de données que l'on souhaite. 
Les infos sont récupérables avec l'array $_POST

#### Cible

La page définit dans la variable action sera appelée lors de l'envoie du formulaire, les paramètres seront récupérés dans GET ou POST.

    action="page_cible.php"

#### Récupérer les paramètres POST

    <?php
        echo $_POST['variable'];
    ?>

### La faille XSS

Cette faille consiste à injecter du code dans les champs de formulaires afin d'y éxecuter un code qui peut être malveillant.
Pour contrer cette faille, il faut "échapper" les éléments entrés par l'utilisateur en utilisant la fonction "htmlspecialchars".

    <?php
        echo htmlspecialchars($_POST['variable']); 
    ?>

Attention: cette fonction renvoie les balises entrées par l'utilisateur. Sinon il faut préférer "strip_tags"


### Les fichiers
			
#### L'envoi de fichiers:

Pour l'envoie de fichiers, il faut rajouter l'attribut enctype:

    <form action="target.php" method="post" enctype="multipart/form-data">
        <p>
            <input type="file" name="fichier" /><br />
            <input type="submit" value="upload" />
        </p>
    </form>

#### Le traitement des fichiers:

Le fichiers est stocké dans un dossier temporaire en attendant l'acceptation ou non de ce dernier grâce à la fonction "move_uploaded_file"
Pour chaque fichier envoyé, la variable $_FILE['nom renseigné dans le champs name'] est crée:

$_FILES['fichier']['name'] : nom du fichier
$_FILES['fichier']['type'] : mimetype du fichier
$_FILES['fichier']['size'] : taille en octet
$_FILES['fichier']['tmp_name'] : emplacement temporaire du fichier
$_FILES['fichier']['error'] : code d'erreur permettant de savoir si l'upload c'est bien passé (= 0 di ok)

##### Vérifications

- Envoie d'un fichier? 
Utiliser isset sur la variable

- Erreurs?
Utliser ['error']

    if (isset($_FILES['fichier']) AND $_FILES['fichier']['error'] == 0){...}

- Taille > X 
Utiliser ['size']

    if ($_FILES['fichier']['size'] <= XXXXX){...}

- Extension autorisée?
Utiliser ['type'] et/ou ['name']

Il est pratique d'utiliser la fonction "pathinfo" pour l'extention:

    $infos = pathinfos($_FILES['fichier']['name']);
    $extension = $infos['extension'];

    $extensions_autorisees = array('jpg', 'jpeg', 'gif');
    if (in_array($extension, $extensions_autorisees)){...}

- Valider l'upload du fichier
    Move_uploaded_file($_FILES['fichier']['tmp_name'], 'path_to_save_file' . basename($_FILES['fichier']['name']));
	

Session et cookies
-----------------

### Sessions

Conserver des variables le temps d'une visite

#### Étapes:
            
1. Génération d'un ID de session
			
    <?php
        session_start(); 
    ?>

à placer en début de code (avant le code html).
Note: ches free.fr, il faut creer un dossier "sessions", à la racine du FTP pour activer les sessions

2. Création de variables $_SESSION['XXX']
			
    <?php
        $_SESSION['nom'] = 'dupont';
        $_SESSION['prenom'] = 'dupont';
    ?>

3. Déconnexion 
			
Soit selon un bouton soit selon un timeout. (permet de supprimer les variables créer pendant la session)

    <?php
        session_destroy()
    ?>

### Cookies

Fichier contenant des informations utiles au site stocké sur le client.

#### Écrire un cookie

À place en début de code tout comme les sessions
			
    <?php
        $timestamp = 365*24*3600;
        setcookies('Nom_cookie', 'value', time() + $timestamp);
    ?>

timestamp = temps en seconde: 365*24*3600 pour garder un cookie un an.

#### Sécuriser un cookie
			
Activer l'option httpOnly permet de rendre inaccessible le cookie en Javascript. (Permet de réduire les risques de la faille XSS).

    <?php
        setcookie('name', 'value', time() + $timestamp, null, null, false, true);
    ?>

#### Afficher un cookie
			
    <?php
        echo $_COOKIE['name_cookie'];
    ?>

(vérifier eu préalable si le cookie existe avec isset)

#### Modifier un cookie

On ne modifie pas vraiment le cookie mais on le recréer avec setcookie() (il faut qu'il ai le même nom). 

+++++++++++++++++++++++++++++++++++ TO TRANSFORM INTO MARKDOWN ++++++++++++++++++++++++++++

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   Les fichiers
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

		/**************************/
		Ouvrir et fermer un fichier
		/**************************/

		<?php
			$file = fopen('Nom_fichier', 'droits');

				//INSTRUCTIONS

			fclose($file);
		?>

			___________________
			Les droits:

				r : lecture seule
				r+ : lecture et écriture
				a : lecture seule plus création auto
				a+ : lecture et écriture plus création auto (ajout en fin de ligne si le fichier existe déja).

		/**************************/
		Lire un fichier
		/**************************/

			___________________
			Lire ligne par ligne:

			<?php
				$file = "mon_fichier";

				if (file_exists($file))
				{
					$fp = fopen($file, 'r+');
					while (!feof($fp))
					{
						//lecture de la première ligne
						$line = htmlspecialchars(fgets($fp));

						echo "<pre>" . $line . "</pre>";

					}
					fclose($fp);
				}
			?>

			___________________
			Lire Le fichier en entier:

			<?php
				$file = "mon_fichier";

				if (file_exists($file))
				{
					$page = file_get_contents($file);
					$page = htmlspecialchars($page);

					echo "<pre>" . $page . "</pre>";

				}
			?>



                        Récupérer le contenu dans un tableau avec file:

                                file(MonFichier); #Récupère le fichier dans un tableau

                                exemple:

                                        $page = file($fichier);

                                        foreach( $page as $line_num => $line )
                                        {   
                                                echo '<tr><td>'.$line_num.'</td><td><pre>'.$line.'</pre></td></tr>';
                                        }

                                Note: le as fonctionne sur tout les tableau pour avoir l'indice.

                        Récupérer le contenu dans une chaîne avec file_get_contents:

                                file_get_contents(monFichier);

                                Il peut être plus pratique pour certaine manipulatution avec preg_replace par exemple.
                                

		/**************************/
		Ecrire dans un fichier
		/**************************/

		Lorsqu'on écrit dans un fichier, il faut faire attention au placement du curseur. Par exemple si on lit la première ligne, le curseur se trouvera à la fin de celle-ci.

		<?php
			$file = fopen('Nom_fichier', 'r+');

				//écrit à l'endroit du curseur.
				fputs($file, 'text to write');

			fclose($file);
		?>

			___________________
			Replacer le curseur:

			<?php
				fseek($file, X)
			?>
				X équivaut à l'emplacement du curseur.
				0 = début du fichier ...

				Ne fonctionne pas avec le mode "a+" qui ajoute toujours à la fin du fichier.

		/**************************/
		Modifier/interpreter un fichier:
		/**************************/

		Pour modifier un fichier facilement, j'utilise la fonction preg_replace:
			(voir son man pour plus de détails sur les options.)

			Cette fonction utiliser un pattern qui sert à selectionner la partie souhaité.
			et on utilise replacement pour changer cette dernière.


		<?php

			$string= "whatelse";

			$patterns = array();
				$patterns[0] = '/REGEX/options';
				$patterns[1] = '/REGEX/options';

			$replacements = array();
				$replacements[0] = 'anything';   
				$replacements[1] = 'anything';   
				
				/* Dans ce dernier cas, il est utile d'utiliser les références arrières (cf memo_regex). */

			echo preg_replace($patterns, $replacements, $string);

			note: pour le remplacement si on veux insérer une référence arrière:

				$0 -> correspond à toute la regex
				$1 -> (corespond à \1)
				...

		?>
			
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   Récupérer les données d'une base de données
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

		/**************************/
		Connexion à la base
		/**************************/

		Nous utiliserons l'extension "PDO" pour se connecter.
		Il à l'avantage d'être complet et permet d'accéder à plusieurs type de base de données comme MySQL, PostgreSQL ou Oracle.

		IL faut au préalable vérifier que PDO est activé sur le serveur. (php_pdo_xxx)

		Sur Wampp: voir fans Extension PHP
		Sur Xampp, rajouter:
			pdo_mysql.default_socket = /opt/lampp/var/mysql/mysql.sock
			
			___________________
			MySQL:

			<?php
				$db = new PDO('mysql:host=HOSTNAME;dbname=DATA_BASE_NAME', 'USER', 'PWD');
			?>
			
			___________________
			Tester la présence d'erreurs

			<?php

				try
				{
					$db = new PDO(...);
				}
				catch (Exception $except)
				{
					die('Error : ' . $except->getMessage());
				}
			?>

		/**************************/
		Exécuter une requête simple (sans variable)
		/**************************/

		<?php
			//Récupération des données:
			$result = $db->query('REQUÊTE_SQL');

				//INSTRUCTIONS

			//Fin du traitement de la requête
			$result->closeCursor();
		?>

		$result contiendra toute les informations de la requête sous forme d'un tableau (array) ayant comme éléments les noms des champs séléctionnés.
		Attention à échapé les simple quote lorsqu'on éxécute une requête demandant un champs précis:
			query('...WHERE name=\'paul\'');

		/**************************/
		Exécuter une requête préparée (avec variable)
		/**************************/

			Il faut éviter la concaténation car cette forme est sujette aux injections SQL.
			query('...WHERE name=\'' . $_GET['name'] . '\'');
			

			Préferons plutôt les requêtes préparées:

			___________________
			Avec marqueurs "?"

			<?php
				$result = $db->prepare('SELECT ... WHERE name = ? AND age >= ?');
				$result->execute(array($name, $age));

					//INSTRUCTIONS

				$result->closeCursor();
			?>
			___________________
			Avec marqueurs nominatifs

			<?php
				$result = $db->prepare('SELECT ... WHERE name = :name AND age >= :age');
				$result->execute(array(
					'name' => $name, 
					'age' => $age
					));

					//INSTRUCTIONS

				$result->closeCursor();
			?>

		/**************************/
		Afficher les erreurs
		/**************************/

			___________________
			requête simple
			
				$result = $db->query('QUERY') or die(print_r($db->errorInfo()));

			___________________
			requête préparée

				$result = execute(array()) or die(print_r($result->errorInfo()));

		/**************************/
		Afficher le résultat d'une requête
		/**************************/

		Lorsqu'on récupère les données d'une base, elles ne sont pas vraimen affichage, car les informations sont en pagaille.

		Il faut les organiser grâce à la fonction fetch() qui renvoie les infos de la première ligne?

		<?php
			$data = $result->fetch();
		?>

			___________________
			Exemple:
			
			<?php
				//1: Connexion (try ...)
				//2: Requête.

				//3: On affiche les éléments.
				while ($data = $result->fetch()
				{
					echo $data['champ1'] . '<br />;
					echo $data['champ2'] . '<br />;
				}

				//4: On Termine la requête.
			?>


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   Ecrire/Modifier/Supprimer les données en base
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

		/**************************/
		requête simple
		/**************************/

		Idem que précédement, mais on utilise la fonction exec(), et nous n'avons plus besoin de terminer le traitement.

		<?php
			$db->exec('REQUÊTE');
		?>


		/**************************/
		requête préparée
		/**************************/

		Le fonctionnement est identique que pour récupérer des données.


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   Creer des images en php
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

	voir site du zero pour détailler ce point.


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   Utiliser les REGEX PCRE
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

	Il existe deux type d'expressions régulière en php:

		POSIX: mis en avant par PHP, il est simple mais un peu lent.
		PCRE: mis en avant par Perl, plus complexe mais plus performant.

	Nous utiliserons PCRE pour la suite.

		/**************************/
		Forme des REGEX
		/**************************/

		Pour le contenu d'uun regex, se référer au memo_regex.
		Il faut entourer notre regex d'un délimiteur au choix.
		Nous choisirons le "#" Pour nos exemples. 

		Soit la forme suivante:

			"#REGEX#OPTIONS"

			exemple:
				"#mot#i"

		/**************************/
		Les options
		/**************************/

			i : ne pas tenir compte de la casse.
			s : le point fonctionne aussi pour les retours à la ligne.
			U : "Ungreedy", Lorsqu'on effectue un remplacement par exemple, cette option permet de s'arrêter entre les 2 premiers mots recherchés, et non pas entre le premier et le dernier.


		/**************************/
		Les fonctions utilisant PCRE
		/**************************/
			___________________
			preg_match:

				true: si mot trouvé
				false: sinon

				if (preg_match("#REGEX#", "chaîne où faire la recherche")){...}


			___________________
			preg_replace:

			Pour cette fonction, chaque groupement entre parenthèse au sein de la regex, correspondra à une variable ($1, $2 ...) permettant ainsi d'éxécuter un remplacement.
			$0 contient toute la regex.

			Pour qu'une parenthèse ne soit pas "capturante", il faut qu'elle commence par "?:"
				exemple: (?:XXX)

			$modified_text = preg_replace('REGEX', 'REMPLACEMENT', $text);

			exemple:
				
				preg_replace('#\[b\](.+)\[/b\]#isU', '<strong>$1</strong>', $text);

				Dans cet exemple on ajoute les balises strong au texte entre les balises [b] et [/b].



			___________________
			D'autre fonctions:

				preg_grep
				preg_split
				preg_quote
				preg_match_all
				preg_replace_callback


		/**************************/
		bbCode
		/**************************/

		Le bbCode sert en fait de parser, c'est à dire remplacer le code entré par l'utilisateur par un autre texte:

		Par exemple on peut remplacer les http:// par des liens cliquables:

		(Exemple issu du site du zero)

		<?php

			if (isset($_POST['texte']))
			{
			    $texte = stripslashes($_POST['texte']); // On enlève les slashs qui se seraient ajoutés automatiquement
			    $texte = htmlspecialchars($texte); // On rend inoffensives les balises HTML que le visiteur a pu rentrer
			    $texte = nl2br($texte); // On crée des <br /> pour conserver les retours à la ligne
			    
			    // On fait passer notre texte à la moulinette des regex
			    $texte = preg_replace('#\[b\](.+)\[/b\]#isU', '<strong>$1</strong>', $texte);
			    $texte = preg_replace('#\[i\](.+)\[/i\]#isU', '<em>$1</em>', $texte);
			    $texte = preg_replace('#\[color=(red|green|blue|yellow|purple|olive)\](.+)\[/color\]#isU', '<span style="color:$1">$2</span>', $texte);
			    $texte = preg_replace('#http://[a-z0-9._/-]+#i', '<a href="$0">$0</a>', $texte);

			    // Et on affiche le résultat. Admirez !
			    echo $texte . '<br /><hr />';
			}
			?>

			<p>
			    Bienvenue dans le parser du Site du Zéro !<br />
			    Nous avons écrit ce parser ensemble, j'espère que vous saurez apprécier de voir que tout ce que vous avez appris va vous être très utile !
			</p>

			<p>Amusez-vous à utiliser du bbCode. Tapez par exemple :</p>

			<blockquote style="font-size:0.8em">
			<p>
			    Je suis un gros [b]Zéro[/b], et pourtant j'ai [i]tout appris[/i] sur http://www.siteduzero.com<br />
			    Je vous [b][color=green]recommande[/color][/b] d'aller sur ce site, vous pourrez apprendre à faire ça [i][color=purple]vous aussi[/color][/i] !
			</p>
			</blockquote>

			<form method="post">
			<p>
			    <label for="texte">Votre message ?</label><br />
			    <textarea id="texte" name="texte" cols="50" rows="8"></textarea><br />
			    <input type="submit" value="Montre-moi toute la puissance des regex" />
			</p>
			</form>
		?>

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   Executer des commandes systèmes
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    Pour executer des commandes systèmes, il faut s'assurer que l'utilisateur web (usuellement www-data) ait les droits d'execution.

    Si l'on veut que la commande soit executé avec un autre utilisateur, on peut utiliser sudoer :

        > vim /etc/sudoers

            www-data ALL=(myuser) NOPASSWD: /home/myuser/scripts/script.sh

        > service sudo restart

    Exemple de code :

        <?php
            system("sudo -u myuser /home/myuser/scripts/./script.sh");
            echo exec('ps faux |grep myprocess');
        ?>

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   POO - Programmation orienté objet
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

	Un objet est créé à partir d'une classe qui contient tous les éléménts (fonctions et variables) nécéssaire à la construction de l'objet.


		/**************************/
		Créer un objet
		/**************************/

		$objet = new class('...') ;
		$objet2 = new class('...') ;

		/**************************/
		Exécuter une fonction d'un objet:
		/**************************/

		Lorsqu'on créer un objet, on peu appeler les fonctions de celui-ci:

		$objet->fonction1();
		$objet->fonction2();

		/**************************/
		Créer une classe
		/**************************/

		Il est recommendé de placer ce code dans un fichier à part:

			Nom_classe.class.php

		À l'intérieur des classes, on place ses propriétés, c'est à dire les variables qui la compose grâce à "private".

		<?php
			class class_name
			{
				private $variable1;
				private $variable2;

				$this->variable1 = "something"
				$this->variable2 = "somethingelse"
			}

		Le ?> fermant le code php est à proscrire dans un fichier class pour éviter certaines erreur du type "Headers already sent by"

			___________________
			inclure une classe:

				include_once('fichier.class.php');
	
		/**************************/
		Les fonctions membres d'une classe
		/**************************/

			___________________
			getters et setters:

			Ces fonction permettent de lire ou maj les variables:
				
			<?php
				class class_name
				{
					private $variable1;
					private $variable2;

					public function getFunction_name()
					{
						return $this->variable1;
					}

					public function setFunction_name($new)
					{
						$this->variable2 = $new
					}
				}

			___________________
			Les autres fonctions

			Défini toutes les autres fonctions qui ont une autre action. 

			exemple avec un envoie de mail:

			<?php
				class class_name
				{

					private $email;
					private $actif;

					public function sendmail($title, $message)
					{
						mail($this->email, $title, $message);
					}

					public function ban()
					{
						$this->actif = false;
						$this->sendmail('fire', 'You are ban, don't come back!');
					}
				}


		/**************************/
		Exemple d'utilisation d'un objet avec une classe:
		/**************************/

		<?php
			include_once('file.class.php');

			$object = new class;
			$object->setFunction_name('$variable');
			echo $object->getFunction_name() . ', I will ban you !';
			$object->ban();
		?>
						
					
		/**************************/
		Fonctions/méthodes magiques
		/**************************/

			Ces fonctions sont réservées pour un usage spécifique et ont la particularitées de commencer par deux underscore: __fonction

			___________________
			__construct

				Cette fonction est la première fonction recherchée par php lorsqu'on créer un objet.
				Elle est nécéssaire pour préparer un objet (exemple: charger le contenu des variable d'un membre à partir d'une base de données).

				exemple:

				<?php
					class Membre
					{
						public function __construct($id)
						{
							//Récupération en base des infos du membre.
							$this->pseudo = $data['pseudo'];
							$this->email = $data['email'];

							//...
						}
					}
				?>

				<?php
					$membre = new Membre(12);
					//chargement du membre 32
				?>

			___________________
			__destruct

				Réalise les opération nécessaires pour mettre fin à l'objet. Un objet est détruit à la fin de l'execution d'une page ou grâce à la fonction unset();

				exemple:

				<?php
					public function __destruct()
					{
						echo 'objet détruit';
					}
				?>


		/**************************/
		L'héritage
		/**************************/

			Permet à une classe d'hériter des variables et fonctions d'une autre classe:

			___________________
			Créer un héritage:

				<?php
					include_once('Mother.class.php');

					class Daughter extends mother
					{

					}
				?>

			La class daughter disposera des même éléments que mother, plus ce qui lui seront affectés.
			

		/**************************/
		Droits d'accès
		/**************************/

			public: tout le monde peut accéder à l'élèment;
			private: personne (à part la classe) ne peut accéder à l'élèment.
			protected: idem que private + l'élément dans une classe mère sera accessible aussi dans les classes filles.


			Explications:

				Pour accéder à un élément d'une classe en dehors de la classe même, il faut que cet élément soit public.


			___________________
			encapsulation

				C'est une règle de programmation, toute les variables membres d'une classe doivent être private ou protected (protected est à préférer si on veut plus de souplesse).
