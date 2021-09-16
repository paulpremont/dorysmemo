# Comment supprimer la guest session

En fonction de son gestionnaire de bureau:

## Sous Xfce:

    vim /etc/lightdm/lightdm.conf

      [SeatDefaults]
      user-session=xfce #(or xubuntu, ubuntu ...)
      allow-guest=false

Restart lightdm :

    restart lightdm
