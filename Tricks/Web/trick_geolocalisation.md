# Géolocaliser une adresse IP

## Liens

[tutoriel](http://quick-tutoriel.com/288-geolocaliser-une-adresse-ip-publique-sous-ubuntu)

## Procédé avec geopip

1. installer geoip-bin

2. Télecharger la base de donnée (version gratuite)

    #sudo wget http://memo.premont.fr/downloads/GeoLiteCity.dat.gz
    sudo wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz

3. Décomprésser l'archive

4. Récupérer les informations	

    geoiplookup <IP> -f <Path_to_GeoLiteCity.dat>

## Autre méthode avec maxmind.com

    wget -qO- http://www.maxmind.com/app/locate_demo_ip?ips=SON_IP | grep "<t[hd]><font" > test.html

Cette méthode est limitée à 25 consultations par jour (ou il faut se créer un compte).
