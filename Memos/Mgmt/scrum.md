# SCRUM

## Introduction 

Scrum est né dans les années 1990, inspiré par des pratiques japonaises de gestion de projet 
et formalisé par Ken Schwaber et Jeff Sutherland. Il repose sur trois piliers :

* Transparence : Tout le monde voit l’avancement du projet.
* Inspection : On vérifie régulièrement l’avancement et la qualité.
* Adaptation : On ajuste le processus en fonction des retours.

## Rôles principaux

* **Product Owner (PO)** : Représente les parties prenantes, priorise les fonctionnalités (backlog).
* **Scrum Master** : Facilite le processus, élimine les obstacles, veille au respect des règles Scrum.
* **Équipe de Développement** : Réalise le travail, auto-organisée et pluridisciplinaire.

## Éléments clés

* **Product Backlog** : Liste priorisée de toutes les fonctionnalités souhaitées.
* **Sprint Backlog** : Sous-ensemble du Product Backlog sélectionné pour le sprint en cours.
* **Incrément** : Résultat concret du sprint, potentiellement livrable.

## Organisation

* **Sprint Planning** : Planification du travail pour le sprint (1 à 4 semaines).
* **Daily Scrum** : Réunion quotidienne de 15 min pour synchroniser l’équipe.
* **Sprint Review** : Démonstration de l’incrément aux parties prenantes.
* **Sprint Retrospective** : Amélioration continue du processus.

## Avantages

* lexibilité et adaptation aux changements.
* Livraison fréquente de valeur.
* Meilleure collaboration et visibilité.

## Termes associés à Git

* Issues/Epics = Backlog
* Milestones = Sprints
* Boards = Tableau Kanban
* Merge Requests = Revue de code
* CI/CD = Livraison continue

## Méthodo avec Git

1. Product Backlog → GitLab Issues & Epics

Le Product Owner crée une Epic pour une nouvelle fonctionnalité (ex: "Intégration paiement en ligne").
Il décompose cette Epic en Issues (ex: "Créer API de paiement", "Intégrer Stripe", "Tester la sécurité").
Les Issues sont priorisées avec des labels (ex: P1, P2) et des milestones (ex: "Q2 2026").

2. Sprint Planning → GitLab Milestones & Boards

L’équipe crée un Milestone pour le sprint (ex: "Sprint 15 - 10/03 au 24/03").
Lors du Sprint Planning, le PO et l’équipe sélectionnent les Issues du backlog et les ajoutent au Milestone.
Un GitLab Board (Kanban) est utilisé pour visualiser le travail : colonnes "To Do", "In Progress", "Done".

3. Daily Scrum → GitLab Boards & Commentaires

Chaque matin, l’équipe consulte le Board pour voir l’avancement.
Les membres mettent à jour le statut des Issues (ex: passer de "In Progress" à "Done").
Les blocages sont signalés en commentaires ou via des labels (ex: blocked).

4. Sprint Review → GitLab Merge Requests & Environnements

À la fin du sprint, l’équipe crée une Merge Request pour fusionner le code dans la branche principale.
Le PO et les parties prenantes testent la fonctionnalité via un environnement de review (ex: "Review App" dans GitLab CI/CD).
Les retours sont ajoutés en commentaires sur la Merge Request.

5. Sprint Retrospective → GitLab Wiki & Issues

L’équipe crée une Issue ou une page Wiki pour noter les points d’amélioration (ex: "Réduire le temps de build CI", "Mieux prioriser les bugs").
Des labels comme retrospective ou improvement sont utilisés pour suivre ces actions.

6. Incrément → GitLab CI/CD & Releases

À chaque sprint, une Release est créée dans GitLab avec les nouvelles fonctionnalités.
Le pipeline CI/CD déploie automatiquement l’incrément sur un environnement de staging ou de production.


## Conclusion

Scrum permet de livrer des produits de qualité en itérant rapidement et en s’adaptant aux besoins changeants.
