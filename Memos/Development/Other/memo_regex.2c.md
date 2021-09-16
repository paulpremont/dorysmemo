==========================================================
                       R E G E X 
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Introduction
~~~~~~~~~~~~~~~~~~~~~~~~~~

    L'art des Regex!

    Ce n'est pas très compliqué même si cela devient vite illisible.
    Il très puissant et permet de générer des filtres sur des châines de caractère.

    Attention au langage de REGEX utilisé (POSIX, PCRE ...), il peut y avoir certaines différences.

    Sinon les bases sont les même.

    Par exemple, pour le langage PCRE, il faudra rajouter des délimiteur (exemple: #) entre une REGEX et on pourra rajouter certaine options:

            #REGEX#OPTIONS

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Tools pour test ses regex en live:
        https://github.com/gskinner/regexr/
        http://www.regexr.com/
        https://docs.python.org/2/library/re.html

~~~~~~~~~~~~~~~~~~~~~~~~~~
Les symboles
~~~~~~~~~~~~~~~~~~~~~~~~~~


	SYMBOLES		SIGNIFICATION


	\			Echapper un caractère

	.			Caractère quelconque (sauf "\n" qui correspond à une nouvelle ligne)

	^			Début de ligne
				(Placé entre crochets, ce symbole indiquera qu'on ne veut pas des caractère énumérés)

	$			Fin de ligne

	[]			Un des caractères entre crochets

	[X-Y]			Sert à définir une plage 
				exemples:
					[a-z] : de la lettre a à z
					[0-9] : de 0 à 9
					[a-z0-9] : de a à z ainsi que de 0 à 9		

	[^X]			On ne veut pas la présence de X

	?			L'élément précédent est facultatif (0 ou 1 fois)

	*			L'élément précédent doit être présent 0, 1 ou plusieurs fois

	+			L'élément précédent doit être présent 1 ou plusieurs fois

	{X}			L'élément précédent doit être présent X fois

	{X,Y}	    L'élement précédent doit être présent entre X et Y fois

    {X,Y}?      Matchera les X éléments si trouvé (au lieu de prendre tout le range)

	{X,}		L'élément précédent doit être présent X ou plus fois.

	|			Ou logique

	( REGEX )	Sert à grouper les expressions

    (?: REGEX ) L'élement ne sera pas capturé mais matchera. (ne sera pas présent dans un groupe)

    (?= REGEX ) L'élement précedent ne matchera que si la REGEX sera l'élement suivant (ne fera pas partie du résultat)

    (?! REGEX ) à l'inverse (ne fera pas partie du résultat)


    *?, +?, ??  Permet de s'arrêter au premier 'groupement' trouvé:
                    exemple:
                        <h1>title</h1> : avec comme regex <.*> va matcher toute la ligne
                                        avec <.*?> , cela matchera uniquement le premier <h1>

    


~~~~~~~~~~~~~~~~~~~~~~~~~~
Les classes abrégées (du moins pour PCRE)
~~~~~~~~~~~~~~~~~~~~~~~~~~

	\d :  chiffre [0-9]
	\D :  ce qui n'est pas un chiffre [^0-9]
	\w :  caractère alphanumérique ou un underscore [a-zA-Z0-9_]
	\W :  ce qui n'est pas un mot [^a-zA-Z0-9_]
	\s :  espace, equivaut à [\n\t\r\d]
	\S :  ce qui n'est pas un espace blanc [^\n\t\r\d]

	\t :  tabulation
	\n :  une nouvelle ligne (saut de ligne)
	\r :  retour chariot
	\e : échappement
	\f : saut de page

~~~~~~~~~~~~~~~~~~~~~~~~~~
Caractères à échapper
~~~~~~~~~~~~~~~~~~~~~~~~~~
                
        The following should be escaped if you are trying to match that character

        \ ^ . $ | ( ) [ ]
        * + ? { } ,


        Special Character Definitions
        \ Quote the next metacharacter
        ^ Match the beginning of the line
        . Match any character (except newline)
        $ Match the end of the line (or before newline at the end)
        | Alternation
        () Grouping
        [] Character class
        * Match 0 or more times
        + Match 1 or more times
        ? Match 1 or 0 times
        {n} Match exactly n times
        {n,} Match at least n times
        {n,m} Match at least n but not more than m times
        More Special Character Stuff
        \t tab (HT, TAB)
        \n newline (LF, NL)
        \r return (CR)
        \f form feed (FF)
        \a alarm (bell) (BEL)
        \e escape (think troff) (ESC)
        \033 octal char (think of a PDP-11)
        \x1B hex char
        \c[ control char
        \l lowercase next char (think vi)
        \u uppercase next char (think vi)
        \L lowercase till \E (think vi)
        \U uppercase till \E (think vi)
        \E end case modification (think vi)
        \Q quote (disable) pattern metacharacters till \E
        Even More Special Characters
        \w Match a "word" character (alphanumeric plus "_")
        \W Match a non-word character
        \s Match a whitespace character
        \S Match a non-whitespace character
        \d Match a digit character
        \D Match a non-digit character
        \b Match a word boundary
        \B Match a non-(word boundary)
        \A Match only at beginning of string
        \Z Match only at end of string, or before newline at the end
        \z Match only at end of string
        \G Match only where previous m//g left off (works only with /g)

~~~~~~~~~~~~~~~~~~~~~~~~~~
Les options
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Syntaxe avec les options (Ce qui suit est tiré du langage perl, le autres langages intères surement les mêmes mécanismes)

            m/$MOTIF/$OPTIONS

            et

            s/$MOTIF1/$MOTIF2/$OPTIONS  : pour faire des substitution (le motif1 deviendra le motif2) 
                                            Attention, par défaut, dans cette syntaxe, la substitution s'arrête à la première occurence trouvée.
                                            Il faudra utiliser l'option "g" pour l'exécuter sur toute les occurences.


    Liste des options:

            i : rend le motif insensible à la casse.
            s : travailler sur une seule ligne, dans le cas ou l'on applique un regex sur un mot comportant des caractères spéciaux, ceux si seront interprétés comme un caractère quelconque.
            m : travailler sur des lignes multiples : ici on interprétra les caractères spéciaux.

    Pour la subsitution:

            g : effectuer toutes les substitutions dans la variable.
            e : évalue le membre de droite comme une expression perl.
                    exemple:
                            $string =~ s/bonjour/fonction($1)/e;

~~~~~~~~~~~~~~~~~~~~~~~~~~
Réferences (Backref)
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Il est possible de faire appel à des valeurs matchées grâce à une expression entre parenthèses.
	Nous somme limités à 9 regroupement (ce qui est déja pas mal si on veux que la regex reste compréhensible)

		exemple:

			(expression) (2eme_expression) \1 \2

		\1 fait référence à la valeur récupérée par la première expression
		\2 fait référence à la valeur récupérée par la deuxième expression

	
	Comme nous somme limités par le nombre de regroupement possible, on peut choisir de ne pas mémoriser une expression à l'aide d'une notation spécifique:

		(?:expression)

                exemple:
                    (?:(\S+)\s+)

                    ici seul l'expression (\S+) sera gardé.
                    ?: ne retien pas l'expression dans laquel il est directement placé.

		Ici la valeur de l'expression ne sera pas mémorisée, on ne pourra l'utiliser avec \1

        Note en perl, on récupère les backref directement dans les variables $1, $2 ... .

            A savoir qu'un bloc qui se repete du type (expression){3} remplacera la première réference et n'en rajoutera pas 2 autres.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Exemples de regex
~~~~~~~~~~~~~~~~~~~~~~~~~~
	____________________________
	Numéro de téléphone:

            ^0[1-9]([-. ]?[0-9]{2}){4}$

	____________________________
	Adresse Mail:

            ^[a-z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$

	____________________________
	Adresse IP:

            ^([0-9]{1,3}\.){3}[0-9]{1,3}$
            ou
            ^([0-9]{1,3}\.){3}[0-9]{1,3}.$ (dans ce cas il devait y avoir un caractère caché comme un retour chariot ?!)

            Attention à la validité de l'ip! Ce regex ne contrôle pas le maximum (les Nombres peuvent dépasser 255).
