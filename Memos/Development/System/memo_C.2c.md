===========================================================
		C 
===========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Links
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        http://fr.openclassrooms.com/informatique/cours/apprenez-a-programmer-en-c
        http://c.developpez.com/
        http://fr.wikipedia.org/wiki/Compilateur

        http://www.acm.uiuc.edu/webmonkeys/book/c_guide/
        http://en.cppreference.com/w/c

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	L'éxécuter
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Contrairement à un langage plus "portatif" il faut vous doter d'un compilateur.
Note:
	Le compilateur génère des fichiers binaires à partir de vos fichiers sources
	Le rendant utilisable uniquement par un système et une architecture après compilation. (Performances élevées)
	L'interpréteur quand à lui réalise cette opération à la volée.
	Ce qui nous permet de garder les sources et de les éxécuter sur n'importe quel système doté d'un interpréteur.
	(Un peu moins performant que la compilation car il compile à chaque fois.)
	Pour ce qui est de java et sa machine virtuelle, c'est un peu un mix des deux. A approfondir...

        Note sur le compilateur: (Tiré du wikipedia)

                Un compilateur effectue les opérations suivantes : analyse lexicale, pré-traitement (préprocesseur), analyse syntaxique (parsing), analyse sémantique, génération de code et optimisation de code.
                Quand le programme compilé (code objet) peut être exécuté sur un ordinateur dont le processeur ou le système d'exploitation est différent de celui du compilateur, on parle de compilation croisée.

                La compilation est souvent suivie d'une étape d'édition des liens, pour générer un fichier exécutable.


	-------------------------
	Windows
	-------------------------
		Soit séparément:
			-débogueur
			-compilateur
			-traitement de texte
			
		Soit tout en un (IDE = integrated development environment )
			Code::Blocks (version mingw)
	
	-------------------------
	Linux
	-------------------------
		Pour faire simple on utilisera le même IDE

			apt-get install codeblocks

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Code minimal
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Les directives de préprocesseur (ajout des librairies);
	et une fonction main:


		#include <stdio.h>
		#include <stdlib.h>
		
		int main() //ou main(int argc, char *argv[])
		{
			prtintf("Hello world!\n");
			return 0;
		}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Arréter un programme en C
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Il suffit de mettre un return 0; dans le main.
        Note:
                return 0 : dire que l'éxécution ne c'est pas bien déroulée.
                return 1 : pour dire que l'execution c'est bien déroulée.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Commentaires
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	// commentaire simple
	/* commentaire sur plusieur lignes */

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Les types de variables
	-------------------------

		________________
		Nombres:

			Les principaux types:
			(valeur standard)

			entiers
                        ``````````````
				signed char : -128 à 127
				int : -32767 à 32767
				long : -2147483647 à 2147483647

				Pour stocker uniquement un nombre positif:
				Il faut rajouter 'unsigned' devant le type:
					
				unsigned char: 0 à 255
				unsigned int 0 à 65535
				unsigned long 0 à 4294967295
			

			décimaux
                        ``````````````
				float : -10^37 à 10^37
				double : -10^37 à 10^37
		________________
		Chaînes:

	-------------------------
	Déclarer une variable
	-------------------------
	
		Le nom doit commencer par une lettre et ne pas comporter d'espace.
		Seul l'underscore _ est accepté comme caractère spécial.
		Et pas d'accent.

		________________
		exemples:

			int monNomDeVariable;
			monNomDeVariable = 2;

			float autreNom = 7;

			PLusieur variable sur une ligne (d'un même type):
			
                                int maVar1 = X, mavar2 = Y;

	-------------------------
	Constantes
	-------------------------

		Pour qu'un variable reste inchangée (et donc de devienne une constante);
		Il faut rajouter le mot 'const' devant sa déclaration:

		const int MA_VARIABLE = X;

		(souvent écrite en maj)
		
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Affichage
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Note: la console windows ne gère pas les accents

	-------------------------
	du texte simple
	-------------------------

		printf("mon_texte\n");
		
			\n : retour à la ligne
			\t : tabulation     

	-------------------------
	des variables
	-------------------------   

		En fonction tu type de variable:

			%d : int
			%ld : long
			%f : float ou double
                        %c : char
                        %s : char[]

		printf("valeur de ma variable1: %d et de ma variable2: %d", maVar1, maVar2);

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Saisir du texte
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

	-------------------------
	Scanf
	-------------------------   
                Voir: http://xrenault.developpez.com/tutoriels/c/scanf/

                Presque similaire à printf:

                scanf("%type", &ma_variable);
                
                exemple:

                        int bonbon = 0;
                        scanf("%d", &bonbon);

                Types:
                
                        %d: int
                        %ld: long
                        %f : float
                        %lf : double

	-------------------------
	Saisie d'un caractère (getchar)
	-------------------------   

                Lorsqu'on saisie des caractère, on ajoute en plus les caractères cachés comme Entrée (\n).
                Ce qui a pour effet de mettre '\n' dans le buffer stdin.
                C'est pourquoi lorsqu'on demande à saisir plusieur caractère à la suite, le deuxième scanf d'une série va prendre le prochain caractère disponible dans le buffer.

                Pour éviter cela, on utilise getchar:
		________________	
                getchar : lit le premier caractère du buffer d'entrée stdin
                        Si il n'existe pas de caractère alors il demande une saisie comme un scanf.

                        On peut ainsi créer notre propre fonction de saisie de caractère:

                        char readChar()
                        {
                                while (getchar() != '\n'); // On vide le buffer.
                                return getchar(); On demande de saisir un caractère
                        }

                exemple de saisie d'un caractère:

                        monCaractere = readChar();

	-------------------------
	Saisie sécurisée (fgets)
	-------------------------   

                fgets est la version sécurisée de gets (pas de protection d'overflow)
                stdin : pointeur vers le buffer d'entrée

		________________	
                fgets: (contenue dans stdio)

                        char *fgets( char *str, int num, FILE *stream );

                        str: un tableau pour contenir la chaine de l'utilisateur
                        num: la taille du tableau str (-1 avec \0 à la fin de la chaine)
                        stream: pointeur sur el fichier à lire (on peut renvoyer vers stdin, l'entrée standard)

                        Renvoie NULL en cas d'erreur.

                        fgets lit le contenu du buffer stdin et récupère les données avant des enelever.
                        Il ne va par contre lire pas plus de caractère que la taille donnée par num.
                        Il faut donc penser à vider le buffer lorsque la chaine dépasse cette taille.

                        exemple:

                                char nom[11];
                                fgets(nom, 11, stdin);

                       fgets garde par contre la saisie du clavier 'Entrée' et entre un \n.

                                Exemple:
                                        m a C h a i n e \n \0

                       Il peut être pratique de faire sa propre fonction pour avoir:

                                        m a C h a i n e \0 \0

	-------------------------
	Saisie custom
	-------------------------   


               void cleanBuffer() //Netoyage du buffer stdin
               {
                        int c = 0;
                        while( c != '\n' && c != EOF)
                        {
                                c = getchar();
                        }
               }

               int getString( char *string, int size)
               {
                        char *enterLocation = NULL; // pour contenir la position du \n

                        if (fgets(string, size, stdin) != NULL) //on demande de saisir du texte
                        {
                                enterLocation = strchr(string, '\n'); //on cherche la position de \n

                                if (enterLocation != NULL) //si un \n a été trouvé
                                {
                                        *enterLocation = '\0'; //on modifie le \n par \0
                                }
                                else // la chaine est trop longue (pas de \n)
                                {
                                        cleanBuffer();
                                }
                                return 1;
                        }
                        else
                        {
                                cleanBuffer();
                                return 0;
                        }
               }

               long getStringToLong() //conversion en long
               {
                        char textSize[100] = {0};

                        if( getString(textSize, 100))
                        {
                                return strtol(textSize, NULL, 10);
                        }
                        else
                        {
                                return 0;
                        }
               }


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Calculs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Les signes
	------------------------- 

		Addition: +
		Soustraction: -
		Multiplication: *
		Division: /
		Modulo: %
	
	-------------------------
	Simples calculs
	------------------------- 
		

		Exemple d'addition:
			
			int result = 8 + 9;
			printf("8 + 9 = %d", result);
			       
		Pour les opération à virgule, il faut impérativement opérer avec des nombres décimaux:

			double result = 0;
			result = 8.0 / 9.0;
			printf("8 / 9 = %f", result);

	-------------------------
	Calculs entre variables
	------------------------- 

		int result = 0, n1 = 8, n2 = 9;

		result = n1 + n2;
		printf("%d + %d = %d\n", n1, n2, result);

	-------------------------
	incrémentation / décrémentation
	------------------------- 

		n = n +1;
		équivaut à écrire:
		n++;

		de même que 
		n = n - 1;
		équivaut à:
		n--;
		
	-------------------------
	Raccourcis d'écriture
	------------------------- 

		n = n * 2;
		équivaut à:
		n *= 2;

		Le même principe s'applique à tout les signes

	-------------------------
	Quelques fonctions mathématiques:
	-------------------------

		#include <math.h>

		double absolu = fabs(n); //Retourne la valeur absolu
		double dessus = ceil(n); //Renvoie le premier nombre entier après le nombre décimal donné.
		double dessous = floor(n); //Idem mais à l'inverce (l'entier juste en dessous).
		double puissance = pow(n, p); //Avec p la puissance à laquelle on éleve n (n^p).
		double racine = sqrt(n); // Calcul la racine carré d'un nombre
		double radian = [sin,cos,tan,asin,acos,atan(n); Avec n un radian.
		double exponentielle = exp(n); Pour calculer l'exponentielle d'un nombre.
		double logarithùe = log(n); Calcul le logarithme népérien d'un nombre.
		double loga10 = log10(n); Calcul du logarithme base 10 d'un nombre.
		
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Conditions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Symboles
	-------------------------
	
		== : égal à
		> : supèrieur à
		< : infèrieur à
		>= : sup ou égal
		<= : infèrieur ou égal
		!= : différent
		&& : ET
		|| : OU
		! : NON
		
	-------------------------
	if
	-------------------------
	
		if ( CONDITION )
		{
			INSTRUCTIONS;
		}
		else if ( CONDITION )
		{
			INSTRUCTIONS;
		else
		{
			INSTRUCTIONS;
		}
		
		exemple:
				if ( taille > 6 && !(poid == 12 ))
		
		Note:
			Les accolades sont facultatives pour les instructions sur une seule ligne.
				
		________________	
		Les booléens:
		
			1 : vrai  --> if (1) // -> true
			0 : faux  --> if (0) // -> false
			
		________________	
		Résultat d'une condition:
		
			On peu obtenir directement le résultat d'une condition (1 ou 0) après avoir utiliser un opérateur conditionel.
			
				exemple:
				
					majeur = age >= 18;
					si l'age < 18 alors majeur sera égal à 0 (faux)
					sinon il sera égal à 1 (vrai).
					
					On pourra utiliser la valeur booléenne de cette variable:
					
					if (majeur)
					{
						INSTRUCTIONS;
					}
					
	-------------------------
	switch
	-------------------------
	
		On test chaque cas de la valeur d'une variable
	
		switch (variable)
		{
			case valeurX:
				INSTRUCTIONS;
			break;
			case valeurY:
				INSTRUCTIONS;
			break;
			default:
				DEFAULT_INSTRUCTIONS;
			break;
		}
		
	-------------------------
	Les ternaires
	-------------------------
	
		Le but étant de syntétiser l'expression d'une condition:
		
			variable = (CONDITION) ? valeur_si_vrai : valeur_sinon;
			
		exemple:
		
			taille = (grand) ? 180 : 120;
			
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Les boucles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	while
	-------------------------

		while( CONDITION )
		{
			INSTRUCTIONS;
		}

                Il est possible de raccourcir cette forme lorsqu'on n'a pas d'instruction:

                        while ( CONDITION );


		Pour éxécuter l'instruction une fois avant la condition:

		do
		{
			INSTRUCTIONS;
		} while( CONDITION );

	-------------------------
	for
	-------------------------


		for( INIT ; CONDITION ; ACTION )
		{
			INSTRUCTIONS;
		}

		exemple:

			int i;
			for( i = 0 ; i < X ; i++)
			{
				INSTRUCTIONS;
			}

			La boucle s'arretera à la valeur X
			On bouclera donc de 0 à X-1 compris.

	-------------------------
	Couper l'éxécution d'une boucle
	-------------------------

		________________	
                continue : permet de passer au saut suivant de la boucle.

                        exemple:

                                while( x<=10) {
                                        if (x == 3) {
                                                x++;
                                                continue;
                                        }
                                        x++;
                                }
                
		________________	
                break : permet d'arréter complétement la boucle et de passer au bloc suivant.

                        exemple:

                                while( x<=10) {
                                        if (x == 3) {
                                                break;
                                        }
                                        x++;
                                }
                                

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Les Fonctions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Type d'une fonction
	-------------------------

		Le type d'une fonction determine le type de variable qu'elle renvoie:

			type: char, int, long, double ...
		
		Pour les fonction qui ne renvoient rien:
			
			type: void

	-------------------------
	Créer une fonction
	-------------------------

		Il faut la déclarer avant le main pour qu'elle soit lu avant.
		
		type nomFonction( paramètres )
		{
			INSTRUCTIONS;
			return result; //Si ce n'est pas un void
		}

		Avec comme paramètres, les variables exploitées par la fonction.
		
		exemple de paramètres: (int a, int b ...)

		On peu déclarer plusieurs paramètres séparés par des virgules.

		exemple d'une fonction:

			int double(int nombre)
			{
				int double = 0;
				double = 2 * nombre;
				return double;

				ou

				return 2 * nombre;
			}

			void hello()
			{
				printf("hello world");
			}

                Note:
                        Le return ne peut renvoyer qu'une seule valeur.
                        Les variables déclarées sont nouvellement crées:
                                (voir porté locale et pointeur).

	-------------------------
	Appeler une fonction
	-------------------------

		maFonction(Mes arguments);

		Si on met plusieurs arguments on les sépare toujours avec des virgules:

		maFonction(int arg1, double arg2, ...);

		exemple en gardant celui du dessus:

			mon_double = double(nombre);

		On peu très bien utiliser directement le résultat retourner par une fonction comme une variable:

		Exemple avec switch:

			switch(menu())
			{
				...
			}
			
			Avec le menu() une fonction renvoyant le choix (un entier) entré par l'utilisateur.

	
	-------------------------
	Quelques fonctions
	-------------------------
		________________	
		random
		
			#include <time.h>

			srand(time(NULL)); // Pour initialiser le nombre aléatoire.
			nombreAleatoire = rand();

			Un nombre random compris dans un range:

                                nombre = (rand() % (MAX - MIN + 1)) + MIN;

                        Un nombre compris entre 0 et un nombre:

                                rand() % nombreMax;

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Programmation modulaire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        -------------------------
        les prototypes 
        -------------------------

                Ils permettent de déclarer les fonction après les directives de préprocesseurs pour les rendre accessibles même écrites après le main.
                pour ce faire on ajoute simplement le nom complet de la fonction suivi d'un ;

                exemple:

                        double maFonction(int arg1, int arg2);
                        ou
                        double maFonction(int, int);

                Ces prototypes étant, communément, directement placer dans des header.h 

                Pour les tableau (ou pointeur) il ne faut pas oublier de mettre une '*' (si on utilise la version courte).
                
                Exemple avec un tableau de char:

                        double maFonction(char*);
        
        -------------------------
        Organiser ses fichiers
        -------------------------
                Pour garder une certaine lisibilite,on segmente un projet en plusieurs fichiers:

                        Exemples :
                                        
                                Sources
                                        |_ fonction.c
                                        |_ main.c
                                Headers
                                        |_ fonction.h

                        Les .c correspondant aux fonctions de notre programme
                        Et les .h les prototypes de ces fonctions.

                        Pour inclure un header dans notre fichier.c :

                                #include "headers/fonction.h"

                        Si il est directement au même endroit que notre .c :

                                #include "fonction.h"

        -------------------------
        Du préprocesseur au fichier exécutable.
        -------------------------

                Le preprocesseur agit avant la compilation et permet entre autre d'inclure les headers dans nos fichiers sources .c.
                Le compilateur traite ensuite un à un chaque fichier source pour les transformer en fichier binaire .o ( ou .obj ). Ces fichiers sont temporaire mais peuvent être conserver pour les prochaines compilation dans le cas ou il n'y aurai pas de modification apporté, on gagnerai ainsi en temps de compilation.
                Enfin nous avons le linker qui permet de regrouper ces fichiers binaires en un seul fichier executable en y incluant les librairies précompilées (.a ou .lib ).Donnant par exemple les .exe pour les windowsiens.

        -------------------------
        Portée des variables et des fonction
        -------------------------
		________________
                Variable locale :

                        Les variables déclarées dans une fonction sont supprimées une fois cette dernière terminée.
                        Pour conserver une variable au sein d'une fonction, on rajoute le mot 'static'. 
                        Ainsi son contenu sera gardé pour la prochaine exécution de la fonction.

                                Static int maVariable = 0;
                                
                        Note: la variable ne sera pas réinitialisé si elle a été déclare avec un = 0.

		________________
                Variable globale:

                        Déclarées en dehors de nos fonctions, apres les directives par exemple, elles sont accessibles par toutes les fonctions.
                        Pour qu'une variable globale puisse être limite a un fichier, on utilise la rend static:

                                Static int maVariable = 0;

		________________
                Fonction locale:

                        Les fonctions sont globale par défaut et accessible depuis tout les fichiers de notre projet.
                        Pour les limiter a un fichier, la aussi on utilise static:

                                Static int maFonction( int arg1, int arg2 )

                        Idem pour les prototypes.
                                                
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les pointeurs 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Il permettent de modifier directement la valeur d'une variable en fonction de son adresse.
        En fait cela revient à modifier directement les valeurs contenus dans les cellules de la mémoire vive.

        Un pointeur = Une adresse. (c'est une variable qui contient une adresse mémoire).
        
        Note: Une cellule ne peut comporter que un nombre.
                Une variable est traduite par une adresse (par le compilateur)
        
        -------------------------
        Afficher l'adresse d'un variable:
        -------------------------

                %p : type pointeur (hexadécimal)
                & : à placer devant le nom de variable, il indique l'adresse de la variable.

                exemple:

                        printf("adresse : %p", &variable);

        -------------------------
        Créer/manipuler un pointeur:
        -------------------------
		________________
                Déclarer un pointeur:

                        type_de_variable_cible *pointeur;

                        exemples:

                                int *pointeur1;
                                ou 
                                int* pointeur1, pointeur2 ... ;

                        Pour récupérer l'adresse d'une variable:

                        exemple:

                                int variable;
                                int *pointeur = &variable;

                        Note: il faut faire attention au type du pointeur, il doit correspondre à celui de la variable ciblée.
		________________
                initialiser un pointeur:
                        
                        int *pointeur = NULL;
		________________
                Afficher l'adresse du pointeur:

                        printf("%d", &pointeur);
		________________
                Afficher l'adresse contenu dans un pointeur:

                        printf("%d", pointeur);
		________________
                Afficher la valeur ciblée par le pointeur:

                        printf("%d", *pointeur);
		________________
                Envoyer un pointeur:

                        il suffit d'envoyer l'adresse d'une variable au pointeur déclaré dans une fonction:

                        exemple:
                                int variable;
                                int *pointeur = &variable;

                                void maFonction(int *pointeur)
                                {
                                        INSTRUCTIONS;
                                }

                                maFonction(&variable);
                                ou
                                maFonction(pointeur);
		________________
                Récap:

                        //Déclarer un pointeur:

                        Type *monPointeur = NULL;
                        Type* monPointeur = NULL;
                        Type *monPointeur = &variable;
                        Type monTableau[] = {0};
                        Type monTableau[5] = {0};

                        //Corespondances
                        
                        &variable = adresse.
                        monPointeur = &variable.
                        &monPointeur = adresse du pointeur.
                        monPointeur = adresse.
                        monTableau[] = pointeur = adresse
                        monTableau[5] = 5 adresses = 5 pointeurs
                        *pointeur = valeur contenu à l'adresse
                                *(pointeur + 1) = valeur contenu à l'adresse + 1 (une case d'un tableau)
                       (*monPointeur).variable1 = accès à la variable contenu dans une structure.
                       monPointeur->variable1 = idem


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les tableaux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Les tableaux sont créer dans espace mémoire contigu, et contiennent des valeurs de même type.
        Ils commencent par la 'case', l'indice 0.
        Les indicent correspondent à des pointeurs.

        -------------------------
        Déclarer un tableau
        -------------------------

                TYPE NOM_TABLEAU[NOMBRE_DE_CASE];

                exemple:
                        int tableau[2];

                        tableau[0] = 1;
                        tableau[1] = 2;

                        ou encore:

                        int tableau[2] = {1,2};

        -------------------------
        Accéder à son tableau
        -------------------------

                tableau: affiche un pointeur sur tableau.
                tableau[X] : affiche la valeur contenu à l'indice X.
                *tableau : renvoie la première valeur du tableau.
                        *(tableau + 1) : renvoie la seconde valeur ...

                exemple:

                        printf("Case1: %d", tableau[0]);   #Affichera 1

        -------------------------
        Tableau à taille dynamique
        -------------------------

                voir allocation dynamique.

                Disponible sur les compilateur à partir de la version C99

                        int size = 5;
                        int tableau[size];

                Sinon utiliser l'allocation dynamique (recommendé)

        -------------------------
        Parcourir un tableau
        -------------------------

                À l'aide d'une boucle: 

                       for (i = 0; i < DERNIER_INDICE ; i++)
                       {
                                INSTRUCTIONS;
                                exemple:
                                        printf("%d\n", tableau[i]);
                       }

                Note: pour récupérer le dernier indice , il faut pensez à incrémenter une variable somewhere.
                        ou voir avec sizeof() qui donne l'espace qu'utilise un tableau en mémoire en fonction de son type:
                sizeof( tableau ) / sizeof(type) 

                exemple:
                        sizeof( tableau ) / sizeof(int);
                                

        -------------------------
        initialiser un tableau
        -------------------------

                À l'aide d'une boucle: 

                       for (i = 0; i < DERNIER_INDICE ; i++)
                       {
                                tableau[i] = 0;
                       }

                       ou encore:

                       int tableau[0] = {0};

                       Note: fonctionne uniquement à la déclaration du tableau.

        -------------------------
        Envoyer un tableau à une fonction
        -------------------------

                Il s'envoi comme un pointeur

                exemple:

                        void maFonction(int *tableau)
                        {
                                INSTRUCTIONS;
                        }

                        ou encore:

                        void maFonction(int tableau[])
                        {
                                INSTRUCTIONS;
                        }

                        maFonction(tableau);

        -------------------------
        Récupérer le tableau d'une fonction:
        -------------------------

                exemple:

                        char* maFonction()
                        {
                                char *monTableau;
                                        INSTRUCTIONS...
                                return monTableau;
                        }

                        char *result
                        result = maFonction;
                        printf("Resultat: %s", result);

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Les caractères
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        char : peut être compris entre -128 à 127

        Ils sont directement traduits en nombre grâce à la table ASCII

        -------------------------
        Déclaration
        -------------------------

                un caractère:

                        char lettre = 'A';

                initialisation:

                        char myChar = 0;

        -------------------------
        Afficher un caractère:
        -------------------------

                sa valeur décimal:

                        printf("%d\n", lettre);

                la lettre même:

                        printf("%c\n", lettre);

        -------------------------
        Saisir un caractère:
        -------------------------

                scanf("%c", &lettre); 

                (Voir saisie)

        -------------------------
        Une chaine de caractère = tableau de caractère
        -------------------------

                Ce sont tout simplement des tableaux de caractères:
		________________
                type:
                        %s
		________________
                Déclarer une chaîne:

                        char chaine[X];
                                chaine[0] = 'A';
                                chaine[1] = 'B';
                                chaine[2] = 'C';
                                ...
                        ou
                        char chaine[] = "mon_mot"; //Ne marche que pour la déclaration

                        Avec X le nombre de caractère + le caractère spécial de fin de chaine: \0

		________________
                Afficher une chaîne:

                        printf("%s", chaine);
		________________
                Saisir une chaîne:

                        scanf("%s", chaine);

                        Note: le & devant chaine est bien volontairement supprimé car ici un tableau fait référence à un pointeur. (Voir pointeur).

		________________
                Parcourir une chaîne:

                        exemple type:

                                int indice = 0;
                                char caractere = 0;

                                do
                                { 
                                        INSTRUCTIONS;
                                        caractere = chaine[indice];
                                        indice++;
                                }
                                while(caractere != '\0');

        -------------------------
        Écrire dans une chaîne
        -------------------------

                Par exemple pour écrire dans la chaine 'chaine':

                char = chaine[X];

                sprintf(chaine, "Ma phrase %d", variable);

                Afficher le résultat:
                        printf("%s", chaine);

        -------------------------
        Caractères spéciaux:
        -------------------------

                %%      affichage du caractère '%'
                \0      caractère null ; valeur 0, délimiteur de fin de chaîne de caractères
                \a      alerte ; beep système
                \b      backspace ; déplacement du curseur d'un caractère en arrière
                \f      form feed ; saut de page
                \n      new line ; saut de ligne
                \r      carriage return ; retour chariot
                \t      tabulation horizontale
                \v      tabulation verticale
                \\      affichage du caractère '\'
                \'      affichage du caractère '''
                \"      affichage du caractère '"'
                \Onn    affichage de la valeur nn en octal
                \Xnn    affichage de la valeur nn en hexadécimal

        -------------------------
        Les fonctions utiles
        -------------------------

                #include <string.h>
		________________
                Calculer la longueur d'une chaîne:

                        size_t strlen(const char* chaine);

                        exemple:

                                int longueur = strlen(chaine);
		________________
                Copier une chaîne:

                        char* strcpy(char* chaineA, const char* chaineB);

                        exemple:

                                strcpy(chaineA, chaineB);

		________________
                strcat: concaténer 2 chaînes: (mettre à la suite)

                        char* strcat(char* chaine1, const char* chaine2);

                        exemple:
                                
                                strcat(chaine1, chaine2);
		________________
                strcmp: comparer 2 chaînes

                        Test si les chaînes sont identiques, renvoie 0 si c'est ok, 1 sinon.

                        int strcmp(const char* chaine1, const char* chaine2);

                        exemple:

                                if (strcmp(chaine1, chaine2) == 0)
                                {
                                        printf("C'est identique\n");
                                        INSTRUCTIONS;
                                }
		________________
                strchr: rechercher un caractère

                        Renvoie NULL si elle n'a rien trouvé.

                        char* strchr(const char* chaine, int caractereARechercher);

                        exemple:
                                char result[] = NULL;
                                result = strchr(chaine, 'a') 

                                if ( result != NULL)
                                {
                                        printf("trouvé!\n");
                                        printf("fin de chaine: %s" result);
                                        INSTRUCTIONS;
                                }

                        Voir strrchr pour renvoyer sur le dernier caractètre trouvé.

		________________
                strpbrk: premier caractère d'une chaine

                        cette fonction renvoie un pointeur sur le permier caractère trouvé de la liste fournis

                        char* strpbrk(const char* chaine, const char* lettresARechercher);

                        exemple:

                                char suite[];

                                suite = strbrk("TEXTE", "abcde");

                                if (suite != NULL)
                                {
                                        printf("suite après match: %s", suite);
                                }

		________________
                strstr: rechercher un mot

                        Presque identique que strpbrk mais cette fois ci recherche le mot entier.

                        char* strstr(const char* chaine, const char* mot);

                        exemple:
                                
                                char suite[];

                                suite = strstr("TEXTE", "mot");

                                if (suite != NULL)
                                {
                                        printf("trouvé !");
                                }

		________________
                toupper: mettre en majuscule un caractère:

                        #include <ctype.h>

                        Majuscule = toupper(caractere);

		________________
                strtol: convertir une chaine en long

                        long strtol( const char *start, char **end, int base );

                        start : chaine à convertir
                        base: la base arithmétique (10 : décimal, 2: binaire ...)
                        end: pointeur qui permet de récupérer le premier caractère lu (qui n'est pas un chiffre)


                        exemple:

                                strtol( maChaine, NULL, 10);
		________________
                strtod: convertir une chaine en double

                        double strtod( const char *start, char **end );

                        Fonctionne comme strtol mais prend en considération le .

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Le préprocesseur
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Il s'occupe de lire les directives de préprocesseur dans le code avant la compilation.

        -------------------------
        Directives de préprocesseur
        -------------------------

                Elles commencent par des '#' et sont traitées par le préprocesseur.
		________________
                #include:

                       Cette directive permet d'inclure le contenu d'un fichier.

                       exemple: les fichier.h (header)

                       <fichier.h> : inclure un fichier de notre IDE.
                       "fichier.h" : inclure un fichier de notre projet.
		________________
                #define:

                        Il permet de définir une constante de préprocesseur.
                        Avant la compilation chaque mot référant seront remplacés par la valeur associée.
                        Il s'applique à tous les fichiers.
                        Ils sont le plus souvent déclarés dans les headers.
                        Ils sont différents des constantes 'const' car se ne sont pas des variables et ne sont pas stockés directement en mémoire.
                        On l'associe à une configuration
                        Souvent utilisé pour définir la taille des tableaux
                        Il permet de remplacer un MOT par un code source (= macro)


                        exemple:

                                #define MONT_MOT 5

                        exemple pour un tableau:

                                #define TAILLE 1000

                                chat chaine1[TAILLE], chaine2[TAILLE];

                        Pour une chaine, ne pas oublier les guillemets:

                                #defiane MOT "maChaine"

                        Les MOTS ne sont pas obligé de contenir de valeur: // utile pour les macros

                        exemple:
                                #define MOT

                        Calculs
                        ``````````````

                                Il est possible d'effectuer des calcules dans les défines:

                                        exemple:
                                                #define SEGMENT 2
                                                #define CUBE (SEGMENT * SEGMENT * SEGMENT)

                        Constantes prédéfinies
                        ``````````````
                               __LINE__ : donne le numéro de la ligne actuelle. 
                               __FILE__ : donne le nom du fichier actuel.
                               __DATE__ : donne la date de compilation.
                               __TIME__ : donne l'heure de la compilation.

                               exemples:
                                        printf("Error at line %d in %s\n", __LINE__, __FILE__);

                        Macro
                        ``````````````
                                Elles servent à remplacer un MOT par un code source:

                                Sans paramètres:

                                        #define HELLO() printf("hello world\n");
                                        int main()
                                        {
                                                HELLO()  
                                                ...
                                        }

                                Sur plusieur lignes:

                                        #define HELLO() printf("hello world\n"); \
                                        printf("it's a new day\n"); \
                                        printf("it's a new life\n");

                                        int main()
                                        {
                                                HELLO()
                                                ...
                                        {

                                Avec paramètres: 

                                        Ils fonctionnent presque comme des fontions:

                                        #define GRAND(taille) if (taille >= 170) \
                                        printf("Vous etes grand ! \n");
                                        int main()
                                        {
                                                GRAND(180)
                                                ...
                                        {

                        Conditions
                        ``````````````

                                Il est possible d'insérer des conditions comme directives de préprocesseur:

                                exemple:

                                        #if condition
                                                /* CODE_SOURCE */
                                        #elif condition2
                                                /* CODE SOURCE2 */
                                        #enfif


                                On peut aussi vérifier si un MOT est définit: (ifdef)

                                exemple:

                                        #define LINUX

                                        #ifdef WINDOWS
                                                /* CODE_SOURCE */
                                        #endif

                                        #ifdef LINUX
                                                /* CODE_SOURCE */
                                        #endif

                                Ou l'inverse vérifier qu'il n'est pas définit: (ifndef)
                                Note:
                                        Cette méthode est très utilisé pour éviter les inclusions infinies.
                                        Il est préférable de le faire dans tout les fichiers header:

                                exemple:

                                        #ifndef INCLUDED_FICHIER        //si le fichier n'a pas été inclu:
                                        #define INCLUDED_FICHIER
                                                /* CODE SOURCE DU HEADER (define, include, prototypes...) */
                                        #endif

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les structure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Elles permettent de rassembler plusieurs variables de différents types.
        Elles sont écritents normalement dans les .h

        -------------------------
        Définir une structure
        -------------------------

                struct MaStructure
                {
                        int variable1;
                        double variable2;
                        char chaine[XXX];
                        ...
                };

                exemple:

                        struct Voilier
                        {
                                char nom[100];
                                int nb_voiles;
                                int nb_coques;
                                char matiere_coque[100];
                        };


        -------------------------
        Créer une variable de type structure
        -------------------------

                struct MaStructure MaVariable;

                exemple:
                        struct Voilier Bateau;

                la variable Svariable sera composée de toutes les variables définies dans MaStructure

        -------------------------
        Le typedef
        -------------------------

                Le typedef permet de créer un alias pour ne pas avoir à réecrire tout le temps struct par exemple lors de définition de variable:

                Déclaration:
                        typedef struct MaStructure MonAlias;

                Définition:
                        MonAlias MaVariable;

                exemple:
                        //------ header

                        typedef struct Voilier Voilier;
                        struct Voilier
                        {
                                char nom[100];
                                int nb_voiles;
                                int nb_coques;
                                char matiere_coque[100];
                        };

                        //------ main

                        Voilier Sbateau;

        -------------------------
        Utiliser les variables d'une structure
        -------------------------

                MonAlias Svariable;

                Svariable.variable1 = XX;
                Svariable.variable2 = XX;

                exemple:

                        Voilier Sbateau;
                        printf("Nom Bateau");
                        scanf("%s", Sbateau.nom);

        -------------------------
        Un tableau de type structure:
        -------------------------

                MaStructure MonTableau[XXX]

                exemple:

                        Voilier Scatamarans[500]

                        Accéder aux sous-variables:
                        ``````````````

                                MonTableau[X].variable1;

                                exemple:

                                        Scatamarans[0].nb_voiles = 2;

                
        -------------------------
        Initialiser sa structure
        -------------------------

                Il suffit de mettre toutes les valeurs contenu dans la structure à 0.

                exemple:
                        Voilier Sbateau = { "", 0 , 0 };


                OU l'aitre possibilité est de renvoyer le pointeur de la structure à une fonction d'initialisation.

        -------------------------
        Pointeur de structure
        -------------------------

                MaStructure* MonPointeur = NULL;
                ou
                MaStructure *MonPointeur = NULL; // Plus pratique pour déclarer plusieurs pointeur

                Pour accéder ensuite à la valeur:

                       (*MonPointeur).variable1 = 0;
                       ou
                       MonPointeur->variable1 = 0;

        -------------------------
        Envoyer une structure à une fonction
        -------------------------

                int main()
                {
                        Voilier Pbateau;
                        initVoilier(&Pbateau);
                        return 0;
                }

                void initVoilier(Voilier* Pbateau) // Voilier* ici, represente bien un type de variable !
                {
                        (*Pbateau).nom = "";
                        (*Pbateau).nb_voiles = 0;
                        ...
                        // Ne pas oublier les parenthèses.
                        ou

                        Pbateau->nom = "";
                        Pbateau->nb_voiles = 0;
                }

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les énumérations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Les énumération permettent de stocker une liste de valeurs possibles pour une variable.

        -------------------------
        Définir une énumération
        -------------------------

                Par défaut chaque valeur déclarée s'incrémente à partir de 0.

                enum NOM_ENUM
                {
                        Valeur1, Valeur2, Valeur3
                };

                exemple:
                        
                        typedef enum Level Level;
                        enum Level
                        {
                                EASY, MEDIUM, HARD
                        };

                Avec EASY = 0, MEDIUM = 1, HARD = 2 ...

                Il est cependant possible d'attribuer une valeurs aux éléments de l'énumération:

                        Valeur1 = NN

                        exemple
                                enum Level
                                {
                                        EASY = 10 , MEDIUM = 50, HARD = 100
                                };


        -------------------------
        Utiliser une énumération
        -------------------------

                MON_ENUM MaVariable = ValeurX;

                exemple:

                        Level game = HARD;

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les Fichiers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Lors de la lecture/écriture d'un fichier, on place un pointeur qui va se déplacer dans le fichier.
        Il faut ici y voir une notion de curseur.

        -------------------------
        Les librairies
        -------------------------

                #include <stdlib.h>
                #include <stdio.h>

        -------------------------
        Ouvrir et fermer un fichier
        -------------------------

		________________
                ouvrir un fichier:

                        FILE* fopen(const char* NomFichier, const char* modeOuverture); 

                        pointeurFichier = fopen("MonFichier", "mode");

                        Note: pour les path, le fichier doit être à la racine de l'éxécutable sinon utiliser un path absolu.
                        Pour les path comprenant des antislash \, il faut les échaper:

                        C:\\Dossier1\\Dossier2\\MonFIchier

		________________
                modes d'ouverture
                        
                        r: lecture seule
                        w: écriture seule (+creation du fichier si manquant)
                        a: ajout à la fin du fichier (+creation du fichier si manquant)
                        r+: lecture + écriture (nécessite la création du fichier)
                        w+: lecture + écrite + initialisation du contenu (création du fichier si manquant)
                        a+: écriture et lecture à la fin du fichier (creation du fichier si manquant)

		________________
                Tester l'ouverture

                        Il faut vérifier si le pointeur ne renvoie pas NULL:

                        exemple:

                                if (fichier != NULL)
                                {
                                        INSTRUCTIONS;
                                }

		________________
                fermer un fichier

                        int fclose(FILE* MonPointeurFichier);


		________________
                exemple:
                        
                        FILE* fichier = NULL;

                        fichier = fopen("MonFichier.txt", "r+");

                        if (fichier != NULL)
                        {
                                INSTRUCTION LECTURE/ECRITURE;

                                fclose(fichier);
                        }
                        else
                        {
                                printf("error with MonFichier.txt");
                        }


        -------------------------
        Lire un fichier
        -------------------------

                Lors de la lecture d'un fichier, on déplace un curseur, il faut donc raisonner en ce sens.
		________________
                fgetc : lire un caractère

                        int fgetc(FILE* pointeurFichier);

                        exemple de lecture d'un fichier:

                                do
                                {
                                        caractereActuel = fgetc(fichier); // On lit le caractère
                                        printf("%c", caractereActuel); // On l'affiche
                                } while (caractereActuel != EOF);

		________________
                fgets : lire une chaîne (au maximum une ligne)

                        La fonction lit le nombre de caractère désiré mais s'arrête au premier \n (retour à la ligne).

                        char* fgets(char* chaine, int nbreDeCaracteresALire, FILE* pointeurFichier);

                        exemple de lecture d'une chaine:

                                fgets(chaine, TAILLE_MAX, pointeurFichier); // On lit un maximum de caractère
                                printf("%s", chaine); // On affiche la chaîne

                        exemple de lecture d'un fichier:

                                while (fgets(chaine, TAILLE_MAX, pointeurFichier) != NULL) // On lit tant qu'il n'y a pas d'erreur
                                {
                                        printf("%s", chaine); // On affiche la chaîne lu
                                }

                        Note:
                                fgets récupère toute la chaine y compris le \n.

                                Pour le supprimer, il suffit de le remplacer par \0
                                Dans ce cas on récupère la taille de la chaine et on change le dernier caractère:
                                        tailleChaine = strlen(chaine);
                                        chaine[(tailleChaine - 1)] = '\0'; //le tableau commence à 0!

		________________
                fscanf : récupérer le contenu d'un fichier dans une variable

                        Par exemple si on a 3 chiffres séparés par un espace dans un fichier et qu'on veux les récupérer dans 3 variables:

                        int chiffre[3] = {0}; //Un tableau de chiffre à déclarer avant de lire le fichier

                        fscanf(pointeurFichier, "%d %d %d", &chiffre[0], &chiffre[1], &chiffre[2]);
                        printf("Les meilleurs scores sont : %d, %d et %d", chiffre[0], chiffre[1], chiffre[2]);

        -------------------------
        Se déplacer dans un fichier
        -------------------------

		________________
                ftell: indique la position du curseur.

                        long ftell(FILE* pointeurSurFichier);

		________________
                fseek: positionne le curseur à un endroit.
                        
                        int fseek(FILE* pointeurFichier, long deplacement, int origine);

                        un nombre négatif correspond à un déplacement vers la gauche (en arrière)

                        l'origine peut être une de ces valeurs:

                                SEEK_SET: début du fichier
                                SEEK_CUR: position actuelle du curseur
                                SEEK_END: indique la fin du fichier

                        Exemples:

                                fseek(pointeurFichier, 2, SEEK_SET);
                                fseek(pointeurFichier, -4, SEEK_CUR);

		________________
                rewind: retour au début

                        void rewind(FILE* pointeurFichier);

                        exemple:

                                rewind(pointeurFichier);


        -------------------------
        Écrire dans un fichier
        -------------------------
		________________
                fputc : écrire un caractère à la fois

                        int fputc(int MonCaractère, FILE* PointeurFichier);

                        Le int renvoie un 'EOF'si l'écriture a échouée.

                        exemple:

                                fputc('A', PointeurFichier);

		________________
                fputs : écrire une chaîne

                        char* fputs(const char* chaine, FILE* pointeurFichier);

                        exemple:

                                fputs("Hello\nWhat's up?", pointeurFichier);
		________________
                fprintf : écrire une chaîne formatée

                        Fonctionne de la même manière qu'un printf:

                                fprintf(PointeurFichier, "Une phrase avec une variable: %d", variable)

        -------------------------
        Actions sur fichiers
        -------------------------
		________________
                $rename : renommer un fichier

                        int rename(const char* ancienNom, const char* nouveauNom);

                        exemple:
                                rename("test.txt", "test_renomme.txt");
                                
		________________
                $remove : supprimer un fichier

                        int remove(const char* fichierASupprimer);

                        exemple:
                                remove("test.txt");

		________________
                Compter le nombre de ligne d'un fichier

                        il suffit de compter le nombre \n

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Allocation dynamique
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        L'allocation dynamique permet de demander de l'espace mémoire à la volée.

        -------------------------
        Taille des variables
        -------------------------
                On peut représenter la mémoire par un tableau d'adressage ou à chaque N° correspond un octet.
                        
                        Par exemple si on stocke un int de 4 octet en mémoire à l'adresse 1200, il occupera l'espace émmoire de 1200 à 1203 compris.
		________________
                sizeof(TYPE) : permet de demander la taille qu'occupe un type de variable en mémoire. (en octet)

                        exemple:
                                printf("int : %d octets\n", sizeof(int));

                        Note: Cela fonctionne aussi avec les structures

        -------------------------
        Allouer de la mémoire
        -------------------------
                #include <stdlib.h>
		________________
                malloc : demander d'allocation de mémoire. (memory allocation)

                        void* malloc(size_t nombreOctetsNecessaires);

                        Malloc renvoie un pointeur 'vide', c'est à dire sur n'importe quel type de variable.
                        Si l'allocation a échouée, le pointeur contient l'adresse NULL.

                        exemple:

                                int* memoireAllouee = NULL; //pointeur sur int.
                                memoireAllouee = malloc(sizeof(int)); //inscrit l'adresse réservée.

                                if (memoireAllouee == NULL) // Si l'allocation a échoué
                                {
                                        exit(0); // On arrête le programme
                                }

                        L'allocation dynamique d'un tableau:
                        ``````````````
                                Pour rappel, on ne peut pas déclarer un tableau avec comme taille un nom de variable. (Dû moins cela n'est pas conseillée même si cela fonctionne sur certain compilateur).

                                Pour réaliser cette manipulation, on alloue la mémoire en fonctin du multiple de nombre de case par la taille du type de variable souhaitée:

                                        MonTableau = malloc(nombreCase * sizeof(TYPE)); 

                                exemple, si on veut créer un tableau d'int:

                                        int nombreCases = 0;
                                        int* Tableau = NULL;

                                        print("Nombre de case du tableau ? ");
                                        scanf("%d", &nombreCases);

                                        if (nombreCases > 0 )
                                        {
                                                Tableau = malloc(nombreCases * sizeof(int));

                                                if ( Tableau == NULL )
                                                {
                                                        exit (0);
                                                }

                                                ...

                                                free(Tableau);
                                        }
		________________
                free: libérer de la mémoire.

                        void free(void* pointeur);

                        Après avoir éxécuté un malloc, il faut penser à libérer la mémoire lorsqu'on n'a plus besoin de notre variable.

                        exemple:
                                free(monPointeur);


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Traitement d'erreur
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        buffer overflow : dépassement de mémoire d'une variable.
