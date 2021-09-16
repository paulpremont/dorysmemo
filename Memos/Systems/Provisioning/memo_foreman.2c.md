==========================================================
                       F O R E M A N
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Site officiel:

        http://theforeman.org/
        http://projects.theforeman.org/projects/foreman/wiki/Howtos

    Docs:
        
        http://theforeman.org/manuals/1.8/index.html#1.Foreman1.8Manual

    Tutos:

        https://www.digitalocean.com/community/tutorials/how-to-use-foreman-to-manage-puppet-nodes-on-ubuntu-14-04

    Pxe :

        http://projects.theforeman.org/projects/foreman/wiki/Unattended_installations

    Articles connexes:

        http://tech-pills.gabrielsambarino.com/foreman-vs-puppet-dashboard/


~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Foreman est un outils de gestion de cycle de vie d'ordinateur.

    Il apporte une interface permetant d'automatiser les tâches courante, déployer des applications et de monitorer l'application des configurations.

    Il peut s'interfacer avec un outil de provisioning comme Puppet.

    /!\ Foreman peut faire doublon avec la dashboard Puppet et vous "empechera d'utiliser hiera avec puppet"

    Note :

        Le gros désavantage de Foreman, c'est qu'il n'est pas possible de versionner simplement les configurations.
        Tout est en base.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Foreman utilise un système de "Smart Proxy" pour lancer ses actions sur les différents hôtes.
        --------------------------
        Architecture
        --------------------------

            http://theforeman.org/manuals/1.8/index.html#ForemanArchitecture

            Foreman envoi ses requêtes aux smart-proxy executant les différentes actions telles que l'allocation d'adresse, la gestion des appels puppet ...

            Il nourit une base (sqlite par défaut) et produit des rapports (avec les infos donnés par puppet).

            Le tout pilotable pas une WUI.

        --------------------------
        Workflow
        --------------------------

            http://theforeman.org/manuals/1.8/index.html#4.4.6Workflow
            http://www.theforeman.org/static/images/diagrams/foreman_workflow_final.jpg

        --------------------------
        Application des changements
        --------------------------

            Lorsqu'on apporte des changements sur les templates et autres fichiers impactants les hôtes, 
            Il ne faut pas hésiter à les rebuilder pour que les 'triggers' se facent.

            (Cancel build -> build )

        --------------------------
        Tour d'horizon sur les features Foreman et son menu
        --------------------------
                __________________________
                Monitor :

                __________________________
                Hosts :

                        hosts :
                        ``````````````````````````
                            
                            - All :

                                Liste complète de tous les hôtes présent en configuration.
                                Permet d'éditer, cloner et supprimer les hôtes configurés.

                            - New :
                                
                                Ajouter un nouvel hôte from scratch.

                        Provisioning setup :
                        ``````````````````````````

                            - Operating System :

                                Un OS est définit par son nom, la table de partition à installer, le media à utiliser et quels modèles (fichier de boot PXE) à appliquer.

                            - Provisioning templates :

                                On y définit tous les fichier nécessaire au boot over PXE,
                                à savoir les preseed ou kickstart par exemple, avec le menu PXE, le fichier de configuration d'installation (preseed, kickstart ...) de l'OS et les scripts custom à appliquer (exemple: configuration de l'agent puppet).

                            - Partition tables :

                                On définit la manière dont on va partitionner l'hôte.
                                C'est un morceau du preseed ou kickstart. (Par exemple utilisation de LVM, nombre de partitions ...)

                            - Installation media :

                                Ce sont les liens utilisés par les hôtes lors du build pour charger le media d'installation.

                            - Hardware models :

                                Une simple information pour catégoriser les types de support pour les hôtes. (VM, machine physique ...)

                            - Architectures :

                                Informations concernant le type d'architecture des hôtes.

                __________________________
                Configure :

                        Host groups :
                        ``````````````````````````

                            On y définit les classes à appliquer pour un groupe particulier.
                            Permet de faire de l'héritage de classe.

                        Global parameters :
                        ``````````````````````````

                            Définition des paramètres (variables) héritées dans toutes les classes puppet.

                        Puppet :
                        ``````````````````````````

                            - Environments :

                                Ce sont les environements puppet (il faut les créer au préalable au niveau de puppet).

                            - Puppet classes :

                                Toutes les classes importées des différents environements.

                            - Config groups :

                            - Smart Variables :

                                On retrouve en vrac, tous les paramètres de classes 

                __________________________
                Infrastructure :

                __________________________
                Administer :


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Forman Installer (recommandée)
        --------------------------

            Il s'occupera de lancer l'installation d'un puppetmaster, d'apache avec passenger, et de Smart Proxy.
            Il utilise puppet pour installer les composants Foreman avec notament:

                - Foreman WUI
                - Passenger
                - TFTP, DNS et DHCP (optionnellement)

                    --foreman-proxy-dhcp=true
                    --foreman-proxy-tftp=true
                    --foreman-proxy-dns=true

            Note: 

                si vous préférez utiliser Nginx:

                http://projects.theforeman.org/projects/foreman/wiki/Setting_up_Nginx_+_Passenger_

            Concernant smartProxy:

                http://theforeman.org/manuals/1.8/index.html#4.3SmartProxies

                __________________________
                Foreman :

                    Il faut au préalable configurer le hostname pour qu'il soit au moins dans un domaine:

                        > hostname foretout.local

                        La commande 'hostname -f' doit retourner le même résultat que 'facter fqdn'

                    (Sur une Debian 8) :

                        Prérequis :

                            S'assurer que les locales soient configurée pour ne pas avoir d'erreur au niveau de postgresql :

                            > voir issue locales
                            
                            et relancer le build du cluster postgre :

                            > pg_createcluster 9.4 main --start

                        /!\ changer le umask : 

                            > umask 0022

                        Install des repo puppet et foreman :

                            > apt-get -y install ca-certificates
                            > wget https://apt.puppetlabs.com/puppetlabs-release-jessie.deb
                            > dpkg -i puppetlabs-release-jessie.deb

                            > echo "deb http://deb.theforeman.org/ jessie 1.8" > /etc/apt/sources.list.d/foreman.list
                            > echo "deb http://deb.theforeman.org/ plugins 1.8" >> /etc/apt/sources.list.d/foreman.list
                            > wget -q http://deb.theforeman.org/pubkey.gpg -O- | apt-key add -

                        Download de l'installeur :

                            > apt-get update && apt-get -y install foreman-installer

                            > foreman-installer --foreman-proxy-dhcp=true --foreman-proxy-dns=true

                            Pour voir toutes les options disponibles:

                                > foreman-installer --help

                    Vous devriez avoir en output :

                        Success!
                        * Foreman is running at https://foretout.local
                            Initial credentials are admin / **password**
                        * Foreman Proxy is running at https://foretout.local:8443
                        * Puppetmaster is running at port 8140
                        The full log is at /var/log/foreman-installer/foreman-installer.log

                        Revoir les credentials:

                            > cat /root/.hammer/cli.modules.d/foreman.yml

                    Start de Foreman au boot:

                        > vim /etc/default/foreman

                            START=yes
                __________________________
                Niveau puppet:

                    On Créer ensuite notre premier hôte dans Foreman:

                        > puppet agent --test

                        Note:

                            "Puppet 3+ will show a warning the first time that the node can't be found, this can be ignored."

                    Il suffit maintenant de se connecter à l'IHM avec les credentials fournits:

                        > https://monForemanHost.monDomain

                    Installation de la classe NTP pour la gestion du NTP:

                        > puppet module install -i /etc/puppet/environments/production/modules saz/ntp

                        Le module s'installera normalement dans:

                            /etc/puppet/environments/production/modules/ntp


                    Importation de la classe dans la DB de foreman:

                        > Configure/Puppet classes -> Import from myHostname -> Cochez la classe NTP et Update de la DB.

                        Un fois importé, cliquez sur la classe "ntp" dans la liste des puppet classes, puis cliquez sur l'onglet Smart Class Parameter

                        Pour ensuite modifier la liste des serveurs NTP, il faut cliquer sur le paramètre 'server_list'

                        Pour que Foreman prenne l'ascendant sur les données, il faut cocher 'override' et modifier enfin les valeurs.

                        (Un peu comme hiera dans le principe)

                        exemple:

                            ["ntp.ilianum.com","ntp1.jussieu.fr","2.pool.ntp.org","3.pool.ntp.org"]

                        Note: 

                            temps que le paramètre est en override, même si on update une classe avec de nouveaux paramètres par défaut,
                            Foreman gardera les paramètres qu'il a en mémoire. (Sauf si on supprime un paramètre directement dans une classe).

                    Application de la classe NTP sur l'hôte local:

                        Dans l'onglet 'All Hosts' de Foreman, 
                        Editer l'host 
                        Dans l'onglet Puppet Classes
                        cliquez sue le '+' correspondant au module NTP et importer la classe ntp (toujours avec le '+')
                        Puis Submit

                        Enfin on retourne sur la description de l'hôte.

                        Le bouton 'YAML' renvoie tout les paramètres de classe ovveridés.

                    Appliquer les changements:

                        > puppet agent --test


        --------------------------
        Depuis les packages:
        --------------------------

            http://theforeman.org/manuals/1.8/index.html#3.3InstallFromPackages
            http://theforeman.org/manuals/1.8/index.html#3.3.3DebianPackages

        --------------------------
        Depuis les sources:
        --------------------------

            http://theforeman.org/manuals/1.8/index.html#3.4InstallFromSource

            Paquets requis :

                Pour la base de données:

                    mysql-devel ou postgresql-devel ou sqlite-devel.

                Pour le reste:

                    gcc, ruby-devel, libxml-devel, libxslt-devel, libvirt-devel

        --------------------------
        SmartProxy
        --------------------------

            Note: cette étape n'est pas nécessaire avec l'auto installer de foreman.

            http://theforeman.org/manuals/1.8/index.html#4.3.1SmartProxyInstallation
            http://theforeman.org/manuals/1.8/index.html#4.3SmartProxies
            http://projects.theforeman.org/projects/smart-proxy/wiki/API

            Le but étant de founir une API pour des systèmde de plus haut niveau comme foreman, 
            communiquant via du Json.

            Il va permettre d'éxécuter des fonctions sur les hôtes qui recevront les requetes de foreman.

                Depuis les sources
                ``````````````````````````

                    > git clone https://github.com/theforeman/smart-proxy.git

                Depuis les packages
                ``````````````````````````
                    Voir la section installation de Foreman depuis les packages.

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Réseau
        --------------------------
                __________________________
                Firewall:

                    
                    Port        Protocol    Required For

                    53          TCP & UDP   DNS Server
                    67, 68      UDP DHCP    Server
                    69          UDP * TFTP  Server
                    80, 443     TCP * HTTP & HTTPS access to Foreman web UI - using Apache + Passenger
                    3000        TCP         HTTP access to Foreman web UI - using standalone WEBrick service
                    3306        TCP         Separate MySQL database
                    5910 - 5930 TCP         Server VNC Consoles
                    5432        TCP         Separate PostgreSQL database
                    8140        TCP         * Puppet Master
                    8443        TCP         Smart Proxy, open only to Foreman

        --------------------------
        Initialisation
        --------------------------

            http://www.theforeman.org/manuals/1.8/index.html

            Voir le lien ci dessus et selectionner la dernière version ...

                __________________________
                Config globale:

                    /etc/foreman/settings.yaml

                    ou depuis l'interface:

                        Administer/Settings
                __________________________
                Config base de données:

                    http://www.theforeman.org/manuals/1.8/index.html#3.5.3DatabaseSetup

                    /etc/foreman/database.yaml

                    Utilise par défaut sqlite, et est une extension de la base puppet.

                    Initialiser la base de données:

                        > cd && RAILS_ENV=production rake db:migrate
                        
                        ou plus récement:

                        > foreman-rake db:migrate
                        > foreman-rake db:seed

                __________________________
                Options de configurations:

                    http://www.theforeman.org/manuals/1.8/index.html#3.5.2ConfigurationOptions
        --------------------------
        Puppet Reports
        --------------------------


            Foreman utilise sa propres address de puppet reports que puppet devra utiliser pour alimenter la dashboard de Foreman.

                __________________________
                Niveau client:

                    Il faut s'assurer que les clients aient l'option "report = true"

                __________________________
                Niveau master:

                    Note: cette partie ne devrait pas concerner l'autoinstall qui confgure déja les fichiers suivant:

                        processeur de rapports:
                        ``````````````````````````

                            Pour une Debian, on trouve ce fichier dans:

                                /usr/lib/ruby/vendor_ruby/puppet/reports/

                            Copier ensuite la source dans ce dossier vers foreman.rb
                                
                                https://raw.githubusercontent.com/theforeman/puppet-foreman/master/files/foreman-report_v2.rb

                            Exemple:

                                > cd /usr/lib/ruby/vendor_ruby/puppet/reports/
                                > wget https://raw.githubusercontent.com/theforeman/puppet-foreman/master/files/foreman-report_v2.rb -O foreman.rb

                            Note: avec l'autoinstall, le fichier devrait déja être présent.


                        config puppet
                        ``````````````````````````

                            > vim /etc/puppet/foreman.yaml

                            On devrait avoir :

                                # Update for your Foreman and Puppet master hostname(s)
                                :url: "https://foreman.example.com"
                                :ssl_ca: "/var/lib/puppet/ssl/certs/ca.pem"
                                :ssl_cert: "/var/lib/puppet/ssl/certs/puppet.example.com.pem"
                                :ssl_key: "/var/lib/puppet/ssl/private_keys/puppet.example.com.pem"
                                # Advanced settings
                                :puppetdir: "/var/lib/puppet"
                                :puppetuser: "puppet"
                                :facts: true
                                :timeout: 10
                                :threads: null

                            > vim /etc/puppet/puppet.conf

                                reports=log, foreman

                                #ou reports=foreman 

                            > service puppetmaster restart

                        Limiter le nombre de rapport en base:
                        ``````````````````````````

                            #Facultatif:

                            > foreman-rake reports:expire days=7
                            > foreman-rake reports:expire days=1 status=0

        --------------------------
        Facts et ENC
        --------------------------

            Puppet fournie une ENC (External Node interface) qui va permettre notament à Foreman de fournir des variables de configuration et des facts.

            Note: idem, avec l'autoinstall, le script ENC devrait déja être installé.

            Lorsqu'un agent se présente, le script ENC enverra ses facts à Foreman et téléchargera les données de l'ENC.

                __________________________
                Télécharger l'ENC :

                    > wget https://raw.githubusercontent.com/theforeman/puppet-foreman/2.2.3/files/external_node_v2.rb -O /etc/puppet/node.rb
                    > chmod +x /etc/puppet/node.rb

                __________________________
                Activer l'ENC : 

                    > vim /etc/puppet/foreman.yaml        

                        ---
                        # Update for your Foreman and Puppet master hostname(s)
                        :url: "https://foreman.example.com"
                        :ssl_ca: "/var/lib/puppet/ssl/certs/ca.pem"
                        :ssl_cert: "/var/lib/puppet/ssl/certs/puppet.example.com.pem"
                        :ssl_key: "/var/lib/puppet/ssl/private_keys/puppet.example.com.pem"

                        # Advanced settings
                        :puppetdir: "/var/lib/puppet"
                        :puppetuser: "puppet"
                        :facts: true
                        :timeout: 10
                        :threads: null

                    > vim /etc/puppet/puppet.conf

                        [master]
                            external_nodes = /etc/puppet/node.rb
                            node_terminus  = exec

                    > service puppetaster restart
                __________________________
                Tester l'ENC :

                    > sudo -u puppet /etc/puppet/node.rb [the name of a node, eg agent.local]

                    exemple d'output (site off):

                        parameters:
                          puppetmaster: puppet
                          foreman_env: &id001 production
                        classes:
                          helloworld:
                          environment: *id001

                    Pousser les facts manuellement :

                        > sudo -u puppet /etc/puppet/node.rb --push-facts

        --------------------------
        CLI
        --------------------------

            La CLI est basée sur le framework 'hammer'

            La config est localisée dans :

                ./config/hammer/ (config dir in CWD)
                /etc/hammer/.
                ~/.hammer/
                custom location specified on command line - -c CONF_FILE_PATH

        --------------------------
        UPGRADE
        --------------------------

            http://www.theforeman.org/manuals/1.8/index.html#UpgradingtoForeman1.8

        --------------------------
        Smart Proxies
        --------------------------

            Smart Proxy founit une API permetant de dialoguer avec plusieurs sous-sytèmes comme le DHCP, le DNS ...

                __________________________
                DHCP & DNS :

                    Après avoir activer foreman-proxy pour le dns et le dhcp, il est possible de générer une config et de relancer l'installation de foreman.

                    Infrastructure > Provisioning setup

                    L'interface dump la commande et les paramètres pour reconfigurer Foreman.

                    Exemple :

                        foreman-installer \
                          --enable-foreman-proxy \
                          --foreman-proxy-tftp=true \
                          --foreman-proxy-tftp-servername=X.X.X.X \
                          --foreman-proxy-dhcp=true \
                          --foreman-proxy-dhcp-interface=eth0 \
                          --foreman-proxy-dhcp-gateway=X.X.X.X \
                          --foreman-proxy-dhcp-range="X.X.X.X Y.Y.Y.Y" \
                          --foreman-proxy-dhcp-nameservers="X.X.X.X" \
                          --foreman-proxy-dns=true \
                          --foreman-proxy-dns-interface=eth0 \
                          --foreman-proxy-dns-zone=clientsdomain \
                          --foreman-proxy-dns-reverse=X.X.X.in-addr.arpa \
                          --foreman-proxy-dns-forwarders=X.X.X.X \
                          --foreman-proxy-foreman-base-url=https://monforeman.mondomaine \
                          --foreman-proxy-oauth-consumer-key=bHHCWqsdfJoGgqdsfrYMwTpbzbJPA2fQ \
                          --foreman-proxy-oauth-consumer-secret=SxqdsfrGDCqdfvA7LGtUnQ2qds4ZgfGp

                    Note :

                        Les packages : dhcpd, bind9, nsupdate devraient être installés.
                        nsupdate permet de mettre à jour bind sans modifier directement les fichiers de conf de bind.

                        les entrées bind sont auto-générées lorsqu'on ajoute un host :

                            Voir : /var/cache/bind/zones

                __________________________
                DHCP :

                    Permet de requêter le serveur DHCP en checkant les IP disponibles, gérant les leases ...

                    /!\ Pour la partie sous-réseau, c'est puppet-dhcp qui s'en occupe.

                    Activer la gestion du DHCP :

                        > apt-get install isc-dhcp-server
                        > vim /etc/foreman/dhcp.yml

                            :enabled: https
                            :dhcp_vendor: isc
                            :dhcp_config: /etc/dhcp/dhcpd.conf
                            :dhcp_leases: /var/lib/dhcpd/dhcpd.leases

                    Les droits en execution et lecture doivent être donnés sur les fichiers concernés pour l'utilisateur foreman-proxy

                __________________________
                DNS :

                    Permet de mettre à jour et supprimer automatiquement les entrées DNS depuis le serveur DNS.

                    Choisir un provider : 

                        - nsupdate
                        - nsupdate_gss
                        - virsh 
                        - dnscmd

                    Puis configurer le DNS :
                
                        > apt-get install bind9 nsupdate
                        > vim /etc/foreman/dns.yml
                        
                __________________________
                TFTP :

                    > apt-get install tftpd

        --------------------------
        Provisioning - OS
        --------------------------

            Ajouter un nouvel OS, c'est renseigner plusieurs éléments, dont les éléments de configuration pour le boot over PXE.
            Ces éléments sont notament définits à travers les templates de provisioning.

            > Hosts > Operating systems > New Operating system

                __________________________
                Partition table :
                
                __________________________
                Installation media :

                __________________________
                Templates :

                    http://projects.theforeman.org/projects/foreman/wiki/TemplateWriting

                    Ne pas hésitez à consulter le memo_pxe.
                    Foreman utilise exactement le même procédé mais avec le système de templating en ruby en plus.
                    Il permet d'automatiser donc tous ce processus.

                    Il existes plusieurs sortes de templates :

                        - PXELinux : config du menu pxe et du chargement du kernel
                        - Provision : correspond à la préconfig de l'OS (kickstart, preseed)
                        - Finish : Post script d'installation

                        - user_data : Similaire à Finish mais pour d'autres type d'image comme Openstack ...
                        - Script : pour d'autres script custom à lancer
                        - iPXE : Si l'on utilise iPXE à la place de PXELinux.

                    Pour associer des templates à un OS, il faut se rendre sur l'onglet association lors de l'édition d'un template.

                    Voici un exemple des fichiers de provisioning :

                        Avec comme objectif le chargement d'une ISO avec ses packages, puis l'installation d'un repo locale, une fois l'installation finie.
                        Cette aproche permet d'éviter les erreur de clé GPG ou de modifier l'ISO de l'éditeur.
                        Le reste de la configuration étant opérée par puppet, il suffit d'installer uniquement le package puppet.
                        Le repo locale est géré par aptly.


                        PXELinux
                        ``````````````````````````

                            <%#
                            kind: PXELinux
                            name: Foo PXE menu
                            oses:
                            - <DISTRIB> <VERSION>
                            %>

                            DEFAULT 

                            LABEL ubuntu1404
                                KERNEL distribs/<DIST><VERS>/linux
                                APPEND vga=788 auto=true priority=critical url=<%= foreman_url('provision')%> initrd=distribs/<DIST><VERS>/initrd.gz live-installer/net-image=http://mirror.<myDOMAIN>/<DIST><VERS>/filesystem.squashfs -


                        Preseed
                        ``````````````````````````

                            <%#
                            kind: provision
                            name: Foo preseed
                            oses:
                            - <DIST> <VERS>
                            %>
                            <%
                              mirror = "mirror.<myDOMAIN>"
                              extra_repo = "http://mirror.<myDOMAIN>/<DIST><VERS>/extra"
                            %>


                            ### ---------------- Localization ----------------
                            d-i debian-installer/locale string <%= @host.params['lang'] || 'en_US' %>

                            ### ---------------- Keyboard selection ----------------
                            d-i keyboard-configuration/xkb-keymap seen true
                            d-i console-keymaps-at/keymap seen true

                            ### ---------------- Time ----------------
                            d-i clock-setup/utc boolean true
                            # /usr/share/zoneinfo/ for valid values.
                            d-i time/zone string <%= @host.params['time-zone'] || 'UTC' %>
                            # NTP
                            d-i clock-setup/ntp boolean true
                            d-i clock-setup/ntp-server string <%= @host.params['ntp-server'] || '0.debian.pool.ntp.org' %>

                            ### ---------------- Network ----------------
                            d-i netcfg/choose_interface select auto
                            d-i netcfg/get_hostname string <%= @host %>
                            d-i netcfg/get_domain string <%= @host.domain %>
                            d-i netcfg/wireless_wep string

                            ### ---------------- Mirror settings ----------------
                            d-i mirror/country string manual
                            d-i mirror/http/hostname string <%= mirror %>
                            d-i mirror/http/directory string /ubuntu1404
                            d-i mirror/http/proxy string

                            ### ---------------- APT ----------------
                            d-i apt-setup/restricted boolean false
                            d-i apt-setup/universe boolean false
                            d-i apt-setup/backports boolean false
                            d-i apt-setup/proposed boolean false
                            d-i apt-setup/security_host string
                            #d-i apt-setup/local0/repository string http://192.168.200.1/ubuntu/extra trusty main
                            #d-i apt-setup/local0/key string http://192.168.200.1/ubuntu/gpgkey.pub
                            #d-i apt-setup/local0/source boolean false
                            #d-i debian-installer/allow_unauthenticated boolean true

                            # local repo
                            #<% repos = 0 %>
                            #Extra packages :
                            #d-i apt-setup/local<%= repos %>/repository string <%= extra_repo %> <%= @host.operatingsystem.release_name %> main
                            #d-i apt-setup/local<%= repos %>/comment string extra packages
                            #d-i apt-setup/local<%= repos %>/source boolean false
                            #d-i apt-setup/local<%= repos %>/key string <%= extra_repo %>/gpgkey.gpg


                            ### ---------------- Divers ----------------

                            # Set alignment for automatic partitioning
                            # Choices: cylinder, minimal, optimal
                            #d-i partman/alignment select cylinder

                            #<%= @host.diskLayout %>

                            # Install different kernel
                            #d-i base-installer/kernel/image string linux-server

                            ### ---------------- Users ----------------

                            # User settings
                            d-i passwd/root-password-crypted password <%= root_pass %>
                            user-setup-udeb passwd/root-login boolean true
                            d-i passwd passwd/make-user boolean false
                            user-setup-udeb passwd/make-user boolean false


                            ### ---------------- PKGS ----------------
                            d-i pkgsel/include string openssh-server curl
                            d-i pkgsel/upgrade  select safe-upgrade

                            # Install minimal task set (see tasksel --task-packages minimal)
                            #tasksel tasksel/first multiselect minimal, ssh-server, openssh-server

                            # Install some base packagesopenssh-server curl
                            #d-i pkgsel/include string openssh-server curl puppet
                            #d-i pkgsel/update-policy select unattended-upgrades

                            popularity-contest popularity-contest/participate boolean false

                            ### ---------------- Boot loader settings ----------------

                            #grub-pc grub-pc/hidden_timeout boolean false
                            #grub-pc grub-pc/timeout string 10
                            d-i grub-installer/only_debian boolean true
                            d-i grub-installer/with_other_os boolean true
                            <% if @host.params['install-disk'] -%>
                            d-i grub-installer/bootdev string <%= @host.params['install-disk'] %>
                            <% elsif @host.operatingsystem.name == 'Debian' and @host.operatingsystem.major.to_i >= 8 -%>
                            d-i grub-installer/bootdev string default
                            <% end -%>
                            d-i finish-install/reboot_in_progress note

                            ### ---------------- Scripts ----------------
                            d-i preseed/late_command string chroot /target sh -c "/usr/bin/curl -o /tmp/postinstall.sh <%= foreman_url('finish') %> && /bin/sh -x /tmp/postinstall.sh"


                        Finish
                        ``````````````````````````

                            <%#
                            kind: finish
                            name: Foo finish
                            oses:
                            - <DIST> <VERS>
                            %>
                            #----------- VARIABLES ---------------

                            puppetmaster='X.X.X.X'
                            repo="http://mirror.<myDOMAIN>"
                            workdir="/root/postinstall"
                            extra_source="deb $repo/<DIST><VERS>/extra trusty main"
                            iso_source="deb $repo/<dist><vers>  trusty main"
                            gpgkey="$repo/<dist><vers>/extra/gpgkey.pub"
                            output="$workdir/postscript.output"

                            #----------- MAKE WORKDIR---------------

                            echo 'launching the postscript installation' >> $output
                            echo "Make the workdir [$workdir]" >> $output

                            mkdir $workdir
                            cd $workdir

                            #----------- INSTALL REPO ---------------

                            echo 'Update the sources.list' >> $output

                            echo $iso_source > /etc/apt/sources.list
                            echo $extra_source >> /etc/apt/sources.list

                            echo 'Add the gpgkey from the extra repo' >> $output

                            curl -o gpgkey.pub $gpgkey
                            apt-key add gpgkey.pub

                            echo 'Update the repository and install puppet' >> $output

                            apt-get update

                            #----------- INSTALL PUPPET ---------------

                            apt-get install -y puppet

                            #----------- CONFIGURE HOSTNAME ---------------
                            echo 'Configuring hosts' >> $output
                            echo '<%= @host.ip %> <%= @host.shortname %>.<%= @host.domain%> <%= @host.shortname %>' >> /etc/hosts
                            echo "$puppetmaster <%= @host.puppetmaster %>" >> /etc/hosts

                            hostname <%= @host.shortname %>
                            echo '<%= @host.shortname %>' > /etc/hostname

                            echo '<%= @host.ip %> <%= @host.shortname %>.<%= @host.domain%> <%= @host.shortname %>' >> $output

                            #----------- CONFIGURE PUPPET ---------------
                            echo 'Configuring puppet agent' >> $output

                            echo "<%= @host.puppetmaster %>" >> $output

                            /bin/sed -i 's/^START=no/START=yes/' /etc/default/puppet
                            /bin/touch /etc/puppet/namespaceauth.conf
                            /usr/bin/puppet agent --enable
                            /usr/bin/puppet agent --config /etc/puppet/puppet.conf --onetime --tags no_such_tag --server <%= @host.puppetmaster %> --no-daemonize

                            echo "
                            [agent]
                            server =  <%= @host.puppetmaster %>
                            report = true
                            pluginsync = true
                            certname = <%= @host.shortname %>.<%= @host.domain%>
                            runinterval = 3600
                            listen = true
                            " >> /etc/puppet/puppet.conf

                            service puppet restart

                            /usr/bin/wget --no-proxy --quiet --output-document=/dev/null --no-check-certificate <%= foreman_url %>

                            echo 'Postscript finished' >> $output
                            exit 0

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
                    

                    

        --------------------------
        Daemon
        --------------------------

            > service foreman start
            > service foreman-proxy start

            ou si installé depuis les sources:

            > RAILS_ENV=production rails server

                __________________________
                Accès à la WUI:

                    https://foreman_host

                    login : admin
                    pwd : donné à l'install, 

                    Voir: 
                        
                        > cat /root/.hammer/cli.modules.d/foreman.yml


        --------------------------
        Hosts
        --------------------------

                __________________________
                Ajouter un hôte:


                    Other hosts with Puppet agents installed can use this puppet master by setting server = foreman.example.com in puppet.conf. Sign their certificates in Foreman by going to Infrastructure > Smart Proxies > Certificates or using puppet cert list and puppet cert sign on the puppet master.


        --------------------------
        Puppet
        --------------------------

            http://projects.theforeman.org/projects/foreman/wiki/Parameterized_class_support

                __________________________
                Classes :

                        Création d'une classe :
                        ``````````````````````````

                            Pour retrouver les paramètres/variables d'une classe dans foreman, il faut déclarer une classe avec des paramètres de classe :

                            Exemple :

                                class gpg::common (
                                    $param_list = ["value1", "value2"],
                                    $param_entier = X
                                ) {
                                    ...
                                }

                            On pourra ainsi utiliser les paramètres directement au niveau de Foreman, (Puppet classes > maClasse)
                            Et retrouver ses paramètres dans 'Smart Class Parameter'
                            Pour pouvoir modifier les valeurs facilement au niveau des hosts, il faut cocher l'option 'override'

                        Importation :
                        ``````````````````````````

                            Pour mettre à jour ou importer une classe au niveau de Foreman, il faut l'importer dans la section 'Puppet classes'

        --------------------------
        Provisioning
        --------------------------
                    
                __________________________
                Ajouter un OS :

                    Dans HOSTS > Operating Systems

        --------------------------
        API
        --------------------------

            Foreman est livré avec une API :

                http://theforeman.org/api/1.9/index.html

                __________________________
                Via python-foreman :

                    Un module python existe déja et permet de piloter l'API :

                        Doc :
                        ``````````````````````````

                            http://david-caro.github.io/python-foreman/client.html

                        Project :
                        ``````````````````````````

                            https://pypi.python.org/pypi/python-foreman

                        Installation :
                        ``````````````````````````

                            > wget https://pypi.python.org/packages/source/p/python-foreman/python-foreman-0.3.1.tar.gz#md5=7787a96710763338373d9a431e468318
                            > tar -xvf python-foreman*.tar.gz
                            > python setup.py install

                        Importer les modules :
                        ``````````````````````````

                            from getpass import getpass
                            from foreman.client import Foreman

                        Instancier l'objet foreman :
                        ``````````````````````````

                            f = Foreman('http://foremanhost', ('admin', getpass()))

                        Obtenir des infos sur un host :
                        ``````````````````````````

                            f.do_get('/api/hosts/', '')
                            f.do_get('/api/hosts/3', '')

                        Créer un host :
                        ``````````````````````````

                            host={'root_pass': 'daozkdpzakdzakdpza', 'mac': '08:00:27:a1:9c:4B', 'environment_id': 1, 'architecture_id': 1, 'name' : 'forefoo.domain', 'ptable_id' : 10, 'operatingsystem_id': 2 }
                            f.do_post('/api/hosts', host)

                        Exemple d'import/export :
                        ``````````````````````````

                            import json
                            with open('hosts.json', 'w') as outputFile :
                                json.dump(f.do_get('/api/hosts', ''), outputFile)

                            with open('hosts.json') as inputFile :    
                                hosts = json.load(inputFile)


~~~~~~~~~~~~~~~~~~~~~~~~~~
Provisioning templates
~~~~~~~~~~~~~~~~~~~~~~~~~~



~~~~~~~~~~~~~~~~~~~~~~~~~~
Toubleshooting
~~~~~~~~~~~~~~~~~~~~~~~~~~
        --------------------------
        Fatal Could not read from the boot medium
        --------------------------

            Si l'on arrive par défaut sur le menu de boot PXE de Foreman c'est qu'il manque un fichier nommé avec l'adresse mac de l'hôte dans :

                /srv/tftp/pxelinux.cfg

            Bien rebuilder ou recréer l'hôte dans le cas ou le fichier est manquant :

                ( monhost > cancel Build > Build )

                /srv/tftp/pxelinux.cfg/01-08-00-27-bf-11-37

        --------------------------
        Changement d'IP de l'interface d'écoute :
        --------------------------

            Si vous changer votre @IP, Foreman peut conserver l'ancienne dans ses fichiers ou sa base et beaucoup de probl_me peuvent arriver.

                1 : Vérifier au niveau du DHCP 
                2 : Vérifier au niveau du DNS
                3 : Reconfigurer l'interface via la UI de Foreman dans la section host
                4 : Relancer le script foreman-installer
                5 : Reconfigurer la partie provisioning via la UI
                6 : Relancer le script foreman-installer avec les données générées par la UI.

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
