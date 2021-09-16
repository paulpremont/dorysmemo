# tcpdump's issues

## Erreur " Message too long" 

Lorsque vous avez une erreur du type :

    "Warning: Unable to send packet: Error with PF_PACKET send() [9933]: Message too long (errno = 90)"

### Résolution

Le problème vient surement du fait que la taille du paquet est plus élevé que le MTU (Maximum Transfert Unit) autorisé par votre système.
La norme Ethernet prévoit en effet des trames comprises entre 64 et 1518 octets.
Votre capture à peut être été fait sur un réseau acceptant les jumbo frame (c'est à dire dépassant les 1500 octet et allant jusqu'a 9000 octet).

Pour augmenter le MTU sur votre système:

Via ifconfig:

    ifconfig ethX mtu 9000 up

Pour chaque (sous)interfaces il faut rajouter la ligne concernant le mtu:

Redhat OS:

    vim /etc/sysconfig/network-script/ifcfg-ethX
        MTU="9000"
        IPV6_MTU="9000" #Pour l'ipv6

Debian OS:
    vim /etc/network/interfaces
        mtu 9000

Si vous voulez afficher le mtu d'une interface:

    ip link show $INTERFACE

ou simplement

    ifconfig |grep MTU


N'oubliez pas que tout les éléments de votre chaîne doivent accépter les jumbo frame, sinon vous allez de toute façon perdre vos paquets.
