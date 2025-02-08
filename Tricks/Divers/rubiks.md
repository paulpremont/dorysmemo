# RUBIX CUBE SOLUTION

## Sources

- https://www.youtube.com/watch?v=uORbJS9bp54
- https://www.youtube.com/watch?v=WIDO5F0myj0

## Déroulé

0. Algos principaux :

  RUR'U' (droite)
  L'U'LU (gauche)

1. Marguerite

  * Former une Marguerite : centre jaune et 4 pétales blanc sur chaque côté

2. Croix Blanche

  * Garder la face jaune en haut du cube
  * Aligner les pétales avec leur couleur
  * Garder le pétale aligné dans la main droite et envoyer le vers le centre blanc (deux rotations)
  * Le faire pour chaque pétale et vérifier ensuite la croix blanche avec chaque arrête basse de la même couleur que le centre
  
3. Première ligne de même couleur

  * Face jaune en haut, identifier un coin avec la couleur blanche
  * Placer ce coin entre les deux couleurs dont les centres correspondent (le mettre dans sa main droite)
  * Envoyer le coin en bas dans le bon ordre (couleur sur couleur) en répétant :
  
    RUR'U'
    
4. Deuxième ligne de même couleur

  * Face jaune en haut
  * Identifier une arrête (ligne du haut) correspondante aux deux couleurs des faces adjacentes
  * Aligner cette arrête (droite ou gauche) avec la couleur de la bonne face
  * Deux cas de figures ensuite :
  
    - L'arrête est à gauche :
    
      On place la face de gauche en face de soit puis :
     
      U RUR'U' > changement de côté (face droite) > L'U'L
  
    - L'arrête est à droite
    
      On place la face de droite en face de soit puis :
      
      U' L'U'LU > change de côté (face gauche) > RUR'
      
   * Note si une des arrêtes correspond est inversée, il suffit d'y insérer une arrête (haut) jaune à la place avec la même formule.
      
5. Croix jaune :

  * Se placer sur une face jusqu'à obtenir une ligne.
    Lorsqu'une ligne est faite se mettre sur l'autre face pour former une deuxième ligne :
  
    F RUR'U' F'
    
6. Arrêtes jaune :

  * Placer chaque arrête sur la couleur de face correspondante
  * Plusieurs cas de figure
    - Si deux couleurs déjà bien placées, mettre une bonne couleur derrière et l'autre à sa droite
    - Si deux couleurs opposées, mettre une bonne couleur devant soit
    
    RUR'U  R U'U'R'
    
7. Coins jaunes :

  * Placer les coins de la bonne couleur correspondante aux faces
    - Il suffit d'avoir les deux couleurs sans pour autant qu'elle soient dans le bon ordre à cette étape
    - Garder la même couleur entre face et arrête et trouver un coin qui est bien placé
  * Faire cet algo en gardant à sa droite un coin bien placé jusqu'à ce que tous les coins soient biens placés :

    L' UR U' LU R'
    
8. Finir le cube

  * Mettre la face blanche en haut
  * Faire en sorte qu'un coin jaune soit à placer sur la face jaune (en bas à droite) et faire l'algo 
  * Bien garder la même face et tourner uniquement le bas jusqu'à placer un nouveau coin puis refaire l'aglo
    (Faire l'algo complet jusqu'à placer le coin jaune correctement)
  
    RUR'U'
    
  
