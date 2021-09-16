==========================================================
                       G I G A M O N 
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        CLI
        --------------------------

                __________________________
                Conventions

                    - Output :

                        Une commande qui s'execute correctement ne retourne pas d'output
                        Sinon une erreur est affichée.

                    - Sensible à la case

                    - alias : ne doivent pas comprendre ni d'espace ni de tab.

                    - cisco like

                __________________________
                Aide et historique :

                    ? : commandes accessibles
                    maCmd? : suggestions
                    maCommande ? : options possibles
                    double Tab = ?
                    historique : avec les flèche up et down.
                __________________________
                Utilisateurs et droits :

                    default user : admin
                    Rôles :

                        Admin : accès à toutes les commandes et fait partie de tout les groupes
                        Default : accès à toutes les commandes (tout les user on se rôle par défaut)
                            Il est possible de créer ses propres rôles.

                    Pour passer en mode config :

                        > enable
                        # configure terminal
                __________________________
                Ports

                    Cibler un port :

                        Chassis(Box)_ID/Slot_ID/Port_ID

                    Exemple :

                        1/1/x1  : désigne le port 10Gb 1, du slot 1 du GigaVUE ayant la boxID 1

                    Lettre des ports ID :

                        g : 1G
                        x : 10G
                        Q : 40G
                        C : 100G

                    Range :

                        port 1/1/x1..x4

                    Pour rajouter des ports ou d'autres range de ports, il suffit de rajouter une virgule :

                        port 1/1/x1..x4,1/1/x8,...

                    Assigner un alias à un port :

                        port 1/1/x6 alias BIDUL

                __________________________
                Sauvegarder les changements

                    (config)# write memory

        --------------------------
        Features
        --------------------------
                __________________________
                Filter
                        Ingress
                        ``````````````````````````
                            Filtre les protocoles entrants avant d'atteindre un port cible.
                            (ne se préocupe pas de la destination)

                        Egress
                        ``````````````````````````
                            Supprimer les paquets sur un port sortant.
                            Selectionner quel protocol peut passer.

                __________________________
                Flow Mapping 

                    Configurer les règles de mapping (entre l'ingress et l'egress) pour rediriger les flux aux bons endroits.
                    Surtout dans le cas où l'on veut rediriger du flux vers des outils d'analyse.

                    Collector :

                        Cette fonction permet de rediriger tous les paquets ne correspondant à aucune règles et de les envoyer sur un port egress pour analyse.
                    
                __________________________
                De-Duplicate

                    Supprimer les paquets doublons ayant la même payload.
                    Utilisé surtout pour des outils d'analyse de performance.

                __________________________
                Slicing

                    Supprimer une partie d'un paquet.
                    Permet de faire gagner du temps à beaucoup d'application d'analyse.
            
                __________________________
                IP Tunneling

                    Encapsuler des infos vers un Gigamon.
                    Par exemple, pour rappatrier des informations pour les faire analyser par des outils.

                __________________________
                Masking 

                    Masquer des données confidentielles à l'intérieur d'un paquet
                    (utile pour garder de la confidentialité tout en envoyant des paquets vers des outils d'analyse)

                    Réecriture d'une donnée confientielle avec d'autre infos d'un pattern définit par l'utilisateur.

                __________________________
                Header Stripping

                    Supprimer les header/Tags d'un paquet pour les rendre utilisable par une application tiers.
                    
                    Note : il est possible de rajouter un TAG type VLAN en fonction d'un autre TAG comme le MPLS.

                __________________________
                Source Identification

                    Ajouter un label à la fin d'un paquet (sur quel Gigamon il a été intercepté) avec :

                        - GigaVUE platform type
                        - Box ID (chassis)
                        - Port ID

                __________________________
                Time stamping 

                    Rajoute des infos temporelles sur des paquets au moment où ils sont interceptés par un Gigamon.
                    Très utile pour débug la latence ou la jigue.

                    Note: il faut idéalement prendre la mesure à plusieur endroit.

        --------------------------
        Physically
        --------------------------
                __________________________
                Control cards :

                    Les cartes de contrôleur se trouvent au milieu du chassis.
                    Elles sont nécessaire pour le management du Gigamon. Sur les HD8, deux cartes existent pour assurer un max de performance.

        --------------------------
        Termes
        --------------------------

            Gigastream : Technologie gigamon pour distrubuer du flux sur plusieurs outils de monitoring (destinations) . Inclut de la HA et du load balancing. (Capable de ne pas casser les sessions).
            Network_port : source port
            Tool_port : destination port
            SPAN (Switch Port ANalyzer) : Fonctionnalité logiciele qui permet de duppliquer le flux sur des équipements tels que des switch, router. (Consomme beaucoup de resources, on préfera souvent un TAP).
            TAP (Test Access Point) : Equipement dédié qui s'occupe de duppliquer le flux à des fin de monitoring.
            
~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        1 - First Use , Accès
        --------------------------

            Note :
                Default user : admin
                Default pwd : YWRtaW4xMjNBIQo=

            Se connecter sur le port console de la control card (au milieu du chassis sur le port nommé 'console', sur la carte de gauche pour les HD8).

                Paramètres :

                    BAUD : 115200
                    NO-PARITY
                    DATA BIT : 8
                    STOP BIT : 1
                    NO FLOW CONRTOL

                > enable
                > config terminal
                > config jump-start

            Si le script de configuration jump-start n'a pas été utilisé, pour les H series, il faut configurer l'Ip du chassis :

                > interface eth0
                > ip default-gateway DEFAULT_GW
                > ip name-server DNS
                > write memory

            Continuer la configuration via l'interface :

                Se connecter sur le port Mgmt
                et accéder à l'IP précedement configurée.

                Il est possible aussi d'y accéder via la WUI grâce à son navigateur.

        --------------------------
        Les line cards
        --------------------------

                __________________________
                Vérifications :

                    Pour afficher l'état actuel des cartes :

                        > show cards

                __________________________
                #Installer/Changer une carte :

                    Eteindre le slot :

                        > card slot <slot id> down

                        Il faut attendre que la LED devienne bleu pour changer une carte en Live.

                    Ou passer par le bouton de "hot-swap".

                    Puis réactiver le nouveau slot :

                        > card slot <slot id>

                     
                __________________________
                Déplacer une carte :

                    > no card slot <slot id> 
                    
                    Changer ensuite de slot

                    > card slot <slot id>

        --------------------------
        Firmware
        --------------------------

            

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Les line cards
        --------------------------

            Les lines cards sont les cartes modulables que l'on ajoute pour ajouter des ports et bénéficier des fonctionnalités du Gigamon.
            La première étape consiste à configurer les line cards et activer les ports pour les utiliser.

                __________________________
                1- Afficher l'état des lines cards :

                    > show cards

                    Chaque line card doit avoir un id

                __________________________
                2- Configurer un id (si manquant)

                    > chassis box-id <integer>

                __________________________
                3- Activer toutes les cartes :

                    > card all
                __________________________
                4- Activer les ports utilisables :

                    > port 1/2/x1..x4 params admin enable           #(activation des ports)
                    ...

            Note: peut se faire via H-VUE :

                > OVERVIEW > CHASSIS > CARD Propertie > check
                > OVERVIEW > CHASSIS > PORT Propertie > check

        --------------------------
        Basics
        --------------------------

            Les conf à faire :

                - Création des users
                - Config de l'authentification
                - Config SNMP
                - Config des notifications
                - Condig de syslog


        --------------------------
        Changer de modes
        --------------------------

            > enable                : endosser les droits d'admin
            > configure terminal    : entrer en mode conf

        --------------------------
        Supprimer une conf
        --------------------------

            > no maCONF

        --------------------------
        Conf
        --------------------------
                __________________________
                Sauvegarder :

                    > write mem
                    > configuration write to FILENAME
                    > configuration upload FILENAME ftp/scp/sftp ...
                    > configuration fetch FILENAME ftp/scp/sftp ...

                    Note : la conf sous forme binaire est la seule qui peut rétablir une config entièrement.

                __________________________
                Changer/voir la conf :

                    > show configuration files
                    > configuration switch-to FILENAME

                __________________________
                Afficher :

                    > show port
                    > show running-config

        --------------------------
        Flow Mapping
        --------------------------
                __________________________
                Intro :

                    Le mapping permet de copier/rediriger du flux des ports ingress aux egress.

                    (config) #> map-passall alias myMapName

                    Exemple, rediriger le flux web sur un port :

                    (config) #> map-passall alias webmapping
                        > to 1/1/g2
                        > from 1/1/g5
                        > rule add pass portsrc 80 bidir
                        > exit
                        > wr mem
                __________________________
                Port Type :

                    Désigne le comportement d'un port :

                        * Network : flux en input. (par défaut) [ingress]
                        * Tool : flux en output, permet de forwarder du flux. [egress]
                        * Hybrid : Beneficie du comportement Network et Tool sur un même port.
                        * Tool Mirror : Réplication des paquets vers un autre port en mode tool.
                        * Tool GigaStream : Load balance des paquets sur d'autre ports en mode tool.
                        * Stacking : Permet d'envoyer du flux entre nouds Gigamon (voir cluster)
                        * Tunnel : Encapsulation des paquets entre Gigamon.
                        * Port-Pair : Equivaut à un TAP logique entre deux ports.

                    Exemple de changement de type :

                        Port 1/1/x1..x4 type tool

                __________________________
                Pass All :

                    Forwarder tout le traffic sans filtrer :

                        # map-passall alias <MapName>
                        # from <port_ingress>
                        # to <port_egress>

                __________________________
                Flow Mapping

                        ``````````````````````````
                        Selectionner le flux à renvoyer sur un ou des egress port(s).

                            # map alias <Map_Name>
                            # from <port_ingress>
                            # to <port_egress>
                            # rule add pass portsrc <portnumber> <flowdirection>

                        ``````````````````````````
                        D'autres exemples de règles :

                            Tout le flux IPv4 :

                                #rule add pass ipver4

                        ``````````````````````````
                        Filtres Overlapping :

                            * La première règle correspondante sera appiquée (uniquement)
                            * Priorisation des filtres du plus specifique au moins specifique.

                        Il est possible de réediter un Flow mapping et de ne changer qu'un attribut comme le "to"

                        ``````````````````````````
                        Gestion des priorités :

                            Niveau de priorités :

                                * after
                                * before
                                * highest
                                * lowest

                            Exemple :

                                # map alias <Map_Name> priority lowest
                                // and/or
                                # map alias <Map_Name>
                                # priority after <Other_Map_Name>

                        ``````````````````````````
                        Shared collector :

                            Permet de récupérer le flux qui ne matche pas avec les filtres :

                            # map-scollector alias <MapName>
                            # from <ingress_port>
                            # collector <egress_port>

                        ``````````````````````````
                        Supprimer une map :

                            Il suffit d'utiliser no et le nom de sa règle.

                            Exemple :

                                # no map-passall alias <Map_Name>

                        ``````````````````````````
                        Tool mirror :

                            Copier les données d'un port egress vers un autre

                            # tool-mirror alias <alias name> from <port_egress> to <other_port_egress>

                        ``````````````````````````
                        Replicate :

                            Permet d'ajouter d'autres tool ports à une map.

                            La différence entre Replicate et Tool mirror, c'est que replicate agit au niveau des maps. Alors que le mirror Tool lui ne s'en préoccupe pas.

                            Dans ce cas on ajoute seulement des ports à l'option "to"

                            Exemple :

                                # map alias Core_Web
                                # to 1/1/x5,1/1/x6...

                        ``````````````````````````
                        Egress Filter :

                            Filtrer les paquet au niveau d'un port egress.

                            # port <egress port> filter rule add drop ipsrc <IP> /<mask>


                        ``````````````````````````
                        Tool GigaStream :

                            Permet de Load balancer du traffic d'une map sur plusieurs ports.

                                * Les paquets d'une même session sont envoyés sur le même port
                                * Permet de gérer les problèmes de limite de bande passante
                                * Il faut au moins un groupe de deux ports pour faire un gigastream

                            // delete all previous filter and remake the flow mapping :
                            # port <port_egress> filter rule delete all
                            # map alias <alias_name>
                            # to <port_egress>

                            //then make the gigaStream egress ports :
                            # gigastream alias <alias name> port <egress ports>

                            //Add the gigastream ports as destination to a flow mapping :
                            # map alias <alias name>
                            # to <gigastream alias name>,<previous ports>
                            # exit

        --------------------------
        Map templates :
        --------------------------

            Permettent de créer des set de règles pré-configurées.

                * Utilisé pour les tâches répétés de supervision
                * Permet d'éliminer des erreurs pour les configurations complexes.
                * Les modèles ne peuvent être utilisés qu'individuellement.

                __________________________
                Créer un template :

                    Exemple :

                        # map-template alias <template name>
                        # comment "my comment
                        > on further lines"
                        # rule add pass ipsrc <IP>/<mask> <direction>
                        # rule ...
                        # exit

                __________________________
                Appliquer un template :

                    Voir GUI

                __________________________
                Combiner des templates :

                    Cette feature est dispo uniquement via la GUI.

        --------------------------
        GigaStream
        --------------------------
                            
            Permet de load blancer du flux sur plusieurs ports egress.
            Support le Failover et le Failover Recovery Automatic.
            Il doit être configuré sur des ports de même capacité.

            Au niveau de la GUI, voit l'onglet port group.

            Deux modes possibles :

                * Tool Gigastream (egress destination tool)

                    Pour load-balancer vers plusieurs tool ports du même noeud.

                * Stacking Gigastream (Bidirectional between two nodes within a cluster)

                    Pour load-balancer vers n'importe quel tool ports du cluster.

            On peut l'utiliser à partir :

                * d'un port map
                * d'un Tool mirror (redirigé vers un port logique GigaStream)
                * d'un Shared Collector (redirigé vers un port logique GigaStream)

                __________________________
                Créer un GigaStream Tool :

                    # port <range ports> type tool
                    # gigastream alias <alias> port-list <same port range> [params hash advanced]
                __________________________
                Créer un GigaStream Stack :


                    # port <range ports> type stack
                    # gigastream alias <alias> port-list <same port range> [params hash advanced]

                __________________________
                Hash :
                    
                    Le hash influt sur comment les paquets seront load balancés.
                    Il se configure au niveau d'un slot.
                    
                    Plusieurs modes :

                        * macdst / macsrc
                        * ethertype
                        * ipdst* / ipsrc* / ip6dst* / ip6src*
                        * protocol
                        * ip6nextHeader
                        * portdst* / portsrc* / port6dst* / port6src*

                        * = Activé par défaut

                    Exemples de configuration :

                        # gigastream advanced-hash slot 1/1 fields ip6dst ethertype
                        # gigastream advanced-hash slot 1/1 fields port6src port6dst
                        # gigastream advanced-hash slot 1/1 fields ipsrc ipdst

                    Afficher :

                        # show gigastream advanced-hash slot 1/1

        --------------------------
        Configuration and Backup
        --------------------------


            Deux formats possibles :

                * Standard (binaire)
                * Text (ASCII) (les password ne sont pas écrit en clair)
                    Il faudra les réentrer à la main.

                __________________________
                Sauver la conf :

                    # write memory
                    # configuration write to <file name> [no-switch]

                    Attention, la configuration sauvée devient la configuration active du noeud.

                    En cas de problème :

                        #configuration revert saved

                __________________________
                Backuper la conf :

                    Binaire :

                        # configuration upload pre-upgrade tftp://IP/filepath
                        # configuration upload active scp://user:pwd@IP/filepath

                    Texte :

                        # configuration text generate active running upload tftp:...
                        # configuration text generate active saved upload ...
                        # configuration text file <file name saved> upload ...

                __________________________
                Restaurer la conf :

                    Binaire :

                        # configuration fetch tftp://IP/filepath
                        # configuration fetch ftp://user:pwd@IP/filepath <filename backuped>
                        # configuration switch to <filename backuped>

                    Texte :

                        # configuration text fetch tftp://...filepath filename <file downloaded> [apply fail-continue verbose]
                        # configuration text file <file saved> apply fail-continue verbose

                        //Appliquer les changements :

                            fail-continue : COntinue d'appliquer la conf même si il y a eu une erreur
                            verbose : afficher les commandes qui sont appliquées


                                

        --------------------------
        Clustering
        --------------------------

                __________________________
                1 - Plan the cluster :

                    Pour créer son cluster, il faut choisir un type d'architecture qui determine comment les différent flux seront interconnectés.
                    À savoir :

                        * Flux de Management, pour prendre le contrôl sur les machines.
                        * Flux de Cluster Control, pour les directives du cluster.
                        * Flux de Crossbox Traffic, pour les données échangées entre cluster.

                    Ce qui donne 3 architectures possibles :

                        * Out-of-band, Daisy Chain 
                            (Separate links + not reliable)
                            Le flux de contrôle et de données transitent par un noeud.

                        * Out-of-band, Spoke and Hub 
                            (Separate links + most reliable)
                            Le flux de contrôle est relié à un switch 
                            Le flux de données lui est relié à un noeud.

                        * In-band, Spoke and Hub
                            (Common link + reliable)
                            Utilise un lien commun et un HDB reliés à un noeud pour tout faire transiter.


                    Le nombre de noeud pouvant être connectés sur un cluster dépend de la version de la carte de contrôle :

                        * CCv1 : 4 nodes
                        * CCv2 : 8 nodes

                    Il faut ensuite déterminer la bande passante qui transitera sur chaque ports pour bien choisir ses modules.


                    Clustering Rôle et votes :

                        * Master : repond au VIP (Virtual IP address), gère le cluster.
                        * Standby : assure le rôle de master si le master n'est plus joignable.
                        * Normal : Participent à l'election du noeud 'standby'

                        Lors d'une panne, ou coupure de courant, le noeud ayant la valeur la plus forte deviendra master et le second standby.

                __________________________
                2 - Physical connection :

                    On rack et on allume d'abord les noeuds
                    On fait les connections dans l'ordre : management, controle, crossbox stacking.

                __________________________
                3 - Configure the cluster master :

                    #show sync          // Ensure the control cards are synced
                    #show version       // All nodes have to be in the same software level
                    #reset factory all  // Erase all configuration before clustering and follow instructions

                    Si on a pas suivit les instructions de départ et qu'on c'est déja logué :

                    > enable
                    # configure terminal
                    (config)#configuration jump-start
                    (config)#show cluster global brief

                __________________________
                4 - Configure the slave nodes :

                    Il faut là aussi lancer un jump-start.
                    Les options de cluster devraient être automatiquement proposées comme le VIP du master.

                    (config)#show cluster global brief

                    Il faut ensuite retourner sur le master pour assigner les BOX-ID aux slaves.
                    Ajouter +1 au BOX-ID du master par exemple.

                        (config)#show chassis       // récupérer les serial ID
                        (config)#chassis box-id 12 serial num C0034
                        (config)#show cluster global brief
                __________________________
                5 - Create crossbox stack links for traffic forwarding

                    Sur le master, activer les lines cards et les ports (exemple) :

                        (config)# show cards
                        (config)# card slot 1/1 mode 32x
                        (config)# card all box-id 11
                        (config)# card all box-id 12
                        (config)# card all box-id 13
                        (config)# port 11/1/x1..x32 params admin enable  // (<box-id>/<card-id>/port-range)
                        ...

                        // Configurer le stacking :
                        (config)# port 11/1/x29..x31 type stack
                        ...
                        (config)# gigastream alias hd4-to-hc2 port-list 11/1/x29..x30
                        ...
                        stack-link alias 94-to-43 between gigastreams hd4-to-hc2 and hc2-to-hd4

                    Note pour le Gigastream :

                        Il faut toujours désactiver ou déconnecter les ports d'un Gigastream avant de le supprimer pour éviter de créer des boucles.

                __________________________
                6 - Verify connectivity between nodes

                    # show cluster global
                    # show cluster global brief
                    # show stack-link
                    # show gigastream

                    Debug :
                        # show log matching clusterd.ERR
                        # show log matching clusterd.NOTICE
                        # show interface eth0
                        # show port params port-list <boxID/slotID/port>

                __________________________
                7 - Test crossbox traffic distribution using a Flow Map

                    Ce test consiste à créer un flow mapping pour voir si tout les ports du cluster sont accessibles.

                    Note : Il n'est pas possible de forwarder du flux sur un autre cluster.


        --------------------------
        Traffic Source Identification
        --------------------------

            Cette feature est activable grâce au GigaSMART Source Port Labeling Application.
            Le label inclut le : GigaVUE PlatformType, BoxID, et le PortID.


        --------------------------
        GigaVue FM
        --------------------------

            GigaVue FM est un outil de centralisation de configuration et monitoring pour les GivaVUE VM (installées sur les hyperviseurs à monitorer) et la Visivility Fabric (equipements dédiés).
                __________________________
                Install :

                    * Sur un Esxi

                __________________________
                Update :

                    Faire un snapshot et une sauvegarde la VM avant update.

                    # show images
                    # image delete fma200.img
                    # image fetch tftp://...//fma2300.img
                    # image install fma2300.img
                    # image boot next
                    # reload

                __________________________
                Ajouter des noeuds :

                    Il n'est pas nécessaire qu'ils soient sur le même hyperviseur que le FM.
                    
                    Le faire via la GUI de GigaVUE-FM et ajouter les credentials des VM.

        --------------------------
        Header/Tunnel Stripping
        --------------------------

            Cette feature permet de supprimer les headers d'un paquet comme :

                * VLAN Tags
                * MPLS Label
                * VN Tags
                * VXLAN Tags
                * GTP Tunnel
                * ISL Tunnel

                __________________________
                Stripping :

                    //Créer des ports egress :
                    # port <port-range> type tool

                    //Créer un groupe GIGAsmart :
                    # gsgroup alias <alias> port-list <pool>

                    //Créer une opération de stripping :
                    # gsop alias <alias name> strip-header <header type> port-list <gsgroup alias>

                    //Associer le stripping à un filtre :
                    # map alias <map alias name>
                    # use gsop <gsop alias>
                    # rule add ..
                    # from <ingress port>
                    # to <egress port>

                    Exemple de stripping MPLS :

                        # port 1/1/x5..x6 type tool
                        # gsgroup alias GS1 port-list 1/5/e1
                        # gsop alias stripMPLS strip-header mpls port-list GS1
                        # map alias strip_MPLS_example
                        # use gsop stripMPLS
                        # rule add pass ethertype 8847
                        # from 1/1/x1
                        # to 1/1/x5
                __________________________
                Tag :

                    Il est possible d'ajouter un VLAN TAG à un paquet :
                    Les étapes sont les même que pour le stripping.

                    Exemple :

                        # port 1/1/x6 type tool
                        # gsgroup alias GS1 port-list 1/5/e1
                        # gsop alias addVLAN add-header vlan 101 port-list GS1
                        # map alias add_VLAN_example
                        # use gsop addVLAN
                        # rule add pass ipver4
                        # from 1/1/x2
                        # to 1/1/x6

        --------------------------
        Packet Slicing
        --------------------------

            Permet de couper une partie du paquet comme la payload pour faire alléger la charge aux outils de monitoring.

            Il est possible de configurer deux types de slicing :

                * Découpage statique (static offsets)
                    Commence de 0 à un nombre donné d'octets (jusqu'a 9000).

                * Découpage relatif (relative offsets)
                    Commence à un nombre donné d'octets jusqu'au dernier octet (9000).

            Le checksum Ethernet est recalculé après une opération de slicing.

            Les commandes sont du même ordre que le stripping :
                    
                __________________________
                Exemple slicing :

                    # port 1/1/x5 type tool
                    # gsgroup alias GS31 port-list 1/3/e1

                    // créer une opération de slicing relatif après 7 octets du paquet UDP
                    // Il est possible d'ajouter un trailer pour retrouver la taille d'origine du paquet.
                    # gsop alias sliceUDP_7 slicing protocol udp offset 7 [trailer add crc enable srcid enable] port-list GS31 

                    # map alias slice_SNMP_example
                    # use gsop sliceUDP_7
                    # rule add pass portsrc 161 bidir
                    # from 1/1/x1
                    # to 1/1/x5
                    # exit
            
        --------------------------
        Data Masking
        --------------------------

            Permet de cacher une partie du paquet pour ajouter de la confidentialité avant de les envoyer à des outils de monitoring.

            Même idée de fonctionnement que le slicing avec de type :

                * Static offsets
                * Relative offsets

            Dans l'opération de masking, il faut determiner quel pattern utiliser pour masker les données.
            Le champs checksum Ethernet est aussi recalculé mais la quantité de données reste inchangée.

                __________________________
                Exemple masking :

                    # port 1/1/x5 type tool
                    # gsgroup alias GS31 port-list 1/3/e1
                    # gsop alias maskUDP_7_20 masking protocol udp offset 7 pattern FF length 20 port-list GS31
                    # map alias mask_SNMP_example
                    # use gsop maskUDP_7_20
                    # rule add pass portsrc 161 bidir
                    # from 1/1/x1
                    # to 1/1/x5
                    # exit


        --------------------------
        IP Tunneling
        --------------------------

            On utilisera un tunnel IP le plus souvent, pour rapatrier des données d'un site distant, parfois difficil d'accès pour l'analyser depuis un outils de monitoring connecté à la Fabric.

            L'IP tunneling peut utiliser des tunnels ERSPAN (Cisco).

        --------------------------
        Source Port Labeling
        --------------------------

            Idéal pour identifier d'où vient un paquet.

            Le TAG Gigamon est ajouté à la fin du paquet entre la payload et le FCS (Frame Check Sequence).

            | Platform Type | Group ID | Box ID | Slot ID | Trailer Length | Gigamon EtherType | CRC |

            Toujours dans le même principe que les autres features, il faut créer un gsgroup un gsop.
                __________________________
                Exemple Labeling :

                    # port 1/1/g5 type tool
                    # gsgroup alias GS1 port-list 1/1/e1
                    # gsop alias Label_Source trailer add crc disable srcid enable port-list GS1
                    # map alias lavelingExample
                    # use gsop Label_Source
                    # rule add pass ipver4
                    # from 1/1/g1..g3
                    # to 1/1/g5
                    # exit

        --------------------------
        Adaptive Packet Filtering
        --------------------------

            Permet d'avoir plus de choix de règle que le flow mapping.
            Compatible Regex (PCRE) pouvant chercher dans la payload même.

            Il peut être utilisé avec d'autre fonctionnalités comme :

                * Tunnel Termination
                * SSl Decryption
                * Header Stripping

            L'APF agit comme un second niveau de filtre et s'applique à des ports virtuels.

            Ingress => Premier niveau de MAP => Port virtuel => Deuxieme niveau de filtre => Egress

            L'association de port virtuel et de l'APF se fait au sein d'un même GS group.

            L'APF gère les encapsulation par tunnel. Dans ce cas il faudra spécifier à quel niveau on applique la recherche.

            Quelques règles :

                * Il est impossible de rediriger un flow Map sur des ports différent d'un même GS group.

                * Le résultat d'un deuxième niveau de filtre ne peut pas être redirigé sur un port virtuel.


                __________________________
                Configuration :

                    On créer une opération :

                        # gsop alias <MyOperation> apf set port-list <GS1>

                    On définit des règles de second niveau (exemple):

                        # gsrule add pass l4port dst pos 2 value 80

                        Paquet TCP de couche4, Attribut encapsulé en position 2 comme port de destination.

                __________________________
                Exemples de règles APF :

                    # gsrule add pass mpls label pos 1 value 3
                    # gsrule add pass iper pos 1 value 4
                    # gsrule add pass ipv4 dst pos 2 value <IP/mask> ipv4 proto pos 2 value tcp l4port dst pos 2 value 80
                    # gsrule add pass gtp gtpu-teid 1001..2000 subset none
                    # gsrule add pass pmatch string "\xff\xff\xfe" 29

                    Regex :

                        # gsrule add pass pmatch RegEx "^\d{3}-\d{2}-\d{4}$" 0..1750

                __________________________
                Exemples APF :

                    //Ici on applique un premier niveau de stripping :

                    # port 1/1/x5..x7 type tool
                    # gsgroup alias GS5 port-list 1/5/e1
                    # gsop alias APF_NoVXLAN apf set strip-header vxlan 0 port-list GS5
                    # vport alias vp51 gsgroup GS5
                    # map alias mapLevel1_VXLAN
                    # rule add pass portsrc 8472
                    # from 1/1/x1
                    # to vp51
                    # exit

                    // Création d'un deuxième niveau de filtering :

                    # map alias mapLeel2_web
                    # use gsop APF_NoVXLAN
                    # gsrule add pass l4port src pos 2 value 80
                    # from vp51
                    # to 1/1/x5
                    # exit

                    ...

                    // Création d'un collector :

                    # map-scollector alias vp51-Collector
                    # from vp51
                    # collector 1/1/x7
                    # exit

                    ...

        --------------------------
        Load Balancing
        --------------------------

            Le load balancing doit 

                * Les ports doivent être sur le même chassis.
                * Peut fonctionner sur des ports à différents débits
                * Non supporté par les shared collector.
                * Support 50 groupes de ports avec 16 ports par groupe.
                * Support du Port Failure et Port Failure Recovery (réatribution du flux d'un port down à un aurte port).
                * Support du Failover et Failover Tresholds (Réassignement automatique du flux à des ports ne dépassant pas le treshold).
                * Support des ports map


            Deux états possibles de load-balancing :

                * Stateless (paquet par paquet)
                * Stalefull (session)

                __________________________
                Stateless :

                    Traite paquet par paquet et ne se soucie pas des sessions.

                        Méthodes de load-balancing
                        ``````````````````````````

                            * Hashing :

                                - ip only
                                - ip and port
                                - 5 tuple ( protocol + Ip + ports )
                                - gtpu teid

                            * Field location :

                                - Outer
                                - Inner
                                    
                                    . Ip in IP
                                    . VXLAN
                                    . GTP
                                    . GRE
                                    . ERSPAN

                        Exemple 
                        ``````````````````````````

                            // Création d'un groupe de port pour le load balaning
                            # port 1/1/g5..g8 type tool
                            # port-group alias LB_tools
                            #  port-list 1/1/g5..g8
                            #  smart-lb enable
                            #  exit

                            // Création d'une opération de load balancing
                            # gsgroup alias GS1 port-list 1/1/e1
                            # gsop alias lb_5 tuple lb hash 5-tuple outer port-list GS1

                            // Activation du load balancing sur une map
                            # map alias LB_web
                            #  use gsop lb_5tuple
                            #  rule add pass protsrc 80 bidir
                            #  from 1/1/x1
                            #  to LB_tools
                            #  exit
                __________________________
                Stateful :

                    Peut agir sur les encapsulation (VLAN ...)
                    Basé sur les sessions, chaque session sera assignée à un port.

                        Méthodes de load-balancing
                        ``````````````````````````

                            * Hashing : Choix d'une subscriber key ( IMSI, IMEI ou MSISDN)
                            * Métrics :


                                - lt-bw , Least Bandwidth : Basé sur la plus petite quantité de bit/s sur chaque ports.
                                - lt-pkt-rate , Least Packet Rate : Basé sur le nombre de paquet transmis sur chaque ports

                                - round-robin : Basé sur une distribution en boucle sur chaque ports.
                                - lt-conn , Least Connection : Basé sur le moins de connections établis sur chaque ports.

                                - lt-tt-traffic : Basé sur le total d'octet envoyé aux ports.

                                Chaque métic dispose d'une variante :

                                - wt-... : Ajoute un critère pour pondérer le choix du load balancing comme la vitesse du lien ou un poid pré-configuré.

                __________________________
                Exemples Load Balancing :

                    GTP load balancing :

                        # port 1/1/g5..g7 type tool
                        # port-group alias GTP_LB_tools
                        # port-list 1/1/g5..g7
                        #  smart-lb enable
                        #  exit
                        
                        # gsgroup alias GS1 port-list 1/1/e1
                        # gsparams gsgroup GS1
                        #  lb replicate-gtp-c enable
                        #  exit

                        # vport alias vp1 gsgroup GS1
                        # gsop alias GTP_LB flow-ops flow-filtering gtp lb app gtp metric hashing key imsi port-list GS1

                        # map alias malLevel1_GTP
                        #  rule add pass portsrc 2123 bidir
                        #  rule add pass portsrc 2152 bidir
                        #  from 1/1/x1
                        #  to vp1
                        #  exit

                        # map alias map_Level2_GTP_LB
                        #  use gsop GTP_LB
                        #  flowrule add pass gtp imsi *
                        #  from vp1
                        #  to GTP_LB_tools
                        #  exit

        --------------------------
        NetFlow Generation
        --------------------------

            Permet d'envoyer du flux compatible NetFlow.
            Agit après une Map rule, les enregistrements sont mis en cache puis exporté vers la cible  via un tunnel sur un port tool.

            Versions actuellement supportées :

                * V5
                * V9
                * IPFIX

                __________________________
                Composants :

                    * Network ports : Fournis le flux à une map
                    * Map : Relis les éléments entre eux
                    * GigaSmart Operation (GSOP) : Contient la configuration du Monitor, Record et Exporter pour un GigaSMART engine group
                    * Record : Définit quels champs des paquets sont utilisés pour voir si le flux est dans le cache ou si un nouvel enregistrement est nécessaire. Et savoir quel champs collecter.
                    * Monitor : Ecrire dans le cache
                    * Exporter : Récolte les enregistrement du cache pour les envoyer dans un tunnel d'un port egress à des collecteurs. (Peut gérer jusqu'a 6 collector)

                __________________________
                Les champs d'enregistrement :

                    * champs match : Utilisés pour créer des set d'élements pour identifier des flux nouveaux ou existant.
                    * champs collect : Identifie le champs dans un enregistrement qui sera enregistré dans le cache.

                __________________________
                Exemple :

                    //Configuration d'un Record
                    # apps netflow record alias netFlow9_BasicRecord
                    # netflow-version netflow-v9
                    # match add ipv4 protocol
                    # collect add counter bytes

                    //Configuration d'un Exporter
                    # apps netflow exporter alias NetFlow9_HQ_Collector2
                    # destination ip4addr <Ip>
                    # netflow-version netflow-v9
                    # template-refresh-interval 300     //( description envoyé toutes les x secondes pour que le collector puisse savoir quels champs sont présent et dans quel ordre.)

                    //Configuration d'un Monitor
                    # apps netflow monitor alias GS1_NetFlowMonitor
                    # cache timeout active 60
                    # record add NetFlow9_BasicRecord
                    # gsgroup alias GS1 port-list 1/1/e1

                    //Configuration du tunnel
                    # tunneled-port 1/1/g5 ip <IP> <mask> gateway <gw> mtu 1500 port-list GS1
                    # tunneled-port 1/1/g5 netflow-exporter add NetFlow9_HQ_Collector2

                    //Ajout du Monitor à un GS group et création d'une opération
                    # gsparams gsgroup GS1
                    #  netflow-monitor add GS1_NetFlowMonitor
                    # gsop alias NetFlow9_to_HQ_Collector2 flow-ops netflow port-list GS1

                    //Association à une map
                    # map alias NetFlowMapExample
                    # use gsop NetFlow9_to_HQ_Collector2
                    # rule add pass ipver4
                    # to 1/1/g5
                    # from 1/1/g1


        --------------------------
        FlowVUE
        --------------------------

            Permet de superviser intelligemment un set de flux.
            Comme par exemple extraire des échantillons (x%) de flux tous les X secondes.

                __________________________
                Exemple :

                    //Création d'un GS group
                    # gsgroup alias GS1 port-list 1/4/e1

                    // Paramètres du flow-sampling avec le sous réseau qui doit matcher.
                    # gsparams gsgroup GS1 flow-sampling-type device-ip
                    # gsparams gsgroup GS1 flow-sampling-rate 10
                    # gsparams gsgroup GS1 flow-sampling-device-ip-ranges add ip4add <IP/mask>

                    // Activation via une map
                    # gsop alias flowSample10 flow-ops flow-sampling port-list GS1
                    # map alias WebSrvCluster2
                    # from 1/1/q1
                    # use gsop flowSample10
                    # rule add pass portsrc 80 bidir
                    # to 1/1/x5
                    # exit

                    Notes : 
                        * Un seul rate est supporté par gsgroup
                        * Ne supporte que les protocols IP et IP dans GTP
                        

        --------------------------
        GTP Correlation
        --------------------------

            Fournit la possibilité de scruter le flux de données mobile (LTE, 3G)

            Comme l'APF, il faudra configurer des ports virtuels pour appliquer un deuxième niveau de filtre (même règles aussi concernant les ports virtuels, voir la section APF).

                __________________________
                Exemple :

                    
                    //Création des opérations GTP
                    # port x1/1/x5..x6 type tool
                    # gsgroup alias GS42 port-list 1/4/e2
                    # gsparams gsgroup GS42 gtp-flow timeout 12
                    # vport alias vp42_1 gsgroup GS42
                    # gsop alias GTP_2hr flow-ops flow-filtering gtp port-list GS42

                    //Création du premier niveau de filtre
                    # map alias malLevel1_GTP
                    #  rule add pass portsrc 2123 bidir
                    #  rule add pass portsrc 2152 bidir
                    #  from 1/1/x1
                    #  to vp42_1
                    #  exit

                    //Création du deuxième niveau de map
                    # map alias mapLevel2_USA
                    #  use gsop GTP_2hr 
                    #  flowrule add pass gtp imsi 310*
                    #  flowrule add pass gtp imsi 311*
                    #  from vp42_1
                    #  to 1/1/x5
                    #  exit

                    //Création du collector
                    # map-scollector alias vp42_1_Collector
                    # from vp42_1
                    # collector 1/1/x6
                    # exit


~~~~~~~~~~~~~~~~~~~~~~~~~~
Troubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Afficher les logs pour debug
        --------------------------

            # show log matching ERR
            # show log matching mgmtd.ERR
            # show log matching mgmtd.NOTICE

        --------------------------
        Erreur
        --------------------------
                __________________________
                Logs:

                __________________________
                Description:

                __________________________
                Résolution:

~~~~~~~~~~~~~~~~~~~~~~~~~~
Keywords
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        GTP
        --------------------------

            Basé sur IP utilisé dans les réseaux GSM et UMTS pour encapsuler les données.
