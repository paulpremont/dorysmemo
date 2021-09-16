===============================================================
         S A M B A       4
===============================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://wiki.samba.org/index.php/Samba_AD_DC_HOWTO
    http://www.ordiwiki.com/index.php/Samba4#Installation
    http://www.matrix44.net/cms/notes/gnulinux/samba-4-ad-domain-with-ubuntu-12-04
    http://dev.tranquil.it/index.php/SAMBA_-_Installation_d%27un_AD_Samba4_pour_un_nouveau_domaine
    https://wiki.samba.org/index.php/Samba4/InitScript
    http://albertolarripa.com/2012/08/12/samba4-installation-and-configuration/
    https://wiki.samba.org/index.php/3.0:_Initialization_LDAP_Database


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
AD DC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ----------------------
        Install
        ----------------------

                apt-get install samba4

                Depuis les sources:

                    apt-get install build-essential libacl1-dev libattr1-dev libblkid-dev libgnutls-dev libreadline-dev python-dev python-dnspython gdb pkg-config libpopt-dev libldap2-dev dnsutils libbsd-dev attr krb5-user docbook-xsl libcups2-dev

                    git clone git://git.samba.org/samba.git samba4
                    cd /samba4
                    git checklout v4-0-stable
                    ./configure --with-ads --with-shared-modules=idmap_ad
                    make
                    make install

                    en cas de mauvaise compilation:

                    make clean 
                    git clean -x -f -d

                    Tout est installé par défaut dans /usr/local/samba
                    Maj du path:
                        PATH=":/usr/local/samba/sbin:$PATH"
                        PATH=":/usr/local/samba/bin:$PATH"

        ----------------------
        Provisioning
        ----------------------

            A adapter en fonction du type d'installation

                > mv /etc/smb.conf /etc/smb.conf.back
                > samba-tool domain provision --help            #display help
                > samba-tool domain provision --use-rfc2307     #intercativ conf with standard object like posix account ...
                > --dns-backend=BIND9_DLZ : to configure with a BIND dns backend

                password requirements: one uppercase, one number, 8 char minimum.

                ou encore:

                samba-tool domain provision --use-ntvfs --domain NOM_DOMAIN --realm NOM_DOMAIN.local --adminpass monPASS --server-role dc --dns-backend=SAMBA_INTERNAL

        ----------------------
        Run deamon 
        ----------------------

                > samba

        ----------------------
        Client connectivity
        ----------------------

                > apt-get install samba4-clients
                > smbclient -L localhost -U%

                __________________
                Test auth:

                        > smbclient //localhost/netlogon -UAdministrator% -c 'ls'

        ----------------------
        Logs
        ----------------------

                Bien voir les logs pour les différents problèmes ;)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    PHP LDAP ADMIN : todo
        
