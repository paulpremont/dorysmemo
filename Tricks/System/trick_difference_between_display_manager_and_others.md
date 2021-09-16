# Faire la différence entre les types de managers (display, windows, login, desktop ...)

## Liens

[unix.stackexchange.com](http://unix.stackexchange.com/questions/20385/windows-managers-vs-login-managers-vs-display-managers-vs-desktop-environment)

## From the bottom up :

* Xorg, XFree86 and X11 are display servers. This creates the graphical environment.

* [gkx]dm (and others) are display managers. A login manager is a synonym. This is the first X program run by the system if the system (not the user) is starting X and allows you to log on to the local system, or network systems.

* A window manager controls the placement and decoration of windows. That is, the window border and controls are the decoration. Some of these are stand alone (WindowMaker, sawfish, fvwm, etc). Some depend on an accompanying desktop environment.

* A desktop environment such as XFCE, KDE or GNOME are a suite of applications designed to integrate well with each other to provide a consistent experience.
In theory (and mostly so in practice) any of those components are interchangeable. You can run kmail using GNOME with WindowMaker on Xorg.
