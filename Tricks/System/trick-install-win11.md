# Installation de Windows 11 depuis linux

## Sources :

- https://www.it-connect.fr/comment-installer-windows-11-sans-connexion-a-internet/
- https://doc.ubuntu-fr.org/tutoriel/installer_windows_boot_usb
- https://www.ventoy.net/

## Télécharger l'image Windows 11

"Télécharger l’image disque Windows 11 (ISO) pour les appareils x64" :

Cliquez sur télécharger et sélectionner votre langue d'installation puis "Confirmer".

Le fichier "Win11_24H2_French_x64.iso" se télécharge.

## Boot usb avec ventoy

Télécharger l'image depuis ventoy : https://www.ventoy.net/en/download.html

Insérez la clé USB qui servira de média de boot (>= 8Go)

```
# repérez la partition (exemple : /dev/sda)
fdisk -l
```

Décompressez et executez le logiciel :

```
tar -xvf ventoy-1.1.05-linux.tar.gz
cd ventoy-1.1.05
./VentoyGUI.x86_64
```

En mode graphique :

1. sélectionnez le média de boot (clé usb)
2. cliquez sur installation

Enfin copiez le (ou les) fichiers iso sur lesquels vous voulez booter 


```
cp Downloads/Win11_24H2_French_x64.iso /media/XX/Ventoy/

# démontez ensuite le disque (ou le faire en mode graphique)
sudo umount /media/XX/Ventoy
```

Il ne reste plus qu'à insérer le média dans votre PC à installer.
(Au démarrage : F12 ou F2 ou Del selon le modèle de votre PC et sélectionnez Ventoy comme séquence de boot).

## Installation Windows 11 en mode offline

Par défaut, windows11 peut vous forcer à créer un compte Microsoft.

Une fois arrivé sur l'étape de connexion internet, veillez à ne pas vous connecter à internet.
Suivez cette étape :

```
# ouvrir la console
MAJ + F10

# redémarrer en mode offline
OOBE\BYPASSNRO
```

Quand l'étape d'installation va revenir sur la connectivité à internet, 
il vous suffira de cliquer sur "Je n'ai pas internet".
