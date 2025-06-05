# Convertir un png en svg et inversement

## Méthode

Exemple :

export d'une image .png via Gimp

## Avec inkscape :

D'un png vers un svg

```
sudo apt install inkscape

inkscape input.png --export-type=svg --export-filename=output.svg
```

D'un svg vers un png :

```
inkscape -z -w 1024 -h 1024 input.svg -e output.png
```
