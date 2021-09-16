Lego Mindstorms
==============================

What is it ?
-----------------------------

Lego Mindstorms est un kit Lego contenant des moteurs, des capteurs, un cerveau programmable, un software ludique pour apprendre la programmation et les pièces nécessaires pour la construction du robot.

Links
-----------------------------

### Official

* [ev3dev.org](http://www.ev3dev.org)
* [ev3dev getting started](http://www.ev3dev.org/docs/getting-started/)
* [ev3dev ethernet via USB](http://www.ev3dev.org/docs/tutorials/connecting-to-the-internet-via-usb/)
* [Notices](https://www.lego.com/en-us/mindstorms/build-a-robot)
* [Notice ev3storm](https://www.lego.com/en-us/mindstorms/build-a-robot/ev3rstorm)
* [Module python](https://github.com/rhempel/ev3dev-lang-python)
* [Programme Mindstorm](https://www.lego.com/en-us/mindstorms/learn-to-program)
* [Wikipedia](https://en.wikipedia.org/wiki/Lego_Mindstorms_EV3)
* [Le site pour apprendre à programmer son robot : ev3python](https://sites.google.com/site/ev3python/)

How it works ?
-----------------------------

L'EV3 (Troisième génération), utilise un CPU ARM9 et tourne sur un système propriétaire (EV3).  
Malgré tout l'équipe Mindstorm semble vouloir encourager une utilisation plus libre de leur robot.

Il est possible d'utiliser un système alternatif via une carte SD.  
Comme ev3dev bassé sur une Debian.

Installation
-----------------------------

### Android

Sur sa tablette, télécharger l'application lego mindstorm programmer.
Il faudra ensuite activer le bluetooth sur son robot pour charger les programmes écrits depuis sa tablette.

**Note :**

Il faut accepter la connexion depuis le robot et configurer un code pin via l'afichage interactif.
La version tablette est un peu limitée (pas de blocs de données ...).

### ev3dev

#### Prérequis

* La Brique EV3 Mindstorms ou un RaspberryPi.
* Une carte microSD ou SDHC(pas SDXC) <= 32Gb.
* Un moyen de connexion (Bluetooth, USB, Dongle Wifi ...).
* Forcement un PC pour programmer.

On peut utiliser le programme ev3dev qui est un systeme compatible mindstorm, sous debian.

À savoir qu'ev3dev est aussi compatible avec un raspberry.

1. Téléchargement de l'image ev3dev :

Pour la brique EV3 (différente du raspberry) :

    wget https://github.com/ev3dev/ev3dev/releases/download/ev3dev-jessie-2016-10-17/ev3dev-jessie-ev3-generic-2016-10-17.zip
    unzip ev3dev-jessie-ev3-generic-2016-10-17.zip

2. Charger l'image sur la carte SD (Flash) :

    df -h
    sudo dd bs=4M if=ev3dev-jessie-ev3-generic-2016-10-17.img of=/dev/sdX

Si il y a des partitions existantes sur la carte SD, ne pas oublier de les démonter.

3. Boot ev3dev sur l'EV3

Pour charger le nouveau système sur la brique EV3 :

Insérer la carte SD.


Configuration
-----------------------------

### Connexion

Pour se connecter sur le robot et/ou le connecter à internet, on peut le faire via plusieurs méthodes :
Soit avec :

* Un dongle Wifi
* Un dongle Ethernet
* Par bluetooth
* USB over ethernet (câble fourni)

#### Ethernet over USB

C'est la méthode la plus simple.
Il faut brancher le câble USB, allumer son robot et vérifier que l'interface soit montée :

    ifconfig

Un nouveau device vient d'apparaître :

    ifconfig enp0s20f0u2u4c2

Il faut vérifier que l'adresse MAC commence par :

    12:16:53

Ensuite on peut configurer la connexion réseau entre le robot et le PC.

Exemple :

Sur le robot, aller dans **Wireless an Networks > All Network Connections > Wired**.
Si l'on a configuré son PC en mode partage de connexion ou DHCP, le **connect automatically** devrait demander et obtenir une adresse IP.
Sinon on peut adresser manuellement le réseau **via Ipv4 > Change > Enter custom values**.

    IP address
    10.3.3.3

    Network mask
    255.255.255.0

    Gateway 
    10.3.3.1

    Apply

Sur son pc on peut maintenant définir son adresse IP et activer le routage vers internet si on le désire.

Exemple :

    sudo ifconfig enp0s20f0u2u4c2 10.3.3.1/24
    ping 10.3.3.3

Il se peut qu'il faille désactiver son Network Manager si on veut pas que son IP saute :

    sudo service network-manager stop

Pour le router vers internet, il faudra jouer avec iptables

Et pour enfin se connecter sur la bête :

    ssh robot@10.3.3.3
    robot@10.3.3.3's password: maker

Routage internet (sur son PC) :
ervic
Cette étape est nécessaire si l'on souhaite mettre à jour son système, télécharger des modules pythons directement depuis internet ...

    echo 1 > /proc/sys/net/ipv4/ip_forward
    sudo iptables -t nat -A POSTROUTING -s 10.3.3.0/24 -o enp3s0 -j MASQUERADE

Le Robot est en mesure d'accéder à l'extérieur :

    sudo ping 8.8.8.8

On peut modifier son DNS :

    sudo vim /etc/resolv.conf

<!-- vim -->

    nameserver 8.8.8.8

#### Installer Telnet

Pour économiser un peu de ressource, je trouve que la couche ssh n'est pas nécessaire si on programme son robot directement depuis son cable.

On peut donc sans risque installer ce service :

    sudo apt-get install telnetd xinetd
    sudo adduser robot telnetd

**sudo vim /etc/xinetd.d/telnet**

    service telnet
    {
      flags           = REUSE
      socket_type     = stream
      wait            = no
      user            = root
      server          = /usr/sbin/in.telnetd
      log_on_failure  += USERID
      disable         = no
      only_from       = 10.3.3.1
    }

    sudo /etc/init.d/xinetd restart

On peut maintenant se telnet sur son Lego :

    telnet 10.3.3.3
    robot/maker

### Se créer un repo

Pour faciliter la mise en oeuvre de ses script tout en gardant un système de versioning, il suffit d'utiliser git :

Sur le robot :

    mkdir /home/robot/mymindstorm
    git init
    git config receive.denyCurrentBranch ignore

Depuis notre ordi, on aura plus qu'à faire des git push :

    git push robot@10.3.3.3:mymindstorm

!!! Note
Cette méthode n'est pas des plus propre mais pour ce cas d'utilisation, cela permet de gagner un peu de temps.

Sur le robot, pour mettre à jour le repo :

    git checkout

Et si on a fait des modifs, il faudra stasher ses modifs :

    git stash
    git checkout


Manipulation
-----------------------------

### Système

Afficher les messages kernel liés aux périphériques.

    dmesg


Programmation
-----------------------------

### Initialisation de l'environnement

#### Installation du module (optionnel pour l'ev3dev)

Avec le système ev3dev, le module python est déja installé.
Si l'on souhaite le mettre à jour, l'installer sur un raspberry ...
Un module python est disponible à cet effet : [rhempel, ev3dev-lang-python](https://github.com/rhempel/ev3dev-lang-python).

    git clone https://github.com/rhempel/ev3dev-lang-python.git
    python ev3dev-lang-python/setup.py install

Exemple :

    python3
    import ev3dev.ev3 as ev3
    ev3.Sound.speak('Hello beebeeche!').wait()

#### Importer le module ev3dev :

    from ev3dev.ev3 import *
ou
    import ev3dev.ev3 as ev3
pour les raspberry :
    from ev3dev.brickpi import *

#### Rendre ses scripts executables

Il est possible d'executer ses scripts directement depuis la brique.
Pour se faire, il suffit de renseigner le shebang dans son script et de le rendre executable :

Exemple de shebang :

    #!/usr/bin/env python3
    ...

<!-- vim -->

    chmod +x monscript.py


### Compiler avec Docker

[docker cross compile](http://www.ev3dev.org/docs/tutorials/using-docker-to-cross-compile/)


Module python ev3dev
-----------------------------

### Import

    from ev3dev.ev3 import *

### L'aide

Pour avoir une aide sur tous le module :

    help()
    help> modules

Si on veut juste avoir des infos sur une classe :

    help(MaClass)

Exemple :

    help(Sound)

### Interraction

#### Sound

    Sound.speak('Hello, my name is E V 3!').wait()
    Sound.speak("What's up?").wait()
    Sound.beep().wait()

#### Led

    Leds.set_color(Leds.LEFT, Leds.RED)
    Leds.set_color(Leds.LEFT, Leds.GREEN)

#### LCD Screen

#### Brick Button

    btn = Button()

### Capteurs (sensors)

#### Boutton poussoir (Touch)

**Class :**

    ts = TouchSensor()

#### Infrarouge (Infrared)

**Class :**

    ir = InfraredSensor() 

#### Couleur

**Class :**

    cl = ColorSensor()

**Modes :**

* COL-COLOR (reconnaissance de la couleur)
* COL-AMBIENT (mesure de l'intensité de la lumière)
* COL-REFLECT (mesure du reflet de la lumière)
* RGB-RAW (mesure de l'intensité du rouge, vert et bleu)
    
### Moteurs (motors)


Troubleshooting
-----------------------------
