# Logitech m560's issues

## Erreur "Mauvaise attribution des boutons"

Mauvaise attribution des boutons

## Lien

[forums.archlinux.fr](https://forums.archlinux.fr/viewtopic.php?t=14987)

## Résolution

    vim /etc/udev/hwdb.d/90-logitech-m-560.hwdb

      # Logitech M-560
      keyboard:usb:v046DpC52B*
       KEYBOARD_KEY_90001=middle              # Middle Button map to Middle
       KEYBOARD_KEY_700E2=reserved           # Will Send leftalt when move left with middle button click
       KEYBOARD_KEY_70072=reserved            # Will send f23 when move left with middle button click
       KEYBOARD_KEY_700E3=reserved            # Will Send leftmeta when move right with middle button click. Also is sent when use Back button.
       KEYBOARD_KEY_7002B=reserved            # Will Send tab when move right with middle button click
       KEYBOARD_KEY_90004=left                # Left Scroll Click map to Left
       KEYBOARD_KEY_90005=right               # Right Scroll Click map to Right
       KEYBOARD_KEY_70007=back                # Back button sends second keycode. 700E3 is the first and already mapped.
       KEYBOARD_KEY_700E7=forward             # Forward button map to Forward

    udevadm hwdb --update
    reboot
