P Y T H O N
==============================

What is it ?
-----------------------------

Python est un langage de programmation orienté objet haut niveau simple et efficace.
Il utilise une syntaxe particulière légère, basée sur l'indentation pour délimiter les blocs et sur une forme proche du langage courant.
C'est un langage interprété, facile à transporter.
Sa communauté est très active, et le langage dispose de bon nombre de modules déja prêts à l'emploi.

Il a été entrepris en 1989 par Guido van Rossum qui était fan des Monty Python.

Links
-----------------------------

### Official

* [Le site officiel du python](https://www.python.org/)
* [La documentation Python3](https://docs.python.org/3/)
* [Un tuto pour apprendre le Python(3.)](https://docs.python.org/3/tutorial/index.html)
* [La documentation Python2](https://docs.python.org/2/)
* [Sources de Python 3.5.2](https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz)

### Références

* [Le Hitchhiker's Guide](http://docs.python-guide.org/en/latest/)
* [Un wiki bien fourni](https://wiki.python.org)


How it works ?
-----------------------------

### La philosophie

The Zen of Python, by TimPeters :

1. Beautiful is better than ugly.
2. Explicit is better than implicit.
3. Simple is better than complex.
4. Complex is better than complicated.
5. Flat is better than nested.
6. Sparse is better than dense.
7. Readability counts.
8. Special cases aren't special enough to break the rules.
9. Although practicality beats purity.
10. Errors should never pass silently.
11. Unless explicitly silenced.
12. In the face of ambiguity, refuse the temptation to guess.
13. There should be one-- and preferably only one --obvious way to do it.
14. Although that way may not be obvious at first unless you're Dutch.
15. Now is better than never.
16. Although never is often better than right now.
17. If the implementation is hard to explain, it's a bad idea.
18. If the implementation is easy to explain, it may be a good idea.
19. NameSpaces are one honking great idea -- let's do more of those!

### L'interpréteur

Il est écrit en C et embarque beaucoup de modules intégrés.
Voir les sources du code Python pour plus de détails.

Il dispose d'un mode interactif permettant d'executer du code python à la volée.

### Les versions

Python utilise la version 3.X qui n'est pas ascendante avec les versions précedentes 2.X car elle vise à corriger et à purger l'ancienne version.
Python2.7 reste tout de même encore très actif notament grâce à ses modules qui ne sont pas encore tous retraduit en version 3
La suite du mémo s'appuie principalement sur python 3.2


### La librairie Standard

La librairie contient des modules intégrés écrit en C pour accéder aux fonctionnalités du système (I/O ...),
ainsi que des modules écrit en python pour ajouter des solutions utilisables au quotidien.

### La syntax, le coeur de la sémantique

### L'API Python/C

Cette API permet d'étendre les fonctionnalités intégrées à Python en C ou C++.


Installation
-----------------------------


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Installer Python
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Voir si il n'est pas déja présent:

        > dpkg -l python3

        Pour installer python 3, il suffit de télécharger l'interpréteur et les librairies:

        Manuellement en téléchargeant et compilant les sources:

        > wget http://python.org/ftp/python/3.2.5/Python-3.2.5.tar.bz2

                Décompréssez et regardez le readme pour bien compiler.

                > tar -jxvf Python-3.2.5.tgz
                > ./configure
                > make && make altinstall

        Automatiquement

        > apt-get install python

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interpréter du code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Via l'interpréteur
	-------------------------
                On peut le faire directement via l'interpréteur:

                > python3
                
                __________________________
                Importer un script directement dans l'interpréteur:

                        >>> exec(open(FileName).read())
                
	-------------------------
	En console
	-------------------------

                Ou sur un fichier executable (chmod +x):
                        
                        Il faut renseigner le shebang et le type d'encodage

                > vim script.py

                        le shebang:

                                #!/path/vers/mon/interpreteur

                                exemple:

                                        #!/usr/bin/python3.2
                                        ou
                                        #!/usr/bin/env python3.2

                        l'encodage

                                # -*- coding: encoding -*-

                                exemple:
                                        # -*- coding: utf8 -*-

	-------------------------
	Dans son code même
	-------------------------
                __________________________
                eval:

                        https://docs.python.org/3.2/library/functions.html#eval
                        eval permet d'évaluer une expression 

                        exemple:

                                var= eval(monCode)
                                var= eval('%d + 20' % var2)
                __________________________
                exec:
                        https://docs.python.org/3.4/library/functions.html#exec
                        exec agit comme une déclaration:

                        exemples:

                                exec 'monCode'

                __________________________
                compile:
                        https://docs.python.org/3.4/library/functions.html#compile

                        Permet de retourner un objet qui peut éxécuter du code

                        exemple:

                                compile(string, '', 'eval')  #retourne eval(string)
                                compile(string, '', 'exec')  #retourne exec(string)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Help
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Pour afficher de l'aide sur un module, une fonction ...

        >>> help("Commande")

	-------------------------
        PEP (Perl Enhancement Proposals)
	-------------------------

                Les conventions de codages usuels.
                   
                http://legacy.python.org/dev/peps/pep-0020/
       
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Commentaires
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        #mon commentaire
        """ Mon commentaire sur plusieurs lignes"""

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
POO
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        La force de python réside dans ce concept.

        Chacune de nos variables sont des objets. On peut donc les manipuler directement comme telles.

        Pour rappel un objet(=~ variable) peut s'assimiler à une instance d'une classe (=~module), ayant accès à ses méthodes (=~ fonctions).

	-------------------------
	Méthodes
	-------------------------
                Pour appliquer une méthode à un objet, on le fait comme avec en manipulant les modules (voir section module).

                monObjet.maMethode

                On peut cumuler les méthodes:

                        monObjet.maMethode1.maMethode2

                        La methode2 s'appliquera au résulatat de la méthode1 sur mon Objet.

                exemple:

                        chaine="  HELLO  "
                        chaine.lower().strip()  #Affiche la chaine en minuscule et on retire les espaces des extrémités.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Les objets et variables
~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	types (= classe)
	-------------------------

                Le python est typé de façon automatique en fonction du contexte.
                Il est cependant possible de vérifier le type d'une variable et de le modifier.
                En python on parle plutôt de classe
		________________
		type() : vérifier le type d'une variable

                        exemple:

                                type(ma_variable)

		________________
        typer une variable

                Syntaxe:

                        MON_TYPE()

                exemple:
                        int() : pour typer en entier

	-------------------------
	Portée
	-------------------------
		________________
        locale:

            Par défaut les variables sont déclarées localement.
            Cependant en python il est possible de lire les variables du bloc parent.
            (Uniquement en lecture et pas en écriture !)
            On peut donc accéder naturelement aux valeurs des variables d'un bloc inférieur

		________________
        globale:

            Pour modifier la valeur d'une variable extérieur à un bloc
            il faut déclarer ses variables dans le bloc concerné avec le mot clé 'global':

                    global var1, var2, ...

            exemple:

                    i = 0
                    def inc_i():
                            global i
                            i += 1
                    
                    inc_i()
                    i       #Affichera la valeur incrémentée de i
                                        
        --------------------------
        Règles de déclaration
        --------------------------
                __________________________
                Sur une ligne:
                        
                    variable = nombre
                    variable = "chaine"

                __________________________
                Sur plusieurs lignes:
                        
                    il faut utiliser le caractère d'échapement \ en fin de ligne

                    variable = param1 \
                    param2 ...

                __________________________
                Egalité de variable:

                    ma_variable = ma_variable
                    
                    On peut le faire pour plusieur variable:

                            a = b = c

                __________________________
                Formater:

                    Voir aussi format dans la section affichage.

                    http://www.informit.com/articles/article.aspx?p=28790&seqNum=2

                    On peut aussi utiliser l'opérateur % pour interpoler des données:
                    Chaque %X sera remplacé par la chaine trouvée.
                    On fait appel à une variable en écrvant: % maVariableAInterpoler

                        Sur tuple et chaines
                        ``````````````````````````
                            On remplace les %X par les chaine trouvée dans un tuple:

                            exemple:

                                    format = "%s est agé de %s ans"
                                    people = ('Jean', 30)
                                    print( format % people )

                            ou encore: 

                                    people = ('Jean', 30)
                                    format = "%s est agé de %s" % people
                                    print (format)

                        Sur dictionnaire
                        ``````````````````````````
                            todo
                        
                        Les directives de format
                        ``````````````````````````

                            %s : une chaine
                            %i : un entier
                            %d : un decimal
                            %x : un hexadecimal
                            %o : un octal
                            %u : un entier non signé ?
                            %e : un exposant
                            %f : un flottant
                            %g : idem?
                            %c : un caractère ASCII

                        Les flags de format
                        ``````````````````````````

                            Ils se placent après el signe % et permetent de changer l'interprétation:

                            exemple:

                                    "%#x" % 0xff

                            les flags:

                            # : force le préfix 0x pour les valeur hexa
                            + : force une valeur positive
                            -X : avec X la justification à gauche
                            " " : à voir ^^
                            0X : Avec X la taille du mot. on remplira avec des 0 (vers la gauche) si la taille est trop petite.


        --------------------------
        Les nombres
        --------------------------
                __________________________
                Entiers:

                        Type
                        ``````````````````````````
                                int()

                        Déclaration
                        ``````````````````````````
                                variable = int()    #initialisation
                                variable = 0        #initialisation
                                variable = int(x)
                                variable = x    

                __________________________
                Flottants:

                        Type
                        ``````````````````````````
                                float()

                        Déclaration
                        ``````````````````````````
                                variable = float()  #initialisation
                                variable = 0.0      #initialisation
                                variable = float(x)
                                variable = x.y  

                __________________________
                Opérateurs:

                        Calculs
                        ``````````````````````````
                                () : regrouper une expression
                                + - * / ... : addition, soustraction ...
                                % : modulo (reste)
                                // : donner le nombre entier d'une division
                                ** : exposant

                        Incrémenter/raccourcis
                        ``````````````````````````
                                i += 1
                                i *= 2
                                ...
                __________________________
                Mathématiques

                        Modules de mathématiques
                        ``````````````````````````
                                import math             #accéder aux fonctions mathématiques
                                import random           #générer des nombres aléatoires
                                import fractions        #modéliser des fractions

                        Méthodes de math
                        ``````````````````````````
                                math.pow(CHIFFRE, EXPOSANT)     #puissance
                                math.sqrt(CHIFFRE)              #racine carré
                                math.exp(CHIFFRE)               #exponentielle
                                math.fabs(-CHIFFRE)             #Valeur absolu

                                Trigo:
                                        math.degrees(angle_radians)     #convertir en degrés
                                        math.radians(angle_degres)     #convertir en radians
                                        math.cos()                        #cosinus
                                        math.sin()                        #sinus
                                        math.tan()                        #tangente
                                        math.acos()                        #arc cosinus
                                        math.asin()                        #arc sinus
                                        math.atan()                        #arc tangente

                                Arrondi

                                        math.ceil(chiffre)      #Arrondir au dessus
                                        math.floor(CHIFFRE)     #Arrondir en dessous
                                        math.trunc(X.Y)         #garde la partie entière X

                        Fractions
                        ``````````````````````````
                                Permet d'avoir un résultat sous forme de fraction

                                from fractions import Fraction

                                Fraction(NUMERATEUR, DENOMINATEUR)
                                ou
                                Fraction('NUMERATEUR/DENOMINATEUR')

                                Fraction.from_float(FLOTTANT)   #Créer une fraction à partir d'un flottant

                                
                        Nombres aléatoires
                        ``````````````````````````

                                random.random()         #Générer un nombre aléatoire

                                Via un range:
                                        random.randrange(DEBUT, FIN_NON_INCLUSE, INTERVALLE)
                                        random.randrange(X)     #renvoie un nombre aléatoire entre 0 et X
                                        random.randrange(X, Y)  #renvoie un nombre aléatoire entre X et Y

                                        random.randint(DEBUT, FIN_INCLUSE)


        --------------------------
	Les caractères
        --------------------------

                        variable = str()                        #Créer une chaine vide (-> variable = "")
                        variable = "chaine"                     #type str
                        variable = 'Sitation: \"Hello\"'        #échappement: \
                        variable = "chaine\nautre\nligne"
                        variable = """chaine"""                 #Sans échappement

                        sur plusieurs lignes
                        ``````````````

                                variable = "blablabla \
                                suite blabla"

                                Sans échappement de guillement et apostrophes:

                                        variable = """PLusieurs 
                                        lignes
                                        blabla"""
                __________________________
                Chaînes:

                        Type
                        ``````````````````````````
                                str()

                        Déclaration
                        ``````````````````````````
                                variable = str()        #initialisation
                                variable = ""
                                variable = ''

                                variable = """chaine formatée"""      #Ne nécessite pas d'échappement (pratique pour le muli-lignes)

                        Caractères spéciaux
                        ``````````````````````````
                                \ : échappement
                                \n : retour à la ligne
                                
                        Parcourir
                        ``````````````````````````

                                Les chaines sont semblables aux listes:
                                (=~ des listes de caractères)
                                
                                chaine[0] : premier caractère
                                chaine[-1] : dernier caractère

                                while i < len(chaine):
                                        print(chaine[i])
                                        i += 1
                                
                        Sélectionner
                        ``````````````````````````
                                Il est possible de sélectionner une partie de la chaine:
                                
                                maChaine[x:y] : Avec x le premier caractère selectionné jusqu'a y-1 compris
                                maChaine[:y] : du premier caractère au yième-1 compris
                                maChaine[x:] : à partir du xième caractère jusqu'a la fin de la chaine
                                
                        Encoder une chaine, typer une chaine
                        ``````````````````````````
                                b'ma_chaine'   #pour encoder en binaire
                                        = maChaine.encode()

                                        --> maChaine.decode() pour l'inverse

                                r'ma_chaine'   #Pour saisir une regex

                __________________________
                Opérations/méthodes:

                        Note: Les méthodes de chaînes ne modifies par directement leur contenu.

                        Assembler/concaténer des chaînes
                        ``````````````````````````
                                variable = mot1 + mot2          #sans espace
                                variable = mot1 + " " + mot2     #avec un espace

                        chaine.lower()  : mettre en minuscule
                        ``````````````````````````
                        chaine.upper()  : mettre en majuscule
                        ``````````````````````````
                        chaine.strip()  : retirer les espaces de début et de fin
                        ``````````````````````````
                        chaine.center(x)  : centrer sur une longueur de x caractères
                        ``````````````````````````
                        chaine.capitalize  : mettre la première lettre en majuscule
                        ``````````````````````````
                        len(chaine) : donner la taille d'une chaine
                        ``````````````````````````
                        transformer une chaine en liste
                        ``````````````````````````
                                Avec split: chaine.split("Caractère de séparation")

                                exemple:
                                        chaine.split(".")
                                        chaine.split("\n")

                                Si on transforme directement un mot en une liste de cractère:

                                        list(maChaine)

                __________________________
                Chiffrer/hasher une chaine:

                        import hashlib

                        Afficher les méthodes de hash
                        ``````````````````````````
                                hashlib.algotithms_guaranteed   #Afficher les méthodes de hash guaranties
                                hashlib.algotithms_available   #Afficher les méthodes de hash disponibles

                        Appliquer un hash
                        ``````````````````````````
                                monHash = hashlib.METHODE(b"maChaine")

                                Avec une variable on l'encodera en binaire au préalable:
                                        maChaine.encode()

                        Afficher un hash
                        ``````````````````````````
                                monHash.digest()        #afficher sous forme octale
                                monHash.hexdigest()     #afficher sous forme hexadécimal

                        Tester un hash
                        ``````````````````````````
                                On ne déchiffre pas directement une chaine, cependant on peut vérifier que 2 hash correspondent.
                                exemple:

                                        if hashlib.sha1(password).hexdigest() = hashlib.sha1(basePassword).hexdigest()
                                                print('Nice !')

	-------------------------
	Les Booléens
	-------------------------
                __________________________
                Type
                        bool()
                __________________________
                Déclaration

                        variable = bool()       #initialiser un booléen (False)
                        variable = True         #vrai
                        variable = False        #Faut

	-------------------------
	Les tuples
	-------------------------

                Les tuples sont identiques aux listes dans leurs forme.
                Mais ils ne peuvent pas être directement modifiés.
                On les utilise beaucoup implicitement

                __________________________
                Type
                        tuple()
                __________________________
                Déclaration

                        initTuple = tuple()
                        initTuple = ()
                        monTuple = (x,)
                        monTuple = x,
                        monTuple = (x, y, z)
                        monTuple = x, y, z

	-------------------------
	Les listes
	-------------------------
                Note: Les listes et les chaines sont relativement semblables. certaines fonctions sont donc utilisable pour les deux types.
                __________________________
                Type
                        list()
                __________________________
                Déclaration

                        variable = list()       #init
                        variable = []           #init
                        variable = list[ nbre, 'chaine', ... ]

                        Copier le contenu d'une liste:
                        ``````````````````````````
                                liste2 = list(liste1)

                        Référence vers une liste:
                        ``````````````````````````

                                liste2 = liste1
                        
                __________________________
                Parcourir
                        
                        Les listes ne sont pas commes les chaines, on peut modifier directement la valeur d'un élément.

                        maListe[0]      #Accès au premier élement de la liste
                        maListe[-1]     #Accès au dernier élement

                        Avec un for classique:
                        ``````````````````````````
                                for element in maListe:
                                        print(element)


                        Pour récupérer en plus l'indice, on utilise enumerate
                        ``````````````````````````

                                for indice, element in enumerate(maListe):
                                        print("indice: {} ; value: {}".format(indice, element))

                                Note: enumerate renvoie deux valeurs dans un tuple.
                                Cela revient au même que de mettre une liste de deux élement dans une liste:
                                        
                                        monEnumerate = [
                                                [indice, 'value'],
                                                [indice1, 'value1'],
                                                ... 
                                        ]

                        Compréhensions de liste (Filtrage)
                        ``````````````````````````

                                Cela permet de filtrer le contenu d'une liste pour en créer une nouvelle.

                                [VALEUR_RETOUR for variable in maListe]

                                exemple:
                                        maListe = [0, 1, 2, 3]
                                        [nb * nb for nb in maListe]

                                On peut y ajouter une condition:

                                        [VALEUR_RETOUR for variable in maListe if CONDITION]

                                        exemple:
                                                maListe = [0, 1, 2, 3]
                                                [nb * nb for nb in maListe if nb%2==0]

                __________________________
                Sélectionner

                        Tout comme les chaine, on peut selectionner une partie du contenu d'une liste
                        
                        maListe[x:y] : Avec x le premier élement selectionné jusqu'a y - 1 compris
                        maListe[:y] : du premier élement au yième-1 élement compris
                        maListe[x:] : à partir du xième élement jusqu'a la fin de la liste

                __________________________
                Fonctions/méthodes

                        len(): Connaitre le nombre d'élement d'une liste:
                        ``````````````````````````

                            Tout comme les chaînes:

                                len(maListe)

                        pop(): Récuperer et supprimer une valeur:
                        ``````````````````````````

                            maListe.pop(X) 
                                Avec X l'indide du tableau à récupérer.

                            Dérivés:

                                popleft() : récupérer l'élement le plus à gauche
                                popright() : l'élement le plus à droite.

                        
                        Ajouter un objet à la fin d'une liste
                        ``````````````````````````
                            maListe.append(Mon_element)

                        Insérer un objet dans une liste
                        ``````````````````````````
                            maListe.insert(n°indice, élément)

                        Ajouter une liste à la fin d'un autre liste
                        ``````````````````````````
                            maListe.extend(maListe2)

                            ou 

                            maListe += maListe2

                        Supprimer un élément d'une liste
                        ``````````````````````````
                            del maListe[x] # avec x l'indice de la liste
                            ma_liste.remove(value)  #retire la première valeur trouvée

                        "caractère de séparation".join(maListe) : transformer une liste en chaine.
                        ``````````````````````````
                            exemple:

                                    ",".join([case1, case2[:5]])

                        maListe.sort(paramètres) : trier une liste
                        ``````````````````````````
                            Paramètre reverse=True ou False pour indiquer le sens de trie.
                            (par défaut : False)

                            exemple:

                                    maListe.sort()
                                    maListe.sort(reverse=True)

                                    (Modifie la liste)
                                
                        sorted(maListe, PARAMETRES) : trier une liste
                        ``````````````````````````

                        index: connaitre l'indice d'un élément:
                        ``````````````````````````

                            maListe.index('element')


                        Séquences aléatoires
                        ``````````````````````````
                            import random

                            random.choice(['a', 'b', 'c'])  #choisira un caractère aléatoirement
                            random.shuffle(liste)           #Mélangera les caractères de liste

                                        
                        zip(): Transposer:
                        ``````````````````````````
                            zip(*maListe)


                        max() et min (): Récuperer une valeur max ou min d'une liste:
                        ``````````````````````````

                            Utilisation basique:

                                max(myList)

                            Connaitre l'indice du min::

                                myList.index(min(myList))

	-------------------------
	Les Dictionnaires
	-------------------------

                On peut les comparer aux hash de perl ou les structures en C.
                Attention à ne pas les confondre ave les listes, les structures ne sont pas ordonnées.
                Il permettent de stocker plusieurs types de variables dans une même structure.

                __________________________
                Type
                        dict()
                __________________________
                Déclaration

                        dico = dict()       #init
                        dico = {}           #init
                        dico["key"] = "value"
                        dico[INDICE] = "value" #avec par exemple l'INDICE un numéro entier.
                        dico[INDICE1, INDICE2] = "value"
                                
                                exemple:
                                        echiquier['a', 2] = "pion blanc"

                                        Note l'indice est un tuple, on aurait pu écrire echiquier[('a', 2)]

                        dico = {"Key":value, Key2:"value2"}
                        dico["key"] = function

                                exemple:
                                        fonction["afficher"] = print


                        un dico de dico:


                                >>> dico = {'section1': {'key1': 'value1',
                                                        'key2': 'value2',
                                                        'key3': 'value3'},
                                           'section2': {'keyA': 'valueA',
                                                        'keyB': 'valueB',
                                                        'keyC': 'valueC'},
                                           'section3': {'foo': 'x',
                                                        'bar': 'y',
                                                        'baz': 'z'}
                                 }

                __________________________
                Parcourir

                        dico['key'] : accéder à la valeur de key

                        dico[key1] = value1    : accéder/modifier une valeur du dico au niveau de key1.
                                                Créera automatiquement une clé si elle n'existe pas.

                        dico[section][key1] = value1    : idem mais avec un sous-dico.
                                                Ne créera une sous clé que si la clé parente existe déja.

                        Les clés .keys()
                        ``````````````````````````
                                for key in dico.keys():
                                        print(key)

                                Note: la méthode keys n'est pas obligatoire mais conseillée pour les dicos.

                        Les valeurs .values()
                        ``````````````````````````
                                for value in dico.values():
                                        print(value)

                                S'utilise très bien avec des conditions:

                                        if banane in dico.values():
                                                print("Youpi!")

                        Clés et valeurs .items() ou iteritems()
                        ``````````````````````````
                                for key, value in dico.iteritems():
                                        print("Key: {}, value: {} ;".format(key, value))
                                        
                __________________________
                Fonctions/méthodes:

                        keys : obtenir la liste des clés
                        ``````````````````````````
                            >>> dico.keys()

                        values : obtenir la liste des valeurs
                        ``````````````````````````
                            >>> dico.values()

                        len : obtenir le nombre de clés
                        ``````````````````````````
                            >>> len(dico)

                        clear : Vider un dictionnaire
                        ``````````````````````````

                            >>> dico.clear()

                        del : supprimer une clé d'un dictionnaire
                        ``````````````````````````
                            >>> del dico["key"]

                        .pop : supprimer une clé plus renvoie de la valeur supprimée
                        ``````````````````````````
                            >>> dico.pop("key")
                __________________________
                Tests :

                        Tester si une clé existe :
                        ``````````````````````````
                            if 'key' in dico :
                                ...

	-------------------------
	Les Références
	-------------------------

                Les références sont semblables aux pointeurs en C.
                Elles représentent les adresses mémoires des objets.
                En python, les variables sont en fait des références vers objets.

                __________________________
                Déclaration

                        monObjet = monObjet2

                __________________________
                Manipulations

                        On peut modifier directement le contenu d'une références grâces aux méthodes qui modifient directement les objets.

                        exemple:

                                liste1 = [1]
                                liste2 = liste1
                                liste2.append(4)

                                Le contenu de liste1 et liste2 sera bien [1, 4]
                __________________________
                Copier des objets, module copy

                    https://docs.python.org/2/library/copy.html

                    Pour éviter de référencer des objets, et ne copier que leurs contenu, ont peut utiliser le module copy :

                        Importer le module :
                        ``````````````````````````
                            import copy

                        Copier un objet et lier son contenu (reference) :
                        ``````````````````````````

                            objectB = copy.copy(objectA)

                        Copier les valeurs d'un object sans lier son contenu (unreference) :
                        ``````````````````````````

                            objectB = copy.deepcopy(objectA)

                __________________________
                Les réferences et les fonctions

                    http://www.tutorialspoint.com/python/python_functions.htm

                        Des paramètres référencés :
                        ``````````````````````````

                            Lorsqu'on envoie un objet à une fonction, on envoi sa réference :
                            Du coup il n'est pas obligatoire de mettre une égalité devant l'appel de la fonction pour récupérer les nouvelles valeurs de l'objet :

                                au lieu de :

                                    new_variable = changeme(new_variable)

                                On peut écrire directement :

                                    changeme(new_variable)
                                    

                            Exemple :

                                def changeme( mylist ):
                                    "This changes a passed list into this function"
                                    mylist.append([1,2,3,4]);
                                    print "Values inside the function: ", mylist
                                    return

                                # Now you can call changeme function
                                mylist = [10,20,30];
                                changeme( mylist );
                                print "Values outside the function: ", mylist

                        Des paramètres non-référencés :
                        ``````````````````````````

                            Si l'on veut manipuler un paramètre non référencé dans notre fonction,
                            on le déréférence en y assignant un nouveau contenu :
                            (peut du coup s'utiliser avec le module copy)

                            Exemple :

                                def changeme( mylist ):
                                    "This changes a passed list into this function"
                                    mylist = [1,2,3,4]; # This would assig new reference in mylist
                                    print "Values inside the function: ", mylist
                                    return

                                # Now you can call changeme function
                                mylist = [10,20,30];
                                changeme( mylist );
                                print "Values outside the function: ", mylist

	-------------------------
	Les set
	-------------------------

                Les set se manipulent comme des listes mais contiennent des objets uniques (pas de doublons)
                __________________________
                Type
                        set()


        --------------------------
	Opérations
        --------------------------
		________________
                Affectation multiple:

                        a, b = valueA, valueB
		________________
                permuter deux variables:

                        a,b = b,a
		________________
                Supprimer une variable:

                        del variable

                        un attribut:
                            delattr(object, 'attr_name')

		________________
                Tester l'existence d'une variable:

                    if 'variable' in locals():

                    #ou encore

                    if 'variable' in globals():

                    (pour les attributs d'un objet, voir hasattr)


~~~~~~~~~~~~~~~~~~~~~~~~~~
Affichage
~~~~~~~~~~~~~~~~~~~~~~~~~~

        variable        # affiche directement son contenu (uniquement au niveau de l"interpréteur)
        ________________
        print() : permet de formater l'affichage d'une variable

                print(*values, sep=' ', end='\n', file=sys.stdout)

                print(variable)
                print("a vaut", a, "b vaut", b)

        __________________________
        format : pour étendre le formatage de l'affichage.

                syntaxe:

                        "Ma chaine".format(mes variables)

                Avec indice:
                ``````````````````````````
                
                        "{indice0} {indice1}".format(variable1, variable2)

                        exemple:

                                nom=michou
                                prenom=jean

                                affichage = "Je m'appelle {0} {1}"
                                affichage.format(nom, prenom)
                
                Sans indice:
                ``````````````````````````
                        On affiche les variables dans l'ordre

                        "{} {}".format(variable1, variable2)

                        exemple:
                                
                                print("Je m'appelle {} {}".format(nom, prenom))

                Indices nommés
                ``````````````````````````

                        "{alias1} {alias2}".format(alias1=value1, alias2=value2)

                        exemple:

                                adresse = """ {rue} 
                                              {CP}
                                              {ville} """
                                
                                display = adresse.format(rue='10 rue jean moulin', CP='75018', ville='Paris')
                                print(diplay)

~~~~~~~~~~~~~~~~~~~~~~~~~~
Saisie
~~~~~~~~~~~~~~~~~~~~~~~~~~
        ________________
        input() : saisir une variable (récupère une chaine, type str)

                exemple:
                        variable = input("Rentrezi quelquechose: ")

                Attention au type de la variable !
                Par exemple si on veut récupérer un entier:

                        entier = int(input("Rentrezi un entier: "))

        ________________
        getpass() : saisir un mot de passe

                from getpass import getpass

                password = getpass("Entrez votre mot de passe: ")


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Conditions / Tests
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Renvoient True ou False.

	-------------------------
	Les opérateurs
	-------------------------
		________________
                Comparer:

                        <       : inférieur
                        >       : sup
                        <=      : inf ou égal
                        >=      : sup ou égal
                        ==      : égal
                        !=      : différent

		________________
                Etendre les conditions

                        () : regrouper des prédicats
                        and
                        or
                        not
                        is : teste l'égalité des références (fonctionne avec les booléens)
                        in : permet de vérifier si un élement est inclu dans une liste
		________________
                Passer une instruction:

                        De part sa conception, il est nécessaire d'écrire du code après une ligne suivi de ':' définissant un bloc d'instruction.
                        Il est possible de ne rien exécuter grâce à la commande 'pass'

                                pass # ne rien faire

	-------------------------
	Tester un prédicat (= condition)
	-------------------------

                prédicat
                #affichage du résultat

                exemple:
                        >>> a = 0
                        >>> a == 5
                        False

                        >>> a > -5
                        True

                exemple avec in:

                        >>> lettre = 'b'
                        >>> lettre in "AUOiou"
                        False

                        >>> lettre in "BbjJ"
                        True

	-------------------------
	Blocs
	-------------------------
                On les définit grâce aux ':' puis on indente l'instruction suivante.
		________________
                if:

                        if CONDITION:
                                INSTRUCTION
                        elif CONDITION2:
                                INSTRUCTION2
                        else:
                                INSTRUCTION3

                        exemple:

                                if a>=5 and a!=10:
                                        print("ok")
                                else:
                                        print("nok")

                                #avec un booléen:

                                if variable is not True:
                                        print("quelque chose")

	-------------------------
	Tests de variable
	-------------------------

        Vérifier l'existence d'une variable, d'une liste ...:

            if maVariable:
                ...
            elif not maVariable:
                ...

        Pour une liste on peut vérifier que le nombre d'élement est > 0

            if len(maListe) > 0:
                ...
            elif len(maListe) == 0:
                ...

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les regex - expressions régulières
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Mettre en place des regex
	-------------------------
                
                __________________________
                Module:

                        >>> import re

                __________________________
                Syntaxe:

                        On peut écrire simplement une regex en échapant les caractères spéciaux.
                        Toutefois pour simplifier et par lisibilité on peut utiliser r'MaRegex' pour éviter les échappements.

                        >>> r'MaRegex' 

                        exemple:
                                
                                regex = r"^[A-Za-z0-9]{7,}$"
                __________________________
                Groupes

                        Numérotés
                        ``````````````````````````

                                Chaque groupe d'expression correspond à \NUM avec NUM le numéro du groupe

                                exemple:

                                       regex = "(a)b(cd)"

                                       a -> \1
                                       cd -> \2

                        Nommés
                        ``````````````````````````

                                Pour nommer un groupe d'une regex, on utilise la syntaxe suivante:

                                        (?P<NOM_GROUPE>REGEX)

                                Pour utiliser en suite le groupe:

                                        \g<NOM_GROUPE>

                                exemple:

                                        texte = """
                                                nom='task1', id=12
                                                nom='task2', id=13"""

                                        print(re.sub(r"id=(?P<id>[0-9]+)", r"id[\g<id>]", texte))


	-------------------------
	Les méthodes/fonctions de regex
	-------------------------

                __________________________
                search: rechercher une chaine:

                        >>> re.search(r"REGEX", "CHAINE")

                                Renvoie 'None' si rien de trouver
                                Renvoie l'objet correspondant à la regex recherchée

                                afficher le résultat:

                                    foo = re.search(r'.*', 'hello')
                                    print( foo.[foo.start():foo.end()] )
                                    #ou encore
                                    print( foo.group(0) )

                __________________________
                match: Appliquer une regex

                        >>> re.match(REGEX, CHAINE)

                        exemple:
                                
                                if re.match(regex, chaine):
                                        #si il y a correspondance
                __________________________
                sub: Substituer du texte

                        >>> re.sub(ORIGINE, REMPLACEMENT, CHAINE) 

                                Renvoie la chaine modifiée.

                __________________________
                compile: compiler une regex

                        >>> re.compil(REGEX)

                                Permet de gagner du temps d'éxécution lorsqu'on appel souvent une regex

                        exemple:

                                regexUpper = r"^[A-Z]$"
                                upperR = re.compile(regexUpper)
                                inputUpper = ""

                                while upperR.search(inputUpper) is None:
                                        inputUpper = input("Entrer une majuscule : ")
                                

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Boucles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	-------------------------
	Types de boucles
	-------------------------
		________________
                Le while


                        while CONDITION:
                                INTRUCTIONS

                        exemple:
                                
                                while i != 10:
                                        print("yoyo")
                                        i+=1
		________________
                Le for (= foreach)
        

                        for ELEMENT in SEQUENCE:
                                INSTRUCTIONS

                        exemple:      

                                chaine = "du texte"
                                for lettre in chaine:
                                        print(lettre)

                        on peut récupérer plusieurs élements:

                            exemple:

                                    for element1, element2 in maListe:
                                            ...

                        Classique:
                            
                            for i in range(x, y):
                                print i


                        Itérations
                        ``````````````````````````

                                http://docs.python.org/3/tutorial/classes.html#iterators
                                (Voir aussi heritage et méthodes spéciales)

                                Les itérations correspondent à chaque tour de boucle.
                                Python créer un itérateur grâce à la méthode __iter__ (iter(maListe)).
                                Cette itérateur parcour la liste donnée avec la méthode __next__ (next(maListe))
                                Il s'arrete un fois tombé sur l'exception 'StopIteration'

                                exemple:

                                        maChaine = "blabla"
                                        iterateur = iter(maChaine) #Création d'un itérateur
                                        next(maChaine) #Renvoie de la première valeur de la liste
                                        next(maChaine) #Renvoie de la deuxième valeur de la liste
                                        ...

                                Pour créer son propre itérateur il faut donc jouer avec ces méthodes.

                                Exemple d'itérateur inversé d'une chaine (parcours à l'envers)

                                        
                                        class ReverseStr(str):
                                                """Classe parente str, changement de la méthode iter"""
                                                def __iter__(self):
                                                        return Iterateur(self)

                                        class Iterateur:
                                                """Itérateur parcourant la chaine"""
                                                def __init__(self, chaine):
                                                        """On récupère le nombre d'élements de la chaine"""
                                                        self.chaine = chaine
                                                        self.position = len(chaine)

                                                def __next__(self):
                                                        """Renvoie lélement suivant à partir de la fin"""
                                                        if self.position == 0:
                                                                raise StopIteration
                                                        self.position -= 1
                                                        return self.chaine[self.position]

                                        >>> chaine = ReverseStr("Hello")
                                        >>> for lettre in chaine:
                                                print(lettre)
                                        
                        Générateurs
                        ``````````````````````````

                                Un générateur permet de renvoyer une valeur à chaque itération.
                                Ces valeurs sont envoyée grâce à 'yield' au sein d'une fonction.
                                Python s'arrete lorsqu'il n'y a plus de valeur définit.


                                        yield maValeur : renvoie maValeur pour la première itération ...

                                exemple:

                                        def intervalle(debut, fin):
                                                """générateur définissant un intervalle"""
                                                debut += 1
                                                while debut < fin:
                                                        yield debut
                                                        debut += 1

                                        >>> generateur = intervalle(8, 12)
                                            for nombre in generateur:
                                                print(nombre)

                        Co-routines
                        ``````````````````````````
                                Elles permettent sur un générateur de changer le comportement de l'itérateur durant une itération.
                                Ces co-routines sont définits via des méthodes:

                                        close() pour interrompte une boucle

                                                generateur.close() =~ break;

                                        send() pour envoyer des données au générateur

                                                generateur.send(value)

                                                Il faudra récupérer la valeur envoyé coté générateur grâce à yield: valeur_recue = (yeld arg1)
                                                Si aucune valeur n'a été envoyée alors la valeur_recue du générateur vaudra None.

                                                exemple:

                                                        def intervalle(debut, fin):
                                                                """générateur définissant un intervalle"""
                                                                debut += 1
                                                                while debut < fin:
                                                                        catchValue = (yield debut)
                                                                        if catchValue is not None:
                                                                                debut = catchValue
                                                                        yield debut
                                                                        debut += 1

                                                        >>> generateur = intervalle(8, 24)
                                                            for nombre in generateur:
                                                                if nombre == 10:
                                                                        generateur.send(15)
                                                                print(nombre)
                                
	-------------------------
        Sauter une boucle
	-------------------------
		________________
                break : arréter une boucle

		________________
                continue : aller au prochain saut

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les Fonctions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
        Déclarer une fonction
	-------------------------

                def nomFonction(parametre1, parametre2):
                        BLOC d'INSTRUCTIONS

                def fonctionVide():
                        BLOC d'INSTRUCTIONS

		________________
                Valeur par défaut:
        
                        Il est possible de mettre une valeur par défaut à nos paramètres:

                                def nomFonction(paramètre1=N, ...):

                                exemple:

                                        def fonction(a=1, b=2, c=3):
                                                print('a=',a,' b=',b,'c=',c)

                        Note:
                               la valeur par défaut doit être attribué à tout les paramètres déclaré après la premiere valeur paramétrée.
                               Seul les paramètres à gauche de celle-ci pourront ne pas contenir de valeur par défaut.

                               exemple:
                                
                                        def fonction(a, b, c=5):
		________________
                Récupérer plusieurs paramètres inconnus:

                        Grâces aux listes:

                                def fonction(*parametres):

                        Tout les paramètres seront récupérés dans un tuple.

                        Il est possible d'avoir des paramètres recquis avant les paramètres inconnus

                        def fonction(param1, pram2, *params):

		________________
                Récupérer plusieurs paramètres inconnus nommés:

                        Grâces aux dictionnaires:

                                def fonction(**parametres):
                                        print("Paramètres: {}".format(parametres))

                        kwargs: 
                        ``````````````````````````

                            c'est le nom donné aux paramètres inconnus nommés
                            
                            Key Words arguments, permet à une fonction de prendre un nombre non définit d'argument keyword.

                            exemple:

                                def print_kwa(**kwargs):
                                    """A dict of keyword args passed to the function"""
                                    for key, val in kwargs.iteritems():
                                        print "%s = %s" % (key, val)

                                #appel de la fonction:

                                    print_kwa(some="things", foo='foo')
                                    #ou en envoyant un dico:
                                    kwargs={'some': 'things', 'foo':'foo'}
                                    print_kwa(**kwargs)

		________________
                Récupérer plusieurs paramètres inconnus non nommés et nommés:

                        def fonction(*paramsListe, **paramsDico):

		________________
                return : retourner une valeur

                        return maValeu

                        exemple:
                                
                                def carre(nombre):
                                        return nombre * nombre

                        Il est possible de retourner plusieurs valeurs:

                                return valeur1, valeur2, ...

		________________
                lambda : déclarer une fonction simple

                        variable = lambda paramètres: INSTRUCTION

                        exemple:

                                carre = lambda x: x * x
                                multiple = lambda x, y: x * y

		________________
                Une variable comme une fonction.

                        On peut très bien créer une référence sur une fonctino à l'aide d'une variable:

                        variable = fonction

                                exemple:
                                        print2 = print
                                        print2("Hello!")



	-------------------------
        Appeler une fonction
	-------------------------

		________________
                Basiquement:

                        maFonction(paramètre1, pamètre2)
                        ou
                        maFonction()


                        En récupérant une valeur:

                        variable = maFonction()

                        Pour une fonction lambda, on utilisera son nom de variable:
                        ``````````````
                                variable(paramètres)

                                exemple:
                                        carre(5)
		________________
                Avec paramètres nommés

                        Il est possible de choisir les paramètres que l'on envoi:

                        maFonction(paramètre3=N, paramètre1=Y, ...)

                        exemple:

                                fonction(b=6, a=5)

                        Note:
                                Les paramètres "nommés" doivent être placés après les paramètres non nommés

		________________
                Avec une liste de paramètres non nommés

                        liste_de_params = [arg1, arg2, arg3]
                        print(*liste_de_params)

		________________
                Avec une liste de paramètres nommés

                        dico_de_params = {"key":"value"}
                        fonction(**dico_de_params)


	-------------------------
        Signature d'une fonction
	-------------------------

                signature = moyens d'identifier une fonction
                En python , c'est la signature est le nom de la fonction.

                Il est possible de redéfinir une fonction avec le même nom plus loin dans son code.
                L'ancienne définition sera alors écrasée par la  nouvelle.

                exemple:
                        
                        def example():
                                print("my first function")
                        example

                        def example():
                                print("my second function")
                        example

	-------------------------
        Décorateurs
	-------------------------

                Les décorateurs peuvent s'appliquer aux fonctions, aux classes et méthodes.
                Ils permettent d'executer ces derniers en apportant de nouveaux comportement sans modifier la définition d'origine.

                __________________________
                Définir un décorateur:

                        On définit un décorateur et sa ou ses fonctions de modification.
                        On renvoie ensuite une fonction 'modifiée'
                        Fonctionne aussi avec une classe.

                        def monDecorateur(inputFunction):                       #ou inputClass
                                """prend en paramètre une fonction"""
                                        def modifiedFunction():
                                                """Fonction de modification"""
                                                ...
                                                return inputFunction()
                                return modifiedFunction                         #ou modifiedClass

                        Fonction avec paramètres
                        ``````````````````````````
                                Pour les fonctions nécessitant des paramètres on utilisera simplement la méthode des paramètres inconnus:

                                        def modifiedFunction(*params_non_nommes, **params_nommes):


                        Decorateur Avec paramètres
                        ``````````````````````````
                                La subtilité ici est de définir une fonction au dessus du décorateur pour traiter les paramètres envoyés:

                        
                                exemple: (Test du temps d'éxécution d'une fonction)
                                        
                                        import time

                                        def execTime(nb_secs):
                                                """Fonction prépondérante traitant les arguments"""
                                                def decorator(input_function):
                                                        """Décorateur chargé de traiter la fonction envoyée"""
                                                        def modifiedFunction():
                                                                """Fonction retournée"""
                                                                time_before = time.time()
                                                                output_value = input_function()         #execution de la fonction
                                                                time_after = time.time()
                                                                exec_time = time_after - time_before
                                                                if exec_time >= nb_secs:
                                                                        print("Attention la fonction {0} a mis {1} pour s'exécuter".format(input_function, exec_time))
                                                                return output_value
                                                        return modifiedFunction
                                                return decorator

                                        @execTime(X)
                                                def waitFor():
                                                        input("Appuyer sur Entrée...")

                                        >>> waitFor()

                __________________________
                Appeler un décorateur

                        Un décorateur s'éxécute au moment de la définition d'une fonction:
                        Il peut aussi s'appliquer à une classe

                        @monDecorateur
                        def maFonction()                #ou class maClasse

                        ou

                        maFonction = monDecorateur(maFonction)

                        Avec paramètres
                        ``````````````````````````

                                @decorateur(parametres)
                                def fonction(...):

                                ou

                                fonction = decorateur(parametres)(fonction)

                __________________________
                Chaîner des décorateurs
                
                        @decorateur1
                        @decorateur2
                        class maClasse ou def function():


                __________________________
                Un exemple concret avec le contrôle des types

                        def controlTypes(*listTypes, **dicoTypes):
                                """On prend en paramaètres les types contrôlés"""
                                def decorator(inputFunction):
                                        """Renvoie la fonction contrôlée"""
                                        def controledFunction(*functionListArgs, **functionDicoArgs):
                                                """Contrôle les types passés en paramètres"""
                                                
                                                if len(listTypes) != len(functionListArgs):
                                                        raise TypeError("le nombre d'argument doit être identique")

                                                for i, arg in enumerate(functionListArgs):
                                                        if listTypes[i] is not type(functionListArgs[i]):
                                                                raise TypeError("L'argument {0} n'est pas du même type {1}".format(i, listTypes[i]))
                                                                
                                                for key in functionDicoArgs:
                                                        if key not in functionDicoArgs:
                                                                raise TypeError("L'argument {0} n'a aucun type précisé".format(repr(key))
                                                        if dicoTypes[key] is not type(functionDicoArgs[key]):
                                                                raise TypeError("L'argument {0} n'est pas de type {1}".format(repr(key), dicoTypes[key]))
                                                return inputFunction(*functionListArgs, **functionDicoArgs)
                                        return controledFunction
                                return decorator

                        >>>
                        @controlTypes(int, int)
                        def intervalle(base_inf, base_sup):
                                print("Intervalle de {0} à {1}".format(base_inf, base_sup))

                        >>> intervalle(1, "testerreur")

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Pour regrouper les fonctions d'un même thème.

        -------------------------
        Déclarer un module
        -------------------------

                    Il suffit de créer un fichier.py à part et d'y mettre nos fonctions

        -------------------------
        Importer un module
        -------------------------
                ________________
                import : importer un module

                                import nomModule #sans le .py ;)

                                on peut le renommer:

                                        import nomModule as autreNomModule

                                En utilisant une variable:

                                        import importlib
                                        monModule = importlib.import_module("package.%s" % moduleVar)
                ________________
                from : importer les fonctions de mon module

                        from nomModule import nomFonction       #importe directement la fonction 
                        from nomModule import *                 #importe toutes les fonctions du module

                        En utilisant une variable:

                                outputVar = getattr(__import__(pathModule, fromlist=[maVar]), maVar)

        -------------------------
        Appeler une fonction ou une variable d'un module
        -------------------------

                On appel un module en fonction de la manière dont il a été importé.

                Avec import:
                        
                        nomModule.nomFonction()
                        nomModule.maVariable

                Avec from:
                        
                        nomFonction()
                        maVariable

	-------------------------
        Faire un test dans un module
	-------------------------

                Il est possible d'effectuer des tests qui seront exécutés uniquement lors de l'appel direct du script.py

                C'est à dire qu'ils n'auront pas d'effet lors de l'importation

                Pour cela on vérifie la valeur de la variable __name__:

                if __name__ = "__main__":
                        INSTRUCTIONS

                exemple

                        if __name__ = "__main__":
                                fonction("foo")


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les packages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Un package regroupe de façon hierarchique plusieurs modules d'un même thème.

	-------------------------
        Créer un package
	-------------------------

                Il faut placer un fichier nommé '__init__.py' à la racine de chaque package

                Note:
                        On peut imbriquer plusieurs package ensemble.

                Exemple:

                        monPackage/
                                __init__.py
                                moduleX.py
                                sousPackage/
                                        __init__.py
                                        moduleY.py

	-------------------------
        Importer un package
	-------------------------

                import monPackage

                On accéde simplement au modules en indiquant le path vers le module:
                        monPackage.monModule

                Si l'on veut uniquement un module d'un package:
                        from package.sousPackage import monModule

                exemples:

                    Accéder aux méthodes d'un modules dans un package:

                        > from package.module import *

                          monObjet = module()

                    Garder toute l'arborescence:

                        > import package.module

                          monObjet = package.module.module()

                    Avec le nom du module uniquement:

                        > from h2p_modules import manager

                          monObjet = module.module()

                
	-------------------------
        Appeler une fonction d'un package
	-------------------------

                de la même manière que pour les modules !

                Avec from : le nom direct de la fonction
                Avec import : le nom du module.le nom de la fonction

~~~~~~~~~~~~~~~~~~~~~~~~~~
Les classes / Modèles
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Elles définissent les méthodes et attributs appliquable à un objet.

        --------------------------
        Définir une classe
        --------------------------

                On définit au moins une classe et son constructeur:

                        class MaClasse:                                         #Nom classe
                                """DocString"""                                 #Petit help sur la classe

                                MES METHODES ET ATTRIBUTS

                                def __init__(self):                             #Méthode constructeur
                                        """DocString"""

                                        self.nomAttribut = "Something"          #Les attributs par défaut
                                        self.monAttribut2 = X
                                        self.monAttribut3 = ""

                Note: Les classes sont des objets définit à partir de la classe 'type'

                        On peut donc définir une classe de cette manière:

                                maClasse = type("NomClasse, tuple_classe_héritée, dico_attribut_méthodes)

                                exemple:
                                        maClasse = type("maClasse", (), {})

                                Voir métaclasse

                __________________________
                Les docString

                        Placés juste en dessous d'une classe ou d'une méthode, ils permetent d'apporter des renseignements au niveau du code même mais aussi directement affichable avec la commande help:

                                help("MaClasse")
                                help("MaClasse.maMethode")

                __________________________
                Self:
                        C'est l'objet qui va s'occuper d'appeler les différentes méthodes.
                        Il caractérise les méthodes et attributs internes d'une classe.
                        C'est l'instance de l'objet.

                        On pourrait écrire:
                                
                                MaClasse.maMethode(monObjet, params)
                                équivaut à
                                monObjet.maMethode(params)

                __________________________
                Le constructeur:
                        
                        Il permet de définir les attributs et instruction de base de la classe lors de la création d'un objet.

                        Un constructeur avec paramètres:
                        ``````````````````````````

                                def __init__(self, param1, param2):
                                        """DocString"""
                                        self.monAttribut = param1
                                        self.monAttribut2 = param2

                __________________________
                Les attributs:

                        Définit dans une méthode, ils seront propres à chaque objet.
                        Définit dans la classe même, ils seront identiques pour tout les objets.

                        Un attribut de classe
                        ``````````````````````````
                                class MaClasse:
                                        objets = 0

                                        def __init__(self):
                                                objets += 1

                                A chaque création d'objet, la variable objets sera incrémenté de 1
                                        
                                        MaClasse.objets         #0
                                        a = Maclasse()          
                                        MaClasse.objets         #1
                                        
                __________________________
                Les méthodes:

                        Méthode d'instance
                        ``````````````````````````
                                On les associes aux actions d'une classe

                                def maMethode(self, params):
                                        Mes instructions

                                Exemple:

                                        >>> class Slate:
                                                """Handle your slate as you whish"""
                                                
                                                def __init__(self):
                                                        self.surface = ""

                                                def note(self, sentence):
                                                        """Write notes on your slate"""
                                                        if self.surface != "":
                                                                self.surface += "\n"
                                                        self.surface += sentence

                                                def read(self):
                                                        """Read the slate"""
                                                        print(self.surface)

                                                def clean(self):
                                                        """Clean your slate"""
                                                        self.surface = ""


                                        >>> ardoise = Slate()
                                        >>> ardoise.note("escargots à la provencale")
                                        >>> ardoise.note("café à la crème")
                                        >>> ardoise.read()
                                        >>> ardoise.clean()

                                Note: Appeler une méthode interne:

                                                def internMeth(self):
                                                        ...

                                        >>> self.internMeth()


                        Méthode de classe
                        ``````````````````````````
                                Tout comme les attributs, on peut travailler directement sur la classe.

                                Il suffit d'employer la classe de l'objet à la place de l'instance self:
                                On la nomme communément 'cls'
                                Il faut ensuite classmethod pour indiquer qu'il s'agit d'une méthode de classe.

                                On s'en sert par exemple pour creer des attributs valables pour tout les objet de cette même classe.

                                >>>
                                        def maMethode(cls):
                                                cls.attributDeClasse = "Hello"

                                        maMethode = classmethod(maMethode)

                                Ainsi cls.attributDeClasse sera le même pour chaque objet.
                                Si on le modifie, il sera modifié dans tout les objets.

                        Méthode statiques
                        ``````````````````````````

                                Elles ne prennent ni 'self' ni 'cls' comme premier paramètre et ne travaillent pas sur les données.
                                On utilise 'staticmethod' pour les déclarer comme telle.

                                >>>
                                        def maMethode():
                                                print("something")
                                        maMethode = staticmethod(maMethode)


                        Méthodes spéciales:
                        ``````````````````````````

                                Ce sont des méthodes d'instance qui permet à Python de savoir comment agir dans certain contexte.
                                On les définit avec des doubles underscore de par et d'autre: __methodeSpe__

                                Elles servent notament à changer le comportement par défaut de certain mécanismes (= surcharger).
                                        Par exemple on peut 'surcharger' l'indexation, les opérateur mathématiques, les opérateurs de comparaisons ...
                                Surtout qu'il n'y a pas forcement de comportement par défaut pour nos objets. Exemple.

                                Tout les objets créer herite la classe object comportant ces méthodes.

                                On peut donc accéder explicitement à une méthode object ainsi:
                                        object.__methodeSpe__(self, arguments)

                                (Voir heritage)
                                

                        Méthodes spéciales globale d'un objet
                        ``````````````````````````

                                __new__ : Créer un objet pour l'instancier (c'est la première méthode appelée)
                                         Elle prend en paramètre la classe manipulée 'cls' et les paramètres de l'objet (pour l'appel d'init):

                                         def __new__(cls, params):
                                                """Construction de l'objet"""
                                                ...
                                                return object.__new__(cls, paramètres)

                                __init__ : agit lors de la création d'un objet, elle intervient après new et s'occupe de créer les attributs préalables:

                                        def __init__(self, params):
                                                """Constructeur"""
                                                self.params = params


                                __del__ : agit lors de la suppresion d'un objet

                                        Note: un objet ce détruit lors d'un appel explicite ou si l'espace dans lequel il a été crée est détruit.

                                        exemple:

                                                def __del__(self):
                                                        printf("This is the end")

                                __repr__ : permet de modifier l'affichage direct d'un objet

                                        exemple:
                                                
                                                def __repr__(self):
                                                        """sert surtout pour le debug"""
                                                        return "Etat des variables: {}".format(self.state)
                                        
                                        Note: la fonction repr permet d'appeler cette méthode:
                                                >>> repr(monObjet)

                                __str__ : permet de renvoyer une chaine lors de l'affichage d'un objet
                                        str est appelée avant repr (et la remplace si toutefoie elle est définie).
                                        exemple:

                                                def __str__(self):
                                                        """presque comme repr mais dans l'optique de récupérer une chaine"""
                                                        return "Etat des variables: {}".format(self.state)

                                                >>> print(monObjet)

                                        Note: la fonction str permet de récupérer cette chaine:
                                                >>> chaine = st(monObjet)

                        Méthodes spéciales d'attributs
                        ``````````````````````````

                                __dict__ : Contient la liste des attributs de l'objet et ses valeurs.

                                __getattr__ : définit les méthodes de lecture d'un attribut.
                                        Cette méthode est appelé à chaque accès (en lecture) à un attribut qui n'existe pas dans l'objet.
                                        Peut être utile pour rediriger vers un autre attribut.

                                        exemple:
                                                
                                                def __getattr__(self, attrNotFound):
                                                        """si python ne trouve pas d'attribut""
                                                        print("Warning, pas d'attribut ",attrNotFound)

                                        Fonction: getattr(object, "attribut")

                                __setattr__ : Définit les méthodes de modification d'un attribut
                                        Appeler à chaque fois qu'on modifie une valeur d'un attribut

                                        exemple:

                                                def __setattr__(self, attrName, attrValue):
                                                        """Appelé pour modifier un attribut"""
                                                        object.__setattr__(self, attrName, attrValue)
                                                        self.maMethode()

                                        Note: on utilise la methode setattr de la classe object pour éviter les boucle infinie. (Voir heritage).

                                        Fonction: setattr(object, "attribut", newValue)

                                __delattr__ : Appelé lors de la suppresion d'un attribut

                                        exemple:

                                                def __delattr__(self, attribut):
                                                        """Interdiction de supprimer un attribut"""
                                                        raise AttributeError("Impossible de supprimer l'attribut")

                                                >>> del monObjet.monAttribut

                                        Fonction: delattr(object, "attribut")


                        Méthodes spéciales de conteneur
                        ``````````````````````````

                                __getitem__ : Appelé lors de l'accès à l'index d'un conteneur

                                        exemple:

                                                def __getitem__(self, index):
                                                        return self._dico[index]

                                __setitem__ : Appelé lors la modification d'un élément d'un conteneur
                                        (objet[index] = valeur)

                                        exemple:

                                                def __getitem__(self, index, valeur):
                                                        self.dico[index] = valeur

                                __delitem__ : Appelé lors de la supression d'un élement d'un conteneur

                                __contains__ : Appelé lorsqu'on souhaite savoir si un objet se trouve dans un conteneur
                                        X in maListe = maListe.__contains__(X)
                                        Doit renvoyer True ou False

                                __len__ : Appelé pour connaitre la taille d'un conteneur
                                        len(objet) = monObjet.__len__()


                        Méthodes spéciales d'opérateur
                        ``````````````````````````

                                __add__ : Appelé lors d'une addition '+' d'objet
                                        paramètre: (self, objet_ajouté)
                                        Doit renvoyer la nouvelle valeur.
                                        Note: objet + X = objet.__add__(X)

                                        exemple: (avec Chrono le nom de la classe)

                                                def __add__(self, new_time):
                                                        """chrono"""
                                                        timer = Chrono()
                                                        timer.min = self.min
                                                   .secingleton(inputClass):
                                                   2196                                         instances = {} #On définit un dictionnaire qui va contenir un instance.
                                                   2197                                         def get_instance():         
                                                   2198                                                 if inputClass not in instances: #Si il n'y a pas d'instance, alors on la met dans notre dico et on appel notre clas     s
                                                   2199                                                         instances[inputClass] = inputClass() 
                                                   2200                                                 return instances[inputClass] #Dans tout les cas on renvoie notre première instance
                                                   2201                                         return get_instance
                                                   2202                                            
                                                   = self.sec

                                                        timer.sec += new_time

                                                        if timer.sec >= 60:
                                                                timer.min += timer.sec // 60
                                                                timer.sec = timer.sec %60

                                                        return timer

                                __sub__ : surcharger l'opérateur '-'
                                __mul__ : surcharger l'opérateur '*'
                                __truediv__ : surcharger l'opérateur '/'
                                __floordiv__ : surcharger l'opérateur '//'
                                __mod__ : surcharger l'opérateur '%'
                                __pow__ : surcharger l'opérateur '**'
                                                        
                        Méthodes d'opérateur inverse
                        ``````````````````````````

                                Le but étant ici de répondre au besoin de saisir des opération dans les deux sens.
                                En effet objet + 4 n'équivaut pas à 4 + objet et la méthode appelée risque de broncher.
                                Dans se cas on utilise le mot clé 'r' pour 'reverse' devant le nom de méthode:

                                exemple:

                                        def __radd__(self, object):
                                                return self + object

                        Méthodes d'opérateur d'ajout
                        ``````````````````````````
                                Même principe que inverse mais pour les méthodes appelant l'opérateur d'ajout type '+=', '-='... grâce au préfixe 'i'.

                                exemple:
                                        
                                        def __iadd__(self, object):
                                                ...

                        Méthodes spéciales de comparaison
                        ``````````````````````````
                                (self, objet_a_comparer):
                                return : True or False (ou un test de comparaison)

                                __eq__ : surcharger '=='
                                __ne__ : surcharger '!='
                                __gt__ : surcharger '>'
                                __ge__ : surcharger '>='
                                __lt__ : surcharger '<'
                                __le__ : surcharger '<='

                                Note: Si python n'arrive pas un test, il effectuera son inverse:
                                        si objet < objet2 ne fonctionne pas, il testera objet2 >= objet

                        Méthodes spéciales d'état / de serialisation
                        ``````````````````````````
                                Note: getstate et setstate peuvent manipuler d'autre type d'objet que des dictionnaire.

                                http://legacy.python.org/dev/peps/pep-0307/
                                
                                __getstate__: Appelée lors de la sérialisation d'un objet.
                                        Par exemple, il est appelé par pickle lorsqu'il souhaite enregistrer un objet.
                                        exemple:
                                                
                                                def __getstate__(self):
                                                        """Renvoie le dico d'attribut à sérialiser"""
                                                        dict_attr = dict(self.__dict__)
                                                        dict_attr =["attribut_temporaire"] = 0
                                                        return dict_attr

                                __setstate__: Inversement, elle est appelée lors de la déserialisation.
                                        Par exemple, lorsque que picket récupère un enregistrement.
                                        
                                        exemple:

                                                def __setstate__(self, dict_attr):
                                                        """désérialisation"""
                                                        self.__dict__ = dict_attr

                __________________________
                singleton:

                        (Voir aussi décorateurs)
                        
                        Les classes singleton ne peuvent être instanciée qu'une fois.
                        On pourra donc créer un seul objet de cette classe.

                        Il est plus commode d'utiliser les décorateurs pour pour faire cela:

                        exemple:
                                
                                def singleton(inputClass):
                                        instances = {} #On définit un dictionnaire qui va contenir un instance.
                                        def get_instance():
                                                if inputClass not in instances: #Si il n'y a pas d'instance, alors on la met dans notre dico et on appel notre class
                                                        instances[inputClass] = inputClass() 
                                                return instances[inputClass] #Dans tout les cas on renvoie notre première instance
                                        return get_instance

                                >>> @singleton
                                    class Test:
                                        ...

                                    a = Test()
                                    b = Test()
                                    a is b   -> True

                                a et b pointe vers le même objet.


                        Il existe plusieurs méthodes pour créer un singleton:

                        Voir: http://stackoverflow.com/questions/6760685/creating-a-singleton-in-python

                        
                        Meta classe:
                        ``````````````````````````

                            class Singleton(type):
                                _instances = {}
                                def __call__(cls, *args, **kwargs):
                                    if cls not in cls._instances:
                                        cls._instances[cls] = super(Singleton, cls).__call__(*args, **kwargs)
                                    return cls._instances[cls]

                            #Python2
                            class MyClass(BaseClass):
                                __metaclass__ = Singleton

                            #Python3
                            class MyClass(BaseClass, metaclass=Singleton):
                                pass

        --------------------------
        Appeler une classe
        --------------------------
                __________________________
                Définir un objet

                        monObjet = MaClasse()

                        Avec plusieurs paramètres:

                                monObjet = Maclasse("value1", "value2")

                        Si on passe par un module, il ne faut pas oublier d'indiquer son nom:
                                
                                monObjet = module.MaClasse()

                __________________________
                Accéder à un attribut:

                        monObjet.monAttribut


                __________________________
                Redéfinir un attribut:

                        monObjet.monAttribut = "otherValue"
                        monObjet.monAttribut    #Affichera "otherValue"

                __________________________
                Tester la présence d'un attribut:

                        hasattr(objet, "attribut")
                __________________________
                Accéder à une méthode:
                        
                        monObjet.maMethode()
                        ou
                        maClasse.maMethode(monObjet)

                        La seconde est à préférer lorsqu'on souhaite être précis,
                        (Très utile pour l'heritage)

                __________________________
                Introspection:

                        Ce sont les manières d'explorer les méthodes et attributs d'un objet

                        dir : Renvoie la liste des méthodes et des attributs d'un objet.
                        ``````````````````````````
                                >>> dir(monObjet)
                        
                        __dict__ : attribut spécial contenant les attributs et leurs valeurs.
                        ``````````````````````````

                                >>> monObjet.__dict__

                                Note: on peut modifier directement l'attribu d'un objet via __dict__ :

                                        monObjet.__dict__['monAttribut'] = 'newValue'


        --------------------------
        Propriétés
        --------------------------

                En python les propriété sont définis essentiellement sur les attributs dépendant d'une action particulière.

                Note: Tout les attributs sont public et accessibles depuis l'extérieur de la classe.

                Pour indiquer qu'un attribut ou une méthode est 'privé', on place un underscore '_' devant le nom de l'attribut ou de la méthode.

                Exemples:

                        def _get_maMethode(...):
                        def _set_maMethode(...):
                        self._monAttribut = ''

                Il est toujours conseillé d'encapsulé pour gagner en lisibilité.
                L'appel d'un attribut quand à lui se fera toujours de la même manière.
                        
                        monObjet.maMethode

                __________________________
                Encapsulation:

                        Permet de protéger les attributs d'une classe et de contrôler les actions liés aux attributs.
                        C'est à dire que Python va tout seul, en fonction du contexte, appeler get si on souhaite récupérer la valeur d'un attribut via une méthode ou set si on souhaite modifier la valeur d'un attribut via la même méthode.


                        l'Attribut au niveau du constructeur:
                        ``````````````````````````

                                def __init__(selfs, param1, param2):
                                        self._monAttribut = param1
                                        self._monAttribut2 = param2
                        
                        get: récupérer la valeur d'un attribut (accesseurs)
                        ``````````````````````````
                                Accès en lecture:

                                        def _get_maMethode(self):
                                                return self._monAttribut

                        set: modifier la valeur d'un attribut (mutateurs)
                        ``````````````````````````
                                Accès en écriture:

                                        def _set_maMethode(self, value):
                                                self._monAttribut = value

                __________________________
                Déclaration:

                        Se déclare directement dans le corps de la classe:
                                
                                METHOD = property(ACCESSEURS, MUTATEUR, [DEL_METHOD, HELP_METHOD])
                                
                                exemple:

                                        maMethode = property(_get_maMethode, _set_maMethode)

        --------------------------
        Heritage
        --------------------------

                L'heritage permet aux objet d'une classe enfant d'accéder aux attributs et méthode d'une classe parente.
                __________________________
                Heritage simple

                        Les méthodes sont d'abord parcouru dans la classe enfant;
                        Si on appele une méthode qui n'est pas présente dans cette dernièrer, il parcours alors récursivement les classes parentes.
                        Il faut donc penser à bien ajouter les attributs des constructeur parents dans la classe enfant.

                        Hériter d'une classe:
                        ``````````````````````````
                                class classeEnfant(ClasseParente):
                                        ...

                                exemple:
                                        
                                        class voiture(vehicule):
                                                """voiture herite de vehicule"""

                        Hériter des attributs constructeurs
                        ``````````````````````````
                                def __init__(self, arguments):
                                        classeParente.__init__(self, arguments)
                                        self.variable = argumentX

                __________________________
                Heritage multiple

                        Le but étant de mettre à disposition méthodes et attributs de plusieurs classe parentes sans toutefois qu'il y ait une hiérarchie entre parent.

                        Par exemple pour un moteur, 

                                on peut avoir une classe hybride heritant de la classe electrique et diesel (héritant vraissemblablement toutes deux de la classe moteur). 
                                La classe electrique et diesel sont bien au même niveau hierarchique.

                        Hériter de plusieurs classes:
                        ``````````````````````````
                                class classeEnfant(ClasseParente1, ClasseParente2):

                                Note: la recherche des méthodes se fait dans l'ordre de défintion des classes (d'abord la première et ses classes parentes, puis la deuxième ...)


                _________________________ 
                Vérifier l'heritage

                        issubclass : vérifie si c'est une classe enfant
                        ``````````````````````````
                                issubclass(classeEnfant, classeParente) -> True
                        
                        isinstance : vérifie si un objet est issu d'une classe (enfant comprise)
                        ``````````````````````````
                                
                            objet = maClasse()
                            isinstance(objet, maClasse) -> True

                            On peut s'en servir pour tester si un objet est d'un certain type, exemple :

                                if isinstance(my_supposed_object_list, list):
                                    do_what_you_want()



        --------------------------
        Métaclasses
        --------------------------

                Ce concept permet de créer une classe à partir d'autre classe.
                Les métaclasses heritent naturelement de la classe 'type'

                _________________________ 
                Définir une métaclasse:

                        On s'occupe essentiellement des méthodes __new__ et __init__

                        
                        __new__(metacls, name, tuple, dict):
                        ``````````````````````````
                                Avec:

                                        metacls: métaclasse modèle pour la création de la nouvelle classe
                                        name: nom de la nouvelle classe
                                        tuple: Le tuple contenant les classes héritées
                                        dict: le dico des attributs et méthodes de notre nouvelle classe

                                exemple:

                                        def MaMetaClasse(type):
                                                """Ma metaclasse"""

                                                def __new__(metacls, name, tuple, dict):
                                                        """Création de de la classe"""
                                                        print("Création de la classe: {}".format(name))
                                                        return type.__new__(metacls, name, tuple, dict)

                        __init__(cls, name, tuple, dict):
                        ``````````````````````````
                                Avec: (voir new)

                                        cls: la classe créee

                                exemple:
                                        
                                        def __init__(cls, name, tuple, dict):
                                                type.__init__(cls, name, tuple, dict)
                                                ...

                _________________________ 
                Appliquer une métaclasse:

                        exemple:

                                class MaClasse(metaclass=MaMetaClasse):
                                        ...

                        
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les erreurs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        Le but étant de contrôler les erreurs renvoyer par l'interpréteur.
        On va donc essayer un bout de code et en fonction du code retourné par l'interpréteur (l'exception),nous allons créer notre propre message d'erreur et/ou instructions.

	-------------------------
        Forme d'une erreur renvoyée
	-------------------------

                Renvoyer une erreur consiste à "lever une exception".

                En précisant la nature de l'erreur et apporter quelque précision.

                exemple:

                        Traceback (most recent call last):
                        File "<stdin>", line 1, in <module>
                        ZeroDivisionError: int division or modulo by zero

	-------------------------
        Types d'erreurs
	-------------------------

                http://docs.python.org/2/library/exceptions.html

                ZeroDivisionError:      Division par zero
                NameError:              La variable n'existe pas
                TypeError:              Le type attendu n'est pas le bon
                ValueError:             La valeur attendu n'est pas la bonne
                AssertionError:         Cas particulier des assertions
                IndexError:             Si l'index dépasse la tranche définis (d'une liste par exemple)

	-------------------------
        Les exceptions
	-------------------------
                
                Essayer mon CODE excepté pour les erreurs citées.

                try:
                        INSTRUCTIONS
                except:
                        CODE A RETOURNER EN CAS D'ERREUR


                Par défaut le except comprend directement qu'il s'agit d'une erreur.
                Mais il est largement conseiller de contrôler les erreurs renvoyées:

                try:                                    #permet de lancer un test
                        INSTRUCTIONS1
                except EXCEPTION X:                     #définir les instructions en cas d'exception X
                        INSTRUCTIONS_ERREUR
                except EXCEPTION Y:                     #définir les instructions en cas d'exception Y
                        INSTRUCTIONS_ERREUR2
                else:                                   #définir les instructions par défaut en cas d'erreur
                        INSTRUCTIONS_DEFAUT
                finally:                                #Exécuter dans tout les cas les instructions définies
                        INSTRUCTION_OBLIGATOIRE


                Note: On n'est pas obligé de présicer une exception.
                Dans ce cas l'instruction sera lu pour n'importe quelle exception levée.

                    except:
                        Intructions

                    Pour récupérer le type d'exception et son contenu on peut faire génériquement:

                    except Exception as errorMessage:
                        print('Except type:', sys.exc_info()[0])
                        print('Except message:', errorMessage)
                    else:
                        print("it's all right")


		________________
                as : récupérer le message de l'erreur

                        except TYPE_EXCEPTION as monErreur:

                        exemple:

                                a = 5
                                #provoquer une erreur: (jouer avec les commentaire sur b)
                                #b = 2
                                #b = 0
                                #b = "str"

                                try:
                                        a / b
                                except NameError as contenuErreur:
                                        print("Variable non définie: ", contenuErreur)
                                except TypeError as contenuErreur:
                                        print("Variable mal typée: ", contenuErreur)
                                except ZeroDivisionError:
                                        print("Division par 0!")
                                else:
                                        print("tout est ok!")
                                finally:
                                        print("je vous retrouverais!")
		________________
                raise : lever une exception pour créer une erreur

                        raise TypeException("Mon message d'erreur") 

                        #Le type doit être un type d'erreur de l'interpréteur.
                        On peut lever une exception en dehors du bloc try!
                                Dans ce cas le programme s'arretera et renverra l'erreur.

                        exemple:

                                a = 1
                                b = 2

                                try:
                                        a / b
                                        if a < b:
                                                raise ValueError("a est plus petit que b")
                                except ValueError as message:
                                        print("ValueError: ", message)

                        autre exemple:
                                
                                if type(variable) is not float:
                                        raise TypeError("Need a float")

		________________
                Créer ses exceptions:

                        Notion d'heritage:
                        ``````````````````````````
                                Les exceptions sont des classes hiérarchisées (voir heritage).

                                Ce qui implique que lorsqu'on intercepte un TypeException, on intercepte toute ses exceptions avec celles des classes parentes.

                                Voir: http://docs.python.org/3/library/exceptions.html

                                Le mieu étant de se référer directement à l'aide d'une exception:
                                        
                                        help("Mon_Exception")

                                        Voir 'Method resolution order'

                                On pourra écrire par exemple:
                                        >>> except ClasseParente: ...

                        Les classes d'exception mères communes
                        ``````````````````````````
                                BaseException : la classe mère de 'toutes' les exceptions
                                        Modelise une exception qui ne necessite pas forcement d'une interruption.
                                Exception : Classe mère de toutes les exceptions d'erreur.
                                
                                
                        Application
                        ``````````````````````````

                                Il faut determiner une méthode __init__ et __str__ .

                                exemple:

                                        class MonException(Exception):
                                                """On herite d'Exception"""

                                                def __init__(self, code, message):
                                                        self.codeErreur = code
                                                        self.messageErreur = message

                                                def __str__(self):
                                                        return "[{}:{}]".format(self.codeErreur, self.messageErreur)

                                        >>> raise MonException(3615, "attention c'est mal")
                                               

	-------------------------
        Les assertions
	-------------------------

                Elles permetent de s'assurer qu'une condition est bien remplie avant de continuer.

                assert TEST

                En cas d'erreur l'interpréteur renvoie 'AssertionError' (si une autre erreur n'a pas été trouvée avant)

                exemple d'erreur:

                        a = 5
                        assert a == 8

                        Traceback (most recent call last):
                        File "<stdin>", line 1, in <module>
                        AssertionError

                On pourrait directement la traiter avec except

                        try:
                                assert a == 8
                        except AssertionError:
                                print("a doit valoir 8")

~~~~~~~~~~~~~~~~~~~~~~~~~~
Les fichiers
~~~~~~~~~~~~~~~~~~~~~~~~~~

	-------------------------
	Ouvrir open
	-------------------------
                
                monFichier = open("/path/to/file", "mode")

                __________________________
                Les modes d'ouvertures:

                        r: read
                        w: write
                        a: append
                        b: binary 
                        U: support étendu des newline
                __________________________
                contrôller l'ouverture:

                        On éxécute les opérations sur un fichier dans un bloc.
                        Ainsi même en cas d'erreur le fichier est fermé à la fin du bloc.

                        Note: dans ce cas, pas besoin d'utiliser .close()

                        with open("monFichier", "modeOuverture") as monFichier:
                                INSTRUCTIONS

	-------------------------
	Lire .read
	-------------------------
                __________________________
                Lire tout le contenu:

                        contenu = monFichier.read()
                        print(contenu)

                        Pour peaufiner le traitement des lignes, il faut jouer avec les \n.

	-------------------------
	Ecrire .write
	-------------------------
                __________________________
                Ecrire une chaine:

                        monFichier.write("Ma chaîne")

	-------------------------
	Fermer .close
	-------------------------

                monFichier.close()

	-------------------------
	Fonctions/méthodes
	-------------------------
                __________________________
                Se déplacer

                        import os
                        os.chdir("/MON/PATH")

                        Note: Le '/' fonctionne même sur windows
                __________________________
                Manipuler des objets au travers des fichiers avec pickle

                        Note: picker enregistre ses données dans des fichier binaires.
                        Il faut prendre soint de rajouter le mode binary: 'b'
                                exemple:
                                        open(monPath, "wb") #mode ecriture
                                        open(monPath, "rb") #mode lecture

                        Importer pickle
                        ``````````````````````````
                                import pickle

                        Enregistrer un objet (Pickler)
                        ``````````````````````````
                                myPickler = pickle.Pickler(monFichier)
                                myPickler.dump(objet)

                        Récupérer un objet (Unpickler)
                        ``````````````````````````
                                myUnPickler = pickle.Unpickler(monFichier)
                                myObject = myUnPickler.load()
                __________________________
                os.path: manipuler les chemins d'accès et tester l'existence de fichier

                        http://docs.python.org/2/library/os.path.html

                        import os
                        
                        os.path.exists(PATH) : vérifier si le path existe
                        ``````````````````````````
                        os.path.isfile(PATH/To/FILE) : vérifier si c'est un fichier
                        ``````````````````````````
                        os.path.isdir(PATH/To/Dir) : vérifier si c'est un dossier
                        ``````````````````````````
                        os.path.basename(PATH) : Renvoyer le nom du fichier
                        ``````````````````````````
                        os.path.dirname(PATH) : Renvoyer le nom du dossier où se trouve notre fichier
                        ``````````````````````````
                __________________________
                glob : récupérer la liste de fichier:

                    Exemple:

                        import glob
                        print glob.glob("/tmp/*")

                    Tester la présence de fichiers:

                        files = glob.glog("/tmp/*")
                        if files:
                            print( "There are some files" )
                __________________________
                shutil : Manipuler les fichiers et dossiers

                    https://docs.python.org/2/library/shutil.html

                    Importer le module:

                        > import shutil

                        Copier des fichiers:
                        ``````````````````````````
                            > shutil.copy(src, dst)

                        Dépacer des fichiers:
                        ``````````````````````````
                            > shutil.move(src, dst)

                        Copier des dossiers:
                        ``````````````````````````
                            > shutil.copytree(src, dst)

	-------------------------
	Fichier de configuration
	-------------------------
                Jouer avec les modules ou en prendre un tout fait:
                __________________________
                ConfigParser:

                    liens:

                        https://docs.python.org/2/library/configparser.html#module-ConfigParser
                        https://docs.python.org/3.4/library/configparser.html#module-configparser

                        Syntaxe du fichier de configuration:
                        ``````````````````````````
                            > vim fichier.conf

                                [global]
                                dir=/usr/local/foo
                                log: %(dir)s/file.log   #On récupère la valeur de dir
                                long: un texte sur
                                   plusieur lignes

                                [network]
                                socket = (192.168.1.1, 1234)
                                ...

                        Lecture du fichier de config
                        ``````````````````````````

                            Il existe plusieurs méthodes, à voir directement dans la doc.

                            config = ConfigParser.ConfigParser()
                            config.read('example.cfg')

                            print config.get('global', 'dir')


                        Ecriture dans le fichie de config
                        ``````````````````````````
                            config = ConfigParser.RawConfigParser()
                            config.add_section('global')
                            config.set('global', 'dir', '/usr/local/foo')

                            with open('file.conf', 'wb') as configfile:
                                config.write(configfile)

                
~~~~~~~~~~~~~~~~~~~~~~~~~~
Le temps
~~~~~~~~~~~~~~~~~~~~~~~~~~
	-------------------------
    Les modules
	-------------------------
                __________________________
                time : Accéder à l'horloge système et convertir des timestamps
                        >>> import time

                        http://docs.python.org/3/library/time.html
                __________________________
                datetime : représenter le temps avec plusieurs classes

                        >>> import datetime
                

	-------------------------
    Les méthodes
	-------------------------
                __________________________
                time:

                        time() : donner le POSIX timestamp (depuis le 1er janvier 1970)
                        ``````````````````````````
                                >>> time.time()

                        localtime() : donner la date et l'heure locale et convertir un timestamp
                        ``````````````````````````

                                >>> time.localtime()

                                On récupère un objet composé de plusieurs attributs:

                                Dans l'ordre:
                                        
                                        tm_year
                                        tm_mon
                                        tm_mday
                                        tm_hour
                                        tm_min
                                        tm_sec
                                        tm_wday
                                        tm_yday : le jour de l'année (entre 1 et 366)
                                        tm_isdst : représenter le changement d'heure local

                                On peut aussi formater un timestamp grâce à cette méthode:

                                >>> time.localtime(MonTimestamp)

                        mktime() : convertir un localtime en timestamp
                        ``````````````````````````
                                >>> time.mktime(monLocalTime)

                        sleep() : mettre en pause le programme
                        ``````````````````````````
                                >>> time.sleep(TempsDePauseEnSeconde)

                        strftime() : formater le temps
                        ``````````````````````````
                                >>> time.strftime("FORMAT")

                                %A : Nom jour
                                %B : Nom mois
                                %d : jour
                                %H : Heure
                                %M : minute
                                %S : secondes
                                %Y : Année

                                exemple:

                                        >>> strftime("%A %d")
                                
                __________________________
                datetime:

                        date() : représenter une date 
                        ``````````````````````````
                                date = datetime.date(ANNEE, MOIS, JOUR)

                                >>> print(date)
                                
                        date.today() : renvoie la date du jour
                        ``````````````````````````
                                today = datetime.date.today()

                        date.fromtimestamp() : renvoie la date par rapport au timestamp donné
                        ``````````````````````````
                                exemple:
                                        datetime.date.fromtimestamp(time.time())

                        time() : représenter une heure
                        ``````````````````````````
                                date = datetime.time(HEURE, MINUTE, SECONDE, MICROSECONDE, TIME_ZONE)

                        datetime.now() : afficher la date et l'heure actuelle
                        ``````````````````````````
                                >>> datetime.datetime.now()

                        datetime.fromtimestamp() : afficher la date et l'heure actuelle à partir du timestamp
                        ``````````````````````````
                                >>> datetime.fromtimestamp(timestamp)

~~~~~~~~~~~~~~~~~~~~~~~~~~
Intéragir avec le système
~~~~~~~~~~~~~~~~~~~~~~~~~~
	-------------------------
        Les Modules
	-------------------------
                __________________________
                sys : accéder aux divers objets de l'interpréteur

                        Par exemple les différents canaux, les arguments envoyés au script ...

                        voir help("sys")

                        >>> import sys

                __________________________
                os : couche d'abstraction de certain élément du système, executer une commande système

                        Par exemple les paths d'éxécution ...

                        >>> import os


	-------------------------
        Redirection de flux
	-------------------------

                Ce manipulent typiquement avec read, write ...

                __________________________
                sys.stdin : entrée standard
                __________________________
                sys.stdout : sortie standard

                        >>> sys.stdout.write("hello")

                        Rediriger dans un fichier
                        ``````````````````````````

                                fichier = open('monFichier', 'w')
                                sys.stdout = fichier
                                print("Something")
                        
                __________________________
                sys.sterr : sortie d'erreur

	-------------------------
        Les paths
	-------------------------
                __________________________
                os.getcwd : obtenir le path courant d'éxécution du script

	-------------------------
        Les signaux
	-------------------------

                Ils permettent d'envoyer des signaux particulier aux processus

                >>> import signal

                __________________________
                signal() Intercepter un signal:

                        signal.signal(MON_SIGNAL, FONCTION_APPELEE)

                        Appele une fonction avec le signal et la trame (voir help).
                                http://docs.python.org/dev/reference/datamodel.html#frame-objects

                        exemple:

                                def closeProg(signal, frame):
                                        sys.exit(0)

                                signal.signal(signal.SIGINT, closeProg)

                                ...

                        SIGINT peut être généré avec CTRL+C.
                        
                __________________________
                sys.exit() : quitter un programme 

                        sys.exit(0) : renvoyer 0 comme valeur de sortie à la fin du programme.
                __________________________
                Exemples:

                        Avec un script attendant d'éxécuter une boucle complète après un SIGTERM.
                        ``````````````````````````

                                ****************************
                                #!/usr/bin/python

                                import sys, signal, time

                                class sigman:
                                    
                                    def __init__(self):
                                        print "welcome to the sig manager"
                                        self.stop = False
                                        for sig in [signal.SIGTERM, signal.SIGINT, signal.SIGHUP, signal.SIGQUIT]:
                                            self.kill(sig)

                                    def handler(self, signum = None, frame = None):
                                        print 'Signal handler called with signal' + str(signum)
                                        time.sleep(1)  #here check if process is done
                                        print 'Wait done'
                                        self.stop = True

                                    def kill(self, sig):
                                        signal.signal(sig, self.handler)

                                    def quit(self):
                                        sys.exit(0)
                                        
                                print 'begin'
                                apps = sigman()
                                run = True
                                print apps.stop

                                while run:
                                    print "t"
                                    time.sleep(0.5)
                                    print "tt"
                                    time.sleep(0.5)
                                    print "ttt"
                                    time.sleep(0.5)
                                    print "tttt"
                                    time.sleep(0.5)
                                    print "ttttt"
                                    time.sleep(0.5)
                                    print "tttttt"
                                    time.sleep(0.5)

                                    if apps.stop:
                                        apps.quit()
                                ****************************

                        Un plus petit script avec l'écoute d'interruption d'un processus (CTRL + C)
                        ``````````````````````````
                                ****************************
                                > import signal

                                shutdown = False
                                
                                def sig_int_handler(signal, frame):
                                    global shutdown
                                    shutdown = True

                                #Ecoute du signal SIGINT et appel de la fonction sig_int_handler dans ce cas:
                                signal.signal(signal.SIGINT, sig_int_handler)

                                while not shutdown:
                                    print 'mes instructions'

                                sys.exit(0)
                                ****************************
                    

	-------------------------
        Les arguments
	-------------------------
                __________________________
                sys.argv: récupérer la liste des arguments envoyés au script

                        >>>print(sys.argv)

                __________________________
                Contrôler le nombre d'arguments:

                        if len(sys.argv) < X:
                                ...

                __________________________
                Récupérer un argument:

                        nomProg = sys.argv[0]
                        monArgument = sys.argv[n>0]
                __________________________
                argparse: traiter les arguments sous forme d'option avancée

                        TODO

                        http://docs.python.org/2/library/argparse.html

                __________________________
                getopt: traiter les arguments sous forme d'option simple

                        >>> import getopt

                        Syntaxe:
                        ``````````````````````````
                                getopt.getopt(LISTE_ARGS, OPTIONS_COURTES, [OPTIONS_LONGUES])

                                Renvoie la liste des options et leurs valeurs et la liste des arguments non interprétés:
                                        >>> opts, args = getopt.getopt(sys.argv[1:], optionsCourtes, optionsLongues)

                        Syntaxe des options
                        ``````````````````````````
                                Options_courtes = "c"           #-c
                                Options_longues = ["long"]      #--long

                        options avec paramètre
                        ``````````````````````````
                                Pour les options courtes on met un ':' après l'option
                                        "h:"
                                Pour les options longues on met un '=' après l'option
                                        "help="

                        Exemple
                        ``````````````````````````

                                optionCourtes = "hp:v"
                                optionLongues = ["help", "param=", "verbose"] 

                                try:
                                        opts, args = getopt.getopt(sys.argv[1:], optionsCourtes, optionsLongues)
                                except getopt.GetoptError as err:
                                        print(err)
                                        usage()
                                        sys.exit(2)

                                params = None
                                verbose = False

                                for opt, arg in opts:
                                        if opt in ('-v', '--verbose'):
                                                verbose = True
                                        elif opt in ('-h', '--help'):
                                                usage()
                                                sys.exit()
                                        elif opt in ('-p', '--param'):
                                                param = arg
                                        else:
                                                print("Option {} inconnue".format(opt))
                                                sys.exit(2)

        -------------------------
        Les commandes systems
        -------------------------
                __________________________
                Exécuter une commande système:

                        Via os.system:
                        ``````````````````````````

                            Permet d'exécuter une commande et de récupérer le code de sortie (uniquement).

                            os.system('MaCommande')

                            exemples:

                                os.system("pause") : mettre en pause l'éxécution du programme (sous Windows)
                                os.system('ls')

                                ...

                        Via un pipe avec os.popen:
                        ``````````````````````````

                            Cette méthode permet de récupérer le retour d'une commande:

                            On récupère la sortie de la commande dans un objet.

                            Template:

                                cmd = os.popen('MaCommande')
                                cmd.MaMethode

                            Exemples: 

                                cmd = os.popen('ps faux')
                                cmd.read() : affiche le contenu du retour de la commande

~~~~~~~~~~~~~~~~~~~~~~~~~~
Le réseau
~~~~~~~~~~~~~~~~~~~~~~~~~~
    -------------------------
    Le socket
	-------------------------

                import socket
                __________________________
                Créer un socket:

                        socket.socket(DOMAINE_SOCKET, TYPE_SOCKET)

                        exemple:
                                connexion = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                        
                __________________________
                Lier le socket à une adresse locale:

                        monObjet.bind((HOSTNAME, PORT))

                        Note: nécessaire notament pour la partie serveur.

                        exemple:
                                connexion.bind(('', 55555))

                __________________________
                Ecouter sur un socket:

                        monObjet.listen(NOMBRE_CONNEXIONS_SIMULTANEE)

                        exemple:
                                connexion.listen(10)
                        
                __________________________
                Accépter une connexion:

                        objetSocketClient, tupleSocketClient = objetSocketServer.accept()

                        exemple:
                                connexion_client, infos_socket_client = connexion.accept()
                        
                __________________________
                Se connecter à un socket:

                        objetConnexion.connect(('HOSTNAME', PORT))

                        exemple:
                                connexionAuClient(('localhost', 55555))

                __________________________
                Communication de socket:

                        La communication entre socket se fait via des bits, il faudra donc formater ses données en conséquence.

                        Envoyer des données
                        ``````````````````````````
                                monObjet.send(DONNEES_OCTAL)

                                Cette méthdoe renvoie le nombre de caractère envoyés

                                exemple:
                                        connexion.send(b"Connection established")

                        Recevoir des données
                        ``````````````````````````

                                monObjet.recv(NOMBRE_CARACTERE)

                                exemple:
                                        msg_recu = connexion.recv(1024)
                __________________________
                Fermer une connexion, un socket:

                        monObjet.close()

                        exemple:
                                connexion.close()


	-------------------------
    Relation client/serveur
	-------------------------
                Voir socket, socketserver, select
                __________________________
                Serveur:

                        Select:
                        ``````````````````````````
                        Pour la gestion asynchrone d'entrée et de sortie de descripteur de fichier

                                Select va nous aider à gérer de multiples connexion et l'envoie de message e données de façon asynchrone entre les clients et le serveur.

                                import select

                                (rlist, wlist, xlist) = select(rlist, wlist, xlist[, timeout])

                                rlist : sequence en attente de lecture
                                wlist : sequence en attente d'écriture
                                xlist : sequence en attente d'une levée d'exception (d'erreur)
                                timeout : temps avant de retourner les données

                                Renvoie un tuple de trois valeurs correspondant au 3 premier arguments.


                        import socket
                        import select

                        host = ''
                        port = 55555
                        serverSocket = (host, port)
                        serverRunning = True
                        connectedClients = []

                        connection = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                        connection.bind(serverSocket)
                        connection.listen(5)

                        print("Server listening on port", port)

                        while serverRunnging:
                                rlist, wlist, xlist = select.select([connection], [], [], 0.05)

                                for readingConnection in rlist:
                                        clientConnection, clientInfos = readingConnection.accept()
                                        connectedClients.append(clientConnection)
                                        
                                rlistClient = []
                                try:
                                        rlistclient, wlist, xlist = select.select(connectedClients, [], [], 0.05)
                                except select.error:
                                        pass
                                else
                                        for clientConnection in rlistClient:
                                                receivedData = clientConnection.recv(1024)
                                                print(receivedData.decode())
                                                clientConnection.send(b"Data received")

                                                if receivedData == "end":
                                                        serverRunning = False

                        for clientConnection in connecterClients:
                                clientConnection.close()
                        connection.close()
                        print ("Connection closed")

                __________________________
                Client:

                        import socket

                        host = 'serverHost'
                        port = 55555
                        serverSocket = (host, port)

                        connection = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                        connection.connect(serverSocket)
                        print("Connection established on port: ", port)

                        dataToSend = b""
                        while dataToSend != b"end":
                                dataToSend = input("> ")

                                dataToSend = dataToSend.encode()

                                connection.send(dataToSend)
                                receivedData = connection.recv(1024)

                                print(receivedData.decode())

                        connection.close()
                        print ("Connection closed")

	-------------------------
    Protocole HL7
	-------------------------

        import hl7

	-------------------------
        Scapy
	-------------------------

            http://www.secdev.org/projects/scapy/doc/usage.html
            http://openclassrooms.com/courses/manipulez-les-paquets-reseau-avec-scapy

            Pour l'install sur debian : 
                > apt-get install python-scapy
                __________________________
                Importer scapy:

                    from scapy.all import *
                __________________________
                Lire un pcap:

                    p = rdpcap(pcap)

                    renvoie la liste des paquets.
                __________________________
                Afficher un pcap:

                    p.show()

                    Pour avoir plus de précision il faut cibler un paquet spécifique.

                    p[1].show()

                    exemple:
                        
                        p = rdpcap(pcap)
                        for pkt in p:
                            pkt.show()

                __________________________
                Créer des paquets (+ encapsulation)

                        Une trame ethernet:
                        ``````````````````````````

                            ma_trame = Ether()
                            ma_trame.show()

                            changer l'adresse dest:

                                >>> ma_trame = Ether(dst='00:19:4b:10:38:79')

                        Un paquet ICMP:
                        ``````````````````````````
                            mon_ping = Ether() / IP(dst='192.168.1.1') / ICMP()
                __________________________
                Envoyer un pcap:


                        Dans un sens:
                        ``````````````````````````
                            Avec en-tête ethernet manuelle:

                                >>> sendp(pcap)

                            Avec en-tête ethernet automatique:

                                >>> send(pcap)

                        Pour recevoir aussi la réponse:
                        ``````````````````````````

                            exemple avec un ping:

                                >>> rep,no_rep = srp(mon_ping)

                                avec rep : les paquets émis et leur réponse
                                et no_rep : les paquets dans réponse

                                Avec en-tête ethernet auto:

                                    >>> rep_no_rep = sr(mon_ping)

                            Pour n'avoir que la première réponse, on utilise srp1:

                                >>> rep = srp1(mon_ping)

                                idem avec en-tête ethernet automatique:

                                    >>> rep = sr(mon_ping)
                __________________________
                Sauvegarder un pcap:

                    >>> wrpcap('out.pcap', p)
                __________________________
                Visualiser un paquet:

                    >>> p.pdfdump('p_out.pdf')

~~~~~~~~~~~~~~~~~~~~~~~~~~
GUI
~~~~~~~~~~~~~~~~~~~~~~~~~~
    -------------------------
    Tkinter
    -------------------------

        http://apprendre-python.com/page-tkinter-interface-graphique-python-tutoriel

                Module permetant la création d'interfaces graphiques via la lib Tk
                On appel les méthodes de création d'objet graphique des widgets (boutons ...)
                Ces widgets sont définissable avec des options (couleur de fond ...)

                __________________________
                Importer Tkinter

                        Vérifier si Tkinter est installé:
                                python3.2 -m tkinter

                        Sinon sur debian
                                apt-get install python3-tk

                        from tkinter import *
                
                __________________________
                Création d'une fenêtre

                        windows = Tk()

                        Note: la fenêtre doit resté ouverte si l'on veut la modifier

                __________________________
                Les widgets:

                        Note: les widget prennent en argument la fenêtre dans lequel il odoivent apparaitre.
                        On affiche un widget via la méthode pack()

                        Créer du texte
                        ``````````````````````````
                                message = Label(windows, text="Hello World")

                        Bouton
                        ``````````````````````````
                                button = Button(windows, TEXT, COMMAND)

                                exemple:
                                        button = Button(windows, text="Quit", command=windows.quit)

                        Zone de saisie
                        ``````````````````````````
                                varInput = StringVar()
                                inputArea = Entry(windows, textvariable=varInput, width=XX)

                        Case à cocher
                        ``````````````````````````
                                varCase = IntVar()
                                case = Checkbutton(windows, text="Cochezi", variable=varCase)

                                Connaitre la valeur de la case:
                                        varCase.get()   -> 1=coché

                        Bouton radio (une seule case possible)
                        ``````````````````````````
                                varChoice = StringVar()

                                choice1 = Radiobutton(windows, text="choice1", variable=varChoice, value="1")
                                choice2 = Radiobutton(windows, text="choice2", variable=varChoice, value="2")

                        Liste déroulante
                        ``````````````````````````
                                list = Listbox(windows)
                                list.insert(END, "choice1")     #END: position d'insertion
                                list.insert(END, "choice2")

                                list.curselection()     #renvoie la position de la selection
                __________________________
                Modéliser/Afficher un objet/un widget:

                        monWidget.pack()

                        On peut choisir où le placer:

                                monWidget.pack(side="top", fill=X)
                                        X: remplissage en largeur
                                        Y: remplissage en hauteur
                                        BOTH : remplissage dans les deux sens
                __________________________
                Récupérer la valeur d'une variabel Tkinter:

                        maVariableTk.get()
                __________________________
                Dimensionner une fenêtre
                        
                        box = Frame(windows, width=XX, height=YY, borderwidth=N)
                        box.pack(fill=BOTH)

                        On pourra utiliser notre nouvelle fenêtre à la place de windows
                __________________________
                Un titre à sa fenêtre
                        
                        box = Labelframe(box, text="Titre fenêtre")
                __________________________
                Mettre en attente notre script jusqu'a fermeture de la fenêtre:

                        windows.mainloop()
                __________________________
                Détruire une fenêtre:

                        windows.destroy()
                __________________________
                Créer ses commandes:

                        Pour créer sa propre commande, on appel une méthode que l'on créer.

                        exemple:
                __________________________
                Scrollbar:

                    La scrollbar ne fonctionne pour le moment que sur les widgets text, listbox, canvas et entry.

                    http://effbot.org/tkinterbook/scrollbar.htm
                    http://effbot.org/zone/tkinter-scrollbar-patterns.htm
                    http://stackoverflow.com/questions/5860675/variable-size-list-of-checkboxes-in-standard-tkinter-package

                    exemple:
                        #########################
                        from Tkinter import *

                        master = Tk()

                        scrollbar = Scrollbar(master)
                        scrollbar.pack(side=RIGHT, fill=Y)

                        listbox = Listbox(master, yscrollcommand=scrollbar.set)
                        for i in range(1000):
                            listbox.insert(END, str(i))
                            listbox.pack(side=LEFT, fill=BOTH)

                        scrollbar.config(command=listbox.yview)

                        mainloop()
                        #########################

                    Une scrollbar pour une checkbox:
                        #########################
                        import Tkinter as tk

                        class Example(tk.Frame):
                            def __init__(self, root, *args, **kwargs):
                                tk.Frame.__init__(self, root, *args, **kwargs)
                                self.root = root

                                self.vsb = tk.Scrollbar(self, orient="vertical")
                                self.text = tk.Text(self, width=40, height=20, 
                                                    yscrollcommand=self.vsb.set)
                                self.vsb.config(command=self.text.yview)
                                self.vsb.pack(side="right", fill="y")
                                self.text.pack(side="left", fill="both", expand=True)

                                for i in range(1000):
                                    cb = tk.Checkbutton(self, text="checkbutton #%s" % i)
                                    self.text.window_create("end", window=cb)
                                    self.text.insert("end", "\n") # to force one checkbox per line

                        if __name__ == "__main__":
                            root = tk.Tk()
                            Example(root).pack(side="top", fill="both", expand=True)
                            root.mainloop()
                        #########################
                        
    -------------------------
    QT PyQt + Pyside
    -------------------------

        http://pyqt.developpez.com/tutoriels/
        http://tcuvelier.developpez.com/tutoriels/pyqt/qt-designer/#LII-C

        Pour des interfaces graphiques plus poussées.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Exporter un script (standalone)
~~~~~~~~~~~~~~~~~~~~~~~~~~

        -------------------------
        cx_Freeze
        -------------------------

            http://openclassrooms.com/courses/apprenez-a-programmer-en-python/distribuer-facilement-nos-programmes-python-avec-cx-freeze

            paquetiser un script python.

                __________________________
                Install:

                    Download:
                        http://cx-freeze.sourceforge.net/
                        https://pypi.python.org/pypi?:action=display&name=cx_Freeze&version=4.3.3

                    Via pip:

                        > sudo apt-get install python-dev libssl-dev
                        > pip install cx_Freeze

                    Via les sources:

                        > wget https://pypi.python.org/packages/source/c/cx_Freeze/cx_Freeze-4.3.3.tar.gz#md5=3cae24b98694540eb083ac500c0d4aa1
                        > tar -xvf cx_Freeze_version.tar.gz

                        > python setup.py build
                        > sudo python setup.py install

                        #en cas d'erreur pour les deux dernières commande, essayez:
                        > vim setup.py
                            - if not vars.get("Py_ENABLE_SHARED", 0):
                            + If True:

                Tester:
                    > cxfreeze


                __________________________
                Paquetiser:

                        Rapidement:
                        ``````````````````````````
                            > cxfreeze monScript.py

                            Sous linux, cela creera un dossier 'dist' avec notre executable.

                        Avec setup.py
                        ``````````````````````````

                            > vim setup.py

                                #########################
                                """Fichier d'installation du script foo.py"""

                                from cx_Freeze import setup, Executable

                                # Appel de la méthode setup:
                                setup(
                                    name = "foo",
                                    version = "0.1",
                                    description = "ma description",
                                    executables = [Executable("foo.py")],
                                )
                                #########################

                            Un dossier dist est maintenant disponible.

                            Builder:

                                > python setup.py build

                                Un dossier exe... est maintenant disponible.

        -------------------------
        py2exe
        -------------------------
            Exporter un script en binaire windows.

            http://www.py2exe.org/

~~~~~~~~~~~~~~~~~~~~~~~~~~
Parallèlisation
~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Note, 
        La difference entre le threading et le processing se fait surtout au niveau de l'espace mémoire.
        Les process sont 'étanches' et utilisent un espace mémoire différent. (+ performant sur du multi CPU)
        Les thread partages le même espace mémoire mais se spawn plus rapidement.

        Voir: http://stackoverflow.com/questions/3044580/multiprocessing-vs-threading-python


        -------------------------
        Multi-threading
        -------------------------

            import threading

        -------------------------
        Multi-processing
        -------------------------

            http://pymotw.com/2/multiprocessing/basics.html

            Note: (le processus n'est pas lancé en background)

            Exemple simple:

                import multiprocessing
                import time

                def worker(num):
                    """thread worker function"""
                    time.sleep(2)
                    print 'Worker:', num
                    return

                if __name__ == '__main__':
                    jobs = []
                    for i in range(5):
                        p = multiprocessing.Process(target=worker, args=(i,))
                        jobs.append(p)
                        p.start()

                print 'all my worker work'

            /!\: ne pas quitter le programme avec un sys.exit() en dehors du main (si vous bossez sous windows)

        -------------------------
        Forking
        -------------------------

            import os

        -------------------------
        Parallèle processing
        -------------------------

            voir anaconda

        
~~~~~~~~~~~~~~~~~~~~~~~~~~
DAEMON (Linux)
~~~~~~~~~~~~~~~~~~~~~~~~~~
    Sources: http://code-weblog.com/creer-une-application-serveur-de-type-demon-en-python/
    http://code.activestate.com/recipes/278731-creating-a-daemon-the-python-way/

    On créer un processus enfant à l'aide d'un fork puis on kill le parent pour ratacher l'enfant à init.(pid =1)
    Enfin on définit un nouveau sid (session identifier) pour détacher le processus de la session utilisateur.
    Sinon ce dernier s'arreterai si on ferme la session user.

    Note: la technique du double fork permet de se prévenir de l'état de zombies.
        En effet le premier enfant est un 'leader de session' et peut être contrôler par un terminal.
        On utilisera donc cette méthode.


        -------------------------
        Module:
        -------------------------

            ****************************
            import sys, os, time, atexit
            from signal import SIGTERM

            class Daemon:
                """
                A generic daemon class.
               
                Usage: subclass the Daemon class and override the run() method
                """
                def __init__(self, pidfile, stdin='/dev/null', stdout='/dev/null', stderr='/dev/null'):
                    self.stdin = stdin
                    self.stdout = stdout
                    self.stderr = stderr
                    self.pidfile = pidfile
                    self.forkno = 1

                def daemonize(self):
                    """
                    do the UNIX double-fork magic, see Stevens' "Advanced
                    Programming in the UNIX Environment" for details (ISBN 0201563177)
                    http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC16
                    """

                    self.fork()
               
                    # decouple from parent environment
                    os.chdir("/")
                    os.setsid()
                    os.umask(0)
               
                    # do second fork
                    self.fork()
               
                    # redirect standard file descriptors
                    sys.stdout.flush()
                    sys.stderr.flush()
                    si = file(self.stdin, 'r')
                    so = file(self.stdout, 'a+')
                    se = file(self.stderr, 'a+', 0)
                    os.dup2(si.fileno(), sys.stdin.fileno())
                    os.dup2(so.fileno(), sys.stdout.fileno())
                    os.dup2(se.fileno(), sys.stderr.fileno())
               
                    # write pidfile
                    atexit.register(self.delpid)
                    pid = str(os.getpid())
                    file(self.pidfile,'w+').write("%s\n" % pid)

                def fork(self):
                    """
                    Make child process with fork method
                    """

                    try:
                        pid = os.fork()
                        if pid > 0:
                            # exit parent
                            sys.exit(0)
                    except OSError, e:
                        sys.stderr.write("fork #%d failed: %d (%s)\n" % (self.forkno, e.errno, e.strerror))
                        sys.exit(1)

                    self.forkno += 1
               
                def delpid(self):
                    os.remove(self.pidfile)

                def start(self):
                    """
                    Start the daemon
                    """
                    # Check for a pidfile to see if the daemon already runs
                    try:
                        pf = file(self.pidfile,'r')
                        pid = int(pf.read().strip())
                        pf.close()
                    except IOError:
                        pid = None
               
                    if pid:
                        message = "pidfile %s already exist. Daemon already running?\n"
                        sys.stderr.write(message % self.pidfile)
                        sys.exit(1)
                   
                    # Start the daemon
                    self.daemonize()
                    self.run()

                def stop(self):
                    """
                    Stop the daemon
                    """
                    # Get the pid from the pidfile
                    try:
                        pf = file(self.pidfile,'r')
                        pid = int(pf.read().strip())
                        pf.close()
                    except IOError:
                        pid = None
               
                    if not pid:
                        message = "pidfile %s does not exist. Daemon not running?\n"
                        sys.stderr.write(message % self.pidfile)
                        return # not an error in a restart

                    # Try killing the daemon process    
                    try:
                        while 1:
                            os.kill(pid, SIGTERM)
                            time.sleep(0.1)
                    except OSError, err:
                        err = str(err)
                        if err.find("No such process") > 0:
                            if os.path.exists(self.pidfile):
                                os.remove(self.pidfile)
                        else:
                            print str(err)
                            sys.exit(1)

                def restart(self):
                    """
                    Restart the daemon
                    """
                    self.stop()
                    self.start()

                def run(self):
                    """
                    You should override this method when you subclass Daemon. It will be called after the process has been
                    daemonized by start() or restart().
                    """

                def status(self):
                    """
                    Get the status
                    """
                    if os.path.exists(self.pidfile):
                        try:
                            pf = file(self.pidfile, 'r')
                            pid = int(pf.read().strip())
                            pf.close()
                           
                            message = "Daemon is running with pid=%s\n"
                            sys.stdout.write(message % pid)
                        except IOError:
                            pid = None
                            message = "Daemond is running (but can't read the pid file)\n"
                            sys.stderr.write(message % self.pidfile)
                    else:
                        pid = None
                        message = "Daemon is not running\n"
                        sys.stdout.write(message)
                    return pid
            ****************************

~~~~~~~~~~~~~~~~~~~~~~~~~~
FORK
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Pour foker un processus, c'est à dire créer un enfant pour exécuter plusieurs tâches simultanément, on utilise le module os avec la méthode fork:


        -------------------------
        Un fork basic
        -------------------------
            ****************************
            import os, time

            def child():
                print 'I am in pid ', os.getpid()
                os._exit(0)

            def parent():
                for l in ['a', 'b', 'c', 'd']:
                    print '----------- %s --------" % (l)

                    #Création d'un sous processus (on parallélise le bloc courant)
                    print 'fork:'
                    newpid = os.fork()

                    if newpid == 0:
                        #On rentre dans le sous process enfant:
                        child()
                    else:
                        #On reste au niveau du processus parent:
                        pids = (os.getpid(), newpid)
                        print "parent: %d, child: %d" % pids
            ****************************

            Note, le pid 0 correspond bien au sous processus.
            Le pid de l'enfant est envoyé au parent.
            

~~~~~~~~~~~~~~~~~~~~~~~~~~
Documentez vos scripts
~~~~~~~~~~~~~~~~~~~~~~~~~~

        -------------------------
        DocStrings et mdown
        -------------------------

            Générer vos Docstrings en markdown

                TODO

        -------------------------
        Docopt : parser automatiquement les options via la docString
        -------------------------

            BIG TODO

~~~~~~~~~~~~~~~~~~~~~~~~~~
TODO
~~~~~~~~~~~~~~~~~~~~~~~~~~

    logging : +définir bonnes pratiques de loglevel (CONSOLE + FICHIER : niveau: debug / erreur ...)
    multiprocessing : todo rajouter les info
    os : daemon : en cours
    service windows
