P E R L
==============================

What is it ?
-----------------------------

Un langage de scripting haut niveau largementt distribué.

Links
-----------------------------

### Official

* [perl.org](http://www.perl.org/docs.html)
* [PERLDDOC](http://perldoc.perl.org/)
* [Les options de Perl](http://www.perl.com/pub/2004/08/09/commandline.html)
* [Apprendre le perl](http://learn.perl.org/)

### Tutos

* [developpez.com tuto](http://lhullier.developpez.com/tutoriels/perl/intro/#L11-M)
* [cookbook](http://docstore.mik.ua/orelly/perl/cookbook/index.htm)


Execution et environnement Perl
-----------------------------

### En CLI

    perl -e 'perl commands'
    perl -w monFichier.pl

### shebang (dans un script)

		#!/usr/bin/perl -w

### Les modules courants

    use strict;
    use warnings;

### Terminer un script

À la fin du script, il faut écrire un "1" à la fin du fichier:

    1;

### Les Options de PERL

Elles permettent d'utiliser simplement perl en ligne de commande

* -e : executer du langage perl délimité entre guillemets.

    perl -e 'print "hello\n";'

* -c : compile sans lancer le programme, utile pour débuguer.
* -w : active les warnings (sur les constructions)
* -W : active tout les warnings
* -X : Desactive les warnings
* -l : permet de rajouter les \n
* -p : permet de créer une boucle implicite avec affichage de chaque ligne:

Équivaut à :

    LINE:

        while (<>) {
            print
        }

Exemple :
        
    #Afficher les lignes d'un fichier et leurs numeros
    perl -pe 'print "$. ";' /etc/passwd

* -n : idem mais sans l'affichage

exemple:

    #Afficher les lignes d'un fichier et leurs numeros
    perl -ne 'print "$. : $_"' mon_fichier


* -a : split chaque entrées dans un tableau @F
* -F : Définir un séparateur de champ

    -F'/regex/'
    -F'pattern'

exemples: 

    #Afficher le nombre de caractère par ligne.
    perl -F -anle 'print scalar @F'
    perl -F ':' -nale '$F[2]>1000 and print' /etc/passwd

    #Afficher le nombre de lignes > 80 caractères:
    perl -ne '$i++ if(length > 80); END{print $i}' /etc/passwd


* -O[octal/hexadecimal] : Délimiteur d'enregistrement  
  -00 : mode paragraphe   #les sauts de ligne font office de séparateur.  
  -0777 : mode fichier    #L'intégralité du fichier constitue un seul block.

* -s : Active le processing des switchs (permet de créer des options automatiquement)

### L'aide

    apt-get install perl-doc

    perl --help
    perldoc perl            #Affiche l'aide sur perl
    perldoc -f MA_FONCTION  #Fonctionne comme un man
    perloc -q MOT           #Regarde les correspondance avec ce mot dans les docs

### Écrire un commentaire

    #Commentaires (comme en bash)

~~~~~~~~~~~~~~~~~~~~~~~~~~
Syntaxe
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Quotes
        --------------------------

            "Interprétation"
            'non interpretation'
            `stdout shell command`

~~~~~~~~~~~~~~~~~~~~~~~~~~
Variables et types de données
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Types
        --------------------------

                Le Perl est faiblement typé.
                Il existe principalement 3 structures de données:
                
                        -Les $scalaires (châine, nombres ...)
                        -Les @tableaux(stocke et identifie les scalaires[])
                        -Les %tables_de_hachage (structure de $données{})

                Les type de données sont définient par une glyphe:
                        $ : scalaire
                        @ : tableau/liste
                        % : hashmap
                        & : fonction

                        Sans glyphe : file handle

                        * : type glob (joker pour les glyphes)
                        
                __________________________
                Contexte:

                        Les opérations sur les variables sont liés au contexte. (chaine, liste...)
                        On peut donc forcer un contexte et obtenir un résultat différent en fonction de ce dernier

        --------------------------
        Portée
        --------------------------

                Une variable déclarée dans un block enfant ne sera pas disponible pour le block parent.
                __________________________
                Locale:


                        my:
                        ``````````````````````````
                            Accessible dans le block où elle a été définie et les blocks enfants.
                            (Fonctionne dans un espace donné)

                                > my $variable;


                        local:
                        ``````````````````````````

                            Fonctionne sur des variables globales.
                            Utilise une version temporaire de la variable globale jusqu'a la fin du block.
                            (Fonctionne dans un temps donné, at runtime)
                        
                                > local $variable;

                        Note: les variables locales ont la priorité sur les variables globales en cas de doublon.

                __________________________
                Globale:

                        Accessible dans les sous fonctions

                            our $variable;
                            ou 
                            $variable;

        --------------------------
        Variables prédéfinies
        --------------------------

                $_ :    Dernier résultat, valeur courante.
                @ARGV : liste des arguments passés au script
                @_ :    liste des arguments passés aux sous fonctions
                $0 :    Nom du script

                $. :    Contient le nombre d'enregistrement lu. (avec l'option -n ou -p)

                    exemple:
                        perl -wnle 'print "$. : $_"' /etc/passwd

                $, :    Contient le caractère de séparation entre deux enregistrements
                       
                    exemple:
                        perl -wle '$,=" || ", @tab=(1,2,3); print @tab;'
    
                $/ :    séparateur d'enregistrement

                    On peut changer le séparateur d'enregistrement avec l'option -0

                        Note: par défaut chaque fin de ligne (\n) est considérée comme le séparateur.

                        exemple:
                            perl -wlp -e 's/^/     /g;' fichier
                            perl -wlp -00 -e 's/^/     /g;' fichier
                            perl -wlp -0777 -e 's/^/     /g;' fichier

        --------------------------
        Déclarer une variable
        --------------------------
                __________________________
                Sur une ligne:

                        my $variable = VALUE;
                        my ($variable1, $variables2, ...);

                __________________________
                Sur plusieurs lignes:

                        my $variable = <<EOF;
                            blablabla
                        EOF
                __________________________
                Undef:

                        Déclarer une variable sans valeur:

                        my $variable = undef;
                        ou
                        my $variable;

                        Réinitialiser une variable:
                        ``````````````````````````
                                undef($variable);

                        Tester une valeur undef:
                        ``````````````````````````
                                if(defined($variable))
                                if(not defined($variable))

        --------------------------
        Règles d'évaluation
        --------------------------

                En perl lorsqu'on ne définit pas explicitement une variable, il utilise automatiquement $_

                exemple:

                        perl -ne '/root/ and print' /etc/passwd

                        #Recherche la ligne root dans /etc/passwd

                        
        --------------------------
        Scalaires
        --------------------------
                __________________________
                Contexte:

                        Forcer le contexte scalaire:
        
                        scalar( $something );

                        ou encore on peu forcer en utilisant les opérateur:
        
                        exemple:

                                @Array+0 ;

                                au lieu de:

                                    scalar(@Array);
                __________________________
                Chaînes:

                        Déclaration:
                        ``````````````````````````
                                my $chaine = "contenu interprété";
                                my $chaine = 'contenu non interprété';

                                $string.=$char --> $string=$string.$char #Raccourci

                        Concaténer
                        ``````````````````````````
                                
                                avec un '.' ou des accolades {} :

                                my $string = "debut"."fin";
                                my $string = "${variableDebut}fin"; 

                        Duppliquer
                        ``````````````````````````
                            x : sert à duppliquer
                            
                            exemple:
                            
                                $string="do"x3 --> "dododo"

                                $stringx=$nb --> $string=$stringx$nb    #Raccourci
			
                        Fonctions
                        ``````````````````````````
			
                            length($string) : calcule et renvoie la longueur de la chaine

                            chop($string) : garde le dernier caractère et modifie la variable

                            chomp($string) : supprime le dernier caractère s'il sagit d'une fin de ligne et renvoie le nombre de caractères supprimés.
                            reverse($string) : renvoie la chaine dans l'ordre inverse

                            substr($string,outset,length) : renvoie la chaîne de longueur length à partir de la position $outset. Et sert à substituer.

                                exemples:
                                
                                > substr("Hello World",7,1); --> W
                                > substr("Hello World",7,); --> World
                            
                            index($Chaine,$SousChaine,$outset) : recherche la SouChaine dans la Chaine et renvoie sa position. le "outset" correspond à la position du début de la recherche (facultatif).

                            rindex($Chaine,$SousChaine,$outset) : identique qu'index mais dans le sens inverse
                                        
                __________________________
                Nombres:

                        Déclaration:
                        ``````````````````````````
                                my $nombre = X;
                                my $nombre = int($flottant); #transformer en entier.

                        Calculs:
                        ``````````````````````````
                                + ; - ; * ; % ; /

                        Incrémenter / Raccourcis
                        ``````````````````````````

                                += ; -= ; *= ; /= ; %=
                                ** : puissance
                                ++ ; -- pour in/décrémenter


                                Note: 
                                    $i++ : incrémenter i mais renvoie l'ancienne valeur de i (dans un contexte conditionnel par exemple)

                                    ++$i : idem mais renvoie la nouvelle valeur.

                        Fonctions mathématiques:
                        ``````````````````````````
                                sin($x), cos($x)
                                exp($x), log($x)
                                abs($x) : l'absolu
                                sqrt($x) : racone carré

                        Random:
                        ``````````````````````````

                                rand($LIMIT);

                                exemple avec un ternaire:

                                (rand(10)>5)?"rouge":"bleu"

                                si > 5 alors affichera rouge
                                sinon afficher bleu

                ____________________
                Range:

                    Pour créer un range de lettre ou de chiffre, il est possible de passer par l'opérateur ".." .

                    Exemple:

                            print 0..9; -> 0123 ...

                            on peut donc l'utiliser dans une boucle

                            for ($first_nb .. $last_nb) { print "$_\n"; }

                    Fonctionne aussi avec des lettres

                            print "a".."z";

~~~~~~~~~~~~~~~~~~~~~~~~~~
Afficher
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        print
        --------------------------

                > print("x = $x , y = $y\n");
                > print "\n------".basename $file."-------\n";

        --------------------------
        warn
        --------------------------

            Afficher un message sur la sortie d'erreur:
                
                > $input == "" and warn 'input empty!';

        --------------------------
        die
        --------------------------

            Ecrire un message d'erreur et sortir du programme

                > $count >= 99 or die "Need more things";

~~~~~~~~~~~~~~~~~~~~~~~~~~
Blocks d'instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~
		____________________
		BEGIN:

			Ce bloc sera exécuté en premier dans un code.

            exemple dans un module:

			>	package XXX;
			>	BEGIN
			>	{
			>		print "Chargements préalables pour le module\n";
			>	}
			>	...

		____________________
		END:

			Ce bloc sera exécuté en dernier.

			>	package XXX;
			>	END
			>	{
			>		print "Derniere exécution pour le module\n";
			>	}
			>	1

        Note les bloc sont executés dans l'ordre d'écriture.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Conditions
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Opérateurs
        --------------------------

			Tests           Numérique	Chaines

			égalité         ==          eq
			différence      !=          ne
			infériorité     <           lt
			supériorité     >           gt
			inf ou égal     <=          le
			sup ou égal     >=          ge

			comparaison     <=>         cmp     
            #Renvoie -1, 0 ou 1 en fonction de la taille de la chaîne de gauche:
                -1 : plus petite, 0 egal, 1 plus grand
			
			correspondance		=~ 	(fonctionne avec les regex)
			l'inverse			!~

			L'expression ($x<=>$y) correspond à 
				> 0 si $x < $y
				< 0 si $x > $y
				null si $x = $y
				
			<=> : nommé le spaceship!
			le cmp s'appuie sur l'ordre des chaînes de la table ASCII.

			ET :        && (ou and mais priorité plus faible)
			ou :        || (ou or mais priorité plus faible)
			Inverse :   ! (ou not)

        --------------------------
        True/False
        --------------------------
            
            0 ou chaine vide ou absence de valeur (undef): false
            autre : true

        --------------------------
        Structures
        --------------------------
            ____________________
            Le if classique:
            
                if( condition ) 
                {
                    instruction;
                }
                elsif ( condition2 )
                {
                    instruction2;
                }
                else
                {
                    instruction3;
                }

                       Note: voir les opérateur booléens pour les différentes syntaxe de condition:

                            ! condition = not condition 
                            ! condition || condition2 = not condition or condition2 ...

        
                        Le if sur une seule ligne (pas de else):
                        ``````````````````````````

                            instruction if( condition );

                            exemple:
                                print "$string\n" if( defined($string) );

            ____________________
            switch:

                http://search.cpan.org/~rgarcia/Switch-2.16/Switch.pm

                use Switch;

                switch ($val) {
                    case 1          { print "number 1" }
                    case "a"        { print "string a" }
                    case [1..10,42] { print "number in list" }
                    case (\@array)  { print "number in list" }
                    case /\w+/      { print "pattern" }
                    case qr/\w+/    { print "pattern" }
                    case (\%hash)   { print "entry in hash" }
                    case (\&sub)    { print "arg to subroutine" }
                    else            { print "previous case not true" }
                }

                        Peut être à éviter d'après certain commentaires:
            ____________________
            Given et When:

                http://perldoc.perl.org/perlsyn.html#Switch-Statements
                La syntaxe avec given et when sont peut être plus recommandées.

               use feature 'switch' 

                given($_) {
                    when (/^abc/) { $abc = 1; }
                    when (/^def/) { $def = 1; }
                    default { something }
                }
               
                Attention toutefois aux problèmes de version.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Boucles
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Structures
        --------------------------
                ____________________
                Le for classique

                    for ( my $i=0; $i<=50; $i++ )
                    {
                        print "$i\n";
                    }
                
                ____________________
                foreach

                    Permet de parcourir facilement un tableau, une liste. Voir la section "Tableau/liste" pour plus de détails.

                    foreach my $elem (@table)
                    {
                        print "$elem\n";
                    }

                ____________________
                Le while
                
                    my $i = 0;
                    while( $i <= 20 ) 
                    {
                        print "$i\n";
                        $i+=2;
                    }
                
                peut s'écrire pour une seul instruction:
                    instruction while( condition );
                
                si on veut executer au moins une fois l'instruction:
                
                    do
                    {
                        insctruction;
                    } while( condition );
                    
                ____________________
                until
                
                    fonctionne de la même manière qu'un while
                    et équivaut à while( !condition )
                
                ____________________
                unless:

                    Execute les instructions si la condition est fausse:

                        unless ( condition ) 
                        {
                            instructions;
                        }

        --------------------------
        Instructions sur blocks
        --------------------------

                (ne fonctionnent pas sur un do_while)
                
                next : fin de l'execution du bloc (la boucle continue)
                last : fin de l'execution de la boucle
                redo : redémarrage du bloc
                    
                    exemple:
                    
                        my $i=0;
                        while( 1 ) 
                        {
                            $i++;
                            redo if( $i = 6 );
                            last if( $i > 10 );
                            next if( $i = 5 );
                            print "$i\n";
                        }

                Les labels:
                ``````````````````````````
                    (comme goto)

                    LABEL: foreach (@something) {
                            while ($something_else) {
                                    last LABEL
                            }
                    }


~~~~~~~~~~~~~~~~~~~~~~~~~~
Enregistrements - records
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Un <enregistrement> est délimité par un séparateur ($/) .

        l'opérateur <> permet de lire le dernier enregistrement du buffer concerné.

        exemple:
            <stdin> : li le buffer d'input
            <> directement peut aussi permetre de lire stdin par défaut.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Saisie de texte
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Il faut récupérer la valeur de l'entrée standard:
           <stdin> ou directement <> 

        exemples:

            > print "Please make your choice: ";
        $choice = <stdin>;      #On attend la saisie de l'utilisateur, et on récupère la valeur dans la variable $choice
        chomp($choice);         #On supprime les saut de ligne qui pourrait déranger dans l'interprétation de la variable
        $resultat = $tableau_valeur[$choice - 1];      #On récupère la valeur contenu dans le tableau

        On peut aussi simplement utilisé le symbole suivant:
        $choice =<>;


~~~~~~~~~~~~~~~~~~~~~~~~~~
Fonctions
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Déclaration
        --------------------------

            sub function { INSTRUCTIONS }

        --------------------------
        Prototype
        --------------------------

            TODO
            (limité en perl)

        --------------------------
        Paramètres 
        --------------------------

            On peut choisir de passer un ou plus de paramètres grâce au ';':

                sub bidul( $var1, $var2 ; $var1 )

            On récupère aussi bien souvent les paramètres dans un tableau:

                sub bidul( @params )

            Voir aussi coté références.

        --------------------------
        Retourner une valeur
        --------------------------

            On retourne une valeur ou une liste de valeurs.

            > return $value, @values;
            
        --------------------------
        Traitement des arguments
        --------------------------

            On les récupères dans @_ .

            my @params = @_;
            ou
            my ($param1, $param2) = @_;
            ou
            my ($param= = shift;

        --------------------------
        Appel de fonctions
        --------------------------

            > function($value1,value2,...);
            > $valueX = function($value1,value2,...);
            > print function($value)."\n";
            > function();

        --------------------------
        Exemple de fonction
        --------------------------
                __________________________
                Renvoi des nombres premiers:

                    sub crible_eratosthene_devlpez_com
                    {
                            #Récupération du paramètre
                            my ($n) = @_;

                            #Création de la liste des premiers:
                            my @first_number = ();

                            #Liste initiale:
                            my @all = (2..$n);

                            #Si le tableau est vide = faux
                            while( @all )
                            {
                                    #on récupére et supprime le premier élément (2) qui est le premier nombre premier.
                                    my $two = shift @first_number;

                                    #on le met dans la liste des premiers:
                                    push @first_number, $two;

                                    #on supprime les nombres non premiers:
                                    @first_number = grep { ( $_ % $two )!=0 } @all;
                            }

                            #on retourne la liste des nombres premiers
~~~~~~~~~~~~~~~~~~~~~~~~~~
Saisie de texte
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Il faut récupérer la valeur de l'entrée standard:
           <stdin> ou directement <> 

        exemples:

            > print "Please make your choice: ";
            > $choice = <stdin>;
            > chomp($choice);

~~~~~~~~~~~~~~~~~~~~~~~~~~
Fonctions
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Déclaration
        --------------------------

            sub function { INSTRUCTIONS }

        --------------------------
        Prototype
        --------------------------

            TODO
            (limité en perl)

        --------------------------
        Paramètres 
        --------------------------

            On peut choisir de passer un ou plus de paramètres grâce au ';':

                sub bidul( $var1, $var2 ; $var1 )

            On récupère aussi bien souvent les paramètres dans un tableau:

                sub bidul( @params )

            Voir aussi coté références.

        --------------------------
        Retourner une valeur
        --------------------------

            On retourne une valeur ou une liste de valeurs.

            > return $value, @values;
            
        --------------------------
        Traitement des arguments
        --------------------------

            On les récupères dans @_ .

            my @params = @_;
            ou
            my ($param1, $param2) = @_;
            ou
            my ($param= = shift;

        --------------------------
        Appel de fonctions
        --------------------------

            > function($value1,value2,...);
            > $valueX = function($value1,value2,...);
            > print function($value)."\n";
            > function();

        --------------------------
        Exemple de fonction
        --------------------------
                __________________________
                Renvoi des nombres premiers:

                    sub crible_eratosthene_devlpez_com
                    {
                            #Récupération du paramètre
                            my ($n) = @_;

                            #Création de la liste des premiers:
                            my @first_number = ();

                            #Liste initiale:
                            my @all = (2..$n);

                            #Si le tableau est vide = faux
                            while( @all )
                            {
                                    #on récupére et supprime le premier élément (2) qui est le premier nombre premier.
                                    my $two = shift @first_number;

                                    #on le met dans la liste des premiers:
                                    push @first_number, $two;

                                    #on supprime les nombres non premiers:
                                    @first_number = grep { ( $_ % $two )!=0 } @all;
                            }

                            #on retourne la liste des nombres premiers
                            return @first_number;
                    }



~~~~~~~~~~~~~~~~~~~~~~~~~~
Gestion du temps - date
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        localtime()
        --------------------------
                
                Exemple:

                        my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
                        my $date = (1900+$year)."_".($mon+1)."_".$mday." at ".$hour.":".$min.":".$sec;

        --------------------------
        sleep()
        --------------------------
            attendre avant d'éxécuter la prochaine séquence.

                > sleep X   #: attendre X secondes.
                            return @first_number;
                    }



~~~~~~~~~~~~~~~~~~~~~~~~~~
Gestion du temps - date
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        localtime()
        --------------------------
                
                Exemple:

                        my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
                        my $date = (1900+$year)."_".($mon+1)."_".$mday." at ".$hour.":".$min.":".$sec;

        --------------------------
        sleep()
        --------------------------
            attendre avant d'éxécuter la prochaine séquence.

                > sleep X   #: attendre X secondes.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Commandes shell
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        system
        --------------------------


            Permet de récupérer le code de sortie d'une commande

                Créer un processus fils.

                > system("command", "arg1", "arg2", ...);
                ou
                > system("command arg1 arg2 ...");

                Note: on peut récupérer la valeur de sortie de la commande avec $?

                        $? = -1   =>  Erreur d'execution
                        $!        =>  Raison de l'erreur

        --------------------------
	exec
        --------------------------

                > exec("command arg1 arg2 ...);

                Remplace le processus courant.

        --------------------------
	Backquote
        --------------------------

                > $result = `commande arg1 arg2 ...';
                ou
                > @result = `commande arg1 arg2 ...`;

                > print $result;

        --------------------------
        open
        --------------------------

                Cette dernière méthode permet de traiter la sortie d'une commande ligne par ligne.
                Et consomme moins de mémoire.

                    > open DUMP, "commande|";
                    > $stdout = <DUMP>;

                    ou

                    > @stdout = <DUMP>;
                    > close DUMP;

        --------------------------
        qx
        --------------------------

		> qx(commande) : permet de lancer des commandes systems.

                Comme les backquotes mais sans l'interprétation direct des variables.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Options
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Via switch avec l'option -s
        --------------------------

            > perl -s MES_ARGUMENTS

                -help               : $help
                -var="contenu"      : print $var

            exemples:
                
                ./script.pl -option="hello" -option2 ...

                  #!/usr/bin/perl -w -s                                                                                                  
                  print $option
                  if( $option2 )
                  {
                    ...
                  }

        --------------------------
	Getopt::Long
        --------------------------

		http://search.cpan.org/~chips/perl5.004_05/lib/Getopt/Long.pm

		Paramétrer les valeurs des arguments:
		(à placer à la fin de l'option):

		symbole		description

		option!		#Pas d'argument et peut être négative: i
				prend les valeur 1 ou 0: option=1 nooption=0
		option+		#La valeur de l'option s'incremente à chaque apparition 
				--option --option --option  : l'option aura pour valeur 3
		option=s	#L'option doit contenir une chaîne (string) (elle sera égal à la chaine)
		option:s	#Si il n'y a pas de chaine en argument, la variable sera vide.
		option=i	#L'option doit être numérique (peut être négative -arg)
		option:i	#La valeur 0 sera assignée si il n'y a pas d'argument
		option=f	#Valeur réel uniquement 
		option:f	#Valeur 0 si pas d'argument

		exemple:

			use Getopt::Long;

			Getopt::Long::Configure( "no_auto_abbrev" );
			Getopt::Long::Configure( "ignorecase" );

			my %option=();

			GetOptions ('long|s=s'      => \$option{create},
				    'rightorfalse!' => \$option{deploy},
				    'number:i'      => \$option{number},
				    'help|h|usage!' => \$option{help}, 
				    'all!'          => \$option{all},
				    'multi'         => \$option{multi}
				    );  
					
			main(\%option);


================================================ REORGANISATION


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Listes et tableaux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	--------------------------------------
	Formes et opérateurs
	--------------------------------------
		____________________
		Valeurs:

			() : liste vide
			(1,2,"$variable") : liste contenant 3 éléments (1 et 2 et la valeur de la variable). 
		____________________
		Intervalle:

			(1..10) : valeur de 1 à 10
			('a'..'z') : lettres de a à z

		____________________
		Répétition:

			Comme pour les chaîne, on peut utiliser l'opérateur "x":

			(1,3) x 2  --> (1,3,1,3)

		____________________
		qw: Permet de créer facilement une liste de caractères:
			
			@table = qw(Hello please list me well);
			ou
			@table = qw/Hello please list me well/:

			donnera ==> ('Hello', 'please', 'list', 'me', 'well')

			Note: pour créer une liste à partir d'une variable, il faut se tourner vers split.


	--------------------------------------
	Manipulation
	--------------------------------------

            -Premier indice d'un tableau = 0
            -Si l'on déborde d'un tableau (accès à des éléments qui n'existent pas), alors on obtiendra la valeur "undef".
            -@ARGV : contient les arguments de la ligne de commande du programme.

		____________________
		Déclaration/Affectations

			> my @tableau = ();				#Déclaration d'une liste vide.

			> my @tableau = (5,'string',"$variable");	#Affectation de 3 type d'éléments de la liste.

			> $tableau[X] = Y; 				#assigne la valeur Y au Xième indices du tableau.

			> @tableau1 = @tableau2; 			#Copie les valeurs du tableau2 dans le tableau1.

			> ($a,$b) = (X,Y); 				#Affecte la valeur X à $a et Y à $b.

				Il est possible grâce à cette syntaxe de faire une multidéclaration:
					my ($a,$b) = (X,Y);
				Ou même d'échanger deux valeur sans faire intervenir une troisième variable:
					($a,$b) = ($b,$a); 		

			> ($a,$b) = @tableau; 				#$a reçoit la 1ere valeur du tableau et $b la 2eme.

			> @table1 = (X,@table2,Y); 			#@table1 = (X,Value1_table2,Value2_table2,...,Y) .
									#On appel ça "l'aplatissement".

			> ($a,@table) = @table2; 			#Donnera 1ere valeur du tableau2 à $a et le reste à $table. 
									#= "l'absorption"


		(Rajouter my pour les déclatations, le comportement est identique)

		____________________
		Accès:

			> print "$tableau[X]"; --> Affiche le Xième élément
			> $tableau[-1] : --> accès au dernier élément du tableau
					$tableau[-2] : accès à l'avant dernier ...
			> $#tableau : donne le dernier indice du tableau.
					$tableau[$#tableau] : accès au dernier élement du tableau.
			> scalar(@tableau) : donne le nombre d'éléments du tableau.
					==> $nombre_elements=@tableau
		____________________
		Tests:

			exists : test l'existence de l'élément du tableau.
				exemple:
					
				> if( exists( $tableau[X] ) ) {
					... }

			defined : test si l'élément du tableau contient un 'undef'.


	--------------------------------------
	Parcourir un tableau - boucle foreach
	---------------------------------------

		> foreach $variable (liste) { instruction }
		
		Il est possible de déclarer la variable dans le foreach:
		
		> foreach my $variable (liste) { instruction }

		____________________
		Exemples:

			Afficher les éléments d'un tableau:

			foreach my $elem (@table)
			{
				print "$elem\n";
			}

			Table de multiplication:

			foreach my $i (1..$ARGV[0])
			{
				foreach my $j (1..$ARGV[1])
				{
					printf( "%4d", $i*$j );
				}
				print "\n";
			}
					
		____________________
		Raccourci:
			
			foreach (@table)
			{
				print "$_\n";
			}

                        autre méthode:

                        > print "$_" for @content;

			
	--------------------------------------
	Fonctions utiles pour tableaux
	---------------------------------------

		____________________
		unshift : ajouter les valeurs d'une liste au début du tableau:
			unshift(@table,X,Y); --> Ajoutera X,Y au début du tableau.
		____________________
		push : comme unshift mais à l'inverse, ajoute les valeurs à la fin du tableau:
			push(@table,X,Y); --> Ajoute X,Y à la fin du tableau.
		____________________
		shift : supprime et renvoie le premier élément d'un tableau:
			$first_elem = shift(@table);
		____________________
		pop : Comme shift mais sur le dernier élément:
			
			$last_elem = pop(@table);
		____________________
		reverse : Inverser une liste (le dernier élement devient le premier ...)
			@table_inverse = reverse(@table);
		____________________
		join : intégre un séparateur entre plusieurs éléments d'une liste et renvoie une châine:

			$string = join("séparateur",@liste);

		____________________
		split: Creer une liste à partir d'une chaine selon un séparateur:

			@liste = split(/séparateur/,"$string");
                        @liste = split(/ /,"string"); --> même effet que qw

			exemple:

			@liste = split(/-/,"4-5-6");
				--> l'élement 1 aura la valeur "4", le deuxième la valeur 5 ...

		____________________
		sort: trier une liste

			Cette fonction se sert de deux variables $a et $b servant à la comparaison. 
			Elle trie selon l'ordre lexical pour les chaîne de caractère ou numérique pour les nombres.
			Il est possible d'utiliser des instructions de comparaison afin de définir ses propres critères de trie.

			@liste2 = sort( @liste1 );  --> La liste2 contiendra les éléments triés de la liste1.

			ou

			@liste22 = sort( {comparaison} @liste1): --> les comparaison peuvent $etre :

				{$a cmp $b}
					--> triera selon l'ordre lexical.

				{$a <=> $b}
					--> triera selon l'ordre numérique.

				{length($b) <=> length($a) or $a cmp $b}
					--> ici le trie est dabord numérique mais de façon inversé puis lexical si les éléments sont égaux.

				Il est possible d'utiliser sa propre fonciton de trie, il suffit de renvoyer les valeurs suivantes: { fonction($a,$b) }
					
					> 0 , si $a avant $b
					< 0 , si $b avant $a
					= 0 , si $a = $b

		____________________
		grep: selectionner des éléments

			Renvoie la liste des éléments correspondant au critère de recherche effectué sur la variable $_ (=vrai). Il est possible d'utiliser les regex.

			@list2 = grep { selection } liste1;

			exemples:

				@list2 = grep { $_ <0 } @list1;
					--> Affecte les éléments < 0 de la liste1 à la liste2.

				@list2 = grep { $_!=10 and $_<2 } @list1;
					--> Affecte tout les éléments différents de 10 et < 2 de la liste1 à la liste 2.

				@list2 = grep { $function($_) } @list1;
					--> on peut écrire sa propre fonction de recherche (devra renvoyer vrai pour chaque élement correspondant à la recherche).

				@list2 = grep(/regex/, @list1 );
					--> même fonctionnement mais avec une expression régulière.

		____________________
		map: Modifier/traiter les éléments d'une liste

			Utilise aussi la variable $_

			@list2 = map({ expression } @list1);

			exemples:

				@list2 = map({-$_} @list1);
					--> list2 contiendra les valeurs opposées à list1.

				@list2 = map({$_."s"} @list1);
					--> list2 contiendra les valeurs de la list1 avec un s à la fin de chaque éléments.

				@list2 = map({$_*=2} @list1);
					--> list2 contiendra tous les éléments de @list1 multipliés par 2.	

	--------------------------------------
	Tranches de tableau (Slice in english)
	---------------------------------------

		Une tranche définit un sous-ensemble des éléments d'un tableau.

		@tableau[Indices] = (list);

		équivaut à :

		($tableau[indice1],$tableau[indice2]) = (list);

		Exemple:

		>	@t[2,10] = ("paul", 430);
		>	@t[2..10] = ("paul", ..., 430);

                Exemple de supression d'une case d'un tableau:

                        Avec $i l'indice du tableau à supprimer:

                        >       @array = @array[0..($i-1),($i+1)..$#array]


	--------------------------------------
	Tableau à deux dimensions
	---------------------------------------

		Au même titre que le C, il est possible de créer un tableau à deux dimensions:

			$table[X][Y] = value ;

		Il sera alors possible de parcourir le tableau en utilisant 2 boucle succinctes. 




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les Tables de hash
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Permet d'associer une valeur à une clé:
	Une table de hache est désigné par le symbole %

	exemple:
		%h

	--------------------------------------
	Déclarer une table de hachage:
	---------------------------------------

                > my %h = ( 	"kirikou"	=>	"04/08/1989",
                >		"kirikette"	=>	"02/12/1989" );	

	--------------------------------------
	Accéder à un élément
	---------------------------------------

                >	$table_de_hachage{clé} = "valeur";
                >	print "value: $table_de_hachage{clé}\n";

	--------------------------------------
	Parcourir une table de hash
	---------------------------------------
		____________________
		Obtenir la liste des clefs avec "keys":

		> my @t = keys(%h);

		> foreach my $k (keys(%h))
		> {
		>	print "Key: $k ; Value: $h{$k}\n";
		> }

		____________________
		Obtenir la liste des valeurs avec "values":

		> foreach my $v (values(%h))
		> {
		> 	print "Value: $v\n";
		> }

		____________________
		Itération sur les couples clef,valeur avec each:

		 while( my ($k,$v) = each(%h) )
		 {
			print "Key: $k ; Value: $v\n";
		 }

                 Avec une référence:

		 while( my ($k,$v) = each($hashRef->{$key}) )
		 {
			print "Key: $k ; Value: $v\n";
		 }

	--------------------------------------
	Autovivification
	---------------------------------------

		Ce concept permet que lorsqu'on manipule une clé qui n'existe pas, Celle-ci est automatiquement crée selon son contexte (numérique=0, chaine=vide)

		exemples:

		>	$h{vide} .= "du contenu";
				--> Associe une chaîne vide puis la concatène avec "du contenu"

		>	$h{nombre}++;
				--> Créer un élément de valeur 1

		>	my @texte = qw( un morceau de phrase );
		>	my %hache = ();
		>	foreach my $mot ( @texte ) 
		>	{
		>		$hache{$mot}++;
		>	}
		>	while( my ($word,$nb) = each(%hache) )
		>	{
		>		print "Le mot '$word' est présent $nb fois\n";
		>	}

				--> on créer une clé du même nom que le mot comportant le nombre de fois ou il est présent dans le texte.
					On affiche les itération grace à each (couples clef/valeur).

	--------------------------------------
	Existence et suppression d'une clef
	---------------------------------------
		____________________
		Tester l'existance d'une clé avec "exists"

			>	if( exists( $h{key} ) )
			>	{
			>		print "La clé 'key' existe\n";
			>	}

			Ce test renvoie vrai si la clé existe

			La méthode "exists" est à préférer de "defined" car elle permet de distinguer si l'élèment est absent ou indéfini.

		____________________
		Supprimer une clé avec "delete"

			>	delete( $h{key} );

			Si la clé n'existe pas, alors rien ne se passera.
			Idem que "defnied", il ne vaut mieux pas utiliser "undef" car la clé existera toujours.

		____________________
		Vérifier qu'une table de hachage est vide (qu'elle n'a pas de clé)

			>	if( %h eq 0 )
			>	{
			>		print "%h is empty\n";
			>	}

	--------------------------------------
	Hachage et correspondance avec les listes
	---------------------------------------
		____________________
		Passer d'une liste à une table de hachage:

		>	my @tableau = ("key", "value", "key2", "value2");
		>	my %hachage = @tableau

		Chaque élément du tableau sont pris deux à deux, le premier correspond à la clé, l'autre à sa valeur.
		Si le tableau fini sur un nombre impaire, la clé aura ue valeur "undef".
		Si une même clé est présente plusieurs fois, la dernière valeur prévaudra.

		Note: il est possible de remplacer les "," par des "=>" pour une meilleur lisibilité
		Note2: l'ordre des couples est aléatoire.
		
		____________________
		Parcourir une table de hachage comme une liste:

		>	foreach my $element (%h)
		>	{
		>		print "$element\n";
		>	}

		____________________
		Inverser l'odre des clé et des valeurs:

		>	my %h = reverse(%h);

		____________________
		Exemples:

		Pour illustrer les tables de hachage voici un exemple du site developpez.com:
		Le but est pour que d'indiquer l'union et l'intersection de 2 sensembles:

		>	#On créer les 2 ensembles et la table de hash
		>		my @ensA = (5, 8, 12, 9);
		>		my @ensB = (6, 12, 2, 3);
		>		my %hash = ();
		>	#On ajoute la clé de chaque ensembles dans la table de hash avec la valeur de 1
		>	#Si la clé existe déja, sa valeur sera incrémenté de 1. (elle vaudra donc 2 ...)
		>		foreach my $element (@ensA) { $hash{$element}++; }
		>		foreach my $element (@ensB) { $hash{$element}++; }
		>	#On créer ensuite la liste union qui comprendra tout les élément présent dans la table de hache (trié par ordre croissant)
		>		my @union = sort( {$a<=>$b} keys(%hash) );
		>	#On créer la liste des intersections en filtrant sur les clés qui ont une valeur = à 2 de la table de hache:
		>		my @inter = sort( {$a<=>$b} ( grep { $hash{$_}==2 } keys(%hash) ));
		>	#On affiche les listes:
		>		print ("@union\n");
		>			#--> 2 3 5 6 8 9 12
		>		print ("@inter\n");
		>			#--> 12
		
		
	--------------------------------------
	Tranches de la table de hachage
	---------------------------------------

		Au même titre que les tableaux et listes, les tranches s'appliquent sur le clefs:

		@h{'clef1','clef2' ...}

		Exemple: Enlever les doublons d'une liste:

		>	my @tableau = qw(bleu rouge bleu blanc);
		>	my %h
		>	# On récupère les éléments d'un tableau (comme une tranche) pour les assigner aux cléfs de la table de hachage
		>	@{@tableau} = ();
		>	@tableau = keys %h;

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations des fichiers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	--------------------------------------
	Inclure un fichier perl (include)
	---------------------------------------

                Il n'existe pas de "include" à pproprement parlé en perl,

                Il faut donc passer par les modules. (cf partie sur les modules)

	--------------------------------------
	Opérateurs sur les noms de fichier
	---------------------------------------

	Les opérateurs sont similaires à ceux du bash.
		
		>	if( -opérateur "/path/to/file" ) { ...; }

		Voir avec: "perldoc -f -X" pour avoir la liste complète des opérateurs

		-e : test que le fichier existe
		-f : test si c'est un fichier
		-d : test si c'est un répertoire
		-l : test si c'est un lien symbolique
		-r : test les droits de lecture
		-w : test les droits d'écriture
		-x : test les droits d'éxecution
		-o : test si le fichier appartien à l'utilisateur courant
		-z : test si le fichier est vide
		-s : Renvoie la taille du fichier (test du coup si le fichier est rempli)
		-M : Renvoie l'âge du fichier (en jour)

	--------------------------------------
	Fonction glob
	---------------------------------------

		Utilise les wildcards (* [a-z] ? ...) comme pour le shell (voir le mémo des commandes linux)

		La fonction glob permet de renvoyer les nom de fichiers correspondant à l'expression donnée:
			glob('expression');

		-première syntaxe:

		>	@file_list = glob('*.txt');

		-deuxième syntaxe:

		>	@file_list = <*.txt>;

                Avec une variable par exemple:

                >       @file_list = glob("$path/*.txt");

		____________________
		exemple:

		>	foreach my $file ( <.*>, <*> ) #Pour chaque fichier : (on prend en compte le fichier courant: . et le dossier père ..)
		>	{
		>		next if( ! -d $file ); #On passe à l'argument suivant si le fichier n'est pas un dossier
		>		next if( ! -w $file ); #On passe à l'argument suivant si on a pas les droits d'écriture sur le fichier
		>		print "$file : ". ( -s $file ) . "\n"; # Enfin on affiche la taille du dossier si on trouve un dossier.
		>	}

	--------------------------------------
	Ouverture d'un fichier
	---------------------------------------

            Syntaxe:
		open( HANDLE , 'MODE_OUVERTURE/PATH' );

            exemple:
                open( FILE, '</path/to/file ) or die( "Erreur: $!" );

            Renvoie vrai ou faux si bon déroulement ou non.

            Note: 
                S'ouvre à l'ancien  placement du curseur.

		____________________
		Modes d'ouvertures

			caractère:	signification:

			vide		lecture
			<		lecture
			>		écriture (écrasement)
			>>		écriture (ajout)
			+>		lecture et écriture (écrasement)
			+<		lecture et écriture (ajout)
		
		____________________
		Lire un fichier:

                    Avec l'opérateur <> permettant de lire un enregistrement.

                    exemple:
                        <FILE>


                    Afficher ligne par ligne (ouverture en mode lecture):

                            my $line = <FILE>;

                            while( defined( $line = <FILE> ) )
                            {
                                chomp $line;
                                if ( ! $line or $line =~ m/^#/ ) { next } # On passe les commentaires et lignes vides
                                print "Line N° $. : $line\n";
                            }

                    Créer un tableau contenant toute les lignes:

                            my @line = <FILE>;

		____________________
		Ecrire dans un fichier:

                            print( FILE "chose à écrire\n" );

			Fonctionne aussi avec printf:

                            printf( FILE "%03d", $to_write );

	--------------------------------------
	Fermer un fichier:
	---------------------------------------

		Permet de fermer un decripteur de fichier et vider les buffers associés

		close( FILE );

	--------------------------------------
	Fichiers ouverts automatiquement
	---------------------------------------

		Lorsque Perl lance un programme, il ouvre automatiquement des fichiers:

		STDIN: entrée standard (clavier le plus souvent)
		STDOUT: sortie standard, print et printf utilise cette sortie par défaut (le terminal)
		STDERR: la sortie d'erreur, warn et die l'utilise par défaut (le terminal)
		ARGV: contient les nom du fichier en lecture (exemple les arguments envoyés à la commande)

	--------------------------------------
	Fonctions pratiques concernant les fichiers
	---------------------------------------
		____________________
		Récupérer un caractère avec getc

			$carac = getc(FICHIER)
		
		____________________
		Lire un nombre déterminé de caractères:

			$nombre_de_carac_lu = read( FICHIER, $chaine_lu, $nombre_de_carac_a_lire );

		____________________
		Entrée/sortie de bas niveau:

			sysopen,sysread,syswrite,close

	--------------------------------------
	Récupérer la sortie d'une commande avec open:
	---------------------------------------
		____________________
		lire la sortie standard:

			> open(FILE, "commande|")
		
			exemples:

				> 	open(FILE,"ls|")
		
		____________________
		lire l'entrée standard:

			> open(FILE, "|commande")

	--------------------------------------
	Ecrire une table de hachage sur disque avec les fichiers DBM
	--------------------------------------

		DBM = format de fichier de hachage (key/value).

		Il possible de manipuler une table de hachage en la liant avec un tel fichier en utilisant les fonctions dbmopen et dbmclose
		
		____________________
		Création d'un fichier DBM:

			>	my %h;
			>	dbmopen(%h, "data",0666 or die($!);
			>		$h{'key'} = 'value';
			>	dbmclose(%h) or die($§);

		____________________
		Lecture d'un fichier DBM:

			>	my %h;
			>	dbmopen(%h, "data",0666) or die($!);
			>		print "$h{'key'}\n";
			>	dbmclose(%h) or die($!);

		Pour 0666 correspond aux droits attribués aux fichiers.
		Attention a ne pas mettre l'extension pour le nom de fichier "data"
		(Un DBM est composé de deux fichiers: .dir et .pag)

	--------------------------------------
	Recouvrir/Supprimer un fichier
	--------------------------------------

                Pour supprimer définitivement un fichier voici une petite fonction pratique:

                > use File::Overwrite qw(overwrite);
                > unlink($MonFichier);

	--------------------------------------
	Trouver un fichier - find
	--------------------------------------

                La syntaxe de find est un peu particulière voici un exemple pour mieux l'aborder:


                > use File::Find;       #On active le module find
                > my @wanted_files;     #On déclare de manière global un tableau
                
                > sub wanted
                > {
                >       push @wanted_files,$File::Find::fullname;               #On alimente notre tableau des fichiers trouvés par find
                > }
                >
                > find(\&wanted, @MyAllFiles);   #Va chercher de façon récursif tous les fichiers trouvés dans MyAllFIles et execute la fonction wanted pour chaque fichier trouvé.

                Note:
                        La fonction wanted n'est pas une fonction ordinaire, puisqu'ici nous ne traitons pas d'arguments mais des variables pré-établies par la fonction Find.

                        Voir: http://perldoc.perl.org/File/Find.html

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Se déplacer/Créer dans une arboresence:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        > chdir $mondossier;            #se déplacer dans un dossier
        > mkdir $mondossier;            #Créer un dossier
        > rmdir $dir;                   #Supprimer un dossier vide

        Supprimer un dossier même non vide:
        > use File::Path qw(make_path);
        > rmtree ("$dir", 1, 1);              


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Expréssions régulières - REGEX
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Pour la syntaxe des expressions, voir le memo_regex

	Pour exécuter une regex, on utilisera l'opérateur bind: "=~"

	--------------------------------------
	Correspondance:
	--------------------------------------

		>	m/ regex /  #m permet d'indiquer le caractère de séparation de la regex.

		Exemple de vérification:
		
			>	if( $variable =~ m/regex/ )
			>	{
			>		instructions
			>	}

			Les instruction seront exécutées si la variable comporte le mot regex.
			La $variable prendra la valeur de la regex dans le cas ou c'est vrai.

		On peut utiliser l'opérateur != pour vérifier l'inverse de la regex.

		On peut aussi utiliser un raccourci si la variable $_ existe:
		exemple:

			>	($_) = @_;
			>	if ( ! m/REGEX/ ) { ...; }


                Note : la syntaxe =~ fonctionne aussi avec n'importe quel motif:

                        > if( $string =~ $string2 )
                        > {
                        >       print "it works !";
                        > }

	--------------------------------------
	Substitution
	--------------------------------------

		>		s/ regex / chaîne /

		Exemple de substitution:

			>	$variable =~ s/regex/remplacement/;

		Ici on remplace les mots "regex" par "remplacement"

                Autre exemple, faire une substitution à la sed:

                        perl -i.bak -0777 -pe 's/<(.*?)>.*?<\/\2\s*>/\1>/'
			
	--------------------------------------
	Variables définies:
	--------------------------------------

		Voir le memo regex, référence arrières.

		Les variables spéciales définient par le référencement arrière, sont aussi accessible dant tout le bloc.
		($1, $2 ...)

		Trois autres variables possible:
			$& : toute la sous-chaîne matchant
			$` : toute la sous-chaîne qui précède la sous-chaîne matchant.
			$' : toute la sous-chaîne qui suit la sous-chaîne matchant.

                exemple:

                    @shell=`df`
                    foreach( @shell )
                    {
                        $_=~/^(\S+)/;
                        print $1;
                    }

	--------------------------------------
	Valeurs de retour m//
	---------------------------------------

		En contexte de liste, l'opérateur "m" de coréspondance renvoie la liste des éléments matchés

		exemple:

		($a,$b) = ( $values =~ m/^(A+).*(B+)$/ );

		On extrait la première occurence trouvé dans $a, la deuxième dans $b ...
		(= $1, $2 ...)

		exemple utile dans un test:

		if( ($a,$b) = ( $values =~ m/^(A+).*(B+)$/ ) ) { ... }

		Il est possible de choisir son séparateur:
			Par défaut on utilise le "/" avec "m" mais il peut être plus commode d'en utiliser un autre (dans le cas où on doit traiter une chaîne avec plein de "/":

			En fait on est pas obligé de mettre la lettre "m" si on utilise les "/" sinon, il suffit de changer le caractère juste après "m":

			m=REGEX=

	--------------------------------------
	Variables et REGEX:
	--------------------------------------

		Il est possible d'utiliser des variables déclarées préalabalement dans les motifs d'une regex:

		>	$string = "motif"
		>	$variable =~ m/$string/

		Lorsqu'on utilise ce genre de syntaxe, si la variable vien d'une saisie utilisateur, il est préférable de la passer à la fonction quotemeta.
		Cette fonction échapera tout les caractères pouvant impacter la REGEX:

		>	$motif = quotemeta($motif);
	
	--------------------------------------
	Remplacements avec l'opérateur 'tr'
	--------------------------------------

		Il est possible d'utiliser les regex pour effectuer des remplacements grâce à l'opérateur 'tr':

		tr/$MOTIF/$REMPLACEMENT/

		exemple:

		> 	$string = "au galop !"
		>	$string =~ tr/g/d/;
		>	#$string --> "au dalop !"
				
	--------------------------------------
	Directement en ligne de commande
	--------------------------------------

            > perl -ne '$_=~/MON_PATTERN/g and print' MON_FICHIER

                -0777 : mode fichier pour récupérer les retours à la ligne par exemple.

                exemple:

                    perl -nle '$_=~/(\d+).*"(.*)"/; $hash{$1}=$2; END{ print "file moi un numero "; $num=<>; chomp $num ; print "le pote ici est $hash{$num}"}' filou

                    Avec le contenu du fichier:

                        654654654 "polo" "kikou"    ""  "polo@utc.fr"
                        698754654 "david" "trunki"    ""  "kiwi@utc.fr"

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Références
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Permet de pointer sur l'adresse mémoire d'une variable (équivalent au pointeur en C)

	Note: Lorsqu'on sort d'une fonction, les variables locales à celle-ci sont détruite.
		Mais tant qu'il reste une référence à une variable, celle ci est conservée.
		Le garbage-collector libérera la mémoire dans le cas contraire.

	--------------------------------------
	Afficher le type/contexte d'une variable:
	---------------------------------------

                > ref $variable

	--------------------------------------
	Références sur scalaire
	---------------------------------------
		____________________
		Récupérer l'adresse mémoire d'un scalaire:


			On utilise le '\' pour faire une référence:

			>	my $ref = \$variable;
			
			la valeur de ref sera du type: "SCALAR(0x25b3d58)"

		____________________
		Afficher la valeur d'une référence: (Déréférencer)

			>	print "$$ref\n";

		____________________
		Affécter une valeur à une variable référencée:

			> 	$$ref = "foo";
			>	#la variable qui aura l'adresse référencée par $ref aura la valeur "foo"


	--------------------------------------
	Références sur tableau
	---------------------------------------

		Les références peuvent nous servir à faire des tableaux contenant des tableaux !		

		____________________
		Récupérer l'adresse mémoire d'un tableau:

			>	my $ref = \@tableau
			>	# --> ARRAY(0x18a0d58)

		____________________
		Contenu d'une référence vers un tableau:

			>	my @contenu = @$ref

		____________________
		Correspondance tableau/référence:

			Avec i le ième élement:

			Tableau			Référence

			table			$ref
			@table			@$ref
			$table[i]		$$ref[i] ou $ref->[i]
			
		____________________
		Tableaux de tableaux:

			>	my @table1 = ( 1, 2, 3 );
			>	my @table2 = ( 4, 5, 6 );
			>	my @table3 = ( \@table1, \@table2, 7 );

		le tableau3 comprendra 3 élement dont les premiers des autres tableaux.

		____________________
		Parcourir un tableau de tableau:

			>	my @table1 = ( 1, 2, 3 );
			>	my @table2 = ( 4, 5, 6 );
			>	my @table3 = ( \@table1, \@table2 );
			>	print "$table3[0]->[1]\n";	# Affichera 2

			>	foreach my $case ( @{ $table3[1] } )
			>	{
			>		print "$case";		# Parcoura tout les élements de table2
			>	}

		____________________
		Référence d'un tableau dans un hash référencer dans un autre hash:

                        Schéma:

                        1 REFERENCE HASH:  
                                2 HASH:   KEY: "MY KEY"   VALUE: REFERENCE_HASH 
                                                3 HASH       KEY: "MY KEY" VALUE: REFERENCE_TABLEAU

                         
                         $hashref1->{$key2}->{key3} = \@array    # Permet d'insérer la référence
                         $hashref1->{$key2}->{key3} = $value     # contiendra la référence ARRAY 
                         $hashref1->{$key2}->{key3}[0] = $value  # Première valeur du tableu

                         Parcourir la réf du tableau:

                         foreach( @{$hashref1->{$key2}->{$key3}} ) {
                                print "$_\n";
                         }

	--------------------------------------
	Références sur table de hashage
	---------------------------------------

		____________________
		Récupérer l'adresse mémoire d'une table de hachage:

		>	my $ref = \%hash
		>	# récupère une valeur de type : HASH(0x14e6d58)
		
		____________________
		Correspondance hash/référence:

			HASH			REFERENCE

			hash			$ref
			%hash			%$ref
			$hash{key}		$$ref{key} ou $ref->{key}

		____________________
		exemple d'affichage de couple key/value:

		>	my $ref = \%hash;
		>	foreach my $key (keys %$ref)
		>	{
		>		print "$key:  $ref->{key} \n";
		>	}


	--------------------------------------
	Références anonymes
	---------------------------------------

		Les références anonymes permettent d'associer une valeur à une variable qui n'est pas nommmée:

		____________________
		Vers un scalaire:

		>	my $ref = \"scalaire";
		>	print "$$ref \n";

			Il ne sera pas possible d'éditer cette valeur ensuite, car elle se trouvera en read-only
		
		____________________
		Vers un tableau:

		>	my $ref = [ "element1", "element2", "..." ];
		>	print "$ref->[0] \n";   #Affichera element1

		> 	$ref->[0] = "elem0"
		>	print "$ref->[0] \n;	#Affichera elem0

		Parcourir une référence anonyme d'un tableau comportant des tableaux:


			>	my $ref = [ [ "elem1", "elem2"], [ "elem3", "elem4" ] ];
			>	print "$ref->[0]->[1]\n"; 		#Affichera "elem2"

			>	foreach my $case ( @{ $ref->[0] } )
			>	{
			>		print "$case";			#Parcoura toutes les valeurs de la première référence contenu dans $ref (elem1 et elem2)
			>	}

		____________________
		Tableau de référence

			on peut aussi stocké des références dans un tableau avec la syntaxe suivante:

		>	my @ref = \("elem1", "elem2", "elem3");
		>	print "$ref[2]\n";   				#Affichera quelque chose du type : SCALAR(0x214a3c0)


		____________________
		Vers une table de hachage:

		>	my $ref = { 'key1' => "value1",
		>			'key2' => "value2" }; 


		Parcourir une table de hachage comportant des table de hachage:


			>	my $ref = {
			>		'Paul' =>
			>			{ 'taille' => '1m20',
			>			'yeux' => 'bleu' },
			>		'Yulia' =>
			>			{ 'taille' => '2m50',
			>			'yeux' => 'vert' },
			>		};
			>
			> 	# On pourrais aussi déclarer deux tables de hachages et insérer leur référence.
			>	# my $ref = { 'key' => \%hash1 };
			>
			>	print "$ref->{Yulia}{yeux}\n";	#affiche vert

	--------------------------------------
	L'opérateur ref()
	---------------------------------------

		Cette fonction permet de connaître le type de référence.

			Elle renvoie le type de scalaire dans le cas où c'est vrai ou faux dans le cas contraire.

			On peut par exemple ce servir de cette fonction pour parcourir un tableau comportant des références de plusieurs types (SCALAIRE, HASH ...) et parcourir par la même occasions les sous-éléments.

			>	foreach my $champ (@$tab_ref)
			>	{
			>		if( ref($champ) eq "SCALAR" )
			>		{
			>			print "Scalar is $$champ\n";
			>		}
			>		elsif ( ref($champ) eq "ARRAY" )
			>		{
			>			print "[ ';
			>			foreach my $subcase (@$champ)
			>			{
			>				print "$subcase ; ";
			>			}
			>			print "]\n";
			>		}
			>		elsif ( ref($champ) eq "HASH" )
			>		{
			>			print "{ ';
			>			foreach my $key (keys(%$champ))
			>			{
			>				print "$key : $champ->{$key}\n;
			>			}
			>			print "}\n";
			>		}
			>		elsif ( !ref($champ) )
			>		{
			>			print "Value is $champ\n";
			>		}
			>	}


	--------------------------------------
	Parcourir plusieurs niveau de référence
	---------------------------------------

		>	use Data::Dumper;
		>	print Dumper($ref);
	

	--------------------------------------
	Références circulaires
	---------------------------------------

		C'est lorsque plusieurs tableaux/hash/scalaire se référencent entre eux.
		Ce qui peut poser des problèmes pour le garbage-collector.

		un $ref = undef; ne fonctionnerait pas.

		Pour casser la circularité il faut procéder ainsi:

		>	$ref->[1] = undef;
		>	$ref = undef;

	--------------------------------------
	Références sur fichiers
	---------------------------------------
	
		>	open(FILE,">fichier") or die("$!");
		>	my $reff = \*FILE;
                ou 
                >       my $reff = <FILE>;

		On peut aussi créer des références sur les sorties standars (STDIN ...)

		>	my $refi = \$STDIN;
		
		
	--------------------------------------
	Références sur les fonctions
	---------------------------------------

		>	my $ref = \&fonction_name;

		exemple d'appel:

		>	&$ref ("arguments")
			ou
		>	$ref->("Arguments");

		on pourait aussi utiliser une fonction qui récupère la référence d'un autre pour l'utiliser:

		>	sub fonction
		>	{
		>		my ($func,$arg) = @_;
		>		$func->( $arg );
		>	}
		>	fonction( $ref, "argument" ); # ou à la place de $ref : \&fonction_name

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Les modules sont des enssembles de fonctions.

	--------------------------------------
	Trouver un module:
	--------------------------------------

		Il faut piocher dans l'archive CPAN (Comprehensive Perl archive Network).

		http://www.cpan.org/

		Pour vérifier qu'un module est bien présent sur le systeme:

		>	perl -e 'use MODULE'

	--------------------------------------
	Installer un module non présent:
	---------------------------------------

        
            Rdv sur http://www.cpan.org/
            Puis rechercher le module et le télécharger (Un lien est normalement présent (download ...))

	    ____________________
            Manuellement:

                (Vous pouvez le faire avec un wget une fois l'url récupérée)

                >	tar xvzf $module.tar.gz
                >	cd $module
                > 	perl Makefile.PL 
                >	make
                >	make test
                >	make install

	    ____________________
            Maj du path:

                Si vous voulez mettre votre propre path:

                >	perl Makefile.PL INSTALL_BASE=/your/path
                
                L'utiliser dans un script:

                > 	use lib "Path_to_module";

	    ____________________
            Via le gestionnaire de paquet:


                >	sudo aptitude search $module |grep perl
                > 	sudo aptitude install $module_trouvé

	    ____________________
            Via cpan:

                Cet utilitaire permet de dialoguer directement avec le CPAN.

                installez le paquet "lynx" qui devrait servir au cpan.

                > cpan		
                #Au premier lancement il faut répondre à quelque question pour le configurer.

                La conf du cpan se trouvera ensuite dans $HOME/.cpan

                > cpan install $module
                        
                        ou

                > perl -MCPAN -e 'install $module'


            Note: il faudra surement relancer votre bashrc pour voir utiliser le module sans erreur.

	--------------------------------------
	Inclure un module:
	---------------------------------------

		>	use MODULE;

                Il faut que votre script ai accès à ce module en éditant la variable INC:

                Une méthode simple:

                >       use lib LIST;

                exemple:

                        >       use lib $0/

                SI vous mettez une variable dans le path, vous serrez confronté à un petit problème:
                        Le module sera chargé avant que la variable ne soit prise en compte du coup il faut finter:


                        >       my $dir;
                        >       use File::Basename;
                        >       BEGIN { $dir = driname $0; }
                        >       use lib $dir;
                        >       use MY_FUNCTION;


		____________________
                AUTOLOAD:

                    TODO

                    Utile pour inclure des modules de dynamiquement.

                    sub AUTOLOAD {
                        my $program = $AUTOLOAD;
                        $program = s/.*:://;
                        system ($program, @_);
                    }

	--------------------------------------
	Ecrire un module:
	---------------------------------------

		Il faut créer un fichier.pm contenant la première ligne indiquant le nom du module.
		La dernière ligne doit finir par le résultat de l'éxécution du module ( "1" pour ok).
		On y mettra ensuite les divers fonction souhaitées.

		exemple:

		>	package Nom_module;
		>	use strict;
		>	sub hello
		>	{
		>		my ($variable) = @_;
		>		print "$variable\n";
		>	}
		>	1 # correspond à la valeur de retour du module (vrai (1)= bon déroulement; faux= le module ne sera pas chargé) 

		____________________
		Nom composé:

		Cela peut être utile pour segmenter de façon logique un module:

		exemple:

		>	# fichier: parent/enfant.pm
		>	package parent::enfant;
		>	use strict;
		>	our $variable = 'foo';
		>	1;

		ici le nom du module sera parent::enfant

		
	--------------------------------------
	Appeler une fonction d'un module:
	--------------------------------------

		>	use Module;
		>	Module::fonction( "arguments" );

	--------------------------------------
	Utiliser une variable d'un module:
	--------------------------------------

		Il faut au préalable, avoir déclaré la variable avec 'our' (dans le module)

		>	print "$module::variable\n";
			ou
		>	print "module::$variable\n";


	--------------------------------------
	Exportation de symbole
	--------------------------------------

		L'export de symbole dans un module permet de pas utiliser le nom du Module pour appeler ses fonctions, ses variables ...
		Pour cela au début du module il faut inscrire les lignes suivantes:

		>	package MODULE;
		>	require Exporter;
		>	our @ISA = qw(Exporter);
		>	our @EXPORT = qw(functions and variables);
		et/ou
		>	our @EXPORT_OK = qw(functions and variables);

		ou

		> 	package MODULE;
		>	use Exporter 'import';
		>	our @EXPORT = qw(...);

		note:
		Pour une compatibilité avec perl < 5.6:
		>	#use vars qw(@ISA @EXPORT_OK)


		____________________
		Symboles exportables par défaut:

			Il faut ajouter dans le tableau EXPORT les fonction et variables souhaitées:


			>	our @EXPORT_OK = qw(&function &function2 $variable ...);
			ou
			>	our @EXPORT = qw(function function2 $variable *prefix...);

			@EXPORT_OK : Le variables et fonctions devront être explicitement appelée pour être utilisée:
				> use MonModule qw (fonction ...); #(voir section "symboles exportables individuellement)

			@EXPORT : contient toutes les vars et fonctions chargées par défaut lors de l'appel du module:
				> use MonModule;

		____________________
		Symboles exportables individuellement

			Ces symboles sont exportable uniquement sur la demande du script utilisant le module.
			Il faut par contre dans le module autoriser l'exportations des symboles souhaités:

			Dans le module:

			>	our @EXPORT_OK = qw(&function $variable ...);

			Dans le script:

			>	use MODULE qw(:DEFAULT $function $variable ...);

			(Sans le DEFAULT:, les symboles exportables par défaut ne serait pas importés dans le script)

		____________________
		Symboles exportables par tags

			Cela permettra d'exporter plusieurs "symboles" selon le tag.

			Dans le module:

			>	our %EXPORT_TAGS=(Nom_TAG=>[qw(&function $variable ...)],
			>			Nom_TAG2=>[qw(&function2 $variable2 ...)];

			Dans le script:

			>	use MODULE qw(:DEFAULT :Nom_TAG :Nom_TAG2 ...);

		____________________
		Fonctions inaccessibles

			Pour indiquer qu'une fonction doit être privée et non utilisée vers l'extérieur du module, il faut que son nom commence par un '_' .

			>	sub _function_name { ... }

			(Ceci sert juste de prévention)

			sinon pour que cela soit vraiment inaccessible, il faut déclarer la fonction dans une variable:

			>	my $function = sub {
			>	...
			>	};

			Pour l'utiliser à l'intérieur du module:

			>	$function->("arguments");


	--------------------------------------
	Documentation about les modules 
	--------------------------------------

		____________________
		doc officielle sur les modules existants:

			Voir perldoc
			et
			http://search.cpan.org

		____________________
		POD:

			Pour documenter ses propres modules on utilise la syntaxe 'POD'
			Ce code s'écrit dans le module même:

			=head1 : titre niveau 1
			=head2 : titre niveau 2

			=over 
			=item BLABLABLA
			=item BLABLABLA   }=> permet de créer une liste
			=back

			=cut : indique la fin du POD (pour pouvoir écrire du code perl)

			exemple:

			>	=head1 NAME
			>	
			>	MODULE.pm - Short description
			>
			>	=head1 SYNOPSIS
			>	
			>	HOW TO USE MODULE (flags ...)
			>
			>	=head1 DESCRIPTION
			>
			>	Long deescription
			>
			>	=head2 Exports
			>
			>	=over
			>	
			>	=item :What_to_export du blabla
			>
			>	=back
			>
			>	=cut
			>
			>	package MODULE;
			>
			>	=head1 FUNCTION FUNCTION_NAME
			>	
			>	Description de la fonction
			>
			>	=cut
			>
			>	sub function_name
			>	{
			>		...;
			>	}
			>	1

			Pour plus de détails sur la syntax: 

			>	perldoc perlpod

		____________________
		Visualiser la doc:

			>	perldoc MODULE

	--------------------------------------
	Quelques modules:
	---------------------------------------

		>	Math::Trig		: permet d'incure les fonctions mathématique (comme les fonctions de trigonométrie ...)
		>	Net::OpenSSH		: Pour se connecter over SSH sur les hôte distant et exécuter ses lignes de codes (utilise la conf de open ssh, ce qui est très pratique!)
                >       File::Basename          : Pour inclure les fonctions basename et dirname

                ...



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
WEB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Petit lien sympa:
	http://articles.mongueurs.net/magazines/linuxmag56.html

        --------------------------
        HTTP
        --------------------------
                __________________________
                Libs:

                    Librairie : libwww-perl

                    Cette dernière permet d'accéder au web et d'éxécuter des requête http.

                    > use LWP

                __________________________
                Définir l'agent:

                    Ce dernier permet d'indiquer le user agent utilisé (facultatif)
                    Il peut être vide.

                    > my $ua = LWP::UserAgent->new( agent => "Agent/version" );

                    exemple:

                    > my $ua = LWP::UserAgent->new( agent => "Mozilla/5.0" );

                __________________________
                Executer une requête

                    > my $req = HTTP::Request->new ( COMMAND => REQUETE );
                    > my $res = $ua->request(REQUETE);
                    > die $res->status_line if not $res->is_success;
                    
                    exemple:

                    > my $foo_req = "http://localhost/bidul?var=toto";
                    > my $req = HTTP::Request->new ( GET => $foo_req );
                    > my $res = $ua->request($req);
                    > die $res->status_line if not $res->is_success;

	--------------------------------------
	Exemple
	--------------------------------------
            use LWP::UserAgent;
            use HTML::Form;     #Permet de parser facilement le code html
            use HTTP::Cookies;
            use HTTP::Request;

            $user=LWP::UserAgent->new(agent => paramètres );
            ...

            Pour injection sql:

        --------------------------
        FTP
        --------------------------

            use Net::FTP;

                $ftp = Net::FTP->new("host.name", Debug =>0);
                    ...

        --------------------------
        SMTP
        --------------------------

            use Net::SMTP;


                


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SQL - avec DBI
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------------
	Utilisation du module:
        --------------------------------

		> use DBI

        --------------------------------
	Création d'une requête préparée
        --------------------------------

		> my $query = <<SQL;
                >       "MA QUERY ? ? ? 
                > SQL
                
                avec les variables remplacées par des "?"


        --------------------------------
	Préparation de la requête:
        --------------------------------

		> my $prep = $dbd->prepare($query)
		  or die FAILED_PREPARE_REQUEST.$dbd->errstr;   

        --------------------------------
	Exécution de la requête
        --------------------------------

	 	> $prep->execute($MES_VARIABLES)
	      	  or die FAILED_EXECUTE_REQUEST.$prep->errstr;

        --------------------------------
	Récupération des données (Optionnel)
        --------------------------------

                > fetchrow_arrayref
                ``````````````````````````

                        Référence sur un tableau contenant une ligne:
                        
                        Le premier appel, on récupère la première ligne,
                        Le deuxième, la deuxième ligne ...

                        Exemple d'utilisation:

                                while (my $ref = $prep->fetchrow_arrayref)
                                {   
                                    my ($value1, $value2, $value3, ...) = @$ref;
                                    print "value1 => $value1, value2 => $value2 ...";
                                }

                > fetchrow_array
                ``````````````````````````

                        Tableau contenant une ligne:
                                
                        Même principe que précedement.

                        Exemple d'utilisation:

                                while (my @array = $prep->fetchrow_array)
                                {   
                                    my ($v1, $v2, $v3) = @array;
                                    print "v1 => $v1, v2 => $v2\n";
                                }

                > fetchrow_hashref
                ``````````````````````````

                        Référence sur une table de hash contenant une ligne:
                        Le couple clé valeur est définie par:
                                Nom de colonne => valeur

                        Même fonctionnement que arrayref:

                        Exemple d'utilisation:
                        
                                while (my $ref = $prep->fetchrow_hashref)
                                {
                                    print "value1 => $ref->{COLUMN_NAME1}, value2 => $ref->{COLUM_NAME2} ..."
                                }

                > fetchall_arrayref
                ``````````````````````````

                        Référence vers un tableau de référence (de tableau) ;)
                        Chaque référence du tableau contient une ligne de la table;

                        Exemple d'utilisation

                                my $ref = $prep->fetchall_arrayref;

                                foreach ( @$ref )
                                {
                                   print "@$_ \n" ;
                                }

                        Il est possible de ne sélectionner que les colonnes qui nous interesses:

                                $prep->fetchall_arrayref([N°_COLUMN]);

                                exemple:
                                
                                > $prep->fetchall_arrayref([2]); : récupère la deuxième colonne.
                                > $prep->fetchall_arrayref([-1, -2]); : récupère la dernière et l'avant dernière colonne.

                        On peut encore filtrer sa sélection grâce au hash:
                        On récupéra alors une Référence vers un tableau de référence (de hash).


                                > $prep->fetchall_arrayref({ COLUMN_NAME=>1, COLUMN_NAME2=>1 });

                                exemple:

                                > $prep->fetchall_arrayref({ nom=>1, age=>1 });

                                Par rapport à l'exemple précédent, on pourra afficher les valeurs avec:

                                >  print "%$_";
                                        ou
                                >  print "$_->{nom} , $_->{age}";


                        Limiter le nombre de ligne à afficher:

                                > $prep->fetchall_arrayref(option_de_selection,MAX_ROWS);

                                exemple:

                                > $prep->fetchall_arrayref(undef, 5);

                > fetchall_hashref
                ``````````````````````````

                        Référence vers une table de hash contenant un couple clé->réf.

                                > $prep->fetchall_hashref($KEYS);

                        La ou les clés permetrons de parcourir les différentes valeurs:

                        Exemple avec une clé:

                                > $ref = $prep->fetchall_hasref('name');
                                > print "Age for dupont : $ref->{dupont}->{age}\n"

                        Exemple avec plusieurs clé:
                                        
                                > $ref = $prep->fetchall_hashref( [ qw( length width) ] );
                                > print "La superficie pour une longueur de 40m et une largeur de 5m est de: $ref->{40}->{5}->{area}\n";


                > $prep->rows
                ``````````````````````````

                        Permet de récupérer le nombre de lignes d'une requête.
                        (Il faut avoir récupérer les données de la requête au moins une fois avec un fetch).

                        > my $rows = $prep->rows;
                

                Récupérer les noms de colonnes:
                ``````````````````````````

                        Une par une:

                        > my $column = $prep->{NAME}->[X] ; #Avec X le numéro de colonne.

                        Récupérer toute les colonnes:

                        > my $ref_columns = $prep->{NAME_hash};
                         
                          foreach my $colname (keys %$ref_columns)
                          {
                            print "[$colname]";
                          }
                        

        --------------------------------
        Fermer la session
        --------------------------------

               A faire à la fin ;)

	  	> $prep->finish;


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Connaître un type de fichier
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Revient à la commande "file" mais sa propre base de données:

         > use File::MimeInfo;
         > my $mime_type = mimetype($file);

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Archives
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Au même titre que la commande tar, 

        On peut décomprésser archiver .. grâce au module:

        >       use Archive::Tar;
        >       my $tar = Archive::Tar->new;

        (Support notament tar, gz et bz)

        Exemple de décompression/extraction:

        >       my @content = $tar->read($file);                                                                                      
        >       $tar->extract();                #extraction de l'archive
        >       print $content[0]->{name};      #Affiche le nom du dossier dans lequel l'archive est compréssée.




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
POO - Programmation objet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	La POO est bien plus focalisée sur les données que le code procédurale qui lui est basé sur les actions à réaliser.

	--------------------------------------
	Traduction
	--------------------------------------

		classe = Représentation et traitement des données (exemple de classe: ordinateur)
			Cette classe décrira les composants de l'ordinateur (CPU, GPU ...)
			Une classe permet de "batir un élément complet"
		méthodes = traitements des données (fonctions)
		instance = objet d'une classe (= ordinateur construit à partir des éléments choisis)

	--------------------------------------
	Correspondance
	--------------------------------------

		classe = module 
		objet (instance d'une classe) = référence associée à cette classe. (nommée "bless")
	
	--------------------------------------
	Créer un constructeur (une classe)
	--------------------------------------

		>	#file : Computer.pm
		>	package Computer;				#Nom du package
		>	use strict;					#activation de la syntaxe strict de perl
		>	sub new         				#fonction de construction de l'objet
		>	{
		>		my ($class,$fCPU,$qRAM,$qHDD) = @_;	#valeurs définissant l'objet, on récupère en premier lieu le nom de la classe.
		>		my $self = {};				#référence anonyme vers une table de hachage vide 
		>		#on utilise $self plus généralement.
		>		bless($self, $class);			#pour lier la référence au package
		>		$self->{FCPU} = $fCPU;			#initialisation des champs de l'objet.
		>		$self->{QRAM} = $qRAM;
		>		$self->{QHDD} = $qHDD;
		>		return $self;				#retourner la référence vers la table de hachage construite.
		>	}
		>
		>	sub type
		>	{
		>		my ($class,$format,$cpu,$chipset) = @_;
		>		bless($self, $class);
		>		$self->{FORMAT} = $format;
		>		$self->{CPU} = $cpu;
		>		$self->{CHIPSET} = $chipset;
		>		return $self;
		>	}
		>	1;						#code de retour du module

	--------------------------------------
	Appeler un constructeur (une classe)
	--------------------------------------

		Lorsqu'on créer une instance (un objet), on fait une référence vers une table de hachage.

		>	#!/usr/bin/perl -w
		>	use strict;
		>	use Computer;
		>	
		>	my $pc1 = Computer->new( "3.1GHZ", "512mB", "1To" ); #création d'une instance Computer
		>	#ou
		>	my $pc1 = new Computer( "3.1GHZ", "512mB", "1tO" );

	--------------------------------------
	Manipulation de l'objet
	--------------------------------------
		
		____________________
		Afficher la classe d'appartenance de l'objet:

			>	print "$pc1\n";  # on doit obtenir une ligne du type: Computer=HASH(0x90f...)

			Si on a pas le nom du module c'est que la table n'est pas "bénie" (il faut utiliser bless).
		
		____________________
		Afficher le contenue de l'objet:

			>	use Data::Dumper;
			>	print Dumper($pc1)."\n";


		Attention lorsqu"on copie un objet, on créera simplement une autre référence sur le même objet.


	--------------------------------------
	Méthode
	--------------------------------------

		Une méthode est une fonction qui s'applique à un objet:
		On peut donc récupérer les valeurs de cet objet.
		____________________
		Ecrire la méthode 

		>	# fichier Computer.pm
		>
		>	sub speedFan
		>	{
		>		my ($self,$speed) = @_;
		>		print "Mon $self->{CPU} est ventilé à $speed rpm.\n"
		>	}
		
		____________________
		Appeler la méthode

		>	$pc1->speedFan( 120 );

	--------------------------------------
	Parcourir les champs
	---------------------------------------

		On le fait de manière identique à une référence d'une table de hachage:

		>	foreach my $key (keys %$pc1)
		>	{
		>		print "$key : $pc1->{$key}\n";
		>	}

		Note: on ne peut pas protéger les champs d'un objet en Perl. On peut toutefois notifier qu'un module est privé en mettant un "_" devant le nom.

	--------------------------------------
	Composition
	---------------------------------------

		La composition définit un objet constitué d'autres objets.

		Exemple: on définit un objet "Parc informatique" comportant une liste de pc 

		>	#ParcInfo.pm
		>	
		>	package ParcInfo;
		>	use strict;
		>	
		>	sub new
		>	{
		>		my ($class,$nb_pc) = @_;
		>		my $self = {};
		>		bless($self, $class);
		>		$self->{NB_PC} = $nb_pc;
		>		$self->{COMPUTER} = [];
		>		return $self;
		>	}
		>
		>	sub add_pc
		>	{
		>		my ($self, $computer) = @_;
		>		if( @{$self->{COMPUTER}} < $self->{NB_PC} )
		>		{
		>			push @{$self->{COMPUTER}}, $vehicule;
		>			return 1;
		>		}
		>		return 0;
		>	}
		>
		>	sub view_parc
		>	{
		>		my ($self) = @_;
		>		my $string = "{ParcInfo:$self->{NB_PC},";
		>		$string .= join( ',', map( { $_->view_parc() }
		>				@{$self->{COMPUTER}} ) );
		>		return $string."}";
		>	}

		Manipulation:

		>	use ParcInfo;
		>	my $parcinfo = ParcInfo->new(5);
		>	my $pc = new Computer();


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Basename et Dirname
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        > use File::Basename;
        > 
        > my $dir = dirname MON_FICHIER
        > my script = basename MON_FICHIER

        exemple:

        > my $dir = dirname $0
        > my script = basename $0

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Supprimer les doublons
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        >      use List::MoreUtils qw/ uniq/;
        >      @uniq = uniq @doublons;

       n'oubliez pas de faire un sort avant:

       Exemple:

        >       @port_list = sort( { $a <=> $b } @port_list );
        >       @port_list = uniq( @port_list );

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
eval : évaluer une variable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Permet d'évaluer une chaîne et de l'intérpréter comme du code perl.
        Pratique par exemple dans le cas de la lecture de fichier contenant des variables.

        exemple:
                
                eval '$variable = "hello"' ; Intérprétera la variable et lui assignera la chaine hello.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Template Récursivité
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Il y a surement moult solution plus propre que celle là mais néanmoins ça fonctionne :

        Ce template permet d'éxécuter une commande en récupérant une valeur de façon récursive:

                
                #Dans un hash, je stock un hash d'un tableau pour chacune des cléf:

                my @Array1 = ( 'a', 'b', 'c', 'd' ) ;
                my @Array2 = ( 1, 2, 3, 4 ) ;

                $ArrayRef1 = \@Array1
                $ArrayRef2 = \@Array2
                
                my %hash = (  key1  =>  $ArrayRef1  ,
                              key2  =>  $ArrayRef2  );

                #Je souhaite exécuter une commande en fonction du niveau de boucle renseigné:
                # loop1 {
                #    loop2 { ...
                #       CMD
                #    }
                # }

                
                #J'aimerais appliquer la récursivité pour les valeurs stockées dans les références des clés suivante:

                my @loop = ( 'key1', 'key2' )
 
                my $indice = @args - 1;
                my @loop_reverse = reverse( @loop );
                my @value;
 
                recurse( \%hash,\@loop_reverse,$indice,\@value);

                sub recurse
                {
                        my ($hashRef, $loopRef, $indice, $valueRef) = @_; 
                                             
                        #Je récupère le nom de la clé
                        my $key = $loopRef->[$indice];

                        #Pour chaque valeur comprise dans le tableau correspondant à cette clé:
                        foreach ( @{$hashRef->{$var}} ) { 
                 
                                # Je stock dans un tableau la valeur de cette clé
                                $valueRef->[$i] = $_; 
                 
                                # Si l'indice n'est pas = à 0 alors on déscend d'un niveau en réexuctant la même fonction:
                                if( $indice != 0 ) { 
                                        my $indice = $indice - 1;
                                        recurse( \%hash,\@loop_reverse,$indice,\@value);
                                }   
                                # Sinon j'exécute ma commande en retrouvant les valeurs précédentes de chaque niveau:
                                else {
                                        my $y = 0;
                                        foreach my $key ( @$loopRef ) { 
                                                print "$key=$valueRef->[$y] |";
                                                $y = $y + 1;
                                        }   
                                        print "\n";
                                }   
                 
                        }   
                }

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FORK
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	--------------------------------------
	Links
	--------------------------------------

                http://www.commentcamarche.net/faq/10611-que-fait-un-fork
                http://blogs.perl.org/users/burak_gursoy/2010/07/parallel-programming-with-fork-and-tailiing-logs.html

	--------------------------------------
	Comment forker
	--------------------------------------
		____________________
                Création du fork:

                        my $pid = fork();

		____________________
                Lancement du code:

                        if( $pid ) { 
                                #parent
                                push @children, $pid;
                                $counter++;
                        }
                        elsif( $pid == 0) {
                                #child     

                                exit;
                        }
                        esle {
                                die "couldn't fork: $!\n";
                        }
		____________________
                Control du fork: (pour éviter les fork bomb)

                        if ( $counter >= $configHR->{fork_limit} ) {
                            warn "A warning to inform that the program will "
                                 ."discard any logs from now on\n";
                            warn "The user either has to change the hard coded limit "
                                  ."or create another instance\n";
                            last;
                        }

		____________________
                kill du fork: (attente de la fin des process enfants).


                        foreach my $pid ( @children ) {
                                waitpid( $pid, 0);
                        }

	--------------------------------------
	Exemple concret:
	--------------------------------------

                my( @children, $counter ) ;

                foreach my $foo_arg ( @what_you_want ) {
                        my $pid = fork();       #création du fork pour l'envoie en parallèle des commandes.
                        if( $pid ) { 
                                #parent
                                push @children, $pid;
                                $counter++;

                                if ( $counter >= $configHR->{fork_limit} ) {
                                    warn "A warning to inform that the program will "
                                         ."discard any logs from now on\n";
                                    warn "The user either has to change the hard coded limit "
                                          ."or create another instance\n";
                                    last;
                                }
                        }
                        elsif( $pid == 0) {
                                #child
                                     
                                #Your code

                                exit;
                        }
                        else {
                                die "couldn't fork: $!\n";
                        }

                }

                foreach my $pid ( @children ) {
                        waitpid( $pid, 0);
                }

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Format de données
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	--------------------------------------
	Pack/Unpack
	--------------------------------------

            Permet de formater les données.
            Par exemple d'une chaine en binaire.

            Pratique pour forger des paquets.

	    ____________________
            > pack TEMPLATE, LIST
            
	    ____________________
            > unpack TEMPLATE, EXPR

	--------------------------------------
	Les formats
	--------------------------------------

            A : ASCII
            c : char (8bit)
            C : char non signé (8 bit)
            s, l, q : valeurs entières signés (32 bits)
            ...

	--------------------------------------
	Modifieur
	--------------------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Réseau
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	--------------------------------------
	Socket
	--------------------------------------

            Note sur le mode row: Indique au système que nous somme à la charge de l'écriture des en tête.

            use Socket;
            use IO::Socket; #plus haut niveau que Socket

	    ____________________
            Client:

                use Socket;
                my ($remote, $port, $iaddr, $paddr, $proto, $line);

                $remote = shift || 'localhost'
                $port = shift || 12345; #random port

                if ($port =~ /\D/) { $port = getservbyname($port, 'tcp') }
                die 'No port' unless $port;

                $iaddr = inet_aton($remote)
                $paddr = sockaddr_in($port, $iaddr);

                $proto = getprotobyname( 'tcp' );
                socket( SOCK, PF_INET, SOCK_STREAM, $proto) || die "socket: $!";
                connect( SOCK, $paddr ) || die "connect: $!";

                while (defined($line = <SOCK>)) {
                    print $line;
                }

                close (SOCK)    [[ die "close: $!";
                exit;
	    ____________________
            Serveur:

~~~~~~~~~~~~~~~~~~~~~~~~~~
Title1
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        subt2
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
