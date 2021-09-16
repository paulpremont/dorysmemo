==========================================================
                        S H I N K E N
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Tutos:
        http://www.shinken-monitoring.org/wiki/shinken_10min_start
        http://blog.nicolargo.com/2008/07/exemples-de-check-de-services-nagios.html

    Documentation

        http://shinken.readthedocs.org/en/latest

        Les addons clients (NRPE ...):
            http://www.nagios.org/download/addons

    Fonctionnement:
        http://wiki.monitoring-fr.org/shinken/shinken-work

    Wiki:

		https://shinken.readthedocs.org/en/latest/08_configobjects/index.html
		http://www.shinken-monitoring.org/wiki
		http://www.shinken-monitoring.org/wiki/setup_snmp_booster_module
		http://www.shinken-monitoring.org/wiki/setup_nrpe_booster_module
		http://shinken.io/
	
~~~~~~~~~~~~~~~~~~~~~~~~~~
Distribution testée
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Debian 7
	Version shinken: 2.0-RC2
	Note: sur la version release candidate 2.0, beaucoup de fichier ne correspondant pas avec la doc. Par exemple les bloques de configuration de shinken-specific.cfg on été déplacés dans les sous dossier de la nouvelle conf.

    /!\ peut engendrer quelques problèmes d'installation sur des architecture autre que x86_64

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it ? 
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Un Nagios dont le coeur à été recodé en python et fonctionnant avec plusieurs daemons complémentaires.
	Jusqu'a 5 fois plus performant que Nagios.

    L'avantage de Shinken c'est que son architectur est distribuée et qu'il peut donc exécuter plusieurs ordonnanceur facilement sur plusieurs sites distants.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Fonctionnement
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Les daemons
        --------------------------

            http://shinken.readthedocs.org/en/latest/_images/shinken-architecture.png

            Layout:


               (read conf)   (dispatch conf)(dispatch check)(execute check)    
            CONF  --->  ARBITRER  --->  SCHEDULER  <--->  POLLER/RECEIVER <---> HOSTS
                                            |--> BROKER 
                                            |   (Export data)
                                            V
                                        REACTIONNER (send alert)

                __________________________
                Arbiter:

                    http://shinken.readthedocs.org/en/latest/_images/shinken-conf-dispatching.png

                    - Supervise les process shinken.
                    - Parse la configuration (Conf parser) et la dispatche (Dispatcher) aux différents Schedulet actifs et daemons.
                    - Répartit la configuration en fonction du nombre d'ordonnanceur up.
                    - Commande les schedulers
                    
                __________________________
                Scheduler:

                    - Gère la répartition des check et actions vers le(s) poller et reactionner.
                    - Analyse les résultats des check.
                __________________________
                Poller:

                    - Execute les checks et renvoit les résultats aux shedulers.
                    - Peuvent être tagués pour exécuter des types de checks précis.
                    - Module NRPE/CommandFile/SnmpBooster pour l'acquisition de données.
                __________________________
                Reactionner:

                    - Lève les alertes, remplis des flux rss, envoie les notifications ...
                __________________________
                Broker:

                    - Exporte les données envoyés par les Schedulers pour le formatage
                    - Intéragi avec la base.
                    - Modules Livestatus API, logs, Graphite-Perfdata ...
                __________________________
                Receiver (optionnel):

                    - Reçoit les checks passifs
                    - Permet d'absorber la charge
                    - Modules NSCA, TSCA, Ws_arbitrer ...

        --------------------------
        Les bases de données
        --------------------------

            rrdtool
            graphite
            mongodb

        --------------------------
        Livestatus (optionel)
        --------------------------

            http://www.shinken-monitoring.org/wiki/livestatus_shinken
                
            L'utilisateur intéragie avec Shinken via l'API 'Livestatus' qui s'occupe d'éxécuter des requêtes auprès de shinken et d'implémenter pas mal de feature du type caching, authentification, récupérer l'état des machines ...

		

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Arborescence
        --------------------------

            anciennement:
                shinken-specific.cfg 	#config propre à shinken
                nagios.cfg 		#config compatible nagios
            
            Depuis la 2.0
                Chaque daemon contient sa conf dans un dossier séparé.

                /etc/shinken        #for configuration files
                /var/lib/shinken    #for shinken modules, retention files...
                /var/log/shinken    #for log files
                /var/run/shinken    #for pid files

        --------------------------
        Ressources:
        --------------------------

            https://shinken.readthedocs.org/en/latest/03_configuration/configmain.html#configuration-configmain-resource-file
            https://shinken.readthedocs.org/en/latest/05_thebasics/macros.html#thebasics-macros

            > vim /etc/shinken/ressources.d

            On y définit les macros utilisateurs
            Elles servent notament à stocker les données sensible comme les mots de passe.

                __________________________
                Macros:

                    $maMacro$

                
                __________________________
                Définitions d'objets
                    https://shinken.readthedocs.org/en/latest/03_configuration/configobject.html#configuration-configobject
                    Permet de définir tout ce que l'on veut monitorer
                


        --------------------------
        Options de conf
        --------------------------

            https://shinken.readthedocs.org/en/latest/03_configuration/configmain.html

                __________________________
                Log (verbosité)

                    log_level=[DEBUG,INFO,WARNING,ERROR,CRITICAL]
                __________________________
                timestamp (visuel)

                    human_timestamp_log=[0|1]
                __________________________
                Objet de config (permet d'indiquer à shinken quoi monitorer)

                    cfg_file=MON_FICHIER
                    cfg_dir=MON_REPERTOIRE

                    Tout les fichier avec l'extension .cfg seront pris en compte pour les répertoires.
                __________________________
                Resources:

                    resource_file=MaResource
                    
                __________________________
                Les utilisateurs:

                    Droits endossés par les daemons:

                        arbiter: broker, poller, reactionner, sheduler

                    user=username
                    group=groupname

                __________________________
                security check:

                    idontcareaboutsecurity=[0|1]
                __________________________
                notification

                    enable_notifications=[0|1]
                __________________________
                rotation des logs

                    log_rotation=[n,d]
                    d : daily
                    n : none
                    
                __________________________
                Commandes externes

                    https://shinken.readthedocs.org/en/latest/07_advanced/extcommands.html#advanced-extcommands
                        check_external_commands=<0/1>	

                __________________________
                d'ordonnancement

                        Contrôles d'execution
                        ``````````````````````````
                            execute_service_checks=<0/1>
                            execute_host_checks=<0/1>

                        accepter les contrôles
                        ``````````````````````````
                            accept_passive_service_checks=<0/1>
                            accept_passive_host_checks=<0/1>

                        ....

        --------------------------
        Variables d'objet
        --------------------------
            __________________________
            Créer ses variables
                
                _maVariableCustom 	XXX

        --------------------------
        Objets
        --------------------------

            https://shinken.readthedocs.org/en/latest/03_configuration/objectdefinitions.html#configuration-objectdefinitions
            
                __________________________
                Les types d'objets:

                    Hosts (Server, switch ...)
                    Host Groups
                    Services (Charge, protocoles ....)
                    Service Groups
                    Timeperiods (Quand peut on monitorer)
                    Commands (Les scripts que shinken doit lancer)
                __________________________
                Heritage des objets 

                    Permet de bénéficier des propriétés et variables d'un autre objet grâce notament à la définition de ces 3 éléments:

                    define monObjet{
                        name	NOM_MODELE_UNIQUE
                        use	NOM_MODELE_HERITE
                        register [0|1]
                    }

                    register permet d'indiquer si shinken inscrit l'objet
                    register n'est pas héritable
                    On le met à 0 lorsqu'on définit un objet partiel. (Dont tout les élements propres à un objet ne sont pas définit)
                    
                    Les variables définit localement on la priorité.
                    Les variables custom sont héritées.
                    L'heritage est chainé entre objets.

                        Annuler l'héritage
                        ``````````````````````````
                            maVariable 	null
                            
                        Ajouter la valeur locale et celle héritée
                        ``````````````````````````
                            +variableHerite,maValeurLocale
                        
                        Heritage implicite (voir doc)
                        ``````````````````````````
                        Heritage implicite ajouté (voir doc)
                        ``````````````````````````
                            lorsqu'on utilise +variableHerité,
                            dans certain cas on en récupère plus d'une avec l'heritage implicite.
                            par exemple:
                                contact_groups +monGroupe

                                heritera de name et de contact_groups du modèle utilisé.

                        Heritage multiple
                        ``````````````````````````
                            use template1,template2 ...

                            la première cité à la priorité ...

                        todo: outrepasser un héritage


        --------------------------
        Config des daemons
        --------------------------

            Dans /etc/shinken/daemons
            
            Les ports d'écoutes par défaut:
                
                scheduler: 7768
                poller: 7771
                reactionner: 7769
                broker: 7772
                arbiter: 7770 (the arbiter configuration will be seen later)

            Une fois la conf fait dans les .ini

            On les référence dans la conf shinken en ouvrant un bloc:

                exemple:
                    define arbiter{
                        Ma_CONF
                    }

        --------------------------
        Les plugins
        --------------------------

            Dans : /var/lib/shinken/libexec
            
            Les plugins vont servir de couche d'abstraction entre shinken et les services managés.

            Exemple de plugins:
                WMI, SNMP, SSH, NRPE, TCP, UDP, ICMP, OPC, LDAP and more

            Ces plugin vont permettre de faire des contrôle, exemple:
                check_nrpe, check_snmp, check_icmp ...

                __________________________
                Importer un plugin:
                    
                    Voir sur un site tiers:
                    http://www.nagios.org/download/plugins
                
        --------------------------
        Les macros
        --------------------------

            Elles servent à subsituer une valeur lors de l'appel d'un objet.
            définition: "$MACRO$"

            Exemple

                define host{
                    host_name XXX	
                    address XXX
                    check_command check_ping
                }
                define command{
                    command_name check_ping
                    command_line ... $HOSTADDRESS$ 
                }
                
                On subsituera HOSTADDRESS par l'adresse du bloc hôte
                __________________________
                Gestion des arguments
                    
                    Envoyer un argument:
                        
                        check_command	script!monArg1!monArg2...

                    Récupérer un argument:
                        
                        $ARG1$, $ARG2$
                __________________________
                Quelques macros + leur portée
                    
                    https://shinken.readthedocs.org/en/latest/05_thebasics/macrolist.html	

                __________________________
                Cibler une valeur d'un autre bloc (On demand macro)

                    Usuellement la valeur d'une macro est substituée par la valeur récupéréer par le bloc appelant.
                    Mais il peut être nécessaire de récupérer une valeur d'un autre block (exemple d'un hôte particulié) en ciblant précisement la réference de la macro:

                    Syntaxe: MONTYPEMACRO 
                        suivi de MAMACRO

                            "MONTYPEMACROMACRONAME"

                    Pour les MACRO de type host:

                        $HOSTMACRONAME:monHostname$

                    Pour les MACRO de type service:

                        $SERVICEMACRONAME:monHostname:monService$

                    Autres exemples:
                        $HOSTDOWNTIME:myhost$               // On-demand host macro
                        $SERVICESTATEID:server:database$    // On-demand service macro
                        $SERVICESTATEID::CPU Load$          // On-demand service macro with blank host name field
                        $CONTACTEMAIL:john$                 // On-demand contact macro
                        $CONTACTGROUPMEMBERS:linux-admins$  // On-demand contactgroup macro
                        $HOSTGROUPALIAS:linux-servers$      // On-demand hostgroup macro
                        $SERVICEGROUPALIAS:DNS-Cluster$     // On-demand servicegroup macro

                    Pour avoir plusieurs valeurs dans une macro on utilise la même syntaxe en ajoutant le délimiteur séparant chaque entrée:
                        
                        $HOSTMAMACRO:monHostGroup:monDelimiteur$

        e				exemple:
                            "$HOSTSTATEID:hg1:,$"

                __________________________
                Récupérer une MACRO d'une variable custom

                    MONTYPE suivit de MAVARIABLE

                    _MAVARIABLE XXX
                    --> $_HOSTMAVARIABLE$
                    
                __________________________
                macro stripping

                    Pour éviter l'interprétation dangereuse d'une macro, certaine sont strippées des caractères shell:

                    $HOSTOUTPUT$
                    $LONGHOSTOUTPUT$
                    $HOSTPERFDATA$
                    $HOSTACKAUTHOR$
                    $HOSTACKCOMMENT$
                    $SERVICEOUTPUT$
                    $LONGSERVICEOUTPUT$
                    $SERVICEPERFDATA$
                    $SERVICEACKAUTHOR$
                    $SERVICEACKCOMMENT$

                __________________________
                Une macro comme une variable d'environnement:

                    Utile surtout pour les scripts

                    On rajoute le préfixe NAGIOS_ devant le nom de sa MACRO

                    Exemple:
                        $HOSTNAME$ devient NAGIOS_HOSTNAME
                    
                
        --------------------------
        Les contrôles / checks
        --------------------------

            Définition des checks à interval régulier
                check_interval
                retry_interval

            Et/Ou sur demande (Varie en fonction du type de check)

            Il sont lancé en paralèlle

                __________________________
                Mise en cache:

                    Permet pour les checks sur demmande régulier de consommer bien mien de mémoire.
                    todo:	
                        https://shinken.readthedocs.org/en/latest/07_advanced/cachedchecks.html#advanced-cachedchecks
                __________________________
                Etats de contrôle (resultat)
                    
                    L'état d'un service ou d'un hôte est determiné à la fois par son status (OK, WARNING...) ainsi que par son type.
                    
                        Types d'état
                        ``````````````````````````
                            https://shinken.readthedocs.org/en/latest/05_thebasics/statetypes.html

                            Ils sont determinés lorsque le gestionnaire d'évennement est exécuté et quand les notifications sont initialement envoyées.
                            En fonction du nombre d'execution d'un même contrôle, on va pouvoir determiner si le problème est important ou pas.
                            On le fait via l'option:
                                max_check_attempts
                            A chaque changement de type d'état le compteur max_check_attempts se reinitialise.
                            
                            On peut récupérer le type d'un état grâce à ces MACRO:
                                $HOSTSTATETYPE$
                                $SERVICESTATETYPE$

                            - Soft state:

                                Determiné par:
                                    non-OK ou non-UP et le nombre de contrôle n'a pas dépassé le max_check_attempts. (= soft error)
                                    récupéré d'un état précédent à soft (= soft recovery)
                                Déclenche:
                                    Log
                                    Gestionnaire d'evenement
                                    incrémentation de max_check_attempts

                                Le gestionnaire d'evenement pourra nous aider à ce que le probème ne monte pas d'un niveau.


                                Pour activer les logs des état SOFT: 
                                    log_service_retries
                                    ou
                                    log_host_retries

                            - Hard state:
                                
                                Determiné par:
                                    non-UP ou non-OK et le nombre de contrôle à dépassé le max_check_attempts. (= hard error)
                                    lorsqu'il y a une transition d'erreur HARD (ex: Warning -> Critical)
                                    lors un état non-OK et que l'hôte est DOWN ou UNREACHABLE
                                    récupération d'un erreur HARD (= HARD recovery)
                                    Quand un contrôle passif est reçu (sauf si l'option 'passive_host_checks_are_soft')
                                Declenche:
                                    
                                    log des état HARD
                                    Appel du gestionnaire d'evenement
                                    notification

                        Changement d'état:
                        ``````````````````````````
                            Appel de gestionnaire d'évenement
                            Envoie de notification
                            Appel de contrôle d'hôte
                            Gestion du flapping des états supprimant les spam de notifications. (En attendant la stabilisation de l'état)

                            exemple sur:
                                https://shinken.readthedocs.org/en/latest/05_thebasics/statetypes.html#example
                
                            Envoie d'un recovery lors du passage d'un état HARD à SOFT

                        Gestionnaire d'evenement
                        ``````````````````````````
                            https://shinken.readthedocs.org/en/latest/07_advanced/eventhandlers.html#advanced-eventhandlers
                            Il est appelé lors de changement d'état

                        Notification
                        ``````````````````````````
                            https://shinken.readthedocs.org/en/latest/05_thebasics/notifications.html#thebasics-notifications
                            https://shinken.readthedocs.org/en/latest/07_advanced/escalations.html#advanced-escalations

                            C'est dans le bloc host ou service que l'on définit l'envoie de notification.

                            On envoie une notification lors d'un changement d'état ou l'orsque l'état reste en HARD (non-OK) et que l'intervalle de temps définit dans 'notification_interval' est finit.

                            Les notifications sont envoyées aux différents groupes de contacts définit par 'contact_groups' (contenant un ou plusieurs contact)
                            Il gère lui même les doublons de contact.
                            Un filtre est applicable pour ne pas envoyer certain notification à tout les contacts.

                            Le premier filtre étant l'envoie ou non d'une notification:
                                'enable_notifications'
                            Le deuxième filtre ce situe au niveau de l'hôte ou des services (plusieurs options sont vérifiées)
                                Si pendant le contrôle on se trouve dans une periode de 'scheduled downtime', alors aucune notification ne sera envoyée.
                                
                                Ensuite shinken vérifie si il n'y a pas de flapping
                                On arrive sur l'option 'host/service-specific' définissant selon l'état si il y a envoie ou non des notifications.
                                Il vérifie aussi la variable 'notification_period' (il attent la prochaine période de notification)
                                Arrive la 'notification_interval' définissant l'intervalle entre chaque notification.

                            Le troisième filtre concerne les contacts
                                Voir option de notif en fonction de l'état d'un test
                                puis notification_period

                            Les méthodes de notification:
                                pages,sms,email,message instantané, audio ...
                                IL faut pour cela paramétrer la commande de notification:
                                    https://shinken.readthedocs.org/en/latest/08_configobjects/command.html#configobjects-command
                                    Voir les conf dans notificationways et dans commands/notify*

                            La macro $NOTIFICATIONTYPE$
                                Les types de problèmes sont répertorié ici:
                                https://shinken.readthedocs.org/en/latest/05_thebasics/notifications.html#notification-type-macro

                __________________________
                TimePeriods:

                    Permet d'effectuer une action en fonction d'un temps donné.

                    Definition:
                        https://shinken.readthedocs.org/en/latest/08_configobjects/timeperiod.html#configobjects-timeperiod

                        Au niveau des hôtes et services:
                        ``````````````````````````
                            Pour l'activer on utilise l'option:

                                check_period MA_PERIODE

                            Les contrôle seront effectuer uniquement pendant la periode donnée. (sauf pour les checks sur demande)
                            Un service herite d'une periode de temps uniquement si il n'a pas été définit.
                            Si on veux désactiver les notifications durant une periode de temps, il faudra commenter 'notification_period' et/ou 'notification_enabled'.

                        Au niveau des notifications
                        ``````````````````````````
                            period_notification MA_PERIODE
                            Permet de determiner quand peut on envoyer une notification.
                            On peut aussi le faire au niveau d'un contact avec:
                                service_notification_period
                                host_notification_period

                            Pour l'escalade de notification, on utilise la variable 'escalation_period'
                                
                        Au niveau des dépendances
                        ``````````````````````````
                            On influt sur le paramètre 'dependency_period'
                __________________________
                Hosts:

                        Checks sur demande
                        ``````````````````````````
                            -Sur changement d'état
                            -Sur la logique d'accessibilité des hôtes
                            Note: les contrôle de dépendances prédictifs ne sont plus gérés
                            

                        dependances:
                        ``````````````````````````
                            Gerer les checks en fonction de l'état de certain host	

                            todo:
                                https://shinken.readthedocs.org/en/latest/08_configobjects/hostdependency.html#configobjects-hostdependency

                        états
                        ``````````````````````````
                            https://shinken.readthedocs.org/en/latest/05_thebasics/networkreachability.html#thebasics-networkreachability

                            En fonction du résultat du plugin:

                            UP (ok)
                            DOWN (warning, unknown, critical, l'hôte parent est UP et l'état précédent de l'hôte était DOWN)
                            UNREACHABLE (si l'état précédent de l'hôte est down et que ces parent sont DOWN ou UNRECHABLE)


                __________________________
                Services:

                        Checks sur demande
                        ``````````````````````````
                            Il n'y en aurait apparament pas d'après la doc
                            Sachant que les checks de dépendance prédictif ne sont plus gérés
                            A voir donc

                        dependances:
                        ``````````````````````````
                            Gerer les checks en fonction de l'état de certain services

                            todo:
                                https://shinken.readthedocs.org/en/latest/08_configobjects/servicedependency.html#configobjects-servicedependency

                        états
                        ``````````````````````````
                            Donné en fonction du plugin:

                            OK/WARNING/UNKNOWN/CRITICAL
                    
                __________________________
                Types de contrôles:

                        Actifs
                        ``````````````````````````
                            Notion de pull d'info

                            Ils sont lancé directement par les process shinken.
                            Shinken execute ainsi un plugin qui sera chargé de vérifier l'état d'un service ou d'un hôte et renverra les infos formatées pour shinken.
                            Exécuté soit régulièrement soir sur demande.

                            HARD state: check_interval
                            SOFT state: retry_interval

                        Passifs
                        ``````````````````````````
                            Notion de push d'info

                            Lancé depuis un process externe, les résultats sont envoyés aux process shinken.

                            On l'utilise surtout pour des problèmatiques de fiewalling mais aussi sur des hôtes qui ne sont pas régulièrement UP par exemple.
                            Ainsi que dans des configuration distribuées et redondante.

                            Les SNMP trap en sont un bon exemple.
                            Utile aussi pour une plus grande précision (l'hôte peut par exemple contrôler ses logs en temps réel et envoyer ces infos directement à shinken lorsqu'il rencontre une alerte)

                            Fonctionnement:
                                L'application externe contrôle l'état de l'hôte ou du service.
                                Elle écrit les résultat dans un pipe: 'external command named pipe' (pas d'IO Disk).
                                Shinken li le pipe et le place dans sa file d'attente en attente d'être lu.
                                Il scan ensuite les résultats de cette fil pour les envoyer au bon process qui s'occupera d'envoyer les notifications.
                                

                            Accepter un contrôle passif:

                                accept_passive_service_checks 1 (nagios.cfg)
                                passive_checks_enabled 1 (à mettre dans chaque définition d'hôte et service)
                                
                            Envoyer le résultat d'un contrôle de service:

                                L'application doit écrire un 'PROCESS_SERVICE_CHECK_RESULT' vers le pipe de commande externe. (= un descripteur de fichier)
                                https://shinken.readthedocs.org/en/latest/07_advanced/extcommands.html#advanced-extcommands
                                https://shinken.readthedocs.org/en/latest/03_configuration/configmain.html#configuration-configmain-command-file
                                https://shinken.readthedocs.org/en/latest/07_advanced/volatileservices.html#advanced-volatileservices	
                                
                                Note: Il faut bien entendu avoir configuré un service pour que shinken puisse accépter de lire les résultat envoyés.


                                Syntaxe de la commande externe:
                                     “[<timestamp>] PROCESS_SERVICE_CHECK_RESULT;<configobjects/host_name>;<svc_description>;<return_code>;<plugin_output>”
                                timestamp:  temps auquel le contrôle c'est exécuté
                                host_name: le nom de l'hôte associé au service
                                svc_description: description fournit dans la définition du service
                                return_code: Le code retour du contrôle:
                                    0: OK
                                    1: Warning
                                    2: CRITICAL
                                    3: UNKNOWN

                                plugin_output: texte de sortie de la commande
                                    

                            Envoyer le résultat d'un contrôle d'hote:

                                Commande:
                                    “[<timestamp>]PROCESS_HOST_CHECK_RESULT;<configobjects/host_name>;<configobjects/host_status>;<plugin_output>” 

                                    host_status:
                                        0:UP
                                        1:DOWN
                                        2:UNREACHABLE

                                Attention, par défaut shinken ne va pas pouvoir determiner de lui même si l'hôte est down ou injoignable.
                                Pour cela il faut utiliser la traduction des contrôle passif d'hôte:
                                    https://shinken.readthedocs.org/en/latest/07_advanced/unused-nagios-parameters.html#advanced-unused-nagios-parameters-translate-passive-host-checks
                                Note: les état seront considérés comme 'HARD' sauf si on rajoute l'option 'passive_host_checks_are_soft'

                            Envoyer le resultat d'un contrôle depuis un hôte
                                
                                Il faut pour cela mettre en place un agent coté client et le daemon coté serveur qui l'écoute.

                                exemple de protocoles/méthodes:
                                    NSCA, TSCA, Shinken WebService ...


        --------------------------
        Les dépendances
        --------------------------

            https://shinken.readthedocs.org/en/latest/07_advanced/dependencies.html#advanced-dependencies


        --------------------------
        Modules d'acquisition actif
        --------------------------

            https://shinken.readthedocs.org/en/latest/05_thebasics/active-module-checks.html#overview

            Lancé par shinken, il permet d'optimiser l'acquisition de données de protocols spécific et est à préférer aux appels répétés de scripts.

                Au lieu d'être externe au poller, il en font partie en tant que module.

            Exemples:

                - SnmpBooster
                - nrpeBooster
                    http://shinken.io/package/booster-nrpe

        --------------------------
        Dépendances et leurs impacts
        --------------------------

                Voir aussi: https://shinken.readthedocs.org/en/latest/07_advanced/advanced-dependencies.html#advanced-advanced-dependencies

                __________________________
                Réseau:

                    Pour que shinken distingue clairement si l'état d'un service ou d'un hôte est DOWN ou UNREACHABLE, il faut définir une relation parent/enfant.
                    On le fait naturellement en fonction du nombre de saut à parcourir pour atteindre un hôte. (le switch étant considéré comme un saut)

                    On le transcrit ensuite dans la conf avec la variable 'parents':
                            > parents	parentHostName

                    Ainsi lorqu'un parent est DOWN, il considéra ces enfants commes UNREACHABLE.
                    Note: dans le cas où l'on définit plusieurs parent, il faut que ces derniers soient tous DOWN ou UNREACHABLE pour que l'enfant soit sonsidéré comme UNREACHABLE.

                    Il faut dailleur pour éviter les flood des notifications d'hôte injoignable exclure 'unreachable' de l'option 'notification_options' du block host ou de l'option 'host_notification_options' du bloc contact.

                    Note: shinken envoie des notifications uniquement pour les problèmes racines. (celle qui en est à l'orgine)
                    Note : il n'enverra donc pas les notifcations pour les services
                __________________________
                Logiques:

                    Il est aussi possible d'établir une dépendance entre service et hôte et donc définir le comportement que doit adopter un contrôle si tel et tel service est DOWN et qu'il dépent d'un service ou d'un hôte ...

                        Au niveau d'un service
                        ``````````````````````````

                            Il peut dépendre d'un ou plusiurs services
                            IL peut dépendre d'un service qui est installé sur un autre hôte
                            Il est possible d'utiliser les dépendances avancées de service pour déclencher des contrôles et notifications (pendant la timeperiods)

                            Définir une dépendance simple avancée:

                            define service{
                                host_name monHostName
                                secrive_description MonService
                                service_dependencies   otherHostName,otherService
                            }

                            Note: on peut définit plusieur couples Hote,service:
                                host,service,host2,service2

                            Le service 'MonService' dépendera donc du service 'otherService' de l'hôte 'otherHostName'.
                            Ce qui implique que si le service parent est dans un état DOWN, il n'y aura de notification pour le service enfant.
                            Si il y a une erreur sur le service enfant, il lancera les contrôles sur les services parents jusqu'a ce qu'il tombe sur l'origine de la panne. (ce fait de manière récursive avec l'héritage)

                            Note:
                                Si le service est down à cause d'un hôte, il levera une alerte en tant qu'"impact" et une notification 'host problem'

        --------------------------
        Tester 
        --------------------------

            https://shinken.readthedocs.org/en/latest/04_runningshinken/verifyconfig.html
            
            > shinken-arbiter -v -c /path/conf/a/tester -c path2....
                        


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        http://shinken.readthedocs.org/en/latest/02_gettingstarted/installations/shinken-installation.html#requirements

        --------------------------
        Prérequis
        --------------------------

            #Paquets recommandés:
                > apt-get install python2.7 python-pycurl python-setuptools python-cherrypy3

            #Plugins:
                > apt-get install nagios-plugins

                Voir aussi les liens suivants (optionnel):
                    #https://www.monitoring-plugins.org/download.html
                    > wget https://www.monitoring-plugins.org/download/monitoring-plugins-2.1.1.tar.gz

            #user:
                > adduser shinken

        --------------------------
        Via pip
        --------------------------

            > apt-get install python-pip
            > pip install shinken

        --------------------------
        Via les sources
        --------------------------

            > wget http://www.shinken-monitoring.org/pub/shinken-2.2.tar.gz
            > tar -xvzf shinken-2.2.tar.gz
            > cd shinken-2.2
            > python setup.py install

        --------------------------
        Mongodb
        --------------------------

            > apt-get install mongodb python-pymongo
            > shinken install mongodb
            > shinken install mod-mongodb

        --------------------------
        Livestatus
        --------------------------
            
            > shinken install livestatus
            > shinken install logstore-mongodb #si on choisi mongodb pour stocker les logs

            Ne pas oublier de changer de module:

                > vim /etc/shinken/modules/livestatus
                    
                    modules     logstore-mongodb

        --------------------------
        L'interface Web
        --------------------------

            > shinken install webui

            (necessite mongodb et livestatus)

            https://shinken.readthedocs.org/en/latest/11_integration/webui.html

            Notes:

                Shinken inclu shinken WebUI qui permet de lancer de façon autonome son interface web grâce à un process python. (basée sur livestatus)

                Il est possible d'implémenter d'autre interface comme Thruk
                Ou bien même d'en implémenter plusieur.


            __________________________
            Choisir le type d'auth:
                
                > shinken search auth

                #auth contacts shinken:

                    > shinken install auth-cfg-password

                Ne pas oublier de l'activer dans la conf de webui (voir ci-dessous)

            __________________________
            Paramétrer le socket d'écoute:

                > vim /etc/shinken/modules/webui.cfg
                
                Par défaut: 0.0.0.0 écoute sur toutes les interfaces définit au niveau du broker.

                à changer par l'interface d'écoute:

                    host 0.0.0.0
                    port 7767

            __________________________
            Activer l'interface:

                > vim /etc/shinken/brokers/broker-master.cfg

                    modules webui, ...
            
            __________________________
            Activer l'authentification:

                > vim /etc/shinken/modules/webui.cfg
                
                    modules mongodb, auth-cfg-password

            __________________________
            Implémenter des graphes:
            
                Todo (PNP, Graphit)

            __________________________
            Redémarrer les process shinken:

                > service shinken restart

            __________________________
            Accéder à l'interface:

                    par défaut sur le port 7767
                    login/mdp : admin/admin

                    (Note: il ne faut pas oublier d'installer MongoDB)


        --------------------------
        Activer au démarrage
        --------------------------

            > update-rc.d shinken defaults	

            (Pour redhat : chkconfig shinken on)

        --------------------------
        Démarrer le service
        --------------------------
                __________________________
                Une de ces commandes:

                    > /etc/init.d/shinken start
                    > service shinken start
                    > systemctl start shinken

                __________________________
                Manuellement (chaque daemon)

                    ./bin/shinken-scheduler -c /etc/shinken/daemons/schedulerd.ini -d
                    ./bin/shinken-poller -c /etc/shinken/daemons/pollerd.ini -d
                    ./bin/shinken-broker -c /etc/shinken/daemons/brokerd.ini -d
                    ./bin/shinken-reactionner -c /etc/shinken/daemons/reactionnerd.ini -d
                    ./bin/shinken-arbiter -c /etc/shinken/shinken.cfg -d
                    ./bin/shinken-receiver -c /etc/shinken/daemons/receiverd.ini -d

~~~~~~~~~~~~~~~~~~~~~~~~~~
Update
~~~~~~~~~~~~~~~~~~~~~~~~~~

	Mettre à jour shinken:

	1) Backup de la conf
	2) Install du shinken, et remplacement de la conf

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Shinken cli
        --------------------------

            Si il y a une erreur de type 'missing path or cli'
            Il faut penser à initialiser shinken:

            > shinken --init
            
            Lister ensuite les commandes:

            > shinken --list

        --------------------------
        Exécuter des contrôles
        --------------------------

            On execute des check sur les hôtes (ou en local) en appelant les commandes de contrôles.

                __________________________
                Localiser les check:

                    La plupart des commandes sont définits dans:
                        /usr/lib/nagios/plugins

                    Référencé par la variable $NAGIOSPLUGINSDIR$ définit dans /etc/shinken/resource.d/paths.cfg
                
                __________________________
                Créer une commande:

                    On définit une commande qui sera appelée lors des contrôles d'hôte ou de service:

                    Exemple:

                        > vim /etx/shinken/commands/check_dig.cfg

                        define command {
                            command_name    check_dig
                            command_line    $NAGIOSPLUGINSDIR$/check_dig -H $HOSTADDRESS$ -l $ARG1$
                        }



                    Toute les variables seront substituées en fonction des hôtes paramètres définits ci-après.

                    /!\ L'output de ces commandes doivent être au format Nagios:
                        
                        ex: 

                            DISK OK - free space: / 3326 MB (56%); | /=2643MB;5948;5958;0;5968/ 15272 MB (77%);/boot 68 MB (69%);/home 69357 MB (27%);/var/log 819 MB (84%); | /boot=68MB;88;93;0;98/home=69357MB;253404;253409;0;253414 /var/log=818MB;970;975;0;980


                    Note: la commande pourra être éxécutée directement ou par l'intermédiaire d'un agent de type NRPE.


                __________________________
                Définir un hôte:

                    Pour appliquer un contrôle sur un hôte il faudra le définir:

                    > vim /etc/shinken/hosts/serverX.cfg

                        define host{
                            use                     generic-host
                            contact_groups          admins
                            host_name               serverX
                            address                 10.X.X.X               
                        }

                    Note: on peut appeler un modèle avec le paramètre 'use'.
                    
                        Toute les paramètres définits dans ce modèle seront appliqué, comme la fréquence des contrôles effectués, le check de base à effectuer (ping par défaut).

                        Les templates sont définits dans le dossier 'templates'.

                __________________________
                Exécuter un contrôle (définir un service):

                    Pour exécuter un contrôle, on le définira dans le dossier service.

                    C'est ici que nous allons appeler la plupart de nos check

                    > vim /etc/shinken/services/foo_control.cfg

                        define service {
                            host_name               serverX
                            service_description     Disk
                            check_command           check_nrpe!check_disks
                            use                     generic-service
                        }

                    /!\ cette commande est exécutée via nrpe mais on pourrait très bien l'éxécuter directement en local.

                    ex:

                        check_command   check_disks


        --------------------------
        Les hôtes
        --------------------------

            Nous allons effectuer nos tests directement sur ces hôtes distant.

            On check les templates dans /etc/shinken/templates pour les rendre les plus generic possible.

                __________________________
                Les serveur Linux:

                    > vim /etc/shinken/hosts/cucumber

                    define host{
                        use 		generic-host
                        host_name	cucumber
                        address		10.10.1.7
                    }

                    > vim /etc/shinken/hostgroups/linux.cfg

                    define hostgroup{
                        hostgroup_name	linux
                        alias		Linux Servers
                        members		cucumber
                    }


                __________________________
                Les routeurs:

                    (TODO)

                    > vim /etc/shinken/hosts/cisco7200

                    define host{
                        use 		generic-router
                        host_name	cisco7200
                        address		10.10.1.254
                    }

                    > vim /etc/shinken/hostgroups/ciscoRouter.cfg

                    define hostgroup{
                        hostgroup_name	ciscoRouter
                        alias		Cisco Router
                        members		cisco7200
                    }

                
        --------------------------
        Contacts
        --------------------------

            Ce sont les personnes qui seront informées des remontées d'erreur de nos hôtes.

            TODO avec le choix de la méthode d'envoi

            >

        --------------------------
        Services
        --------------------------

            Ce sont les différents services que nous allons tester sur nos hôtes.

            define service {
                hostgroup_name          serveur-linux
                service_description     Disk
                check_command           check_nrpe!check_disks
                use                     generic-service
            }

        --------------------------
        Commandes 
        --------------------------

            Ces objets définissent clairement la commande à appeler lors d'un contrôle avec les arguments ...

        --------------------------
        Plugins
        --------------------------

            C'est la nommination des fichier de contrôles, des commandes à éxécuter.

                __________________________
                Exemple de de récupération de checks:

                    wget http://www.nagios-plugins.org/download/nagios-plugins-2.0.1.tar.gz

                    On installe les plugins (soit on l'intègre directement dans les plugins de shinken soit on les met à part dans les plugins Nagios (voir le path $NAGIOSPLUGINSDIR$ définit dans resource.d)

                    mkdir /usr/lib/nagios
                    ./configure --prefix=/usr/lib/nagios --with-nagios-user=shinken --with-nagios-group=shinken

                    Note: Sur la version RC de shinken, il peut y avoir des petites 'erreurs' sur les macro PLUGINS, il faut parfois remplacer $PLUGINSDIR$ par $NAGIOSPLUGINSDIR$ pour plus de cohérence.

                    > make all		#on compile
                    > make install		#on install

                    > vim /etc/shinken/resource.d/paths.cfg

                        $NAGIOSPLUGINSDIR$=/usr/lib/nagios/libexec

                    On fix les MACRO pour les commandes check_ping et check_host_alive en remplacceant $PLUGINSDIR$ par $NAGIOS...

                On peut aussi passer par les repo:

                    > apt-get install nagios-plugins

                    Note: Dans ce cas il n'y aura pas d'install dans libexec, le path au niveau de la MACRO devrait être bon du coup.

                __________________________
                Port d'écoute:

                    Les requêtes sont envoyées par défaut sur le port 5666 de l'hôte distant


        --------------------------
        Checks
        --------------------------

            Le choix de la méthode de check se fait notament en fonction de l'architecture à superviser de sa roblématique.
                __________________________
                Check SNMP (actif):

                        Coté agent:
                        ````````````````````````````

                            > apt-get install snmpd
                            > vim /etc/snmp/snmpd.conf

                __________________________
                Check NRPE (actif):

                    Méthode active:

                        Shinken demande à l'agent distant d'éxécuter les commandes.

                        Installation du plugin:
                        ````````````````````````````

                            > wget http://prdownloads.sourceforge.net/sourceforge/nagios/nrpe-2.15.tar.gz
                            > ./configure --with-nagios-user=shinken --with-nagios-group=shinken --libexecdir=/var/lib/shinken/libexec --enable-libtap --enable-extra-opts --enable-perl-MODULES --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu
                        
                            > make all
                            > make install-plugin

                            Note: il faudra surement installer libssl-dev

                        Install du serveur nrpe coté client:
                        ````````````````````````````

                            > apt-get install nagios-nrpe-server nagios-plugins

                            On écrit ensuite les tests appelés par le serveur de supervision, c'est à dire les tests appelés apprès le '!' : (ex: check_nrpe!check_disks )

                            Exemple:
                        
                                > vim /etc/nagios/nrpe.d/check_disks.cfg

                                    command[check_disks]=/usr/lib/nagios/plugins/check_disk -w 5% -c 2% -X proc -X none -X devpts -X udev -X usbfs -X tmpfs

                            Filtrer les hôtes autorisés à faire des check nrpe:

                                > vim /etc/nagios/nrpe.cfg

                                    allowed_hosts=127.0.0.1,10.10.10.10

                            On redémare le daemon:

                                > service nagios-nrpe-server restart
                __________________________
                Check NSCA (passif):

                    Méthode passive:

                        L'hôte envoi des informations à shinken au travers d'un script.

        --------------------------
        Modules
        --------------------------

            http://www.shinken.io/

            Les modules vont permettre à shinken d'étendre ses fonctionnalités. 
                __________________________
                Importer un module:

                    à partir de la 2.0 il n'y a plus de module chargé par défaut.
                    il faut les demander explicitement

                    > shinken search monModule
                    > shinken install monModule

                    Il suffira de l'ajouter ensuite dans un objet:
                        modules 	monModule1,monModule2 ...
                __________________________
                Créer un module:

                    vim modules_NOM_MODULE.cfg
                    
                    define module{
                        module_name MON_MODULE
                        module_type TYPE
                        PARAMETRES
                    }
                    
                    On l'appel ensuite dans notre objet:
                    module MON_MODULE
                __________________________
                Afficher les modules disponibles:

                    > shinken inventory

                __________________________
                Note:

                    La conf des modules est définit par défaut dans shinken/modules
                    Les binaires et script du module sont quand à eux définit dans /var/lib/shinken/modules

                    Les type de module font référence aux types définits dans directement dans le code source du module.
