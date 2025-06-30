#!/bin/bash

### BEGIN INIT INFO
# Provides:          PersonalFirewall
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Personal Firewall
# Description:       Init the firewall rules
### END INIT INFO

# Commandes
IPT=/sbin/iptables
IP6T=/sbin/ip6tables
FILTER="$IPT -t filter"
FILTER_IN="$IPT -t filter -A INPUT"
FILTER_OUT="$IPT -t filter -A OUTPUT"
NAT="$IPT -t nat"
MANGLE="$IPT -t mangle"

# Network
#dmz='X.X.X.X/24'
#lan='X.X.X.X/24'

# Interfaces
#iwan='vmbrX'
#ilan='vmbrX'
#idmz='vmbrX'

# Les IPs
#IP_TRUSTED=xx.xx.xx.xx

do_start() {

    # Efface toutes les regles en cours. -F toutes. -X utilisateurs
    $FILTER -F
    $FILTER -X
    $NAT -F
    $NAT -X
    $MANGLE -F
    $MANGLE -X

    # strategie (-P) par defaut : bloc tout
    $FILTER -P INPUT DROP
    $FILTER -P FORWARD DROP
    $FILTER -P OUTPUT DROP

    # Loopback
    $FILTER_IN -i lo -j ACCEPT
    $FILTER_OUT -o lo -j ACCEPT

    # Permettre a une connexion ouverte de recevoir du trafic entrant
    $FILTER_IN -m state --state ESTABLISHED,RELATED -j ACCEPT
    $FILTER_OUT -m conntrack ! --ctstate INVALID -j ACCEPT

    # ICMP
    $FILTER_IN -p icmp -j ACCEPT
    $FILTER_OUT -p icmp -j ACCEPT

    # DNS:53
    $FILTER_OUT -p udp --dport 53 -j ACCEPT
    $FILTER_OUT -p tcp --dport 53 -j ACCEPT

    # SSH:22
    $FILTER_IN -p tcp --dport 22 -j ACCEPT
    $FILTER_OUT -p tcp --sport 22 -j ACCEPT
    $FILTER_OUT -p tcp --dport 22 -j ACCEPT

    # HTTP:80
    $FILTER_IN -p tcp --dport 80 -j ACCEPT
    $FILTER_OUT -p tcp --sport 80 -j ACCEPT
    $FILTER_OUT -p tcp --dport 80 -j ACCEPT

    # HTTPS:443
    $FILTER_IN -p tcp --dport 443 -j ACCEPT
    $FILTER_OUT -p tcp --sport 443 -j ACCEPT
    $FILTER_OUT -p tcp --dport 443 -j ACCEPT

    # SMTP:465
    $FILTER_OUT -p tcp --dport 465 -j ACCEPT

    # IMAP:993
    $FILTER_OUT -p tcp --dport 993 -j ACCEPT

    # accepte tout d'une ip en TCP
#    $FILTER_IN -p tcp -s $IP_TRUSTED -j ACCEPT

    echo "firewall started [OK]"
}

# fonction qui arrete le firewall
do_stop() {

    # Efface toutes les regles
    $FILTER -F
    $FILTER -X
    $NAT -F
    $NAT -X
    $MANGLE -F
    $MANGLE -X

    # remet la strategie
    $FILTER -P INPUT ACCEPT
    $FILTER -P OUTPUT ACCEPT
    $FILTER -P FORWARD ACCEPT

    #
    echo "firewall stopped [OK]"
}

# fonction status firewall
do_status() {

    # affiche les regles en cours
    clear
    echo Status IPV4
    echo -----------------------------------------------
    $IPT -L -n -v
    echo
    echo -----------------------------------------------
    echo
    echo status IPV6
    echo -----------------------------------------------
    $IP6T -L -n -v
    echo
}

case "$1" in
    start)
        do_start
        exit 0
    ;;

    stop)
        do_stop
        exit 0
    ;;

    test)
        do_start
        echo "60s remaining..."
        sleep 60
        do_stop
        exit 0
    ;;

    restart)
        do_stop
        do_start
        exit 0
    ;;

    status)
        do_status
        exit 0
    ;;

    *)
        echo "Usage: /etc/init.d/firewall {start|stop|test|restart|status}"
        exit 1
    ;;

esac

exit 0
