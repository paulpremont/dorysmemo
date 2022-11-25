# Reset root password

## Ubuntu

1. Démarrer en mode recovery :

Appuyer sur la touche Echap jusqu'à obtenir le menu grub (juste après le logo de démarrage de la machine).
Pour les disques chiffrés, cette étape intervient avant le prompt.

Sélectionner la dernière version de kernel en mode recovery

2. Selectionner le mode "roor" dans la liste puis Entrée

3. Monter le FS en mode rw :

    mount –o rw,remount /

4. Changer le mot de passe :

    passwd username

5. Redémarrer :

    shutdown –r

Attendre quelques secondes avant le redémarrage.

## Sources

- https://phoenixnap.com/kb/how-to-change-root-password-linux
