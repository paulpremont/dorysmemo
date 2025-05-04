# Tutanota installation

## Install

https://tuta.com/fr#download

```
chmod +x tutanota-desktop-linux.AppImage
./tutanota-desktop-linux.AppImage
```

## Fix sandbox helper binary not configured correctly

```
vim ~/.local/share/applications/tutanota-desktop.desktop

  Exec=sh -c "/home/pol/AppImages/tutanota-desktop-linux.AppImage --no-sandbox" %U
```
