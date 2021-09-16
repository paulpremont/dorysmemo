# Cryptsetup's issues

## Erreur "code 239"

Message :

    cryptsetup code 239:

### Résolution

Il semblerait que la table de mapage n'ait pas été libérée:
(la référence entre majeu et mineur doit suremnt encore existée)

Du moins c'est comme ça que je l'ai interprété :p :

    dmsetup remove /dev/mapper/udisks-luks-uuid-a6b11aab-f424-415e-bbf1-ff05f11b82d7-uid500

Note : le udisks-luks-.... est à remplacer selon votre cas.

## Erreur "saisie mot de passe"

Message :

    Impossible de saisir le mot de passe pour déchiffrer son disque au démarrage :

### Résolution

Il semblerait qu'il y ait un problème de saisie dû à la configuration du grub ?

Le fix possible est supprimer l'option "quiet-splash"

    sudo vim /etc/default/grub

      #GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
      GRUB_CMDLINE_LINUX_DEFAULT=

    sudo update-grub
