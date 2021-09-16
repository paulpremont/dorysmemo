# Faire une autoinstall avec kickstart

Kickstart a pour but d'automatiser une installation en répondant automatiquement aux choix proposés lors d'une installation de l'OS.

Il est possible d'automatiser une installation en utilisant un support DVD (.iso), un disque local, ou encore par le réseaux avec un serveur DHCP, TFTP, DNS et HTTP.

Pour rendre opérationel kickstart il faut:

* Créer un fichier de configuration kickstart
* Créer un media de diffusion
* Créer l'arbre d'installation
* Puis démarrer l'installation

## Link:

[redhat](https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/ch-kickstart2.html)

## Kickstart File

Ce fichier comporte une liste de mot-clé nécéssaire pour la configuration du système.
On peu créer ce fichier à partir d'un modèle ou à partir de zero.

Sur une RedHat, on peut trouver le fichier contenant les nos choix dans /root/anaconda-ks.cfg

Pour que le fichier kickstart soit opérationnel, il faut respecter un ordre bien des différentes parties :

1. La partie commandes:
[options](https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/s1-kickstart2-options.html)

2. La partie packages:
[package_selection](https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/s1-kickstart2-packageselection.html)
3. La partie pre et post (optionnel)
[pre_install_config](https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/s1-kickstart2-preinstallconfig.html)
et
[post_install_config](https://access.redhat.com/knowledge/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/s1-kickstart2-postinstallconfig.html)


Pour une maj de systeme le fichier kickstart doit contenir les élements suivants:

* Language
* Installation method
* Device specification
* Keyboard setup
* upgrade keyword
* Boot loader configuration

## A partir d'une iso: (réalisée sur une iso d'ubuntu)

(N'oubliez pas d'ajouter les droits d'écritures sur les fichiers que vous éditer)

1. monter une image de votre distribution et copier son contenu pour pouvoir le manipuler

    mkdir /media/iso
    mount -o loop /path/to/image.iso /media/iso
    cp -R /media/iso /tmp

2. Edition du fichier de configuration isolinux pour activer l'auto-install:

	  vim /tmp/iso/isolinux/isolinux.cfg

		  prompt 0

      TODO

3. Création de l'iso

	  mkisofs -o $ISO_NAME -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -R -J -v -T $PWD
