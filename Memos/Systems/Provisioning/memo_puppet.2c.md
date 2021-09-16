==========================================================
                       P U P P E T
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Site officiel:
        --------------------------

            http://docs.puppetlabs.com/puppet/
            http://docs.puppetlabs.com/puppet/3/reference/
            http://docs.puppetlabs.com/references/latest/type.html

            Learn:
                http://docs.puppetlabs.com/learning/introduction.html

        --------------------------
        Tutos
        --------------------------

            http://doc.ubuntu-fr.org/puppet
            https://wiki.deimos.fr/Puppet_:_Solution_de_gestion_de_fichier_de_configuration#V.C3.A9rifier_la_syntaxe_de_ses_.pp
            http://garylarizza.com/blog/2013/12/08/when-to-hiera/

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Puppet est un gestionnaire de configuration centralisé, basé sur ruby.
    C'est un outil de provisioning au même titre que chef, salt, ansible ...

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Le puppet Master contient les configurations écritent avec la syntaxe puppet.
    Les agents se synchronisent régulierement avec le master pour récupérer les configurations.
    La configuration à appliquée s'appel un catalogue, il est obtenue grâce à la compilation des manifests (fichiers puppets pour écrire l'état des configuration des agents).

    Puppet utilise une hierarchie de fichier spécifique pour générer ses catalogues.

        --------------------------
        Les types d'installation
        --------------------------

            Deux types d'installation sont possible:

                __________________________
                Agent/master:

                    Les clients/noeuds (puppet agent/node) se réfèrent à la configuration du serveur puppet (puppet master).
                    [over https]

                __________________________
                Standalone:

                    Les clients compiles leur propre configuration, ils sont à la fois agent et master.

        --------------------------
        RAL Resources abstraction layer
        --------------------------

            https://docs.puppetlabs.com/puppet_core_types_cheatsheet.pdf

            Ce sont des objets constitués par des couples attributs/valeurs. 
            Elles définissent les objets d'un système comme un utilisateur, un paquet...

            Les étapes d'application d'une ressource sur un agent:

                read -> check -> write

            On gère les ressources puppet avec la commande 'puppet resource'.

                __________________________
                Déclaration de ressource:

                    Type_Ressource { 'Nom Ressource':
                        attribut => 'valeur',
                        attribut2 => 'valeur2',
                    }

                    exemple:

                        service { 'console-setup':
                            ensure => 'stopped',
                            enable => 'true',
                        }
                __________________________
                Faire une référence à une ressource dans un attribut:

                    Exemple, s'assurer que le package ntp à été installé:

                        
                        #Création de la ressource Package['ntp']
                        package { 'ntp':
                            ensure => installed,
                        }

                        #Installation du fichier de configuration
                        file { 'ntp.conf':
                            path    => '/etc/ntp.conf',
                            ensure  => file,
                            require => Package['ntp'],      #Référence à la ressource Package['ntp']
                            source  => "/root/examples/answers/${conf_file}"
                        }

                __________________________
                Installer plusieurs packages:

                    http://www.puppetcookbook.com/posts/install-multiple-packages.html

                    $enhancers = [ "screen", "strace", "sudo" ]
                    package { $enhancers: ensure => "installed" }

                    ou

                    Package { ensure => "installed" }
                    $enhancers = [ "screen", "strace", "sudo" ]
                    package { $enhancers: }

            D'autres ressources sont disponibles en ajoutant des modules.

        --------------------------
        Arborescence:
        --------------------------

            TODO

        --------------------------
        MANIFESTS
        --------------------------

            Les manifests sont les fichiers propres à puppet (monFichier.pp) contenant les déclarations des resources.
            Ils représentent l'état d'une configuration d'un noeud.
            Ces fichiers sont ensuite compilés par puppet, donnant un catalogue, puis appliqués sur le système de l'agent.

            On peut appliquer un manifest localement grâce à la commande 'puppet apply monManifest.pp'

                __________________________
                Créer un manifest:

                    exemple:
                        
                        > vim test.pp

                            file {'title':		            #Nom de la ressource
                                path => '/tmp/hello.txt',	#path vers lequel le fichier est uploadé
                                ensure => present,		    #s'assurer que le fichier est bien présent
                                mode => 0640,			    #droits par défauts
                                content => "hello_world\n",	#contenu du fichier (plus souvent un hash md5)
                            }

                            notify {"Hello de lu":
                                require => File['title'],
                            }

                        > puppet apply test.pp
                        > cat /tmp/hello.txt
                __________________________
                Commentaires :

                    # This is a comment

                    /*
                        This is a bigger 
                        comment
                    */

        --------------------------
        Ordonner - Ordering et Dépendances
        --------------------------

            Les ressources sont appliquées dans le "désordre".
            On peut donc ajouter des attributs pour gérer l'ordre d'application des ressources.

                __________________________
                before/require: 

                        Au niveau des ressources :
                        ``````````````````````````

                            - before: 
                                execute la ressource inscrite en argument après la ressource dans laquelle il est définit.

                            - require:
                                exécute la ressource inscrite en argument avant la ressource dans laquelle il est définit.

                            before => Type['maRessource']
                            require => Type['maRessource']

                            exemple:
                    
                                file {'/etc/foo.conf':
                                    ensure => 'present',
                                    source => '/dump/conf/foo.conf',
                                    require => Notify['installing']
                                    before => Notify['installed']
                                }

                                notify {'installing':
                                    message => 'Installing configuration file',
                                }
                                notify {'installed':
                                    message => 'Install finished',
                                }

                                ordre d'application:

                                    1 -> installing
                                    2 -> file
                                    3 -> installed


                        Au niveau des classes
                        ``````````````````````````

                            Créer des dépendances :

                            https://docs.puppetlabs.com/puppet/latest/reference/lang_classes.html#using-require

                            Pour les classes, les modules insrits au niveau des requires seront éxécutés avant ?
                            Du moins c'est ce qui est dit au niveau de la doc, mais impossible de constater ça.
                            Au moins le require doit créer une dépendance avec les modules cités (et doivent donc existés)

                            Par exemple :

                                class b()
                                {
                                    require a::install
                                    require a::configure

                                    ...
                                }

                                et ne pas ecrire :

                                    require a

                            /!\ Pour ordonner l'execution des modules, il faut voir côté chaînage et anchor.

                __________________________
                notify/subscribe

                    Ces metaparamètres permettent à une resource de se relancer après modificiation, comme par exemple les démons ...
                    Correspondances:

                        notify =~ before
                        subscribe =~ require

                    exemple (de la doc):

                        package { 'openssh-server':
                            ensure => latest,
                            before => File['/etc/ssh/sshd_config'],
                        }

                        file { '/etc/ssh/sshd_config':
                            ensure => file,
                            mode   => 600,
                            source => '/drop_conf/etc/sshd_config',
                        }

                        service { 'sshd':
                            ensure     => running,
                            enable 	   => true,
                            hasrestart => true,
                            hasstatus  => true,
                            subscribe  => File['/etc/ssh/sshd_config'],
                        }

                __________________________
                chainer:

                    Cette méthode est plus visuel, elle permet de définir l'ordre d'application des ressources avec des flèches:

                        Déclaration de la chaîne à la fin du manifest:
                        ``````````````````````````

                            Ressource['title'] -> Ressource2['title2'] ...

                            exemple:

                                file {'/etc/foo.conf':
                                    ensure => 'present',
                                }

                                notify {'installing':
                                    message => 'Installing configuration file',
                                }

                                notify {'installed':
                                    message => 'Install finished',
                                }

                                Notify['installing'] -> File['/etc/foo.conf'] -> Notify['installed']


                        Chaîner avec les caractères clés :
                        ``````````````````````````

                            [ -> ] Appliquer d'abord la ressource de gauche, puis celle de droite :

                                MaResource {'name':
                                }
                                ->
                                MaResource2 {'name':
                                }
                                -> 
                                ...

                            [ ~> ] Appliquer d'abord la ressource de gauche, puis si celle-ci opère de nouveaux changements, continuer sur celle de droite :

                                MaRessource {'name':
                                }
                                ~>
                                MaRessource2 {'name':
                                }
                                ~>

                        Chaîner des classes :
                        ``````````````````````````

                            On peut executer des classes dans l'ordre avec include et le chainage :

                            class a()
                            {
                                include a::install
                                include a::configure

                                Class['a::install'] -> Class['a::configure']
                            }

                            /!\ Attention, d'autres classes peuvent être executée entre a::install et a::configure.


                    Note:
                        Il est aussi possible de changer le sens des flèches mais attention à la compréhension du coup ;).

                __________________________
                anchor: 

                    http://projects.puppetlabs.com/projects/puppet/wiki/Anchor_Pattern

                    Cette méthode est utile pour chainer des classes entre elles.

                    Par exemple dans notre init.pp
                    On va définir toute les classes à inclure et dans l'ordre que l'on souhaite.

                    Il faut d'abord installer stdlib et activer pluginsync sur les agents.

                    > puppet module install puppetlabs-stdlib
                    > cp -r stlib /module/paths

                    On chaîne ensuite les classes de cette manière:

                        anchor { 'wrapper::begin': } ->
                        class { 'maclass::install': } ->
                        class { 'maclass::config': } ->
                        class { 'maclass::service': } ->
                        anchor { 'wrapper::end': }

                __________________________
                Classes: 

                        Ordonner :
                        ``````````````````````````
                            Pour ordonner les classes , le plus simple est d'utiliser simplement :

                            class b ()
                            {
                                include b::install
                                include b::configure

                                Class['::a::configure'] -> 
                                Class['b::install'] ->
                                Class['b::configure'] ->
                            }

                            Note, un include sera surement nécessaire pour les modules qui ne sont pas déja lié au noeud puppet.

                        require, contain, include 
                        ``````````````````````````
                            https://docs.puppetlabs.com/puppet/latest/reference/lang_classes.html#resource-like-behavior

        --------------------------
        Variables - Types de données
        --------------------------

            https://docs.puppetlabs.com/puppet/latest/reference/lang_datatypes.html
                __________________________
		        Déclaration:

                    On utilise le signe '$' pour déclarer une variable:

                        $maVariable = maValeur

                    La valeur d'une variable peut être:

                        - une châine
                        - un nombre
                        - un boolean
                        - un tableau
                        - un hash
                        - undef

                    On peut faire référence à une variable avec les accolades pour bien les distinguer:

                        ${maVariable}
                        ou 
                        $maVariable

                    Les variables ont deux "noms":

                        - locale
                        - externe
                __________________________
		        locales

                    Pour appeler une variable déclarée dans son manifest.

                    Déclaration:
                        $variable = 'something'
                        $variable = "something ${else}" #Avec interprétation d'une autre variable

                    exemple:
                        
                        value = "contained"
                        ressource {'title':
                            key => $value,
                        }

                __________________________
                externes "long fully-qualified name"

                    Pour appeler une variable externe à son manifest.

                    $scope::variable

                    $::variable     #Fait référence au plus haut niveau

                    voir la partie scope

                __________________________
                Tableaux:

                    $montableau = [
                        'val1',
                        'val2',
                        'val3'
                    ]

                    Accéder aux valeurs:

                        $montableau[0] ...

                    Tableau de hash:

                        $th = [
                            { name => polo, id => plop },
                            ...
                        }

                        Accès:

                            $th[0][name] ...

                __________________________
                Hash:

                    $monhash = {
                        key => 'value'
                        key2 => 'value2'
                    }

                    Accéder aux valeurs:

                        $monhash[key] ...

        --------------------------
        Scope
        --------------------------

            https://docs.puppetlabs.com/puppet/latest/reference/lang_scope.html

            Puppet permet d'accéder aux divers éléments de son arboressence grâce à sa syntaxe de 'scope':
                __________________________
                Les différents niveaux:

                    - Top Scope: le plus haut niveau:
                        * ne voit que ses variables
                        * par exemple tout ce qui est définit dans site.pp au dessus des classes et des nodes.

                    - Node Scope: Au niveau de la définition d'un noeud:
                        * voit ses variables et le top scope
                        * par exemple tout ce qui est compris dans "node { ... }" dans site.pp

                    - Parent class scope: Au niveau de la définitition d'une classe
                        * Voit tout sauf ses parents.
                        * par exemple tout ce qui est définit dans "class { ...}" dans init.pp, maClass.pp ...

                    - Jusqu'aux enfants (on garde la même logique)

                __________________________
                variables:

                    Pour accéder à une variable définie localement dans sa classe, on utilisera:

                        $ma_variable

                    Pour accéder à une variable définie dans son module mais dans une autre classe:

                        $maclasse::ma_variable

                    Et enfin pour faire référence au top niveau (facts/site.pp), c'est à dire les variables définits hots classes, on utilise la syntaxe suivante:

                        $::top_level_var
            
                __________________________
                classes:

                    Pour faire référence à une classe de son module:

                        require maclasse::maclasse_enfant

                    Pour faire référence à une classe externe à son module:

                        require ::maclasse_ext

        --------------------------
        Facts
        --------------------------

			Les facts sont des variables crées par puppet contenant un tas d'informations liées au système.
			Elles sont crées grâce à facter, un outil intégré à puppet et sont propres à chaque système.
            Puppet collect les facts avant de demander un catalogue.

			Some facts:

				${hostname}, ${operatingsystem}, ${domain} ...

			Afficher tous les facts:

                > facter

            On fait souvent rérérence aux facts en utilisant cette notation:

                $::maVariable

                __________________________
                Créer ses facts:

                    http://docs.puppetlabs.com/guides/custom_facts.html
                    https://docs.puppetlabs.com/facter/latest/custom_facts.html

                    Il suffit de créer des fichier ruby de cette manière:

                    > vim compant.rb

                        Facter.add('company') do
                            setcode do
                                Facter::Core::Execution.exec('/bin/cat /etc/puppet/company.conf')
                            end
                        end

                    Un nouveau fact 'company' vien d'être crée !

                    Il ne reste qu'a le charger au niveau de facter:


                        Utiliser ses facts custom:
                        ``````````````````````````

                            Il existe plusieurs méthodes pour charger ses facts,

                            Au niveau des agents:

                                Soit les palcer au niveau du path par défaut:

                                    /usr/lib/ruby/vendor_ruby/facter

                                Il est aussi possible de configurer son propre path:

                                    > vim /etc/puppet/puppet.conf

                                        factpath=$vardir/lib/facter

                            Au niveau du master:

                                Pour distribuer les nouveaux facts, il faut ajouter:
                                    pluginsync=true
                                 au niveau de la configuration du node

                                Et placer ses facts dans {module_path}/{mon_module}/lib/facter/

                                -> Voir la partie PLUGINS pour charger automatiquement ses facts.

        --------------------------
        Conditions
        --------------------------

                __________________________
                If:
                    if condition and condition2 {
                        code
                    }
                    elsif condition {
                        code
                    }
                    else {
                        code
                    }

                    exemple:

                    if $enable_ssh == 'true'
                    {
                        service { 'sshd':
                            name	   => 'sshd',
                            ensure     => running,
                            enable 	   => true,
                            hasrestart => true,
                            hasstatus  => true,
                            require  => Package['openssh-server'],
                        }
                    }

                    Ce qui peut être interprété comme faux:
                        -false 
                        -undef 
                        -''

                    Opérateurs: 
                        ==, !=, <, >, <=, >= (classique)
                        =~, !~ (regex)
                        in (test si le le composant de gauche se trouve dans celui de droite)

                __________________________
                Case:

                    case $operatingsystem {
                        centos: { $apache = "httpd" }
                        debian, ubuntu: { $apache = "apache2" }
                        default: { fail{"Unrecognized operating sytem") }
                    }
                    package {'apache':
                        name => $apache,
                        ensute => latest,
                    }

                    case $ip_address {
                        /^127[\d.]+$/: {
                            notify {'misconfig':
                                message => "Network misconfig: check $0 IP",
                            }
                        }
                    }
            
                    On peut utiliser les références arrières pour les regex: $1 = premier match ... $0 = tout les matchs.

                __________________________
                Selector:

                    $apache = $operatingsystem ? {
                          centos                => 'httpd',
                          redhat                => 'httpd',
                          /(?i)(ubuntu|debian)/ => "apache2-$1",
                          default               => undef,
                    }	

                    selector offre une syntaxe différente de case.

        --------------------------
        Loop - Itérations
        --------------------------

            https://docs.puppetlabs.com/puppet/latest/reference/lang_iteration.html
            https://docs.puppetlabs.com/puppet/latest/reference/experiments_lambdas.html#content

            Les boucles (for) ne sont pas présentent pas défaut.
            Il faut activer le parser "future" pour bénéficier de cette fonctionnalité:

                __________________________
                Activation du parser:

                    Au niveau du master:

                        > vim /etc/puppet/puppet.conf

                            [main]
                            ...
                            parser = future

                __________________________
                each:

                    Pour boucler sur un tableau ou un hash:

                    each($monTableau) |$indice, $value| {
                        Mes ressources...
                    }

                    Exemple:
                
                        $shinken_modules = [ 'mongodb', 
                                            'mod-mongodb', 
                                            ... ]

                        each($shinken_modules) |$i, $mod| {
                            exec {"install_shinken_module_$mod":
                                command     => "shinken install $mod",
                                timeout     => "14400",
                                path        => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                                require     => Exec['init_shinken']
                            } 
                        }

                    /!\ ne pas chainer (->) des ressources avec un each, vous aurez le droit à une erreur.
                        Obliger d'utiliser un require.
                __________________________
                map:

                    Transformer un tableau ou un hash dans un nouveau
                __________________________
                filter:

                    Filtre les éléments du tableau à afficher
                __________________________
                reduce:

                    Réduire un tableau en une seule valeur
                __________________________
                slice:
                    
                    Créer des couples de valeurs

                __________________________
                Avec les anciennes version :

                    Fonctionne avec une fonction et un tableau en argument :

                    Méthode :

                        #On définit une fonction :

                            define maFonction { 
                                #On définit une ressource et on utilise la variable ${title} pour récupérer la valeur de chaque itération
                                maResource {"${title}":
                                    param => ${title},
                                    ...
                                }
                            }

                            #On appel la fonction avec les paramètres que l'on souhaite executer :
                            maFonction { [ 'arg1', 'arg2', ... ]: }


                    Exemple :

                        ***********************************
                        class gpg::common {

                            $gpg_keys = [ "key1", "key2" ]

                            define copy_keys {
                                file {"gpg_key_${title}":
                                    path => "/root/${title}",
                                    ensure => file,
                                    source => "puppet:///modules/gpg/${title}",
                                    mode => '0644',
                                    #notify => Exec["import_gpg_key_$key"],
                                }
                            }

                            define import_keys {
                                exec {"import_gpg_key_${title}":
                                    command => "gpg --import /root/${title}",
                                    path        => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                                }
                            }

                            copy_keys { $gpg_keys: } ->
                            import_keys { $gpg_keys: }
                        }
                        ***********************************

                        
        --------------------------
        Classes (rôles, aspects)
        --------------------------

            https://docs.puppetlabs.com/puppet/latest/reference/lang_classes.html

            Les classes vont nous permettrent de séparer le code logiquement.
                __________________________
                Déclaration:

                     exemple:

                         > vim ntp-class.pp

                           class ntp {
                                package { 'ntp':
                                    ensure => installed,
                                }
                           }

                __________________________
                Tester son application:

                    > puppet apply --debug --verbose ntp-class.pp
                    
                    Pour appliquer les changements il se peut que l'option -e soit requise :

                        > puppet apply --debu --verbose -e "moduleName::className"

                __________________________
                Appeler une classe :

                    Pour utiliser une classe dans son manifest:

                        class foo {
                            include classname
                            include classname1
                        }

                        Les classe incluses seront appliquée avant la classe dans laquelle elles sont incluse.
                        Mais il n'y pas d'ordre spécifié.


                    Sans paramètes :

                        class {'maclass':}

                        ou

                        Class['par::child']

                    Avec paramètes :

                        class {'maClass':
                            param1 => 'foo'
                            param2 => 'foo2
                        }

                    Pour ordonner l'application des classes :

                         class roles::ecommerce_app {
                             include profiles::dbserver
                             include profiles::webserver
                             Class['profiles::dbserver'] -> Class['profiles::webserver']
                         }

                         ou avec anchor :

                         anchor { 'wrapper::begin': } ->
                         class { 'maclass::install': } ->
                         class { 'maclass::config': } ->
                         class { 'maclass::service': } ->
                         anchor { 'wrapper::end': }

                __________________________
                Nommage:

                    On peut utiliser les :: pour faire apparaitre les relation avec des classes parentes.
                    exemple:

                        apache::ssl
                        apache::vhost

                __________________________
                Require:

                    require => Class['module::subdir::class']

                    exemple:

                        require => Class['ssh::server::install']



                __________________________
                Paramètres:

                    Lorsque l'on souhaite appliquer des paramètres par défaut à une classe, 
                    on peut utiliser la syntaxe suivante:

                        class maClass (
                            $param1 = 'bidul',
                            $param2 = {}
                        ) { 
                            ...
                        }



                        les paramètres pourront être utilisés comme des variables locales.

                    Maintenant si l'on souhaite appeler cette classe en lui donnant des paramètres:

                        class {'maClass':
                            param2 => 'foo'
                        }

                        Note: 
                            Si l'on passe par un include ou que l'on ne définit pas de paramètres,
                            Puppet cherchera les données au niveau de Hiera


                __________________________
                Héritage d'une classe:

                    Il est possible d'hériter des attributs d'une autre classe.

                    On utilise usuellement l'heritage avec la class params.
                    Cela permet d'évaluer en premier lieu params:

                    exemple:

                        class maClass (
                            $param = maClass::params::myparam
                        ) inherits maClass::params {
                            ...
                        }


        --------------------------
        Modules
        --------------------------

            http://docs.puppetlabs.com/module_cheat_sheet.pdf

            Les modules sont en faites des classes organisées dans une structure.
            Ils sont chargés automatiquement.

                __________________________
                Structure:

                    module_name/
                    
                        manifests/		#Contient tout les manifests
                        
                            init.pp 	#Définition de la classe (Utilisable avec le même nom du module)

                            #site.pp     #Premier fichier lu par le Master pour determiner un catalogue.
                                        On y définit les variables globales, les modules à importer en fonction des noeuds ciblés.
                                        (A placer au niveau du dossier manifests de puppet et non du module)
                            
                            templates.pp    #Définit toutes les classes modèles.

                            #nodes.pp        #Définit tous les noeuds auxquels on peut appliquer ce module. 
                                        (A placer au niveau du dossier manifests de puppet et non du module)

                            other_class.pp 	#module_name::other_class

                            implementation/

                                foo.pp	#module_name::implementation::foo

                        files/			#Contient tous les fichiers susceptibles d'être téléchargés par les nodes. 
                                        #Ils sont accessibles depuis l'URL puppet:///modules/module_name/filename

                        lib/			#Contient tous les plugins (Ces propres ressoures, facts...)

                        templates/		#Contient les fichiers modèles propres au module.

                        tests/			#Contient des exemples de déclaration des classes.
                                    #http://docs.puppetlabs.com/guides/tests_smoke.html

                        specs/          #todo

                __________________________
                Déclaration

                    modulpath : permet de chercher des modules:

                        > puppet apply --configprint modulepath
                        /etc/puppetlabs/puppet/modules:/opt/puppet/share/puppet/modules

                        todo: voir configprint

                    Rendre un module utilisable depuis n'importe quel emplacement
                    (Il faut que le fichier contenant la classe soit placé dans un dossier manifests de la façon suivante) :
                        
                        > mkdir -p /etc/puppetlabs/puppet/modules/classname/manifests
                        >	puppet apply -e "include classname"

                    Pour utiliser un fichier contenu dans une classe:

                    exemple:

                         file { 'file.conf':
                            ...
                            source => "puppet:///modules/classname/${foo_conf},
                         }

                __________________________
                Références, Paths

                    Pour faire référence à une classe dans un module, on l'appel de la manière suivante:

                        <MODULE NAME>::<SUBDIR NAME>::<FILE/CLASS NAME> 

                        Exemple:

                            apache/manifests/mod_passenger.pp

                            Le nom de mod_passenger sera:

                                apache::mod_passenger

                __________________________
                Puppet Forge
        
                    La "puppet forge" est un dêpot contenant des modules déjas établis:

                        http://forge.puppetlabs.com/
                        https://puppetlabs.com/category/blog/module-of-the-week-blog/

                __________________________
                Installer un module:

                    > puppet module install module_name	#Installer le module
                    > puppet module list			#Afficher les modules installés

                    http://docs.puppetlabs.com/puppet/latest/reference/modules_installing.html

                __________________________
                Paramètres:

                    Les paramètres permettent d'appeler une classe en lui soumettant des variables:
                        
                        #.../modules/module_name/manifests/init.pp

                        class module_name ($value1, $value2 = "optional default")
                        {
                            notify {"Value 1 is ${value1}.":}
                            notify {"Value 2 is ${value1}.":}
                        }

                        #..../test_param.pp

                        class {'module_name':
                            value1 => 'Something',
                        }

                        On peu aussi envoyé un array en paramètre:

                        > value => [ "case1", "case2", ] ,

                __________________________
                Rdoc:

                    Dans le cadre d'une réutilisation, il est très recommandé de créer la doc de son module:

                    http://rdoc.rubyforge.org/RDoc/Markup.html

                    exemple:

                    > todo

                    Parcourir la doc:

                    > puppet doc --mode rdoc --outputdir ~/moduledocs --modulepath /etc/puppetlabs/puppet/modules


        --------------------------
        TYPES
        --------------------------

            Les TYPES vont nous permettre de définir nos propres ressources.

                __________________________
                Définir un type:

                    define typename ($title, $content)   	#La variable title est optionnel et automatiquement crée.
                    {
                        resource {"$title.typename": 	#Il vaut veuiller a ce que le titre d'une ressource possible varie à chaque appel.
                            ...			#Sinon puppet retournera une erreur du type "already defined"
                        }
                        ...
                    }

                    typename {'foo':
                        content => "something",
                    }

                    Ainsi un type contient un nom, des paramètres et une liste de ressource.
                    Il est comparable à une macro.
                    
                    Ensuite on l'ajoute de la même manière qu'une classe dans un module: dans le folder manifests.

        --------------------------
        PLUGINS
        --------------------------

            https://docs.puppetlabs.com/guides/plugins_in_modules.html#content

            Les plugins vont nous permettre de distribuer des facts, des ressources custom au travers des modules.
            On les écrits au niveau du master.

            Exemple:

                {modulepath}
                └── {module}
                    └── lib
                        |── augeas
                        │   └── lenses
                        ├── facter
                        └── puppet
                            ├── parser
                            │   └── functions
                            ├── provider
                            |   ├── exec
                            |   ├── package
                            |   └── etc... (any resource type)
                            └── type

            Pour activer les plugins au niveau des agents:

                [main]
                pluginsync = true

        --------------------------
        REFERENCES
        --------------------------

            > todo

        --------------------------
        TEMPLATES - TEMPLATING
        --------------------------

            https://docs.puppetlabs.com/guides/templating.html
            https://docs.puppetlabs.com/learning/templates.html
            http://ruby-doc.org/stdlib-1.8.7/libdoc/erb/rdoc/ERB.html
            http://docs.puppetlabs.com/guides/templating.html#erb-template-syntax

            Le but des templates est d'alléger les fichiers de configuration:
            Au lieu d'avoir un fichier de config par type de config, on aura un seul fichier implémentant du code Ruby (ERB) et s'adaptant aux types de config.

                __________________________
                Appeler un template:

                    On utilise le mot clé template('monModule/monTemplate.erb')

                    Exemple:

                        file { 'broker_master_cfg':
                            path    =>  '/etc/shinken/brokers/broker-master.cfg',
                            content =>  template('shinken/broker-master.erb'),
                            owner   =>  'shinken',
                            group   =>  'shinken',
                            mode    =>  '0644',
                        } 

                    Il est possible de concaténer plusieurs templates :

                         template('my_module/template1.erb','my_module/template2.erb')

                         Note :

                            On peut le faire au niveau même du template (voir la partie "fonctions")



                __________________________
                Définir un template:

                    On écrit nos templates à la racine du module, dans le dossier template (au même niveau que le dossier manifests)

                    Exemple:

                        monModule
                        ├── manifests
                        └── templates
                            ├── broker-master.erb


                        > vim broker-master.erb

                            #mon fichier de config
                            avec son contenu
                            et du code ruby qui sera substitué
                            <% mon code ruby substitué %>
                            fin de mon fichier

                __________________________
                Insérer du ruby (Tags):

                        Commentaire :
                        ``````````````````````````
                            <%# comment %>	

                        Afficher :
                        ``````````````````````````
                            <%= Ruby expression / variables %>

                        Evaluer du code :
                        ``````````````````````````
                            <% Ruby code %>

                            Il est possible de supprimer les espaces avant ou après des tags:

                                <%- : supprime les espaces avant 
                                -%> : supprime les espaces après

                        Echapper un tag d'évaluation :
                        ``````````````````````````
                            <%% or %%> — A literal <% or %>, respectively.

                __________________________
                Appeler des variables (références):

                    On peut faire référence aux variables ou aux fact de notre module directement avec un @maVariable à la place du $:

                        Dans son scope:
                        ``````````````````````````
                            @fqdn
                            @in_scope_variable

                        En dehors de son scope:
                        ``````````````````````````
                            scope.lookupvar('::path::to::out_scope_variable')

                        Exemples:
                        ``````````````````````````

                            #Définition des modules:

                                $broker_modules = [
                                    'webui',
                                    'livestatus',
                                    ...
                                ]

                                $_module = $broker_modules

                                file { 'monFichier':
                                    ...
                                    content => template('monModule/monTemplate')
                                }

                            #Insertion au niveau du template:

                                #En dehors de son scope:

                                    modules <%= scope.lookupvar('shinken::config::broker_modules') %>

                                #Loop sur une ligne différente à chaque itération:

                                    <% @_modules.each do |mod| -%>
                                        modules <%= mod %>
                                    <% end -%>

                                #Loop sur une seule ligne:

                                    modules <%- @_modules.each do |mod| -%> <%= mod %>, <%- end -%>

                __________________________
                Le code ruby :

                        Itération :
                        ``````````````````````````

                            $values = [val1, val2, otherval]

                            <% @values.each do |val| -%>
                            Some stuff with <%= val %>
                            <% end -%>

                        Conditions :
                        ``````````````````````````

                            <% if @broadcast != "NONE" %> broadcast <%= @broadcast %> <% end %>

                        Accéder aux différentes classes et tags :
                        ``````````````````````````

                            TODO
                            
                        Fonctions :
                        ``````````````````````````

                            Inclure un autre template :

                                <%= scope.function_template(["my_module/template2.erb"]) %>

                            Loguer un Warning :

                                <%= scope.function_warning(["Template was missing some data; this config file may be malformed."]) %>

                            
        --------------------------
        NODES - TARGETING
        --------------------------

            Il est possible de définir au même titre qu'une classe, un noeud (node).
            Tout ce qui sera inclus dans ce bloc sera appliqué uniquement pour le neud définit:
            Il ne peut y avoir qu'une déclaration pour ce noeud.
            Le nom du noeud correspond au certname de la conf

            exemple:

                node 'hostname.domain.lan' {
                    
                    include classname
                    include XXXX
            
                    class {'ntp':
                        enable => false,
                        ensue => stopped,
                        }
                }

        --------------------------
        LAYOUT Agent/Master
        --------------------------

            Fonctionnement Agent/master:

                Le master ne diffuse jamais ses manifestes aux Agents pour ne pas envoyer d'informations qui ne les regardes pas:

                L'agent envoie donc une requêtes pour accéder au catalogue (Request calaog) avec ses variables (facts);
                Le master compile les manifestes avec les valeurs envoyées par l'agent et envoie le catalogue au client.
                Le client applique le catalogue (comparaison avec le système ...) et envoie un rapport au master.

                1: NODE ===  (FACTS)  ==> MASTER (Génère le catalogue qui spécifie dans quel état le noeud doit se trouver)
                2: NODE <== (CATALOG) === MASTER (Envoi le catalogue à l'agent)
                3: NODE === (REPORT)  ==> MASTER (Envoie les modifications qui ont été appliquées au Master)


        --------------------------
        L'environnement
        --------------------------

            https://docs.puppetlabs.com/puppet/latest/reference/environments.html
        
        L'idée ici est d'avoir des manifest et modules différents pour chaque dossier d'environnement comme par exemple 'Production', 'Dev' ...
                __________________________
                File environement (DEPRECATED):

                    Les environnements: (Par ordre croissant d'intéressement)

                        [main]                  #: Les valeurs de ce block sont appliquées uniquement si elles n'ont pas été trouvées avant.
                        [agent],[master],[user] #: Correspondent aux valeurs des différents modes de puppet. 
                            [user] correspond aux applications puppet.

                        [environnement_test]    #: le nom de l'environnement est ici custom par l'administrateur.

                            modulepath = $confdir/environments/test/modules:$condfir/modules:/usr/share/puppet/modules
                            manifest = $confdir/environments/test/manifests
                            config_version = /usr/bin/git --git-dir $confdir/environments/test/.git rev-parse HEAD

                            Peu de valeurs peuvent être inscrite dans ces block. Certaines sont propres aux modes de puppet (master,agent...)

                __________________________
                Dir environement:

                    https://docs.puppetlabs.com/puppet/latest/reference/environments_creating.html
                    https://docs.puppetlabs.com/puppet/latest/reference/environments_configuring.html
                    https://docs.puppetlabs.com/puppet/latest/reference/config_file_environment.html

                    Cette méthode (Directory Environment) est à préférer par rapport à une modification brut des paths dans le fichier de config (Config File Environments)

                    Pour activer ce mode:

                        [main] #ou master.
                            environmentpath=$confdir/environments

                    On Créer ensuite un dossier d'environement:
                        > mkdir manifests \
                            modules \

                    On édite le fichier de conf de notre environements:
                        
                        > vim environment.conf

                            modulepath = modulepath = modules:$basemodulepath
                            #manifest = manifests   #utilisé par défaut
                            #config_version=
                            #environment_timeout=

                    On ajoute les noeud à leur environement:

                        Au niveau des agents, on ajoute le paramètre suivant:

                            environment=monEnvironement

                        Par défaut: production

        --------------------------
        HIERA
        --------------------------

            https://docs.puppetlabs.com/hiera/1/puppet.html
            https://docs.puppetlabs.com/hiera/1/hierarchy.html
            http://puppetlabs.com/blog/first-look-installing-and-using-hiera
            http://garylarizza.com/blog/2013/12/08/when-to-hiera/

            Ou encore comment séparer les données des manifests?
            Hiera permet d'aporter de la portabilité et à votre code puppet.
            Et de centraliser les variables de configuration. (à la manière de Saltstack et des pillars)

            Bientôt intégré completement à puppet et non plus en tant que module.

            Attention à bien suivre les prérequis pour installer les repos Puppet Labs

                __________________________
                Bests practises:

                    - Utiliser Hiera que pour les données 'sensibles' ou spécifiques.
                      C'est à dire tout ce que l'on ne souhaiterais pas partager dans le cas où l'on partagerai son module.
                    - Utiliser les Roles/Profiles pour créer des classes 'wrapper' pour les déclaration de classe.
                    - Placer les subsitutions Hiera dans les classes profiles
                    - Garder la classe 'params' pour tout ce qui est path ...
                    - Les classes rôles ne doivent include que des classes profiles

                __________________________
                Data Bindings:

                    Disponible à partir de la version 3:

                    Cette fonctionnalité intègre automatique les subsitutions de Hiera.

                    Si puppet ne trouve pas de données pour une variable paramétrée,
                    il recherche dans les données définit dans Hiera.

                __________________________
                Vérifiez si hiera n'est pas déja installé:

                    > sudo puppet resource package hiera ensure=installed

                    Pour puppet < 3:
                        > sudo puppet resource package hiera-puppet ensure=installed

                __________________________
                Installation:

                    > gem install hiera 

                    Pour puppet < 3:
                    
                        > gem install hiera-puppet
                    
                    Telecharger ensuite le module:

                        > sudo puppet master --configprint modulepath
                        > curl -L https://github.com/puppetlabs/hiera-puppet/tarball/master -o \
                          'hiera-puppet.tar.gz' && mkdir hiera-puppet && tar -xzf hiera-puppet.tar.gz \
                          -C hiera-puppet --strip-components 1 && rm hiera-puppet.tar.gz


                    On redémarre le daemon:
                        > sudo service puppetmaster restart

                __________________________
                Exemple de structure hieradata:

                        # /etc/puppet/hieradata/appservers.yaml
                        ---
                        proxies:
                            - hostname: lb01.example.com
                              ipaddress: 192.168.22.21
                            - hostname: lb02.example.com
                              ipaddress: 192.168.22.28

                __________________________
                Récupérer les données:

                        # Get the structured data:
                        $proxies = hiera('proxies')
                        # Index into the structure:
                        $use_ip = $proxies[1]['ipaddress'] # will be 192.168.22.28

                __________________________
                Best practises avec des environnements

                    Au niveau du hiera.yaml

                        ---
                        :backends:
                            - yaml
                        :yaml:
                            :datadir: '/etc/puppetlabs/puppet/environments/%{environment}/hieradata'
                        :hierarchy:
                            - %{::certname}
                            - common

                    Arborescence type:

                        environments/
                            |-- development
                            |   |-- hieradata
                            |   |   |-- Debian.yaml
                            |   |   |-- RedHat.yaml
                            |   |   `-- common.yaml
                            |   |-- manifests
                            |   |   `-- site.pp
                            |   `-- modules
                            |       `-- ssh
                            `-- production
                                |-- hieradata
                                |   |-- Debian.yaml
                                |   |-- RedHat.yaml
                                |   `-- common.yaml
                                |-- manifests
                                |   `-- site.pp
                                `-- modules
                                    `-- ssh
                __________________________
                Utiliser automatiquement les données hiera

                    Puppet utilise hiera automatiquement au niveau des paramètres de classe.

                    Exemple:

                        class myclass ($parameter_one = "default text") {
                          file {'/tmp/foo':
                            ensure  => file,
                            content => $parameter_one,
                          }
                        }

                        
                        1: Puppet va d'abord regarder si la classe est appelée avec le parameter_one
                        2: Sinon il va regarder au niveau de Hiera si une variable est définit:
                            
                            ---
                            myclass::parameter_one: 'other special text'

                            (En prenant la première variable définit hiérarchiquement)

                        3: Sinon il prend la valeur par défaut.
                        4: Sinon il crache une erreur.


                    Si l'on souhaite désactiver cette fonctionnalitée au niveau de puppet.conf:

                        data_binding_terminus = none

        
                __________________________
                Classes:

                    Il est possible d'appliquer des classes au niveau de hiera.

                    C'est à dire de se passer de la définition des noeuds dans site.pp

                    Il suffit d'écrire le mot clé 'hiera_include('key') au niveau du fichier site.pp:

                        exemple:

                            hiera_include('classes')

                    Et de définir le tableau classes dans les fichiers yaml de hiera

                        exemple:

                            #common.yaml
                            ---
                            classes:
                                - base
                                - security

                            #web.yaml
                            ---
                            classes:
                                - nginx
                                - php

                    Si par exemple on aurait définit au niveau de hiera.yaml:

                        :hierarchy:
                         - "%{::clientcert}"
                         - common

                        On appliquerait les classes:

                            - php
                            - nginx
                            - security
                            - base

        --------------------------
        Rôles et Profiles
        --------------------------

            Considérer comme une best practise, 

            Avec des classes profiles contenant tout les éléments de configuration pour un service particulier.
            Et des classes rôles incluant uniquement des classes profiles.

            Exemple:

                Profile:

                    class profiles::wordpress {
                      # Data Lookups
                      $site_name               = hiera('profiles::wordpress::site_name')
                      $wordpress_user_password = hiera('profiles::wordpress::wordpress_user_password')
                      $wordpress_db_password   = hiera('profiles::wordpress::wordpress_db_password')
                      ...

                      ## Create user
                      group { 'wordpress':
                        ensure => present,
                      }
                      user { 'wordpress':
                        ensure   => present,
                        gid      => 'wordpress',
                        password => $wordpress_user_password,
                        home     => '/var/www/wordpress',
                      }
                      ...
                    }

                Rôle:

                    class roles::website {
                      include profiles::apache
                      include profiles::wordpress
                      include profiles::mysql
                      ...
                    }    

        --------------------------
        Anchor
        --------------------------

        --------------------------
        Fonctions
        --------------------------

            https://docs.puppetlabs.com/references/latest/function.html#defined

            Puppet disposent de ses propres fonctions comme alert, each, defined ...

            En voici quelques une :

                __________________________
                defined :

                    tester si une variable est définie :

                        if defined(File['/tmp/foo']) {
                             notify { "This configuration includes the /tmp/foo file.":}
                        }

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Pré-requis
        --------------------------
                __________________________
                Réseaux:

                    - le port d'écoute du server est le 8140.
                    - Chaque noeud doit avoir un hostname différent.
                    - Résoudre les noms d'hôtes (DNS, hosts)
                    - Avoir un serveur NTP (évite les problèmes de certificats expirés)

                __________________________
                Repo puppet:

                    https://docs.puppetlabs.com/guides/install_puppet/install_debian_ubuntu.html
                
                    > wget http://apt.puppetlabs.com/puppetlabs-release-$DISTRIB.deb

                    exemple avec debian squeeze:

                        > lsb_release -a
                        > wget https://apt.puppetlabs.com/puppetlabs-release-squeeze.deb

                        ou pour la version stable, simplement:
                        > wget https://apt.puppetlabs.com/puppetlabs-release-stable.deb

                        > dpkg -i puppetlabs-release-*.deb
                        > apt-get update

                    Exemple pour Redhat :

                        > rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

                __________________________
                Versions:

                    Les agents et le master doivent être au même niveau de version pour éviter tout conflit.

                        > puppet --version

        --------------------------
        Master
        --------------------------

            Debian like :

                > apt-get install puppetmaster puppetmaster-common
                > /etc/init.d/puppetmaster status

            Redhat like :

                > yum install puppet-server

                __________________________
                Activer le service:

                    > puppet resource service puppetmaster ensure=running enable=true

                __________________________
                Passenger (optionel)

                    Passenger est la méthode à utiliser avec un server web evolutif (type apache).
                    Ceci est nécéssaire pour avoir de meilleurs performance et dans le cas ou l'infrastructure mise en place est sérieuse.

                    C'est à dire dès que l'on touche à de la production et qu'on s'écarte de l'environnement de test.

                    > aptitude install puppetmaster-passenger

                    (Voir sinon du coté de NGINX et Mongrel)

        --------------------------
        Agent - Linux
        --------------------------

            Debian like :

                > apt-get install puppet
                > service puppet status

            Redhat like :

                > yum instal puppet
                > service puppet status

        --------------------------
        Agent - Windows
        --------------------------
                __________________________
                Pré-installation:

                    https://docs.puppetlabs.com/guides/install_puppet/pre_install.html

                    - Le master doit être accessible (attention aux règle de firewall) et sous linux.

                __________________________
                Script d'installation:

                    https://docs.puppetlabs.com/guides/install_puppet/install_windows.html

                    Download du msi:

                        https://downloads.puppetlabs.com/windows/

                        (voir la version du puppet master)

                    Installation:

                        Soit graphiquement (execution du msi)
                        
                        ou manuellement:

                            exemple:

                                > msiexec /qn /i puppet.msi PUPPET_MASTER_SERVER=puppet.example.com

        --------------------------
        Dashboard
        --------------------------

            https://docs.puppetlabs.com/dashboard/manual/1.2/bootstrapping.html#installing-in-summary
            https://wiki.deimos.fr/Puppet_Dashboard_:_Mise_en_place_d%27une_interface_graphique_pour_Puppet

                __________________________
                Dépendances (Exemple depuis une Ubuntu 14.04 Trusty):

                        Installation des packages
                        ``````````````````````````
                            - RubyGems
                            - Rake > 0.8.3
                            - Mysql > 5.0
                            - Rubby-MySQL > 2.7

                        > apt-get install -y build-essential irb libmysqlclient-dev mysql-server rake rdoc ri ruby ruby-dev ruby-rack-ssl libsslcommon2 ruby-mysql 

                        Script pour installer rubygems:
                        ``````````````````````````

                            Obtenir la dernière version:
                                https://rubygems.org/pages/download

                            > vim installRubyGems.sh

                                URL="http://production.cf.rubygems.org/rubygems/rubygems-2.4.6.tgz"
                                PACKAGE=$(echo $URL | sed "s/\.[^\.]*$//; s/^.*\///")

                                cd $(mktemp -d /tmp/install_rubygems.XXXXXXXXXX) && \
                                wget -c -t10 -T20 -q $URL && \
                                tar xfz $PACKAGE.tgz && \
                                cd $PACKAGE && \
                                sudo ruby setup.rb

                        Faire en sorte que gem devienne une alternative pour gem1.9.1:
                        ``````````````````````````

                            > sudo update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 1
                            > adduser puppet-dashboard
                            > sudo chown -R puppet-dashboard:puppet-dashboard /opt/puppet-dashboard
    
                __________________________
                Dashboard

                        Packages (Install du repo préalablement)
                        ``````````````````````````

                            > apt-get update && apt-get install puppet-dashboard

                        Sources
                        ``````````````````````````

                            todo


                        Tarball
                        ``````````````````````````

                            Voir https://downloads.puppetlabs.com/dashboard/

                            > wget 
                    

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Master
        --------------------------
                __________________________
                fichier de config principal:

                    https://docs.puppetlabs.com/references/latest/configuration.html#configuration-reference

                    > vim /etc/puppet/puppet.conf

                        #Tout les noms pouvant être utilisés par les agents

                        dns_alt_names = master, master.domain, puppetmaster ...

                __________________________
                Générer un template de config:

                    > puppet doc --reference configuration > /etc/puppet/template.conf

        --------------------------
        Agent - Linux
        --------------------------

            /!\ Note: "puppetd" = "puppet agent"

            Exemple de configuration:

                > vim /etc/puppet/puppet.conf

                    [agent] #ou [main]
                    server=hostname du puppet master
                    report=true
                    pluginsync=true
                    certname=NomUniqueNoeud(hostname)
                    rundir =        /var/run/puppet/
                    runinterval =   50	#(en seconde)
                    listen=true

            Note:
                Le nom du puppet master doit être strictement équivalent au vrai nom,
                Celui avec lequel vous avez créé son certificat.
                Sinon vous allez forcement avoir des problèmes de certificats.
                Le nom donné au paramètre certname et le hostname doivent être identique.

                __________________________
                Tester la connexion avec le master:

                    (Cette commande délanche la demande de signature de certificat)

                    > puppet agent --test
                    > puppet agent --test --server mon_server_puppet

                    Dans le cas où l'agent n'a pas encore de certif, on peut renseigner un timeout dans le but de valider le certif côté master.

                    > puppet agent --test --waitforcert 60

                __________________________
                Purger les certificats

                    > rm -r /etc/puppet/ssl
                    ou voir au niveau de /var/lib/puppet/ssl (selon les version)
                __________________________
                Activer le service au démarrage:

                        via script init
                        ``````````````````````````
                            > puppet resource service puppet ensure=running enable=true

                        via le fichier /etc/default/puppet
                        ``````````````````````````
                            START=yes

                        via la cron:
                        ``````````````````````````

                            puppet resource cron puppet-agent ensure=present user=root minute=30 command='/usr/bin/puppet agent --onetime --no-daemonize --splay'

                        > server puppet restart

        --------------------------
        Agent - Windows
        --------------------------

            https://docs.puppetlabs.com/windows/

            Path par défaut sous windows 7:

                C:/ProgramData/puppetLabs/puppet/etc/puppet.conf

            Connaitre le path vers le fichier de config:

                > puppet agent --configprint config

                __________________________
                Post-installation:

                    https://docs.puppetlabs.com/guides/install_puppet/post_install.html

                __________________________
                Lancer les commandes puppet:

                    Lancer le 'start command prompt with puppet' 

                __________________________
                Essayer la connexion avec le master:

                    Lancer le script 'Run Puppet Agent'


        --------------------------
        Attributs du fichier de config:
        --------------------------

            https://docs.puppetlabs.com/references/latest/configuration.html

            puppet s'arrête à la première valeur trouvée suivant cet ordre:

                -valeurs entrées en ligne de commande.
                -valeurs de l'environnement courant
                -valeurs du mode run
                -valeurs du main
                -valeurs par défauts

            Quelques attributs des fichiers de conf: (/etc/puppet/puppet.Conf)

                certname=hostname
                    Non du noeud courant.
                    A mettre si on n'utilise pas de dns
                    dans un domaine mettre le fqdn.

                dns_alt_names = master names
                    Les noms possibles du master

                server=server_hostname
                    Non du puppet_master
                    Idem si pas de dns le mettre dans le fichier hosts.

                pluginsync=true
                    à mettre sur les agents (recommandé, voir pourquoi todo)

                report=true
                    à mettre sur les agents (permet d'envoyer les rapports au serveur)

                reports=true
                    à mettre au niveau du master. (active le gestionnaire de rapport)

                modulepath=$PATH
                    path vers les modules de puppet (défaut: /etc/puppet/modules:/usr/share/puppet/modules)

                environment=$NAME
                    Spécifie l'environnement dans lequel le noeud envoie ses requêtes (à faire donc coté agent)

                node_terminus=exec
                    exec: dans le cas ou l'on est en standalone ou ENC (External Node Classifiers)

                confdir=$PATH
                    path vers les fichiers de conf (config, manifests, modules and certificate)

                vardir=$PATH
                    path vers d'autres fichier de conf (données en cache, rapports et backup)

                dns_alt_names=$LIST_NAME
                    liste de hostname pour le master


~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Config
        --------------------------

            Afficher la configuration:

                > puppet config print

        --------------------------
        Certificats
        --------------------------

            Voir aussi: http://docs.puppetlabs.com/puppet/3.7/reference/ssl_regenerate_certificates.html

            /!\ Note: "puppetca" = "puppet cert"

                S'éxécute en root!

            Lors de la première mise en route, chaque noeud demanderons un certificat signé au master.
            Pour forcer cette première demande voir la commande puppet --test (coté agent)

                __________________________
                voir les demandes de certificats:

                    > puppet cert list 
                    > puppet cert --list --all
                __________________________
                signer les demandes:

                    > puppet cert sign --all
                    ou
                    > puppet cert sign $AGENT

                __________________________
                supprimer un certificat

                    > puppet cert --clean MON_CLIENT
                __________________________
                Générer des certif serveurs:

                    > puppet cert generate <puppet master's certname> --dns_alt_names=<comma-separated list of DNS names>
                __________________________
                Regénérer des nouveaux certificats :

                    Si on remplace une machine par exemple, il faudra surement regénérer un certificat  :

                    Coté master :

                        > puppet cert clean monHost.monDomain

                    Côté Client :

                        > sudo find /var/lib/puppet/ssl -name monHost.monDomain.pem -delete

                    Puis redemander un certificat, exemple :

                        Client :

                            > puppet agent --test

                        Master :

                            > puppet cert --sign --all

        --------------------------
        AIDE
        --------------------------

            Obtenir de l'aide: 

                > puppet ... --help

        --------------------------
        Gérer les ressources
        --------------------------
            

            Ou encore comment créer automatiquement des manifests.

                __________________________
                Aide:
                    > puppet resource --help

                __________________________
                Liste tout les types de resources:
                    > puppet resource --type

                __________________________
                Toute les ressources un système existant:
                    > puppet resource

                __________________________
                Afficher tout les services de sa machine:
                    > puppet resource service

                __________________________
                D'autre exemples:
                    > puppet resource service httpd
                    > puppet resource user root
                    > puppet resource package postfix

                __________________________
                Appliquer une ressource sur son système (exemple):
                    > puppet resource user $NAME ensure=present shell="/bin/bash" home"/home/$USER" managehome=true

                __________________________
                Avoir plus d'info sur une resource:
                    > puppet describe -s $RESOURCE

            Note, pour générer le hash d'un mot de passe pour les ressources type user:

                > mkpasswd -m sha-512
                
                autre possibilité:

                    $password = 'your_plain_text_password'
                    user { 'root':
                        ensure   => 'present',
                        password => generate('/bin/sh', '-c', "mkpasswd -m sha-512 ${password} | tr -d '\n'"),
                    }

            Packages sous windows:

                https://docs.puppetlabs.com/puppet/3.6/reference/resources_package_windows.html

        --------------------------
        Collecter et afficher les facts
        --------------------------

            > facter

        --------------------------
        Synchroniser un client manuellement (test)
        --------------------------

            > puppet agent -t

            mode debug:
                
                > puppet agent -t -v -d
            
            En spécifiant des modules particuliers:

                > puppet agent --test --tags moduleA moduleB

                Note :

                    Par défaut les tag font références au nom des modules.

                    Il est possible de taguer n'importe quel manifest pour qu'il soit utilisé avec un nom de tag :
                
                    Exemple :

                        > vim manifests/monModule.pp

                            tag 'nom1', 'nom2', ...

            Tester sans déployer les configs:

                > puppet agent -t --noop

            Mode debug au niveau du master:

                > sudo puppet master --verbose --no-daemonize

	---------------------
	Appliquer un manifest localement
	---------------------

        > sudo puppet apply monManifest.pp

        Un module entier:

            > sudo puppet apply -e 'include monModule'
            
	---------------------
	Afficher les éléments de configuration
	---------------------

        modulepath:
            > sudo puppet master --configprint modulepath

        Tout les élements en fonction de la section et l'environement:
            > sudo puppet config print all --section master --environment advim


	---------------------
	Checker / tester la syntaxe d'un .pp
	---------------------

        > puppet parser validate init.pp

	---------------------
	Partager des fichiers
	---------------------

        > vim /etc/puppet/fileserver.conf

            [files]
             path /path/to/share
             allow *

        On pourra ensuite l'utiliser par exemple dans un champs source:
        source => 'puppet:///files/...',

	---------------------
	Conf de test
	---------------------
            
        > vim site.pp 
        
            todo
    
        case $operatingsystem {
            centos, redhat: { $repo = 'yum' }
            debian, ubuntu: { $repo = 'apt' }
        }


        case $repo {
            apt: {
                file { 'sources':
                    path    => '/etc/apt/sources.list',
                    ensure => 'file',
                    source	=> 'puppet:///files/debian/sources.list',
                    mode => 0644,
                }
            }
            yum: {
                file { 'sources':
                    path    => '/etc/yum/todo',
                    ensure => 'file',
                    source	=> '/etc/puppet/files/redhat/todo',
                }
            }
        }

        exec { "done":
          cwd     => "/tmp",
          creates => "/tmp/puppet",
          command => "echo \"done at $uptime_seconds\" > puppet",
          user    => "$id",
          path    =>  "/bin",
        }

        filebucket { 'main':
                path => '.puppet-bak',
        }

        File { backup => main, }

        --------------------------
        Checker les logs
        --------------------------

            Par défaut sur chaque noeud, les logs puppet sont dumpés au niveau de :

                /var/log/messages

            Note : 
                Attention à l'interprétation de l'output Puppet. Surtout concernant l'ordre d'installation des packages.
                Les logs concernent l'application du catalogue qui a été généré par le master.
                Et donc il peut notifier l'installation d'un package qui est en fait installé avant à cause d'une dépendance avec un autre package.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Quelques ressources
~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://docs.puppetlabs.com/references/latest/type.html

        --------------------------
        Messages
        --------------------------

            http://www.puppetcookbook.com/posts/simple-debug-messages.html

            Pour afficher des messages de debug notament!
            Deux manières principales:

                __________________________
                notice:

                    Debug output coté master:

                    Exemples:

                        notice("mon message")
                        notice $monMessage
                        ...

                __________________________
                notify:

                    Debug output coté agent:

                    Exemples:

                        notify("mon message")
                        notify $monMessage
                        ...

                    En rajoutant la source de l'info:

                        notify { "mon Message":
                            withpath => true
                        }

                    On peut aussi dumper une erreur, ou autre niveau de log :

                        notify { "error":
                            loglevel => alert,
                        }

        --------------------------
        Commandes
        --------------------------
                __________________________
                exec:

                    Url :

                        https://docs.puppetlabs.com/references/latest/type.html#exec

                    Exemple :

                        exec { 'nomCommande' :
                            command => "une commande ;
                                sur plusieurs lignes",
                            path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
                        }
                    Description :

                        La commande exec doit être 'idempotent' et doit pouvoir s'executer plusieurs fois.

                        Pour qu'elle soit idempotent, il faut :

                            - soit qu'elle le soit elle même
                            - qu'elle contienne onlyif, unless ou creates
                            - qu'elle contienne un refreshonly => true

                        Elles peuvent être executer après un 'refresh event' :

                            Caractérisé par un : notify, subscribe ou ~>

                            Dans se cas pour que la commande exec soit lancéeaprès l'event, il faut utiliser soit un des attributs refresh suivant :

                            - Refreshonly :

                                S'exectutera uniquement si la ressource reçoit un event.

                            - Refresh :

                                TODO

                    Tips :

                        Pour continuer à executer une commande chaîner, il est possible de feinter la sortie d'erreur de la commande :

                            Exemple en bash :

                                maCommandeFailed || echo 'tampis !'

                    Note :

                        Eviter les répétition de bloc exec.
                        Préférer l'écriture d'une nouvelle ressource.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

    _____________
    Exiting; no certificate found and waitforcert is disabled
     --> bien démarrer le service puppet au niveau de l'agent 
         Et signer le certificat de l'agent au niveau du serveur:

         exemple:

            > puppet cert sign --all

    _____________
    err: Could not retrieve catalog from remote server: Server hostname 'X.X.X.X' did not match server certificate; expected one of foo, DNS:puppet, DNS:puppet.foo, DNS:foo

     --> Remplacer l'IP du serveur par son nom de domaine / hostname.

    _____________
    Read Only Type

        Dans ce cas il suffit de ne pas renseigner le type

    _____________
    provider from vcsrepo

        https://tickets.puppetlabs.com/browse/PUP-1515

        puppet master --no-daemonize --trace --verbose --environment fail


        Run puppet plugin download --environment ENVIRONMENT-NAME-HERE && service puppetmaster restart on the puppet master to make the plugins available in the correct place
        Apply the puppet configuration on the puppet agent (puppet agent -t)
        Run puppet plugin download && service puppetmaster restart on the puppet master to restore the original plugins

        puppet agent --environment fail --test --debug --verbose
    _____________
    invalid byte sequence in US-ASCII

        Résolution :

            find . -name "*.pp" | xargs file

            côté client essayer :

                export LANG=en_US.UTF-8
                export LANGUAGE=en_US.UTF-8
                export LC_ALL=en_US.UTF-8

            Ou au niveau serveur, sur le fichier en question :

                Essayer de convertir son fichier :

                    > iconv -f ISO-8859-1 -t UTF-8 file.php > file-utf8.php
    _____________
    Problème pour retrouver des infos dans le dossier lib du module.

        Error: /File[/var/lib/puppet/facts.d]: Could not evaluate: Could not retrieve information from environment production source(s) puppet://X.X.X.X/pluginfacts

        Il suffit de créer un lien symbolique de facts.d :

            > ln -s /etc/puppet/path/to/lib facts.d
    _____________
    circular dependencies error :

        http://serverfault.com/questions/281085/whats-the-difference-between-include-and-require-in-puppet

        Il faut tracker les depéndances entre modules impliqués.
        Eviter de mettre à la fois des requires et des includes dans les modules impliqués (voir la partie ordering)

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
