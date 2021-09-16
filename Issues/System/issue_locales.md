# Locale's issues

## Erreur :


    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
        LANGUAGE = "fr_FR.UTF-8",
        LC_ALL = "fr_FR.UTF-8",
        LANG = "fr_FR.UTF-8"
        are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").
    locale: Cannot set LC_CTYPE to default locale: No such file or directory
    locale: Cannot set LC_MESSAGES to default locale: No such file or directory
    locale: Cannot set LC_ALL to default locale: No such file or directory

### Lien :

[quennec.fr](http://www.quennec.fr/gnulinux/commandes/ubuntu-server/erreur-perl-warning-setting-locale-failed)

### Résolution :

    vim /etc/locale.gen

<!-- vim -->

    fr_FR.UTF-8 UTF-8
    fr_FR ISO-8859-1

<!-- /vim -->

    locale-gen

et/ou ?

    dpkg-reconfigure [-f noninteractive] locales
