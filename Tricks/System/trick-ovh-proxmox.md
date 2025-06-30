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

#Configuration de fail2ban
