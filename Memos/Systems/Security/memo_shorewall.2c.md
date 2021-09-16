S H O R E W A L L
==============================

What is it ?
-----------------------------

http://shorewall.net/Introduction.html

Shorewall est un outils de haut niveau qui permet d'écrire des règles de firewall proprement et efficacement.
Il est Idéal pour les réseaux avec beaucoup de règles et si l'on veut manipuler de simples fichiers textes comme configuration.
Pour un outil graphique, voir plutôt du côté d'ipcop.

Links
-----------------------------

### Official

http://shorewall.net/

### Tutos


How it works ?
-----------------------------

Shorewall s'appuie sur iptables pout configurer Netfilter.
Il permet d'écrire les règles de manières plus propres sous forme de fichiers de configuration.
Chaque règles étant définies par zone de réseau.

1. On définit donc en premier lieu des zones, comme par exemple :
(/etc/shorewall/zones)

* dmz
* wan
* lan

2. Puis on associe ces zones à des interfaces ou des hosts
(/etc/shorewall/interfaces et /etc/shorewall/hosts)

3. On définit les politiques et les règles de firewall que l'on va leur appliquer.
(/etc/shorewall/rules et /etc/shorewall/policy)

4. Shorewall compile et execute la configuration sous forme d'un script shell.
(/var/lib/shorewal)


Installation
-----------------------------

Configuration
-----------------------------

Manipulations
-----------------------------

/etc/shorewall/zones 

Troubleshooting
-----------------------------

### Erreur

#### Log

    log output

#### Description

#### Résolution

Sample
-----------------------------

### Title 3
#### Title 4

Normal text

* bullet points
* bp2

1 bp ordered
2 bp ordered

    console output
