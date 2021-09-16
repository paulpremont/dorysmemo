==========================================================
           R S Y N C    &   S Y N O L O G Y
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://www.dikant.de/2013/06/25/secure-offsite-backups-for-synology-nas/
    https://blog.sleeplessbeastie.eu/2013/08/08/how-to-perform-automated-backup-using-rsync-over-ssh/
    http://www.nas-forum.com/forum/topic/35111-sauvegarde-chiffree-dans-le-nuage-entre-1-synology-vers-un-serveur-rsync/

~~~~~~~~~~~~~~~~~~~~~~~~~~
Préambule
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Scenario:

        NAS -> Serveur BACKUP (non synology)

    /!\ En fonction de la version de DSM les options peuvent être diffente et surtout à un autre endroit.

    Quelques petites remarques:

        - Une gestion de la synchro over ssh très peu sécurisée selon moi:
            -pas de certificat, 
            -pas de chroot possible, 
            -pas de changement possible du port rsync,
            -login/mot de passe ssh et rsync identique ...

        Un simple rsync over ssh dans daemon aurait suffit !
        On peu surement le faire à la main mais on perd du coup le management via l'interface utilisateur.

        En esperant qu'il y aura des modifications sur ce point.


~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install openssh-server rsync

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Activation de rsync:

        > vim /etc/default/rsync

    Configuration des modules à partager:

        > vim /etc/rsyncd.conf

            use chroot = no
            log file = /var/log/rsyncd.log
            pid file = /var/run/rsyncd.pid
            charset = utf8
            transfer logging = yes
            timeout = 0
            uid = syncUser
            gid = syncUser
            secrets file = /etc/rsyncd/rsyncd.secrets

            #Modules
            [backup]
            max connections = 2
            comment = backupzi
            path = /home/backup
            read only = no
            list = yes
            hosts allow = @IP_host
            auth users = syncUser

    Configuration du secret:

        > vim /etc/rsyncd/rsyncd.secrets

            syncUser:myPwd

    SSH:

        configurez votre daemon ssh comme à votre habitude avec un maximum de protection + fail2ban

        Note: 

            La config ssh coté NAS n'est pas prise en compte.
            Leur outil force l'utilisation du user avec mot de passe ...

    Droits:

        Ajoutez un lien rsyncd.conf vers le home user de syncUser

            > ln -s /etc/rsyncd.conf 

        Veillez à ce que votre syncUser ai les droits sur:

            /var/run/rsyncd.pid
            /var/run/rsyncd.lock
            /var/log/rsyncd.log


    Sécuriser un minimum:

        Avec fail2ban:


    logrotate:

        > vim /etc/logrotate.d/rsync

            /var/log/rsync.log {
                daily
                rotate 4
                compress
                notifempty
                missingok
            }

    Coté NAS,

        Backup & Replication > Backup > Create

        Suivre les instructions.

        Lorsque vous arriverez sur la config du backup, cochez le chiffrement par ssh.

        Si vous avez des problèmes du type:

            Connexion ssh failed ou problème d'application -> vérifiez:
                -la connexion ssh entre les deux hôtes (manuellement)
                -les logs syslog coté serveur de backup (souvent un problème liés aux droits)
