===========================================================
        H A R D W A R E     E T     T E C H N O S
===========================================================
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Composants électroniques
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	-------------------------
	transistor
	-------------------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Unités de calculs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	-------------------------
	CPU
	-------------------------
		________________
                x86
		________________
                amd64
		________________
                arm

	-------------------------
	GPU
	-------------------------
	-------------------------
	Chipset
	-------------------------

                http://fr.wikipedia.org/wiki/Chipset

                Littéralement traduit par jeux de puces, c'est un jeu de composants électronique préprogrammé gérant les flux de données entre le processeur, la mémoire et les périphériques. C'est une sorte de rond point où les bus véhiculent leurs données.

                Le chipset d'une carte mère est plus usuellement découpé en deux partie, le NorthBridge(SPP) traitant avec le CPU, le GPU et la RAM ,puis le Southbridge (MCP) traitant avec le reste des périphériques.
                        

~~~~~~~~~~~~~~~~~~~~~~~~~~
Media de stockage
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        HDD
        --------------------------

            http://www.commentcamarche.net/contents/740-disque-dur-externe-ou-interne
            http://www-gtr.iutv.univ-paris13.fr/Cours/Mat/Architecture/Cours/polyarch/chap-10_sec-2_sec-2.html

                __________________________
                Composants:
                
                    carte electronique: controleur (firmware) executant les ordre de l'ordinateur et se charge de donner la vitesse de rotation.
                    interface : type de connecteur utilisé (sata, IDE, SCSI ...)
                    Moteur du bras : pour déplacer la tête de lecture
                        -Fonctionne via l'electromagnétisme
                    Le bras : support à la tête de lecture
                        -Pivote très vite grâce aux force eletromagnétiques
                    la tête de lecture : la pointe du bras servant à lire les données sur le disque.
                        -Flote sur un coussin d'air créer lors de la rotation du disque (ne touche jamais le disque)
                        -Elles ont pour but de lire et de magnétiser les couches du disque.
                    le disque: représente l'ensemble des plateaux physiques.
                        -Les plateaux sont recouvert d'une fine couche magnétisé.
                        -Cette couche permet de stocker des bits (sous forme magnétique + -)
                    moteur: permet de faire tourner le disque.
                    cavaliers : permet d'ordonner le rôle du disque dut (maitre/esclave).
                        (Sur les vieux disques)

                __________________________
                Structure

                    Les plateaux peuvent être en métal, en verre ou en céramique.
                    Ils tournent autour d'un axe dans le sens inverse d'une aiguille d'une montre.
                    Ces plateaux sont magnétisés (sur une fine couche protégé).
                    Permetant ainsi de stocker les bits sur des cellules magnétique polarisée.
                        Ainsi l'information binaire est représenté par l'orientation des particules magnétiques:
                            -> 0 | <- 1

                    La tête de lecture comporte une bobine créant un champ magnétique dont l'orientation dépend du sens de circulation du courant electrique.

                    Pistes:
                        Correspond à chaque cerle de rayon n+1 de l'extremité au centre du plateau.
                        Il peut y avoir jusqu'a 200 000 pistes ...

                    Secteur:
                        Segmentation des pistes en quartier régulier et égaux.
                        (512 octet par secteur en règle générale)

                    Cylindre:
                        Ensemble des données situées sur une même piste sur l'ensemble des plateaux.

                    cluster/blocs:
                        zone minimale que peut utiliser un fichier sur un disque.
                        Regroupe plusieurs secteurs
                        Elle est determinée par le type de FS et la taille des partitions.

	-------------------------
	SSD
	-------------------------
            http://www.tomshardware.fr/articles/ssd-flash-disques,2-393-2.html

            Repose sur la mémoire flash NAND utilisant les transistors comme support de stockage.

            Il existe plusieurs type de NAND:
                
                SLC (Single Layer Cell) : 1 seul bit dans la grille flottante.
                MLC (Multi Layer Cell) : plusieurs bits dans la même cellule.


        --------------------------
        CD Rom
        --------------------------

            Composé d'une piste en spirable lisible par un faisceau laser.
            La piste est recouverte d'une couhe de métal réfléchissant garni de trou (représentant l'information binaire)
            Le lecteur CD mesure le reflet du faisceau et permet la detection de ces trous.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bus
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        http://fr.wikipedia.org/wiki/Bus_informatique

        Il définit les manières de communiquer entre les périphériques d'un ordinateur.
        En général cela comprend à la fois le type de support (câble, nappe...) et le protocole de communication.

        Les informations véhiculant sur un bus sont en général découpées en 2 catégories:
                -Les informations utiles pour chaque périphériques; (=~ payload)
                -Les informations de contrôle d'état du bus.

        On caractérise un Bus notament par sa fréquence (Hz), son débit (o/s) et le nombre de voie sur lesquels les bit circulent (sa taille en bits).

        Nous avons deux grands type de bus qui sont:
                
                Les Bus parallèle:
                ``````````````
                        
                        Doté de plusieurs canaux physique, ils transmettent des bits simultanément à chaque impulsion électrique.
                        Par exemple sur un bus 16 bits, L'emetteur positionnera 16 bits sur chacun des cycle électriques. Le recepteur devra traiter le mot entier de 16 bits arrivant.
                        L'émetteur et le récepteur doivent s'accorder pour envoyer et lire chaque groupe de bits envoyés. 
                        Pour que le recepteur sache que tout les bits on été envoyés sans erreur (dû à des longueurs variables de canaux, des position différentes...); il faut donc contrôler, maintenir l'état de chacun des canaux.
                        Cela réduisant le débit maximal de données transmis.
                        Ils ont aussi tendance à générer plus d'inteférence électromagnétiques que les bus série.

                Les Bus série:
                ``````````````

                        Il nécessite une serialisation des données (découpage en suite dite atomique de l'information), c'est à dire de transporter les données sous forme de petit mot pour les véhiculer sur un canal et les traiter plus facilement.

                        En théorie le bus série dispose d'un seul canal pour envoyer les données. (notion de half-duplex)
                        Cependant beaucoup de Bus 'série' en dispose d'au moins deux afin d'assurer une communication dans les deux sens (notion de full-duplex)
                        Il permet de bénéficier de côuts moins importants et d'avoir des débits très élevés.

                        De manière général il faut que l'emetteur et le recepteur s'accorde sur la vitesse d'émission/reception (exprimée en bauds de bit/s , exemple 9600, 4800 ...).
                        On reservera de manière général des bits supplémentaires de début et de fin pour garentir une transmission sans erreur et délimiter clairement le mot de bit envoyé.
                        Enfin la transmission se fait le plus souvent de manière asynchrone , c'est à dire sans qu'il y ait d'impulstion d'horloge sur l'emetteur et le récepteur).

	-------------------------
	SCSI - Small Computer System Interface
	-------------------------
		________________
		Links:

                        http://fr.wikipedia.org/wiki/Small_Computer_System_Interface
                        http://www.t10.org/

		________________
		Description:

                        C'est un standard décrivant un bus informatique reliant des périphériques entre eux.
                        Il définit les aspects mécaniques, électriques et fonctionnelles du bus.
                        Il s'appui plus recement sur la norme SCSI-3.

                        Sa force réside dans le fait de laisser au périphérique la tâche d'éxécuter les opérations/commandes complexes. Déchargeant ainsi le CPU et plus facilement maniable par les OS multitache qui peuvent les décomposer en sous-tâche.

                        Le SCSI-3 apporte en plus des interfaces parallèles, des spécificité pour les interfaces série.

                        
                        Norme   Interface       Vitesse (Mo/s) |Fréquence (MHz)|Taille (bits)
                        SCSI-1  SCSI            5               5               8 
                        SCSI-2  Wide            10              5               16      
                                Fast            10              10              8       
                                Fast Wide       20              10              16      
                        SCSI-3  Ultra           20              20              8       
                                Ultra Wide      40              20              16      
                                Ultra2          40              40              8       
                                Ultra2 Wide     80              40              16      
                                Ultra3          80              80              8       
                                Ultra3 Wide     160             80              16      
                                Ultra-320       320             160 (80 en DDR) 16 
                                Ultra-640       640             320 (80 en QDR) 16 

                        Note: attention cependant à la longueur et le type du câble qui diffère selon les interfaces.


                        Autres technologies utilisées avec les commandes SCSI-3:
                                                Interface parallèle                                     Interfaces série
                                                    Ultra SCSI               FC-AL                           SSA                     IEEE P 1394
                        Protocole            SCSI Interlock Protocol   Fibre Channel Protocol       Serial Storage Protocol       Serial Bus Protocol 
                                                     (SIP)                   (FCP)                           (SSP)                       (SBP)
                        Vitesse max.              5 à 640 Mo/s           100 à 400 Mo/s                  20 à 80 Mo/s              12,5 à 3 200 Mb/s
                        Nombre de périphériques     7 à 15                      126                           128                        63
                        Distance                   12 à 25 m            20 à 200 m (cuivre)             20 m (cuivre)                   72 m
                                                                        10 km (fibre optique)        680 m (fibre optique) 
                                  

	-------------------------
	PCI - Peripheral_Component_Interconnect
	-------------------------

                http://fr.wikipedia.org/wiki/Peripheral_Component_Interconnect

                C'est un standard de bus interne décrivant la liaison de cartes d'extension sur une carte mère.
                Le PCI permet à deux carte PCI de dialoguer entre elles sans passer par le processeur.

                Souvent utilisé sur les carte son, graphique et réseau.

		________________
		Variantes:

                        PCI Express
                        Mini PCI
                        PCI-X 2.0


	-------------------------
	SATA
	-------------------------
	-------------------------
	IDE
	-------------------------
	-------------------------
	USB
	-------------------------


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Câbles et catégories
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Troubles et interférences
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
==========================================================
                       T I T L E
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

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

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
