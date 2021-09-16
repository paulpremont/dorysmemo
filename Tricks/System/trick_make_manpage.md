# Créer son propre man

1 Créer sa manpage selon une syntaxe bien particulière (voir exemple dans /usr/share/man):
-----------------

Pour afficher un manuel en .gz :

    zcat nom_manuel.X.gz

Ecrire son manuel pour une section particulière :

    vim commande.X 	
    
Avec X le numéro de la section (voir mon mémo sur les commandes ou "man man" pour plus d'info sur les sections). 

**Exemple :**

    .\" Manpage for commande					                      #Titre du manuel
    .\" Contacter paul@npremont.fr pour se pleindre.		
    .TH man 5 "06 May 2010" "1.0" "Manuel de la commande"		#Section (man X), date, version et titre du manuel
    .SH NAME							                                  #.SH : annonce d'une sous partie.
    commande \- Très courte description				
    .SH SYNOPSIS							
    commmande [argument]						
    .SH DESCRIPTION							
    Ici on décrit la commande avec plus de détails, sur ce qu'elle fait.
    .SH OPTIONS							
    liste des commandes liées à la commande.
    .SH BUGS							
    Des bugs connus à décrire?
    .SH AUTHOR							
    Prémont Paul (@mail)

2 Voir le rendu
-----------------

    man ./commande.man

<!-- output -->


    man(5)                                   Manuel de la commande                                  man(5)
    
    NAME
           commande - Très courte description
    
    SYNOPSIS
           commmande [argument]
    
    DESCRIPTION
           Ici on décrit la commande avec plus de détails, sur ce qu'elle fait.
    
    OPTIONS
           liste des commandes liées à la commande.
    
    BUGS
           Des bugs connus à décrire?
    
    AUTHOR
           Prémont Paul (@mail)
    
    1.0                                           06 May 2010                                       man(5)
     Manual page commande.man line 1/25 (END) (press h for help or q to quit)


3 Installer son man
-----------------

Pour installer son man, il faut le placer en .gz dans un PATH reconnu par la commande man 
(éditer le fichier **/etc/manpath.config** pour ajouter des paths).

    cp commande.5 /usr/local/man/man5/
    gzip /usr/local/man/man5/commande.5

ou 

	  install -g 0 -o 0 -m 0644 commande.5 /usr/local/man/man5
	  gzip /usr/local/man/man5/commande.5

4 Finaliser
-----------------

Pour finir le test 

    man commande
