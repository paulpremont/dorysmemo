# ssh's issues

## Erreur "host unreachable"

Message :

    named[4039]: client 127.0.0.1#60810: error sending response: host unreachable

### Résolution

Vérifiez votre pare feu et autorisez la loopback en OUTPUT et INPUT

    iptables -A OUTPUT -o lo -j ACCEPT
    iptables -A INPUT -i lo -j ACCEPT

## Erreur "Bad owner or mode"

Message :

    Bad owner or mode

### Résolution :

    chmod 755 /home/monUser           #A fonctionné avec un montage autofs et un nas.
    chmod 700 /home/monUser/.ssh
    chmod 600 /home/monUser/.ssh/*

## Erreur "Could not load host key"

Message :

    Could not load host key: /etc/ssh/ssh_host_rsa_key
    Could not load host key: /etc/ssh/ssh_host_ecdsa_key
    Could not load host key: /etc/ssh/ssh_host_ed25519_key
    Server listening on 0.0.0.0 port 22.
    Server listening on :: port 22.

### Résolution :

Lancé avec

    /usr/sbin/sshd -D -e

Si on ne passe pas par le service il faut lancer la commande :

    /usr/bin/ssh-keygen -A

Pour lancer la génération des clés

## Erreur "cannot change locale"

Message :

    bash: warning: setlocale: LC_ALL: cannot change locale (fr_FR.utf-8)

### Résolution :

    vim /etc/ssh/ssh_config

      # SendEnv LANG LC_*
