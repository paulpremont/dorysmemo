==========================================================
                       K V M
==========================================================


~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Site off:
        http://www.linux-kvm.org/page/Main_Page

    tutos:
        http://www.guillaume-leduc.fr/mise-en-place-dun-petit-serveur-de-virtualisation-avec-kvm-libvirt-et-virt-manager.html
        http://doc.ubuntu-fr.org/kvm

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    KVM pour Kernel Virtual Machine est intégré depuis le noyau 2.6.20.
    C'est un hyperviseur orienté vers les systèmes serveurs, il vaut mieux utiliser VirtualBox pour émuler des desktop.

    On peu l'utiliser avec virt-manager pour avoir une petite aide graphiqe.
    Cependant proxmox s'appuyant sur kvm est encore plus élaboré de ce coté.

    KVM est un fork du projet QEMU.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    KVM est un module noyau qui permet à un programme d'utiliser une couche de virtualisation des ressources type processeurs ...



~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Vérifications
        --------------------------

            > egrep '^flags.*(vmx|svm)' /proc/cpuinfo

        --------------------------
        kvm
        --------------------------

            > apt-get install qemu-kvm
            > kvm-ok    #Pour s'assurer que l'acceleration peut être utilisée.

            D'autres outils intéressants:

            Programme pour créer et cloner les machines virtuelles:

            > apt-get install libvirt-bin virtinst

        --------------------------
        virt-manager
        --------------------------

            Si l'on veux une petite interface graphique:

            > apt-get install virt-manager

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Donner les droits
        --------------------------

            Ajouter votre utilisateur au groupe kvm:

            > adduser $USER kvm
            ou 
            > usermod -a -G kvm user

            Pour le tools virt:
            
                > usermod -a -G libvirtd user

            Tester:
                > virsh -c qemu:///system list


~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Création d'une VM
        --------------------------

                __________________________
                Initialisation de l'espace disque virtuel:

                    qemu-img create -f VM_FORMAT IMAGE.img SIZE

                    exemple:

                        > qemu-img create -f qcow2 /tmp/image.img 6G

                __________________________
                Installer un système:

                    kvm -m MEMORY -cdrom MOUNTED_ISO -boot d IMAGE.img

                    exemple:

                        > kvm -m 256 -cdrom /dev/cdrom -boot d image.img
                        ou
                        > kvm -m 256 -cdrom image.iso -boot d image.img

                CTRL +ALT pour quitter

        --------------------------
        Démarrer une VM
        --------------------------

            > kvm -m 256 image.img
            
            Avec le son et le port usb:

            > kvm -m 386 -std-vga -cdrom /dev/cdrom image.img -soundhw all -usb

        --------------------------
        Restauration
        --------------------------
                __________________________
                clonezilla:

                    kvm -m 512 -cdrom clonezilla.iso -boot d image.img -hdb /dev/sdx

        --------------------------
        Network
        --------------------------

            http://www.linux-kvm.org/page/Networking
                __________________________
                Private bridge:
                __________________________
                Public bridge:
                __________________________
                VLANs

        --------------------------
        virt-manager
        --------------------------

        --------------------------
        Conversions
        --------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~
subtitle 1
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        subtitle 2
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
