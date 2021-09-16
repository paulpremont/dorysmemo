======================================
Se référencer - SEO (Search Engine Optimization)
======================================

~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~

        http://fr.openclassrooms.com/informatique/cours/le-referencement-de-son-site-web

~~~~~~~~~~~~~~
Les termes
~~~~~~~~~~~~~~

        Indexation: présence sur les moteurs de recherche
        Positionnement: la place sur les moteurs de recherche (premier/derniers..)

        référencement naturel : gratuit , la zone la plus en bas.
        référencement sponsorisée : pubs sur les moteurs de recherche (liens à droites et tout en haut)
        référencement payant : par une société tiers

        Le moteur de recherche:
                Il utilise des spiders, des robots pour collecter les pages web. (h24 7j/7)
                Il stock et indexe ces données.
                Il traite ensuite les requêtes clientes en fonction de leurs algorithme et en fonction des données en bases renvoie le bon résultat.

                crawlers: suit et collectes les liens fournis par les spiders

        Pour savoir quand une page a été indéxée, il faut cliqué sur 'En cache' et regarder les infos fournis.


~~~~~~~~~~~~~~
Google
~~~~~~~~~~~~~~

        Premier succès grâce aux backlink mettant en avant la popularité des sites

        stop words: les mots de liaison ne sont pas pris en compte par défaut lors d'une recherche mais ils comptent dans le positionnement des mots.
                "le chat" n'est donc pas indexé pareil que "chat". Pour le premier cas, il saura que chat est en deuxièmes positions.

                Pour faire une recherche tenant comptes des 'stop words', il faut la placer entre guillement.
                        "le chat"


        Les annuaires: bien que peu utilisé aujourd'hui, on peu s'en servir comme backlink pour accroitre la popularité de son site.

        Les mots clés : ils correspondent aux recherches directes des internautes.
                Il doivent prendre en compte l'activité, le volume de recherche et la concurrence.

        La longue traine: c'est le resultat des recherches des mots clés aux autres mots contenu dans son site.
                il faut donc avoir un code et un contenu de qualité pour optimiser son référencements.

        ________________
        La pratique:

                Bien définir ses mots clé grâce à AdWords

                        https://adwords.google.com/ko/KeywordPlanner/Home#search.none

                Voir la tendandes des mots clés avec google Insights

                        http://www.google.com/trends/

                Optimiser la balise <title>Des mots cibles</title> 

                Renseigner les meta
                        
                        Les keywords, pas plus d'une vingtaine et n'est peut être plus utilisé maintenant.
                        <meta name="keywords" content="motclé1, motclé2, ..." />

                        La description
                        <meta name ="description" content="Description de mon site en 1 prhase ou 2" />

                Bien reneigner les balises alt et title si possible.

                
                Réaliser un fichier sitemap contenant les urls du siteweb.
                        
                        au format .txt et xml       
                        http://www.sitemapdoc.com

                Ecrire le fichier robots.txt pour indiquer la marcheà suivre aux "gentils" robots.
                        
                        exemple:
                                User-Agent: *
                                Disallow:
                                sitemap: http://PATH_sitemap.xml

                        Il est aussi possible d'utiliser la balise meta name="robots" content="noindex"
