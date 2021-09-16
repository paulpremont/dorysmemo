P R O X M O X
==============================

What is it ?
-----------------------------

Proxmox est un hyperviseur de type 1 comparable à VMware ESX.
Il apporte une interface d'administration à KVM.

Links
-----------------------------

### Official

* [Site officiel](https://www.proxmox.com/en/)
* [Guide d'admin](https://pve.proxmox.com/pve-docs/pve-admin-guide.html)
* [Wiki](https://pve.proxmox.com/wiki/Main_Page)


How it works ?
-----------------------------

### Schéma de fonctionnement :

![schema_fonctionnement_proxmox](Pictures/proxmox_schema.jpg)

Proxmox offre (depuis la version 5.0 à l'heure où j'écris) la possibilité d'émuler deux type de socles :

* des VMs avec un combo KVM + QEMU.
* des conteneurs avec un combo KVM + LXC.

### Fonctionnalités clés 

* Se base sur une Debian
* Peut émuler des VM et des conteneurs
* Fonctionne en mode HA
* Peut gérer la partie réseau et firewalling depuis l'interface
* Gère plusieurs FS
* Gestion des droits et des utilisateurs assez fine
* Permet d'affiner les droits en fonction de pool (segmentation des ressources)

Installation
-----------------------------

Configuration
-----------------------------

### Définition des utilisateurs/groupes/pools

### Ajustement des droits

### Natter son réseau


Manipulations
-----------------------------

Troubleshooting
-----------------------------

### Erreur

#### Log

  log output

#### Description

#### Résolution

Sample :
-----------------------------
