FreeNas
==============================

What is it ?
-----------------------------

FreeNas est un système OpenSource basé sur FreeBsd avec tous les services pré-installé pour faire de votre serveur un NAS prêt à l'emploi.
Il s'appui sur le système de fichier ZFS pour protéger l'intégrité des données, faire des snapshots ...


Links
-----------------------------

### Official

### Tutos

How it works ?
-----------------------------

Installation
-----------------------------

```bash
dd if=FreeNAS-9.10-RELEASE-x64.iso of=/dev/sdX bs=64k
```

Configuration
-----------------------------

### Choix du RAID

FreeNAS utilise zfs, et les niveaux de raid équivalents sont décrits dans le lien suivant :
http://www.zfsbuild.com/2010/05/26/zfs-raid-levels/

Petit rappel sur les niveaux de raid 5 et 6 :
http://www.tomshardware.fr/articles/nas-raid-entreprise,2-898-4.html

RAIDZ = RAID5
RAIDZ2 = RAID6

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
