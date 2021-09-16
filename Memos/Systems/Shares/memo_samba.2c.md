==========================================================
		S A M B A
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Samba
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	paquet: samba
	config: /etc/samba/smb.conf

	Exemple de partage:

	------------------
	Ajout d'un partage:
	------------------

		[global]
		server string = NomServeur
		workgroup = workgroup
		netbios name = NomServeur
		encrypt passwords = true

		[DossierPartagé]
		path = /path_du_folder
		read only = no
		writeable = yes
		public = yes
		comment = commentaire
		#valid users = $MON_USER_SAMBA #(mettez public à "no")
		#create mask = 777 #(si vous voulez changer le masque du dossier)
				
	------------------
	Ajout d'un utilisateur samba 
	------------------

		Note:
			Il faut au préalable créer un utilisateur systeme. (question de droits ;) )

		> smbpasswd -a MON_USER_SYSTEM 

	------------------
	Redémarrage du démon
	------------------

		> /etc/init.d/samba restart
	ou 	> service smbd restart
		...


	Attention pour les commandes suivante, il est nécessaire de créer un user dans samba pour accéder aux partages:

	----------------------
	Visioner les partages:
	----------------------

		> smbclient -L SERVERNAME
		> smbclient //host/share_folder <-U user>: accéder à un partage samba

	----------------------
	Monter les partages:
	----------------------

	s'assurer que les paquetes smbfs ou cifs.utils soient installés.

	
		Monter le dossier:

			> smbmount //@IP/SHARE /path/to/mount -o username=bidule
	
			ou encore:

			> mount.cifs //@IP/SHARE /path/to/mount -o username=bidule

		Fstab:

			> //@SERVER_SAMBA/SHARE_NAME /path/to/mount smbfs password=PASSWORD,username=USERNAME 0 0

			ou

			> //@SERVER_SAMBA/SHARE_NAME /path/to/mount cifs  _netdev,credentials=/root/.smbcredentials     0     0
	 		avec le password et le username dans le fichier /root/.smbcredentials:

				username=USER
				password=PASS

			Exemple:
				//10.10.3.56/packages /media/packages cifs username=packages,password=mypwd,iocharset=utf8,sec=ntlm  0  0

		Note: Pour activer le partage sur un périphérique distant
			La syntaxe est souvent la suivante (pour le protocole cifs essentielement il me semble):
				\\@IP_serveur\Nom_partage

	
