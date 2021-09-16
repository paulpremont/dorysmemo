PowerDNS
==============================

What is it ?
-----------------------------

Un système de DNS performant qui peut être découpé en Authoritative/Recursor pour pouvoir gérer de grandes quantités d'entrées DNS.
L'avantage de PowerDNS est sa légereté et son mécanisme simple ainsi que sa sécurité.
Il semble plus abouti que peut l'etre bind.

Links
-----------------------------

### Official

[powerdns website](https://www.powerdns.com/)
[powerdns repo](https://repo.powerdns.com/)
[powerdns documentation](https://doc.powerdns.com/md/)

### Tutos


How it works ?
-----------------------------

PowerDNS est divisé en deux systèmes :

* Authoritative : ne répond qu'aux requêtes de son domaine
* Recursor : il n'est rattaché à aucun domaine et s'occupe de chercher les entrées manquantes.

Les deux peuvent être combinés sur le même serveur.

Il est compatible avec bon nombre de Backend pour stocker ses entrées.

* Bind
* Mysql
* ...

Il dispose d'un système de logging avancé avec plusieurs niveau de priorité dans un format syslog.

### Sécurité

[DNSSEC](https://doc.powerdns.com/md/authoritative/dnssec/)

Niveau Sécurité, powerdns support DNSSEC (en fonction du backend choisi).
Ce qui permet en plus de protéger le canal d'échange, les entrées elles même grâce a des hash (signatures) généré par RSA ou DSA...
Les clés sont récupérables sur des serveurs spécifié par le DS record (envoyé par la zone parente).


Installation
-----------------------------

### Authoritative Server

  yum install epel-release yum-plugin-priorities
  curl -o /etc/yum.repos.d/powerdns-auth-40.repo https://repo.powerdns.com/repo-files/centos-auth-40.repo
  yum install pdns
  yum install pdns-backend-mysql

Configuration
-----------------------------

Manipulations
-----------------------------

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
