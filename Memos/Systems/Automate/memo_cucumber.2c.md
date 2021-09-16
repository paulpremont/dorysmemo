C U C U M B E R
==============================

What is it ?
-----------------------------

Cucumber est un Soft de BDD (Behavior Driven develoment) en ruby basé sur un langage interne 'Gherkin' permetant de rédiger des scenarios de test dans un langage simpliste.

Cucumber permet notament un travail collaboratif et d'écrire une documentation vivante basée sur le résultat des tests (scenarios) à effectuer.

Le BDD, quand à lui, introduit le concept de supervision piloté par le comportement (en gros celui ressenti par l'utilisateur).

Concrètement, le BDD est un ensemble de bonnes pratiques pour réduire les coûts de developpement.  
Avec la définition des spécifications par l'exemple et le pilotage des tests du code.

Il se couple avec plusieurs autres solutions telles que Nagios, Watir, Sikuli ... pour créer des outils complet de test applicatif de type end-user.

Links
-----------------------------

### Official

* [Documentation](https://cucumber.io/docs)

### Wikis

* [cucumber wiki](https://github.com/cucumber/cucumber/wik)
* [monitoring-fr cucumber-nagios-watir](http://wiki.monitoring-fr.org/nagios/plugins/cucumber-nagios-watir)
* [monitoring-fr cucumber-nagios](http://wiki.monitoring-fr.org/nagios/plugins/cucumber-nagios)
* [Github Tuto cucumber](https://github.com/cucumber/cucumber/wiki/Tutorials-and-Related-Blog-Posts)

### RVM

* [RVM](https://rvm.io/rvm/install)

### Presentation

* [PREZI presentation](http://prezi.com/arubpcolpmzv/test-automation-using-sikuli-cucumber-and-jenkins/)

### Gherkin:

* [Writing better cucumber features](http://andrewvos.com/2011/06/15/writing-better-cucumber-features/)
* [Gherkin GitHub](https://github.com/cucumber/cucumber/wiki/Gherkin)

### Steps

* [Cukes](http://cukes.info/step-definitions.html)
* [Wiki step definitions](https://github.com/cucumber/cucumber/wiki/Step-Definitions)


How it works ?
-----------------------------

Lancé sans arguments, Cucumber cherche dans un dossier 'features' les différents scenarios à lancer (écrit selon la syntax de Gherkin).

Ces scenarios contiennent des 'steps' qui dictent à cucumber quoi faire.

Tout est basé sur un système d'intéraction de données entre les scenarios écrit en Gherkin, les step_definitions ecritent en ruby et les scripts/applications appelés par les step_definitions.

### Layout

Features (Gherkin) -> Step Definition (Ruby) -> Application


### Projets

Cucumber respecte une arborescence generique:

    <Nom-Projet>/                           #Englobe tout les scenarios et scripts d'une même thématique (exemple : une même application)
    ├── <script1>.rb                        #Script appelé lors des tests de scenarios
    └── features                            #Comprend les fonctionnalités à tester et les moyens d'y parvenir.
        ├── <nom_feature>.feature           #Fichier comprenant les scenarios à tester pour valider la feature (Gherkin).
        └── step_definitions                #Comprend les descriptions liées à un scenario pour qu'il puisse correctement s'exécuter.
            └── <nom_description>_steps.rb  #Fichier écrit en ruby chargé d'appeler les scripts, méthodes, applications pour renvoyer le résultat d'un test.
        └── support                         #Comprend les scripts d'une features

Il est possible de générer automatiquement une arborescence grâce au gem cucumber-nagios:

    cucumber-nagios-gen project MON_PROJET


### Features

Les features sont lancées dans l'ordre alphabétique si il y'en a plusieur.
Il peut donc être judicieux de les préfixer:

exemple:

    000_start.feature
    001_do.feature
    002_stop.feature



### Gherkin

Gerkin (traduisons par "cornichon") est le pseudo langage utilisé pour décrire un scénario applicatif.

#### Syntaxe basique :


    Given:
        Commencer le test en le mettant dans un état initial

    When:
        Description des actions

    Then:
        Observation de la sortie du test

    And, But
        chainer logiquement les entrées précedentes.
        (Pour ne pas repèter Given, When, Then)
        
**Exemple :**

    Feature: google Search
      In order to find more about pepito
      I need to be able to search pepito into google

      Scenario: google Search for pepito
        Given that I am on the google Homepage
        When I search for "pepito"
        Then I should see "aie pepito"


#### Quelques règles:

Attention à ne pas rajouter plusieurs 'Then'.  
On peut cependant mettre plusieurs 'And'.

!!! note
    la syntaxe de Gherkin doit être light, ce sont les steps qui s'occupent de l'automatisation.


#### Plusieurs variables (les exemples)

Gherkin peut itérer sur plusieurs variables (sous formes d'un tableau) et les envoyer aux steps grâces à la syntaxe des exemples.

    Feature: Adding

        Scenario Outline: Add two numbers
            Given the input "<input>"
            When the calculator is run
            Then the output should be "<output>"

        Examples:
            | input | output |
            | 2+2   |  4     |
            | 98+1  |  99    |

Dans ce cas on envoi un tableau à nos steps

On les récupera par exemple ainsi:

    @input = input

#### Langues

Il est possible d'écrire ses scénarios dans d'autres langues.  
C'est à dire utiliser des mots clés Gherkiin propre à sa langue.

Afficher toutes les langues disponibles :

    cucumber --i18n help

Afficher la traduction pour le Français :

    cucumber --i18n fr


### Steps

C'est grâce aux steps que l'on va automatiser nos actions.  
Cucumber envoi aux steps chacune des phrases de Gherkin pour analyse.

Given(/^PHRASE 1$/) do
    #CODE
end
When(/^PRHASE 2$/) do
    #CODE
end
Then(/^DERNIERE PHRASE$/) do
    #CODE RETOUR (True or false)
    # ex: mymessage.should == output (deprecated)
    # ou: expect(mymessage).to eq(output)
end


#### Récupérer les 'variables' de Gherkin

On utilise simplement les regex:

exemple:

    When(/^I login with "(.*?)"$/) do |login|
        CODE
    end

Le (.*?) correspond au morceau de phrase que l'on va mettre dans notre variable login.

### L'environnement

Cucumber met à disposition un fichier **env.rb** par défaut lors de l'initialisation d'un dossier cucumber.
Dans ce fichier on placera les fonctionnalitées communes à toutes les steps.

On peut gérer, par type d'environnement différents des comportements différents grâce à la variable **ENV** et au passage d'argument avec la commande cucumber.

Exemple, pour lancer un scénario en mode headless avec watir :

    cucumber HEADLESS=true --format progress features
    #ou
    cucumber HEADLESS=true

On pourra récupérer le résultat via la variable **ENV** dans son fichier **env.rb** :

    if ENV['HEADLESS']
      require 'headless'
      headless = Headless.new
      headless.start
      at_exit do
        headless.destroy
      end
    end


Installation
-----------------------------

* [lien installation](https://cucumber.io/docs/reference/ruby#installation)

!!! note
    Testé sur une debian 7 en mode graphique (pour lancer des tests applicatifs graphiques avec sikuli par exemple)


Il est possible de choisir le langage dans lequel on veut installer cucumber.  
On a par exemple le choix avec:

* ruby
* Java
* Jython
* javascript
* ...

### Prérequis

#### Libs et compilateur GCC

    apt-get install build-essential curl zlib1g-dev libreadline-gplv2-dev rubygems
    apt-get install libssl-dev libxml2-dev libxslt-dev sqlite3 libsqlite3-dev

#### ruby (via rvm)

Je conseil cette méthode pour vous éviter quelques erreurs d'incompatibilité.

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable

    rvm list known
    rvm install 2.4
    rvm use 2.4 --default
    rvm list

#### Maj des gems (optionnel)

    gem update
    gem list

#### xvfb (optionnel, pour les scénarios graphique)

C'est un serveur X virtuel.  
Il permet de se passer d'une distribution desktop pour cucumber.  

    apt-get install xvfb
    gem install headless #wrapper xvfb

A rajouter dans le script rb :

    if ENV['HEADLESS']
      require 'headless'
      headless = Headless.new
      headless.start
      at_exit do
        headless.destroy
      end
    end


### Cucumber

#### Via gem

    gem install cucumber
    cucumber --help

### Sur Windows

[getting-started-with-ruby-cucumber-and-capybara-on-windows](http://www.agileforall.com/2011/08/getting-started-with-ruby-cucumber-and-capybara-on-windows/)
[complete-setup-guide-for-ruby-cucumber-and-watir-or-selenium-on-windows](http://www.spritecloud.com/2011/04/complete-setup-guide-for-ruby-cucumber-and-watir-or-selenium-on-windows/)

Voir le mémo ruby pour l'installation de ruby et du devkit

!!! note
    je conseil d'utiliser la version 2.0.0 en version 32 bits pour éviter beaucoup d'erreur par la suite !

#### Install de ansicon:

Pour avoir les couleurs en console (requis pour l'output de cucumber)

[Download de l'archive](http://adoxa.altervista.org/ansicon/dl.php?f=ansicon)
ou voir :
[Github Ansicon](https://github.com/adoxa/ansicon/downloads)

Décompression à l'endroit souhaité (exemple C:)

Puis on install ancison:

    cd C:\ansi166\x64
    ansicon.exe -i

#### Quelques gems à rajouter :

    gem update --system
    gem install rspec --no-ri --no-rdoc
    gem install win32console --no-ri --no-rdoc
    gem install watir-webdriver --no-ri --no-rdoc
    gem install cucumber --no-ri --no-rdoc

    Rajouter CALL devant pour les exécuter dans un fichier bat


Manipulation
-----------------------------

### Créer une arborescence

    mkdir mon_scenario
    cd mon_scenario
    cucumber --init

Ce qui donnera une arborescence de ce type :

    features/
    ├── step_definitions
    └── support
        └── env.rb


### Tests de scenarios
                
Pour lancer les tests de scenario:

    cucumber #depuis la racine du projet

Ou en appelant directement une feature:

    cucumber maFeature.feature

Il est conseillé de le faire assez souvent pour pouvoir débugguer facilement un scenario en cours de rédaction.
De plus, il permet de dumper le début de code à insérer dans les steps.


### Exemple complet

#### Définition d'une fonctionnalité

Objectif: écriture du scénario en Gherkin

    cucumber --init
    vim features/Ma_Feature.feature

<!-- begin vim -->

    Feature: Ma_Feature
            
        Scenario Outline: Description du test
                Given the input "<example_in>"
                When the Mon_Application is run
                Then the output should be "<example_out>"

        Examples:
                | example_in | example_out |
                | value_in   |  value_out  |

<!-- endvim -->


    cucumber

Dans cet exemple,  

Gherkin utilisera chaque valeur du tableau "Examples" de la colonne "example_in" et l'enverra au code ruby chargé d'interpréter la ligne 'Given the input...'.
Puis il compara la valeur 'value_out' du tableau avec la valeur renvoyée par le code ruby traitant la ligne 'Then the output...'

Note: la section example est facultative.

On lance une première fois cucumber pour récupérer le code de sortie pour construire notre fichier de step_definitions.

#### Définition des steps

Objectif: interprétation du scenario Gherkin.

    vim features/step_definitions/something_steps.rb


<!-- vim --> 

    #Parsing de la ligne Given the input ...
    Given(/^the input "(.*?)"$/) do |input_values|
      @input = input_values    #On récupère les valeurs envoyées par Gherkin dans un tableau. (car il peut y en avoir plusieurs)
    end

    #Parsing de la ligne When the ...
    When(/^the Mon_application is run$/) do
      @output = `ruby Mon_script.rb #{@input}` #On envoie à notre script les valeurs récupérées en input pour qu'il les traite et nous renvoie les résultat dans un tableau.
      raise('Command failed!') unless $?.success?
    end

    #Parsing de la ligne Then the output ...
    Then(/^the output should be "(.*?)"$/) do |expected_output|
      #@output.should == expected_output #On compare les valeurs renvoyées par le script par les valeurs renvoyées par Gherkin.
      expect(@output).to eq(expected_output)
    end

##### Expect à la place de should (RSpec::Expectations)

* [rspec should](https://github.com/rspec/rspec-expectations/blob/master/Should.md)
* [rspec-expectations](https://github.com/rspec/rspec-expectations)

/!\ Should est maintenant obsolète.

On utilise expect à la place.

    gem install rspec
    gem install rspec-expectations

Quelques exemples d'utilisation :

**Tests d'égalités :**

    expect(actual_value).to eq(expected_value)
    expect(actual_value).not_to eq(expected_value)

**Tests d'identité :**

    expect(actual).to be(expected)  #ou equal

**Comparaisons :**

    expect(actual).to be > expected

**Regex :**

    expect(actual).to match (/expression/)

**Booléens :**

    expect(actual).to be true

**Erreurs :**

    expect(actual).to raise_error(ErrorClass)   #ou juste raise_error

...

~~~~~~~~~~~~~~~~~~~~~~~~~~
Fonctionnement:
~~~~~~~~~~~~~~~~~~~~~~~~~~


        --------------------------
        Exemples (From book)
        --------------------------
                __________________________
                Une feature:



                __________________________
                Step_definitions:

                    Ecrites en ruby, elles interpretent les tests à effectuer.


                __________________________
                Scripts:

                    Ecrit en ce qu'on veut, il doit retourner les valeurs au format attendu par les step_definitions:

                    Par exemple, si il doit executer directement les valeur envoyées (si ce sont des bout de code ruby comme des calculs ...)

                    > vim Mon_script.rb

                        *******
                        print eval(ARGV[0])
                        *******

                __________________________
                Lancement du test:

                    > cucumber #à faire à la racine du projet.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Intégration à nagios
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Ce dernier va nous permettre de lancer nos scenarios et de remonter les erreurs auprès de notre serveur de supervision dans un format qu'il comprend.

        --------------------------
        Installation du plugin cucumber-nagios
        --------------------------

    rvm install ruby-2.4.0
    ruby --version
    ruby 2.4.0p0 (2016-12-24 revision 57164) [armv7l-linux-eabihf]
    gem install cucumber-nagios

            https://github.com/auxesis/cucumber-nagios

            Note: Le gem à l'air un peu abandonné nous forceant à utiliser de vieille version de gem. 

                Et peut causer bon nombre d'incompatibilité. 
                En esperant qu'il y ait des améliorations de ce coté.

            > gem install cucumber-nagios

                Note: 
                        Au moment où j'écris, cucumber-nagios digère bundler en version 1.0.22 (mais pas au dessus).

                Le mieux étant de créer un gemset différent à partir de celui en cours:
                        > gem uninstall bundler
                        > gem install bundler --version 1.0.2

                Il risque d'y avoir encore quelque petit ajustement à faire au niveau des gems !

        --------------------------
        Test du plugin cucumber-nagios
        --------------------------
                __________________________
                Génération d'un projet automatique (optionnel):

                        > cucumber-nagios-gen projet monProjet

                        on peu ensuite générer une feature:
                
                        > cd monProjet
                        > cucumber-nagios-gen feature monSubDir maFeature

                __________________________
                Test de scenario:

                        > cd monProjet
                        > cucumber-nagios feature/maFeature.feature

                        ou via un path absolu

                        Puis debug en fonction des erreurs remontées si il y en a (voir issue_cucumber)

                        Note: cela revient au même que de lancer cucumber de cette manière:

                        > cucumber --require /path/to/featureDir --format Cucumber::Formatter::Nagios featureDir/maFeature.feature

                            --require : pour chaque fichier liés à un test.


        --------------------------
        Configuration des checks coté clients
        --------------------------

            On le fait par exemple via NRPE

            > apt-get install nagios-nrpe-server nagios-plugins
            > cd /etc/nagios/nrpe.d

            > vim check_MON_CHECK.cfg

                    command[check_search]=/PATH/TO/cucumber-nagios /PATH/TO/MA_FEATURE.feature

                    ou aussi via un cd:

                    command[check_calc]=cd /opt/cucumber/scenarii/calculator; cucumber-nagios features/adding.feature

            Note: on oublie pas de rajouter l'ip du serveur 'allowed_hosts=IP_SUPERVISEUR' dans nrpe.cfg

            > /etc/init.d/nagios-nrpe-server restart

                __________________________
                En cas de problème d'environnement:

                    Redefinition de l'utlisateur avec usermod (optionnel)
                    (à accorder avec l'utilisateut et le groupe définit dans la conf du serveur nrpe)

                        > usermod -s /bin/bash -U -d /home/nagios nagios
                        > mkdir -p /home/nagios/scripts
                        > chown -R nagios:nagios /home/nagios


                    Pour contourner les problèmes liés à l'environnement, j'appekl directement un script de cette manière:

                        Au niveau de la conf nrpe
                        ``````````````````````````

                            command[check_calc]=/home/nagios/scripts/./check_calc.sh
                            command[check_watir]=/home/nagios/scripts/./check_watir.sh
                            command[check_sikuli]=/home/nagios/scripts/./check_sikuli.sh

                        Au niveau des scripts
                        ``````````````````````````

                            #!/bin/bash
                            source /etc/profile     #on charge l'environnement

                            cd /opt/cucumber/scenarii/sikuli_calc
                            xvfb-run -a cucumber-nagios features/sikucalc.feature
                            #xvfb pour lancer une application en mode graphique (virtuellement)


                            

        --------------------------
        Configarion des checks coté serveur
        --------------------------
                __________________________
                On rajoute une commande:

                    exemple avec watir:

                    # 'check_watir' command definition
                        define command{
                                    command_name    check_watir
                                    command_line    $USER1$/check_nrpe -H $_SERVICEROBOT_IP$ -t $_SERVICETIMEOUT$ -c $ARG1$
                        }
                __________________________
                On définit le check service:

                    define service{
                            use                             eue-service
                            host_name                       guitest
                            service_description             Search Feature
                            check_command                   check_watir!check_wiki_search
                            _TIMEOUT                        60       
                            _ROBOT_IP                       192.168.3.4
                            }


~~~~~~~~~~~~~~~~~~~~~~~~~~
Couplage avec Watir
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Watir va nous permettre de piloter un navigateur web et d'en récupérer son contenu.

	Watir permet de piloter le navigateur web.

        Voir memo_watir pour plus de commandes

        --------------------------
        Installation de watir
        --------------------------

            > gem install rspec watir watir-webdriver geckodriver-helper

        --------------------------
        Exemple d'arborescence
        --------------------------

                google/
                └── features
                    ├── search.feature
                    ├── step_definitions
                    │   └── search_steps.rb
                    └── support
                        └── watir.rb

        --------------------------
        watir.rb
        --------------------------
            C'est ce fichier qui va nous permmetre d'implémenter watir à nos tests:

            *******
            begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end

            if ENV['FIREWATIR']
              require 'firewatir'
              Browser = FireWatir::Firefox.new
            else
              case RUBY_PLATFORM
              when /darwin/
                require 'safariwatir'
                Browser = Watir::Safari.new
              when /x86_64-linux/
                require 'watir-webdriver'
                Browser = Watir::Browser.new(:firefox)
              when /win32|mingw/
                require 'watir'
                Browser = Watir::IE.new
              when /java/
                require 'celerity'
                Browser = Celerity::Browser.new
              else
                raise "This platform is not supported (#{PLATFORM})"
              end
            end

            # "before all"
            browser = Browser

            Before do
              @browser = browser
            end

            # "after all"
            at_exit do
              browser.close
            end
            *******

        --------------------------
        search.feature
        --------------------------
        
                Notre scenatio de recherche:

                *******
                Feature: google Search
                  In order to find more about QUERY
                  I need to be able to search QUERY into google

                  Scenario: google Search for QUERY
                    Given that I am on the google Homepage
                    When I search for "QUERY"
                    Then I should see "QUERY.com"
                *******

        --------------------------
        search_steps.rb
        --------------------------

                Nos étapes, on appel ici directement watir pour faire nos tests.

                *******
                Given(/^that I am on the google Homepage$/) do
                  @browser.goto('http://www.google.fr')
                end

                When(/^I search for "(.*?)"$/) do |query|
                  @browser.text_field(:name, 'q').set(query)
                  @browser.button(:name, 'btnG').click
                end

                Then(/^I should see "(.*?)"$/) do |view|
                 @browser.ol(:id => 'rso').wait_until_present
                 #@browser.text.include?(view).should == true  #essayer la ligne du dessous
                 expect(@browser.text.include?(view)).to be true
                 
                 @browser.close
                end
                *******

        --------------------------
        Lancement de scenario
        --------------------------

               >cd google
               >cucumber 


~~~~~~~~~~~~~~~~~~~~~~~~~~
Couplage avec sikuli
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Exemple de feature:
        --------------------------

            Feature: sikuli calculator
                In order to test calculator application
                I need to be able to launch calculator and make a calcul

                Scenario: launch sikuli test
                    Given that the scenario calculator.sikuli exist
                    When I launch scenario "calculator"
                    Then the output should be "scenario ok"

        --------------------------
        Exemple de steps:
        --------------------------

            Given(/^that the scenario calculator\.sikuli exist$/) do
              File.directory?('/home/sikuli/scenarii/calculator.sikuli')
            end

            When(/^I launch scenario "(.*?)"$/) do |scenario|
              result = `/home/sikuli/sikuliX/runsikulix -c -f /home/sikuli/logs/#{scenario} -r /home/sikuli/scenarii/#{scenario}.sikuli`
              @result = result.split(/\n/)
            end

            Then(/^the output should be "(.*?)"$/) do |output|
              #@result[-1].should == output #essayer avec la ligne du dessous:  
              expect(@result[-1]).to eq(output)
            end
