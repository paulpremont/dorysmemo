# Comment étendre sa partition sous LVM

Dans le cas ou l'on a ajouté un nouveau disque ou encore étendu sa partition,
Il faudra respecter les opérations suivantes :

1. Ajout/Extension de la partition physique
2. Si LVM : ajout d'un PV, extension du VG et du LV
3. Extension du FS

## Liens

* [Tuto](https://www.rootusers.com/how-to-increase-the-size-of-a-linux-lvm-by-expanding-the-virtual-machine-disk/)
* [Doc ubuntu lvm](https://doc.ubuntu-fr.org/lvm)
* [Tuto reduc/extend lvm](http://www.tecmint.com/extend-and-reduce-lvms-in-linux/)

## Exemple avec VirtualBox et LVM

Après avoir executer les commandes d'extension du disque virtuel :

### Vérifiez que votre système soit installé sous lvm :

    pvdisplay
    vgdisplay
    lvdisplay
    df -h

### Création de la partition

Créer une nouvelle partition sur le disque ajouté/étendu.

    fdisk -l
    fdisk /dev/sdX

      #Création de la partition :
      n   #suivre les instructions par défaut
      p 
      #...

      #Tag de la partition :
      t
      <numero de la partition>
      8e  #LVM

      #Sauvegarder et quitter
      w

### Étendre le volume physique

    pvcreate /dev/sdXn  #à remplacer par le nom de la partition fraichement créée.
    pvdisplay
    pvscan

### Étendre le volum group

    vgextend <vg name> /dev/sdXn
    vgdisplay
    vgscan

### Étendre le volume logique

    lvextend <lv name> /dev/sdXn
    lvdisplay
    lvscan

### Étendre le fs

    df -hT

Selon votre FS, par exemple pour ext4 :

    resize2fs /dev/lv_partition/name

Pour xfs :

    xfs_growfs /mount/point

