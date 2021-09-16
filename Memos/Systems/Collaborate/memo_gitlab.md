GitLAB
==============================

What is it ?
-----------------------------

GitLAB est une interface web à GIT.

Il embarque une gestion plus fine des droits utilisateurs, de la gestion des commits et des bugs.

Il sert aussi d'outils de gestion de projet (Assignation des tasks avec leur due date, possibilité de faire des schémas Gantt...)

Quelques fonctionnalitées :

* Gestion des utilisateurs
* Affichage de l'activité (actions effectuées sur l'interface)
* Envoi de mails
* Merge requestion (demande de merge avec une branche)
* Issue tracking (signaler un bug)
* Wiki
* Groupes de projets (catégoriser des repositories)
* Chat (via Mattermost)

Links
-----------------------------

### Official

* [Site officiel](https://about.gitlab.com/)
* [Sources Gitlab](https://gitlab.com/gitlab-org/gitlab-ce/)
* [Sources Ganttlab](https://gitlab.com/ganttlab/ganttlab-live)


How it works ?
-----------------------------

Gitlab utilise le système de gestion de version de Git et le complète avec une interface graphique ainsi qu'un lot de fonctionnalité essentiel à la gestion d'un projet orienté application.

Il est écrit en Ruby et est décliné en deux versions :

* Version CE (communautaire)
* Version EE (Entreprise)

Installation
-----------------------------

### Gitlab

Voir [la procédure officielle.](https://about.gitlab.com/installation/)

### Ganttlab Live

Ce projet permet de visualiser les Issues d'un projet ou d'un groupe sous forme d'un GANTT.

Petit bémol tout de même, il n'intégre pas une visualisation par Phases d'un projet ou par Milestones.

Pour le tester rapidement avec docker :

    git clone https://gitlab.com/ganttlab/ganttlab-live
    cd ganttlab-live && ./bashInDevEnv.sh
    ./bootstrapIt.sh
    npm run dev

Configuration
-----------------------------

Manipulations
-----------------------------

### Changer le mot de passe :

    sudo gitlab-rails console

    user = User.find_by(email: 'admin@local.host')
    user = User.find_by(username: 'root')

    user.password = 'secret_pass'
    user.password_confirmation = 'secret_pass'
    user.save


Troubleshooting
-----------------------------

### Erreur

#### Log

  log output

#### Description

#### Résolution
