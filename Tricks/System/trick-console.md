# Se connecter en console

## Prérequis :

### Accès

- Disposer du compte d'accès à l'appareil (selon l'appareil)
- Disposer d'un câble console selon la compatbilité avec l'appreil :
  * console (RJ45) vers USB-A (classique) => conseillé
  * console (Rj45) vers DB9 (+ éventuellement adaptateur RS232 à USB-A)
  * console micro-usb vers USB-A
  * etc...
- Disposer des droits root sur sa machine

### Logiciels

Plusieurs logiciels permettent de se connecter en série sur un appareil :

- putty
- minicom
- screen

### Connexion

Vérifier lorsque vous vous connecter sur l'appareil qu'il existe une entrée dans
dmesg :

```
sudo dmesg |grep tty
...
[21276.406938] pl2303 ttyUSB0: pl2303 converter now disconnected from ttyUSB0
[21707.798962] usb 3-1: pl2303 converter now attached to ttyUSB0
```

Donnez les droits dut la sortie tty pour la prise de main :

```
sudo chmod 666 /dev/ttyUSB0
```

Ouvrez votre logiciel préféré et connectez vous.

## Putty

Exemple avec putty :

1. Executer putty
2. Onglet Session > Cocher Serial en  Connection type > /dev/ttyUSB0
  * Régler éventuellement le Speed
3. Lancer la connexion

Exemple avec un switch Omada :

* /dev/ttyS0
* Speed : 38400

## Sources

**Linux**

* [How to](https://www.cyberciti.biz/hardware/5-linux-unix-commands-for-connecting-to-the-serial-console/)

**TP-Link Omada**

* [Omada FAQ - Accounts](https://www.tp-link.com/us/support/faq/893/)
* [Omada FAS - Reset](https://www.tp-link.com/us/support/faq/379/)
* [Omada FAS - Reset factory](https://www.tp-link.com/us/support/faq/3146/)
* [Omada FAS - Access](https://www.tp-link.com/us/support/faq/291/)
