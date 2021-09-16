=====================================================================
			S C R I P T    B A S H
=====================================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

http://abs.traduc.org/abs-5.0-fr/index.html
http://wiki.linuxquestions.org/wiki/Bash_tips
http://wiki.bash-hackers.org/scripting/posparams
http://abs.traduc.org/abs-5.3-fr

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Commencer un script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Indiquer le shell à utiliser :

#!/bin/bash (-x pour afficher avoir une description lors de l'exec du script)

on peut executer un script avec différentes options:

	-xv : pour exécuter en mode debug.
	_____________________
	bash : bash est un interpréteur de commande qui execute les commandes lues depuis l'entrée standard ou un fichier.

		-xv : pour exécuter en mode debug.

        Configurer son bash.

	_____________________
    options (set) :

        Il est possile de configurer les options de son shell et donc d'interprétation du script grâce à set :

        Exemple :

            set -o nounset : traiter les variables non définies comme une erreur.
            set -o pipefail : todo
            set -o errexit
            set -o xtrace

        Some options :

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
autocompletion
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Voir : complete/compgen

        https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
        http://tldp.org/LDP/abs/html/tabexpansion.html

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Commentaires
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    # sur une seule ligne

    : '
    Sur plusieurs
    lignes
    '

    Note :


        Le ':' est un équivalent à NOP, c'est à dire no op, ne rien faire.
        Il est du même ordre que true, et retourne true (0) comme status lors d'un exit.

    ou

    <<COMMENT
    Sur plusieurs
    lignes
    COMMENT

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Les variables en bash ne sont pas(ou peu) typés.
Le bash possède des mécanismes particuliers d'évaluation d'expression pour placer les variables dans le bon "contexte" (arithmétique ...)

Règles:
	-Le premier caractère ne doit pas être un nombre
	-Eviter d'utiliser des majuscules pour ne pas confondre les variables user des variables system.

	-----------------------------------------
	chaînes && Opérations
	-----------------------------------------

		variable="texte qui prend en compte les valeurs des $variables"
		variable='texte sans prise en compte des valeurs des $variables'
		variable=`commande` ou
		variable=$(commande)   #plus adapté

		________________________
		#longueur d'une chaîne

		${#<variable>}  : donne la longueur de la chaine contenu dans la variable:

			exemple:
				> string="hello"
				> echo "Longueur de $string : ${#string}"

                todo : voir http://abs.traduc.org/abs-5.0-fr/ch09s02.html

	-----------------------------------------
	Arithmétique && Opérations
	-----------------------------------------
		_________________________
		#opérateurs

			+ - * / : Opérations simples
			% : modulo
			< > <= >= : comparaisons
			== != : Egal ou différent
			&& || : Comparaisons liées par un opérateur logique
			& | ^ : Logique binaire AND OR XOR

		_________________________
		#let:

			let "a = nombre"
			let "b = nombre"
			let "c = a + b"

		_________________________
		#bc: (plus pratique pour les nombres à virgules)

			variable=$( echo "x/y" | bc -l)

		_________________________
		#calcul bash (double parenthèse)

			result=$((x + y))

		_________________________
		#expr
			On peut utiliser la commande expr pour effectuer des calculs, des comparaisons et de la recherche dans les chaînes de texte.

i			exemples:

				expr X + Y
				expr $variable - 5
				result=$(expr $value1 - $value2)
				...

	-----------------------------------------
	Variable null
	-----------------------------------------


		variable=
		unset variable : donne une valeur null

	(= 0 dans les opétation arithmétiques)
	ou (= chaine vide)

	-----------------------------------------
	Exporter une variable
	-----------------------------------------

		Pour la rendre accessible aux sous-shell et autres scripts:

		export $variable

		Voir memo_commandes pour plus de details

	-----------------------------------------
	Tableaux et champs
	-----------------------------------------

                Links:
                        http://wiki.bash-hackers.org/syntax/arrays
                        http://abs.traduc.org/abs-5.0-fr/ch26.html

		(de 0 à 1023 élements)

		_________________________
		#Déclaration :


           Déclarer un tableau indéxé:

                declare -a array

           Initialiser un tableau:

                array=()
                array=[0]

           Remplir un tableau:

                array=('valeur0' 'valeur1' 'valeur2')
                array[X]="contents" : affecte le contenu "contents" au Xième élement du tableau.
                array=([X]='valeurX' [Y]='valeurY')

           Ajouter à la fin d'un tableau:

                array+=(value1 value2)

		_________________________
		#Affichage

                       Afficher une valeur:

			   echo ${array[2]}  #affiche la 3ième valeur du tableau

                       Afficher tout les éléments d'un tableau:

			   echo ${array[*]}
                           echo ${array[@]}

                       Afficher l'indexe:

                           echo ${!array[*]}
                           echo ${!array[@}}

                       Afficher le nombre d'éléments:

			   echo ${#array[*]}
                           echo ${#array[@]}

                       Afficher certain éléments:

                           echo ${array[@]:2}   : afficher à partie du 2° élement
                           echo ${array[@]:2:4} : afficher 4 élements à partir du 2°.

                       Variables:

			   Si l'on veut mettre une variable à la place d'un chiffre, il ne faut pas mettre le $ devant le nom de la variable.

			   echo ${array[variable]}

                           ou bien la séparer avec les accolades:

                           echo ${array[${variable}]}

		_________________________
        #tableau associatif (ou hash)

            Il sert de tableau de hash mais aussi pour les tableaux multi-dimension

            Déclarer le tableau:

                    > declare -A array

            Définir un couple clé valeur:

                    > array["key"]=value
                     ou
                    > array=([key1]=value1 [key2]=value2)

            Pusher dans un tableau associatif:

                    array+=([key1]=value1 [key2]=value2)

            Accéder à un élément en particulier

                    > echo ${array["key"]}

            Parcourir le tableau de hash:

                    for elem in ${!array[*]}
                    do
                            echo "key: $elem"
                            echo "value: ${array[${elem}]}"
                    done

            Supprimer un tableau:

                    > unset array

            Exemple tableau 2 dimmensions:

                    > declare -A array
                    > tab[0:0]=A
                    > tab[0:1]=B
                    > tab[1:0]=C
                    > tab[1:1]=D


	-----------------------------------------
	Typer une variable
	-----------------------------------------

        declare ou typeset

        On peut typer une variable soit par la commande declare ou typeset

        Il est possible de typer une variable en "entier" (integer) grace à la commande typeset - i .
        Il est alors possible d'effectuer des opération sans passer par des expressions comme let, ((...)).

        Exemple :

            > typeset -i variable
            > variable=2*4
            > echo $variable
            #Affichera : 8


		Il y a bien sur plus de possibilité pour typeset:

			declare -ir BASHPID
			declare -ir EUID="1000"
			declare -i HISTCMD
			declare -i LINENO
			declare -i MAILCHECK="60"
			declare -i OPTIND="1"
			declare -ir PPID="1873"
			declare -i RANDOM
			declare -ir UID="1000"
			declare -i long

    -----------------------------------------
    Environnement :
    -----------------------------------------

        Voir les variables de son environnement (variables user et system) :

            > env

        Permet de redéfinir l'environnement du processus à lancer en lui envoyant la valeur des variables définient en arguments.

            > env var1=XX var2=YY commande


	-----------------------------------------
	Supprimer une variable:
	-----------------------------------------

		   unset <variable> : supprime la variable

	-----------------------------------------
	Protéger une variable:
	-----------------------------------------

        Rendre une variable en lecture seule :


		   readonly <variable>

               la variable ne pourra pas être supprimée ou changée

        Rendre une variable accessible uniquement localement à sa définition :

            declare local maVariable="foo"

                La variable ne sera accessible que dans la fonction dans laquelle elle a été définie.
                Dans l'autre cas, elle ne sera pas accessible par les autres fonctions.

        On peut aussi par exemple protéger le source d'un fichier grâce à cette méthode :

            [[ ${MODULE_NAME:-} -eq 1 ]] && return || readonly MODULE_NAME=1

            Cela permet de s'assure que la variable ne sera déclarée qu'une fois.


	-----------------------------------------
	Identifier le nom d'une variable
	-----------------------------------------

		Les accolades permettent d'identifier le nom d'un variable:
		exemple:

			> variable="file_name"
			> cp ${variable}1 ${variable}2
				--> cp file_name1 file_name2


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Traitement des arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-----------------------------------------
	Paramètres de position
	-----------------------------------------



		$# : contient le nombre de paramètres
		$0 : contient le nom du script
		$@ : contient la concaténation de tous les paramètres distinct séparés par un espace ("$1" "$2" "$3" ...)
                $1 à $n : contient les valeurs des arguments
		$* : Liste tout les paramètres au format "$1 $2 $3 ..."

                ${@:START:COUNT} : concatène à partir de START, COUNT élements
                ${*:START:COUNT} : concatène à partir de START, COUNT élements

                        exemple:
                                ${@:2} : concatène à partir de l'indice 2
                                ${@:5:3} : concatène à partir de l'indice 5, les 3 éléments
                                ${@: -1} : conatène à partir du dernier élément

		shift #décale les parametres de +1 ($1 = $2 ...)
			shift n : décale de n éléments

                ${!variable_n} : affiche l'argument d'indice $variable_n

	-----------------------------------------
	Code de sortie
	-----------------------------------------

		$? : renvoie le code de sortie de la derniere commande executée.

	-----------------------------------------
	Identifiant du processus
	-----------------------------------------

		$$ : renvoie le PID du script executé (processus courant)
		$! : renvoie le PID du processus fils

	-----------------------------------------
	Redéfinir les arguments/paramètres
	-----------------------------------------

		> set value1 value2 ...

			(value1 = $1 ...)

	-----------------------------------------
	Exemple:
	-----------------------------------------

        range_except_last=${@:1:$(($# - 1 ))}

        last=${@: -1}
        #or

        last=${!#}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Afficher un message
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-----------------------------------------
	Simple message:
	-----------------------------------------

        > echo "message à afficher"
        > printf "hello \n"  #pour les inconditionnels

	-----------------------------------------
	Retour à la ligne '\n'
	-----------------------------------------
		> echo -e "Message\navec des retour\nà la ligne"

	-----------------------------------------
	Tabulation '\t'
	-----------------------------------------
		>echo -e "\tUne tabulation"

	-----------------------------------------
	Supprimer le saut de la ligne final '\c'
	-----------------------------------------
		>echo -e "il n'y aura pas de retour à la ligne\c"

	-----------------------------------------
	Supprime un caractère en arrière
	-----------------------------------------
		>echo -e "hollo\ba, deviendra hella!"

	-----------------------------------------
	Compacter (supprimer les espaces)
	-----------------------------------------
		>echo -n "supprime les espaces"

	-----------------------------------------
	Afficher une variable
	-----------------------------------------

		> echo $variable    #(ne preserve pas les espace)
		> echo "$variable"  #(preserve les espaces)


	-----------------------------------------
	Afficher une plage de nombre/lettres (Expansions étendues)
	-----------------------------------------

		> echo {1..10}
		> echo {a..z}

                Note seq peut être aussi utilisé pour afficher une plage de nombre mais l'affichage ne sera pas la sortie ne sera pas formaté de la même façon.

                > seq 1 10

	-----------------------------------------
	Filtrer l'affichage
	-----------------------------------------

        echo ${variable% *} : affiche tout les mots sauf le dernier.
        echo ${variable#*} : à voir ...

	-----------------------------------------
	Afficher ave cat :
	-----------------------------------------

        cat <<EOF
            blabla
        EOF

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Saisir du texte
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	read variable (variable2 variable3 ...)
		echo $variable ($variable2 $variable3 ...)

	read -p "texte à afficher" variable
		echo $variable

	read -p 'test' -n X variable   #Limite le nombre de caractères
			-t X variable  #Limite le tps autorisé pour la saisie
			-s variable    #Ne pas afficher la saisie


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Echappement
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

\ : pour échapper un caractère, un nom de variable ...

exemples:
	variable=chaine\ sans\ guillemets\ avec\ des\ espaces

	echo "\$nom_var affichera le \"nom\" de la variable mais pas son contenu"


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Substitution
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://www.tldp.org/LDP/abs/html/parameter-substitution.html

    enlever de gauche à droite:

        ${PWD##*/}      #s'arretra au dernier élement trouvé
        ${PWD#*/}       #s'arretra au premier élement trouvé

    enlever de droite à gauche

        ${archive.tar.gz%%.*}  #s'arretra au dernier élement trouvé
        ${archive.tar.gz%.*}  #s'arretra au dernier élement trouvé

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Remplacement conditionnel {}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Les accolades offrent une syntaxe particulière permettant d'éffectuer des remplacements:

		{variable:remplacement}

		Les remplacements:

		{<variable>:-<chaine>} : si x vide ou inexistant, y le remplacera.
		{<variable>:=<chaine>} : si x vide ou inexistant, y le remplacera et deviendra la valeur de la variable
		{<variable>:+<chaine>} : si x définie et non vide, y le remplacera
		{<variable>:?<chaine>} : si x vide ou inexistant, le script sera interrompu et le message y s'affiche. Si y non définie, un message d'erreur standard est affiché


		exemples:

			> name=paul
			> new_name=${name:-juliette}
			> echo $new_name 			#--> paul
			>
			> unset name
			> new_name=${name:-juliette}
			> echo $new_name 			#--> juliette
			> echo $name				#-->
			>
			> echo ${name:=paul}		#--> paul
			> echo $name 				#--> paul
			>
			> echo ${name:+juliette}		#--> juliette
			> echo $name				#--> paul
			>
			> unset name
			> echo ${name:?nom inexistant}	#-->name: nom inexistant

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Groupement de commandes ()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Le groupement de commandes avec des parenthèses () permet d'éxécuter des commandes à l'intérieur d'un sous-shell.
	Les variables présentes dans ce groupement ne seront pas visibles par le processus parent.

		On pourrait bien voir la chose en executant:

		> top &
		> jobs      # ---> [1]+  Running                 top &
		> ( jobs )  # ---> RIEN car jobs affiche les processus ratachés au shell courant.
			    # Dans ce dernier cas jobs est éxécuté dans un shell fils, et ne comporte pas de processus en background.

		Ou encore:

		> a="bonjour"
		> ( a="aurevoir" )
		> echo $a
		> #	bonjour

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Expansion d'accolades
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Ce mécanisme permet de définir plusieurs possibilités pour un même nom:
	Attention à ne pas mettre d'espace dans les accolafes, sinon les échapper.

	exemples:

		> touch fichier{a,b,c}
			#	créer: fichiera fichierb fichierc

		> touch fichier{a..z}
			#	créer: fichiera ... fichierz

		> cp images.{jpg,png} Pictures/
			#	Copiera toute les images png et jpg dans Pictures

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Groupement de commandes {}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Le groupement de commandes avec des accolades {} permet d'éxécuter une suite de commande dans le shell courant. il faut par contre faire attention à bien mettre des ";" après chaque commandes:

	>	{ cd /somewhere ; mkdir foo ; }

	Aussi l'intérêt peut être de rediriger toute les sortie standard vers un fichier:

	>	{
	>		commandes ...
	>	} > /tmp/$fichier


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les conditions && tests
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-----------------------------------------
	Commande test
	-----------------------------------------

	$test : permet d'effectuer des tests de conditions
		Le résultat est récupérable par la variable $?
		si $? = 0 : alors la condition est vrai.

		-a : and
		-o : or
		! : not
		(...) : groupement de combinaison. Les parenthèses doivent être vérouillées \(...\)

		exemple:
			test -z "variable"
			echo $?
				si la variable est vide $? = 0

		test peut être remplacé par les crochets ouverts et fermé:
			[ ... ]
			Il faut respécter l'espace avant et après les crochets.

		Une autre syntaxe peut être utilisée: [[ ]]

			Les doubles crochets permettent d'assouplir l'interprétation du test et apporte des éléments d'interprétation plus "logique".
			Cette syntaxe est à préviligié car elle est plus récente et peut résoudre pas mal de bug.

				-Evaluation arithmétique des constantes octales et hexa
				-Evaluation des opérateurs logiques && || < et >
				-Permet de reconnaître l'opérateur =~ pour les Regex.
				-Autocomplétion des variables ... (évite de mettre des "")

			La syntaxe des doubles crochets apporte donc beaucoup plus de soupless:

		Note: il est possible d'enchainer les test dans des simple corchets avec -o (OU) et -a (AND)


		exemple de comparaison:

			[ ]				vs		[[ ]]

		[ "$coucou" == "coucou" ]		vs	[[ $coucou == "coucou" ]]
		[ "$a" == "$a" -a "$b" == "$b" ]	vs 	[[ $a == $a && $a == $a ]]
		[ "$a" =~ regex ] 	#impossible	vs 	[[ $a =~ regex ]]
		[ "0x0f" -eq "15" ] 	#faut		vs	[[ "0x0f" -eq "15" ]] #vrai


	-----------------------------------------
	IF
	-----------------------------------------
		if [ my_test ]   # (ou if [ my_test ]; then ... fi)
		then
			echo "premier test vrai"
		elif [ my_test2 ]
		then
			echo "deuxieme test vrai"
		else
			echo "c'est faut"
		fi

	-----------------------------------------
	Un test sur une seule ligne
	-----------------------------------------

        Exemple :

        Si le message retour précedent est égal à 0, alors le message_retour sera égal à la variable $msg_ok sinon égal à la variable $msg_ok

        ((message_retour=($?==0)?${msg_ok}:${msg_nok}))

	-----------------------------------------
	Avec une variable :
	-----------------------------------------
		if [ $variable = "moi" ]; then ... fi

	-----------------------------------------
	Plusieurs tests:
	-----------------------------------------
		&& : "et"	#if [ ... ] && [ ... ]
		|| : "ou"	#if [ ... ] || [ ... ]

			exemples:

			 [ ] && echo "hello" 	=> vide
			 [ 1 ] && echo "hello" 	=> hello

			 [ ] || echo "hello"	=> hello
			 [ 1 ] || echo "hello"	=> vide

	-----------------------------------------
	Tests sur chaînes
	-----------------------------------------
		$chaine1 = $chaine2	#chaines egales
		$chaine1 != $chaine2	#chaines différentes
		-z $chaine		#chaine vide
		-n $chaine		#chaine pleine

	-----------------------------------------
	Tests sur nombres
	-----------------------------------------
		$num1 -eq $num2		#equal (=)
		$num1 -ne $num2		#non equal (!=)
		$num1 -lt $num2		#lower than (<)
		$num1 -le $num2		#lower or equal (<=)
		$num1 -gt $num2		#greater than (>)
		$num1 -ge $num2		#greater or equal (>=)

	-----------------------------------------
	Tests sur fichiers
	-----------------------------------------
		-e $filename	#file exist
		-d $filename	#folder
		-f $filename	#file ordinaire
		-L $filename	#Lien symbolique
		-r $filename	#file lisible
		-w $filename	#file modifiable
		-x $filename	#file éxecutable
		-s $filename	#file size > 0
		-b $filename	#périphérique type bloc (lecteu cd, disquette, ...)
		-C $filename 	#périphérique de type caractère (clavier, modem, carte son, ...)
		-u $filename	#file existe, SUID-Bit positionné.
		-g $filename	#file existe, SGID-Bit positionné

		$file -nt $file2	#newer than (fichier plus récent que)
		$file -ot $file2	#older than (fichier plus vieux que)
		$file -ef $file2	#sont ils des liens physiques vers le même fichier?

	-----------------------------------------
	Inverser un test !
	-----------------------------------------

		if [ ! -e file ]; then ... fi  #Si le fichier n'existe pas


	-----------------------------------------
	Case
	-----------------------------------------

		_________________________
		Syntaxe:

			case valeur in
				modele1) commandes ;;
				modele2) commandes ;;
				*) default_action ;;
			esac

			Le modèle peut être composé de caractères spéciaux:
				* : châine variable
				? : un seul caractère
				[...] : Une plage de caractères
				[!...] : négation de la plage de caractère
				| : OR

		_________________________
		Exemple:

			case $variable in
				"valeur1")
					echo "equation tend vers -oo"
					;;
				"valeur2")
					echo "equation tend vers +oo"
					;;
				"valeur3" | "valeur4" | "valeur5")	#valeur3 ou valeur4 ...
					echo "equation tend vers 0"
					;;
				*)
					echo "wrong equation !!"
					;;
			esac

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Les boucles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-----------------------------------------
	While
	-----------------------------------------

		_________________________
		#Syntaxe

			while condition
			do
				commandes
			done

		ou:

			while
				bloc d'instructions
			do
				commandes
			done

		_________________________
		Exemples:

			while [ test ] || [ test2 ]
			do
				something
			done

		ou:

			while
				read nom
				[ -z "$nom" ]
			do
				echo "erreur, entrer un nom"
			done


		_________________________
		Lecture d'un fichier ligne à ligne:

			cat fichier.txt | while read line
			do
				echo $line
			done

			(Dans ce cas la boulce est exécutée dans un second processus. Toutes les variables modifiées dans cette boucle perdra sa valeur en sortie.
		ou

			while read line
			do
				echo $line
			done < fichier.txt

	-----------------------------------------
	For
	-----------------------------------------
		_________________________
		#boucle liste implicite

			for params
			do
				echpo "$param"
			done
		_________________________
		#boucle sur des valeurs : liste explicite

			for variable in 'valeur1' 'valeur2 'valeur3'...
			do
				echo "variable vaut $variable"
			done
		_________________________
		#boucle sur une commande (liste de valeurs)

			for fichier in $(ls)
			do
				echo "Fichier trouvé : $fichier"
			done
		_________________________
		#boucle incrémentation

			for variable in $(seq X Y)	#boucle de X à Y
			do
				echo $variable
			done

		_________________________
		#boucle avec critère de recherche
			Si des éléments de la liste correspond à un fichier ou à un motif de fichiers présents à la position actuelle de l'arborescence, la boucle for considère l'élément comme un nom de fichier.

			for fichier in *
			do
				echo $fichier
			done

	-----------------------------------------
	Until
	-----------------------------------------

		Dès que la condition est réalisée, on sort de la boucle.

		until condition
		do
			commandes
		done

	ou

		until
			bloc d'instructions
		do
			commandes
		done

	-----------------------------------------
	Interrompre/relancer une boucle
	-----------------------------------------

		_________________________
		break : permet d'intérompre une boucle et de continuer le script au done suivant.
			break n : permet de sauter n boucles.

		_________________________
		continue : permet de relancer une boucle
			continue n : permet de remonter n boucles.

	-----------------------------------------
	Incrémentation
	-----------------------------------------

		((i+=1))


	-----------------------------------------
	Select
	-----------------------------------------

		Permet de créer un menu simple.
		La variable PS3 affiche un message au niveau de la saisie.
		Si la valeur saisie est incorrecte, le menu d'affiche de nouveau.
		Nécessite un break pour arrêter un select.

		_________________________
		Syntaxe:

			select variable in liste_contenu
			do
				traitement
			done


		_________________________
		Exemples :

			PS3="Your choice: "
			select answer in truc much nuch luch quit
			do
				if [ "$answer" == "quit" ]
				then
					break
				fi
			done

            #An other one :

                PS3="Beverage : "
                choices="coffee tea watter pass"

                select answer in $choices
                do
                    case $answer in
                        coffee)
                            echo "Success !"
                            break
                            ;;
                        pass)
                            break ;;
                        esac
                done


	-----------------------------------------
	Manipulation spéciale:
	-----------------------------------------

		_________________________
		Récupérer la valeur des arguments du script

		On peut être amener à boucler sur une variable de type numérique et récupérer l'argument correspondant à cette valeur:

			Pour ce faire il faut utiliser cette syntaxe: ${!VARIABLE}

			exemple:
			>	for num in $(seq 1 10)
			>	do
			>		echo ${!num}
			>	done

			Cette exemple affichera la valeur de $1, $2 ...

		_________________________
		Récupérer la valeur d'une variable grâce à l'incrémentation:


		Lorsqu'on dispose d'une variable identifiée par un indice, on peut souhaité de parcourir les différentes valeurs de celle-ci:


			exemple:
			>	pc1="10.10.10.10"
			>	pc2="10.12.12.12"
			>	pc3="45.45.45.45"
			>
			>	for nb in $(seq 1 2)
			>	do
			>		variable=pc${nb}
			>		pc=${!variable}
			>		echo "$variable contains $pc"
			>	done

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Caractères spéciaux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 ":"  -> commande null (=0) peut être assimilié à true

exemple d'utilisation:
	if condition
	then :  # Ne rien faire et continuer
	fi

	while :  # identique à while true
	do
	  opérations
	done

":" placé en début de ligne suivie d'une commande:

	: commande  #Exécuter la commande et ses arguments mais ne fait rien (retourne toujours 0)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Générer un chiffre alétoire
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	${RANDOM}


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Insérer une commande dans une variable:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	path=/tmp/ftp_$(basename $path2).xml


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Tester Si une Variable est numérique:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

var=$1
	if [ "$(echo $var | grep "^[ [:digit:] ]*$")" ]
	then
 		echo "La chaîne est numérique"
	fi

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Sortir d'un code
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Le code de sortie permet de renvoyer une valeur disponible pour le processus parent du script.
0 = ok
1-255 = erreur

exit : quitte le programme et renvoie le code de sortie de la derniere commande

équivaut à exit $? ou même en omettant le exit.
	$? : correspond au code de sortie de la derniere commande.

exit <Nombre compris entre 0 et 255> : renvoie le code de sortie indiqué

	_________________________
	Inverser le résultat de la sortie avec true et false

		exemple:
			echo $?  #0
			false
			echo $?  #1
			true
			echo $?  #0

		(true = 0
		false = 1)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ecrire une Erreur
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Afin de coder proprement,

	Il faudrait rediriger les erreurs vers le canal d'erreur standard:

		> echo "erreur" >&2

	Voir la partie flux de redirection dans le memo_commandes_linux



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Fonctions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Les fonctions suivent les mêmes règles que les variables mais ne peuvent être exportées.


	_________________________
	Dans un fichier:

		Il est possible de mettre ses fonctions dans un fichier.
		Pour charger le contenu de se fichier.
			. filename

		Le point suivi d'un nom de fichier charge son contenu, (fonctions et variables), dans l'environnement courant.

	_________________________
	Structure / Déclaration :

		nom_fonction()
		{
			commandes

			echo "premier param: $1"
			echo "deuxième param: $2"

			return XX  #si on veut affecter une valeur de retour à la fonction
		}

        Une fonction peut être aussi définie via le mot clé function :

        function maFonction()
        {
            ...
        }

	_________________________
	Appeler une fonction:

		nom_fonction
		nom_fonction "param1" "param2" "param3"

	_________________________
	Récupérer le nom d'une fonction:

		echo $FUNCNAME



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
traitement des signaux avec la commande trap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(voir memo_commandes_linux : processus)

	trap " signaux : Ignorer les signaux
	trap commandes signaux : Execution des commandes pour chaque signal reçu.
	trap signaux : Restaure les actions par défaut des signaux.

	_________________________
	Exemple:

		bye ()
		{
			exit 0
		}

		trap '' 2 #Empêche l'éxécution du Ctrl+C (SIINT)
		trap bye 15 #Nécéssite d'utiliser kill -15 PID pour quitter


	_________________________
	Sortir d'un script avec CTRL+C (même dans une boucle)

	>	trap "exit" SIGINT SIGTERM


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SEPARATEUR DE FIN DE LIGNE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Parfois lorsqu'on veux afficher dans une boucle les lignes d'un fichier, une par une, il est nécessaire de changer la variable $IFS qui indique le séparateur de ligne.

exemple:
	IFS_old=$IFS    #sauvegarde l'ancien état de $IFS
	IFS=$'\n'	#nouveau caractère de fin de ligne
	ou encore:
	IFS=' '		#Pour considérer le saut de ligne comme un espace
        IFS=''          #Pour reconsidérer le caractère de fin

	for line in $(cat file)
	do
		echo $line
	done

	IFS=$IFS_old	#remet l'ancien séparateur

        exemple:
                #On souhaite enregistrer dans une variable chaque ligne.
                #Puis insérer chaque mot dans un tableau:

                |       IFS=$'\n'
                |       for line in $(cat file)
                |       do
                |               IFS=' '
                |               array=($(echo $line))
                |       done

        Note:
                évitez les tabulations dans vos fichier, mettez des espaces à la place ;) (configurer votre éditeur)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Session ssh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Pour executer des commandes sur un serveur distant en ssh:
    (Si rien ne s'affiche il faut simplement scroller vers le haut!)

        ssh host <<EOF
        cmd1 ;
        cmd2 ;
        ... ;
        exit
        EOF

    #ou fonctionne avec des guillemets (on ne verra pas les commandes executées):
        ssh host "
        ... ;
        "

    Si une erreur de type "stind is not a terminal",
     rajouter l'option "-t -t" (ssh -t -t host ...)

    Si on fait des manipulation avec des variables, il faut échaper le $ : \$ .
    Caractères à échapper dans une session SSH (tout ce qui peut être mal interprété!):
        | \ | $ | ' | " |

    Si l'on souhaite executer une fonction via ssh :

        http://stackoverflow.com/questions/22107610/shell-script-run-function-from-script-over-ssh

        typeset -f | ssh user@host "$(cat);f"
        ou
        ssh user@host "$(typeset -f); f"

        typeset -f affiche les fonctions définies dans le script, cat reçoit l'output sous forme de texte et $() permet son execution.

        Par contre cette méthode nécessite de déclarer les variables au niveau des fonctions ou en paramètre.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Session telnet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Voici une méthode pour réaliser ses script telnet en ssh:

	Il ne faut pas oublier de rajouter les sleep (sinon ça va trop vite et le script n'aboutira pas)

	>	#!/bin/bash

		switch="10.1.1.1"

		(
		sleep 4
		echo "admin"   #mot de passe du switch (rajouter un id aussi le login si besoin"
		sleep 4
		echo "commande_to_execute"
		sleep 4
		echo "exit"
		) | telnet $switch

		exit 0

	Cette méthode à l'avantage d'éxécuter d'abord la commande sur notre système avant de l'envoyer sur l'hôte distant.
	Elle fonctionne aussi pour les session ssh.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Script de configuration d'équipement réseaux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Si ssh et telnet en bash ne sont pas suffisant ou pose problème au niveau de la saisie:
		Préférer expect qui a son propre langage et est conçu spécialement pour ça !

		Voici un exemple de syntaxe d'expect:

		#!/usr/bin/expect

		##Récupération des arguments:

			set login [lindex $argv 0]
			set host [lindex $argv 1]
			set password [lindex $argv 2]

		##Connexion à l'équipement:

			spawn ssh $login@$host
			sleep 1

		##Saisie du mot de passe:
			expect {
			"password:" {send "$password\n"}
			}
			sleep 1

		##Envoie des commandes
			send "list -l 2\r"
			sleep 1
			send "exit\r"
		interact
		exit


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OPTIONS simples "getopts"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-----------------------------------------
	#Syntaxe Globale:
	-----------------------------------------

	>while getopts ":a:b:Cd" OPT
	do
		case $OPT in
		a)
			echo $OPTARG
			<commandes...>
			;;
		b)
			echo $OPTARG
			<commandes...>
			;;
		C)
			echo "no arg!"
			<commandes...>
			;;
		d)
			echo "no arg!"
			<commandes...>
			;;
		\?)
			echo "Argument $OPTARG invalide" >&2
			;;
		:)
			echo "Options $OPT need argument!" >&2
			;;
		esac
	done
	###shift $((OPTIND-1))  optionnel, voir ci-dessous

	-----------------------------------------
	#Syntaxe Options
	-----------------------------------------

	getopts "Options"

	Pour définir une Option, on ajoute la lettre correspondante entre les guillemets.
		> getopts "o"

	Si l'option necessite un argument, on ajoute simplement ":" apres l'option:

		> getopts "o:"

	Il est courant de commancer la liste des options par ":" (Afin que le message d'erreur correspondat à :) soir valide.
	Sinon on peut tout simplement l'enlever et enlever par la même occasion le case :)

		> getopts ":o:"


	-----------------------------------------
	#Shifter les options si besoin!
	-----------------------------------------

	Dans un cas particulier où l'on veut par exemple utiliser $@
	Il peut être nécessaire de shifter les options avec la commande suivante:

		> shift $((OPTIND-1))


	-----------------------------------------
	#Afficher ou non les messages d'erreurs
	-----------------------------------------

	Il suffit de définir la variable suivante sur 1 (affiche les messages (par défaut)) ou 0 pour le contraire

		> OPTERR=0

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OPTIONS longues "getopt"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	-----------------------------------------
	#Syntaxe des options
	-----------------------------------------

		options=$(getopt -o <options> -l <options,longues> -- "$@")

		exemples:
			options=$(getopt -o o:p:ti: -l my,longue:,option: -- "$@")

		Tout comme getopts, le ":" signfie que l'option attend un argument.


	-----------------------------------------
	#Syntaxe Globale, exemples:
	-----------------------------------------

	short_flag="sl:"
	long_flag="short,long:"

	if ! options=$(getopt -o "$short_flag" -l "$long_flag" -- "$@")
	then
		echo "Error with getopt" >&2
		exit 1
	fi

	#set -- "$options" (facultatif, todo: expliquer)

	while [ $# -gt 0 ]
	do
		case $1 in
			-s|--short) short=1 ;;
			-l|--long) argument="$2" ; shift ;; #Il faut shifter si l'option attend un argument.
			(--) shift; break;;
			(-*) echo "$0: error, unrecognized option $1" 1>&2; exit 1;;
			(*) break;;
		esac
		shift
	done

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Utilisation des REGEX
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pour utiliser une regex, il faut utiliser le caractère "=~" :

exemple:

	if [[ $variable =~ $REGEX ]]
	then
		echo "its work"
	fi

Note: pour voir la syntaxe des regex, voir le memo sur le regex.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SQL
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	-----------------------------------------
	#Mysql
	-----------------------------------------

		_________________________
		connexion:

		>	mysql -uUSER -pPASSWORD -e"use DATABASE; QUERY;"

		_________________________
		Variable:

		>	variable=$(mysql -uUSER -pPASSWORD -e"use DATABASE; QUERY;")


	-----------------------------------------
	#Oracle - SqlPlus
	-----------------------------------------
		_________________________
		connexion

		>	sqlplus -silent USER/PWD <<-SQL
		>		set pages 0
		>		$QUERY
		>	SQL

		# l'option -silent permet d'enlever tout le texte inutil
		# Remplacer << SQL par <<-SQL permet d'enlever les espaces inutiles
		# l'option "set pages 0" permet d'enlever le nom des colonnes ...

		_________________________
		Variable:
		Le mieux que j'ai trouvé pour récupérer le résultat d'une requête est de créer une fonction.

		>	query_result()
		>	{
		>		query=$1
		>        	sqlplus -silent USER/PWD <<-SQL
		>	        set pages 0
		>		$query
		>	SQL
		>	}
		>
		>	variable=$(query_result "SELECT * FROM ...;")

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INTERPRETATION D'UNE CHAINE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	_________________________
	$eval: permet d'interpréter par le shell, une chaîne de caractère:

	exemple:
		>	user="nom=paul; age=32"
		>	echo $user
			--->		nom=paul; age=32
		>	eval $user
		>	echo $nom
			--->		paul
		>	echo $age
			--->		32

	Cette commande peut être pratique dans le cas où l'on récupère plusieurs infos dans une même chaîne.
	Il sera peut être nécéssaire de traiter la chaîne avec $tr par exemple, pour avoir des ";" après chaque déclaration de variable"

	Tout comme les variables, eval interprète aussi les commandes:

	exemple:
		>	message="date"
		>	eval $message
			--->		Date d'aujourd'hui


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Exemples de codes / Howtos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	-----------------------------------------
	#Boucle multiple paramètres
	-----------------------------------------

	>script.sh [commande] [*]

	 	#!/bin/bash

  		 commande=$1
 	 	 echo $commande

  		 shift

   	 		for i in $@
    			do
             			echo $1
            		 	sudo $commande $1
             			shift
    			done
    		exit

	-----------------------------------------
	#Sort une variable: (fonctionne avec uniq ... toute les commandes nécéssitant un fichier en input)
	-----------------------------------------

        2 méthodes:

                _________________________
                for string in $(echo $variable)
                do
                        echo $string
                done | sort

        ou encore

                _________________________
                echo $variable |tr " " "\n" |sort

        pour l'avoir sur une seule ligne:
                _________________________
                echo $variable |tr " " "\n" |sort |tr "\n" " "


==========================================================
                       T I T L E
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
subtitle 1
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        subtitle 2
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
