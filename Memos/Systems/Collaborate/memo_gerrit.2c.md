==========================================================
                       G E R R I T
==========================================================

Gros TODO

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Docs :

        https://review.openstack.org/Documentation/intro-quick.html#_what_is_gerrit
        https://gerrit.googlecode.com/svn/documentation/2.0/install.html

    Download :

        https://code.google.com/p/gerrit/downloads/detail?name=schema-upgrades003_019.zip&can=2&q=

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Gerrit est un système de révision de code fonctionnant à l'aide des notes des reviewers.
    Il dispose d'une WUI et est fait pour s'interfacer avec git de base.

    Il fournit un framework légé pour revoir chaque commit avant qu'ils soient acceptés dans le projet initial.

    C'est donc aux membre de l'équipe de participer à la notation d'un commit pour le valider ou non.

    Gerrit offre donc une plateforme transitoire de validation de commit avec la possibilité d'échanger de l'information autour d'un commit.

    Si un commit n'est pas accepté, l'auteur devra remodifier son commit et retanter de pousser les modifications pour une nouvelle relecture.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Layout
        --------------------------

            Gerrit c'est :

                Les développeurs récupèrent les sources sur le repo "autorisé/validé"
                Ils poussent leurs commit sur le repo "transitoire"
                Les Relecteurs récupèrent les changements et approuve ou non le commit
                Si le commit est validé, il est poussé dans le repo "autorisé/validé"

          [Developers] <-- Fetch -- [Authoritative Repository] <-- Fetch -- [CI Build Server]
                                                A
                                                |
                                              Submit
                                                |
                       -- Push -->      [Pending Changes]
                                                A
                                                |
                                           Fetch/Approve
                                                |
                                                V
                                            [Reviewer]

                Gerrit peut fonctionner aussi comme un simple contrpoleur d'accès vers un repo.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        TODO

        --------------------------
        Build des sources 
        --------------------------

            Le build s'appui apparament sur Apache Maven :

                > git clone git://android.git.kernel.org/tools/gerrit.git
                > cd gerrit
                > mvn clean package
                > cp target/gerrit-*.war ...YOUR.DEST.../gerrit.wa

            Apache Maven :

                http://maven.apache.org/download.cgi
                http://maven.apache.org/run-maven/index.html

        --------------------------
        Base de données (MySQL)
        --------------------------
                __________________________
                Configuration :

                    CREATE USER 'gerrit2'@'localhost' IDENTIFIED BY 'secret';
                    CREATE DATABASE reviewdb;
                    ALTER DATABASE reviewdb charset=latin1;
                    GRANT ALL ON reviewdb.* TO 'gerrit2'@'localhost';
                    FLUSH PRIVILEGES;

                __________________________
                Initialisation du schéma :

                        Création des tables :
                        ``````````````````````````

                            java -jar gerrit.war --cat extra/GerritServer.properties_example >GerritServer.properties
                            edit GerritServer.properties
                            java -jar gerrit.war CreateSchema

                        Ajout des indexes :
                        ``````````````````````````
                            java -jar gerrit.war --cat sql/index_generic.sql | mysql reviewdb -u gerrit2 -p
                            java -jar gerrit.war --cat sql/mysql_nextval.sql | mysql reviewdb -u gerrit2 -p

                        site_path
                        ``````````````````````````

                            mkdir /home/gerrit2/cfg
                            cd /home/gerrit2/cfg
                            UPDATE system_config SET site_path='/home/gerrit2/cfg'
                            
        --------------------------
        SSH
        --------------------------

            ssh-keygen -t rsa -P '' -f ssh_host_rsa_key
            ssh-keygen -t dsa -P '' -f ssh_host_dsa_key

        --------------------------
        Création d'un repo Git de base :
        --------------------------

            mkdir /srv/git
            git config --file '$site_path'/gerrit.config gerrit.basePath /srv/git

        --------------------------
        Accès par défaut
        --------------------------

            Ports :

                ssh : 29418
                http : 8080
            

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        ChangeID
        --------------------------

            Avoir un Change ID dans ses commit :
             
                Git repository: 

                    Dowloader le hook :
             
                        > curl -Lo .git/hooks/commit-msg http://myURL/hooks/commit-msg
                        ou
                        > scp -p -P 29418 monUser@monServerGerrit:hooks/commit-msg .git/hooks/

                    Puis s'assurer que les droits soient bien setés :

                        > chmod u+x .git/hooks/commit-msg
             
~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Cloner un repo
        --------------------------

            > git clone ssh://gerrithost:29418/RecipeBook.git RecipeBook

        --------------------------
        Reprendre un commit non validé
        --------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Erreur
        --------------------------
                __________________________
                Logs:

                __________________________
                Description:

                __________________________
                Résolution:

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
