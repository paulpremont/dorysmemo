W A T I R
==============================


What is it ?
-----------------------------

Un outil d'automatisation de navigateur web écrit en ruby.
Sous Windows watir supporte IE uniquement. (Pour le moment).
Watir-WebDriver supporte quand à lui Chrome, FF, IE, et Opera ...

Watir-webdriver est d'ailleurs basé sur selenium pour le pilotage du navigateur.

Links
-----------------------------

### Officiels:

* [Site officiel](http://watir.github.io/)
* [Documentation](http://watir.github.io/docs/home)
* [Détails du gem](http://www.rubydoc.info/gems/watir-webdriver)
* [Projet Github](https://github.com/watir/watir.github.io)
* [Ancien site](https://watir.com/)

### Alternatives

* [Selenium](http://www.seleniumhq.org/)


How it works
-----------------------------

Installation
-----------------------------

    gem install watir

#### Headless

    apt-get install xvfb
    gem install headless

Manipulations
-----------------------------

### Exemples d'utlisation

#### Recherche Google

    #Chargement des libs
    require 'watir'
    require 'rspec'

    #Instanciation du navigateur
    b = Watir::Browser.new :firefox
    b.cookies.clear

    #Étapes de navigation
    b.goto "http://www.google.com"
    b.text_field(:name => "q").set(item)
    b.button(:name => "btnG").click
    b.ol(:id => 'rso').wait_until_present
    b.text.include?(item).should == true

    #Fermeture de la navigation
    b.close

### Importer Watir

    require 'watir'

### Instancier un navigateur

#### Firefox

* [Firefox](http://watir.github.io/docs/firefox/)


#### Mode headless

* [Headless](http://watir.github.io/docs/headless/)

    require 'watir'
    require 'headless'
    headless = Headless.new
    headless.start
    b = Watir::Browser.start 'www.google.com'
    puts b.title
    b.close
    headless.destroy

#### Fermer le navigateur

    b.close

### Naviguer/selectionner

Pour selectionner un élément de votre page, il faut le cibler.  
On peut le faire grâce à sa balise et les champs type id, class....

Syntaxe générique de selection :

mon_element = objet_navigateur.ma_balise type_information: contenu_information

Exemple :

    icon = @browser.span text: mails
    icon.exists?

#### Les différentes informations de selection :

* :text Le contenue entre deux balises
* :id L'id d'une balise
* :class La classe d'une balise
* :value La valeur d'une balise (exemple : submit pour un bouton)
* :...

#### Les différentes méthodes :

* .click Cliquer sur l'élément
* .exists? Checker si l'élément existe
* .set Écrire dans le champ selectionné
* .set? 
* .select
* .selected_options

#### Aller sur une page web

    browser.goto('http://maPage')

#### Ecrire dans un champ:

    browser.text_field(:name => 'fieldname').set('text')

#### Cliquer sur un bouton

    browser.button(:name => 'buttonname').click

#### Suivre un lien

    browser.link(:id, 'something').click


### Tester la présence d'éléments

#### Attendre un élément

Attendre qu'un élément apparaisse avec .wait_until

Exemple :

    browser.ol(:id => 'something').wait_until_present

                __________________________
                Tester si un élement est inclus:

                    @browser.text.include?(item).should == true
                        
                __________________________
                exists:

                    Check si l'element est présent.

                    exemple:
                        if browser.image(:src, "/image.png").exists?
                __________________________
                present:

                    retourne vrai si l'élement est présent et visible.
                __________________________
                visible:

                    Checker si l'alement est visible.


Troubleshooting
-----------------------------

### Mode Headless :

http://stackoverflow.com/questions/6398595/how-do-i-run-firefox-browser-headless-with-my-ruby-script

Here is extract of the links, how to use headless browser:

    require 'watir-webdriver' 
    require 'headless'

Now start headless and browser

    headless = Headless.new
    headless.start 
    b = Watir::Browser.start 'www.google.com' puts b.title
    b.close headless.destroy

    
        --------------------------
        uninitialized constant Watir::IE (NameError)
        --------------------------

            http://stackoverflow.com/questions/15875215/error-in-running-a-simple-watir-script-uninitialized-constant-watirie-nameer

            Remplacer:

                Browser = Watir::IE.new

                par:

                Browser = Watir::Browser.new(:ie)

            Note, watir-classic sera requis:

                > gem install watir-classic

        --------------------------
        ffi_c (LoadError)
        --------------------------
            
            https://github.com/ffi/ffi/issues/176

            > gem uninstall ffi
            > gem install ffi --platform=ruby

        --------------------------
        problem dl/import
        --------------------------

            Passer sur la version 2.0.0 x32 de ruby

        --------------------------
        problem with "gherkin_lexer_en"
        --------------------------

            https://github.com/cucumber/gherkin/issues/257

            Passer sur la version 2.0.0 x32 de ruby

### AJAX

[Support du waith avec de l'AJAX](http://3qilabs.com/watir-method-for-waiting-until-ajax-elements-have-loaded-completely-or-become-enabled/)


    def wait_until_ready(browser, how, what, desc = '', timeout = 45)
        msg = "wait_until_ready: element: #{how}=#{what}"
        msg &lt;&lt; " #{desc}" if desc.length &gt; 0
        proc_exists  = Proc.new { browser.element(how, what).exists? }
        proc_enabled = Proc.new { browser.element(how, what).enabled? }
        case how
          when :<a class="zem_slink" title="HTML element" href="http://en.wikipedia.org/wiki/HTML_element" rel="wikipedia">href</a>
            proc_exists  = Proc.new { browser.link(how, what).exists? }
            proc_enabled = Proc.new { browser.link(how, what).enabled? }
        end
            start = Time.now.to_f
            if Watir::Wait.until(timeout) { proc_exists.call }
                if Watir::Wait.until(timeout) { proc_enabled.call }
                    stop = Time.now.to_f
                    debug_to_log("#{__method__}: start:#{"%.5f" % start} stop:#{"%.5f" % stop}")
                    passed_to_log("#{msg} (#{"%.5f" % (stop - start)} seconds)")
                    true
                else
                    failed_to_log(msg)
                end
            else
                failed_to_log(msg)
            end
      rescue
        failed_to_log("Unable to #{msg}. '#{$!}'")
    end
