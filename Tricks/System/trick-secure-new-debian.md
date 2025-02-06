# Sécuriser sa machine Debian

## Sources

* https://fr-wiki.ikoula.com/fr/S%C3%A9curiser_sa_machine_Debian
* https://docs.clamav.net/manual/Installing/Packages.html

## Application 

```
apt update && apt upgrade
apt install sudo vim fail2ban iptables rkhunter clamav
apt install clamav clamav-daemon libclamunrar9

usermod -a -G sudo votre_utilisateur

vim /etc/ssh/sshd_config

  PermitRootLogin no
  Port XXX

vim /etc/crontab

   0  0    * * *   root rkhunter --checkall --report-warnings-only  

rkhunter --checkall
```
