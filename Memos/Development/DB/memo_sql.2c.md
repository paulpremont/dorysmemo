==========================================================
                       S Q L
==========================================================

/!\ la plupart des commandes on été réalisées avec mysql.
La syntaxe peu différer en fonction du SGBD utilisé.
Tous ne respectent pas forcement le standard SQL.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://sql.developpez.com/
    http://fr.openclassrooms.com/informatique/cours/administrez-vos-bases-de-donnees-avec-mysql
    http://dev.mysql.com/
    http://fr.wikipedia.org/wiki/Open_Database_Connectivity


    Très useful:
        http://sql.sh

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    SQL (Structured Query Language) est un standard pour les SGBD.
    IL définit un langage de requête structurée pour intéragir avec des bases de données relationnelles.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Accès
        --------------------------

            Pour utiliser du SQL on passe par le soft client d'un SGBD (type sqlplus pour oracle, mysql pour mysql-server ...)
            Les logiciels client peuvent s'interfacer avec un intergiciel de type ODBC (Open Databse Connectivity), JDBC (Java Database Connectivty)...
            Ces intergiciels permettent à une application de manipuler plusieurs SGBD sans se soucier de son type.

            On peut aussi utiliser du SQL directement dans son code source (embedded SQL)

            Il existe aussi des procédures stockées (utilisé surtout par des trigger) qui sont des fonctions SQL enregistrées en base.



~~~~~~~~~~~~~~~~~~~~~~~~~~
Données
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        opérateurs
        --------------------------

            != < > <> >= <= ...

        --------------------------
        Types de données
        --------------------------
                __________________________
                Chaînes:

                    VARCHAR(X)      : chaîne de X caractères
                    CHAR(1)         : stocker un caractères, ou une chaine de caractère fixe
                    TEXT            : Pour accueillir des commentaires
                __________________________
                Nombres:

                    DATETIME        : stocker une date
                    INTEGER         : Nombres entiers
                    DECIMAL         : Nombres décimaux
                    SMALLINT        : petit nombre

                        Timestamp:
                        ``````````````````````````

                            Testé sous oracle:

                                !date +%s : affiche le timestamp courant.

                                exemple de requête permetant d'afficher tous les champs datant de moins d'une heure. 

                                select * from <table>
                                where <champ_timestamp> > TO_UNIX_TS(sysdate-1/24); 

                    Type de colonne     Espace requis
                    TINYINT     1 octet
                    SMALLINT    2 octets
                    MEDIUMINT   3 octets
                    INT,INTEGER     4 octets
                    BIGINT  8 octets
                    FLOAT(p)    4 if X <= 24 or 8 if 25 <= X <= 53
                    FLOAT   4 octets
                    DOUBLE PRECISION, REAL  8 octets
                    DECIMAL(M,D)    M+2 octets si D > 0, M+1 octets si D = 0 (D+2, si M < D)

                    Type de colonne     Espace requis
                    DATE    3 octets
                    DATETIME    8 octets
                    TIMESTAMP   4 octets
                    TIME    3 octets
                    YEAR    1 octet

                    Type de colonne     Espace requis
                    CHAR(M)     M octets, 1 <= M <= 255
                    VARCHAR(M)  L+1 octets, avec L <= M et 1 <= M <= 255
                    TINYBLOB, TINYTEXT  L+1 octets, avec L < 2^8
                    BLOB, TEXT  L+2 octets, avec L < 2^16
                    MEDIUMBLOB, MEDIUMTEXT  L+3 octets, avec L < 2^24
                    LONGBLOB, LONGTEXT  L+4 octets, avec L < 2^32
                    ENUM('valeur1','valeur2',...)   1 ou 2 octets, suivant le nombre d'éléments de l'énumération (65535 au maximum)
                    SET('valeur1','valeur2',...)    1, 2, 3, 4 ou 8 octets, suivant le nombre de membres de l'ensemble (64 au maximum)

        --------------------------
        Contraintes
        --------------------------

            NOT NULL        : valeur obligatoire
            UNIQUE          : valeur unique
            PRIMARY KEY (colonne_pk1 [, colonne_pk2, ...])      : identifiant d'une table
            CONSTRAINT nom_contrainte FOREIGN KEY champ_concerné REFERENCES Table(champ)        : ajout d'une clé étangère 

            AUTO_INCREMENT  : Auto incrémentation de la valeur du champ
            DATA TYPE number(5, 0)  : Donner un type de donnée?
            CHECK (<chp> >= <nombre>) : la valeur du champ doit être supèrieur au nombre indiqué.
            DEFAULT value   : mettre une valeur par défaut

                DEFAULT current date : met la date courante comme valeur par défaut

        --------------------------
        Commentaires
        --------------------------

            -- mon commentaire

~~~~~~~~~~~~~~~~~~~~~~~~~~
Requêtes
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Informations
        --------------------------

            SELECT version();        : version 
            SELECT current_date from dual;     : date actuelle
            SELECT TO_CHAR (SYSDATE, 'DD-dd-YY HH24:MI:SS') NOW  FROM DUAL ;   -- Afficher la date du système.

        --------------------------
        Création
        --------------------------
                __________________________
                Base de données:

                    > CREATE DATABASE IF NOT EXISTS db_name CHARACTER SET 'utf8';
                        USE db_name;
                __________________________
                Tables:
                    
                    > CREATE TABLE IF NOT EXISTS table_name (                  
                        id INTEGER UNIQUE NOT NULL,                      
                        other_id INTEGER UNIQUE NOT NULL,
                        name VARCHAR(30),                                 
                        birth DATETIME,                                   
                        sex CHAR(1),                                      
                        last_update DATETIME,                             
                        PRIMARY KEY (pid),
                        CONSTRAINT other FOREIGN KEY (other_id) REFERENCES Other(id)
                    );

                        Copier une table:
                        ``````````````````````````
                            > CREATE TABLE <table> AS SELECT * FROM <autre_table>;
                            
                            ou utiliser l'outil dump qui est plus adapté
                __________________________
                Utilisateurs:

                    > GRANT ALL PRIVILEGES ON h2p.* TO 'h2p'@'localhost'    
                      IDENTIFIED BY 'nihon' WITH GRANT OPTION;
                __________________________
                Contraintes:

                    > ALTER TABLE <table>
                        ALTER COLUMN <chp>
                        SET <contrainte>; 
                        
                        ALTER TABLE <table>
                        ADD PRIMARY KEY (<chp_primary_key>);  : ajout d'une clé primaire
	
                        exemples de contraintes:
                        ``````````````````````````
		
                            -- On voudrais que les prix des des vetements soient obligatoirement compris entre 20 et 50$
                            
                                ALTER TABLE vetement
                                ADD CONSTRAINT prix
                                CHECK(prix between 20 AND 50);
                            
                            
                            -- On voudrais que les prix ne depasse pas 50$ en contant le montant de la TVA:
                            
                                ALTER TABLE vetement
                                ADD CONSTRAINT prix
                                CHECK(prix + tva <= 50)
                            
                            -- On voudrais s'assurer que tout les vetements possède une matiere
                            
                                ALTER TABLE vetement 
                                ADD CONSTRAINT matiere
                                CHECK (matiere IN (SELECT nom_matiere FROM matiere);

                __________________________
                Vues:

                    CREATE VIEW <nom_vue>
                    AS
                            <REQUETE SELECT>;


        --------------------------
        Suppression
        --------------------------
                __________________________
                Base de données:

                    DROP DATABASE db_name;
                __________________________
                Contrainte:

                    ALTER TABLE <table>
                    ALTER COLUMN <chp>
                    DROP <contrainte>;
                __________________________
                Table:

                    DROP TABLE nom_Table;

                        Colonnes
                        ``````````````````````````

                            ALTER TABLE maTable
                            DROP COLUMN maColonne
                    
                __________________________
                Valeurs:

                    DELETE
                    FROM <table>
                    WHERE <chp>='<chaine>';  (ou pas de WHERE pour tout supprimer)

        --------------------------
        Insertion
        --------------------------
                __________________________
                Valeurs:

                    INSERT INTO <table>(<chp1>, <chp2>)
                    VALUES ('<chaine>', Nombre); 

        --------------------------
        Selection
        --------------------------
                __________________________
                Champs:

                    -- selectionner tout les champs d'une table

                        SELECT *
                        FROM <table>;
                    

                    -- Selectionner des champs particulié correspondant à la recherche
                    
                        SELECT <chp1>, <chp2> ...
                        FROM <table>
                        WHERE <chp>='<chaine>'
                        OR <chp>='<chaine>';    (On peut définir plusieurs cas)
                    
                    -- affiche tous les champs du SELECT qui ont une correspondance avec le champ du WHERE et dont la valeur commence par la chaine inscrite.

                        SELECT <chp1> 
                        FROM <table>
                        WHERE <chp2> LIKE '<chaine>%'; 
                __________________________
                Ordonner:

                    SELECT *
                    FROM <table>
                    ORDER BY <chp>;  Ordonne le résultat par le champs choisi (tri par ordre croissant)
                    
                    ORDER BY <chp> DESC; Ordonne par tri décroissant
	
                __________________________
                Limmiter:
	
                    SELECT *
                    FROM <table>
                    LIMIT <X>, <Y>;  :Affiche Y entrées à partir de X+1


                    -- Sous oracle:

			SELECT *
			FROM <table>
			WHERE ROWNUM < X; 

			Affichera les X premières entrées.
				
                __________________________
                Alias:
	
                    SELECT <chp1>
                    AS <chaine>
                    FROM <table>;

                __________________________
                Grouper:
	
                    SELECT AVG(prix)
                    AS prix_moyen
                    FROM <table>
                    GROUP BY marque;
                __________________________
                Filtrer:
	
                    SELECT AVG(prix)
                    AS prix_moyen
                    FROM <table>
                    GROUP BY marque
                    HAVING prix_moyen <= 5;

                    Note HAVING s'applique après le groupe by alors que le WHERE agit juste avant.
                __________________________
                Jointures:

                        Internes
                        ``````````````````````````
                            Selection, uniquement,  des champs qui ont une correspondance avec les tables

                            Basique:
	
                                SELECT <table1>.<chp1>, <table2>.<chp1>
                                FROM <table1>, <table2>
                                WHERE <table2>.<chp_KEY> = <table1>.<chp_KEY>;
	
                            Avec des alias:
                            
                                SELECT v.nom_vetement, m.nom_marque, ma.nom_matière
                                FROM vetement v, marque m, matiere ma
                                WHERE m.ID_marque = v.ID_marque
                                AND ma.ID_matiere = v.ID_matiere;

                            Avec JOIN:
	
                                SELECT v.nom_vetement, m.nom_marque, ma.nom_matière
                                FROM vetement v
                                INNER JOIN marque m ON (m.ID_marque = v.ID_marque)
                                INNER JOIN matiere ma ON (ma.ID_matiere = v.ID_matiere);

                                Note: INNER est facultatif, il indique seulement que la jointure est interne.
	
                        Externes
                        ``````````````````````````
                            
                            Si il n'y a pas de correspondance, la valeur NULL apparauitra.
	
                            Table de gauche : correspond à la table mentionnée dans le FROM
                            Table de droite : correspond à la table mentionnée dans le JOIN

                            -- selection des champs de la table de gauche (vetement) 
                            -- même si il n'y a pas de correspondance dans la table de droite (marque), la valeur  "NULL" apparaitra)
	
                                SELECT v.nom_vetement, m.nom_marque
                                FROM vetement v
                                LEFT JOIN marque m ON (m.ID_marque = v.ID_marque);
                            
                                    
                            -- selection des champs de la table de droite (marque) 
                            -- même si il n'y a pas de correspondance dans la table de gauche (vetement), la valeur  "NULL" apparaitra)
                            
                                SELECT v.nom_vetement, m.nom_marque
                                FROM vetement v
                                RIGHT JOIN marque m ON (m.ID_marque = v.ID_marque);
                            
                __________________________
                Imbriquer:

                    On peut utiliser le résultat d'une requête comme critère de recherche:

                    exemple:

                        SELECT F.NomFou, P.PrixUnit
                        FROM FOU F, PRO P          
                        WHERE P.NumFou = F.NumFou  
                        AND P.NomPro = 'Chef'      
                        AND PrixUnit = (SELECT MIN(PrixUnit) FROM PRO WHERE NomPro = 'Chef');

        --------------------------
        Modifications / Mise à jour
        --------------------------
                __________________________
                Tables:

                    UPDATE <table>
                    SET <chp> = '<chaine>'
                    WHERE <chp> = '<autre chaine>';

                        Via une vue:
                        ``````````````````````````
		
                            CREATE RULE <nom règle> AS ON UPDATE TO <vue>
                                    DO INSTEAD
                                    UPDATE <table>
                                    SET 	<PK> = NEW.<PK>,
                                            <chp2> = NEW.<chp2>,
                                            <chp3> = NEW.<chp3>
                                    WHERE <PK> = OLD.<PK>;
                                    
                            UPDATE <vue> SET <chp> = '<chaine>'
                            WHERE <chp> = '<chaine>';
                            
                            Lorsque l'update aura lieu, la regle sur la vue s'appliquera et mettra à jour la table défini dans la règle.

                        Ajouter une colonne
                        ``````````````````````````

                            ALTER TABLE maTable
                            ADD COLUMN maColone parametres;
                    
                        Renommer une colonne
                        ``````````````````````````
                            ALTER TABLE maTable
                            CHANGE column1 column2 parametres;

                        Changer les paramètres/description d'une colonne
                        ``````````````````````````

                            ALTER TABLE maTable
                            MODIFY column1 new_description
	
                __________________________
                Vue:
                        Renommer:
                        ``````````````````````````
                            ALTER VIEW <vue>
                            RENAME TO <new_vue>;

        --------------------------
        Sous-Requêtes
        --------------------------

            http://sqlpro.developpez.com/cours/sqlaz/sousrequetes/#L1.2.1

            exemple:

                On voudrais afficher tout les vetements dont le prix est supèrieur à deux fois le prix minimum:
                
                SELECT nom_vetement
                FROM vetement
                WHERE prix > (2 * (SELECT MIN(prix) FROM vetement));

                __________________________
                Listes et sous requêtes

                    Pour traiter les valeurs d'une sous requête renvoyant une liste,
                    on peut utiliser les opérateur IN, ALL et ANY(SOME):

                    ALL et ANY sont surtout utilisé par les critère d'inégalité (>, >=, <, <=, <>).

                        IN
                        ``````````````````````````
                            Exemple:

                                SELECT * FROM PRO WHERE NumFou NOT IN (SELECT NumFou FROM PRO WHERE PrixUnit > 50);

                        ALL
                        ``````````````````````````

                            S'utilise pour comparer toutes les valeurs pour que le prédicat soit vrai.

                            Exemple:

                                SELECT CHB_ETAGE 
                                FROM   T_CHAMBRE 
                                GROUP  BY CHB_ETAGE
                                HAVING SUM(CHB_COUCHAGE) >= ALL (SELECT SUM(CHB_COUCHAGE)
                                                                 FROM   T_CHAMBRE
                                                                 GROUP  BY CHB_ETAGE)

                        ANY
                        ``````````````````````````

                            vrai si au moins une valeur de l'ensemble est vrai lors de la comparaison

                            Exemple:

                                SELECT CHB_ETAGE 
                                FROM   T_CHAMBRE 
                                GROUP  BY CHB_ETAGE
                                HAVING SUM(CHB_COUCHAGE) < ANY (SELECT SUM(CHB_COUCHAGE)
                                                                FROM   T_CHAMBRE
                                                                GROUP  BY CHB_ETAGE)
                __________________________
                EXISTS:

                    Tester l'existance d'une valeur dans un WHERE:

                    Exemple:

                        SELECT nom_colonne1
                        FROM `table1`
                        WHERE EXISTS (
                            SELECT nom_colonne2
                            FROM `table2`
                            WHERE nom_colonne3 = 10
                        )

        --------------------------
        Evaluation sémantique
        --------------------------

            SQL évalue par défaut de façon sémantique.
            C'est à dire qu'il va selectionner toutes les cas possible dans l'ordre.

            Par exemple si l'on souhaite afficher tout les couples possible d'une entreprise:

                SELECT C1.NomCli, C2.NomCli FROM CLI C1, CLI C2 WHERE C1.NomCli < C2.NomCli;

                Note ici on liste tous les couples possible en enlevant en plus les valeur identique et inversée:

                    AA
                    AB
                    BA
                    ..
                        Ne gardera que AB ou BA en fonction de la comparaison.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Fonctions
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Scalaires
        --------------------------
	
            UPPER(<chp>) : champ en majuscules
            LOWER(<chp>) : champ en minuscules
            LENGTH(<chp>) : nombre de caractères des entrées du champ
            ROUND(<chp>, <X>) : arrondi le champs à X chiffres apres la ,

        --------------------------
        Agrégats (retourne une seule valeur)
        --------------------------
	
            AVG(<chp>) : donne la moyenne d'un champ
            SUM(<chp>) : additionne toute les valeur du champ
            MAX(<chp>) : retourne la valeur maximale du champ
            MIN(<chp>) : retourne la valeur minimale
            COUNT(<chp>) : compte le nombre d'entrées correspondantes au champ
            COUNT(*) : compte tout les champs
            COUNT(DISTINCT <chp>) : compte le nombre d'entrées différentes dans le champ

        --------------------------
        WHERE
        --------------------------

            AND & OR
            IN
            BETWEEN
            LIKE
            IS NULL / IS NOT NULL

	
~~~~~~~~~~~~~~~~~~~~~~~~~~
Indépendance logique
~~~~~~~~~~~~~~~~~~~~~~~~~~

	 le niveau conceptuel doit pouvoir être modifié sans remettre en cause le niveau physique, c'est-à-dire que l'administrateur de la base doit pouvoir la faire évoluer sans que cela gêne les utilisateurs
	
	
	Par exemple on peut découper une table en deux parties:
		CREATE EMP1 AS (SELECT empno, ename....);
		CREATE EMP2 AS (SELECT empno, job....);
		
		DROP TABLE EMP;
		
		CREATE VIEW EMP AS (SELECT * FROM EMP1 NATURAL JOIN

~~~~~~~~~~~~~~~~~~~~~~~~~~
Exemples
~~~~~~~~~~~~~~~~~~~~~~~~~~

    __________________________
    Liste des couples de client différents
    Ex: si ABC alors afficher AB, AC, BC

        SELECT C1.NomCli, C2.NomCli FROM CLI C1, CLI C2 WHERE C1.NomCli < C2.NomCli;

    __________________________
    Afficher le prix moyen, le prix max de chaque type de produit ayant plus de 10 produits.

        SELECT TypePro, AVG(PrixUnit) avg, MAX(PrixUnit), COUNT(*) nb FROM PRO GROUP BY TypePro HAVING COUNT(*) > 10 ORDER BY TypePro;

    __________________________
    Calcul du total par commande:

        SELECT D.NumCom, C.FraisPort, (SUM((D.Qte * P.PrixUnit) * (1 - (D.Remise / 100))) + C.FraisPort) total FROM COM C, DET D, PRO P WHERE C.NumCom = D.NumCom AND D.NumPro = P.NumPro GROUP BY D.NumCom, C.FraisPort Order By D.NumCom;
