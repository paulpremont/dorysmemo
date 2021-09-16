Jenkins
==============================

What is it ?
-----------------------------

Jenkins est un moteur d'automatisation ou encore un ordonnanceur de jobs.  
Il permet d'automatiser des tâches courantes et est orienté Intégration Continue ("continuous delivery").
Il a été designer à la base pour valider le code source d'une application sur des environnement de test avant de délivrer un package prêt pour la production.

L'application repose essentiellement sur du Java.
Il est livré avec bon nombre de plugins (Git, Ansible...) et dispose de mécanismes de création de jobs simplifiés.

Links
-----------------------------

### Official

* [Documentation](https://jenkins.io/doc/)
* [Available steps](https://jenkins.io/doc/pipeline/steps/)

### Tutos


How it works ?
-----------------------------

### Langages

* Jenkins : [java](https://www.java.com/fr/)
* Jenkinsfile : [Groovy](http://groovy-lang.org/)

### Pipelines

* [Pipelines](https://jenkins.io/doc/book/pipeline/)

Un pipeline va, par l'intermédiaires d'un fichier de description (Jenkinsfile), permettre d'ordonnancer des tâches (stages) en plusieurs étapes (steps).  
Ces étapes (steps) sont réalisables par l'intermédiaires de plugins comme :

* [Git](https://jenkins.io/doc/pipeline/steps/git/)
* [Gitlab](https://jenkins.io/doc/pipeline/steps/gitlab-plugin/)
* [Docker](https://jenkins.io/doc/pipeline/steps/docker-workflow/)
* [Ansible](https://jenkins.io/doc/pipeline/steps/ansible/)
* [HTTP Request](https://jenkins.io/doc/pipeline/steps/http_request/)
* ...

Exemple de jenkinsfile :

    pipeline {
        agent any 

        stages {
            stage('Example') {
                steps {
                    echo 'Hello World'
                }
            }
            stage('Build') { 
                steps { 
                    sh 'make' 
                }
            }
            ...
        }
    }

Avec :

1. agent : Spécifie où le pipeline sera executé et dans quel workspace (un node, un conteneur, ...)
2. stages : contient la liste des phases à appliquer
3. stage : une phase de l'ordonnancement découpée en une ou plusieurs étapes ('Build', ...)
4. steps : contient les étapes à exécuter dont la syntaxe est donnée par le plugin même ou un élément built-in (ex : echo, sh ...)

#### Syntax

* [Pipelines Syntax](https://jenkins.io/doc/book/pipeline/syntax/)

### Jenkinsfile

* [Jenkins File](https://jenkins.io/doc/book/pipeline/jenkinsfile/)


Installation
-----------------------------

### Prérequis

Il faut tout d'abord installer java sur sa machine.

#### Debian

    apt-get install default-jre
    apt-get install default-jdk

### Jenkins

Téléchargement de l'application :

    wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war

Exécution de l'application :

    java -jar jenkins.war
    ...
    Apr 28, 2017 3:03:23 PM hudson.model.AsyncPeriodicWork$1 run
    INFO: Finished Download metadata. 7,429 ms

Finaliser l'installation :

    http://monserver:8080

le mot de passe admin se trouvant ici :

    /root/.jenkins/secrets/initialAdminPassword

Une fois configuré, arrêter l'execution du de l'application (CTRL+C).  
Et relancer l'application en background :

    nohup java -jar jenkins.war &
    netstat -laputen |grep 8080


Configuration
-----------------------------

Manipulations
-----------------------------

### Création d'un pipeline

* [Getting-started](https://jenkins.io/doc/book/pipeline/getting-started/)

Pour créer un pipeline, il faut se rendre sur la page principale et cliquer sur "New Item".

Plusieurs options s'offrent à nous :

* todo

Il est possible d'écrire un pipeline directement depuis l'interface de Jenkins mais le plus courant est d'écrire un fichier nommé "Jenkinsfile" dans son repo à tester.  
Pour charger un Jenkinsfile depuis un repo, il faut selectionner "Pipeline script from SCM" depuis la liste "Definition" de la frame Pipeline.

On peut y définir l'url du repo et le path du fichier Jenkinsfile à charger.

#### Jenkinsfile 

    #!groovy
    ...

#### Documentation embarquée

Une documentation est mise à disposition directement depuis Jenkins.  
Il est possible de générer des blocs de configuration avec la syntax Groovy en fonction du plugins que l'on souhaite utiliser grace au Menu "Pipeline Syntax" disponible depuis un Pipeline.
    monserveur:8080/pipeline-syntax

### Exécution d'un pipeline avec docker


Troubleshooting
-----------------------------

