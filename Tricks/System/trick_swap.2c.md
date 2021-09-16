============================================================
Comment modifier son swap
============================================================

La zone de swap est completement modifiable, on peu changer son emplacement et même à la place d'une partition dédié au swap, créer un fichier de swap, ce qui offre beaucoup d'avantage.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Création d'un fichier de swap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	>	fallocate -l XXXm /file.swap
	>	chmod 600 /file.swap
	>	mkswap /file.swap
	>	swapon /file.swap


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Changer l'emplacement du swap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	>	mkswap /dev/XXX #(ou sur un fichier, voir au dessus)
	>	swapoff -a
	>	swapon /dev/XXX
	>	blkid /dev/XXX
	
	récupérer l'UUID

	>	vim /etc/fstab

	Rajouter la ligne suivante:

	>	UUID=UUID de l'étape précédente	swap	sw	0	0

	Sauver puis modifier l'ancien uuid présent dans les fichiers suivants:

		/etc/initramfs-tools/conf.d/resume
		/etc/default/grub

	Prendre ensuite les paramètres en comptes par le système:

	>	update-initramfs -u -k $(uname -r)

	
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Customiser son swap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	Le système écrit dans le swap à partir d'un % utilisé par la RAM:

	Définit dans:

	>	cat /proc/sys/vm/swappiness

	Pour changer cette valeur:

	>	sysctl vm.swappiness=XX
	>	swapoff -av && swapon -av

	Pour appliquer les changements définitivement:

	>	vim /etc/sysctl.conf

	rajouter la ligne:

	>	vm.swappiness=XX
