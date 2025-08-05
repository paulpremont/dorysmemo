# Rebond SSH

Les méthodes via ProxyJump ou ssh-agent permettent de se connecter via un serveur de rebond.

Cela évite de stocker ses clés sur les serveurs distants.

La méthode de Proxyjump est plus sécurisée que ssh-agent car en cas de compromission du rebond,
ce dernier pourrait utiliser les clés de l'agent.

## Création de la clé

Sur le client :

```
ssh-keygen -t ed25519 -a 100
```

Ajouter la clé publique sur le serveur cible :

```
vim ~/.ssh/authorized_keys

ssh-ed25519 CLEPUB user@host

chmod 600 ~/.ssh/authorized_keys
```

## Mode ProxyJump (à préférer)

(À partir de OpenSSH 7.3)

Repose sur "ProxyCommand"

### Connexion directe


```
# Spécifier la clé privée si le fichier de config ssh n'est pas paramétré :

ssh -J utilisateur@serveurRebond -i CLECIBLE utilisateur@serveurCible
ssh -J utilisateur@serveurRebond -i CLEREBOND -i CLECIBLE utilisateur@serveurCible
```

### Configuration client

```
vim ~/.ssh/config

Host rebond
    HostName nomServeurRebond
    User utilisateur
    IdentityFile ~/.ssh/cle-rebond.ed

Host cible
    HostName nomServeurCible
    User utilisateur
    ProxyJump rebond
    IdentityFile ~/.ssh/cle-cible.ed

ssh cible
```

## Mode Proxycommand

Si SSH ne supporte par proxuyJump.
Ou si l'on souhaite faire des actions plus spécifiques


```
vim ~/.ssh/config

Host rebond
    HostName serveurRebond
    User user
    IdentityFile ~/.ssh/id_rsa

Host cible
    HostName serveurCible
    User user
    IdentityFile ~/.ssh/id_rsa
    ProxyCommand ssh -q -W %h:%p rebond
```

## Mode Agent

### Connexion

```
# Démarrage de l'agent
ssh-agent -s


# Ajout de la clé au niveau de l'agent
# -t (lifetime)
ssh-add -t 3600 ~/.ssh/private_key_rsa

# Se connecter en mode agent sur le serveur distant
ssh -A user@monServeurRebond

# Se connecter ensuite sur le rebond
ssh monuser@monServeurCible
```

### Configuration serveur distant

Autoriser le mode agent sur le serveur distant :

```
vim /etc/ssh/sshd_config

AllowAgentForwarding yes
```

### Configuration client

Pour se connecter en mode agent automatiquement :

```
vim ~/.ssh/config

# Si l'on veut ajouter automatique chaque nouvelle clé :
# AddKeysToAgent yes

# Activer le mode agent sur certains hosts :
Host server1
 ForwardAgent yes
```

### Gérer vos clés :

```
# Listez vos clés :
ssh-add -l

# Ajouter une clé :
ssh-add ~/.ssh/id_rsa

# Supprimer une clé :
ssh-add -d ~/.ssh/id_rsa

# Supprimer toutes les clés :
ssh-add -D
```
