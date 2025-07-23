# OVH PROXMOX

* Modifier le plan de partitionnement ovh proxmox avec /var/lib/vz en zfs
* Modifier la partition pour la chiffrer ensuite
* Création d'une clé ssh
* Connexion en root
* Configuration ssh et service proxmox
  * Création d'un nouvel utilisateur

```
#nouvel admin
adduser foouser
usermod -aG sudo foouser

#test :
su - foouser
sudo su -

#Ajouter sa clé ssh utilisateur admin
mkdir /home/foouser/.ssh
vim /home/foouser/.ssh/authorized_keys
  #Copier sa clé publique
chown -R foouser: /home/foouser/.ssh
chmod 600 /home/foouser/.ssh/authorized_keys

#On test l'accès
ssh foouser@fooserver

#on retire root de l'accès ssh et on change le port
#(https://fr.wikipedia.org/wiki/Liste_de_ports_logiciels)
#Les ports numérotés 49152 à 65535 sont des ports dynamiques. Ils ne sont pas assignés par l’IANA
vim /etc/ssh/sshd_config

Port 49100
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
PubkeyAuthentication yes


#Pour OVH, retirer la config ssh qui force l'autentification par mot de passe :
rm /etc/ssh/sshd_config.d/50-cloud-init.conf

#on sécurise l'accès à la WEBUI proxmox
vim /etc/default/pveproxy

ALLOW_FROM="127.0.0.1"
DENY_FROM="all"
POLICY="allow"

#redémarrage des services
systemctl restart pveproxy
systemctl status pveproxy
systemctl restart sshd
```

**Sur son poste :**

```
#Réperctuter la configuration dans sa config ssh
vim ~/.ssh/config

HOST XXX
  User XXX
  IdentityFile ~/.ssh/...
  Port XXXX

#Répercuter le nom d'host dans son /etc/hosts
sudo vim /etc/hosts
  X.X.X.X fooserver

#connexion via tunnel ssh
ssh -L 8006:127.0.0.1:8006 foouser@your-proxmox-server
```
**Personnalisation :**

```
apt install net-tools
#copier éventuellement vimrc, bashrc et motd
```

**Premier niveau de sécurisation :

```
#changement du mdp root
sudo su -
password

#mise à jour système
sudo apt update && sudo apt upgrade
sudo apt install fail2ban #iptables #s'il n'est pas déjà install

#Sources : https://www.remipoignon.fr/securiser-son-serveur-linux/
#https://github.com/paulpremont/dorysmemo/blob/main/Memos/Systems/Security/memo_iptables.2c.md
#Configuration réseau et firewall
vim /etc/sysctl.conf

net.ipv4.ip_forward=1
# Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

# Recharger la conf:
sysctl -p

# Vérifier:
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
cat /proc/sys/net/ipv4/ip_forward

# Configuration iptables
# Copier et adapter la source : https://github.com/paulpremont/dorysmemo/blob/main/Memos/Systems/Security/firewall-example.sh
cp firewall-example.sh /etc/init.d/firewall
chmod +x /etc/init.d/firewall
/etc/init.d/firewall test
update-rc.d firewall defaults
#pour supprimer : update-rc.d -f firewall remove

#Configuration de fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
#Adapter en conséquence
```

**Mise à jour auto**

```
# Mise à jour de sécurité automatique
apt install cron-apt

# Séparer les sources concernant les dépôts de sécurité dans un fichier distinct :
cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian-security.sources
# Éditer les fichiers en conséquence

vim /etc/cron-apt/config
# Configuration for cron-apt. For further information about the possible
# configuration settings see /usr/share/doc/cron-apt/README.gz.

  APTCOMMAND=/usr/bin/apt-get
  OPTIONS="-o quiet=1 -o Dir::Etc::SourceList=/etc/apt/sources.list.d/debian-security.sources"
  MAILTO="foouser@foodomain.fr"
  MAILON="upgrade"

vim /etc/cron-apt/action.d/3-download

  autoclean -y
  #on supprime l'option -d par défaut pour que la mise à jour soit appliquée
  dist-upgrade -y -o APT::Get::Show-Upgraded=true

#vérifier l'application en crontab
cat /etc/cron.d/cron-apt

#tester
cron-apt
cat /var/log/cron-apt/log
```

**MTA**
```
#Configuration d'un MTA pour l'envoi d'email depuis le système
#source : https://fr.ittrip.xyz/linux/using-email-commands-in-linux
#https://serverfault.com/questions/221696/ssmtp-change-from-root-xycom-root-name
#choix de ssmtp pour disposer d'un MTA simple d'envoie d'email depuis un service externe

apt install ssmtp
cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.origin.conf
vim /etc/ssmtp/ssmtp.conf

  # Configuration pour le serveur SMTP
  #mailhub=smtp.example.com:587
  mailhub=smtp.example.com:465

  # Nom d'utilisateur et mot de passe du serveur SMTP
  AuthUser=votre_utilisateur@example.com
  AuthPass=votre_mot_de_passe

  # Adresse email de l'expéditeur
  FromLineOverride=YES
  rewriteDomain=example.com

  # Réglez ce qui suit pour l'utilisation de SSL/TLS
  #UseSTARTTLS=YES
  UseTLS=YES

vim /etc/ssmtp/

  root:monexpediteur@mondomain.com

# Test

echo -e 'Subject: test\n\nTesting ssmtp' | sendmail -v support@mondomaine.com

# Note : il est possible de changer le nom de l'utilisateur du from via /etc/password
# Exemple :

vim /etc/passwd
  root:x:0:0:YOUR NAME HERE,,,:/root:/bin/bash
```

**IDS**

```
apt install rkhunter
vim /etc/default/rkhunter

  CRON_DAILY_RUN="yes"
  REPORT_EMAIL="foouser@foodomain.fr"

rkhunter --propupd
```

**Logs**
```
apt install logwatch
cp /usr/share/logwatch/default.conf/logwatch.conf /etc/logwatch/conf/logwatch.conf
vim /etc/logwatch/conf/logwatch.con

  Format = html
  MailTo = moi@mondomaine.fr
  Detail = Med
```

**SSH alerte**
```
vim /etc/profile

echo "Objet : Alerte connexion SSH.
Serveur : `hostname`
Date : `date`
`who` " | mail -s "`hostname` connexion ssh de : `who | cut -d"(" -f2 | cut -d")" -f1`" moi@mondomaine.fr
```

**Accès admin proxmox**
```
ssh -L 8006:127.0.0.1:8006 monserveur
```

Puis accéder à https://127.0.0.1:8006

**Chiffrement ZFS en mode mirroir**
```
#identifier les partitions de données
fdisk -l
zpool status -v data

#supprimer le pool zfs non chiffré
zfs list
sudo zfs set mountpoint=none data
sudo zfs set mountpoint=none data/zd0
zpool destroy data
zfs list

#créer le nouveau pool zfs
sudo zpool create -f -o ashift=12 data mirror /dev/nvme0n1p5 /dev/nvme1n1p5
sudo zfs set mountpoint=none data
sudo zfs create -o encryption=on -o keylocation=prompt -o keyformat=passphrase data/zd0
sudo zfs set mountpoint=/var/lib/vz data/zd0
zfs list
  NAME       USED  AVAIL  REFER  MOUNTPOINT
  data       944K   899G    96K  none
  data/zd0   248K   899G   248K  /var/lib/vz

sudo zfs mount -l data/zd0
df -h
  data/zd0       942931840     128 942931712   1% /var/lib/vz
zfs list -o name,mountpoint,mounted,my.custom:property

reboot
#Note : il est possible de suivre la séquence de boot via le KVM en ligne de votre serveur
sudo zfs mount -l data/zd0
zfs list -o name,mountpoint,mounted,my.custom:property
df -h

# /!\ regarder également sur l'interface de proxmox si la partie storage correspond bien.
# Attention à ne pas manipuler des VM lorsque le point de montage n'est pas réalisé

ls -lR /var/lib/vz
/var/lib/vz:
total 20
drwxr-xr-x 2 root root 4096 Jul  1 16:54 dump
drwxr-xr-x 2 root root 4096 Jul  1 16:54 images
drwxr-xr-x 2 root root 4096 Jul  1 16:54 private
drwxr-xr-x 2 root root 4096 Jul  1 16:54 snippets
drwxr-xr-x 4 root root 4096 Jul  1 16:54 template
```

**Configuration utilisateurs proxmox**

Aller sur proxmox : localhost:8006 > Datacenter > Permissions

1. Créer un groupe
2. Ajouter permission administrator groupe
3. Ajouter un utilisateur pam

Note : il n'est pas conseillé sur proxmox de désactiver l'utilisateur root au risque de perdre certaines fonctionnalités


**Réseau des VM**

Aller sur proxmox : localhost:8006 > non-serveur > 


**Première VM**


**Accès VPN Wiregard**

```
```
