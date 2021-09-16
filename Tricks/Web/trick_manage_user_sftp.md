# Gérer less accès SFTP et les utilisateurs

Le but de ce trick est de montrer comment ajouter des utilisateurs à un serveur distant. 
En leur laissant un espace de stockage et par exemple leur donnant accès à leur dossier source de leur site web.

Ces exemples sont à tester sur l'utilisateur et le groupe de votre choix.

À voir: rssh pour n'autoriser que scp et sftp.

Installation des paquets
---------------

    apt-get install openssh-server

Ajout d'un nouvel utilisateur et d'une arborescence
---------------
	
(à faire en root)

    addgroup GROUPNAME
    useradd -m -p PASSWORD -g GROUPNAME -d /home/USERNAME -s /bin/bash -k /dev/null USERNAME 
    chmod 755 /home/USERNAME

si vous faite le test sur un utilisateur déja existant:

    usermod -a -G ftpgroup -a GROUPNAME

(pour le chroot, il faudra garder root en owner:group)

    ll /home
    #drwxr-xr-x  4 root    root     4096  1 mai   11:32 USERNAME/

On créer une arborescence pour l'utilisateur :

    mkdir -p /home/USER/Documents/...  #rajoutez ce que vous voulez ! :p
    mkdir -p /home/USER/Website	

Pour ceux qui veulent lier un site web (dans un folder externe à l'utilisateur par exemple)

Rajoutez dans la fstab :

**/etc/fstab**
		
		/var/www/WEB_FOLDER /home/USER/Website none bind 0 0

<!-- endvim -->

    mount -a 	#pour monter le nouveau dossier 

Note: Les liens externes à la racine du chroot ne fonctionneront pas.

    chown -R USER:GROUPNAME /home/USER/Documents
    chown -R USER:GROUPNAME /home/USER/Website
    chmod -R 700 /home/USER/Documents
    chmod -R 700 /home/USER/Website

Note: Vérifiez vos droits sur le dossier **/var/www/XXXX** et appliquer la même logique de façon récursive.

Configuration:
---------------

    vim /etc/ssh/sshd_config

On ajoute un peu de sécurité:

		AllowUsers USERNAME USERNAME2 ...  (garder votre login pour l'accès ssh :p)
		PermitRootLogin no
		PermitEmptyPasswords no (par défaut)
		ClientAliveInerval 600 (timeout d'incactivité en seconde)
		ClientAliveCountMax 3 (nombre de tentatives de reponse de la part du client)

		Subsystem       sftp    internal-sftp -f AUTH -l VERBOSE
			Match Group GROUPNAME
			ChrootDirectory /home/%u
			ForceCommand internal-sftp
			AllowTCPForwarding no
			X11Forwarding no

<!-- endvim -->

    service ssh restart

Note:

Les groupes définis dans 'Match Group' ne pourront plus se ssh !

Les quotas
---------------

[ubuntu-fr](http://doc.ubuntu-fr.org/quota)
[tuto k-tux.com](http://www.k-tux.com/linux-mise-en-place-de-quota)

Les quota vont nous permettre de limiter l'espace disque pour un utilisateur ou un groupe.

    apt-get install quota
    vim /etc/fstab			#On modifie une partition pour y inclure la gestion des quota.

Rajoutez les lignes usrquota,grpquota sur le device de votre choix:

exemple :

		UUID=f6cf6908f591 /home   ext4   defaults,usrquota,grpquota    1     2

<!-- endvim -->

    mount -o remount /home		#on remonte le fs
    quotacheck -vgum /home		#On créer les nouveaux fichier quota (si non présent)

Les fichiers aquota.group et aquota.user sont maintenant crées.
Ils doivent avoir les droits 600 pour root.

    quotaon -v /home			#On active le quota
    quotacheck -vgum /home		#On recheck si tout est ok
    edquota -u USERNAME			#Pour limiter l'espace disque:
    #ou -g GROUPNAME

Notions :

* hard limit = Au dessus de ce seuil, l'utilisateur ne peux plus enregistrer de données.
* soft limit = Limite temporaire que peut atteindre l'utilisateur (< hard) pendant la grace period.
* grace period = Temps dont l'utilisateur bénéficie pour libérer l'espace disque temporaire.

Voici un exemple de configuration:

		Disk quotas for user USERNAME (uid 1002):
		Filesystem                   blocks       soft       hard     inodes     soft     hard
		/dev/sdb1                     88451      90000     102400       8500        0        0

Avec:

* La 1ere colonne (blocks) = taille actuellement utilisé par l'utilisateur.
* La 2eme et 3eme colonne (soft & hard) = Limite du nombre de blocks (en taille de 1K)
* La 4eme colonne (inode) = nombes de fichiers actuels de l'utilisateur.
* Les 2 dernières colones = Limite du nombre de fichiers.

Affichez ensuite le nombre de block de votre partition:

    df -Bk

Attention les blocks sont ici définis en bloc de 1K


    edquota -u -f /home -t	#pour gérer la grace period
    repquota -sia			#Affiche le résumé de notre conf avec la taille réel

ou

    repquota -si /home		#Affiche le résumé de notre conf

Pour copier ensuite ce quota :

    edquota -p user1 user2

Note :

Pour les montages (mount).  
Si le point source de montage est situé sur une autre partition alors le quota ne s'appliquera pas pour celui ci.  
Il faudra définir les quota sur cette dernière.
			
tests quota
---------------

    dd if=/dev/zero of=FileXXMo bs=1M count=XX	#Avec XX en Mo

tests clients
---------------

Faite bien gaffe aux droits et le tour est joué

    sftp USER@MON_SERVEUR

désactiver les quota
---------------

    sudo quotaoff -avug
