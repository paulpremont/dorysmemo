Pour lire tranquillement ses vidéos sous netflix, le plus simple :

#Installer chrome stable :
 
 wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
 sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
 sudo apt-get update
 sudo apt-get install google-chrome-stable

#Note : le lancer à travers un proxy :
exemple :
    > google-chrome-stable --proxy-server="socks5://localhost:8080" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"

    (même options que pour chromium)
