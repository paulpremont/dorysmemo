# Backup Synology

## Configuation synology

### Création du volume

Choix du RAID en fonction du besoin : 

https://www.synology.com/fr-fr/support/RAID_calculator

### Shared Folder

Organisation par user par exemple ou usage.

Note : l'option "Hide sub-folder from users without permissions" 
permet d'améliorer la sécurité.

### Services

SMB, rsync, SSH (via Terminal & SNMP), DLNA (via Media Server)

### Apps

* HyperBackup
* exFAT
* Media Server

### Hardware & Power

Ajouter un onduleur et le brancher over USB (par exemple)

Activer le support UPS

### Backup

Via HyperBackup sur un disquedur externe.

Scheduling chaque fin de semaine par exemple.

Possibilité d'éjecter automatique le device pour faire des rotations.

## Backup sous Linux :

1. Activer le service rsync : File Services > rsync
2. Créer une destination :
  * soit ajouter les droits R/W sur le dossier NetBackup
  * ou créer son propre dossier

Note : avec un utilisateur non admin,
il ne sera pas possible d'utiliser ssh directement.

Exemple de commande :

```bash
sudo rsync -av -e 'ssh -p22' /home/ user@syno::user/backup/pc
```

Source : https://kb.synology.com/fr-fr/DSM/tutorial/How_to_back_up_Linux_computer_to_Synology_NAS

## Backup sous Android :

Note : Il est préférable de créer un utilisateur dédié avec droits d'écriture uniquement sur le dossier de backup.

Installation de DS File via le PlayStore :

Source : https://recoverit.wondershare.com/data-backup/synology-android-backup.html

Dans les options configurer la partie backup photos.
