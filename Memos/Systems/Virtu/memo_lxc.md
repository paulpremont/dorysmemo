# L X C

## Links

* [site offciel](https://linuxcontainers.org/)
* [wikipedia](http://fr.wikipedia.org/wiki/Cgroups#mediaviewer/Fichier:Linux_kernel_unified_hierarchy_cgroups_and_systemd.svg1)
* [wiki debian](https://wiki.debian.org/LXC)
* [docs oracle](http://docs.oracle.com/cd/E37670_01/E37355/html/ol_config_os_containers.html)

## What is it ?

LXC pour Linux Containers est une sorte de chroot gonflé aux hormones de taureaux permetant de créer plusieurs sous-tables de processus et créer des conteneurs système ou applicatif.

Il a l'avantage d'être plus légé que de la virtualisation mais partage le noyau de l'hôte avec tous les autres conteneurs.

## How it works ?

Il fournit une API et un set d'outils permettant de dialoguer avec la couche kernel utilisant notament :

* Les namespaces kernel (ipc, uts, mount, pid, network and user)
* Apparmor and SELinux profiles
* Seccomp policies
* Chroots (using pivot_root)
* Les capacités du Kernel
* CGroups (control groups)

LXC s'appuie sur les cgroup pour l'isolation des processus.

L'API peut être pilotées depuis plusieurs langages comme :

* Python
* Go
* Ruby
* ...

## Installation rapide

```
sudo apt install lxc
sudo lxc-create -n NomConteneur -t download
sudo lxc-start -n NomConteneur
sudo lxc-attach -n NomConteneur
```

## Les commandes essentielles

```
#Stopper (pour manipuler) :
sudo lxc-stop -n monCT

#Copier :
sudo lxc-copy -n monCT -N monCT2

#Supprimer :
sudo lxc-destroy -n monCT
```


## Installation manuelle (archive)

### Sous Debian

```
apt-get install lxc bridge-utils libvirt-bin debootstrap
```

### Depuis les sources

```
git clone git://github.com/lxc/lxc
```

## Configuration (optionel)

### Préparation de l'hôte

cgroup: limiter/compter et isoler l'utilisation des ressources

    vim /etc/fstab


    cgroup  /sys/fs/cgroup  cgroup  defaults  0   0


    mount /sys/fs/cgroup

#### Check du kernel

    lxc-checkconfig

Si il manque des choses, il faudra penser à recompiler son noyau.
Ou checker la version de son kernel.

### Mode bridge

[Configurer les interfaces réseaux en mode bridge](https://wiki.debian.org/fr/LXC/SimpleBridge)

Exemple over dhcp :

1) Installation des packages

    apt-get install bridge-utils

2) Configuration du bridge sur l'hôte

**/etc/network/interfaces**

    iface eth0 inet manual

    auto br0
    iface br0 inet dhcp
        bridge-ifaces eth0
        bridge_ports eth0
        bridge_fd 0
        bridge_maxwait 0
        up ifconfig eth0 up

3) Configurer le conteneur pour se rattacher sur cette nouvelle interface (depuis l'hôte)

**/var/lib/lxc/containername/config**

    #Network part
    lxc.network.type = veth
    lxc.network.link = br0
    lxc.network.flags = up
    lxc.network.hwaddr = XX:XX:XX:XX:XX:XX

4) Redémarrer les interfaces et le conteneur

Bien tout cleaner :

    sudo ifconfig eth0 0
    sudo ifdown eth0

Puis démarrer l'interface et le conteneur
    
    sudo ifup br0
    sudo lxc-stop containername && sudo lxc-start containername

Si vous avec un problème quelque part, le résultat doit être le suivant :

Après un **ifconfig** :

* pas d'addresse sur eth0
* un adresse dhcp sur br0

Après un **route -n** :

* Interface de gw par défaut : br0
* Interface vers le réseau lan : br0
* Plus de référence à eth0 dans la table de routage


Création de conteneurs
-----------------------------

### RootFS :

C'est l'image de base qui sera utilisée pour instancier un conteneur.

Notes :

* On peut apparament forcer l'install en 32bit en rajoutant linux32 devant la commande.

* Si l'on install un template issu d'une autre distribution, il faudra installer quelques paquets supplémentaires.
(par exemple yum et curl lorsqu'on tente d'installer du redhat sur du Debian).  
Par contre pas de package zypper dispo pour opensuse

### Templates :

C'est la manière la plus simple et rapide de créer un conteneur.

Il existe plusieurs templates dispo:

    ls /usr/share/lxc/templates

Créer un conteneur à partir d'un modèle :

    lxc-create -n NOM_CONTENEUR -t MON_TEMPLATE

Exemples :

    lxc-create -t download -n test -- -d debian -r bullseye -a amd64
    lxc-create -n fooct -t download #mode interactif

!!! note
    Pour pouvoir installer un conteneur en mode interactif, il faudra passer par le template "download"

!!! passer en mode interractif en cas d'erreur avec un template téléchargé
    (Voir : https://github.com/lxc/lxc/issues/1799)
    Exemple : lxc-create -t download -n test -- -d debian -r stretch -a arm64

#### Copier un conteneur existant :

Personnaliser votre propre template et cloner vos conteneurs à partir de ce dernier :

    lxc-copy -n monConteneurTemplate -N monNouveauCT 

### Conteneurs sans privilèges :

Ce sont les conteneurs les plus sûrs.

Cela empêche notament :

* Le montage de la plupart des FS
* Créer des périphériques
* Toutes opération sur les uid/gid en dehors de ceux alloués.

L'utilisateur doit avoir un ui et un gid définit dans :

* /etc/subuid 
et
* /etc/subgid

Sinon voir usermod.

Autoriser l'utilisateur de créer des périphériques réseaux :

(lié à /etc/lxc/lxc-usernet)

    your-username veth lxcbr0 10

Dans cet exemple, l'utilisateur pourra créer 10 interfaces virtuelles rattachées au bridge lxcbr0.

    mkdir ~/.config/lxc
    cp /etc/lxc/default ~/.config/lxc/default.conf

Ajouter l'uid et le gid récupéré précedement dans la nouvelle conf :

    echo "lxc.id_map = u 0 100000 65536" >> ~/.config/lxc/default.conf
    echo "lxc.id_map = g 0 100000 65536" >> ~/.config/lxc/default.conf

### Conteneurs avec privilèges :

Simplement en utilisant l'utilisateur root.

    sudo lxc-create -n my_vm_name -t template_name_to_download

Note si l'on souhaite utiliser un modèle existant dans 

    /usr/share/lxc/templates

Il ne faut pas utiliser le préfix "lxc-"

Exemple :

    sudo lxc-create -n test -t debian

On peut utiliser le template "download" pour télécharger un nouveau modèle depuis le repo officiel

    sudo lxc-create -t download -n foolxc

Réseau
-----------------------------

### Config réseau

Voir aussi ebtables

Pour la partie config réseau, il existe plusieurs manières de faire

#### Bridge

    vim /var/lib/lxc/MON_CONTENEUR/config  

<!-- vim -->
 
    ## Network

    lxc.utsname = MON_CONTENEUR
    lxc.network.type = veth
    lxc.network.flags = up

    # that's the interface defined above in host's interfaces file
    lxc.network.link = br0

    # name of network device inside the container,
    # defaults to eth0, you could choose a name freely
    # lxc.network.name = lxcnet0

    lxc.network.hwaddr = 00:FF:AA:00:00:01

    # the ip may be set to 0.0.0.0/24 or skip this line
    # if you like to use a dhcp client inside the container
    # lxc.network.ipv4 = 192.168.1.110/24

Niveau host:

    vim /etc/network/interfaces

<!-- vim -->

    auto br0
    iface br0 inet dhcp
    bridge_ports eth0
    bridge_fd 0
    bridge_maxwait 0

Manipuler un conteneur
-----------------------------

/!\ si on a builder les conteneurs à partir de l'utilisateur root, il faudra lancer toutes les commandes avec root (ou sudo).

### Démarrer un conteneur

    lxc-start -n CONTAINER -d       #Démarrer en mode deamon
    lxc-start -n CONTAINER -F       #Démarrer en mode foreground

### Se rattacher à un conteneur :

Se rattacher au CT avec le shell par défaut (si pas d'options spécifiées).

    lxc-attach -n myCT

!!!note
    Il se peut que l'invit de commande soit du type "bash-4.2#"
    Dans ce cas faire un : "sudo su -"

Accéder au conteneur en lanceant une console (tty1)

    lxc-console -n myCT -t 1

<!-- -->

    Type <Ctrl+a q> to exit the console, <Ctrl+a Ctrl+a> to enter Ctrl+a itself
    (nécessite d'avoir le service tty configuré)

### Obtenir des infos:

**Afficher les conteneurs :**

    lxc-ls -f CONTAINER

**Afficher les infos sur un conteneur :**

    lxc-info -n monCT

Son adresse IP :

    lxc-info -n container-name -iH

### Arréter un conteneur:

    lxc-halt -n CONTAINER   #proprement
    lxc-stop -n CONTAINER   #mechament

### Détruire un conteneur:

    lxc-destroy -n myCT

### Conteneur au démarrage de l'hôte

    ln -s /var/lib/lxc/CONTENEUR/config /etc/lxc/auto/CONTENEUR

Configurer un conteneur
-----------------------------

Chaque conteneur dispose de son dossier :

    /var/lib/lxc/MON_CT

Avec sa config :

    sudo cat /var/lib/lxc/my_lxc_container/config

<!-- vim -->

    # Template used to create this container: /usr/share/lxc/templates/lxc-debian
    # Parameters passed to the template:
    # For additional config options, please look at lxc.container.conf(5)

    # Uncomment the following line to support nesting containers:
    #lxc.include = /usr/share/lxc/config/nesting.conf
    # (Be aware this has security implications)

    lxc.network.type = veth
    lxc.network.link = lxcbr0
    lxc.network.flags = up
    lxc.network.hwaddr = 00:16:3e:8e:5a:cc
    lxc.rootfs = /var/lib/lxc/my_lxc_container/rootfs
    lxc.rootfs.backend = dir

    # Common configuration
    lxc.include = /usr/share/lxc/config/debian.common.conf

    # Container specific configuration
    lxc.tty = 4
    lxc.utsname = my_lxc_container
    lxc.arch = amd64

et de son rootfs  :

    /var/lib/lxc/my_lxc_container/rootfs
    ├── bin
    ├── boot
    ├── dev
    ├── etc
    ├── home
    ├── lib
    ├── lib64
    ├── {lib,etc}
    ├── media
    ├── mnt
    ├── opt
    ├── proc
    ├── root
    ├── run
    ├── sbin
    ├── selinux
    ├── srv
    ├── sys
    ├── tmp
    ├── usr
    └── var

### Partie sécurité

* [https://stgraber.org/2014/01/01/lxc-1-0-security-features/](https://stgraber.org/2014/01/01/lxc-1-0-security-features/)
* [https://gist.github.com/dash17291/4598721](https://gist.github.com/dash17291/4598721)

Par défaut les conteneurs sont "sécurisés" et bon nombre de fonctionnalitées sont désactivée, surtout celle concernant la modification du kernel de l'hôte.

Il est possible d'influer sur les paramètres cgroup pour augmenter les droits d'un conteneur.

Exemple (tout autoriser au niveau des devices) :

    lxc.cgroup.devices.allow               = a

Exemple de configuration du github gist :

    ## Devices
    # Allow all devices
    #lxc.cgroup.devices.allow               = a
    # Deny all devices
    lxc.cgroup.devices.deny                 = a
    # Allow to mknod all devices (but not using them)
    lxc.cgroup.devices.allow                = c *:* m
    lxc.cgroup.devices.allow                = b *:* m

    # /dev/console
    lxc.cgroup.devices.allow                = c 5:1 rwm
    # /dev/fuse
    lxc.cgroup.devices.allow                = c 10:229 rwm
    # /dev/null
    lxc.cgroup.devices.allow                = c 1:3 rwm
    # /dev/ptmx
    lxc.cgroup.devices.allow                = c 5:2 rwm
    # /dev/pts/*
    lxc.cgroup.devices.allow                = c 136:* rwm
    # /dev/random
    lxc.cgroup.devices.allow                = c 1:8 rwm
    # /dev/rtc
    lxc.cgroup.devices.allow                = c 254:0 rwm
    # /dev/tty
    lxc.cgroup.devices.allow                = c 5:0 rwm
    # /dev/urandom
    lxc.cgroup.devices.allow                = c 1:9 rwm
    # /dev/zero
    lxc.cgroup.devices.allow                = c 1:5 rwm

    ## Limits
    #lxc.cgroup.cpu.shares                  = 1024
    #lxc.cgroup.cpuset.cpus                 = 0
    #lxc.cgroup.memory.limit_in_bytes       = 256M
    #lxc.cgroup.memory.memsw.limit_in_bytes = 1G

    ## Filesystem
    lxc.mount.entry                         = proc proc proc nodev,noexec,nosuid 0 0
    lxc.mount.entry                         = sysfs sys sysfs defaults,ro 0 0
    # Bind mounting host's resolv.conf to the container.
    lxc.mount.entry                         = /etc/resolv.conf /vz/lxc/template/rootfs/etc/resolv.conf none bind 0 0


L'API
-----------------------------

### Python :

Exemple :

    import lxc
    container = lxc.Container('CONTAINER_NAME')
    container.create('IMAGE')
    container.start
    container.get_ips()
    container.stop()

Les FS
-----------------------------

### BTRFS :

C'est un FS crée dans le but de faire des snapshots, checksums ...
A coupler avec LXC pour pouvoir manier les conteneur facilement et rapidement.

Pour le manipuler voir le tool : btrfs-tools

### LXCFS :

todo

### Mettre une IP statique

Sources : 

- [Forum](https://askubuntu.com/questions/1087073/lxc-3-0-2-equivalent-of-lxc-network-type-veth)
- [Man page](https://linuxcontainers.org/lxc/manpages/man5/lxc.container.conf.5.html)

```
vim /var/lib/lxc/nom-ct/config

lxc.net.0.ipv4.address = 10.0.10.5/24
```

Troubleshooting
-----------------------------

### Failed de l'install centos

    Host CPE ID from /etc/os-release: 
    'yum' command is missing
    lxc-create: lxccontainer.c: create_run_template: 1297 container creation template for foo failed
    lxc-create: tools/lxc_create.c: main: 318 Error creating container fooA36656F13D115564D1FA44C45A736

Si vous etes sur une Debian like, il faudra explicitement nommer la version de centos :

    lxc-create -n centos -t download
    
    Distribution: centos
    Release: 7
    Architecture: amd64
