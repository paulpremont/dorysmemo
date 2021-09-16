==========================================================
                       L a T e X
==========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~
Links
~~~~~~~~~~~~~~~~~~~~~~~~~~

    http://www.tuteurs.ens.fr/logiciels/latex/latex.html
    http://latex.developpez.com/
    http://doc.ubuntu-fr.org/latex
    http://www.xm1math.net/texmaker/index_fr.html
    http://fr.openclassrooms.com/informatique/cours/redigez-des-documents-de-qualite-avec-latex/qu-est-ce-que-latex

~~~~~~~~~~~~~~~~~~~~~~~~~~
What is it?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    Un langage de description dans l'optique de séparer le contenu de la forme.
    Le but étant d'optimiser le processus de mise en forme et gagner du temps par rapport à un soft classique type word.
    On gagne aussi en performance (pas besoin de charger toute la maise en page lors de l'édition).

    Il est possible de générer des PDF et PostScript à partir de latex.

~~~~~~~~~~~~~~~~~~~~~~~~~~
How it works?
~~~~~~~~~~~~~~~~~~~~~~~~~~

    __________________________
    Workflow:

        écriture du code (éditeur), génération d'un .tex
        compilation (packages) (<- fichier de conf, lib ...)
            -> transformation en .ps, .pdf, .dvi ...

~~~~~~~~~~~~~~~~~~~~~~~~~~
Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~
        Pour les présentations:
            latex-beamer

	-------------------------
	Le compilateur: (distribution)
	-------------------------
                __________________________
                Ubuntu: 

                        > apt-get install texlive texlive-lang-french texlive-latex-extra
                        ou plus bourin:

                        > apt-get install texlive-full
        
                __________________________
                Windoobe:

                        Voir le soft Texmaker

	-------------------------
	Les éditeurs
	-------------------------

            Kile:
                apt-get install kile

            vim:
                apt-get install vim-latexsuite

	-------------------------
	Les lecteurs
	-------------------------

            pdf:
                apt-get install xpdf

            dvi:
                apt-get install xdvi

~~~~~~~~~~~~~~~~~~~~~~~~~~
Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~
Manipulations
~~~~~~~~~~~~~~~~~~~~~~~~~~
	-------------------------
	Compiler
	-------------------------

            Directement en dvi:

                > latex file.tex


            Directement en pdf:

                > pdflatex file.tex

	-------------------------
	Convertir
	-------------------------

            en postscript:

                > dvips -o file.dvi

            postscript en pdf:

                >ps2pdf file.ps

            .tex -> 

	-------------------------
	Lire
	-------------------------

            Exemples (à adapter selon ses softs)

                Un .dvi

                    > xdvi file.dvi

                    imprimer:
                        > dvips file.dvi

                UN .pdf

                    > xpdf file.pdf

        
~~~~~~~~~~~~~~~~~~~~~~~~~~
Le code
~~~~~~~~~~~~~~~~~~~~~~~~~~

        --------------------------
        Minimum
        --------------------------

            \documentclass{article}

            \begin{document}
            C'est du latex, beat it
            \end{document}

        --------------------------
        Commentaires
        --------------------------

            %Mon comm

        --------------------------
        Packages
        --------------------------

            Pour importer un package et étendre les fonctionnalités de latex:

                \usepackage[option]{type}

                exemple:
                    
                    %Caractères clavier
                    \usepackage[utf8]{inputenc}
                    \usepackage[T1]{fontenc}        %pour les mots accentués

                    %langage utilisé
                    \usepackage[francais]{babel}

        --------------------------
        Classes de documents (Gabarits)
        --------------------------
            
            \documentclass[options, ...]{type de document}

            Détermine le format de la page, taille des polices par défauts ...
            (Tout ce qui concerne l'agencement de base)
            
            \documentclass{article} : Article (scientifique)
            \documentclass{book}    : Livres
            \documentclass{letter}  : Format Lettre
            \documentclass{report}  : Rapports, (thèses ...)

            options de documentclass:

                Valeurs                     Description [Défaut]

                a4paper, letterpaper ...: format du papier [letterpaper]
                10pt, 11pt              : taille de police [10pt]
                onecolumn, twocolumn    : colonnes [onecolumn]
                alignement équations    : fleqn [centré]
                1ere page chapitres     : openay, openright [openright]
                Recto/verso             : oneside, twoside [oneside]
                                                    book : twoside

        --------------------------
        Commandes babel, customisation du texte
        --------------------------

            \usepackage[francais]{babel}

            balise                  effet

            \og \fg         :       " "
            \up{}           :       exposant
            \bsc{Lamport}   :       Petite majuscules
            N\ier           :       avec un N un chiffre (ex: 1er)
            N\ieme          :       avec un N un chiffre (ex: 2eme)
            \primo \secundo ...         :       1° 2° ...
                ou
                \FrenchEnumerate{N} : avec N un chiffre
            N\degres        :       40°C

        --------------------------
        Sections
        --------------------------

            \part{name}
            \chapter{name}
            \section{name}
            \subsection{name}
            \subsubsection{name}
            \paragraph{name}
            \subparagraph{name}

        --------------------------
        Numérotation
        --------------------------
            
            La numéroration des chapitres est automatique

            Pour l'enlever on rajouter une * devant l'accolade:

                \chapter*{name}

            Il est possible de changer de type de numérotation à tout moment en rajouter une des clauses suivantes à l'endroit où l'on veut que le changement prenne effet.
                __________________________
                Changer par des lettres (nouvelle numérotation)

                    \appendix
                __________________________
                Préambule en chiffre romain:

                    \frontmatter (après begin)
                __________________________
                Repasser sur la notation arabe:

                    \mainmatter
                __________________________
                Arréter la numérotation:

                    \backmatter

                        subtitle 4
                        ``````````````````````````
        --------------------------
        Page de garde
        --------------------------

                __________________________
                Automatique:

                    Avant la balise begin:

                        \title{titre}
                        \author{auteur}
                        \date{date}

                        on place ensuite après begin:

                        \maketitle
                __________________________
                Personalisée:

                    exemple:

                        \makeatletter               %Utilisation de commandeis internes à Latex
                          \begin{titlepage}
                          \centering
                              {\large \textsc{Institut bidouille}}\\
                              \textsc{Département des affaires bidouilles}\\
                            \vspace{1cm}
                              \includegraphics[width=0.25\textwidth]{logo1.jpeg}
                              \hfill
                              \includegraphics[width=0.35\textwidth]{logo2.jpeg}\\
                            \vspace{1cm}
                              {\large\textbf{   \@date\\
                               Thèse de doctorat}}\\
                            \vfill
                               {\LARGE \textbf{\@title}} \\
                            \vspace{2em}
                                {\large \@author} \\
                            \vfill
                                \includegraphics[height=0.07\textheight]{partenaire1.png}
                                \hfill
                                \includegraphics[height=0.1\textheight]{partenaire21.jpg}
                          \end{titlepage}
                        \makeatother

        --------------------------
        Alignement
        --------------------------

            \begin{TYPE_ENV} ... \end

            avec comme type d'env:
                __________________________
                à droite:

                    flushright
                __________________________
                à gauche:

                    flushleft
                __________________________
                centrer

                    center
                __________________________
                justifier:

                    par défaut
                    
        --------------------------
        Sauts
        --------------------------

            Pour sauter un paragraphe, on place simplement un saut de ligne:

            ex: 
                \begin{document}
                Premier paragraphe

                Deuxieme paragraphe
                \end{document}
                
                __________________________
                Retour à la ligne:

                    \\
                    \newline
                __________________________
                Saut de page:

                    \newpage

        --------------------------
        Marges
        --------------------------

                __________________________
                Afficher:

                    Afficher l'état des marges pour bien les conf:
                    Un graph apparait sur la première page.
                        
                        ...
                        \usepackage{layout}
                        \begin{document}
                        \layout 
                        ...
                        \end

                        Note:
                            Bien remplir la page pour afficher le rendu.
                __________________________
                Modifier:

                    Via le package geometry

                        exemple:

                            \usepackage[top=2cm, bottom=2cm, left=2cm, right=2cm]{geometry}

                    Directement avec les élement dumpés:

                        exemples:
                            
                            \topmargin = XXpt
                            \textheight = XXpt

        --------------------------
        Interlignes
        --------------------------

            \usepackage{setspace}

            \onehalfspacing : 1.5 fois plus grand que la normal
            \doublespacing  : 2 fois plus

            Pour modifier les interlignes seulement dans certain bloc:

                onehalfspace ou doublespace

                ex:

                    \begin{onehalfspace}
                    \end{onehalfspace}

        --------------------------
        Listes
        --------------------------
            
                __________________________
                à puces:

                    \begin{itemsize}
                    \item MON ELEMENT 1
                    \item MON ELEMENT 2
                    \end{itemsize}

                    changer la forme de la puce:
                        \item[forme]

                        ex:
                            \item[@]
                __________________________
                numéroté:

                    \begin{enumerate}
                    \item
                    \end{enumerate}

                __________________________
                description:

                    \begin{description}
                    \item[element :] definition.
                    \end{description}

        --------------------------
        Styles
        --------------------------

            personalisation des en-têtes et pieds de page.

            plain : numero de page au milieu du pied de page
            headings : nom du chapitre et le numero de page en en-tête (pied de page vide)
            empty : en tête et pied de page vide.

            \pagestyle{NOM STYLE}


        --------------------------
        Texte mise en forme
        --------------------------

            \cmd{mon texte}
            ou
            {\cmd mon texte}
            ou
            \begin{cmd} texte \end{cmd}

                __________________________
                taille:

                    \tiny
                    \scriptsize
                    \footnotesize
                    \small
                    \normalsize
                    \large
                    \Large
                    \LARGE
                    \huge
                    \Huge
                __________________________
                mise en valeur:

                    /!\ Change en fonction de la notation

                    normal:

                        {\normalfont}
                        \begin{rm} texte \end{end}

                    gras:

                        \textbf
                        {\bfseries texte }
                        \begin{bf} texte \end{end}

                    italique:
                        
                        \textit{texte}
                        {\itshape texte}
                        \begin{it} ...

                    Penché:

                        \textsl{
                        {\slshape
                        begin{sl}

                    Machine à écrire:

                        \texttt{ texte }
                        \begin{tt}

                    Petite maj:

                        \textsc{ texte }
                        {\scshape texte }
                        \begin{sc} texte

                    Exposant:

                        texte\textsuperscript{ exposant }

                    Encadrer (paramétrable):

                        \fbox{ texte }

                    Soulignement (package ulem):

                        \uuline{ texte }
                        \uwave{ texte }

                    Barrer (package soul):

                        \st{ texte }

                    automatique:

                        \emph{ texte }
                __________________________
                Couleurs:

                    package: color
                    \textcolor{couleur}{ texte }

                    Couleurs par défaut:
                    ``````````````````````````
                        black, white, red, green, blue, yellow, magenta, cyan

                    rgb:
                    ``````````````````````````
                        \definecolor{ nom_couleur }{rgb}{ taux rouge, taux vert, taux bleu}

                    nuances:
                    ``````````````````````````
                        \definecolor{ nom_couleur }{grey}{ deux décimales }

        --------------------------
        Polices
        --------------------------

            Pour changer de pack de police:

            \usepackage{pack}

                exemples:

                    bookman, charter, newcent, lmodern, mathpazo, mathptmx

            Pour l'appliquer sur une portion de texte:

                {\fontfamily{code}\selectfont texte}

                code    nom

                bch     charter
                cmr     computer modern
                ...

        --------------------------
        Citations
        --------------------------

            Citations de texte:

                \begin{quote} ma citation \end{quote} #une tablutation
                \begin{quotation} ma citation \end{quotation} #deux tabulations

        --------------------------
        Echapper du code:
        --------------------------

            Pour des petits bout de code:

                \verb| Mon Code {} |
                \verb( Mon Code {} (
                \verb[ Mon Code {} [

            Pour des gros bout de code:

                \usepackage{verbatim}

                \begin{verbatim}
                mon code
                \end{verbatim}

            Garder les tabulations en les remplacant par le nombre d'espace choisi

                \usepackage{verbatim}
                \usepackage{moreverb}

                \begin{verbatimtab}[nombre_d'espaces_par_tabulation]
                votre code
                \end{verbatimtab}

            Colorer son code

                \usepackage{listings}

                \lstset{ %
                language=nom_du_langage,        % choix du langage
                basicstyle=\footnotesize,       % taille de la police du code
                numbers=left,                   % placer le numéro de chaque ligne à gauche (left) 
                numbers=right,                  % placer le numéro de chaque ligne à droite (right)
                numberstyle=\normalsize,        % taille de la police des numéros
                numbersep=7pt,                  % distance entre le code et sa numérotation
                backgroundcolor=\color{white},  % couleur du fond 
                % Possibilité d'utilisation du package color
                }

                \begin{lstlisting}
                CODE
                \end{lstlisting}

        --------------------------
        URL
        --------------------------

            \usepackage{url}
            \url{adresse}

        --------------------------
        Encadrer
        --------------------------

            % Commande permettant de définir l'écart
            \setlength{\fboxsep}{8mm}
            % Commande permettant de définir l'épaisseur du trait
            \setlength{\fboxrule}{2mm}
            \fbox{Un lapin}

            Sur plusieurs lignes:

                \fbox{\begin{minipage}[alignement]{Largeur cm}
                ''texte''
                \end{minipage}}

            Avec comme alignement:
                c : centré
                t : aligné en haut
                b : aligné en bas
            
        --------------------------
        Notes
        --------------------------
                __________________________
                De bas de page:
                    
                    texte1\footnote{note bas de page1}
                    texte2\footnote{note bas de page2}

                    Autre possibilité [en choisissant son numéro de note]

                        texte1\footnotemark[1] \\
                        texte2\footnotemark[18] \\

                        \footnotetext[1]{note bas de page1} 
                        \footnotetext[18]{note bas de page2} 

        --------------------------
        Références
        --------------------------

            On peut créer une référence à tout moment dans notre document:

                \label{NOM_REF}

            Pour faire appel à cette référence:

                \ref{NOM_REF}   : sera remplacé par l'élement précedent au label
                \pageref{NOM_REF}   : sera remplacé par le numéro de page

        --------------------------
        Images
        --------------------------

                __________________________
                Package:

                    \usepackage{graphicx}

                __________________________
                Insertion:

                    \includegraphics{path image}  #Absolu ou relatif depuis le .tex

                __________________________
                Tailles:

                    \includegraphics[width=200]{image.png}
                    \includegraphics[height=200]{image.png}
                    \includegraphics[height=200, width=600]{image.png}  
                    \includegraphics[scale=1.5]{image.png}  

                __________________________
                Rotation:

                    \includegraphics[angle=45]{image.png}

                __________________________
                Portion d'image:
                    todo

                __________________________
                Dans un paragraphe (wrap):
                    (contour du texte)

                    \usepackage{wrapfig}

                        \begin{wrapfigure}[nombre lignes]{placement}{largeur img en cm}
                            \includegraphics[width=largeur en cm]{image}
                        \end{wrapfigure}
                        Paragraphe sans saut de ligne entre \end et le paragraphe

                    Avec comme placement:

                        l : gauche
                        r : droite
                        o : exterieur
                        i : intérieur

                __________________________
                Flottants:

                    exemple:

                        \begin{figure}[options]

                        \begin{center}
                        \includegraphics{monImage.png} 
                        \end{center}

                        \end{figure}

                    options:

                        On cumule les options sans espaces ni virgules.
                        
                        ! : insister sur une option (à placer avant)
                        t : haut
                        b : bas
                        p : où il réside que des flottants
                        h : à l'endroit même

                    fin de page:

                        \clearpage : saut de page après des flottants.
                        \cleardoublepage : idem mais retombe sur une page impaire.
                    
                __________________________
                Légendes:

                    exemple:

                        \includegraphics{poulpy.png} 
                        \end{center}
                        \caption{maLegende}
                        \label{maLegende}


        --------------------------
        Tableaux
        --------------------------

            TODO

        --------------------------
        Sommaire
        --------------------------

            Le sommaire ce génère automatiquement grâce à la balise \tableofcontents.
            Il faut cependant suivre une structure au niveau du document.
                __________________________
                Structure:

                \documentclass{book}
                \usepackage[latin1]{inputenc}
                \usepackage[T1]{fontenc}
                \usepackage[francais]{babel}
                \begin{document}
                    \tableofcontents

                    \part{Partie 1}
                        \chapter{Chapitre 1}
                            \section*{Une section}
                            \section{Une section avec un nom méga 
                                \mmligne  mais alors vraiment méga trop giga long qui dépasse}
                            \subsection{Une sous-section}
                            \subsection{Une sous-section}
                        \chapter{Chapitre 2}
                            \section{Une section}
                                \subsection{Une sous-section}
                                    \paragraph{Un paragraphe}
                                \subsection{Une sous-section}
                                    \paragraph{Un paragraphe}
                            \section{Une section}
                        \chapter{Chapitre 3}
                            \section{Une section}
                            \section{Une section}

                \end{document}
                __________________________
                Renommer:

                    \renewcommand{\contentsname}{Sommaire}  %changement du titre du sommaire.
                    \renewcommand{\partname}{Nom partie}    %changement du titre des parties.

                    à placer avant le \tableofcontents
                __________________________
                Raccourcir un titre:

                    \section[titre dans le sommaire]{titre dans le document}
                __________________________
                Choisir son niveau de profondeur:

                    \setcounter{tocdepth}{profondeur}

                    avec:

                        Elément hiérarchique | Nombre
                        
                        Partie                  -1
                        Chapitre                0
                        Section                 1
                        Sous-Section            2
                        Sous-sous-section       3
                        Paragraphe              4
                        Sous-paragraphe         5
    
                __________________________
                Ajouter du contenu manuellement:

                    Avec addcontentsline{toc}partie concernée}{mon contenu}
                    A placer où l'on veut dans son document.

                    exemple:

                        \addcontentsline{toc}{part}{Something} 
                        \addcontentsline{toc}{chapter}{L'Eurasie} 
                        ...

            Note: compiler 2 fois

        --------------------------
        Table des figures ou des tableaux
        --------------------------
            Indique les éléments founis par les légendes dans /caption

            Introduire une table:

                \listoffigures
                \listoftables

            légendes:
                \caption[titre court]{légende normale de l'image}
                \caption{légende normale de l'image}

            Note: compiler 2 fois

        --------------------------
        Index
        --------------------------
            
            TODO

        --------------------------
        Bibliographie (Références)
        --------------------------

            TODO

        --------------------------
        Inclusions de fichier
        --------------------------
                __________________________
                Via input:

                    Pour la séparation du contenu.

                     \input{fichier}

                    Note: on précise l'extension si el fichier n'est pas un .tex

                    On peut préciser un path relatif:

                    \input{dossier/sousDossier/fichier.tex}

                __________________________
                Via include:

                    Démarrage d'une nouvelle page

                     \include{fichier}

                    Revient à

                     \newpage CONTENU FICHIER \newpage

            Note: \jobname permet de récupérer le nom du fichier.

        --------------------------
        Landscape
        --------------------------

            Mettre une page en forme paysage:
                __________________________
                Via lscape:

                    \usepackage{lscape}

                    \begin{landscape}
                        CONTENU
                    \end{landscape}

                __________________________
                Via rotatebox:

                    exemple sur un tableau:

                        \begin{table}{!p}
                        \rotatebox{90}{MonTableau}
                        \caption{Légende}\label{decadix}
                        \end{table}
