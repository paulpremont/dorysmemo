S A L T  S T A C K S
==============================

What is it ?
-----------------------------

Un système de centralisation de gestion de configuration d'un ensemble d'hôtes.
Le but étant d'automatiser le provisioning, l'exécution de commandes et le maintient en état de configuration de plusieurs noeuds, simultanément.
Le tout en pyhton -> I love it!

SaltStack peut fonctionner en mode agent ou agentless (un de ses points forts) et les modules peuvent être facilement développés.


Links
-----------------------------

### Officiels :

* [Site officiel](https://saltstack.com/)
* [Documentation](http://docs.saltstack.com/en/latest/)
* [Documentation sommaire](http://docs.saltstack.com/en/latest/contents.html)
* [Documentation configuration](http://docs.saltstack.com/en/latest/ref/configuration/index.html)
* [Documentation modules](http://docs.saltstack.com/en/latest/ref/modules/all/index.html)
* [Sources](https://github.com/saltstack/salt)
* [Tutos officiels](http://docs.saltstack.com/en/latest/topics/tutorials/index.html)

### Interfaces

* [SaltPad](https://github.com/Lothiraldan/saltpad)
* [Foreman](https://theforeman.org/plugins/foreman_salt/2.0/)
* [API](https://docs.saltstack.com/en/develop/topics/api.html)


How it works?
-----------------------------

### Architecture

Salt est structuré à partir de 3 modèles de machines possible:

* Le master qui pilotes les minions.
* Le syndic qui est un master intermédiaire.
* Les minions qui sont les noeuds gérés par un master.

### Structure des commandes et fichiers

Au niveau commande:

    salt TARGET CONTEXTE.MA_COMMANDE

soit :

    salt TARGET CLASS.METHODS

Au niveau des fichiers:

    KEY:
    - value

### Chiffrement

Salt utilise AES par défaut pour le chiffrement entre minion et master.
Mais il peut aussi utiliser ssh comme surcouche de transport ou bien pour un mode agentless.

### Ports utilisés par défaut

4505 (publisher) / 4506 (master) / 22 (ssh)


### Modules d'exécution

* [Remote Execution](https://docs.saltstack.com/en/latest/topics/execution/index.html)
* [Liste des modules d'exécution](https://docs.saltstack.com/en/latest/ref/modules/all/index.html#all-salt-modules)
* [Comment écrire un module d'execution](http://docs.saltstack.com/en/latest/ref/modules/index.html)

Ce sont les commandes pouvant être exécuter sur les minions.
Les modules par défaut sont présents dans les lib et le share :

* /usr/lib/python2.7/dist-packages/salt/modules/*
* /usr/share/pyshared/salt/modules/*

On écrit nos propres modules dans **/srv/salt/_modules/**  
(Path spécifié par la variable file_roots au niveau de la config du master)

Les modules placés dans ce folder seront synchronisés vers les minions après l'appel de ces fonctions:

* state.highstate
* saltutil.sync_modules
* saltutil.sync_all

Les modules d'exécution peuvent être tester grace à la commande salt-run utilisant le "salt runner" (depuis la version 2016.11.0).

Exemples de modules :

* cmdmod
* aptpkg

#### Créer son module d'exécution
  
##### Appels de fonctions de modules d'exécution:

Tous les modules d'exécution sont consultables entre eux, les fonctions sont donc rendues accessible.

la variable **__salt__** est un dictionnaire contenant toutes les fonctions partagées Salt.

exemple d'appel de la fonction cmd.run :
    
    def foo(bar):
        return __salt__['cmd.run'](bar)

Pour définir une fonction privée, on rajoute le **_** devant le nom de la fonction.

##### Grains data

On peu accéder aux données d'un minion grâce à la variable grains via la fonction grains.item()

exemple CLI :

    salt 'hostname' grains.items --output=pprint

Pour récupérer une de ces valeurs dans son code :
    
    __grains__['key']

exemple :

    __grains__['id'].

##### To continue

#### Tester un module d'exécution

Avec salt-run.

Exemple :

    salt-run salt.cmd test.ping


### Modules d'états

todo

### Grains

[Grains](https://docs.saltstack.com/en/latest/topics/grains/index.html)

Ce sont les données concernant un minion et stockées ou générées depuis un minion.

Les grains peuvent être settés au niveau de la conf des minions.

Par exemple : 

  grains['os'] : correspond au type de système installé sur un minion.

#### Ordre d'application des grains:

1. Core grains.
2. Custom grains in /etc/salt/grains.
3. Custom grains in /etc/salt/minion.
4. Custom grain modules in _grains directory, synced to minions.

### Pillars

[Pillar](http://docs.saltstack.com/en/latest/topics/tutorials/pillar.html)

Ce sont les infos concernant un ou plusieurs minions stockées ou générées depuis le master.
(Les variables côtés master).

On utilise les pillars pour dissocier la partie variable/données, au niveau des fichiers d'état, de la partie fonctionnelle/template jinja.  
Permet de faire des fichier states plus propres.

On définit sur quel target appliquer un fichier pillar via le fichier top.sls :

**/srv/pillar/top.sls**

    base:
        '*':
            -foo

Enfin on y place des variables :

**/srv/pillar/foo.sls**

    info: some data
    users:
        pepito: 1000
        nespresso: 1001

Afficher le résultat :

    salt '*' pillar.items

Toutes les données seront ensuite accessibles dans les fichiers d'état via le dictionnaire pillar['key1']['key2']...

### Targeting

* [Targeting Minions](https://docs.saltstack.com/en/latest/topics/targeting/index.html)
* [Top File](https://docs.saltstack.com/en/latest/ref/states/top.html#states-top-environments)

Le targeting permet d'exécuter un module sur l'hôte ciblé.
Un module d'exécution comme une commande ou encore un fichier d'état.

Le targeting se fait soit directement en CLI ou depuis un fichier top.sls placé à la racide des dossiers de fichier d'état (/srv/salt)  
ou encore au niveau des pillars (/srv/pillar).


#### Les correspondances (matchs)

Ce sont les différentes manière de cibler un hôte.
On peut utiliser '*' comme wildcard dans les noms d'hôtes.

##### Cibler avec des noms de minions

Avec les wildcards :

* *
* *.example.net
* *.example.*
* web[1-5]
* web[1,3]
* web-[x-z]

Exemple :

    salt 'web[1,3]' test.ping

On peut utiliser des expressions régulières **Regex PCRE** :

CLI :

    salt -E 'web1-(prod|devel)' test.ping

Dans un fichier top.sls :

    '^(memcache|web).(qa|prod).loc$':
        - match: pcre
        ...

Ou encore des listes :

    salt -L 'web1,web2,web3' test.ping


##### Cibler avec des grains

CLI :

    salt -G 'os:Fedora' test.ping

top.sls :

    'os:Ubuntu':
        - match: grain
        ...

    'os:(RedHat|CentOS)':
        - match: grain_pcre
        ...


##### Cibler avec les pillars

CLI :

    salt -I 'somekey:specialvalue' test.ping

top.sls :

    'somekey:abc':
        - match: pillar
        - xyz

##### Cibler avec compound (composé)

[Compound Matcher](https://docs.saltstack.com/en/latest/topics/targeting/compound.html#targeting-compound)

Permet d'utilisé AND et OR :

CLI :

    salt -C 'G@os:Debian and webser* or E@db.*' test.ping


top.sls :

    'nag1* or G@role:monitoring':
        - match: compound
        - nagios.server

##### Cibler avec des adresses IP

CLI

    salt -S 10.0.0.0/24 test.ping

top.sls

    '172.16.0.0/12':
       - match: ipcidr
       - internal

#### Node Groups

On peut définir des groupes d'hôte au niveau de la config du master (/etc/salt/master) :

Exemple :

    nodegroups:
      group1: 'L@foo.domain.com,bar.domain.com,baz.domain.com or bl*.domain.com'
      group2: 'G@os:Debian and foo.domain.com'
      group3: 'G@os:Debian and N@group1'
      group4:
        - 'G@foo:bar'
        - 'or'
        - 'G@foo:baz'

Pour ensuite les cibler plus simplement.

CLI :

    salt -N group1 test.ping

top.sls :

    base:
      group1:
        - match: nodegroup
        - webserver

                    
#### Les fichiers top.sls

Les fichiers tops permettent d'assigner à des hôtes les bon fichiers d'état.
On s'en sert au niveau des pillars pour récupérer la bonne configuration mais aussi pour les modules d'état.

Un fichier top est segmenté en plusieurs environnements comportant plusieurs targets et les fichiers à leur assigner.

##### Environnements

Permet de définir des groupes d'hôtes appartenant à un environnement:
et d'y appliquer leurs états.

Pattern :

    template:

      environnement:
          'host_match_pattern':
              -state_file

Exemple:

**1- Définition de la racine des environnements :**

/etc/salt/master

    file_roots:
      base:
        - /srv/salt/base
      dev:
        - /srv/salt/dev

**2- Définition des targets et states associés :**

/srv/salt/base/top.sls

    base:
      '*':
        - ssh

    dev:
      'dev_bidul,dev_machin': 
        - match: list
        - db
        - vim

##### Où écrire les fichiers top.sls
                            
* À la racine de la base
* À la racine de chaque environnement
* Si un environnement n'est pas déclaré dans le fichier base,
Salt cherchera un fichier top.sls dans l'ordre alphabétique des environnements.
Et appliquera la première définition trouvée dans ces fichiers.

!!! note
    l'environnement déclaré dans le top file de son path, a la priorité.

On peut couper un fichier tops en mettant les définitions de chaque environnement dans leur dossier respectif.

!!! note 
    La manière la plus simple reste d'écrire un seul top.sls au niveau de la base.

### Ordonnancement

* [oredering](https://docs.saltstack.com/en/latest/ref/states/ordering.html)
* [orchestrate_runner](https://docs.saltstack.com/en/latest/topics/orchestrate/orchestrate_runner.html)

#### Un point sur l'ordre d'application des states :

1. L'application des fichiers sls se fait dans l'ordre de la liste du fichier top.sls.
2. Les states s'éxécute dans l'ordre de définition.
3. L'utilisation des 'requires' prévaut sur l'ordre définit précedement.

Pour ordonnancer plus précisément l'ordre d'application des fichiers sls ou des states, on peut utiliser **l'orchestrate_runner**.

#### Note sur les différentes méthodes d'ordonnancement :

Il y a plusieurs manières d'arriver à ordonner l'éxécution des fichiers d'états :

* Via les requires au sein des fichiers d'états (.sls) pour dicter l'ordre d'application des différentes tâches/states.
* Via l'option "state_auto_order" pour appliquer les states files dans l'ordre de leur définition. (comportement par défaut avec les top.sls).
* Via l'orchestrate_runner pour ordonnancer proprement et de façon externe l'application des fichiers d'états.

!!!warning
    l'option state_auto_order sera désactivé si l'utilisation d'un require force l'ordonnancement.

#### orchestrate_runner

##### Un point sur les différents modes d'exécution

* [saltmod](https://docs.saltstack.com/en/latest/ref/states/all/salt.states.saltmod.html#salt.states.saltmod.state)

* function : correspond à une tâche à exécuter à la volée (exemple : cmd.run)
* state : correspond à un état définit (- name:) ou un fichier d'état (- sls:)
* highstate : correspond à l'application de tous les états disponibles pour un hôte (top.sls)

##### Ordonnancer avec l'orchestrate_runner

On va pouvoir faire référence soit à une fonction, un fichier d'état ou encore un highstate et appliquer des requires.

Exemple :

    TODO


### Mines (salt mine)

[Lien salt mine](https://docs.saltstack.com/en/latest/topics/mine/index.html)
[Lien module salt mine](https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.mine.html)

Les mines permettent de collecter les données auprès des minions sur le master (système de cache) de façon optimisée.  
Elles viennent remplacer l'utilisation des grains dans certain cas.  
Le but étant d'être le plus à jour possible et d'éviter d'intéroger les minions à chaque fois que l'on demande un grain.  
On va donc économiser de la bande passante et du temps.

!!! warning
    Attention toutefois au mode agentless (ssh).

TODO
    


        --------------------------
        SALT STATES
        --------------------------

            Liens pratiques:
                http://docs.saltstack.com/en/latest/topics/tutorials/starting_states.html
                http://docs.saltstack.com/en/latest/ref/states/requisites.html
                http://docs.saltstack.com/en/latest/ref/states/ordering.html

            La liste des states:
                http://docs.saltstack.com/en/latest/ref/states/all/

            Le salt states représente l'état dans lequel un noeud devrait se trouver.
            On écrit ces états dans des fichiers .sls (SaLt State file).
            Ce qui va nous permettre de faire du provisionning.

            Ces fichiers sls comportent en fait des dictionnaires, listes .... écrit en YAML.

            Les fichiers sont stockés dans /srv/salt (par défaut) (le salt state tree)
            Les fichiers SLS comporte l'extension .sls

                __________________________
                Structurer:

                    Pour structurer ses SLS, on créer des dossier contenant nos fichiers sls.
                    Si l'on créer un fichier init.sls, il sera lu lorsqu'on executera la commande state.sls avec le nom du repertoire en argument.

                    exemple:

                        > mkdir /srv/salt/dirname
                        > vim  /srv/salt/dirname/init.sls
    
                    On l'appelera par le nom du dossier:

                        > salt '*' state.sls dirname

                    Si l'on place d'autres fichiers.sls dans le repertoire on pourra les executer ainsi:

                        > salt '*' state.sls dirname.filename

                    Sinon il faudra appeler l'état par son nom:

                        > salt '*' state.sls vim.sls

                __________________________
                Syntaxe:
                    
                    °°°°°°°°°°°°°°°°°°°°°°°°°
                    id_name:
                        function:
                            - variable: value
                    °°°°°°°°°°°°°°°°°°°°°°°°°

                    #L'id peut être utiliser pour spécifier un nom de paquet, ou un path ... (utilisé par la variable name)
                    #Utiliser un id probant à chaque fois permet de bien structurer son fichier.
                    #Attention à bien faire la différence entre id et fonction lors de l'écriture d'un state.
                __________________________
                Vérifier qu'un paquet est installé:

                    paquet:
                        pkg.installed

                __________________________
                Passer des fichiers:

                    http://docs.saltstack.com/en/latest/ref/states/all/salt.states.file.html

                    /path/to/dest:              
                        file.managed:
                            - source: salt://path/to/source     #(depuis le file_roots [defaut: /srv/salt])
                            - mode : 644
                            - user: root
                            - group: root

                    On peut aussi l'écrire ainsi:

                        application:
                            file.managed:
                                - name: /path/dst
                                - source: /path/src

                    exemple:

                        vim:
                          pkg.installed

                        /etc/vimrc:
                          file:
                            - managed
                            - source: salt://vimrc
                            - mode: 644
                            - user: root
                            - group: root

                    Pour les dossiers:

                        file.directory:
                            - user: bidul
                            - group: bidul
                            - dir_mode: 755
                            - file_mdoe: 644
                            - makedirs: True
                            - recurse:
                                - user
                                - group
                                - mode

                        ou

                        file.recurse:
                            - source: salt://somewhere
                            - include_empty: True

                    Liens symboliques:

                        file.symlink:
                            - target: /tmp/somewhere

            Note: Le daemon n'a pas besoin d'être redémarré.

                        Copier une arborescence entière:
                        ``````````````````````````

                            root_fs:
                                file.recurse:
                                    - name: /
                                    - source: salt://files/clients/{{ grains['id'] }}/{{ grains['os_family'] }}
                                    - include_empty: True
                                    - file_mode: 664
                                    - dir_mode: 775
                                    - makedirs: True
                                    - template: jinja
                                    - recurse:
                                      - user
                                      - group
                                      - mode

                __________________________
                Gérer un service:

                    service_name:
                        pkg:
                            - installed
                        service:
                            - running
                            - require:
                                - pkg: package name

                    exemple:

                        nginx:
                          pkg:
                            - installed
                          service:
                            - running
                            - require:
                              - pkg: nginx

                            ou

                            - watch:
                              - pkg: apache
                              - file: /etc/httpd/conf/httpd.conf
                              - user: apache

                        watch permet en plus de redémarrer le service en cas de modification.
                        Il regarde trois état au lieu d'un seul: pkg, file et user.

                __________________________
                Les utilisateurs:

                    exemple:

                  user.present:
                    - uid: 87
                    - gid: 87
                    - home: /var/www/html
                    - shell: /bin/nologin
                    - require:
                      - group: apache
                  group.present:
                    - gid: 87
                    - require:
                      - pkg: apache

                __________________________
                Les rendus, (du code dans nos state.sls)

                    Salt offre plusieurs manières d'ajouter du code dans ses fichiers .sls.

                    Celle par défaut s'appele yaml_jinja (template de programmation python jinja2)
                        http://jinja.pocoo.org/docs/
                        Il existe aussi mako et wempy.

                    Ce système peut aussi être utilisé sur les fichier uploadé (file.managed)

                    /!\ Pour plus de clareté, il est préferable de générer ce code au niveau des pillar.


                        exemple avec des conditions:
                        ``````````````````````````

                            apache:
                              pkg.installed:
                                {% if grains['os'] == 'RedHat'%}
                                - name: httpd
                                {% endif %}
                              service.running:
                                {% if grains['os'] == 'RedHat'%}
                                - name: httpd
                                {% endif %}
                                - watch:
                                  - pkg: apache
                                  - file: /etc/httpd/conf/httpd.conf
                                  - user: apache

                        exemple avec une boucle:
                        ``````````````````````````
                            {% for mnt in salt['cmd.run']('ls /dev/data/moose*').split() %}
                            /mnt/moose{{ mnt[-1] }}:
                              mount.mounted:
                                - device: {{ mnt }}
                                - fstype: xfs
                                - mkmnt: True
                              file.directory:
                                - user: mfs
                                - group: mfs
                                - require:
                                  - user: mfs
                                  - group: mfs
                            {% endfor %}
                        
                        pyobjects, pydsl ...
                        ``````````````````````````
                            todo
                _________________________
                Include un autre state:
                    
                    include:
                        - state[.sls]_name
                __________________________
                Installer un package:

                        Simplement:
                        ``````````````````````````
                            monPackage:
                                pkg.installed

                        Avec dépendances:
                        ``````````````````````````

                        Plusieurs packages:
                        ``````````````````````````

                            NomGroupePackage:
                                pkg.installed:
                                    - pkgs:
                                        - pkg1
                                        - pkg2

        --------------------------
        Schedule
        --------------------------

            Pour lancer automatiquement les states:
            Il est possible de le configurer au niveau de pillar, du master ou encore des minions.

            Note: 
                maxrunning spécifie le nombre de routine possible lancée en même temps 
                par défaut il est à 1.

            Syntaxe:

                schedule:
                    jobname:
                        function: state.sls
                        args:
                            - httpd
                        kwargs:
                            test: True

                        #les moments possibles:
                        
                        seconds: 3600           #execution toutes les heures
                        minutes: XX
                        hours: XX

                        when: 
                            - 8:00pm            #execution à 8 heure du soir
                            - monday 5:00 pm    #en précisant un jour (note: on peut cumuluer plusieurs date)

                        range:                  #execution dans un intervalle de temps donné (à cumuler avec seconds...)
                            start: 2:00 am
                            stop: 4:00 pm

                        #stocker les infos (TODO)

                        returner: mysql


                TODO, voir http://docs.saltstack.com/en/latest/topics/jobs/schedule.html

        --------------------------
        Ordonner
        --------------------------
            http://docs.saltstack.com/en/latest/ref/states/requisites.html

            Salt évalue les états dans l'ordre d'écriture mais leurs executions sont de l'ordre déclarative.

            l'attribut 'state_auto_order' à True permet d'évaluer chaque état dans leur ordre de définition .
            Mettre à False pour un ordre alphabétique.

                __________________________
                Directives:

                        require
                        ``````````````````````````
                            http://docs.saltstack.com/en/latest/topics/tutorials/states_pt2.html

                            Permet de spécifier que l'état solicité doit être lancé avant celui qui le demande.

                            - include:
                                - network

                            - require:
                                - pkg: httpd
                                - sls: network

                            Ici pkg (de l'état de httpd) devra être exécutée en premier, puis le fichier d'état network ...

                            Références:

                                * require peut faire référence à plusieurs déclaration d'état:

                                    apache:
                                    pkg.installed: []
                                    service.running:
                                        - require:
                                        - pkg: apache

                                * Ou encore à d'autre états:

                                   apache:
                                      pkg.installed: []
                                      service.running:
                                        - require:
                                          - pkg: apache

                                    /var/www/index.html:                        # ID declaration
                                      file:                                     # state declaration
                                        - managed                               # function
                                        - source: salt://webserver/index.html   # function arg
                                        - require:                              # requisite declaration
                                          - pkg: apache                         # requisite reference 
                                        
                                * à un fichier d'état entier:

                                    - include:
                                        monSlsFile

                                    - require:
                                        - sls: monSlsFile
                                        

                        require_in
                        ``````````````````````````

                            Dans la même optique que précédent mais cette fois ci à l'inverse c'est à dire qu'on spécifie quel état est dépendant du notre.

                        watch
                        ``````````````````````````

                            Agit comme require en terme d'ordre, mais vérifie si il y eu des changements d'état.
                            On s'en sert comme trigger lors d'un changement d'état, comme par exemple l'installation d'un package:

                            exemples:

                                #à la mise à jour d'un fichier:
                                - watch:
                                    - file: /etc/bidul

                                #à la mise à jour/installation d'un paquet:
                                - watch:
                                    - pkg: redis

                        prereq
                        ``````````````````````````
                            
                        onfail
                        ``````````````````````````

                        onchanges
                        ``````````````````````````

                        use
                        ``````````````````````````

                        unless
                        ``````````````````````````

                        onlyif
                        ``````````````````````````

                        order
                        ``````````````````````````
                            Permet de préciser explicitement l'ordre d'éxécution.

                            - order: X
                            - order: last

                            exemple:
                                - order: 1 

                                Exécutera toute les tâche d'ordre 1 en même temps ...

        --------------------------
        Renderers - templating
        --------------------------

            http://docs.saltstack.com/en/latest/ref/renderers/all/salt.renderers.jinja.html

            Comme Puppet, saltstack peut utiliser un système de modèle pour les fichiers de configuration.

            On spécifie alors le type de tempalce utilisé pour ses fichiers.

                __________________________
                Avec Jinja:

                        Niveau fichier d'état (state):
                        ``````````````````````````

                            > vim redis.sls

                                # redis.sls
                                /etc/redis/redis.conf:
                                    file.managed:
                                        - source: salt://redis.conf
                                        - template: jinja
                                        - context:
                                            bind: 127.0.0.1
                    
                        Niveau pillars
                        ``````````````````````````

                            # lib.sls
                            {% set port = 6379 %}

                        Niveau fichier de configuration
                        ``````````````````````````

                            # redis.conf
                            {% from 'lib.sls' import port with context %}
                            port {{ port }}
                            bind {{ bind }} 



Installation
-----------------------------

[Installation](http://docs.saltstack.com/en/latest/topics/installation/index.html)

### Par le gestionnaire de paquet:

#### Debian :

**/etc/apt/sources.list.d/salt.list**

    deb http://debian.saltstack.com/debian wheezy-saltstack main

<!-- vimend -->

    wget -q -O- "http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key" | apt-key add -
    apt-get update
    apt-get install salt-master salt-minion salt-syndic
    mkdir -p /srv/salt/_modules #(c'est le dossier par défaut de nos fichiers salt)

#### Ubuntu :

    sudo add-apt-repository ppa:saltstack/salt
    sudo apt-get update
    sudo apt-get install salt-master

#### Foreman

Pour avoir une interface graphique derrière tout ça :

* [Foreman avec salt](https://theforeman.org/plugins/foreman_salt/7.0/index.html)
* [Install de Foreman](https://theforeman.org/manuals/1.14/index.html#2.1Installation)

Installation de Foreman :

    apt-get install smart_proxy_salt foreman_salt foreman-installer
    foreman-installer --enable-foreman-plugin-salt --enable-foreman-proxy-plugin-salt


Mise à jour
-----------------------------

### 1 - mise à jour du master :

    salt --version
    salt-run manage.versions
    apt-get update
    apt-get upgrade salt-master
    salt-run manage.versions

### 2 - mise à jour des minions (depuis le master)

    salt '*' cmd.run "apt-get update"
    salt '*' pkg.install salt-minion refresh=True
    #ou salt '*' cmd.run "apt-get -y install salt-minion"
    salt '*' test.version


Configuration
-----------------------------

### Dossier de configuration général

**/etc/salt**

### Master

[Configuration du master](http://docs.saltstack.com/en/latest/ref/configuration/master.html)

#### Réseau

Firewall, exemple :

    # Allow Minions from these networks
    -I INPUT -s 10.1.2.0/24 -p tcp -m multiport --dports 4505,4506 -j ACCEPT
    -I INPUT -s 10.1.3.0/24 -p tcp -m multiport --dports 4505,4506 -j ACCEPT
    # Allow Salt to communicate with Master on the loopback interface
    -A INPUT -i lo -p tcp -m multiport --dports 4505,4506 -j ACCEPT
    # Reject everything else
    -A INPUT -p tcp -m multiport --dports 4505,4506 -j REJECT

#### Grains

todo

#### Output (outputter)
            
[Les formats d'output](http://docs.saltstack.com/en/latest/ref/output/all/index.html#all-salt-output)

Il est possible de choisir son format de sortie de commande parmis plusieurs :

* nested : le format par défaut
* pprint : 
* grains : 
* higstate :
* json : format json
* key : utilisé par salt-key
* raw : Structure de données python
* txt : format texte
* yaml : format yaml

Par défaut **/etc/salt/master** :

    output: nested

#### Sauvegarder le résultat des jobs

[Lien](https://docs.saltstack.com/en/latest/topics/jobs/external_cache.html)

Par défaut le résultat des jobs est sauvegardé dans le cache (Job Cache).

Mais il aussi possible de sauvegarder dans un système tier type mysql.

#### Logs

[Logging](https://docs.saltstack.com/en/latest/ref/configuration/logging/index.html)

Il peut être très interessant de coupler Salt avec un système de logs.
Tous les événements en fonction du niveau de verbosité peuvent être logués dans un fichier.

Exemple :

    log_file: /var/log/salt/master


### Syndic

todo


### Minion

[Configuration des minions](http://docs.saltstack.com/en/latest/ref/configuration/minion.html)

#### Authentification avec le master

**/etc/salt/minion**

    master: MASTER_HOSTNAME

**/etc/salt/minion_id**

    monMinionName

Il faut redémarrer la daemon pour s'authentifier auprès du master.

    service salt-minion restart

Voir la suite partie manipulation pour ajouter un minion.

Puis côté master on ajoutera les clés des nouveaux minions :

    salt-key -L
    salt-ket -a my_minion_id1
    salt-ket -a my_minion_id2
    salt-key -L

#### Modules d'exécutions

La liste des modules d'exécution est disponible sur le site de saltstack (voir la section how it works)
Il est possible de devoir configurer certain éléments pour rendre possible l'utilisation de quelques modules.

Comme par exemple avec mysql.

Le module sera ensuite pilotable depuis le CLI ainsi que via les fichiers d'états (niveau master).

##### mysql

* [Détail du module](http://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.mysql.html)
* [state : mysql_user](http://docs.saltstack.com/en/latest/ref/states/all/salt.states.mysql_user.html)
* [state : mysql_query](http://docs.saltstack.com/en/latest/ref/states/all/salt.states.mysql_query.html)
* [state : mysql_grants](http://docs.saltstack.com/en/latest/ref/states/all/salt.states.mysql_grants.html)
* [state : mysql_database](http://docs.saltstack.com/en/latest/ref/states/all/salt.states.mysql_database.html)


Il est possible d'utiliser le module Mysql avec Salt mais il faut d'abord:

1. Installer les packages niveau client
2. Configurer le minions pour les accès à la base

On pourra ensuite utiliser les méthodes mysql de salt.

###### Packages à installer coté minion

* libmysqlclient-dev
* mysql-client
* python-mysqldb

###### Configuration des accès mysql au niveau du minion:

*/etc/salt/minion.d/mysql.conf*

    mysql.host: 'root'
    mysql.port: 3306
    mysql.user: 'root'
    mysql.pass: ''
    mysql.db: 'mysql'
    mysql.unix_socket: '/var/run/mysqld/mysqld.sock'
    mysql.charset: 'utf8'


!!! note
    On peut surpasser la configuration mysql du minion via le fichier d'état

    - connection_user: someuser
    - connection_pass: somepass

###### Utilisation des méthodes mysql

Exemple:

    mon_user:
        mysql_user.present:
            - name: mon_user
            - host: localhost
            - password: hellodelu




### Clés - Pré enregistrement

[Comment pré-enregistrer des clés](http://docs.saltstack.com/en/latest/topics/tutorials/preseed_key.html)

Salt utilise le système de clé pour identifier les minions.
Il faut donc dans la pki une clé nommée pour chaque minion différent.

Mais cette clé peut être partagée.

Générer les clés sur le master :
                
    salt-key --gen-keys=<key_name>

Ajout de la clé publique dans la conf du master :

    cp key_name.pub /etc/salt/pki/master/minions/<minion_id>

Ajout de la nouvelle paire de clés au niveau du minion :

    cp key_name.pem /etc/salt/pki/minion/minion.pem
    cp key_name.pub /etc/salt/pki/minion/minion.pub

!!! note
    Il est aussi possible d'auto-accepter une clé via la configuration du master => auto_accept: True

Todo : exemple en mode agentless.



Manipulations
-----------------------------

### Daemon

    /etc/init.d/salt-master {start|stop|status|restart|force-reload}
    salt-master -d

Avec systemV

    service salt-master {start|stop|status|restart|force-reload}

#### Ports

    nc -v -z salt.master.ip 4505
    nc -v -z salt.master.ip 4506

#### Mode debug et foreground

    salt-master -l debug
    salt-minion -l debug


### Par ou commencer?

#### Niveau minion

##### S'enregistrer au niveau du master :

*/etc/salt/minion*

    master: saltmaster

Redémarrer ensuite le service pour commencer l'échange des clés publiques :

    service salt-minion restart

#### Niveau master

##### Accepter les clés des minions et les ajouter comme target.

    salt-key -L
    salt-key -A

##### Créer l'arbre des états de base

C'est lui qui contiendra tous les fichiers d'états des minions.

    mkdir -p /srv/salt
    mkdir -p /srv/pillar

*/etc/salt/master*:

    file_roots:
        base:
            - /srv/salt

    pillar_roots:
        base:
            - /srv/pillar

Prendre en compte les changements :

    service salt-master restart

##### Créer les fichiers top.sls pour targeter

*/srv/salt/top.sls*:

  base:
    'targets':
      - state_file1
      - state_file2

*/srv/pillar/top.sls*:

  base:
    'targets':
      - pillar_file1
      - pillar_file2

##### Créer ses fichiers d'états

    mkdir apache /srv/salt
    mkdir mysql /srv/salt
    ...

##### Appliquer les configurations sur les minions
                            

    salt '*' state.highstate


### Master

#### Clés

    salt-key --help               #aide
    salt-key -L                   #lister les clés
    salt-key -f MINION-ID         #vérifier
    salt-key -A                   #Accepte toute les demandes (interactif)
    salt-key -a maCle

#### Appliquer des modules

Les modules vont nous permettre d'éxécuter des actions sur les minions.

Syntaxe générique :

    salt 'TARGETS' MODULE.METHOD ARGS

#### Tests/Fonctions/Modules:

Executer une commande depuis le master vers les différents hôtes:
                    
    salt 'TARGETS' FUNCTIONS [ARGS]

##### Lister les fonctions disponibles

    salt '*' sys.doc

##### Exemples

    salt '*' test.ping                  #test de la connectivité
    salt '*' disk.percent               #check de l'espace disque
    salt '*' cmd.run 'MA_COMMANDE'      #executer une commande shell
    salt '*' pkg.install vim            #installer un package
    salt '*' network.interfaces         #check des interfaces réseaux

#### States

Appliquer un 'state' sur tous les targets :

    salt '*' state.sls MON_FICHIER[.sls]

Appliquer tous les states sur tous les targets:

    salt '*' state.highstate

Debuguer:
      
    salt-call state.highstate -l debug

!!! note
    Si rien n'apparait du type succeed, c'est qu'il y a une erreur somewhere dans un fichier salt/path ...

#### Pillars

Voir les données des minions :

    salt '*' pillar.items

Pour préciser quels pillars on veut voir:

    salt '*' pillar.get key1:key2 ...

Exemples :

    salt '*' pillar.get pkgs
    salt '*' pillar.get pkgs:apache

### Format d'affichage

--out FORMAT.

exemples :

    salt '*' grains.item pythonpath --out=pprint
    salt '*' grains.item pythonpath --out=grains



### Minions

#### Nom

Changer le nom de son minion

    echo "monMinion" > /etc/salt/minion_id

#### Les clés

Obtenir une clé et s'inscrire sur le master :

    salt-call key.finger --local

#### Calls

Éxécuter une commande directement sur le minion au lieu de le faire depuis le master.

    salt-call [OPTIONS] FUNCTIONS [ARGS]

On peut utiliser les modules python installés sur le minion sans contacter le master :

    --local : ne pas contacter le master pour les instructions.

Cibler un fichier d'état à appliquer:

    salt-call state.sls STATE_FILE

Lancer tous les fichiers d'états applicable au minion

    salt-call state.highstate

### Services

On peut directement intéragir avec les services des hôtes.

    salt TARGET service.METHOD monService:

Exemples :

    salt '*' service.available sshd
    salt '*' service.get_all
    salt '*' service.missing sshd
    salt '*' service.reload <service name>
    salt '*' service.restart <service name>
    salt '*' service.start <service name>
    salt '*' service.status <service name> [service signature]
    salt '*' service.stop <service name>



### Grains

#### Un grain comme critère de recherche:

    salt -G 'os:Debian' test.ping

#### Récupérer une info précise avec un grain:

    salt -G 'cpuarch:x86_64' grains.item num_cpus

#### Lister les grains:

Ceux disponible :

    salt '*' grains.ls

Les données des grains :

    salt '*' grains.items

Un grain en particulier :

    salt '*' grains.get os
    salt '*' grains.item os

#### Assigner des grains aux minions:

**/etc/salt/minion**

    grains:
      roles:
        - webserver
        - memcache
      deployment: datacenter4
      cabinet: 13
      cab_u: 14-15 

OU dans **/etc/salt/grains**

!!! note
    Dans ce cas on enlève la clé 'grains'

#### Utiliser des grains dans les fichiers .sls

**Au niveau du minion :**

    grains:
      node_type:
        - webserver

**Utiliser les grains dans le fichier top (targeting) :**

    'node_type:webserver'
        - match: grain
        - webserver

Ici on appliquera le fichier d'état webserver au node de type "webserver" grâce au grain custom.

**Templatisons avec du code jinja :**

    {% set node_type = salt['grains.get']('node_type', '') %}

    {% if node_type %}
      'node_type:{{ self }}':
          - match: grain
          - {{ self }}
    {% endif %}

#### Écrire ses propres grains

En les plaçant dans un dossier _grains à la racine de file_roots :

**/srv/salt/_grains**

Les nouveaux grains seront déployés après un state.highstate ou en utilisant saltutil.sync_grains/saltutil.sync_all

Exemple de grain custom :

    todo


### Pillars

#### Utiliser des données pillars dans nos fichiers d'état

Soit en spécifiant directement l'ensemble de clé valeur :

    {{ pillar['key1']['key2'] }}

ou avec la méthode get :

    {{ salt['pillar.get']('key1:key2', 'default_value_if_empty') }}

#### Avec Jinja

    {% for user, uid in pillar.get('users', {}).items() %}
    {{user}}:
      user.present:
          - uid: {{uid}}
    {% endfor %}

Dans ce cas, on liste tout les items du dictionnaire users et on récupère ses id.

#### Avec jinja et les grains dans une définition de variable pillar

**/srv/pillar/pkg/init.sls**

    pkgs:
      {% if grains['os_family'] == 'RedHat' %}
      apache: httpd
      vim: vim-enhanced
      {% elif grains['os_family'] == 'Debian' %}
      apache: apache2
      vim: vim
      {% elif grains['os'] == 'Arch' %}
      apache: apache
      vim: vim
      {% endif %}

!!! note
    ne pas oublier d'ajouter le fichier au top file.

La valeur est ensuite utilisable ainsi:

    apache:
      pkg.installed:
        - name: {{ pillar['pkgs']['apache'] }}

Si l'on veut une valeur par défaut (httpd)

    apache:
      pkg.installed:
        - name: {{ salt['pillar.get']('pkgs:apache', 'httpd') }}

#### Exemple de fichier d'état (state) avec l'utilisation de pillar

**Fichier state**

*/srv/salt/vim.sls*

    vim:
      pkg:
        - installed
        - name: {{ pillar['pkgs']['vim'] }}

    /etc/vimrc:
      file.managed:
        - source: {{ pillar['vimrc'] }}
        - mode: 644
        - user: root
        - group: root
        - require:
          - pkg: vim

**Fichier pillar associé**

*/srv/pillar/vim.sls*

    {% if grains['id'].startswith('dev') %}
    vimrc: salt://edit/dev_vimrc
    {% elif grains['id'].startswith('qa') %}
    vimrc: salt://edit/qa_vimrc
    {% else %}
    vimrc: salt://edit/vimrc
    {% endif %}

1. En fonction des grains, on détermine le path du fichier vimrc dans le fichier pillar.
2. On récupère le path local dans salt pour envoyer le bon fichier vimrc au minion grâce à la variable pillar.


### Best Practices et Formula

Lorsqu'on se retrouve à gérer beaucoup de fichiers d'état pour plusieurs hôte, il devient primordiale de s'organiser :

* [Best_practices](https://docs.saltstack.com/en/latest/topics/best_practices.html)
* [Formulas](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#salt-formulas)
* [Gitfs](https://docs.saltstack.com/en/latest/topics/tutorials/gitfs.html#git-fileserver-backend-walkthrough)
* [GitHub des formulas communautaires](https://github.com/saltstack-formulas)

#### Best Practises

* Avoir recours au paramètre name le plus souvent (ne pas utiliser un path ou un nom de package directement par exemple)
* Utilisez des ID d'état decrivant l'action.
* Utilisez la notation en module.fonction

Exemple :

    # Comment individual states as necessary.
    update_a_config_file:
      # Provide details on why an unusual choice was made. For example:
      #
      # This template is fetched from a third-party and does not fit our
      # company norm of using Jinja. This must be processed using Mako.
      file.managed:
        - name: /path/to/file.cfg
        - source: salt://path/to/file.cfg.template
        - template: mako

* Ne pas utiliser Jinja à outrance pour ne pas complexifier la lecture d'un fichier d'état.
* Organiser l'application et la configuration de services par l'intermédiaire des formulas (rôles).
* Utilisez pillar pour les données variant d'un projet à un autre et les données confidentielles.
* Splitter les état en plusieurs fichiers par application de fonctionnalitées.

#### Formulas

Ce sont finalement comme les rôles (Ansible) à appliquer.
Les Formulas ont l'avantage de segmenter proprement l'arborescence et d'avoir un niveau assez fin de modularité.
On pourra appliquer des formulas pour divers projets.

Chaque formula est sous forme d'un repo git.

Prise en compte au niveau du master :

    file_roots:
      base:
        - /srv/salt
        - /srv/formulas/icinga2-formula

Arborescence type d'une formula :

    icinga2-formula/
    ├── icinga2
    │   ├── files
    │   │   └── etc
    │   │       ├── apt
    │   │       │   └── preferences.d
    │   │       │       └── icinga2.pref
    │   │       └── icinga2
    │   │           ├── conf.d
    │   │           │   ├── hosts.conf
    │   │           │   └── services.conf
    │   │           └── icinga2.conf
    │   ├── init.sls
    │   ├── map.jinja
    │   ├── master_conf.sls
    │   └── repo.sls
    ├── pillar.example
    └── README.md

Où chaque formula est un repo git.
Il est possible d'utiilser gitfs pour que la mise à jour des formulas soit automatique.

##### map.jinja

Il s'agit ici de livrer des formula prête à l'utilisation sans utiliser forcement les pillar (ou très peu).
On écrit donc toutes les variables par défaut dans le fichier map.jinja en plus d'un exemple de configuration de pillar à la racine du repo.

Exemple *map.jinja* :

    {% set icinga2 = salt['grains.filter_by']({
        'default': {
            'master' : 'icinga2_master',
            'service' : 'icinga2',
            'conf': {
                'master' : '/etc/icinga2/icinga2.conf',
                'master_source' : 'salt://icinga2/files/etc/icinga2/icinga2.conf',
                'hosts' : '/etc/icinga2/conf.d/hosts.conf',
                'hosts_source' : 'salt://icinga2/files/etc/icinga2/conf.d/hosts.conf',
                'services' : '/etc/icinga2/conf.d/services.conf',
                'services_source' : 'salt://icinga2/files/etc/icinga2/conf.d/services.conf',
            },
        },
        'Debian': {
            'pkgs': [
                'icinga2',
                'nagios-plugins',
            ],
            'repo': {
                'humanname': 'debmon_for_icinga',
                'file': '/etc/apt/sources.list.d/debmon_for_icinga.list',
                'name': 'deb http://debmon.org/debmon debmon-' + salt['grains.get']('lsb_distrib_codename') + ' main',
                'key_url': 'https://debmon.org/debmon/repo.key',
            },
            'apt': {
              'preferences_name' : '/etc/apt/preferences.d',
              'preferences_source' : 'salt://icinga2/files/etc/apt/preferences.d',
            },
        },
    },
    grain='os', merge=salt['pillar.get']('icinga2:lookup'), base='default') %}

Grâce à cette méthode, on pourra définir un fichier pillar supplémentaire pour surpasser certaines variables.

On pourra récupérer dans tous les fichiers d'état et template jinja, la variable icinga2 précedement définie.

En écrivant un en tête : 

    {% from "icinga2/map.jinja" import icinga2 with context %}

Et utiliser la variable icinga2 :

    incinga_service:
      service.running:
        - name: {{ icinga2.service }}
        - enable: True
        - reload: True





ISSUES
-----------------------------

### No Top file or external nodes data matches found:

Vérifier en plus du top file si la version du master et du minion est identique.

### Conflicting ID

Il doit surement manquer un nom pour définir votre déclaration (plusieurs nom de déclaration de states identique)

### Ordonner les déclarations avec pillar:

Il suffit de déclarer les clés sous formes de liste:

    ma_cle:
      - var1
      - var2 
      ...

au lieu de:

    ma_cle:
      var1
      var2
      ...

### Unable to manage file: Jinja variable 'dict object' has no attribute 'mysql

Ces messages apparaissent lorqu'une clé est manquante!

Il faut s'assurer qu'elle est présente au niveau des pillars (si cet attribut fait référence à un attribut stocké dans pillar):

    salt 'target' pillar.get monObjet

ou encore

    salt 'target' pillar.items

### Cannot find unit for notify message of PID

Bizarrement, le fichier /lib/systemd/system/salt-minion.service n'était plus sous la bonne forme.
Il faut qu'il ressemble à ça :

    [Unit]
    Description=The Salt Minion
    After=network.target

    [Service]
    Type=simple
    ExecStart=/usr/bin/salt-minion

    [Install]
    WantedBy=multi-user.target

Puis recharger la conf :

    systemctl daemon-reload

Et enfin redérammer le service :

    systemctl restart salt-minion.service

### Recurse failed: none of the specified sources were found

Si vous êtes sûr que les fichiers sources existent et que vous avez ce message,
il semble qu'il y ai un bug avec l'ajout de certain fichiers au file_roots du salt-master.

Voir le lien suivant: [modifier le backend](https://github.com/saltstack/salt/issues/22787).

Voici les actions qui ont résolu le pbs :

* Ajout explicite du fileserver_backend :

    fileserver_backend:
      - roots

* Suppression d'un dossier qui semblait à l'origine du problème dans un de mes formulas :

    file_roots:
      base:
        - /srv/salt
        - ... # <= un formula/dossier ajouté récemment aux file_roots peut faire buguer le master.

Pour ma part c'était un dossier contenant un ensemble de certificats (formula-systems/systems/files/usr/certificates/....)
