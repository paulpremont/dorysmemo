==========================================================
                       T E S T S 
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    https://wiki.debian.org/LinuxRaidForAdmins
    https://raid.wiki.kernel.org/index.php/Detecting,_querying_and_testing
    http://www.tux-planet.fr/tester-la-vitesse-de-lecture-et-decriture-dun-disque-sous-linux/
    https://wiki.debian.org/LinuxRaidForAdmins?action=fullsearch&context=180&value=linkto%3A%22LinuxRaidForAdmins%22

~~~~~~~~~~~~~~~~~~~~~~~~~~
Performance
~~~~~~~~~~~~~~~~~~~~~~~~~~

    > apt-get install pv hdparm

    Lecture:

        exemples:

            > cat /dev/cciss/c0d1 | pv -r > /dev/null
            > hdparm -t -T /dev/sda

    Ecriture:

        > dd if=/dev/zero of=/tmp/test.data bs=1M count=1024 conv=fdatasync

        #Création de 1024 block de 1 mega

~~~~~~~~~~~~~~~~~~~~~~~~~~
Erreurs
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Avec testdisk
        > apt-get install testdisk

~~~~~~~~~~~~~~~~~~~~~~~~~~
RAID
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
DISKS
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
CACTI
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        subtitle 2
        --------------------------
                __________________________
                subtitle 3

                        subtitle 4
                        ``````````````````````````
