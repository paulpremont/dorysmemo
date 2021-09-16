R U B Y
==========================

Links
------------------------

    Docs :

        http://www.ruby-doc.org/docs/beginner-fr/xhtml/
        http://guides.rubygems.org/rubygems-basics/
        https://ruby-doc.org/core-2.2.0/Module.html

    Tutos :

        http://tryruby.org/levels
        https://www.tutorialspoint.com/ruby

        https://www.codeschool.com/courses/ruby-bits
        https://www.codeschool.com/courses/rails-for-zombies-redux/

    Best practises :

      https://github.com/bbatsov/ruby-style-guide

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it ?
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Un langage de scripting de haut niveau orienté objet.
	Il est comparable à python mais emprunte la philosophie de Perl.

	On retrouve donc le vosabulaire associé:

		* Toutes les données sont objet;
        * Les objets sont des instances d'une classe.
		* Les classes séparent les types de données et leurs méthodes associées.
		* Les méthodes sont des sortes de fonctions applicables à un objet d'une même classe.


~~~~~~~~~~~~~~~~~~~~~~~~~~
INTERPRETEUR
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Installation de l'interpréteur
        --------------------------

            https://www.ruby-lang.org/en/documentation/installation/

            #Installer la version par défaut dispo sur les repo:

            > apt-get install ruby-full

            Vérifier sa version:

            > ruby -v

        --------------------------
        Installation sur windows
        --------------------------
                __________________________
                Ruby Installer

                    Download the ruby installer:

                        http://rubyinstaller.org/downloads/

                        - On install le rubyinstaller (tout cocher)

                __________________________
                Devkit

                    Installation du devkit:

                        https://github.com/oneclick/rubyinstaller/wiki/Development-Kit

                        Récupérer le devkit sur:

                            http://rubyinstaller.org/downloads/

                    Décompresser le devkit,

                        Puis l'installer:

                        > cd <DEVKIT_DIR>
                        > ruby dk.rb init
                        > start config.yml

                            Ajouter les paths vers le path d'installation de ruby.

                            Exemple:

                                ---
                                - C:/Ruby22-x64

                        > ruby dk.rb review
                        > ruby dk.rb install

                    Tests:

                        > gem install json --platform=ruby
                        > ruby -rubygems -e "require 'json'; puts JSON.load('[42]').inspect"
                        > gem -v

        --------------------------
        Lancer un script
        --------------------------
                __________________________
                En live directement depuis l'interpréteur:

			        > irb --simple-prompt

                __________________________
                En console:

                    > ruby monFichier.rb
                    > ruby -e "rubyCode"

                __________________________
                Executer directement un fichier.rb

                    chmod +x script.rb
                    vim script.rb

                        shebang:
                        ``````````````````````````

                            (voir l'output de "which ruby")

                            path:
                            #!/usr/bin/ruby

                            ou

                            env:
                            #!/usr/bin/env ruby

        --------------------------
        Gérer les gems
        --------------------------

                Un gem est un paquet fournis par la communauté Ruby.
                On peu l'assimiler à un module.
                Il est lu par RubyGems qui est dailleurs le gestionnaire de package ruby.
                un gem peu être installé via RubyGems
                __________________________
                Installer rubygems:

                        On peut le faire via les sources ou aussi de cette manière:

                        > gem install rubygems-update
                        > update_rubygems

                        On peut changer de version

                        > gem update --system maVersion

                __________________________
                Rechercher un gem:

                        gem search monGem
                                -r : recherche sur le serveur distant
                __________________________
                Installer un gem:

                        > gem install monGem
                        > gem install monGem -v maVersion

                        Depuis les sources :

                            > gem build MONGEM.gemspec
                            > sudo gem install GemName.gem

                __________________________
                Lister les gem installés:

                        gem list
                        gem list --local
                __________________________
                Supprimer un gem:

                        gem uninstall monGem
                __________________________
                Mettre à jour un gem:

                        gem update #(tout les gems)
                        gem update monGem
                __________________________
                Utiliser un gem en ruby:

                        require "rubygems"
                        require_relative "../local/path"
                        require_gem "mongem"

~~~~~~~~~~~~~~~~~~~~~~~~~~
GESTIONNAIRE
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        RVM (Ruby Version Manager) - Non officiel
        --------------------------

                RVM est un installateur.
                C'est un outils très pratique pour manager différentes version de ruby, de gems ....
                __________________________
                Some links:

                    http://cheat.errtheblog.com/s/rvm
                    https://www.digitalocean.com/community/articles/how-to-use-rvm-to-manage-ruby-installations-and-environments-on-a-vps

                __________________________
                Installer RVM:

                    Récupérer la clé publique:

                        > gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
                        ou

                        > curl -sSL https://rvm.io/mpapis.asc | gpg --import -

                    Installation avec ruby:

                        > \curl -sSL https://get.rvm.io | [sudo] bash -s stable --ruby

                                --trace         #Activer le mode debug
                                --ignore-dotfiles #Ne pas autoriser l'auto 'sourcing' dans les fichier de conf profile ...

                        Pour facilier la mise en oeuvre en multi-utilisateur, on place sudo avant la commande bash.
                        Sinon en root, l'install sera quand même considérée en multi-user mais l'appel via sudo sera surement requis.



                        L'install se fait par défaut dans /usr/local/rvm en root.

                        > source /etc/profile

                        Pour les utilisateurs désirant se servir de rvm, il faut lancer la commande > rvm user gemsets

                        Le 'manager' rvm ne doit pas lancer cette commande. Sinon supprimer le fichier .rvmrc de son $HOME.

                __________________________
                Installer une version de ruby:

                    > rvm list known    : Afficher les versions de ruby disponible
                    > rvm install 2.1   : Installer la version 2.1 de ruby
                    > rvm use 2.1       : Utilisatiion de la version 2.1 pour l'utilisateur courant

                    Vérifier:
                        > ruby -v
                        > which ruby

                    Pour choisir une version par défaut:

                        > rvm use 2.1 --default
                __________________________
                Créer différentes branches de set de gem (gemset)

                    Utile lorsqu'on veut cloisoner différentes configuration de ruby

                    Il existe deux type de gemset:

                            - default : appelé quand aucun gemset n'est spécifié

                            - global : contient les gems hérités par les autres gemset.


                    > rvm list gemsets              #Lister les gemsets

                    > rvm gemset create NOM_GEMSET  #Créer un gemset

                    > rvm version@NOM_GEMSET        #Se placer dans un gemset caractérisé par version@NOM_GEMSET

                    > rvm gemset use NOM_GEMSET     #idem

                    > rvm gemdir : afficher $GEM_HOME (le gemset actuel)

                    > rvm gemset copy gemset@1 gemset@2 #copier les gems vers un autre gemset

                    > rvm gemset empty GEMSET  #vider les gem d'un gemset
                            --force

                    > rvm gemset delete GEMSET #supprimer un gemset

        --------------------------
        bundler
        --------------------------

                Bundler permet de créer des fichier comportant les différentes version de gem à installer.
                Ce fichier s'appel un Gemfile.
                Pratique pour installer des environnement rapidement.

                Note il est necessaire d'avoir au moin rubygem pour utiliser bundler.

                __________________________
                Installer bundler:

                    > gem install bundler
                __________________________
                Syntaxe d'un gemfile:

                    > vim Gemfile

                        gem 'monGem'
                        gem 'monGem', 'version'
                        gem 'monGem', '>=version'
                        gem 'monGem', '~>version'
                        ...
                __________________________
                Installation des gems:

                    > bundle install
                __________________________
                Maj des gems:

                    > bundle update
                __________________________
                Connaitre l'emplacement d'un gem:

                    > bundle show               #: affiche les gems
                    > bundle show monGem        #: affiche l'emplacement

        --------------------------
        rake
        --------------------------

                http://rake.rubyforge.org/

                rake est un constructeur de programme ruby au même titre que make.
                __________________________
                Installer rake:

                    > gem install rake

        --------------------------
        rbenv
        --------------------------

                https://github.com/sstephenson/rbenv

                rbenv  est un outil très pratique permetant de compartimenter les différentes version de ruby et gem pour chaque application.

~~~~~~~~~~~~~~~~~~~~~~~~~~
FRAMEWORK
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        ruby on rails
        --------------------------

            https://www.iflexion.com/ruby-on-rails-development?gclid=CMDM8YD5ms8CFZFsGwodcdEKXQ

            Permet de créer rapidement des prototypes ou des applications avancées.

            rails est un framework très populaire chez ruby.
            Dans le but d'optimiser son temps de travail et de simplifier l'écriture de programme ruby.

            __________________________
            Installer rails:

                > gem install rails

~~~~~~~~~~~~~~~~~~~~~~~~~~
Syntaxe Ruby
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Indentation
        --------------------------

            Par convention, on indente les blocks de code de 2 espaces.

        --------------------------
        Couper une expression
        --------------------------

            Pour garder un code lisible.

            On utilise le '\'

            Exemple:

                "hel\
                lo"

        --------------------------
        Commentaires
        --------------------------

            Sur une seule ligne :

                #my com

            Sur plusieurs lignes :

                =begin
                my big com
                =end


        --------------------------
        Raccourcis d'opérations
        --------------------------

            +=, -=, *=, /=, **=, %=

            exemples :

                Pour un entier :

                    x = 12
                    x += x
                    => 24

                pour une chaine :

                    chaine = "Hello"
                    chaine *= 5
                    => "HelloHelloHelloHelloHello"

        --------------------------
        Blocks
        --------------------------

            Il sont délimités par des accolades {} (qu'on utilise surtout pour des blocs d'une ligne)

            ou

            On peut les créer avec 'do' et 'end'

                do
                ...
                end

            Ils contiennent du code ruby qui peut être réutilisé par des méthodes (comme times, each ...).

            A savoir qu'il existe deux convention sur l'utilsiation des accolades ou de do,

              * Soit : une ligne (accolades) // plusieurs lignes (do...end) [la plus répendu]
              * Soit : si on utilise une valeur de retour (accolades) // si il a un effet de bord (do...end)

                __________________________
                YIELD :

                  yield permet d'interpréter un bloc envoyé à une méthode.
                  On l'utilise pour refactoriser des méthodes ayant la même structure mais pas la même logique.

                  Exemple :

                    def call_block
                      yield
                      yield
                    end

                    call_block { puts "hello" }

                    #Affichera "hello hello"

                  yield peut prendre des arguments,

                  Exemple :

                    def call_block
                      yield "coucou"
                    end

                    call_block { |arg| puts arg.upcase }

                    #Affichera "COUCOU"

                  On peut aussi retourner simplement une valeur :

                    def puts_block
                      puts yield
                    end

                    puts_block { "hellodelu" }

                  IMPORTANT :

                  On utilise par exemple yield lorsqu'on créer plusieurs méthodes ayant la même structure mais avec une logique légèrement différente.

                  Exemple :

                    Transformer :

                      ```
                      class Users

                        def infos_users
                          @users.each do |user|
                            user.infos.each { |info| puts info }
                          end
                        end

                        def save_infos
                          @users.each do |user|
                            user.infos.each { |info| info.save }
                          end
                        end
                      end
                      ```

                    En :

                      ```
                      class Users

                        def each
                          @users.each do |user|
                            user.infos.each { |info| yield info }
                          end
                        end

                      end

                      user = Users.new
                      user.each { |info| puts info }
                      user.each { |info| info.save }
                      ```

                    En encore transformer (from code school) :

                      ```
                      def update_status(user, tweet)
                        sign_in(user)
                        post(tweet)
                        rescue ConnectionError => e
                          logger.error(e)
                        ensure
                          sign_out(user)
                      end

                      def get_list(user, list_name)
                        sign_in(user)
                        retrieve_list(list_name)
                        rescue ConnectionError => e
                          logger.error(e)
                        ensure
                          sign_out(user)
                      end

                      ```

                    En :

                      ```
                      def while_signed_in_as(user, tweet)
                        sign_in(user)
                        yield
                        rescue ConnectionError => e
                          logger.error(e)
                        ensure
                          sign_out(user)
                      end

                      #l'utiliser :

                      while_signed_in_as(user) do
                        post(tweet)
                      end

                      tweets = while_signed_in_as(user) do
                        retrieve_list(list_name)
                      end

                      ```

                    Un autre exemple de codeSchool pour bien comprendre comment les arguments sont passé d'une méthode à l'autre :


                      ```
                      def play
                        emulate do |emulator|             #On commence une itération de la méthode emulate
                          emulator.play(self)             #On récupère le emurator que emulate renvoi, c'est à dire la variable écrite à droite de yield, soit emulator
                        end
                      end

                      def screenshot
                        emulate do |emulator|             #Idem que play
                          emulator.start(self)
                          emulator.screenshot
                        end
                      end

                      private
                      def emulate
                        begin
                          emulator = Emulator.new(system) #emulator devient un nouvel objet instancié.
                          yield emulator                  #yield enverra cet objet en tant qu'argument au bloc envoyé.
                        rescue Exception => e
                          puts "Emulator failed: #{e}"
                        end
                      end
                      ```

                    Enumerable :
                    ``````````````````````````

                        Tips :

                          Lorsqu'on créer une méthode each dans une classe,
                          il peut être intéressant d'utiliser les méthodes d'Enumerable.

                          class Users
                            def each
                              ...
                            end*
                            include Enumerable
                          end

                          user.sort_by { [info| info.login_at }
                          user.map { |info| info.name }
                          user.find_all { [info| info.name =~ /robert/ }}

                    Tester si un bloc exists :
                    ``````````````````````````

                      if block_given?
                        #.... yield
                      else
                        #...
                      end
                __________________________
                PROCS :

                  La class Proc permet de sauvegarder un block dans une variable.

                  On l'utilise de la manière suivante :

                    my_proc = Proc.new { puts "hello" }

                    #ou encore :

                    my_proc = Proc.new do
                      puts "hello"
                    end

                  Pour faire appel au bloc, on utilisera la méthode call :

                    my_proc.call    # => hello

                  L'autre manière de définir un bloc, plus élégante, est d'utiliser le mot clé "lambda".

                __________________________
                LAMBDAS :

                  Lambda est un mot clé permettant aussi de définir un bloc tout comme procs.
                  Il utilise la même interface.

                  my_proc = lambda { puts "hello" }
                  my_proc.call    # => hello

                  Depuis la version 1.9, on peut utiliser un autre raccourci (->) :

                    my_proc = -> { puts "hello" }

                  Grâces aux procs, on va pouvoir maintenant envoyer des variables de bloc à différente méthodes :

                    Exemple :

                      class Foo
                        def fooMeth(bloc_arg1, bloc_arg2)
                          bloc_arg1.call
                          bloc_arg2.call
                        end
                      end

                      fifoo = Fou.new
                      bloc_arg1 = -> { puts "something" }
                      bloc_arg2 = -> { puts "something else" }
                      fifoo.fooMeth(bloc_arg)


                    Convertir un proc en bloc :
                    ``````````````````````````
                      Certaines méthodes nécessitent un bloc en argument (comme each) mais pas un proc.
                      Pour ce faire il faut reconvertir le proc en bloc via le raccourci '&'.

                      Exemple :

                        floors = [1, 2, 3]
                        tower = lambda { |floor| puts floor }
                        floors.each(&tower)

                      Une manière plus élégante lorsqu'on définit une méthode qui attend en argument un bloc,
                      est de le placer le raccourci '&' directement au niveau de la définition de la méthode.

                      Exemple :

                        def maBlocMeth(&bloc1, &bloc2)
                          #...
                        end

                      On peut aussi repasser d'un bloc vers un proc et vis versa.

                      Exemple :

                        class Foo
                          attr_accessor :iterfoo

                          def each(&block)
                            iterfoo.each(&block)
                          end
                        end

                        my_iter = Foo.new(iterfoo)
                        my_iter.each do |foo|
                          puts foo
                        end

                    Raccourcis :
                    ``````````````````````````

                      Grâce au raccourci '&' pour convertir un proc en bloc et vis versa,
                      On peut aussi définir un bloc entier en le combinant avec un symbol :

                        { |arg| arg.meth }  #revient à --->   &:meth

                      Exemple :

                        x.map { |arg| arg.meth }

                        #is the same that :

                        x.map(&:meth)

        --------------------------
        Conditions
        --------------------------
                __________________________
                opérateurs et méthodes

                    Booléens:
                        0 : true
                        "" : true
                        'False' : true

                    Les opérateurs classiques de comparaison de contenu:

                        ==, !=, > ...
                        AND, &&, OR, ||


                        Il agissent différement en fonction de la classe de l'objet:
                        Pour les chaîne les opérations sont faites en fonction de la table ASCII.
                        avec comme ordre de comparaisone :

                            1. les nombres
                            2. les majuscules
                            3. les minuscules

                        exemple:

                            'a' < 'b'
                            'Z' < 'b'
                            >>> true

                    Vérifications:

                        Si une variable existe:

                            defined? variable

                        Si 2 variables sont égales et du même type:

                            var1.eql?(var2)

                        Si 2 vars sont de même objet:

                            var1.equal?(var2)

                    Comparaison:

                        <=> : renvoie 0 si égal
                                -1  si c'est infèrieur
                                1   si c'est supérieur
                                nil si ce n'est pas le même type

                __________________________
                if statement :

                  Structure de base :


                    if CONDITION
                        INSTRUCTIONS
                    elsif CONDITION
                        INSTRUCTIONS
                    else
                        INSTRUCTIONS
                    end

                  On peut écrire un if sur une seule ligne simplement :

                    INSTRUCTIONS if CONDITION

                    Exemple :

                      yield if game.system == system

                  Pour dire si non,

                        Au lieu d'utiliser "if !" (uniquement)
                        Il faut préferer "unless" mais éviter de chaîner unless avec des less par exemple.

                        Exemple :

                            unless condition
                                ...
                            end

                        Autre exemple d'un unless sur une seule ligne (du codeschool) :

                            games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
                            puts "Games in your vast collection: #{games.count}" unless games.empty?

                  Pour chaîner les conditions :

                      if ... && ....
                __________________________
                while :

                    Exemple :

                        while i < x
                            i += 1
                        end

                __________________________
                case :

                    Exemple d'utilisation :

                        varToSet = case varToTest
                            when "A"
                                "newValA"
                            when "B"
                                "newValB"
                            else
                                nil
                        end

                    On peut utiliser case avec des ranges :

                        varToSet = case varToTest
                            when 0..9
                                foo
                            when 10..99
                                fooooo
                            else
                                nil
                        end

                    Et on peut aussi l'utiliser avec des regex :

                        when /maREGEX/
                            :foo
                        when /monAutreRegex/
                            :foo2

                    On peut écrire les cases sous une autre forme plus visuelle :

                        varToSet = case varToTest
                            when /\A@\w+/       then :foo
                            when /\Ad\s+\w+/    then :foo2
                            else                     :defaultfoo
                        end


        --------------------------
        Boucles
        --------------------------
                __________________________
                while :

                    http://www.tutorialspoint.com/ruby/ruby_loops.htm

                    while CONDITION
                        INSTRUCTIONS
                    end

                    Todo:

                        break, redo, next, retry
                __________________________
                .times

                    Il est possible d'éxécuter des boucles via des méthodes comme times :

                        NOMBRE.times do
                            INSTRUCTIONS
                        end

                        Exemple:

                            i = 0
                            11.times do
                                i += 1
                                puts i.to_s
                            end

                    On peut sur une séquence d'itération rajouter une variable auto-alimentée (plus jolie syntaxiquement) :

                        NOMBRE.times do |VAR|
                            INSTRUCTIONS
                        end

                        Exemple :

                            4.times do |i|
                                puts i.to_s
                            end

        --------------------------
        Target
        --------------------------

            Il est possible de cibler des éléments d'un objet via les crochets :

            En ruby les crochets signifie "je recherche quelque chose".

            Exemple :

                maChaine['mon_mot_cible'] = 'un_autre_mot'

        --------------------------
        Raccourci d'assignement
        --------------------------
                __________________________
                N'évaluer qu'une expression si le résultat d'une autre expression est nulle

                    Par exemple :

                        maVar = defaultValue || valueSiNull

                        La partie de droite ne sera évaluée que si la partie de gauche renvoie nil.

                        cela correspond à faire :

                            maVar = defaultValue
                            maVar = valueSiNull unless maVar

                __________________________
                Attribuer une valeur si une variable est null

                    maVar ||= valueSiNull

                    Cela revient à faire ce test :

                        maVar = valueSiNull if maVar.nil?
                        ou encore
                        maVar = valuSiNull unless maVar

                __________________________
                Valeur de retour sous condition :

                    on peut attribuer une valeur de retour en fonction d'une condition grâce à cette syntaxe :

                        maVarToSet = if monTest
                            value1
                        else
                            value2
                        end

                    Cela correspond à faire :

                        if monTest
                            maVarToSet = value1
                        else
                            maVarToSet = value2
                        end

                    Sachant que toutes les méthodes retournent une valeur, on peut écrire :

                        def maMethod (arg1, ...)
                            if arg1
                                valueA
                            else
                                valueB
                            end
                        end


~~~~~~~~~~~~~~~~~~~~~~~~~~
Objets ruby
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Déclaration
        --------------------------

            Note sur la déclaration des objets,

            Par défaut les objets ne sont pas copiés mais font références à la même adresse.
            /!\ Lorsqu'on modifiera la valeur d'un des deux objets, ils seront déréférencés :

                a = 'foo'
                b = a
                a.object_id     # => 8047240
                b.object_id     # => 8047240

                b = 'other_foo'
                a.object_id     # => 8047240
                b.object_id     # => 7955400

            Voir la partie méthodes pour ce qui est la modification de la valeur d'un objet via sa référence.

        --------------------------
        Les nombres
        --------------------------

            Syntaxe :

                X : Entier / Integer
                X.Y : flottant / Float
                XXX_XXX_XXX : désignation des grands nombres via des '_'

                On peut aussi utiliser le signe exposant 'e' pour les grands nombres :

                    e5 => 10^5
                    e-13 => 10^-13

            Ruby à l'instar de python peut être utilisé comme une calculatrice en interprétant directement les calculs et leur résultat.

            Exemple :

                1 + 2
                1.0 + 2.0

            _ pour apporter de la clareter sur les grands nombres:
                289_456_465 => 289456465

            Pour 10^X pour les très grand nombre:
                exemple, pour 1.7^10^19 :

                    1.7e19	#équivaut à 1.7^10^19

            __________________________
            Opérateurs usuels: (méthodes)

                ** : exposant
                % : modulo
                ...

            __________________________
            Méthodes de calcul :

                Bien que les méthodes pour entier et flottant sont appelées de la même manière, elles ne sont pas forcement pareil.

        --------------------------
        Chaînes de caractère
        --------------------------

            "Ma Chaine"
            'Ma chaine'

            Récupérer le résultat d'un code ruby dans une chaîne :

              "#{foo_code}"

            Une chaîne sans besoin d'échapper avec

              * Avec interprétation des variables :

                %Q@ ... @

                %Q@ tout ce que j'aimerais #{afficher}
                  Pourquoi pas sur plusieurs lignes
                @

              * Avec interprétation des variables sur une ligne :

                % ...

                %What #{else}

              * Sans interprétation :

                %q@ #... @

                %q@ tout ce que j'aimerais #{afficher}
                  Pourquoi pas sur plusieurs lignes
                @

                __________________________
                Opérateurs usuels :

                    + : concaténer
                        "hello" + "world"

                    * : répeter
                        "repeat again" + " and again" * 3

                __________________________
                Méthodes :

                    .capitalize : Mettre une maj au début d'une phrase
                    .reverse : inverser l'ordre des caractères
                    .next : change le dernier caractère par la lettre suivante de l'alphabet.
                    .upcase : en majuscule
                    .downcase : en minuscule
                    .swapcase : mettre les extremité en min et le reste en maj

                    .chomp : retirer le dernier caractère

                    .split("motif") : spliter le contenu dans un tableau.

                    .lines.to_a : splitter une chaîne dans un tableau découpé en lignes

                    .join : Rassembler un tableau en une chaîne

                        Exemple d'inversion des lignes d'une chaîne :
                        ``````````````````````````

                            poem.lines.to_a.reverse.join

                __________________________
                Remplacer la première occurrence d'une chaîne :

                    myString['myword'] = 'myOtherWord'

                __________________________
                Evaluer du code dans une chaîne :

                    On insère le code via la syntaxe suivante :

                        "#{mon_code_ruby}"

                    Exemple :

                        puts "Game #{search} Found: #{games[search_index]} at index #{search_index}."

        --------------------------
        Les booléens
        --------------------------

            - true

                Est considéré comme true :

                    * ""
                    * 0
                    * []

            - false

        --------------------------
        Structures de données
        --------------------------

            == Collection d'objet

                __________________________
                Tableaux:

                    Déclaration:
                    ``````````````````````````

                        [ "val1" , "val2" ... ]
                        array = [ ... ]
                        array[n] = "something"
                        array = [ [...], [...] ... ] #Tableau à deux dim

                    Ajouter des données à la suite :
                    ``````````````````````````

                        myArray = []
                        myArray << 'foo1'
                        myArray << 'foo2'
                        myArray << 'foo3'


                    Parcourir :
                    ``````````````````````````

                        Affichage basique d'une donnée ciblée :

                        à une dimension :

                            array[0] ...

                        à deux dimension et plus ...

                            array[X][Y]

                    Itération :
                    ``````````````````````````

                        Avec each

                            Exemple :

                                mon_tab.each do |selected_elem_value|
                                    puts selecteced_elem_value.to_s
                                end

                        Avec times :

                            Exemple :

                                mon_tab.length.times do |i|
                                    puts mon_tab[i].to_s
                                end

                        De façon triée :

                            mon_tab.sort.each do |elem|
                                ...
                            end

                    Méthodes
                    ``````````````````````````
                        + ["target"]    # ajouter un élément au tableau
                        - ["target"]    # Supprimer un élement
                        * n             # Rajoute tous les éléments du tableau n fois.

                        .reverse            # inverser l'ordre des éléments
                        .length             # donne la taille du tableau
                        .sort               # trie numérique/alphabétique
                        .map                # permet d'executer une action sur chaque élément du tableau.

                          Exemple :

                            [1, 2, 3].map { |n| n * n } #=> [1, 4, 9]

                        .any?               #test si le tableau est vide.
                        .include? 'value'   #test si la valeur est dans le tableau

                        Note :

                            On peut converir un tableau en string ...
                            Pour cela il aggrège toutes les cases du tableau.

                        Chercher si un tableau est vide ou non :

                            myArray.any?

                                Renvoie false si aucun élément n'est définit

                            myArray.empty?

                                Renvoie true si le tableau est vide


                    Affichage:
                    ``````````````````````````
                        puts monTableau # Afficher tout les élements du tableau.

                    Trie :
                    ``````````````````````````

                        Trier un tableau à deux dimension :

                        Faire un trie alphabétique sur le premier élément :

                            monHash = [
                                [ "elem1a", "elem1b"],
                                [ "elem2a", "elem2b"],
                                ...
                            ]

                            monHash.sort do |a, b|
                                a[0] <=> b[0]
                            end

                        Faire un trie sur le deuxième élément :

                            monHash.sort do |a, b|
                                a[1] <=> b[1]
                            end

                __________________________
                Hash / Dictionaries :

                    Initialisation :
                    ``````````````````````````
                        myH = {}
                        myH = Hash.new(0)

                    Alimenter un hash :
                    ``````````````````````````

                        Directement avec une clé :

                            myH['key1'] = 'content'

                        ou :

                            myH = {
                                "key1" => "content",
                                "key2" => "content2",
                                ...
                            }

                        ou encore :

                            myH = {
                                :key1 => 'content',
                                :key2 => 'content'
                            }

                            (Attention, dans se cas il faudra utiliser des symbols, on ne pourra pas accéder à un élément via une chaîne.)

                        Et la nouvelle syntaxe (>=1.9)

                            myH = {
                                key1: 'content',
                                key2: 'content2',
                            }

                        Note :

                            Il est déconseillé de déclarer des sous structures, il faut préférer une déclaration découpée :

                            Exemple :

                                adresse_foo = {
                                    "rue" => "3 avenue de ruby"
                                    ...
                                }

                                foo_man = {
                                    "age" => 44,
                                    "adresse" => adresse_foo
                                    ...
                                }
                    Tests :
                    ``````````````````````````

                        Tester si une clé est présente dans un hash :

                            hash.key?(:some_key)

                    Affichage :
                    ``````````````````````````

                        Clés :
                            myH.keys

                        Valeurs :
                            myH.values

                    Parcourir :
                    ``````````````````````````
                        Un hash se parcour de la même manière qu'un tableau sauf que celui-ci n'est pas ordonné.

                        un hash dans un hash :

                            my_hash["sub_hash"]["key"]

                    Itération :
                    ``````````````````````````

                        Avec each :

                            monH.each do |key, value|
                                puts key + " => " + value
                            end

                        Avec each_key :

                            monH.each_key do |key|
                                ...
                            end

                        Avec each_value :

                            monH.each_value do |value|
                                ...
                            end

                    Compter le nombre de valeurs identiques et les sauver dans un nouveau hash :
                    ``````````````````````````

                        (pour faire des stats par exemple)

                        recettes_notes = {}
                        recettes.values.each { |foovar| recettes_notes[foovar] += 1 }

                    Trie
                    ``````````````````````````

                        Trier sur une clé d'un hash :

                            monHash.sort do |a, b|
                                a["key"] <=> b["key"]
                            end
~~~~~~~~~~~~~~~~~~~~~~~~~~
Les variables
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Pour associer un nom à un objet:

        --------------------------
        Déclaration
        --------------------------

            maVariable = monObjet

            Une variable nulle :

                maVar = nil

        --------------------------
        Utilisation
        --------------------------

            De la même façon qu'un objet.

        --------------------------
        Symboles
        --------------------------

            Lorsqu'on utilise une valeur de façon répétée, les symboles permettent de faire une économie niveau mémoire.

            On utilise ':' devant le nom du symbole.

            Exemple :

                recettes['tiramisu'] = :tropbon
                recettes['tarte_epinard'] = :extra
                recettes['gateau_chocolat'] = :tropbon

~~~~~~~~~~~~~~~~~~~~~~~~~~
Les constantes
~~~~~~~~~~~~~~~~~~~~~~~~~~

	A la différence d'une variable, sa valeur ne doit pas changer.
	Sinon ruby vous avertira.

	On les déclare de la même manière mais en commençant par un maj:

	Constante = "something"

~~~~~~~~~~~~~~~~~~~~~~~~~~
Intéraction utilisateur
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Affichage
        --------------------------

            Avec puts:

                puts "Ma Chaine"
                puts "Ma chaine" + maVariable + "fin chaine"

            Note:  il faut penser à convertir les nombres en chaine pour les affivcher:

            Note2 : ni1 signifie que puts ne renvoie rien.

        --------------------------
        Saisie
        --------------------------

            Avec gets:

                inputVar = gets

                Note: On récupère le \n lors de l'appui sur la touche Entrée.
                    On peut le retirer en utilisant la méthode chomp.

                exemple:
                    puts "Entrez votre age "
                    age = gets.chomp


~~~~~~~~~~~~~~~~~~~~~~~~~~
Méthodes
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Chaîner des méthodes
        --------------------------

            Il est possible de chaîner plusieurs méthodes entre elles :

                objet.meth1.meth2 ...

        --------------------------
        Arguments
        --------------------------

            On utilise la ',' pour séparer les arguments :

                meth "arg1", "arg2", ...

            Si l'on shouaite utiliser un argument comme un nom de méthode on peur utiliser la syntaxe suivante :

                monObjet.method(metod_name).call(my_args)

        --------------------------
        Méthodes communes
        --------------------------
                __________________________
                Connaître la classe d'un objet (=~type)

                    .class

                        monObjet.class
                __________________________
                Questionner la classe d'un objet :

                    .is_a?

                    monObjet.is_a?(monType) : renvoie true ou false

                    exemple:
                        12.is_a?(Integer)
                __________________________
                Conversion de classe :

                    .to_s  : d'un nombre à une chaine
                    .to_f : d'une chaine ou un entier vers un flottant
                    .to_i : d'une chaine ou un flottant vers un entier

        --------------------------
        Créer une méthode
        --------------------------
                __________________________
                Définir une nouvelle méthode :

                    def mynewmeth( args )

                        myCode...

                        maValeurdeRetour

                    end

                    Exemple :

                        def load_contacts( path )
                          contacts = {}
                          File.foreach(path) do |line|
                            name, number = line.split(':')
                            contacts[name] = number.strip
                          end
                          contacts
                        end

                        contacts = load_contacts('/home/contacts.txt')
                __________________________
                Appel et arguments :

                    Pour éviter de renseigner tous les arguments lors de l'appel d'une méthode,
                    on utilise des valeurs par défauts, ex :

                        def maMeth(arg1, arg2 = nil, arg3 = nil)
                            #...
                        end

                        maMeth("foo")

                    Par contre, dans si l'on souhaite renseigner le troisième arguments, il faudra tous les renseigner jusqu'au 3eme.
                    Pour éviter ça, on utilise un hash :

                        def maMeth(main_arg, options = {})
                            foo = options[:key]
                            fo2o = options[:key2]
                        end

                        maMeth("main_foo",
                            :key => 'x1',
                            :key2 => 'x2'
                        )

                    On peut aussi récupérer les arguments dans un tableau (splat argument '*') :

                        def trip(world, *countries)
                            go("#{contries.join(' ')} #{world}")
                        end

                        trip('earth', 'France', 'Japan', 'Ireland')
                __________________________
                méthode privée :

                    Pour rendre une méthode privée, c'est à dire uniquement accessible depuis la classe même
                    il faut ajouter 'private' juste avant la méthode.
                    La méthode ne pourra pas être appelée depuis l'exterieur de la classe ainsi qu'explicitement à l'intérieur même de la classe.

                    Exemple :

                        private

                        def mameth
                            #...
                        end
                __________________________
                méthode protégée :

                    A l'instar d'une méthode privée, la méthode sera privée mais autorisée à être appelée par une autre instance de la même classe.

                    Exemple :

                        protected

                        def mameth
                            #...
                        end

        --------------------------
        Passer un objet et valeur de retour
        --------------------------

                __________________________
                Return :

                  La valeur de retour correspond toujours à la valeur de la dernière expression executée.
                  Il est possible cependant d'écrire explicitement la valeur que l'on souhaite retourner avec 'return' :

                  Exemple

                    def maMeth
                      #...
                      return maVal
                    end
                __________________________
                Référence sur objet :


                  Par convention, lorqu'on souhaite modifier directement la valeur d'un objet,
                  On appel une méthode avec le symbol '!'

                  Exemple :

                    title = 'mon titre'
                    title.upcase!
                    puts title    # => MON TITRE

                    /!\ ne fonctionne pas sur toutes les méthodes, elles doivent être définies explicitement.
                __________________________
                Passer un objet :

                  https://launchschool.com/blog/object-passing-in-ruby
                  https://launchschool.com/blog/references-and-mutability-in-ruby

                  Il existe deux type de stratégie lorsqu'on passe une valeut à une méthode :

                    Passer une valeur : on créera une copie de l'objet.
                    Passer une référence : on modifiera directement l'objet.

                  Par défaut Ruby passe toujours une référence :

                    Exemple :

                      def increment(x)
                        x << 'b'
                      end

                      y = 'a'
                      increment(y)
                      y    # => 'ab'

                    Dans l'exemple ci-dessus, on modifie directement la valeur de la référence grâce à la méthode '<<' (append)

                    Si l'on souhaite passer une valeur, il faut utiliser une méthode qui copie l'objet.

                      Exemple :

                        def increment(x)
                          x + 'b'
                        end

                        y = 'a'
                        increment(y)
                        y    # => 'a'

                    Un object dont l'état n'est pas modifiable après sa création est dit "immutable".
                    immutable vs mutable ...

        --------------------------
        Exceptions
        --------------------------

            On lève une exception lorsqu'on rencontre une erreur.
            On peut par exemple tester si une valeur est nulle, et dans se cas lever une exception :

                if maVal.nul?
                    raise MonEsception.new
                end

            Pour traiter l'exception en question, on utilise le bloc begin/rescue :

                begin
                    #code à executer sans erreur
                rescue MonException
                    warn "message erreur"
                end


            Lever une exception, exemple :

                def control(access_list)
                    unless access_list.authorized?(@user)
                        raise AuthorizationException.new
                    end
                    access_list.validate
                end

                begin
                    access = control(my_access_list)
                rescue AuthorizationException
                    warn "You are not authorized to access this list."
                end

            Note :

              Dans une méthode le begin et end sont optionnels.

              Exemple :

                #code
                resuce MonException

        --------------------------
        Regrouper les même foncitonnalités (Best practise)
        --------------------------

            Pour coder proprement,
            il vaut mieux créer une méthode par défaut et créer autour des méthodes au rendu spécific venant compléter le comportement par défaut.

            Exemple :

                #Eviter :

                    class User
                        def mesg_header
                            [@first_name, @last_name].join(' ')
                        end

                        def profile
                            [@first_name, @last_name].join(' ') + @description
                        end
                    end

                #Préférer :

                    class User
                        def display_name
                            [@first_name, @last_name].join(' ')
                        end
                        def mesg_header
                            display_name
                        end
                        def profile
                            display_name + @description
                        end
                    end


~~~~~~~~~~~~~~~~~~~~~~~~~~
Fonctions
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Une fonction est une méthode qui n'est rattachée à aucun objet.

    Exemple :

        def hello
            puts "hello world!"
        end

~~~~~~~~~~~~~~~~~~~~~~~~~~
Classes
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Note: les entiers, les flottant et les chaines sont bien des classes apparente.
    Les classes définissent un type d'objet et contiennent leurs méthodes associées.

        --------------------------
        Créer une classe
        --------------------------

            Exemple de création de classe avec argument :

                #Définition de la classe
                class MaClass

                    #Constructeur
                    def initialize(arg)

                        #Variables de classe
                        @arg = arg

                    end

                end


        --------------------------
        Héritage
        --------------------------

            Hériter d'une classe, exemple :

                class TestMafeature < Test::Unit::TestCase
                    #...
                end

            Note :

              On ne peut hériter que d'une classe.


            Exemple (codeschool) :

                class Attachment
                    attr_accessor :title, :size, :url
                    def to_s
                        "#{@title}, {#@size}"
                    end
                end

                class Image < Attachment
                end

                class Video < Attachment
                end
                __________________________
                Appeler le constructeur d'une classe parente :

                    Pour, en plus d'hériter des méthodes, appeler aussi le constructeur de la classe parente (initialize),
                    on utilisera la méthode super.

                    Exemple :

                        class Attachment
                            attr_accessor :title, :size, :url
                            def initialize(title)
                                #...
                            end
                        end

                        class Image < Attachment
                            def initialize(pict_name)
                                super(pict_name)
                            end
                        end
                __________________________
                Super :

                    Note sur super :

                        la méthode super, cherche en réalité, une méthode parente qui a le même nom que celle depuis laquelle il est executé :

                        Note :
                            * La recherche est récursive, si elle ne trouve pas dans la méthode parente, elle cherchera dans les grandparents ...
                            * Par défaut, super réutilise les arguments de la classe appelée pour les renvoyer. (pas forcement besoin d'utiliser des arguments)

                        Exemple :

                            class Grandparent
                                def my_meth(args)
                                    "Grandparent: my_meth called"
                                end
                            end

                            class Parent < Grandparent
                            end

                            class Child < Parent
                                def my_meth(args)
                                    string = super
                                    "#{string}\nChild : my_meth called"
                                end
                            end

                            #Si on print maintenant l'objet child :

                            child = Child.new
                            puts child.my_method

                            #On obtiendra

                            Grandparent: my_meth called
                            Child: my_meth called
                __________________________
                Méthodes Overriding :

                    Une des astuces concernant les méthodes (optimisation),
                    est de créer les méthodes par défaut au sein de la classe parente,
                    et de gérer les spécificités dans les classe enfants.
                    Au lieu de faire un traitement au niveau de la classe parente.

                    Exemple :

                        #Eviter :

                            class Attachment
                                def preview
                                    case @type
                                    when :jpg, :png, :gif
                                        thumbnail
                                    when :mp3
                                        player
                                    end
                                end
                            end

                        #Préfere :

                            class Attachment
                                def preview
                                    thumbnail
                                end
                            end

                            class Audio < Attachment
                                def preview
                                    player
                                end
                            end

        --------------------------
        Les attributs
        --------------------------

            Les attributs sont les propriétés d'un objet.
            On doit pour cela les déclarer avant le constructeur
            ainsi que les initialiser au niveau du constructeur.

            On peut les définir de plusieurs manières :

                attr_reader :monAttribut    => accès en lecture
                attr_writter :monAttribut   => accès en écriture
                attr_accessor :monAttribut   => accès en lecture et écriture

            On peut déclarer plusieurs attributs sur une ligne :

                attr_accessor :attr1, :attr2 ...

            Exemple de création de classe avec attributs :

                class MaClass

                    attr_accessor :attr1, :attr2 ...

                    def initialize
                        @attr1 = @attr2 = ... = ""
                    end

                end

            On peut ensuite modifier les attributs directement :

                monObjet = MaClass.new
                monObjet.attr1 = "foo"

            Note sur les attributs de classe :

                @maVar = ...

              #équivaut à :

                self.maVar = ...

        --------------------------
        Instancier un objet
        --------------------------

            monObjet = MaClass.new(args)

            Ensuite on pourra lui appliquer les méthodes définies au niveau de sa classe.

        --------------------------
        Gérer l'affichage d'un objet
        --------------------------

            Il suffit de redéfinir la méthode to_s pour cette objet
            On pourra ensuite afficher simplement un objet avec puts.

            En ruby on peut donc ré-ouvrir certaines classes existante (comme to_s)

            Exemple :

                def to_s
                    "    " + @attr1 + "\n" + \
                    "    " + @attr2 + ", " + @attr3
                end

        --------------------------
        Les classes systèmes
        --------------------------
                __________________________
                Dir : Parcourir l'arborescence du système

                    Exemples :

                        Afficher les fichiers situés à la racine :

                            Dir.entries '/'

                        N'afficher que certains fichiers :

                            Dir['/*.txt]

                __________________________
                File : Manipulation basique des fichiers

                    Exemples :

                        Lire un fichier :

                            print File.read("/myrootfile.txt")

                        Ouvrir un fichier :

                            Plusieurs modes d'ouverture sont possible :

                                a : append

                            File.open("/Home/contacts.txt", "a") do |f|
                              f << "John:­ palmbeach"
                            end

                        Connaître la date de modification d'un fichier :

                            File.mtime("/Home/contacts.txt")
                            File.mtime("/Home/contacts.txt").hour

                __________________________
                FileUtils : Manipulation avancée des fichiers

                    Exemples :

                        Copier un fichier :

                            FileUtils.cp('/myrootfile.txt', '/Home/myhomefile.txt')

~~~~~~~~~~~~~~~~~~~~~~~~~~
Modules ruby
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Les modules permettent de regrouper plusieurs fonctions, classes, méthodes et constantes dans un même namespace.
    C'est une manière d'embarquer un lot de fonctionnalités communes et de pouvoir les utiliser via un require sans polluer le global namespace.
    L'avantage et de pouvoir fournir un namespace et de se prévenir de potentielles incompatibilités.
    On l'utilise aussi dans un contexte de mixin (héritage multiple).


        --------------------------
        Créer un module
        --------------------------

          Créer un fichier :

            coffee_utils.rb :

              ```
              module CoffeeUtils

                def grind(bean)
                  #...
                end

              end

              ```

          Note :

            Si on définit une fonction avec self.maFonction,
            Celle sera considérée comme une instance du module.

        --------------------------
        Charger un module
        --------------------------

            require 'monmodule'

            Exemple :

            coffee_shop.rb :

              ```
                require coffee_utils

                arabic_coffee = bean.arabic
                CoffeeUtils.grind(arabic_coffee)

              ```
        --------------------------
        Inclure un module (MIXIN)
        --------------------------

            On utilise souvent un module à l'intérieur d'une classe pour étendre ses fonctionnalités.

            Note :

              Mixin vs Inheritance :

                On pourrait être tenté d'utiliser l'heritage de classe pour importer des méthodes communes à plusieurs objets,
                mais on risque d'être heurté à pas mal de problème dont le fait qu'une classe ne peut hériter que d'une superclass.

                Lorsqu'on pense à ajouter des fonctionnalités commune à plusieurs objets, on passera plutôt par le MIXIN (donc include)
                On peut inclure plusieurs modules.

              Méthode d'instance vs Méthode classe :

                http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/

                * Les méthodes d'instance ne sont accessible que depuis l'objet instancié d'une classe.
                * Les méthodes de classe ne sont accessible que depuis la classe même.

                Exemple :

                    class Foo
                      def self.bar
                        puts 'class method'
                      end

                      def baz
                        puts 'instance method'
                      end
                    end
                __________________________
                include, méthodes d'instance :

                    Dans ce cas, toutes les fonctions du module inclus, deviendrons des méthodes d'instance.

                    Exemple :

                      require coffee_utils
                      class CoffeeShop
                        include CoffeeUtils
                      end

                      #On pourra ainsi appeler directement nos méthodes via l'objet CoffeeShop :

                        arabic_coffee = bean.coffee
                        arabic_coffee.grind

                __________________________
                extend, méthodes de classe :

                    Idem que include, mais cette fois-ci en tant que méthode de classe.

                    Exemple :

                      require coffee_utils
                      class CoffeeShop
                        extend CoffeeUtils
                      end

                    #On ne pourra plus utiliser :

                        arabic_coffee.grind

                        mais plutôt :

                          CoffeeShop.grind('whatever')

                    /!\ Si on utilise la méthode extend sur un object, on pourra utiliser directement les nouvelles méhodes comme méthodes d'instance :

                      arabic_coffee = Coffee.new
                      arabic_coffee.extend(CoffeeUtils)
                      arabic_coffee.grind

                __________________________
                hooks - self.included

                  inclure des méthodes d'instance et de classe dans une classe :

                  Exemple de module :

                    module CoffeeUtils

                      def self.included(base)              #Où base devient la class faisant appel au module.
                        base.extend(ClassFooMethods)
                      end

                      def grind()
                        #...
                      end

                      module ClassFooMethods
                        def organic(bean)
                          #...
                        end
                      end

                    end

                  Exemple pour inclure à la fois les méthodes d'instance et de classe :

                    class Coffee
                      include CoffeeUtils

                      #Avec self.included, extend devient inutile :
                      #extend CoffeeUtils::ClassFooMethods
                    end

                  Exemple d'appel :

                    arabic_coffee = bean.coffee
                    arabic_coffee.grind

                    Coffee.organic('whatever')

                __________________________
                ActiveSupport::Concern

                  On peut sélectionner les méthodes de classe que l'on souhaite inclure dans un module :

                  Exemple :

                    require 'active_support/concern'

                    module XXXX

                      extend ActiveSupport::Concern

                      included do
                        ma_meth_de_class
                      end

                      module ClassMethods
                        def ma_meth_de_class
                        end
                      end
                    end

                  La class Concern permet également de résoudre les dépendances entre modules avec self.included
                  Par exemple, si l'on souhaite inclure des méthodes d'un autre module, on utilisera include + Concern.

                  Exemple :

                    module CoffeeUtils
                      extend ActiveSupport::Concern

                      module ClassMethods
                        def clean_up; end
                      end
                    end

                    module CoffeeServe
                      extend ActiveSupport::Concern
                      include CoffeeUtils
                      included do
                        clean_up
                      end
                    end

                    Class Coffee
                      include CoffeeServe
                    end

        --------------------------
        Ancestors
        --------------------------

          Pour connaîtres tous les modules dont une classe hérite, il est possible de faire appel à la méthode ancestor :

            MaClass.ancestors

          Et pour prendre connaissance des modules qu'une classe inclue, on utilise included_module :

            MaClass.included_modules

~~~~~~~~~~~~~~~~~~~~~~~~~~
Gems
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Chaque gem est caractérisé par un nom, une version et un environement.

        --------------------------
        Structure
        --------------------------

            Un gem est une structure organisée d'un ensemble de classes et doit inclure :

                * Le code ruby (dans le dossier lib), les tests et les utilitaires
                * La documentation
                * un gemspec

                myGem/
                ├── bin/
                │   └── myGem
                ├── lib/
                │   └── myGem.rb
                ├── test/
                │   └── test_myGem.rb
                ├── README
                ├── Rakefile
                └── myGem.gemspec

        --------------------------
        Gemspec
        --------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~
Options et pramètres
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Paramètres de script ARGV
        --------------------------

          http://aya.io/blog/ruby-stdin-argv-argf/

          En ruby la liste des paramètres envoyée au script est dispo via le tableau ARGV :

            ARGV.inspect

        --------------------------
        Options
        --------------------------

          http://ruby-doc.org/stdlib-2.3.1/libdoc/optparse/rdoc/OptionParser.html

          Pour gérer les options en Ruby, on peut utiliser le module optparse.

          Exemple d'utilisation d'Option avec auto génération d'un help :

            require 'optparse'

            Options = Struct.new(:name)

            class Parser
              def self.parse(options)
                args = Options.new("world")

                opt_parser = OptionParser.new do |opts|
                  opts.banner = "Usage: example.rb [options]"

                  opts.on("-nNAME", "--name=NAME", "Name to say hello to") do |arg|
                    args.name = arg
                  end

                  opts.on("-h", "--help", "Prints this help") do
                    puts opts
                    exit
                  end
                end

                opt_parser.parse!(options)
                return args
              end
            end
            options = Parser.parse ARGV
            #options = Parser.parse %w[--help]


~~~~~~~~~~~~~~~~~~~~~~~~~~
Les librairies usuels
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        ACTIVESUPPORT
        --------------------------

          Cette librairie viens ajouter pas mal de méthodes sur les objets courants comme Array, Hash ...
          C'est une sorte d'extension à Ruby.

          Voici quelques exemples d'ajouts en fonction de la classe de l'objet :

          #Installation :

            > gem install activesupport
            > gem install i18n

          #Charger la lib :

            require 'active_support/all'

                __________________________
                Array :

                  array = [0, 1, 2, 3, 4, 5, 6]

                  #Garder les élements d'un tableau à partir d'un indice :

                    array.from(4)   #[4, 5, 6]

                  #Idem jusqu'à un indice :

                    array.to(2)     #[0, 1, 2]

                  #Grouper les élements :

                    array.in_groups_of(3)   #[[0, 1, 2], [3, 4, 5], [6, nil, nil]]

                  #Spliter un tableau à partir d'un indice (en excluant l'indice):

                    array.split(2)      #[[0, 1], [3, 4, 5, 6]]

                __________________________
                Date :

                  apocalypse = DateTime.new(2016, 01, 30, 10, 00, 00)
                  apocalypse.at_beginning_of_day
                  apocalypse.at_end_of_month
                  apocalypse.at_end_of_year
                  apocalypse.tomorrow
                  apocalypse.yesterday

                  #Avancer la date (sommmer) :
                    apocalypse.advance(years: 4, months: 3, weeks: 2, day: 1)

                __________________________
                Hash :

                  yogurt = {fruit: 'banana', cream: 'milk'}
                  new_yogurt = {fruit: 'raspberry', cream: 'milk', chantilly: 'vanilla'}

                  #faire la diff entre deux hash :

                    yogurt.diff(new_yogurt)

                  #convertir les clés en chaînes :

                    yogurt.stringify_keys   #"fruit"=>"banana" ...

                  #Attribuer des clés par défaut à un hash :

                    options = {
                      lang: fr,
                      user: 'codeschool'
                    }

                    defaults = {
                      lang: 'en',
                      country: 'us'
                    }

                    options.reverse_merge(defaults)

                    #donnera :

                      {
                        lang: fr,
                        user: codeschool,
                        country: 'us'
                      }

                  #Ne garder que les clés qui nous interesse :

                    new_yogurt.except(:chantilly, :cream)

                  #Tester la conformité d'un hash :

                    new_yogurt.assert_valid_keys(:fruit, :cream)

                __________________________
                Integer :

                  #Tester si la valeur est pair :
                    value.even?

                  #Tester si la valeur est impair :
                    value.odd?

                __________________________
                Inflector :

                  #Ordinalizer un nombre (le convertir en châine) :

                    1.ordinalize   #1st
                    2.ordinalize   #2nd
                    ...

                  #Mettre une chaîne au pluriel :

                    "octopus".pluralize   #octopi

                  #Mettre une chaîne au singulier :

                    "women".singularize   #woman

                  #Mettre une majuscule à chaque début de mot :

                    "ruby bits".titleize  #Ruby Bits

                  #Rendre lisible une chaîne :

                    "test_ruby".humanize  #Test ruby

~~~~~~~~~~~~~~~~~~~~~~~~~~
Tests
~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://en.wikibooks.org/wiki/Ruby_Programming/Unit_testing

~~~~~~~~~~~~~~~~~~~~~~~~~~
API
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Ou comment créer une API ruby
        --------------------------
        Quelques notions
        --------------------------

            CRUD :

            REST :

        --------------------------
        La gem Grape
        --------------------------

            https://www.synbioz.com/blog/api_ruby_rails_gem_grape

~~~~~~~~~~~~~~~~~~~~~~~~~~
Examples
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Refactorisation
        --------------------------

          From http://rubybits.codeschool.com/levels/3/challenges/8

            Transformer :

              ```
              class Game
                attr_accessor :name, :year, :system
                attr_reader :created_at
                def initialize(name, options={})
                  self.name = name
                  self.year = options[:year]
                  self.system = options[:system]
                  @created_at = Time.now
                end

                def to_s
                  self.name
                end

                def description
                  "#{self.name} was released in #{self.year}."
                end
              end

              class ConsoleGame < Game
                def to_s
                  "#{self.name} - #{self.system}"
                end

                def description
                  "#{self.name} - #{self.system} was released in #{self.year}."
                end
              end
              ```
            En :

              ```
              class Game
                attr_accessor :name, :year, :system
                attr_reader :created_at
                def initialize(name, options={})
                  self.name = name
                  self.year = options[:year]
                  self.system = options[:system]
                  @created_at = Time.now
                end

                def to_s
                  self.name
                end

                def description
                  "#{self} was released in #{self.year}."
                end
              end

              class ConsoleGame < Game
                def to_s
                  "#{self.name} - #{self.system}"
                end
              end
              ```
