# Comment renommer des fichiers en masse

Source : https://www.youtube.com/watch?v=e0T1uTUVZgY

## Avec rename

```
rename 's/CHAINE A MODIFIER//' *.mon-extension

# exemple :

ls

fichier.2013.v01.foo.fifoo.180h.100b.foolight.ah2000-foo.txt
fichier.2013.v02.foo.fifoo.180h.100b.foolight.ah2000-foo.txt
fichier.2013.v03.foo.fifoo.180h.100b.foolight.ah2000-foo.txt

rename 's/.foo.*\-foo//' *.txt

ls

fichier.2013.v01.txt
fichier.2013.v02.txt
fichier.2013.v03.txt
```

## Avec sed

**théorie**
On divise la chaîne en blocs et on substitue :
  ls MESFICHIERS |sed 's/(BLOC1)(BLOC2)/mv MACHAINE BLOC1.extension/'

Le BLOC1 peut être tout le début de la chaîne : \(.*\)
Le BLOC2 peut être toute la fin de la chaîne à supprimer : \(FINTEXT.txt\)

**tester**
ls *.txt |sed 's/\(.*\)\(.foo.fifoo.*\-foo.txt\)/mv & \1/'

**appliquer**
ls *.txt |sed 's/\(.*\)\(.foo.fifoo.*\-foo.txt\)/mv & \1/' |sh

```
# exemple :

ls

fichier.2013.v01.foo.fifoo.180h.100b.foolight.ah2000-foo.txt
fichier.2013.v02.foo.fifoo.180h.100b.foolight.ah2000-foo.txt
fichier.2013.v03.foo.fifoo.180h.100b.foolight.ah2000-foo.txt

ls *.txt |sed 's/\(.*\)\(.foo.fifoo.*\-foo.txt\)/mv & \1/'
ls *.txt |sed 's/\(.*\)\(.foo.fifoo.*\-foo.txt\)/mv & \1/' |sh

ls

fichier.2013.v01.txt
fichier.2013.v02.txt
fichier.2013.v03.txt
```
