Si vous avez des erreur du type :

bluetoothd[4833]: Unable to select SEP

Il faut (peut être) ajouter quelque paquet :

 > apt-get install pulseaudio-module-bluetooth bluez-tools



Et certainement configurer votre fichier /etc/bluetooth/audio.conf ainsi :

    > vim /etc/bluetooth/audio.conf

        # Configuration file for the audio service

        # This section contains options which are not specific to any
        # particular interface
        [General]

        # Switch to master role for incoming connections (defaults to true)
        #Master=true

        # If we want to disable support for specific services
        # Defaults to supporting all implemented services
        #Disable=Gateway,Source,Socket

        # SCO routing. Either PCM or HCI (in which case audio is routed to/from ALSA)
        # Defaults to HCI
        SCORouting=PCM
        #SCORouting=HCI

        # Automatically connect both A2DP and HFP/HSP profiles for incoming
        # connections. Some headsets that support both profiles will only connect the
        # other one automatically so the default setting of true is usually a good
        # idea.
        #AutoConnect=true
        AutoConnect=true

        # Headset interface specific options (i.e. options which affect how the audio
        # service interacts with remote headset devices)
        [Headset]

        # Set to true to support HFP, false means only HSP is supported
        # Defaults to true
        #HFP=true

        # Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
        #MaxConnected=1

        # Set to true to enable use of fast connectable mode (faster page scanning)
        # for HFP when incoming call starts. Default settings are restored after
        # call is answered or rejected. Page scan interval is much shorter and page
        # scan type changed to interlaced. Such allows faster connection initiated
        # by a headset.
        FastConnectable=false

        # Just an example of potential config options for the other interfaces
        [A2DP]
        SBCSources=1
        MPEG12Sources=0


La connexion peut ensuite se faire via l'interface graphique (bluetooth > device > se connecter au headset service)

ou via les tools :

    Exemple :

         > bt-device -l
         > bt-audio -c @MACDEVICE zz

Et au final on redémarre le daemon pulseaudio :

    > pulseaudio -k

Pour augmenter la qualité du headset, il faut appliquer le profil A2DP au niveau de la conf bluetooth
et via les settings de pulseaudio.
