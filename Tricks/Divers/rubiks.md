# RUBIX CUBE SOLUTION

## Sources

- 3x3 : https://www.youtube.com/watch?v=uORbJS9bp54
- 3x3 : https://www.youtube.com/watch?v=WIDO5F0myj0
- 2x2 : https://www.youtube.com/watch?v=CYycCxzMrsU

## Rubiks 3x3

0. Algos principaux :

  RUR'U' (droite)
  L'U'LU (gauche)

1. Marguerite

  * Former une Marguerite : centre jaune et 4 pétales blanc sur chaque côté

*Note : avec uniquement le U et quelques R ou L il est possible de réaliser cette étape*

2. Croix Blanche

  * Garder la face jaune en haut du cube
  * Aligner les pétales avec leur couleur
  * Garder le pétale aligné dans la main droite et envoyer le vers le centre blanc (deux rotations)
  * Le faire pour chaque pétale et vérifier ensuite la croix blanche avec chaque arrête basse de la même couleur que le centre
  
3. Première ligne de même couleur

  * Face jaune en haut, identifier un coin avec la couleur blanche
  * Placer ce coin entre les deux couleurs dont les centres correspondent (le mettre dans sa main droite)
  * Envoyer le coin en bas dans le bon ordre (couleur sur couleur) en répétant :
  
    RU R'U'
    
4. Deuxième ligne de même couleur

  * Face jaune en haut
  * Identifier une arrête (ligne du haut) correspondante aux deux couleurs des faces adjacentes
  * Aligner cette arrête (droite ou gauche) avec la couleur de la bonne face
  * Deux cas de figures ensuite :
  
    - L'arrête est à gauche :
    
      On place la face de gauche en face de soit puis :
     
      U RU R'U' > changement de côté (face droite) > L'U'L
  
    - L'arrête est à droite
    
      On place la face de droite en face de soit puis :
      
      U' L'U' LU > change de côté (face gauche) > RUR'
      
   * Note si une des arrêtes correspond est inversée, il suffit d'y insérer une arrête (haut) jaune à la place avec la même formule.
      
5. Croix jaune :

  * Face jaune sur le dessus
  * Se placer sur une face jusqu'à obtenir une ligne.
    Lorsqu'une ligne est faite se mettre sur l'autre face pour former une deuxième ligne :
  
    F RU R'U' F'

  * Si un L jaune est formé, le garder dans le coin supérieur gauche (L inversé).

*Note : il est possible d'enchaîner plusieurs sexy move avant de refaire un F' de fin*
    
6. Arrêtes jaune :

  * Placer chaque arrête sur la couleur de face correspondante
  * Plusieurs cas de figure
    - Si deux couleurs déjà bien placées, mettre une bonne couleur derrière et l'autre à sa droite
    - Si deux couleurs opposées, mettre une bonne couleur devant soit
    
    RU R'U  R U'U'R'
    
7. Coins jaunes :

  * Placer les coins de la bonne couleur correspondante aux faces
    - Il suffit d'avoir les deux couleurs sans pour autant qu'elle soient dans le bon ordre à cette étape
    - Garder la même couleur entre face et arrête et trouver un coin qui est bien placé
  * Faire cet algo en gardant à sa droite un coin bien placé jusqu'à ce que tous les coins soient biens placés :

    L' URU' LU R'
    
8. Finir le cube

  * Mettre la face blanche en haut
  * Faire en sorte qu'un coin jaune soit à placer sur la face jaune (en bas à droite) et faire l'algo 
  * Bien garder la même face et tourner uniquement le bas jusqu'à placer un nouveau coin puis refaire l'aglo
    (Faire l'algo complet jusqu'à placer le coin jaune correctement)
  
    RU R'U'
    
  
## Rubiks 2x2

Même exercice que le 3x3 mais sans les étapes concernant les arrêtes (uniquement les coins)

1. Compléter une face 

  * En utilisant l'algo principal constituer une face avec toutes les couleurs bien placées :

    RU R'U'

2. Placer les coins

  * Pour placer les coins en mettant soit deux coins biens placés à l'arrière ou
  si deux en diagonal, mettre un des coins sur sa droite.

  [UR] [U'L'] [UR'] [U'L]

  [URU'] [L'UR'U'L]

3. Finir le cube

  * De la même manière que le 3x3

