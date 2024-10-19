# Monter une partition RAID

## Contexte

retrouver les données d'un disque en RAID + lvm2

## Actions

```
sudo fdisk -l  # repérer le disk à monter
sudo mount /dev/sda3 /mnt/ #mount: unknown filesystem type 'linux_raid_member'
sudo mdadm --assemble --run /dev/md0 /dev/sda3 #on créer un point de montage à partir d'un volume RAID
sudo mount /dev/md0 /mnt/ #mount unknown filesystem type 'lvm2_member'
sudo vgdisplay
sudo vgrename VGID mml # il est possible de renommer le volum group pour faciliter la suite
sudo vgscan
sudo vgchange -ay mml
sudo lvs
sudo mount /dev/mml/c /mnt/
```
