http://www.tomshardware.fr/articles/root-android-rom-smartphone,2-837-2.html
http://www.addictivetrick.com/mobile/android-partitions-explained-boot-system-recovery-data-cache-misc/
http://www.flashmyandroid.com/forum/showthread.php?4119-RECOVERY-Max-M9-v2-ClockWorkMod-v6-0-3-1
http://forum.frandroid.com/topic/180947-pipo-m9pro-ne-d%C3%A9marre-plus/
http://developer.ubuntu.com/start/ubuntu-for-devices/installing-ubuntu-for-devices/
http://www.pipo-m9.info/article/how-root-pipo-m9-using-ubuntu-linux
http://wiki.radxa.com/Rock/flash_the_image#Linux
http://tablette-chinoise.net/firmwares-pipo-m9-les-liens-t1515/page50.html

# dmesg 
Should return something like this: 
[45441.193934] usb 2-1.3: new high-speed USB device number 12 using ehci-pci 
[45441.286976] usb 2-1.3: New USB device found, idVendor=2207, idProduct=0010 
[45441.286983] usb 2-1.3: New USB device strings: Mfr=2, Product=3, SerialNumber=4 
[45441.286987] usb 2-1.3: Product: M9 
[45441.286991] usb 2-1.3: Manufacturer: rockchip 
[45441.286994] usb 2-1.3: SerialNumber: KI8VAVXFUD
 
 4. Get the udev rolling 
 # sudo gedit /etc/udev/rules.d/99-android.rules 
 paste this text:
 SUBSYSTEMS=="usb", ATTRS{idVendor}=="2207", ATTRS{idProduct}=="0010", MODE="0660", OWNER="root"
  

  # service udev restart
  # udevadm control --reload-rules
  # mkdir ~/.android
  # echo "0x2207" > ~/.android/adb_usb.ini

Replugguer l'appareil:

# adb kill-server
# adb devices 
Should return this:



List of devices attached 
