# HDMI's issues

## Erreur "connexion HDMI"

Problèmes de connexion HDMI:

### Liens :

* [unix.stackexchange.com](http://unix.stackexchange.com/questions/25120/xrandr-doesnt-detect-monitor-on-hdmi-port)
* [bbs.archlinux.org](https://bbs.archlinux.org/viewtopic.php?id=130734)
* [ubuntuforums.org](http://ubuntuforums.org/showthread.php?t=1657660&highlight=optimus)

### Résolution :

    lshdw -c video
    xrandr -q

Ou simplement voir au niveau du bios pour désactiver la carte Nvidia (résolu dans mon cas)
