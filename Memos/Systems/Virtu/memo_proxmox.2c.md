==========================================================
                       P R O X M O X
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Network:

        http://guides.ovh.com/Proxmox
        https://pve.proxmox.com/wiki/Network_Model

    CLI:

        http://pve.proxmox.com/wiki/Command_line_tools

    Tutos:
        http://www.nedproductions.biz/wiki/configuring-a-proxmox-ve-2.x-cluster-running-over-an-openvpn-intranet
        https://aresu.dsi.cnrs.fr/spip.php?article198
        http://www.sheldon.fr/2014/02/mise-en-place-dun-cluster-proxmox-3-1/
        http://nefertiti.crdp.ac-lyon.fr/wk/notes/proxmox
        http://www.guillaume-leduc.fr/mise-en-place-dun-san-iscsi-hautement-disponible-avec-drbd-et-keepalived.html
        http://blog.héry.com/article11/cluster-proxmox-distant-le-concept
        http://blog.gamb.fr/index.php?post/2013/12/23/Haute-dispo-de-prolo-%C3%A9pisode-2-%3A-Proxmox-2-noeuds-HA

    Wiki:
        http://pve.proxmox.com/wiki/Main_Page
        http://pve.proxmox.com/wiki/Proxmox_VE_2.0_Cluster
        http://pve.proxmox.com/wiki/Proxmox_VE_Cluster#Delete_and_recreate_a_cluster_configuration
        http://pve.proxmox.com/wiki/DRBD#Introduction

    Comparatif et tips
        http://www.tomshardware.fr/articles/virtualisation-serveur-hyperviseur-gratuit-logiciels,2-9-12.html

    vnctiger :
        https://bintray.com/tigervnc
        https://github.com/TigerVNC/tigervnc
        http://tigervnc.org/
        

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    C'est une interface à KVM et OPENVZ.
    Il gère donc les VM et les conteneurs.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Les types de stockage
        --------------------------

            Chaque type de stockage ont leur particularité peuvent accueillir que certain type de données.
                __________________________
                Réseau:

                    LVM Group (network backing with iSCSI targets)
                    iSCSI target
                    Direct iSCSI LUN
                    NFS
                    GLusterFS
                    RDB/Ceph

                __________________________
                Local:
                    
                    LVM Group (Local Backing devices, DRBD, FC devices ...)
                    Directory (Sur un FS existant)

                __________________________
                Contenu:

                    LVM : Raw VM images (à besoin d'une base iSCSI ou local).
                    NFS, GlustetrFS : n'importe quel type de données.

                    Les types de données:

                         Images : VMs (qcow2, vmdk, raw ...)
                         ISO : .iso
                         Templates : CT (openvz) templates (.tar.gz)
                         Backups : .vma.lzo, .vma.gz)
                         Container : CTs .

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Depuis l'image
        --------------------------

            Récupérer l'image:

                voir http://www.proxmox.com/fr/downloads/category/iso-images-pve
                ou
                wget http://www.proxmox.com/fr/downloads?task=callelement&format=raw&item_id=112&element=f85c494b-2b32-4109-b8c1-083cca2b7db6&method=download&args[0]=c177547b88aef458fed07a482547a95f

            Installation sur une clé usb bootable:

                > dd if=pve-cd.iso of=/dev/XYZ bs=1M

            On suit ensuite les instructions (très rapides)
            
        --------------------------
        Sur une Debian:
        --------------------------

            Voir: https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_Wheezy

                __________________________
                Vérifier que le processeur est compatible pour de la virtu:

                    > cat /proc/cpuinfo 

                        |grep -i vmx #(pour intel)
                        |grep -i svm #(pour amd)
                    
                __________________________
                Les paquets:

                    vim /etc/apt/sources.list.d/proxmox
                        deb http://download.proxmox.com/debian wheezy pve
                    
                    > apt-get update

                    en fonction des versions disponibles:

                    Install de Proxmox VE Kernel:

                        > apt-get install pve-firmware pve-kernel-2.6.32-26-pve
                        > apt-get install pve-headers-2.6.32-26-pve

                    Install de Proxmox VE Packages:

                        > uname -a #Check du noyau
                        
                    Suppression du kernel Debian:

                        > apt-get remove linux-image-amd64 linux-image-3.2.0-4-amd64 linux-base

                    Check de la conf grub2

                        > update-grub

                    Packages:

                        > apt-get install proxmox-ve-2.6.32 ntp ssh lvm2 postfix ksm-control-daemon vzprocps open-iscsi bootlogd

                __________________________
                LVM:

                    TODO
    
                __________________________
                Vérifications:

                    Vérifier que kvm soit bien chargé:

                        > dmesg |grep kvm

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Les repo:
        --------------------------

            https://pve.proxmox.com/wiki/Package_repositories

            #Testing:
            deb http://download.proxmox.com/debian wheezy pvetest

            #No subscription:
            deb http://download.proxmox.com/debian wheezy pve-no-subscription

            #Enterprise:
            deb https://enterprise.proxmox.com/debian wheezy pve-enterprise


        --------------------------
        Paths
        --------------------------

            Par défaut:

                racine des vm:

                    /var/liv/vz

                config:

                    /etc/pve
                    /etc/vz

        --------------------------
        Keyboard Layout VNC
        --------------------------

            Voir options au niveau du Datacenter.
            Et changer le Keybpard Layout

        --------------------------
        VNC
        --------------------------

            Avec le serveur VNC par défaut, des problèmes d'encodage peut subsiter et rendre son utilisation dérangeante !

            Pour palier à se problème, le mieux est d'utiliser son propre proxy VNC et un client VNC:

            Coté proxmox:

                > apt-get install openbsd-inetd

                > vim /etc/inetd.conf

                #port                                                 kvm
                59101 stream tcp nowait root /usr/sbin/qm qm vncproxy 101
                59102 stream tcp nowait root /usr/sbin/qm qm vncproxy 102
                59103 stream tcp nowait root /usr/sbin/qm qm vncproxy 103
                59104 stream tcp nowait root /usr/sbin/qm qm vncproxy 104

                > service openbsd-inetd restart

            Coté client:

                Avec VNC TIGER:

                Voir http://tigervnc.sourceforge.net/tiger.nightly/
                Pour avoir les dernières version.

               Version 32bit:
                    > wget http://sourceforge.net/projects/tigervnc/files/tigervnc/1.3.1/tigervnc-Linux-i686-1.3.1.tar.gz

               Version 64bit:
                    > wget http://sourceforge.net/projects/tigervnc/files/tigervnc/1.3.1/tigervnc-Linux-x86_64-1.3.1.tar.gz

                    dernierement :

                    > wget https://bintray.com/artifact/download/tigervnc/stable/tigervnc-Linux-x86_64-1.5.0.tar.gz

                Note: voir http://sourceforge.net/projects/tigervnc/files/tigervnc pour les versions en cours.

                On décompresse l'archive:

                    > tar xvzf tigervnc-Linux-x86_64-1.3.1.tar.gz -C /

                On lance la connexion:

                    > vncviewer PROXMOX:5910X

                    Accepter le certificat
                    user: root@pam
                    password : mot de passe root proxmox

        --------------------------
        Interfaces réseaux
        --------------------------
                __________________________
                NAT:

                    Pour créer notre NAT, on lui dédie une interface bridge:

                    Exemples avec vmr0 l'interface avec l'IP publique de l'hôte.

                    host:
                    ``````````````````````````
                        vim /etc/network/interfaces

                        auto vmbr2
                        iface vmbr2 inet static
                            address 10.0.0.254      #Ip qui fera office de gateway pour les VM
                            netmask 255.255.255.0
                            bridge_ports none
                            bridge_stp off
                            bridge_fd 0
                            post-up echo 1 > /proc/sys/net/ipv4/ip_forward
                            post-up iptables -t nat -A POSTROUTING -s '10.0.0.0/24' -o vmbr0 -j MASQUERADE
                            post-down iptables -t nat -D POSTROUTING -s '10.0.0.0/24' -o vmbr0 -j MASQUERADE

                        Si l'on veut ensuite lier des ports entre l'hôte et une VM:

                        post-up iptables -t nat -A PREROUTING -i vmbr0 -p tcp --dport PORT_HOTE -j DNAT --to IP_VM:PORT_VM
post-down iptables -t nat -D PREROUTING -i vmbr0 -p tcp --dport PORT_HOTE -j DNAT --to IP_VM:PORT_VM


                    vm:
                    ``````````````````````````

                        Il suffit de créer une ip dans le bon range:

                        auto eth0
                        iface eth0 inet static
                            address 10.0.0.1
                            netmask 255.255.255.0
                            broadcast 10.0.0.255
                            gateway 10.0.0.254

                        On rajoutera dans /etc/resolv.conf la même Ip que le serveur DNS de l'hôte par exemple.

                __________________________
                BRIDGE:

                    Pour le mode bridge il faut pouvoir lier une MAC virtuelle de notre VM à une IP du failover. Necessite d'avoir cette option.
                    Simplement une IP_Publique par VM (confortable mais honereux)

                    host:
                    ``````````````````````````

                        auto vmbr0
                        iface vmbr0 inet static
                            address IP_PUB
                            netmask 255.255.255.0
                            network ^IP_PUB.0
                            broadcast ^IP_PUB.255
                            gateway ^IP_PUB.254
                            bridge_ports eth0
                            bridge_stp off
                            bridge_fd 0

                    vm:
                    ``````````````````````````

                        auto eth0
                        iface eth0 inet static
                            address IP.FAIL.OVER
                            netmask 255.255.255.255
                            broadcast IP.FAIL.OVER
                            post-up route add GATEWAY_VM dev eth0
                            post-up route add default gw GATEWAY_VM
                            pre-down route del GATEWAY_VM dev eth0
                            pre-down route del default gw GATEWAY_VM

                        subtitle 4
                        ``````````````````````````
                __________________________
                ROUTED:

                    Pas forcement supporté par les providers. (Plusieurs adresses mac différentes sur une IP pub)
                    permet de router les paquets en provenances des vm sur l'interface "publique".
                    

                    host:
                    ``````````````````````````
                        auto vmbr1
                        iface vmbr1 inet manual
                            post-up /etc/pve/kvm-networking.sh
                            bridge_ports dummy0
                            bridge_stp off
                            bridge_fd 0

                        Avec comme script:

                        + ip route add IP.FAIL.OVER dev vmbr1

                    vm:
                    ``````````````````````````

                        auto lo eth0
                        iface lo inet loopback
                        iface eth0 inet static
                            address IP.FAIL.OVER
                            netmask 255.255.255.255
                            broadcast IP.FAIL.OVER
                            post-up route add IP.DE.VOTREDEDIE dev eth0
                            post-up route add default gw IP.DE.VOTREDEDIE
                            post-down route del IP.DE.VOTREDEDIE dev eth0
                            post-down route del default gw IP.DE.VOTREDEDIE

                __________________________
                VLAN:

        --------------------------
        Cluster
        --------------------------

            https://pve.proxmox.com/wiki/Proxmox_VE_2.0_Cluster

            Le cluster va pemettre de centraliser la gestion de nos noeuds.

            Note: pour éviter tout problème, le mieux est de partir sur des nouvelles installes de proxmox avant de former son cluster.

                __________________________
                Prérequis:

                    Tous les noeud doivent être sur le même réseau.
                    L'horloge doit être synchronisée.
                    Le ssh entre les noeud doit pouvoir fonctionner.
                    Aucune VM ne doit être présente
                
                __________________________
                Changement IP et hostname:

                    Il faut opérer directement sur le hostname
                    C'est à dire changer le nom de la machine
                        > vim /etc/hostname

                    et attribuer l'IP du noeud à proxmox
                        > vim /etc/hosts

                        et mettre son ip sur la ligne pvelocalhost:

                        exemple:
                            10.X.X.X    proxmox1 pvelocalhost

                    Un redémarrage de proxmox sera peut être necessaire

                    

                __________________________
                Création du cluster: (sur le serveur maître)

                    > pvecm create CLUSTER_NAME
                    > pvecm status

                    Note: la particularité du cluster est qu'il fonctionne sur un système de quorum, c'est à dire un système de vote paramétrable. (On peut donner plus de vois à un hôte).
                __________________________
                Voir troubleshooting:

                    -Config de l'unicast
                    -Expected vote à 1
                    ...

                __________________________
                Ajout d'un noeud (sur les autres serveurs)

                    > pvecm add HOSTNAME_SERVER1

                __________________________
                Vérifications:

                    > pvecm status 
                    > pvecm nodes
                     à faire sur les noeud pour vérifier qu'ils sont dans le même cluster et qu'ils ont la même version de config.

                    Sur la GUI:
                     Vérifier que tout les noeud sont bien présent dans la vue serveur et qu'il soit tous en vert.

                __________________________
                Troubleshooting:

                    Si il y a des erreurs de type loop proxy,
                        S'assurer qu'il n'y ait pas un doublon de nodes sur le même hôte.
                        Dans ce cas, au niveau de /etc/pve/nodes, 'déplacer' le neud en trop. 

                    Lors de l'ajout en cluster, si des problèmes de clé, supprimez vos entrées au niveau de ~/.ssh/known_hosts

                    Waiting quorum:

                        Il se peut que le multicast ne soit pas digéré par l'infrastructure actuelle:

                            Utiliser du unicast:

                                #Ajouter les noeuds dans /etc/hosts

                                #Edition de la conf du cluster
                                > cp /etc/pve/cluster.conf /etc/pve/cluster.conf.new
                                > vim /etc/pve/cluster.conf.new

                                    #remplacer les lignes correspondantes par:
                                    <cluster name="CLUSTERNAME" config_version="+1">

                                    <cman keyfile="/var/lib/pve-cluster/corosync.authkey" transport="udpu">
                                    </cman>

                                #Application de la config
                                > ccs_config_validate -v -f /etc/pve/cluster.conf.new

                                #On vérifie les changements dans l'onglet HA
                                #On active les changements dans le même onglet

                            Augmenter le pouvoir du master

                                Par défaut pour que le quorum fonctionne, il faut 3 votes. 
                                Lorsqu'il n'y a que 2 noeud, il faut augmenter le pouvoir de vote du master:

                                    sur les deux noeud:
                                        > pvecm expected 1

                                    Sur le noeud à ajouter:
                                        > pvecm add noeud1 -force

                    /etc/pve vide:

                        se palcer en dehor du dossier et remonter les fichiers:
                            > service pvecluster start

                    authentication key already exists:

                        Apparut après une erreur lors de l'ajout d'un noeud:

                            Soit relancer sa commande avec l'option -f

                            Ou tout simplement relancer tout les services pve (un reboot avec proxmox ce n'est pas trop mal)

                            Note: éviter de lancer la commande dans /etc/pve, car pvecm redémarre pvecluster et il voudra remonter ses fichier à cet endroit.
                    Quorum: 2 Activity blocked

                        Voir au niveau des logs : /var/log/cluster/corosync.log

                        Et tenter de redémarrer cman:
                            > service cman restart

                        En cours
        --------------------------
        HA
        --------------------------
            
            https://pve.proxmox.com/wiki/High_Availability_Cluster

                __________________________
                Prérequis:

                    -Fencing
                    -Cluster proxmox
                    -Espace partagé
                    -Redondance réseaux
                    -NFS pour les conteneurs
                
                __________________________
                Fencing:

                    Le fencing est un élement obligatoire pour faire de la HA:
                        https://pve.proxmox.com/wiki/Fencing

                    Le fencing va permettre d'éviter les erreurs liées aux accès simulatanés à une même ressource / VM.



        --------------------------
        KVM - Commandes
        --------------------------
            __________________________
            Config des vms:

                dans /etc/pve/qemu-server/
                (lien vers nodes/proxmox1/qemu-server)
            __________________________
            Forcer la suppresion de vm sur un storage qui n'est plus existant:

                > cd /etc/pve/qemu-server
                > mv *.conf /somewhere
            __________________________
            Changer les vms de storage:

                Editer la config de la vm dans /etc/pve/qemu-server/vmid.conf

                Changer la ligne suivante:
                    ide0: <NOM_STORAGE>:101/vm-101-disk-1.raw,format=raw,size=5G
                                
        --------------------------
        DRBD
        --------------------------

            http://pve.proxmox.com/wiki/DRBD

            Prérequis:
                Les noeud doivent idéalement être dans le même cluster.

            Réseau:
                
                Chaque noeud doit pouvoir se joindre sur le même réseau.

            Partionnement:
                
                Sur chaque noeud, il faudra créer une partition identique

                > fdisk ..

            Installation de DRBD:

                On install les paquets DRBD:

                > apt-get install drbd8

            Configuration du deamon DRBD:

                > vim /etc/drbd/global_common.conf

                    global { usage-count no; }
                    common {
                            syncer { rate 30M; verify-alg md5; }
                            handlers { out-of-sync "/usr/lib/drbd/notify-out-of-sync.sh root"; }
                    }

                On créer un fichier de ressources:

                    > vim /etc/drbd/RESSOURCE_NAME.res #(ex : r0.res)

                        resource RESSOURCE_NAME {
                            protocol C;
                            startup {
                                    wfc-timeout  0;     # non-zero wfc-timeout can be dangerous (http://forum.proxmox.com/threads/3465-Is-it-safe-to-use-wfc-timeout-in-DRBD-configuration)
                                    degr-wfc-timeout 60;
                                    become-primary-on both;
                            }
                            net {
                                    cram-hmac-alg sha1;
                                    shared-secret "my-secret";
                                    allow-two-primaries;
                                    after-sb-0pri discard-zero-changes;
                                    after-sb-1pri discard-secondary;
                                    after-sb-2pri disconnect;
                                    #data-integrity-alg crc32c;     # has to be enabled only for test and disabled for production use (check man drbd.conf, section "NOTES ON DATA INTEGRITY")
                            }
                            on proxmox-105 {
                                    device /dev/drbd0;      #Note: correspond au périphérique répliqué à utiliser. (au niveau de LVM)
                                    disk /dev/sdb1;
                                    address 10.0.7.105:7788;
                                    meta-disk internal;
                            }
                            on proxmox-106 {
                                    device /dev/drbd0;
                                    disk /dev/sdb1;
                                    address 10.0.7.106:7788;
                                    meta-disk internal;
                            }
                            disk {
                                # no-disk-barrier and no-disk-flushes should be applied only to systems with non-volatile (battery backed) controller caches.
                                # Follow links for more information:
                                # http://www.drbd.org/users-guide-8.3/s-throughput-tuning.html#s-tune-disable-barriers
                                # http://www.drbd.org/users-guide/s-throughput-tuning.html#s-tune-disable-barriers
                                no-disk-barrier;
                                no-disk-flushes;
                            }
                        }
            
            On démarre le deamon DRBD:

                (Sur les deux serveurs)

                /etc/init.d/drbd start  #démarrage du deamon
                drbdadm create-md RESSOURCE    #Création des metadata du périphérique
                drbdadm up RESSOURCE           #Lancement du périphérique
                ou (voir si ça remplace:)
                drbdadm attach RESSOURCE
                drbdadm connect RESSOURCE

                cat /proc/drbd          #Afficher l'état de DRBD (Doit être en secondary/secondary)


                (Sur le noeud primaire)

                drbdadm -- --overwrite-data-of-peer primary RESSOURCE
                watch cat /proc/drbd

                #Si DRBD n'est pas repassé en primary/primary alors redémarre les deamon.

            Ajout de la couche LVM:

            Tests:

        --------------------------
        Storage
        --------------------------

            Il est possible de modifier les options de montage des différentes sources de données dans:

                > vim /etc/pve/storage.cfg

                #Exemple pour du nfs, changer les options:

                    nfs: backups
                            path /mnt/pve/backups
                            server nas
                            export /volume1/proxmox1/backups
                            options vers=3,rsize=4096,wsize=4096,hard,intr,async
                            content images,iso,vztmpl,rootdir,backup
                            nodes px1
                            maxfiles 3

                On checkera ensuite:

                > mount

        --------------------------
        Utilisateurs
        --------------------------

            https://pve.proxmox.com/wiki/User_Management

            Pour créer de nouveaux utilisateurs (au niveau du Datacenter)

                1 - Vérifier les rôles disponibles
                2 - Créer un groupe (optionnel mais plus pratique pour l'attribution des droits)
                3 - Créer un utilisateur (PVE ou PAM)
                4 - Ajouter les permissions:
                    Il faudra selectionner un groupe ou un utilisateur 
                    Et appliquer la permission à un objet en renseignant un path:

                        /vms  : pour l'attribuer sur toutes les vms
                        /vms/vmid : pour l'attribuer sur une vm spécifique
                        /storage/storeid : pour l'attribuer sur un espace particulier
                        /pool/poolname : pour l'attribuer sur un pool de ressource particulier

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Connexions
        --------------------------

            Ports:

                WUI : 8006
                VNC : 5900-5999
                SPICE : 3128
                CMAN : 5404,5405 (udp)

        --------------------------
        Backups
        --------------------------

            CLI:
                man vzdump 
                /etc/vzdump.conf

                __________________________
                Pour créer un backup programmé:

                    -Rajouter un espace de stockage dédié au backup (optionnel)
                    -Se placer sur le datacenter
                    -Aller sur l'onglet Backup
                        -> configurer le jour et l'heure du Backup et selectionner un type:

                        stop (KVM): Eteind la VM pour avoir un état consistent (court downtime).
                        stop (OpenVZ): Eteind la VM/CT (very long downtime)
                        suspend (KVM): idem que snapshot.
                        suspend (OpenVZ): Utilise rsync, (temps minim d'interuption sans utiliser LVM)
                        snapshot (KVM): Backup en live (no downtime, online)
                        snapshot (OpenVZ): Utilise les snapshot lvm2 (no downtime, online) 

                    Exemples en ligne de commande (issu de la crontab):

                        > vzdump 100 101 102 103 104 105 106 120 107 108 109 110 --quiet 1 --mode stop --mailto admin@advim.fr --node px1 --compress gzip --storage backups
                        > vzdump 100 101 102 103 104 105 106 120 121 107 108 109 110 --quiet 1 --mode snapshot --mailto admin@advim.fr --node px1 --compress gzip --storage snapshots

                __________________________
                Pour backuper instantanément:

                    Utiliser l'onglet backup dispo sur chaque VM/Conteneur

                    En ligne de commande:

                        > vzdump 109 --remove 0 --mode snapshot --compress lzo --storage backup-new --node proxmox-7-106

                __________________________
                Restaurer:

                    CLI:
                        man qmrestore
                        man vzrestore

                    Pour restaurer ses données il faut se rendre sur l'espace de backup
                        -> onglet Content
                            -> Restore

                    En ligne de commande:
                        lzop -d -c /var/lib/vz/backup-new/dump/vzdump-qemu-109-2013_01_29-08_49_28.vma.lzo|vma extract -v -r /var/tmp/vzdumptmp324484.fifo - /var/tmp/vzdumptmp324484

                    Note en cas de problème lors de la restauration (failed exit code 1), lancer manuellement la vm pour voir la sortie d'erreur:

                    exemple:

                        > qm start 103

                        Note: vérifier que kvm est bien supporté par le système.
                    

        --------------------------
        Aspiration P2V
        --------------------------

            Voir clonezilla

        --------------------------
        Redimmensionner l'espace disque
        --------------------------

            http://pve.proxmox.com/wiki/Resizing_disks
                __________________________
                Resize du disk virtuel:

                    Via l'interface, au niveau de la VM:
                         
                         [Resize disk]

                    Via la CLI:
                        
                        > qm resize <vmid> <disk> +<size>G

                __________________________
                Resize de la partition:

                    Insérer simplement un disk de type gparted.

                        > wget ... -> /var/lib/vz/template/iso

                    ou voir avec cfdisk

                __________________________
                Resize ddu file system:

                    > resize2fs /dev/sdaX

                    LVM:
                        todo

                    Réactiver le swap si il a été supprimé:

                        > mkswap /dev/sdxy

                        > vim /etc/fstab

                            #Remplacer le UUID fourni par la commande précedente.

                        > swapon -a

        --------------------------
        Unlock une VM
        --------------------------

            > qm unlock VM_ID

            suite à une erreur de type:

                <root@pam> update VM 109: -lock backup

        --------------------------
        Update
        --------------------------

            1) Backuper toutes les VM
            2) Eteindre les VM
            3) Ajout des repos:

                > vim /etc/apt/sources.list.d/pve-enterprise.list 

                    #Version payante officielle:
                    #deb https://enterprise.proxmox.com/debian wheezy pve-enterprise

                    #Version non payante (unstable):
                    deb http://download.proxmox.com/debian wheezy pve-no-subscription

            4) Update de l'OS:

                > apt-get update
                > apt-get dist-upgrade
                > reboot

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

    qemu : permission denied failed to start :
        
        Si ce message apparaît lors du démarrage d'une VM, un problème de droit subsiste et peut être fixé simplement en redémarrant le serveur proxmox.

        Sinon voir comment augmenter les droits sur le folder image.(chmod ou conf de l'accès en root).

    kvm: Could not access KVM kernel module: No such file or directory

        Vérifier que le module kvm est bien chargé:

        > dmesg |grep kvm
        > modprobe -a kvm kvm-intel

        Voir au niveau du bios et vérifier que la virtu est bien activée.

### no subscription

* [Premier tuto](https://www.jamescoyle.net/how-to/614-remove-the-proxmox-no-subscription-message)
* [Deuxième tuto](https://www.sysorchestra.com/2016/05/13/remove-proxmox-4-2-no-valid-subscription-message/)

    cp /usr/share/pve-manager/js/pvemanagerlib.js /usr/share/pve-manager/js/pvemanagerlib.js.bkp

Editer le fichier et commentez les lignes ci-dessous (à partir de la ligne 815 dans mon cas) :

    //              if (data.status !== 'Active') {
    //                  Ext.Msg.show({
    //                      title: gettext('No valid subscription'),
    //                      icon: Ext.Msg.WARNING,
    //                      msg: PVE.Utils.noSubKeyHtml,
    //                      buttons: Ext.Msg.OK,
    //                      callback: function(btn) {
    //                          if (btn !== 'ok') {
    //                              return;
    //                          }
    //                          orig_cmd();
    //                      }
