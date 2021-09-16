V A G R A N T
==============================

Links
-----------------------------

* [Official doc](https://docs.vagrantup.com/v2/getting-started/)
* [Download](https://www.vagrantup.com/downloads.html)
* [Boxes](https://vagrantcloud.com/)
* [Bonus](https://wooster.checkmy.ws/2014/06/cms-dev-environnement/)
* [Cloud vagrant](https://vagrantcloud.com)
* [Atlas hashicorp](https://atlas.hashicorp.com/boxes/search)
* [Créer son repo local de box](http://swaeku.github.io/blog/2013/07/20/create-a-local-repository-of-vagrant-base-boxes/)
* [Créer une box de base](https://github.com/fespinoza/checklist_and_guides/wiki/Creating-a-vagrant-base-box-for-ubuntu-12.04-32bit-server)
* [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc)

Voir aussi du coté de la solution packer pour la création d'image.
Il est issu du même créateur que Vagrant.

What is it?
-----------------------------

Vagrant permet de créer et configurer simplement des environnemnts virtuels.
Il s'appui sur un fichier Vagrantfile pour décrire les actions à faire pour créer son environnement.
C'est un système semblable aux Dockerfile mais compatible sur plus de plateformes.
Le but étant d'utiliser des VM/CT templates et d'y ajouter plusieurs couches logiciels et du provisionning. 
Puis de distribuer ses modifications.

Une des force de Vagrant actuellement est le fait qu'il puisse utiliser plusieurs type d'environnement
et "intègre" une façon simple d'utiliser des systèmes de provisioning tiers tel qu'Ansible...

How it works?
-----------------------------

Vagrant est écrit en Ruby.
C'est une surcouche de gestion d'un système d'environnement virtuel (VM, contenurs) permettant la création, le provisioning, le partage d'environement (box) de façon simplifié.

### VagrantFile

Vagrant s'appuie sur des Vagrantfile pour provisionner et configurer ses vm depuis une box.
            
### Boxes - Image de base

Les boxs sont simplement des images de bases utilisées pour builder les environnements.

### Providers

Ce sont les socles qui vont nous permettre de créer des environnements de type VM ou CT (VirtualBox, lxc, docker ...).

### Synchro

Par défaut lorsque on instancie un environnement,
Ce dernier dispose à la racine de son fs d'un dossier /vagrant partagé avec son hôte.
Le /vagrant est lié au dossier du projet.

Installation
-----------------------------

### Vagrant

Pour bénéficier de la dernière version,
RDV sur la page de download :

[Download](https://www.vagrantup.com/downloads.html)

Sous Ubuntu, on peut le faire directement depuis le gestionnaire de packages :

    sudo apt-get install vagrant

### Providers

#### Virtualbox

Ajouter Virtualbox si ce n'est pas déja fait:

    sudo apt-get install virtualbox

#### Lxc

    sudo apt-get install vagrant-lxc

ou

    vagrant plugin install vagrant-lxc

Configuration
-----------------------------

### Fichiers vagrant

Tous les fichiers téléchargés par vagrant sont disponible dans son /home

**$HOME/.vagrant.d**

### Choix du provider

[providers](https://www.vagrantup.com/docs/providers/)

Par défaut vagrant fonctionne sous virtualBox
Pour changer de provider, il suffit de rajouter une option lors du vagrant up.

    vagrant up --provider=Mon_Provider

Exemple :

    vagrant up --provider=virtualbox

### vagrant-lxc

[vagrant-lxc](https://github.com/fgrehm/vagrant-lxc)

Manipulations
-----------------------------

### Démarrer un environnement rapidement :

    vagrant init maBox      #Création d'un Vagrantfile.
    vagrant up              #Démarrer et provisionner une instance d'une box à partir d'un VagrantFile
    vagrant ssh             #Se connecter à la machine créee.
    vagrant destroy [name]  #Détruire une instance. (depuis le dossier projet ou renseigner le nom de l'environnement)

Exemple avec une box disponible sur le cloud vagrant :

    vagrant init hashicorp/precise64
    vagrant up --provider=virtualbox
    vagrant ssh

Si vous lancez l'interface virtualbox, vous verrez votre VM en mode running.

### Créer un projet avec un Vagrantfile
            
    mkdir monProjet
    cd monProjet
    vagrant init

**Vagrantfile**

    # -*- mode: ruby -*-
    # vi: set ft=ruby :

    # All Vagrant configuration is done below. The "2" in Vagrant.configure
    # configures the configuration version (we support older styles for
    # backwards compatibility). Please don't change it unless you know what
    # you're doing.
    Vagrant.configure("2") do |config|
      # The most common configuration options are documented and commented below.
      # For a complete reference, please see the online documentation at
      # https://docs.vagrantup.com.

      # Every Vagrant development environment requires a box. You can search for
      # boxes at https://atlas.hashicorp.com/search.
      config.vm.box = "base"

      # Disable automatic box update checking. If you disable this, then
      # boxes will only be checked for updates when the user runs
      # `vagrant box outdated`. This is not recommended.
      # config.vm.box_check_update = false

      # Create a forwarded port mapping which allows access to a specific port
      # within the machine from a port on the host machine. In the example below,
      # accessing "localhost:8080" will access port 80 on the guest machine.
      # config.vm.network "forwarded_port", guest: 80, host: 8080

      # Create a private network, which allows host-only access to the machine
      # using a specific IP.
      # config.vm.network "private_network", ip: "192.168.33.10"

      # Create a public network, which generally matched to bridged network.
      # Bridged networks make the machine appear as another physical device on
      # your network.
      # config.vm.network "public_network"

      # Share an additional folder to the guest VM. The first argument is
      # the path on the host to the actual folder. The second argument is
      # the path on the guest to mount the folder. And the optional third
      # argument is a set of non-required options.
      # config.vm.synced_folder "../data", "/vagrant_data"

      # Provider-specific configuration so you can fine-tune various
      # backing providers for Vagrant. These expose provider-specific options.
      # Example for VirtualBox:
      #
      # config.vm.provider "virtualbox" do |vb|
      #   # Display the VirtualBox GUI when booting the machine
      #   vb.gui = true
      #
      #   # Customize the amount of memory on the VM:
      #   vb.memory = "1024"
      # end
      #
      # View the documentation for the provider you are using for more
      # information on available options.

      # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
      # such as FTP and Heroku are also available. See the documentation at
      # https://docs.vagrantup.com/v2/push/atlas.html for more information.
      # config.push.define "atlas" do |push|
      #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
      # end

      # Enable provisioning with a shell script. Additional provisioners such as
      # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
      # documentation for more information about their specific syntax and use.
      # config.vm.provision "shell", inline: <<-SHELL
      #   apt-get update
      #   apt-get install -y apache2
      # SHELL
    end

Note : c'est ce dossier qui sera synchronisé dans /vagrant de l'instance.

### Installer une box

Afficher les boxs installées :

    vagrant box list

Voir aussi dans :

    $HOME/.vagrant.d/boxes

Rechercher dans la liste des box publiques sur le [cloud vagrant](https://vagrantcloud.com)
Renommé [atlas hashicorp](https://atlas.hashicorp.com/boxes/search)

Importer une box :

    vagrant box add maBox [/path/to/the/new_box]

Exemple d'une box disponible sur le cloud :

    vagrant box add hashicorp/precise32

### Utiliser/Instancier une box

Pour instancier une box, il faut renseigner dans le Vagrantfile la box de base :

Exemple :

**Vagrantfile**

    Vagrant.configure("2") do |config|
      config.vm.box = "hashicorp/precise64"
      #config.vm.box_version = "1.1.0"
      #config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    end

On peut aussi y renseigner l'url où se trouve la box et sa version.

Maintenant pour builder l'instance depuis le dossier avec le Vagrantfile :

    vagrant up

!!! note
    On utilisera la même commande pour démarrer une instance qui a été stoppée.

Et pour s'y connecter :

    vagrant ssh


### Provisionner une box

Il y a plusieurs manières de provisionner une instance

#### Copier des fichiers de l'hôtes vers l'instance

Exemple de copie de fichier :

    Vagrant.configure("2") do |config|
    # ... other configuration

      config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
    end

#### Lancer des scripts shell

[doc provisioning shell](https://www.vagrantup.com/docs/provisioning/shell.html)

Voir la doc pour toutes les possibilités.

Exemple pour un script "inline" :

    $script = <<SCRIPT
    echo I am provisioning...
    date > /etc/vagrant_provisioned_at
    SCRIPT

    Vagrant.configure("2") do |config|
      config.vm.provision "shell", inline: $script
    end

Exemple pour un script "externe" :

    Vagrant.configure("2") do |config|
      config.vm.provision "shell", path: "script.sh"
    end

Exemple de script.sh :

    #!/usr/bin/env bash                                                                                                  
    apt-get update
    apt-get install -y nginx
    ln -fs /vagrant/www /var/www
    

#### Utiliser un système de provisioning tiers

Dans ce cas on fera appel à un système de provisioning existant tel que Ansible, Puppet, Saltstack.

##### Ansible

[provisioning avec ansible](https://www.vagrantup.com/docs/provisioning/ansible.html)

Exemple d'utilisation avec Ansible :

    Vagrant.configure("2") do |config|
      #
      # Run Ansible from the Vagrant Host
      #
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
      end
    end

### Manipulations sur les instances

**Afficher les instances :**

    vagrant global-status

**Démarrer une instance :**

    vagrant up INSTANCE_ID

**Se connecter à une instance :**

    vagrant ssh INSTANCE_ID

**Stopper une instance :**

    vagrant halt INSTANCE_ID

**Supprimer une instance :**

    cd monProjet
    vagrant destroy

ou

    vagrant destroy [instance id]

**Suspendre une instance :**

(Sauvegarde l'état courant avant de l'éteindre)

    vagrant suspend

**Stopper une instance :**

    vagrant halt

**Relancer le provisioning sur une instance :**

    vagrant reload --provision

### Networking

#### Port Forwarding :

Partage de port entre l'hôte et la vm :

**Vagrantfile**

    config.vm.network :forwarded_port, host: 8080, guest: 80

<!-- endvim -->

    vagrant reload

### Vagrant Share

Le partage Vagrant permet de mettre à disposition son environnement instancié facilement.
Il utilise le cloud Vagrant pour que le partage soit accessible de n'importe quel endroit :

Créer un compte :

[compte Vagrant](https://vagrantcloud.com/account/new)

Se loguer :

    vagrant login

Raccourci pour stopper le partage :

**CTRL + C**

#### HTTP sharing :

Ce procédé permet de partager directement l'interface http de sa machine.

partager :

    vagrant share

Pour forcer sur le port http ou https :

    vagrant share --http monPortHttp et/ou --https monPortHttps

Attention de bien partager le port sa VM!

Cette action créera un lien pour que d'autre personnes puissent visionner votre environnement.
Très pratique en cas de présentation.

**Note :**

Les application doivent utiliser des path relatif pour le chargement d'assets.

#### SSH sharing :

    vagrant share --ssh

Il suffira ensuite de setter un mot de passe et d'utiliser la commande dumpée par vagrant.

Pour n'autoriser qu'une seule connexion :

    vagrant share --ssh --ssh-once

#### General sharing :

Accéder aux ports partagés.

### Importer / Exporter une box

Dirty way :

* Créer son environnement avec 'vagrant package'
* vagrant box add ...
* vagrant up
* Puis copier les fichiers du projets

Clean way :

Utiliser simplement un outils de gestion de version comme git, mercurial ...
Pour versionner ses projets et effectuer simplement un pull/clone de votre repo :

    git clone monProjet
    vagrant up

### Boxes manipulations générales

**Lister :**

    vagrant box list

**Mettre à jour :**

    vagrant box update

**Packager :**

    vagrant package --base vagrant_base --output new.box --vagrantfile box.Vagrantfile

**Supprimer :**

    vagrant box remove maBox [--box-version X.X] [--all]
