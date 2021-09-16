========================================
		J A V A
========================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it ? 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Un langage orienté objet regroupant plusieurs technos/environement:
        
		Une plateforme d'éxécution (JRE)    Java Runtime Environment
		Une plateforme de dev (JDK)	Java Development Kit  (il inclut le JRE), nécessaire si l'on ne passe pas par un IDE par exemple.
		Des greffons pour l'éxécution sur des programmes tel que des browser

	Java s'appuie sur une machine virtuelle (JVM [son coeur])pour compiler (byte code) et interpréter le code java.
	Il est réputé pour soin interoperabilité.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	http://doc.ubuntu-fr.org/java

	-------------------------
	Versions libres
	-------------------------
		_________________	
		Install des packages
			
			apt-get install openjdk-7-jre openjdk-7-jdk icedtea-7-plugin
			
			
		2) export PATH
		3) compilation avec javac
		4) execution avec java

	-------------------------
	Version Fermée
	-------------------------
	-------------------------
	IDE
	-------------------------

		Voir eclipse

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Commandes usuelles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	-------------------------
	Version
	-------------------------
		java -version (jre)
		javac -version (jdk)

	-------------------------
	Updates
	-------------------------
	
	-------------------------
	Intérprétation
	-------------------------
		_________________	
		fichier jar:

			Un fichier .jar:
				java -jar file.jar
		_________________	
		Via un fichier:
			
			> javac fichierSource.java
			> java byteCode (ou java MaClass)
		_________________	
		Via la classe principale:

			> java MainClass

		_________________	
		via un make :
			> make && make run

				all:
					javac PATH_TO_SOURCE
					jar -cfe PATH_JAR_OUTPUT MAIN_CLASS FICHIERS_INPUT
				run:
					java -jar FICHIER_JAR
		
	-------------------------
	Exporter en jar
	-------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Code minimal
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Java est un langage orienté objet, Les instructions sont à placer à l'intèrieur d'une classe:

	-------------------------
	La classe main
	-------------------------

		Il faut au minimum une classe composée d'une méthode main:
	
		Exemple:
		
		>	public class Class_name {
		>		public static void main(String[] args) {
		>			//Instructions
		>		}
		>	}

		On créera ensuite notre byte code de notre classe pour l'interpréter avec java:
			
		> javac fichier.java
		> java Class_name

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les commentaires
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	//commentaire
	/* commentaire */

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Variable:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	-------------------------
	Types:
	-------------------------

		2 types de variables:
			Type simple (primitif)
			Type complexe (objet)

	-------------------------
	Déclaration
	-------------------------
	
		monType maVariable1, ... ;

	-------------------------
	Numériques
	-------------------------
		_________________	
		déclaration

	-------------------------
	Booléens
	-------------------------

	-------------------------
	caractères
	-------------------------

	-------------------------
	Déclaration:
	-------------------------

		On peut déclarer plusieurs variables de même type sur une seule ligne:

			int variable1, variable2, ...;

		_________________	
		numérique:

			byte variable; //entre -127 et +128
			short variable; //entre -32768 et +32767 
			int variable; //entre -2*10^9 et 2*10^9
			long variable; //entre -9*10^18 et 9*10^18

		       	--> variable = X;

			float variable; //nombre à virgule

		       	--> variable = X.Yf;

		       	(Le nombre doit finir par un 'f')

			double variable;

				--> variable = X.Y;

				Idem que float mais peut comporter plus de chiffres et n'a pas besoin du 'f'.

		_________________	
		booléen:

		>	boolean variable;
			
				--> variable = true;
				--> variable = false;

		_________________	
		caractères:

		>	char one_char;

				--> one_char = 'L';

		>	String string;
		>	String str = new String();

				--> string = "une phrase";
				--> String string = new String("une phrase");
			
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les opérateurs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Classique
	-------------------------

		-, +, *, /, % ...

		++ : pour incrémenter
		-- : pour décrémenter

		-= : soustraire la partie de droite dans la variable de gauche
		+= : ajoute idem ...
		/= : divise idem ... 

		...

		exemple:

		>	int x, y;

			x = 2;
			y = 3;

			x = y * 3; //6
			x += 1; //7
			x++; //8
			y--; //2

			...

	-------------------------
	Conversion ("cast")
	-------------------------

		_________________	
		numérique à numérique:

			>	type variable;
			>	autre_type autre_variable = (autre_type)variable;

			Convertira la variable dans l'autre type.

			exemple:
			>		int x = 1;
			>		float y = (float)x;
			>		int z = (int)(x / y);
			>
			>		int nbre1 = 2, nbre2 = 4;
			>		double result = (double)(nbre1) / (double)(nbre2);

			IL ne faut pas oublier la notion de priorité: par exemple un double peut contenir un int.	

		_________________	
		numérique à caractère:

			>	int entier = 12;
			>	String chaine = new String();

			>	chaine = chaine.value0f(entier); // la variable chaine contiendra la chaine "12"
			>	int entier2 = Integer.value0f(chaine).intValue(); // la variable entier2 contiendra la valeur 12

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Afficher
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	>	System.out.print("Hello World");

	Avec les caractères d'échappement:

	>	System.out.println("Hello World\n" + variable);

		\n : retour à la ligne
		\r : retour chariot
		\t : tabulation ...

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Importer des packages:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Lorsqu'on souhaite utiliser des classes, il faut importer les "packages" comprenant ces classes:
	Ces lignes sont à placer en début du code (avant la création de la classe)
		
		>	import package.classe;
		
		ou 

		>	importe package.*;

		exemple pour utiliser Scanner:

		>	import java.util.Scanner;

		ou 

		>	import java.util.*;

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Packages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Classes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Lire les saisies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Scanner
	-------------------------

	>	Scanner prompt = new Scanner(System.in);
	>	System.out.println("enter a word :");
	>	String input = prompt.nextLine();
	>	System.out.println("You have entered: + input);
	
		_________________	
		Récupérer la saisie:

		>	Scanner variable = new Scanner(System.in);

		>	int i = variable.nextInt();
		>	double d = variable.nextDouble();
		>	long l = variable.nextLong();
		>	byte b = variable.nextByte();
		>	//...

		Pour ne récupérer qu'un caractère, il faut faire appel à une méthode de String: 
		charAt(N) qui permet de récupérer le Nième - 1 caractère d'une chaine:
		
		>	String input = prompt.nextLine();
		>	char carac = input.charAt(0);

		Attention, seul nextLine() permet de placer le curseur sur une autre ligne.
		Les autres méthode ne le font pas ce qui implique qu'il n'est pas possible de demander plusieurs saisie sans passer par un nextLine:

		>	Scanner sc = new Scanner(System.in);
		>	System.out.println("saisir un entier: ");
		>	int i = sc.nextInt();
		>	System.out.println("Saisir une chaîne: ");
		>		//On place le curseur sur une nouvelle ligne:
		>	sc.nextLine();
		>	String str = sc.nexLine();

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les conditions:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Les opérateurs:
	-------------------------

		== (égal) 
		!= (différent)
		< (infèrieur)
		<= (infèrieur ou égal)
		> (supèrieur)
		>= (supèrieur ou égal)
		&& (ET)
		|| (OU)
		? (ternaire)

		exemple de condition:

		>	if( variable == 2 || variable > 5 && variable < 8)

	-------------------------
	If classique
	-------------------------

		if(//condition)
		{
			//instrucltions;
		}
		else if(//autre condition)
		{
			//instructions;
		}
		else
		{
			//instructions;
		}

	-------------------------
	La structure switch
	-------------------------

		Dans le cas ou il y a beaucoup de conditions

		switch (/*variable*/)
		{
			case /*valeur de la variable*/:
				/*Instruction*/;
				break;
			case /*Autre valeur*/
				/*Instructions*/;
				break;
			default:
				/*Instruction*/;
		}
		
	-------------------------
	Ternaire
	-------------------------

		variable = (/*Condition*/) ? value_si_oui : value_si_non ;

		exemple:

		>	int n = 5, m = 6;
		>	int s = ( n > m ) ? n * 2 : m * 2 ; // s vaut 12

		Note: Il est possible d'insérer une ternaire à l'intèrieur même d'une autre ternaire.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les boucles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	While
	-------------------------

		while (/* Condition */)
		{
			// Instructions
		}

		exemple:

		>	char reponse = 'Y'
		>	while (reponse == 'Y')
		>	{
		>		System.out.println("Continue? (Y/N)");
		>		reponse = sc.nextLine().charAt(0);
		>	}

	-------------------------
	Do While
	-------------------------

		do 
		{
			// Instructions
		}while(/*Condition*/);

		Note: attention au ";" à la fin de la boulce.

	-------------------------
	For
	-------------------------

		for(Variables; Condition; Instruction de fin de boucle)
		{
			//Instructions
		}

		exemples:

			for(int i = x; i <= y; i++)
			{
				System.out.println("Line" +i);
			}

			for(int i = 0, j = 2; (i < 10 && j < 6); i++, j+=2
			{
				System.out.println("i = " + i + ", j = " + j);
			}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les tableaux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Note: le tableau commence toujours à l'indice 0 (classique)

	-------------------------
	déclaration
	-------------------------

		_________________	
		Tableau à une dimension:

			<Type> <Name>[] = {contenu};

				Si on déclare un tableau vide, il faut indiquer le nombre d'éléments:

			<Type> <Name>[] = new <Type>[X_éléments];
			ou
			<Type>[] <Name> = new <Type>[X_éléments];

		_________________	
		Tableau à plusieurs dimensions:

			<Type> <Name>[][] = { {contenu1},{contenu2} };

		_________________	
		Exemple:

			int tableau[] = {0,1,...};
			char tableau[] = {'a','b',...};
			String tableau[] = {"word1", "word2"};
			int tableau[] = new int[8];
			int tableau[] = { {1,2,...},{2,5,...} };


	-------------------------
	Parcourir le tableau
	-------------------------

		System.out.println(tableau[Xième_element]);

		exemple:

		>	String tableau[] = {"bleu", "blanc", "rouge"};
		>	
		>	for(int i = 0; i < tableau.length; i++)
		>	{
		>		System.out.println("L'élément : " + i + " vaut: " + tableau[i]);  
		>	}

		ou pour afficher rapidement les valeurs d'un tableau:

		>	String tableau[] = {"bleu", "blanc", "rouge"};
		>
		>	for(String chaine : tableau)
		>	{
		>		System.out.println(chaine);
		>	}

		Pour les tableaux à plusieurs dimensions, il faut boucler autant de fois qu'il y a de dimensions:

		>	for(int i = 0; i < 2; i++)
		>	{
		>		for(int j = 0; j < last_element; j++)
		>		{
		>			System.out.print(tableau[i][j]);
		>		}
		>	}

	-------------------------
	Rechercher un élément:
	-------------------------

		Exemple:

		Supposons que l'élément recherché se trouve dans la variable "to_find":

		>	while( i < tableau.length && to_find != tableau[i])
		>	{
		>		i++;
		>	}
		>	if(i < tableau.length)
		>	{
		>		System.out.println(" Le mot " +to_find+ "se trouve dans le tableau");
		>	}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les méthodes de classe
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	(méthode = fonction)

	-------------------------
	Méthodes sur chaîne de caractère
	-------------------------

		_________________	
		toLowerCase():

			Transforme une chaîne en minuscule

			>	String chaine = new String("HELLO WOLRD"), chaine_minuscule = new String();
			>	chaine_minuscule = chaine.toLowerCase();

		_________________	
		toUpperCase():

			Idem que précédent ! mais cette fois ci en majuscule

		_________________	
		length():

			Permet de renvoyer la longueur d'une chaine:

			>	String chaine = new String("Hello world");
			>	int longuer = 0;
			>	longueur = chaine.length();
				//--> renvoie 11
		_________________	
		equals():
			Permet de vérifier que 2 chaines soient identique:

			>	if (chaine1.equals(chaine2))
			>		System.out.println("Les deux chaines sont identiques !");


