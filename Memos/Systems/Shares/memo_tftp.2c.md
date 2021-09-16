#=====================================================
#	T F T P d
#=====================================================

#= ftp via UDP

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#	Packages
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

packages="xinetd tftpd tftp"
apt-get install $packages

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#	Conf file
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

echo "service tftp
{
protocol	= udp
port		= 69
socket_type	= dgram
wait		= yes
user		= nobody
server		= /usr/sbin/in.tftpd
server_args	= /home/tftpboot
disable		= no
}" > /etc/xinetd.d/tftp

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#	Build
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mkdir /home/tftpboot
chmod -R 777 /home/tftpboot
chown -R nobody /home/tftpboot

service xinetd reload
service xinetd restart

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#	Files
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

touch fichier1 fichier1 /home/tftpboot/

#Il faut au préalable créer les fichiers sur le serveur pour pouvoir ensuite up/downloader les fichiers.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#	Client
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tftp 
> ? 			#afficher l'aide
> verbose 		#pour augmenter la verbosité
> connect $IP_SERVER
> status 		#pour vérifier la connectivité
> get file		#récupérer le fichier
> put file		#envoyer un fichier
> quit			#arrêter la connexion
