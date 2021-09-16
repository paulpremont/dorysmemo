Créer ses RPM
==============================

Links
-----------------------------

Official link :

[rpm.org](http://www.rpm.org/wiki/TracGuide)

Environnement :

[doc.fedora](http://doc.fedora-fr.org/wiki/RPM_:_environnement_de_construction)

Specs :

[doc.fedora](http://doc.fedora-fr.org/wiki/La_cr%C3%A9ation_de_RPM_pour_les_nuls_:_Cr%C3%A9ation_du_fichier_SPEC_et_du_Paquetage)

Licences :

[fedoraproject](https://fedoraproject.org/wiki/Archive:PackagingDrafts/LicenseTag?rd=PackagingDrafts/LicenseTag)

Tutos :

[rpm.org](http://www.rpm.org/max-rpm/)

Understand :

[ibm.com](http://www.ibm.com/developerworks/library/l-rpm2/)


Pourquoi faire ?
-----------------------------

Créer des RPM est la meilleure méthode pour distribuer ses programmes compilés.

How it works?
-----------------------------

Pour builder un RPM, il faut créer un environnement de build (arborescence système)
et un fichier spec qui va servir de configuration (Où installer les packages? Quelles dépendances? ...).

Créer un environnement
-----------------------------

### Créer un user pour les builds

    su -
    useradd builder
    passwd builder
    su - builder


### Installation des outils

* Prérequis :

    yum install bash bzip2 coreutils cpio diffutils fedora-release gzip tar unzip zip
    yum install gcc gcc-c++ make patch perl rpm-build redhat-rpm-config sed
    yum install gpg rpm-sign

* Tools de build :

    yum install rpmdevtools yum-utils


### Créer l'arborescence

(En user builder)

    rpmdev-setuptree

Devrait donner :

    rpmbuild/
    |-- BUILD       # Pour la décompréssion des archives
    |-- RPMS        # RPM binaires construits
    |-- SOURCES     # Sources, Archives, Patchs
    |-- SPECS       # fichiers .spec (Instructions de construction)
    `-- SRPMS       # RPM sources construits
    .rpmmacros      # Fichier de paramétrage

#### Macros (.rpmmacros) :

    %_topdir        : sommet de l'arborescence utilisé
    %_smp_mflags    : compiler en parallèle (multi-processeur)
    %vendor         : Nom   (à ne pas renseigner pour les dépôts off)
    %packager       : Plus d'info (idem)
    %dist           : nom distribution
    ...

### Générér une signature GPG

#### Dossier de configuration :

$HOME/.gnupg

#### Créer une clé :

    gpg --gen-key

Les valeurs par défaut sont supportées.

#### Mettre à jour le .rpmmacros :

    %_signature             gpg
    %_gpg_name              Votre Nom
    %_gpg_path              %(echo $HOME)/.gnupg

#### Exporter et partager sa clé pub :

    gpg --export --armor >RPM-GPG-KEY-votrenom

#### Importer la clé sur un client :

    rpm --import ~builder/RPM-GPG-KEY-votrenom


### Construire un rpm

#### Obtenir un fichier src (Exemple) :

    wget http://vault.centos.org/7.1.1503/os/Source/SPackages/less-458-8.el7.src.rpm

#### A partir du fichier src.rpm :

    rpmbuild --rebuild less-458-8.el7.src.rpm

Si cette commande fait référence à des dépendances, on peut les reconstruire :

    yum-builddep less-458-8.el7.src.rpm -y        # (en root)

Ce qui devrait donner :

    |-- RPMS
    |   `-- x86_64
    |       |-- less-458-8.el7.centos.x86_64.rpm
    |       `-- less-debuginfo-458-8.el7.centos.x86_64.rpm

#### A partir du fichier spec :

##### Dumper les sources :

    rpm -ivh less-458-8.el7.src.rpm

Ce qui devrait donner :

    |-- SOURCES
    |   |-- less-394-search.patch
    |   |-- less-394-time.patch
    |   |-- less-418-fsync.patch
    |   |-- less-436-help.patch
    |   |-- less-436-manpage-add-old-bot-option.patch
    |   |-- less-444-Foption.v2.patch
    |   |-- less-458-less-filters-man.patch
    |   |-- less-458-lessecho-usage.patch
    |   |-- less-458-lesskey-usage.patch
    |   |-- less-458-old-bot-in-help.patch
    |   |-- less-458.tar.gz
    |   |-- less.csh
    |   |-- less.sh
    |   `-- lesspipe.sh
    |-- SPECS
    |   `-- less.spec

##### Construire le rpm et le src.rpm :

    rpmbuild -ba rpmbuild/SPECS/less.spec

On devrait avoir les fichiers de création (make) dans :

    |-- BUILD
    |   `-- less-458

Le rpm et le src.rpm dans :

    |-- RPMS
    |   `-- x86_64
    |       |-- less-458-8.el7.centos.x86_64.rpm
    |       `-- less-debuginfo-458-8.el7.centos.x86_64.rpm
    `-- SRPMS
        `-- less-458-8.el7.centos.src.rpm


### Signer ses RPM

Une fois le rpm testé, ajouter sa signature :

    rpmsign --addsign rpmbuild/RPMS/x86_64/less-458-8.el7.centos.x86_64.rpm

Vérifier :

    rpm -K --nosignature rpmbuild/RPMS/x86_64/less-458-8.el7.centos.x86_64.rpm


Créer un fichier SPEC
-----------------------------

### Une nouvelle spec vierge

/!\ Certain paquets ont besoin d'un modèle de SPEC spécifique.
Voir la liste des Specs :

    ls /etc/rpmdevtools/spectemplate-*.spec

C'est le fichier spectemplate-minimal.spec qui est utilisé par défaut

Autrement :

    su - builder
    cd rpmbuild/SPECS
    rpmdev-newspec newSpec

On peut spécifier un autre modèle :

    rpmdev-newspec -t {template} nomSpec

En tête

    Name            : Nom du fichier
    Version         : version du logiciel (Numérique)
    Release         : Sous-Version (ex : 0.1.rc2%{?dist} )
    Summary         : Description bréve
    Group           : Groupe d'application (voir : > cat /usr/share/doc/rpm-*/GROUPS )
    Licence         : Type de Licence (ex : MPLv1.1 or GPLv2+ )
    URL             : Site web du logiciel
    Source0         : Lien web vers le logiciel
    BuildRoot       : Indique que le paquet peut être installé dans un dossier définit par l'utilisateur (ne pas changer idéalement)
    %description    : description complete du paquet (pas plus de 79 caractères)


### Dépendances

L'intérêt d'un gestionnaire de paquet c'est qu'il gère lui même les dépendances des paquets externes.

Il faut donc spécifier les dépendances "unique" de son logiciel.

Il existe deux types de dépendances :

* de compilation
* d'utilisation/d'installation

#### Dépendances de compilation (BuildRequires ou BR) :

(Permetant de contruire le paquet)
On peut en mettre autant que l'on veut.
Elles se terminent souvent pas *-devel :

Exemple :

    BuildRequires: ncurses-devel
    BuildRequires: autoconf automake libtool

##### Voir les dépendances de compilation d'un paquet

    su -lc 'yum-builddep nomdupaquet' #(en root)

#### Dépendances d'installation (Requires) :

Ce sont les dépendances externes qui decront être installées pendant l'installation.

Exemple :

    Requires: groff-base

##### Voir les dépendances d'installation d'un paquet

    rpm -qp --requires paquet.rpm
ou
    rpm -q --requires paquet

### Macros

Les macros sont disponibles dans :

* /usr/lib/rpm/macros
* /usr/lib/rpm/i386-linux/macros
* /etc/rpm/macros.*

### Sections

#### %prep :

Dédiée à la préparation de l'empaquetage.
Décompression des sources, application des patchs présent dans les sources :

Exemple :

    %setup -q
    %patch1 -p1 -b .Foption
    %patch2 -p1 -b .search

#### %build :

Dédiée à la compilation du logiciel.
./configure, make ...

Exemple :

    %configure
    make CC="gcc $RPM_OPT_FLAGS -D_GNU_SOURCE -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64" datadir=%{_docdir}

#### %install :

Dédiée à l'installation de ses fichiers sur le système :

Exemple :

    rm -rf $RPM_BUILD_ROOT
    make DESTDIR=$RPM_BUILD_ROOT install
    mkdir -p $RPM_BUILD_ROOT/etc/profile.d
    install -p -c -m 755 %{SOURCE1} $RPM_BUILD_ROOT/%{_bindir}


#### %files :

C'est dans cette section que l'on liste le scope de l'application.
Quels fichiers seronts installés/gérés par l'application.

Evite les erreurs du type :

    RPM build errors:
       Installed (but unpackaged) file(s) found

Exemple :

    %defattr(-,root,root,-)
    %doc LICENSE
    /etc/profile.d/*
    %{_bindir}/*
    %{_mandir}/man1/*

Vérifier si un path est géré par un paquet :

    rpm -qf monPath

#### %changelog :

Indique les modifications apportées au fichier.

Exemple :

    * Mon Feb 03 2014 Jozef Mlich <jmlich@redhat.com> - 458-8
    - changes introduced in less-458-old-bot-in-help.patch
      wasn't compiled in. It is necessary to use mkhelp tool.
      Resolves: #948597

Fichiers de langues :

TODO


#### Fichiers graphiques :

TODO


### Ordre

#### Installation :

1. %pre
2. %install
3. %post

#### Upgrade :

1. %pre (du nouveau)
2. %post (du nouveau)
3. %preun (de l'ancien)
4. %postun (de l'ancien)

Note :

Si l'on veux executer des action dans le nouveau rpm en relation avec l'upgrade, il faut utiliser la valeur passée en argument :


    %pre
    if [ "$1" = "1" ]; then
      # Perform tasks to prepare for the initial installation
    elif [ "$1" = "2" ]; then
      # Perform whatever maintenance must occur before the upgrade begins
    fi

La section %pre est installée

### Construction d'un paquet

#### 1 - Récupération des sources :

Exemple :

    wget url_from_source0.tar.gz ~/rpmbuild/SOURCES/

#### 2 - Processus de construction :

Dépaqueter et appliquer des patchs :

    rpmbuild -bp monFichier.spec

Compiler :

    rpmbuild -bc --short-circuit monFichier.spec

Empaqueter

    rpmbuild -bi --short-circuit monFichier.spec

Construire les RPM :

    rpmbuild -ba monFichier.spec

### Correctifs / Patches

Ce sont les modifications apportées aux sources (on ne les modifies jamais directement).

#### Générer un patch :

(Si on utilise pas d'outil de gestion de version)
On copie le fichier original pour faire des modifications

    cp monFichier monFichier.back

On peut ensuite modifier l'original

On génère le diff :

    cd ~/rpmbuild/BUILD
    gendiff monDossier .back > ../SOURCES/appName-version-modifTitle.patch

On inclue le patch dans les SPECS

    vim ~/rpmbuild/SPECS/monFichier.spec

      #Il faut dabord déclarer le nouveau patch :
      Patch0:     %{name}-version-modifTitle.patch

      #Puis on l'applique :
      %patch0 -p1 -b .modifTitle


### Contrôler

#### rpmlint

rpmlint à appliquer sur tout les paquetes nouvellement crées :

Exemple :

    rpmlint ~/rpmbuild/{RPMS|SRPMS}/paquet.{src.rpm|rpm}

#### rpmdevtools

Utilitaires de diagnostic

Lister les fichier associés à un paquet :

    rpmls /path/to/package
ou
    rpmfile /path/to/package #(octal mode)

Voir les diff entre deux paquets :

    rpmdiff /old/package /new/package

Lister les libs et les sonames d'un package :

    rpmsoname /path/to/Package

#### mock

TODO

Troubleshooting
-----------------------------

### Impossible d'entrer un mot de passe durant la génération d'une clé gpg

#### Lien :

[bugzilla](https://bugzilla.redhat.com/show_bug.cgi?id=659512)

#### Logs :

    "You need a Passphrase to protect your secret key."

#### Environnement:

Docker (centos:7)

#### Résolution:

* Le package pinentry doit être installé
* Droit d'accès sur le tty courant :

La commande 'su' n'ouvre pas de nouveau tty avec les droits de l'utilisateur.

Obligé de lancer la commande en root : (en attendant de trouver mieux)

    gpg --gen-key

et de copier les clés dans le .gnupg de l'utilisateur builder.

### GPG - Problème d'entropy

Pour éviter les problèmes d'entropy (difficulté à générer des bit aléatoires)
Commande bloquée sur la génération de la clé :

    cat /proc/sys/kernel/random/entropy_avail
    yum install rng-tools
    rngd -r /dev/urandom      (sur Centos problème de readonly)

Sur Docker, générer de l'activité sur l'hôte devrait suffir, (yum update, ou encore installer un nouveau paquet ...)
