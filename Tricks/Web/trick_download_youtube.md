# Comment télécharger simplement sur youtube

Il existe un outils simple d'utilisation pour se faire : youtube-dl

## Lien

[youtube-dl](https://github.com/rg3/youtube-dl/blob/master/README.md#how-do-i-update-youtube-dl)

## Install

    sudo pip install youtube-dl

## Mettre à jour

    sudo pip install -U youtube-dl

## Téléchargement

### La vidéo en entière :

    youtube-dl <http link>

### Uniquement l'audio :

    youtube-dl --extract-audio --audio-format mp3 <video URL>
