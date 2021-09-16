# Exporter automatiquement les bookmarks:

## Firefox

Via l'interface :

    about:config
        Search: browser.bookmarks.autoExportHTML
        #Passer la valeur à True

Manuellement :

Aller dans le dossier de config de mozilla.

Exemple :

~/.mozilla/firefox/e1f5ld9.default

et éditer la même ligne dans 'prefs.js'

    user_pref("browser.bookmarks.autoExportHTML", true);

Dump :

Le fichier bookmarks.html apprait alors dans le dossier de configuration.
Il est mis à jour après chaque fermeture du browser.
Il suffit ensuite de le backuper avec un script utilisant rsync par exemple.


## Chromium

Mis à part la méthode graphique pour l'exportation, il n'y a que le fichier Bookmarks disponible dans le dossier de configuration (~/.config/chromium/Default)

