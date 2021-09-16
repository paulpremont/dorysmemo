# Backuper ses données:

1. Établir un plan de backup:

* quoi backuper et comment?
* pull ou push? (le plus sécuritaire)
* sources/destination?
* Système de stockage physique et logique?
* protocoles à utiliser?
* quantité de données?
* scheduler les backups (quand?)


## Les outils:

* rsync

## Les types de backup :

* Complèt

sauvegarde intégrale des données (au moins une fois necessaire).
Le plus gourmand en ressource.

* Différentiel

sauvegarde les données modifiées depuis la dernière sauvegarde complète.
Necessite moins de ressources mais il est necessaire de faire une sauvegarde complète régulièrement.

* Incrémental

sauvegarde les données modifiées depuis l'état précedent.
Très peu gourmand mais une restauration plus difficile.
N'ajoute que les fichiers modifiés.

## Les mécanismes de stockages :

* système de tapis roulant.

Pour ne pas saturer son espace disque

TODO
