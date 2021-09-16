# Intégrer un client à l'AD

## LINKS

[microsoft.com](http://technet.microsoft.com/en-us/magazine/2008.12.linux.aspx)
[samba.org](http://www.samba.org/samba/docs/man/Samba-HOWTO-Collection/winbind.html)
[ubuntu.fr](http://doc.ubuntu-fr.org/tutoriel/comment_ajouter_machine_ubuntu_dans_domaine_active_directory)
[howto](http://www.tejasbarot.com/2012/04/30/howto-other-login-option-on-login-screen-ubuntu-12-04-lts-precise-pangolin/#axzz2lBRxyEtf)

## HOW IT WORKS

Les différents systèmes à mettre en place :

* Samba: Projet / serveur permetant le partage, l'authentification et de rapprocher les environnements Linux et Windows.
* Winbind: élément de samba, c'est un deamon permettant de dialoguer avec les serveurs AD.
* NSS et PAM: modules d'authentification des systèmes Linux.

* NSS: pour les accès aux fichiers.
* PAM: pour la centralisation de l'authentification.


## Méthodes d'authenttification

### Auth LDAP:
			
NSS et PAM conf pour dialoguer avec la base LDAP :

Problèmes: 

* L'auth ne se fait pas par kerberos.
* Pas de gestion de changement et d'expiration de mot de passe.

### Auth LDAP + Kerberos
			
PAM utilise Kerberos pour l'authentification.  
NSS utilise LDAP pour les infos concernant les utilisateurs et groupes.

Problèmes:

* Pas de gestion des SRV (enregistrement automatique des entrées DNS)

### Auth Winbind

NSS et PAM appel le daemon Winbind pour l'auth.  
Ce qui permet de retranscrire les appels NSS et PAM par winbind et d'envoyer les requêtes au bon server (LDAP/RPC/Kerberos/NTLM).


## Application
	
### Install des paquets:

    apt-get install winbind samba ntp(ou ntpdate)

### Configuration du ntp:

Sous Ubuntu:

    ntpdate -s MY_NTP_SERVER

La conf se trouve dans **/etc/default/ntpdate**

**/etc/default/ntpdate**

    NTPDATE_USE_NTP_CONF=no #mettre à yes pour une gestion au niveau de ntp.conf
    NTPSERVERS="MON_SERVER_NTP"

**/etc/ntp.conf**

    server MY_NTP_SERVER

<!-- /vim -->

		/etc/init.d/ntp restart #si vous passez par le démon ntpd

### configuration du DNS  Réseaux si pas déja fait
		
		vim /etc/resolv.conf #ou autre méthode pour ceux qui on un resolv dynamique.
			
### #configuration de PAM
	
		cd /etc/pam.d
		
Editer :
		
* common-account

    account [success=1 new_authtok_reqd=done default=ignore] pam_winbind.so
    #account [default=bad success=ok user_unknown=ignore] pam_winbind.so

* common-auth

    #auth sufficient pam_winbind.so use_first_pass
    auth [success=1 default=ignore] pam_winbind.so krb5_auth krb5_ccache_type=FILE cached_login try_first_pass

* common-password

    password [success=1 default=ignore] pam_winbind.so use_authtok try_first_pass
    #password sufficient pam_winbind.so use_authtok

* common-session

    session optional	pam_winbind.so
    session required  pam_mkhomedir.so skel=/etc/skel/
				
### #configuration de NSS

Vérifiez que vous avez bien la librairie suivante dans /lib par exemple:

		locate libnss_winbind.so

ou encore:

		ldconfig -v |grep winbind

**/etc/nsswitch.conf**

    passwd: winbind
    group: winbind

### configuration de Samba (minimale)

**/etc/samba/smb.conf**

    [global]
      workgroup = NOM_DOMAINE
      winbind separator = /
      idmap uid = 10000-20000
      idmap gid = 10000-20000
      winbind enum users = yes
      winbind enum groups = yes
      template homedir = /home/%D/%U
      template shell = /bin/bash
      password server = MY_SERVER_AD
      realm = MON_DOMAINE_FQDN
      winbind use default domain = true
      security = ADS
      winbind offline logon = yes

    [home]
      comment = Home dir
      browseable = no
      writable = yes
      read only = yes
      create mask = 0700
      valid users = %S

### Pour la connexion offline :

**/etc/security/pam_winbind.conf**

    [global]
    cached_login = yes

### Changer le hostname
	
Ce procédé est nécessaire pour pouvoir ajouter des entrées DNS.
		
    hostname PC_NAME

**/etc/hostname**

    PC_NAME

**/etc/hosts**

    127.0.1.1 PC_NAME.FQDN PC_NAME

Checks :

hostname : doit afficher le nom court
hostname : doit afficher le fqdn du pc
					
### Joindre le domaine
			
les démons smbd et winbindd doivent tourner.
		
		/etc/init.d/smbd restart
		/etc/init.d/winbind restart

		net rpc join -S MY_SERVER_FQDN -U administrator
		net ads join -S MY_SERVER_FQDN -U administrator

### Tests
		
		wbinfo -u : lister les utilisateurs de l'AD
		wbinfo -t : Vérifier la validité du secret entre les deux entité
		wbinfo -g : lister les groupes de l'AD

		getent passwd
		getent group

### Pour le login ubuntu (sur les nouvelles version)

Il faut ajouter la possibilité de rentrer l'utilisateur souhaité :

    cp -p /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.back
    /usr/lib/lightdm/lightdm-set-defaults -m true
    /etc/init.d/lightdm restart

ou manuellement (non testé pour le moment)
			
**/etc/lightdm/lightdm.conf**

    [SeatDefaults]
    greeter-session=unity-greeter
    user-session=ubuntu
    greeter-show-manual-login=true
