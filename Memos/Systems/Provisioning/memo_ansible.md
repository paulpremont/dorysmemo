A N S I B L E
==============================

Links
-----------------------------

* [docs produits](http://docs.ansible.com/)
* [doc ansible](http://docs.ansible.com/ansible/index.html)
* [ansible github](https://github.com/ansible/ansible)
* [video ansible](https://www.ansible.com/videos)

Des comparatifs :

(lire les comments qui sont aussi intéressants).

[salt vs ansible](http://jensrantil.github.io/salt-vs-ansible.html)
[puppet to salt or ansible](http://ryandlane.com/blog/2014/08/04/moving-away-from-puppet-saltstack-or-ansible/)

What is it?
-----------------------------

Ansible est un système d'automatisation IT, permettant de configurer, automatiser et maintenir à jour des hôtes.  
C'est un système de provisioning comparable à Puppet et SaltStack.

How it works?
-----------------------------
    
[How ansible works](https://www.ansible.com/how-ansible-works)

Ansible est écrit en python et est agent less (sans agent).
Mais il a tout de même besoin d'un moyen de connection comme ssh.  
Ce qui nécessite d'installer et configurer un agent ssh sur chaque client.
Note : si la version d'OpenSSH n'est pas supportée, Ansible utilisera l'implementation SSH de python : "paramiko".

Cette manière de faire a l'avantage de ne pas devoir mettre à jour des agents côté client,
de s'appuiyer sur un protocole de sécurité éprouvé et permet un fonctionnement en mode distribué.
Par contre à voir niveau performance mais cela risque d'être conséquent si l'on a beaucoup de noeuds à gérer.

Pour effectuer les copies de fichiers, ansible utilise par défaut sftp, mais peut être configuré avec scp.

Il s'appuie sur YAML pour être configuré, un langage de description de configuration simple à prendre en main. (Comme Saltstack)

Le gros avantage d'ansible, est surtout sa simplicité de mise en oeuvre et de configuration.

Et il contient bon nombre de modules.

### Playbooks

Les playbooks font office de fichiers de description d'état des hôtes à gérer.  
(ce sont les manifests de puppet ou encore les fichier sls de salt)

Ces playbooks contiennent des "plays",
qui eux même contiennent les tâches (tasks) à effectuer.
Chacunes de ces tasks correspondent à l'appel d'un module.

Chaque tâche est lancée séquentiellement.
Elles peuvent déclencher des "handlers".

Exemple de playbook avec deux plays :

    - hosts: webservers
      remote_user: root

      tasks:
      - name: ensure apache is at the latest version
        yum: name=httpd state=latest
      - name: write the apache config file
        template: src=/srv/httpd.j2 dest=/etc/httpd.conf

    - hosts: databases
      remote_user: root

      tasks:
      - name: ensure postgresql is at the latest version
        yum: name=postgresql state=latest
      - name: ensure that postgresql is started
        service: name=postgresql state=started

### Handlers

Ils sont appelés par les "tasks" et sont executés une fois à la fin d'un 'play'.

Via, par exemple, la clause notify :

    tasks :
      ...
      notify:
      - restart apache


Installation
-----------------------------

[installation](http://docs.ansible.com/ansible/intro_installation.html)

### Dépendances

    sudo apt-get install python2.7 python-pip python-dev python-markupsafe software-properties-common openssh-client
    sudo easy_install pip

Note :

python2.7 devra aussi être installé coté client.

### Via les sources

    git clone git://github.com/ansible/ansible.git --recursive
    cd ./ansible
    source ./hacking/env-setup
    sudo pip install paramiko PyYAML Jinja2 httplib2 six
    sudo python setup.py build
    sudo python setup.py install

#### Update :

    cd ansible
    git pull --rebase
    git submodule update --init --recursive

### Via apt

    sudo apt-get install software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install ansible

### Via pip

    sudo pip install ansible

### Test :

    ansible --version
    
Configuration
-----------------------------

[Fichier de configuration](http://docs.ansible.com/ansible/intro_configuration.html#configuration-file)

### Générer la config

Par défaut la configuration doit se trouver dans /etc/ansible.

Mais si l'on a fait l'installation via les sources ou pip, il faut la générer :

    mkdir /etc/ansible
    cd /etc/ansible
    wget https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg

### Configurer l'accès SSH

#### Hosts (serveur ssh) :

Pour que ansible puisse accéder aux clients, il faut installer et configurer ssh (sur les clients) :

    apt-get install openssh-server sudo

Par défaut la connexion SFTP et l'accès via un utilisateur system (sauf root) sont activés.

Evitez d'accéder directement en root aux machines, préférez un utilisateur faisant partie de sudo.

Créer un utilisateur :

    adduser ansible
    sudo usermod -a -G sudo ansible

#### Ansible server (client ssh) :
                            
    apt-get install openssh-client
    ssh-keygen -t rsa

Copier la clé sur un host :

    ssh-copy-id -i id_rsa.pub ansible@monHostToManage

##### Default user et privilèges :

Ansible permet de changer d'utilisateur pour se connecter et appliquer les playbooks.

voir : [become](http://docs.ansible.com/ansible/become.html#become)

    vim /etc/ansible/ansible.conf

<!-- vim -->

    remote_user = ansible
    sudo = yes
    ask_sudo_pass = True

Note : si l'on ne veut pas utiliser de password, il faudra configurer sudo en conséquence :

à la fin du fichier **/etc/sudoers**

    ansible ALL=(ALL) NOPASSWD:ALL

Et dans ce cas, configurer ansible avec les privilèges root :

    [privilege_escalation]
    become=True
    become_method=sudo
    become_user=root
    become_ask_pass=False


### INVENTORY

[inventory](http://docs.ansible.com/ansible/intro_inventory.html)

Constituer son inventaire d'hosts à gérer :

**/etc/ansible/hosts**

    127.0.0.1
    client1
    client2
    ...

#### Groupes :

    [monGroupe]
    hostX
    hostY
    ...

#### Ranges :

    host[a:z].dom
    10.1.0.[01:50]

#### Configurer un type de connexion :

    host1 CONNECTION_TYPE [USER]

Exemple :

    hostX ansible_connection=ssh ansible_user=admin

#### Variables :

TODO ...

#### Inventaire dynamique :

[dynamic_inventory](http://docs.ansible.com/ansible/intro_dynamic_inventory.html)

Ansible supporte l'utilisation d'inventaires externes stockés sur par exemple dans LDAP, Cobbler, Openstack, ou une CMDB...

### Synchro

Cette méthode de synchro entre le serveur et les clients utilise rsync, il faut donc l'avoir installé sur les deux parties.

[module de synchronisation](http://docs.ansible.com/ansible/synchronize_module.html)


Manipulations
-----------------------------

### Documentation

    ansible-doc -l

### PATTERNS

[intro-patterns](http://docs.ansible.com/ansible/intro_patterns.html)

Les patterns servent surtout à ajouter les hôtes que l'on souhaite gérer à notre système.

Exemple :

    ansible <pattern_goes_here> -m <module_name> -a <arguments>

#### Tous les hôtes :

    all
    *
#### Cibler des hôtes ou des groupes d'hôte:

    foo1:foo2:...

#### Exclure les hosts d'un groupe :

    groupe1:!groupe2
                    
#### Les hôtes appartenant à plusieurs groupes (intersections) :

    groupe1:&groupe2

#### Utiliser des variables :

    webservers:!{{excluded}}:&{{required}}


### Tester la connectivité avec les hosts

    ansible all -m ping [OPTIONS]

Exemples :

    ansible all -m ping
    ansible all -m ping --ask-sudo-pass


### Les commandes "Ad-Hoc"

[intro_adhoc](http://docs.ansible.com/ansible/intro_adhoc.html)

Les commandes "Ad-Hoc" sont des commandes que l'on souhaite executer rapidement sur un ou plusieurs hôtes, à la volée.
Pour des besoins plus complexe, on utilisera les playbooks.

#### Fork

    ansible PATTERN -a "SHELL_COMMAND" -f NUMBER_OF_MAX_FORK_PROCESS [-m monModule]

L'option f permet de définir le nombre maximum de commandes lancées en parallèle sur un groupe d'hôte.

Exemple :

    ansible fooservers -a "/sbin/foo" -f 10

Dans ce cas, le /sbin/foo sera lancé sur 10 hôtes en simultané.

#### Background :

Il y a plusieurs manière de lancer une commande ad-hoc en background :

* Avec Polling -P0
* Sans Polling -PX

Le Polling permet de récupérer le status de la commande à interval régulié.

Exemple :

    ansible all -B 1800 -P 60 -a "/usr/bin/long_running_operation --do-stuff"

Lorsqu'on execute une commande en background, le jobid est donné.
On pourra checker le status de cette commande grâce au module async_status

    ansible web1.example.com -m async_status -a "jid=488359678239.2844"


#### Shell commands :

On peut utiliser le module shell pour lancer les commandes à travers un shell :

Par exemple, cela permet d'évaluer une variable dans le shell de l'hôte distant (et pas avant).

**Exemples :**

    #sans le module shell
    ansible testgroup -a 'echo $OLDPWD'

    #avec le module shell
    ansible testgroup -m shell -a 'echo $OLDPWD'

#### File transfer :

##### Copier un fichier sur des hôtes

    ansible testgroup -m copy -a "src=/tmp/file dest=/tmp/file"

##### Changer les permissions

    ansible testgroup -m file -a "dest=/tmp/file mode=600"

#### Lister les facts (les paramètres d'un hôtes) :

    ansible all -m setup

#### D'autres exemples de modules :

* packages
* user and groups
* git
* services


### PLAYBOOKS

#### Ecrire un playbook :

**myfooplaybook.yml**

    --- 
    - name: playbook_name
      hosts: hosts_to_target
      user: ssh_user

      vars:
        var1: XX
        var2: YY

      tasks:
      - name: apply_this
        module specs ...

      handlers:
      - name: restart_this
        module specs

#### Exemple de playbook :

TODO

#### Executer un playbook :

Différentes manière de faire.


En utlisant l'inventaire de ansible :

    ansible-playbook myfooplaybook.yml

On peut spécifier à la volée les targets grâce à l'option -i :

    ansible-playbook raspberrypi_playbook.yml -i "192.168.10.30," --ask-pass

En appliquant les changements localement :

    ansible-playbook -i 'localhost,' -c local monplaybook.yml

En utilisant son fichier d'inventaire :

    ansible-playbook -i 'my_inventory' monplaybook.yml


### VARIABLES

#### basic :

    var: my_value

#### Via les paramètres du script:

    var: "{{ my_param }}"

Pour l'appeler il faudra utiliser l'option -e :

    -e "my_param=value"
                    
#### Via les facts :

Lister les facts d'un hôtes :

    ansible -m setup my_targets

Puis on les récupère simplement avec :

    {{ ansible_var }}

#### Créer des listes :

    var:
        - val1
        - val2

### Projets Ansible

[best practices](http://docs.ansible.com/ansible/playbooks_best_practices.html)

Un projet ansible est une arborescence type.

Exemple proposé par le site officiel :

    production                # inventory file for production servers
    staging                   # inventory file for staging environment

    group_vars/
       group1                 # here we assign variables to particular groups
       group2                 # ""
    host_vars/
       hostname1              # if systems need specific variables, put them here
       hostname2              # ""

    library/                  # if any custom modules, put them here (optional)
    filter_plugins/           # if any custom filter plugins, put them here (optional)

    site.yml                  # master playbook
    webservers.yml            # playbook for webserver tier
    dbservers.yml             # playbook for dbserver tier

    roles/
        common/               # this hierarchy represents a "role"
            tasks/            #
                main.yml      #  <-- tasks file can include smaller files if warranted
            handlers/         #
                main.yml      #  <-- handlers file
            templates/        #  <-- files for use with the template resource
                ntp.conf.j2   #  <------- templates end in .j2
            files/            #
                bar.txt       #  <-- files for use with the copy resource
                foo.sh        #  <-- script files for use with the script resource
            vars/             #
                main.yml      #  <-- variables associated with this role
            defaults/         #
                main.yml      #  <-- default lower priority variables for this role
            meta/             #
                main.yml      #  <-- role dependencies

        webtier/              # same kind of structure as "common" was above, done for the webtier role
        monitoring/           # ""
        fooapp/               # ""

Il est aussi possible de créer son inventaire et vars de façon plus élégante :

    inventories/
       production/
          hosts.ini           # inventory file for production servers
          group_vars/
             group1           # here we assign variables to particular groups
             group2           # ""
          host_vars/
             hostname1        # if systems need specific variables, put them here
             hostname2        # ""



### ROLES

Ils permettent d'organiser les playbooks.

Les rôles définissent une arborescence d'un même type d'utilisation avec :

* les playbooks
* handlers
* fichiers à copier
* templates
* variables
* ...

On peut créer des dépendances entre rôles, des rôles par défaut ...

#### Créer un rôle :

TODO

#### Appeler un rôle depuis un playbook :

    ---
    - hosts: webservers
      roles:
         - common
         - webservers

#### Galaxy

[Ansible Galaxy](https://galaxy.ansible.com/)
[Doc Ansible Galaxy](http://docs.ansible.com/ansible/galaxy.html)

Ansible Galaxy est un dépôt de rôle communautaire.
C'est un moyen simple de récupérer des rôles et de les modifier en fonction de ses besoins.

Pour installer un role disponible sur la plateforme galaxy :

    ansible-galaxy install username.rolename

##### requirements.yml

TODO

### MODULES 

Les modules permettent donc d'executer des actions sur les hôtes.  
(Installer des packages, uploader des fichiers de conf...)

Tous les modules sont listés ici :

[liste des modules](http://docs.ansible.com/ansible/list_of_all_modules.html)


### OPTIONS

#### Check Mode

C'est un "dry-run"

    -C

Ce mode permet de lancer une commande ansible (AdHoc ou playbook) sans appliquer les modifications.
Il permet de voir ce qui changera si on applique cette commande.


### DOCUMENTATION

Voici une partie très bien faite de ansible :

Si l'on cherche un module particulier :

    ansible-doc --list

Pour savoir comment manipuler un module :

    ansible-doc MODULE_NAME

Si on veut n'afficher qu'un résumé :

    ansible-doc --snippet MODULE_NAME


### TEMPLATES

Les temmplates exisent aussi sous ansible avec la prise en charge de jinja2.

#### Ecrire un template :

TODO

#### Evaluer un template :

    - name: A foo template
        template:  src=mon_fichier_templates
                   dest=/foo/path
                   ower=root group=root mode=0644
