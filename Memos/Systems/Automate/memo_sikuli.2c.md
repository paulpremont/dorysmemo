==========================================================
                       S I K U L I
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Docs:
        http://doc.sikuli.org/
        http://doc.sikuli.org/keys.html
        http://doc.sikuli.org/sikuli-script-index.html

    Tutos:
        http://linuxconfig.org/ubuntu-lucid-lynx-linux-sikuli-installation
        https://github.com/RaiMan/SikuliX-IDE/wiki/Release-Notes-IDE
        http://www.sikulix.com/quickstart.html

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it ?
~~~~~~~~~~~~~~~~~~~~~~~~~~

        Sikuli est un soft en Jython qui permet de tester des applications lourdes en utilisant le principe de screenshot pour automatiser les actions d'un utilisateur.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        voir https://launchpad.net/sikuli/+download

        --------------------------
        Linux
        --------------------------

            Les sources sont dispo ici:
                    https://github.com/RaiMan/SikuliX-2014

            On donwload le jar sikuli:

                > wget https://launchpad.net/sikuli/sikulix/1.0.1/+download/sikuli-setup.jar
                ou 

                > wget https://launchpad.net/sikuli/sikulix/1.1.0/+download/sikulixsetup-1.1.jar

            Et les tools:

                > wget https://launchpad.net/sikuli/sikulix/1.0.1/+download/Sikuli-1.0.1-Supplemental-LinuxVisionProxy.zip
                > unzip Sikuli-1.0.1-Supplemental-LinuxVisionProxy.zip

            Il faut installer java si ce n'est pas déja fait:

                > apt-get install openjdk-7-jre openjdk-7-jdk icedtea-7-plugin wmctrl

            On install les lib nécessaires

                > apt-get install libopencv-dev libtesseract-dev

            On install ensuite quelques prerequis pour Linux:

                > cd Sikuli-1.0.1-Supplemental-LinuxVisionProxy
                > ./makeVisionProxy         #chmod +x si non executable

            On lance le setup:

                > java -jar sikuli-setup.jar

                   Le reste est interactif.

        --------------------------
        Windows
        --------------------------

            Check des prérequis:

                http://www.sikuli.org/downloadrc3.html

            Installation du JDK (6 version 32 bit), la version 64 bit n'est pas supportée à ce jour. (pour la version 1.0rc3)

                http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase6-419409.html

            Installation de sikuli:

                https://launchpad.net/sikuli/+download

            Enjoy !


~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works ?
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Le langage 
        --------------------------

            Les scripts sikuli s'écrivent entièrement en python.
            On peut donc utiliser les méthodes de sikuli mais aussi importer ses propres modules ...

        --------------------------
        Raccourcis clavier
        --------------------------

            http://doc.sikuli.org/keys.html

            S'utilise en fonction de la bonne classe:
                __________________________
                Key: 
                    
                    Méthodes supportées:
                        type(), keyDown(), keyUp().

                    ENTER, TAB, ESC, BACKSPACE, DELETE, INSERT, SPACE, F1-F15
                    HOME, END, LEFT, RIGHT, DOWN, UP, PAGE_DOWN, PAGE_UP
                    PRINTSCREEN, PAUSE, CAPS_LOCK, SCROLL_LOCK, NUM_LOCK
                    NUM0-NUM9, SEPARATOR, ADD, MINUS, MULTIPLY, DIVIDE

                __________________________
                KeyModifier

                    Méthodes supportées:
                        click(), dragDrop(), doubleClick(), rightClick(), type()

                    ALT, CMD, CTRL, META, SHIFT, WIN
                
                __________________________
                Exemples:

                    type('sikuli' + Key.TAB + 'rox du poney' + Key.ENTER)
                    équivaut à
                    type('sikuli\trox du poney\n')

                    Combiner des touches:

                        type(Key.ESC, KeyModifier.CTRL + KeyModifier.ALT)
                        ou
                        type(Key.ESC, KeyModifier.CTRL | KeyModifier.ALT)

        --------------------------
        Screenshots/Régions
        --------------------------

            Sikuli fonctionne sur deux modèle d'image:
                
                Les screenshot:
                    Sikuli scan l'interface jusqu'au match

                Les région:
                    A l'avntage de faire gagner du temps à sikuli
                    Mais nécessite une résolution fixe et de ne pas bouger les éléments.

        --------------------------
        Les modifiers
        --------------------------

        --------------------------
        Méthodes sikuli
        --------------------------
                __________________________
                click:

                        Screenshot:
                        ``````````````````````````

                            Permet de scaner l'écran et de cliquer au bon endroit:

                            click("NouveauITIES.png")

                            On peut affiner le match, c'est à dire pour être sur qu'il ne tombe pas sur un pattern similaire:

                                click(Pattern("1427133172881.png").similar(0.91))

                            Il est possible de décaler le point du clic gace à la methode targetOffset:

                                click(Pattern("Vrilicationd.png").targetOffset(85,6))

                        Région:
                        ``````````````````````````

                            En insérant les coordoonées:

                            click(Region(887,590,146,167))

                __________________________
                wait:

                    Il faut parfois temporiser ses actions:

                        while not exists('screenshot'):
                            sleep(5)

                        ou avec la méthode intégrée à sikuli:

                        wait('screenshot', 5)
                        
                        on peut attendre jusqu'a tombée sur l'image souhaitée:

                        wait('screenshot', FOREVER)

                __________________________
                popup:
                    
                    Pour afficher un message graphiquement:

                        popup("mon Message")
                __________________________
                exists:

                    Retourne vrai ou faut si le screenshot est trouvé.

                    while exists('screenshot'):
                        sleep(5)

                    Note: on peut aussi utiliser waitVanish

                        waitVanish('screenshot', FOREVER)

                        On attend que l'image ne soit plus présente.

                    Exemple plus complexe de la doc:

                        On peut tester l'existence d'une image au sein d'une région:

                        MaRegion.inside().exists(monScreenshot):
                            sleep(5)

                        ou encore:

                        MaRegion.inside().wait(monScreenshot, FOREVER)

                __________________________
                type/paste:

                    type():
                        Surtout pour l'utilisation de touches spéciales.

                    Paste():
                        Pour les textes.
                        Evite les problèmes liés aux différent type de clavier (qwerty ...)

                    Note on peut directement écrire ou coller du texte en spécifiant la zone:

                    Exemples:

                        type("1401101608700.png", Key.NUM5 + "+" + Key.NUM5)
                        paste("1401101608700.png", "foo text")


~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        On réalise ses scenarios de test via l'IDE de sikuli.
        appelé sikulix sur la nouvelle version.

        Il est possible d'écrire directement ses scripts python à l'intérieur de l'IDE.

        --------------------------
        Démarrage
        --------------------------
                __________________________
                Mode gui:

                    soit via le jar
                    > java -jar sikuli-ide.jar

                    ou via le script
                    > ./runIDE
                    ou 
                    > ./runsikulix

                __________________________
                Mode console:

                    ./runsikulix -c -f FICHIER.log -r MON_SCRIPT

                    exemple:

                        ./runsikulix -c -f sikuli.log -r /home/sikuli/scenarii/testx.sikuli [--args '...']

                    Il est possible d'envoyer des arguments au script sikuli:

                        --args "mes arguments"

                    Voir aide: ./runsikulix -h    

        --------------------------
        Exemples de scenario
        --------------------------

                Toutes les possibilités d'automatisation par screenshot sont utilisable via le panel de gauche de l'IDE.

                Ensuite toute la rédaction du script peut se faire en python:


                __________________________
                Script calculatrice:

                    #import sys
                    #params=sys.argv[:1]

                    try:
                        click("1401101029271.png")
                        wait("1401101272843.png", 60)
                        type("1401101608700.png", Key.NUM5 + "+" + Key.NUM5)
                        click("1401101639225.png")
                        if not exists("1401101725853.png"):
                            raise ValueError("Wrong result")
                        click("1401113436758.png")
                        
                    except Exception as errorMessage:
                        print('Except type:', sys.exc_info()[0])
                        print('Except message:', errorMessage)
                        print('Error, scenario nok')
                    else:
                        print('scenario ok')

                __________________________
                Script mail:

                    if exists("1404074137492.png"):
                        click("1404074137492.png")
                        wait("1404074196639.png", 60)
                        click("1404074196639.png")
                        wait("1404242422479.png", 60)
                        paste("test@mail.fr")
                        sleep(1)
                        type(Key.TAB)
                        sleep(1)
                        paste("cucumber mail")
                        sleep(1)
                        type(Key.TAB)
                        sleep(1)
                        paste("This is an email autogenerate by sikuli script")
                        sleep(2)
                        if exists("1404081335505.png"):
                            click("1404081335505.png")          
                            wait("1404241483225.png", 30)
                            click(Region(771,27,27,28))
                            print( 'Message sent' )
                        else:
                            print( "No send picture" )
                    else:
                        print( "No icon" )


                        subtitle 4
                        ``````````````````````````
