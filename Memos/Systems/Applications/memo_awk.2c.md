=====================================================
	A W K
=====================================================

TODO
http://www.shellunix.com/awk.html

Fonctionnement:
	chaque champ d'une ligne correspond à une variable ($1, $2, ..., $NF).
une
	$0 : correspond à l'ensemble de l'enregistrement.

	print : permet d'afficher les variables (print tout seul correspond à print $0.


exemples:

	awk '{print $1}' <file> : affiche le premier champ du fichier
	awk -F ":" '{ $2 = "" ; print $0 }' <file>  : affiche chaque ligne de l'enregistrement sans le 2eme champs

	awk 'END {print NR}' <file>  : affiche le nombre total de lignes du fichier.

	awk 'length($0)>75 {print}' <file>  : affiche les lignes de plus de 75 caractères.

        awk '{print $1,$4}' : pour afficher plusieurs valeurs séparées par un espace.



Variables prédéfinies:


Variable	Signification	 				Par défaut

ARGC		Nombre d'arguments de la ligne de commande	
ARGV		tableau des arguments de la ligne de commnde	 
FILENAME	nom du fichier sur lequel on applique les commandes	 
FNR		Nombre d'enregistrements du fichier	 
FS		separateur de champs en entrée			" "
NF		nombre de champs de l'enregistrement courant	 
NR		nombre d'enregistrements deja lu	
OFMT		format de sortie des nombres	 		"%.6g"
OFS		separateur de champs pour la sortie		" "
ORS		separateur d'enregistrement pour la sortie	"\n"
RLENGTH		longueur de la chaine trouvée	 
RS		separateur d'enregistrement en entrée		"\n"
RSTART		debut de la chaine trouvée	
SUBSEP		separateur de subscript				"\034"
