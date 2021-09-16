==========================================================
                       D R B D
==========================================================

Distributed Replicated Block Device

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    doc:
        http://www.drbd.org/users-guide/
        http://www.drbd.org/users-guide-9.0/

    wiki:
        https://wiki.debian.org/DrBd
        http://www.dalibo.org/hs45_drbd_la_replication_des_blocs_disques

    tutos:
        http://denisrosenkranz.com/tuto-ha-drbd-sur-debian-6/

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    C'est un système de stockage distribué sur plusieurs noeuds fonctionnant sur un réseau TCP/IP.
    Il s'accapare à du raid 1 et est utilisé surtout pour former des cluster en HA.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    DRBD réplique les block de données (disque dur, partitons, volumes logiques ...) avec les autres noeud du cluster DRBD.

    La réplication se fait:
        
        -En temps réel : réplication constante lorsqu'il y a changement de données.
        -Transparence : Pas de config niveau applicatif
        -Synchrone ou Asynchrone: Notification des applications après l'écriture sur tout les noeud du cluster ou après l'écriture en local.

    DRBD constitue en fait un driver se situant au plus près des I/O du périphérique. (Situé entre le FS et le Sheduler d'I/O)

    Pour schématiser, on applique d'abord drbd avec d'appliquer un FS.

    On peut l'avoir directement sur une partition (non formartée):

        [DISK][PARTITION][DRBD][FS]

    Ou encore sur un LVM:

        [DISK][PARTITION LVM][PV][VG][LV][DRBD][FS]

    Ou encore comme un PV sur du LVM:

        [DISK][PARTITION LVM][PV][VG][LV][DRBD][PV][VG][LV][FS]
        
        --------------------------
        Les tools
        --------------------------

            drbdadm:

                Permet de gérer DRBD et acceder à la conf /etc/drbd.conf.
                C'est le front-end de drbdsetup et drbdmeta

            drbdsetup: 

                Permet de configurer le module DRBD chargé dans le noyau.

            drbdmeta: 

                Permet de générer, restauré ... les structures de méta données de DRBD.

        --------------------------
        Ressources
        --------------------------

            Concerne tous les aspects particuliés à une réplication de données:
            Elles ont chacune un rôle (Primaire ou Secondaire)

            Volumes:
                Contient les données et meta données DRBD. Il concerne tout ou partie d'une ressource.
                
            Périphérique DRBD:
                Block virtuel géré par DRBD

                rôle primaire: rw operations
                rôle secondaire: Reçoit toutes les données d'un noeud.

            Connextion:
                Liaison entre deux noeuds.
                
        --------------------------
        Les modes
        --------------------------

            Single-primary:
                Un seul membre du cluster gère les ressources en mode primaire.
                (idéal pour la HA)

            Dual-primary:
                Les deux noeuds gère les ressources en mode primaire.
                Necessite l'utilisation d'un FS de cluster partagé (OCFS2, GFS ...)
                (idéal pour le load balancing)

        --------------------------
        Les types de réplication
        --------------------------

            Concerne les opération d'écriture locale et influ sur la protection et la latence.

            A: Asynchronous:
                Considérées comme finient dès que le disque local à terminé d'écrire et que le paquet est entré dans le buffer de transmission.
                (idéal pour les longues distantes)

            B: Semi-synchronous:
                Terminées lorsque les données sont écrites en local et que les paquets ont atteints les membres du cluster.

            C: Synchronous:
                Terminées lorsque les données sont écrites en local et sur les noeuds distants.
                (mode le plus utilisé)

        --------------------------
        Partition et LVM
        --------------------------

            DRBD peut être installé au niveau d'une partition physique ou bien même logique.
            C'est à dire qu'on peut installer DRBD directement sur un LV.

                (représenté par la variable disk au niveau de la conf)

            Dans tout les cas DRBD créera une partition (via la variable device) que l'on poura utiliser.
                
~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    > apt-get install drbd8-utils

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
    Voir /etc/drbd.d

        --------------------------
        Partitionnement
        --------------------------

            Chaque noeud du cluster doivent répliquer leur données sur des partitions similaires.
            
            Exemples:
                __________________________
                Sur une partition vierge:

                    > fdisk
                __________________________
                Sur une LV: (LVM)

                    > pvcreate
                    > vgcreate
                    > lvcreate


        --------------------------
        Ressources
        --------------------------

            resource proxmoxcluster{
                    protocol A;                  # A is asynchronous (mostly one-way data flow)
                    meta-disk internal;
                    startup {
                            wfc-timeout 15;
                            degr-wfc-timeout 15;
                            outdated-wfc-timeout 15;
                            become-primary-on proxmox1;
                    }
                    net {
                            cram-hmac-alg sha1;
                            shared-secret "unsecretbiengarde";
                            after-sb-0pri discard-zero-changes;
                            after-sb-1pri discard-secondary;
                            after-sb-2pri disconnect;
                            ping-timeout 50;
                    }
                    syncer {
                            use-rle;
                            csums-alg sha1;
                    }
                    on proxmox2 {
                            address 10.X.X.2:7788;
                            device /dev/drbd0;
                            disk /dev/das/vm;
                    }
                    on proxmox1 {
                            address 10.X.X.1:7788;
                            device /dev/drbd0;
                            disk /dev/das/vm;
                    }
            }

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        initialisation
        --------------------------

            #à faire sur les noeuds du cluster.

            > drbdadm create-md RESSOURCE_NAME
            
            Forcer l'utilisation d'un noeud en tant que primaire:

                > drbdsetup /dev/drbdX primary -o

            Démarrage du service:
                
                > modprobe drbd
                > service drbd start

            Rendre up les disk:

                > drbdadm up RESSOURCE
                #correspond à attach + connect

            Démarrage de la synchro (à faire sur le noeud primaire):

                > drbdadm -- --overwrite-data-of-peer primary RESSOURCE

            Voir le progrès en temps réel:

                > watch cat /proc/drbd

        --------------------------
        Utilisation des partition drbd
        --------------------------

            Montage des volumes (si pas déja fait)
                > drbdadm up RESSOURCE_NAME

            Avec LVM:

            > pvcreate /dev/drbdX
            > vgcreate bidul /dev/drbdX
            > lvcreate ..

            Et on formate comme si on avait à faire à une partition normale:

            > mkfs.ext4 /dev/bidul/...
        

~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Need access to UpToDate data
        --------------------------
            0: State change failed: (-2) Need access to UpToDate data
            Command 'drbdsetup 0 primary' terminated with exit code 17

            Check:
                cat /proc/drbd

                --> 
                    ...
                     0: cs:WFConnection ro:Secondary/Unknown ds:Inconsistent/Outdated A r----s
                     ns:0 nr:0 dw:0 dr:0 al:0 bm:0 lo:0 pe:0 ua:0 ap:0 ep:1 wo:b oos:1048543964

            > drbdadm invalidate RESSOURCENAME
            > drbdadm -f primary RESSOURCENAME

            > cat /proc/drbd

                --> 
                    0: cs:SyncTarget ro:Primary/Secondary ds:Inconsistent/UpToDate A r-----
                    ns:0 nr:516028 dw:509568 dr:519132 al:0 bm:31 lo:65 pe:3 ua:50 ap:0 ep:1 wo:b oos:1048032220
                    [>....................] sync'ed:  0.1% (1023468/1023968)M
                    finish: 304:53:21 speed: 948 (1,076) want: 250 K/sec
    
            
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
