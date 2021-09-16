# Skype's issues

## Erreur "pas de son"

Pas de son sur skype

### Lien :

[freedesktop.org](http://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/PerfectSetup/#Skype)

### Résolution :

    sudo sed -i 's/^Exec=.*/Exec=env PULSE_LATENCY_MSEC=30 skype %U/' /usr/share/applications/skype.desktop
    env PULSE_LATENCY_MSEC=30 skype
