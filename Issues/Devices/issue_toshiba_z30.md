# Toshiba z30's issues

## Erreur "temperature élevée"

Problème de temperature élevée (surconsommation du CPU)

### Liens

[phoronix.com](http://www.phoronix.com/scan.php?page=article&item=intel_i915_power&num=1)
[archlinux.org](https://bbs.archlinux.org/viewtopic.php?id=188340)
[archlinux.org](https://bbs.archlinux.org/viewtopic.php?id=132077)

### Résolution :

Si vous avez un problème de surconsommation CPU /surchauffe/ventillo qui tourne à fond sur votre portege z30 :

Il faut :

**1 vérifier la temperature actuelle :**

    apt-get install lm-sensors

Note : peut être aussi installer le paquet : acpi-call-dkms (pour le chargement du module acpi-call)
Mais je n'ai pas vraiment testé ce point.

Puis le lancer : (la première fois répondre à Yes partout pour générer la configuration)

    sensors

Constat : il fait chaud ! (environ 70C° pour ma part)

**2 Fix :**

    sudo vim /etc/default/grub

<!-- vim -->

    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pcie_aspm=force i915.i915_enable_rc6=1 i915.i915_enable_fbc=1 i915.lvds_downclock=1"

<!-- /vim -->

    sudo update-grub
    sudo reboot

Vous devriez constater deux choses :

* le ventillo va commencer à faire moins de bruit (le temps de dissiper la chaleur)
* la commande sensors devrait vous retourner quelque chose du genre 40°C :

OUTPUT :

    acpitz-virtual-0
    Adapter: Virtual device
    temp1:        +16.0°C  (crit = +107.0°C)

    coretemp-isa-0000
    Adapter: ISA adapter
    Physical id 0:  +43.0°C  (high = +105.0°C, crit = +105.0°C)
    Core 0:         +42.0°C  (high = +105.0°C, crit = +105.0°C)
    Core 1:         +42.0°C  (high = +105.0°C, crit = +105.0°C)
