# Network Manager

## Désactiver Network Manager pour ifup

    sudo vim /etc/NetworkManager/NetworkManager.conf

    <!-- vim -->

    [main]
    plugins=ifupdown,keyfile,ofono
    dns=dnsmasq

    [ifupdown]
    managed=true
