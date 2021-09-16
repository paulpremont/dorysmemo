==========================================================
                   S T R I D E R    C D
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Git:

        https://github.com/Strider-CD
        https://github.com/Strider-CD/strider

    Doc:

        http://strider.readthedocs.org/en/latest/index.html

    Infos:

        http://blog.frozenridge.co/fast-and-easy-continuous-deployment-customization-with-stridercd/
        https://linuxmeerkat.wordpress.com/2014/12/11/jenkins-time-is-over/

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Strider CD est un outils de Déploiement/Intégration continu au même titre que Jenkins.
    Il a l'avantage d'avoir une interface un peu plus moderne et d'être plus simple d'utilisation.
    En plus d'être taillé pour la modularité (création facile de plugins)

    L'inconvénient c'est qu'il n'est pas des plus répandu et manque encore à ce jour de plugins.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Strice CD est écrit en nodejs.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        From Docker
        --------------------------
            https://linuxmeerkat.wordpress.com/2014/12/11/jenkins-time-is-over/

                __________________________
                Créer une image:

                    git clone https://github.com/Pithikos/Dockerfiles
                    cd Dockerfiles/strider-docker
                    ./preprocess
                    docker build -t strider:barebones .

                __________________________
                Lancement d'un conteneur:

                    > docker run -it --privileged -v $PWD/data/db:/data/db -p 3000:3000 strider:barebones /bin/bash

                    Tester l'accès à l'IHM: localhost:3000

                    #En cas de problème:

                        Voir si les droits sont ok au niveau de /data/db pour le lancement de mongodb
                        Lancer supervisord à la main:

                            (a éxécuter en tant que strider)

                            > supervisord -c /etc/supervisord.conf

                            Pour utiliser supervisorctl avec cette conf, il suffit d'éxécuter les commande aux niveau de /etc

                            > cd /etc
                            > supervisorctl restart all

                            Si il y a des problèmes de droit au niveau de data:

                            > sudo chown -R strider:strider /data

                            Ne pas hésiter à lancer les process à la main pour voir les erreurs:

                                > mongod
                                > strider
                                > supervisord



                        Note: pour revenir en root:

                            > sudo su -

                    On créer un utilisateur:

                        > strider addUser

        --------------------------
        From scratch
        --------------------------

            http://strider.readthedocs.org/en/latest/install.html
                __________________________
                Prérequis:

                    > apt-get install nodejs-legacy nodejs npm      #ou voir : https://nodejs.org/
                    > apt-get install mongodb                       #ou suivre : http://docs.mongodb.org/manual/administration/install-on-linux/

                __________________________
                Stable (packages):

                    > npm install -g strider

                __________________________
                Dev (sources):

                    > git clone https://github.com/Strider-CD/strider.git
                    > cd strider
                    > npm install -g

                __________________________
                Ajouter un utilisateur:

                    > strider addUser

                    Si on a déja les ids:

                    > strider addUser -l monUser@monDomain.com -p monPassword -a
                    
                __________________________
                Changer l'emplacement de la base (si besoin):

                    DB_URI=mongodb://username:supersecret@mongodb.example.com/strider npm start

        --------------------------
        Plugin Mercrurial 
        --------------------------

            à créer ou à compléter:

            https://github.com/didiercrunch/strider-hg
            ou
            https://github.com/csolar/strider-hg

            Les deux n'étant pas encore fonctionnels mais peuvent toujours servir de base pour achever ces plugins.

            Récupérer le path d'install de strider et aller dans node_modules:

            Exemple: 
                
                > cd /usr/local/lib/node_modules/strider/node_modules
                > git clone https://github.com/didiercrunch/strider-hg
                > cd strider-hg
                > npm install

                => redémarrer strider



~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Toubleshooting
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
