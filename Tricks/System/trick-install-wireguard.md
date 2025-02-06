# Installation Wireguard

## Source

* https://wiki.debian.org/WireGuard

## Application

**Côté serveur :**

```
apt install wireguard

# Génération des clés

cd /etc/wireguard/
umask 077; wg genkey | tee privatekey | wg pubkey > publickey

# Configuration

vim /etc/sysctl.conf
  net.ipv4.ip_forward = 1

sysctl -p

vim /etc/wireguard/wg0.conf

  [Interface]
  Address = 192.168.11.1/24
  #SaveConfig = true
  PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
  #/!\ change eth0 by the good interface
  ListenPort = 51820
  PrivateKey = YOUR_SERVER_PRIVATE KEY

  [Peer]
  PublicKey = YOUR_CLIENT_PUBLIC_KEY
  AllowedIPs = 192.168.11.2/32

  [Peer]
  PublicKey = OTHER_CLIENT_PUBLIC_KEY
  AllowedIPs = ...

systemctl start wg-quick@wg0
ip a show wg0

systemctl enable wg-quick@wg0
```

**Côté client :**

```
cd /etc/wireguard/
umask 077; wg genkey | tee privatekey | wg pubkey > publickey

vim /etc/wireguard/wg0.conf

  [Interface]
  PrivateKey = YOU_CLIENT_PRIVATE_KEY
  ## Client IP
  Address = 192.168.11.2/24

  ## if you have DNS server running
  # DNS = 192.168.11.1

  [Peer]
  PublicKey = YOUR_SERVER_PUBLIC_KEY

  ## to pass internet trafic 0.0.0.0 but for peer connection only use 192.168.11.0/24, or you can also specify comma separated IPs
  AllowedIPs =  0.0.0.0/0

  Endpoint = SERVER_PUBLIC_IP:51820
  #PersistentKeepalive = 20

systemctl start wg-quick@wg0
ip a show wg0
```
