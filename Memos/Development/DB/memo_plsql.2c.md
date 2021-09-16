==========================================================
           P r o c e d u r a l      L a n g u a g e
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~
    http://fr.wikipedia.org/wiki/PL/SQL

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    PL/SQL est un langage propriétaire Oracle permetant d'intégrer des instructions procédurales de type (IF, WHILE ...)
    avec des requêtes SQL destinés aux traitements complexe stockées sur des bases de données.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~~~~~~~~~~~
Les langages:
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        PL/SQL
        --------------------------
            http://plsql-tutorial.com/plsql-variables.htm

            langage propriétaire d'ORACLE.


        --------------------------
        Équivalent MYSQL
        --------------------------
            http://dev.mysql.com/doc/refman/5.0/en/create-procedure.html

            
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
~~~~~~~~~~~~~~~~~~~~~~~~~~
PL/SQL
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Template
        --------------------------

            DECLARE
                variables
            BEGIN
                Program
            EXCEPTION
                Lever une exception
            END;

                __________________________
                Commentaire:

                    --Mon commentaire

        --------------------------
        Variables
        --------------------------

                __________________________
                Syntaxe:
                    
                    variableName datatype [NOT NULL := value ];

                __________________________
                Exemple:

                    salary number(4)
                    dept varchar2(10) NOT NULL := "HR Dept";

                __________________________
                Assigner une valeur à une variable:

                    SELECT ...
                    INTO maVariabmle
                    FROM ...

                __________________________
                CONCATENER:

                    variable || 'machaine'

        --------------------------
        Boucles
        --------------------------
                __________________________
                FOR:

                    FOR I IN val1..val2 LOOP
                        ...
                    END LOOP;
                __________________________
                While:

                    WHILE <condition> LOOP
                        ...
                    END LOOP;
