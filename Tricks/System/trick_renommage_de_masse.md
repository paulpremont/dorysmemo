# Comment renommer des fichiers en masse

## Tuto

```
# Créer un dossier de test :
mkdir /tmp/test
for f in $(ls); do touch /tmp/test/$f; done

# Essayez votre commande :
ls \[a-s\]_samurai_champloo_-_01_-_tempestuous_temperaments__rs2_\[1080p_bd-rip\]\[61FCD3EE\].mkv |sed 's/\(.*\)\(samurai_champloo\)_-_\([0-9][0-9]\)_-_\(.*\)__rs2.*/mv & \2_\3_\4\.mkv/'
ls * |sed 's/\(.*\)\(samurai_champloo\)_-_\([0-9][0-9]\)_-_\(.*\)__rs2.*/mv & \2_\3_\4\.mkv/'

# Appliquer la commande :
ls * |sed 's/\(.*\)\(samurai_champloo\)_-_\([0-9][0-9]\)_-_\(.*\)__rs2.*/mv & \2_\3_\4\.mkv/' |sh
```
