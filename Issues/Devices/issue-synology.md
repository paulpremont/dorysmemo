## Problème de chargement de la WUI sur un synology après un reboot.

Prérequis : disposer d'un accès SSH

**Constat de services en état "degraded" :

Plus redémarrage de l'interface web

```
systemctl status
systemctl reset-failed
systemctl restart nginx
systemctl status
```

**Constat d'une date éronnée" :

```
date
systemctl stop ntpd
ntpdate 0.fr.pool.ntp.org
systemctl start ntpd
```
