=========================================
	V i r t u a l 	B O X
=========================================

todo (voir tuto)
--------------------------
Install / Update
--------------------------

    Voir : https://www.virtualbox.org/wiki/Linux_Downloads
        _______________________
        Debian :

            #Ajouter les sources (à adapter en fonction de sa distrib) :

                > sudo vim /etc/apt/sources.list.d/virtualbox.list

                    deb http://download.virtualbox.org/virtualbox/debian vivid contrib

            #Ajouter la clé du repo :

                > wget https://www.virtualbox.org/download/oracle_vbox.asc
                > sudo apt-key add oracle_vbox.asc

                ou

                > wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

                #Pour vérifier la clé, il faut se rendre sur le site et voir le fingerprint.

            #Installer les packages :

                > sudo apt-get update
                > sudo apt-get install virtualbox-5.0

--------------------------
Gestion des VM
--------------------------

    https://www.virtualbox.org/manual/ch08.html
        _______________________
        Afficher les vms :

            > VBoxManage list vms

        _______________________
        Afficher la conf d'un VM :

            > VBoxManage showvminfo <MyVM>

        _______________________
        Clone du disque d'une vm:

            > VBoxManage clonehd /path_to_old_vm.vmdk /path_to_new_vm.vdi --existing
            > VBoxManage clonehd /path_to_old_vm.vmdk /path_to_new_vm.vdi --format VDI --variant Standard

        _______________________
        Resize une vm:

            (fonctionne uniquement sur le format vdi apparament):

            Il faut donc d'abord cloner sa VM avec le bon format.

            > VBoxManage modifyhd vm.vdi --resize XXXXX 	# (en MB)

            exemple:

                > VBoxManage modifyhd /home/myuser/VirtualBox\ VMs/vmtest/vmtest.vdi --resize 25000

            => il faudra ensuite resize la partition puis le FS.

            Exemple :

                (Refaire en full CLI)

                > VBoxManage clonehd /path_to_old_vm.vmdk /path_to_new_vm.vdi --format VDI --variant Standard
                > VBoxManage modifyhd vm.vdi --resize 10000

                Supprimer le montage des anciens vmdk pour les nouveaux vdi (via la GUI).
                Et voir les infos du disque au niveau de l'interface.
                Lancer un outil de partitionnement pour etendre la ou les partitions.

                Puis sur la VM :


        _______________________
        Démarrer une vm :

            > VBoxManage startvm VMNAME|ID

            Pour la lancer en mode headless (c'est à dire sans UI et détaché de la console) :

                > VBoxManage startvm $VM --type headless

        _______________________
        Démarrage automatique d'une VM :

            #Création des fichiers de conf :

                > vim /etc/default/virtualbox

                    VBOXAUTOSTART_DB=/etc/vbox
                    VBOXAUTOSTART_CONFIG=/etc/vbox/autostart.cfg

                > vim /etc/vbox/autostart.cfg

                    # Default policy is to deny starting a VM, the other option is "allow".
                    default_policy = allow
                    # Create an entry for each user allowed to run autostart
                    #myusername = {
                    #allow = true
                    #}

            #Permettre aux utilisateurs d'activier l'autostart pour une VM :

                chgrp vboxusers /etc/vbox
                chmod 1775 /etc/vbox
                usermod -a -G vboxusers USERNAME

            #Activation de l'autostart

                > VBoxManage setproperty autostartdbpath /etc/vbox

                (La VM doit être éteinte)
                > VBoxManage modifyvm <uuid|vmname> --autostart-enabled on

            #Démarrage du service :

                > sudo service vboxautostart-service start


--------------------------
Une interface web
--------------------------

    Voir http://sourceforge.net/projects/phpvirtualbox/

--------------------------
Install des guest additions
--------------------------

        Lien:
                http://www.virtualbox.org/manual/ch04.html
                http://download.virtualbox.org/virtualbox/

        Sur une Debian

        > apt-get install gcc make
        > apt-get install build-essential
        > mount -o loop /usr/share/virtualbox/VBoxGuestAdditions.iso /media/cdrom0
        > ./media/cdrom/VBoxLinuxAdditions-???.run

        ou à la place du mount:
        > apt-get install linux-headers-$(uname -r)

--------------------------
Activer l'usb, partager une clé
--------------------------

    Pour activer, partager une clé usb, il faut :

        - télécharger le pack d'extension :

            https://www.virtualbox.org/wiki/Downloads

        - ajouter notre user courant au groupe virtualbox :

            > sudo usermod -aG vboxusers <username>

        - redémarrer sa session

        - lancer virtualbox et ajouter un périphérique usb :

            > Settings > USB > cocher 'Enable USB 2.0' > Add a new USB filter (la liste des périphériques usb devrait se générer automatiquement)

--------------------------
Transformer une clé usb bootble en vmdk
--------------------------

    http://www.metashock.de/2012/11/booting-your-usb-stick-using-virtual-box-on-a-linux-host/

    Par défaut, il n'est pas possible de booter directement depuis une clé usb sur une VM.

    En revanche on peut convertir un media bootable en vmdk.

    Si on veux le faire depuis son user :

        Il faut d'abord ajouter son user dans les groupes suivants :

            > useradd monUser vboxusers disk

            #relancer sa session :

                > reload
                > groups 

    Ensuite, voir sur quelle partition est montéer la clé usb :
        
        > mount

    Par exemple si la clé usb est dispo sur /dev/sdb avec deux partitions :

        #Démonter toutes les partitions de la clé :

            > umount /dev/sdb1
            > umount /dev/sdb2

        #Puis créer son vmdk (avec sudo si l'on n'a pas ajouté son user au groupe vboxusers)

            > sudo VBoxManage internalcommands createrawvmdk -filename usb.vmdk -rawdisk /dev/sdb
            > chmod 666 usb.vmdk

    Il suffira ensuite d'ajouter un disk vmdk au niveau des settings de la VM, controller SATA.

--------------------------
Monter un dossier partagé
--------------------------

        > mount.vboxsf nom_du_partage /mnt/Dossier_créer

--------------------------
Pour les cds:
--------------------------

        > mount /dev/cdromX /media/cdrom0

--------------------------
Activer l'accélération graphique
--------------------------

        Utilisé par exemple par Aero sous windows:

        Cocher Direct3D lors de l'install des guest additions
        Si une fenêtre demande si l'on veut remplacer Direct3D experimental par basic, cliquer sur 'No'.

        Finir l'install et éteindre la VM
        Enfin configurer la VM, dans Display, rajouter au 128 MB de mémoire vidéo.
        et cocher les deux options 3D/2D Acceleration 

        Enjoy !

--------------------------
Network
--------------------------

    https://www.virtualbox.org/manual/ch06.html

    - Bridge: avoir une interface directement relié au réseau hôte.

    - Internal: réseau accessible uniquement entre VM

    - Host-only : Pour pouvoir communiquer avec son hôte et les VMs sans pour autant avoir accès à l'extérieur.
        
        Necessite de créer une interface virtualbox (File/Préference/Network de virtualbox)

    - NAT : classique, accès vers l'extérieur avec l'adresse de l'hôte et aux VMs.

    - NAT Network : mix entre NAT et internal. Accès vers l'extérieur plus cloisement dans un réseau virtualbox.

    Ne pas hésiter à cumuler plusieur NIC pour en fonction du besoin.

--------------------------
PXE
--------------------------

    Il suffit de configurer son interface réseau pour la mettre dans le bon réseau.

    Puis Toujours dans les settings de la VM dans System, mettre network en premier dans la section "boot order".

--------------------------
Un peu de config
--------------------------

    Exemple, mettre les interfaces en mode bridge :

        VBoxManage modifyvm centos7 --nic1 bridged --bridgeadapter1 'eth0'

--------------------------
Issues/Erreurs Connues
--------------------------

        _______________________
        Plus d'interface réseaux:
                > rm /etc/udev/rules.d/70-persistent-net.rules

        _______________________
        Problème d'UUID déja éxistant:

                Deux possibilités: cloner un disque en ligne de commande:

                        > VBoxManage clonehd src_disk_path dest_disk_path         #vdi ou vhd

                Ou changer l'UID du disque:
                        
                        > VBoxManage internalcommands sethduuid DISK PATH

        _______________________
        Plus de vboxdrv dans /etc/init.d:

            Désinstaller virtualbox : 

                > apt-get autoremove virtualbox

            Réinstaller certain packages:

                > apt-get install linux-headers-`uname -r`
                > dpkg-reconfigure virtualbox-dkms 
                > modprobe vboxdrv

            Télécharger le .deb du site officiel:

                > https://www.virtualbox.org/wiki/Downloads

            Installez le.
        _______________________
        Cannot register the DVD image :

            Supprimer l'image via le manager :

                File > Virtual Media Manager > Optical Disk > select the disk > release > remove
        _______________________
        NS_ERROR_FACTORY_NOT_REGISTERED 

            https://www.virtualbox.org/ticket/3568

            Vérifier les droits au niveau de /tmp :

                > chown -R root: /tmp
                > chmod 1777 /tmp
