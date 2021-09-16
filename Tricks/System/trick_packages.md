# Quelques astuces de manipulation des packages

Script pour avoir les dépendances d'un package :
---------------------

[tuxradar](http://www.tuxradar.com/answers/517)

    apt-get --print-uris --yes install MYPKG | grep ^\' | cut -d\' -f2 > downloads.list
    wget --input-file downloads.list

Site internet indispensable pour générer sa liste de repo:
---------------------

[repogen](http://repogen.simplylinux.ch/)
