D J A N G O
==============================

What is it ?
-----------------------------

Django est un Framework Web Python.
Il permet de créer rapidement et proprement de belles applications web.

Links
-----------------------------

### Officiel

https://www.djangoproject.com/

### Tutos

https://docs.djangoproject.com/en/1.9/intro/

### Git

https://github.com/django/django

### Doc

https://docs.djangoproject.com/en

La documentation est aussi accessible offline:
    wget https://docs.djangoproject.com/m/docs/django-docs-1.9-en.zip


How it works ?
-----------------------------

Django embarque un set d'outil qui permet de créer un projet.
Dans ce project on peut créer une ou plusieurs applications web.

### Fonctions

#### url()

https://docs.djangoproject.com/en/1.9/intro/tutorial01/#url-argument-regex

Django nous encourage à utiliser de belles URL et éviter d'avoir des etensions par exemple dans son URL.
Pour se faire on utilise une sorte de sommaire contenant les patterns d'URL faisant référance à une vue.
Si la requête cliente ne correspond à aucun pattern, une erreur 404 not found sera retournée.

Cette fonction permet de publier les urls de son site.
2 arguments son requis (regex et view) et 2 optionnels :

* regex

Les regex vont aider à définir l'URL que l'utilisateur sera amené à utiliser.
Elles ne prennent pas en compte les paramètres envoyés via POST ou GET.

Exemple du tuto :

Pour https://www.example.com/myapp/?page=3the 
URLconf correspondra au pattern myapp/

* view

Lorsque Django trouve le pattern correspondant à la requête cliente, 
il appel alors la vue avec comme premier argument l'objet "HttpRequest".

* kwargs

Il est possible d'envoyer des dictionnaires en argument aux vues.

* name

Permet de nommer une URL pour mieux s'y retrouver et éviter des erreurs.

* Exemple :

    #mysite/news/urls.py

    from django.conf.urls import url

    from . import views

    urlpatterns = [
        url(r'^articles/([0-9]{4})/$', views.year_archive),
        url(r'^articles/([0-9]{4})/([0-9]{2})/$', views.month_archive),
        url(r'^articles/([0-9]{4})/([0-9]{2})/([0-9]+)/$', views.article_detail),
    ]

Lorsque l'utilisateur voudra accéder à '/articles/2006/05' par exemple, 
Il appelera la vue month_archive (= à une fonction python) :

Soit :

    news.views.article_archive(request, '2006', '05' )

### modèles de données

Les modèles de données définissent la structure d'une données.
Il est important de bien définir ses modèles au préalable.

La base de données sera constuire en fonction des modèles définis au niveau de chaque application.

* Un modèle est définit par une classe.
* Chaque nom de champs est définit par une variable de classe.
* Le type de données est définit par la valeur de la variable de classe, (une fonction de la classe modèle)

Exemple :

    from __future__ import unicode_literals

    # Create your models here.

    from django.db import models
    from django.utils.encoding import python_2_unicode_compatible
    from django.utils import timezone

    #needed onlt for python2 compatibility
    @python_2_unicode_compatible
    class Question(models.Model):
        question_text = models.CharField(max_length=200)
        pub_date = models.DateTimeField('date published')

        def __str__(self):
            return self.question_text

        def was_published_recently(self):
            return self.pub_date >= timezone.now() - datetime.timedelta(days=1)

    @python_2_unicode_compatible
    class Choice(models.Model):
        question = models.ForeignKey(Question, on_delete=models.CASCADE)
        choice_text = models.CharField(max_length=200)
        votes = models.IntegerField(default=0)

        def __str__(self):
            return self.choice_text

Pour Créer son modèle, 
Il faudra l'ajouter à la variable INSTALLED_APPS des settings de son projet.
Puis executer la commande makemigrations et migrate pour créer/mettre à jour le schéma.


Installation
-----------------------------

https://docs.djangoproject.com/en/1.9/topics/install/#how-to-install-django

Installation de la dernière version de python (fonctionne aussi sur la version 2.7):

Avec la version 2 de python :

    apt-get install python2.X python-pip
    pip install Django

Avec la version 3 de python :

    apt-get install python3.X python3-pip
    pip3 install Django


Configuration
-----------------------------

### Utiliser son serveur web :

#### Apache

mod_wsgi

#### Nginx

### Utiliser sa base de données :

#### MariaDB

https://docs.djangoproject.com/en/1.9/topics/install/#get-your-database-running

### Peaufiner les settings de son projet :

#### Activer des applications :

Django utilise un set d'application pour pouvoir fonctionner.
Il est possible d'utiliser ses propres applications mais aussi activer/désactiver des applications django.

    INSTALLED_APPS = [
        'django.contrib.admin',
        'django.contrib.auth',
        'django.contrib.contenttypes',
        'django.contrib.sessions',
        'django.contrib.messages',
        'django.contrib.staticfiles',
    ]

Note :

Lorsqu'on applique un migrate pour construire la base de données. 
Django va dabord regarder la variable INSALLED_APPS pour contruire toutes les bases nécessaires.

Manipulations
-----------------------------

### Créer un projet Django :

    django-admin startproject PROJECT_NAME

Note : Si django-admin n'est pas dans son PATH, 
voir du côté de $HOME/.local/bin/django-admin

Et rajouter dans son PATH :

    PATH=$HOME/.local/bin:$PATH 

Et/ou installer :

    pip install django-admin-tools

#### Arborescence de base

    mysite/
    ├── manage.py           #Command to interact with the project
    └── mysite              
        ├── __init__.py     #See memo Python, consider the project as a python package
        ├── settings.py     #Settings of the project
        ├── urls.py         #Url declarations for the project
        └── wsgi.py         #To be compatible with some web servers

### Choisir un système de base de données

    vim mysite/settings.py

Pour de simple test et ou un petit site sans prétention, SQLite peut faire l'affaire :
Sinon, pour avoir une base de données plus robuste, ce tourner vers des solutions comme PostgreSQL.
Il existe aussi des modules pour rendre django compatible avec elasticsearch :
http://elasticutils.readthedocs.org/en/latest/django.html

    # Database
    # https://docs.djangoproject.com/en/1.9/ref/settings/#databases
              
    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.sqlite3',                                      
            'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        }        
    }         

Il faut ensuire initialiser la base pour les applications par défaut (INSTALLED_APPS et bien sur notre projet) :

    python manage.py migrate


### Serveur Web de Developpement

    python manage.py runserver [SOCKET ou PORT]

Note : le serveur de dev n'a pas besoin d'être redémarré sauf pour l'ajout de nouveaux fichiers.

### Créer une application dans un projet :

Chaque applications crées correspondent à des packages pythons normalisés.

    python manage.py startapp APP_NAME

Note :

Un projet est une collection d'apps et de configuration;
Une app peut se trouver dans plusieurs projets.

#### Arborescence d'une app

    myapp/
    ├── admin.py
    ├── apps.py
    ├── __init__.py
    ├── migrations
    │   └── __init__.py
    ├── models.py
    ├── tests.py
    └── views.py

#### Views

* Création d'une vue basique 

    Les vues sont en charge de traiter et répondre aux requêtes clientes.

    #vim myapp/views.py

    from django.http import HttpResponse

    def index(request):
        return HttpResponse("Hello, world. You're at the polls index.")

* Rendre une vue accessible avec URLconf :

Pour qu'une vue puisse être appelée, il faut la mapper avec une URL.

    #vim myapp/urls.py

    from django.conf.urls import url

    from . import views

    urlpatterns = [
        url(r'^$', views.index, name='index'),
    ]

Ici on gère le mapping au niveau de l'application même.
Il faut cependant l'inclure à l'application.

* Inclure l'URLconf d'une application au niveau du projet (continuer le mapping)

    from django.conf.urls import include, url
    from django.contrib import admin

    urlpatterns = [
        url(r'^polls/', include('polls.urls')),
        url(r'^admin/', admin.site.urls),
    ]

Dans le cas ci-dessus, on incluera le mapping définit au niveau de l'application.

#### Models

https://docs.djangoproject.com/en/1.9/intro/tutorial02/#creating-models

Comment Créer son Modèle de base de données :
Les modèles définissent le schema de la base avec des metadata supplémentaires.
Concretement un modèle de données décrit comment doit être représenter une donnée.

Par exemple dans le tuto Django, on définit deux modèles de données pour notre application de sondage :

* Question
Représenté par une question et une date de publication

* Choice
Représenté par un Texte évoquant le choix à faire et un vote.

Chaque choix étant associé à une question.

Ce qui donnerait :

    #vim polls/models.py

    from django.db import models

    class Question(models.Model):
        question_text = models.CharField(max_length=200)
        pub_date = models.DateTimeField('date published')

        def __str__(self):
            return self.question_text

    class Choice(models.Model):
        question = models.ForeignKey(Question, on_delete=models.CASCADE)
        choice_text = models.CharField(max_length=200)
        votes = models.IntegerField(default=0)

        def __str__(self):
            return self.choice_text

Il faut ensuite activer son modèle en rajoutant dans les settings son application :

    INSTALLED_APPS = [
        'myappname.apps.MyappnameConfig',
        ...
    ]

Exemple :

    #vim mysite/settings.py

    INSTALLED_APPS = [
        'polls.apps.PollsConfig',
        ...
    ]

Définir les opérations de migration du schéma de base de données :

    python manage.py makemigrations polls

(Remplacez polls par le nom de son application).

Un fichier indiquant les opérations de la migration sera alors crée :

    polls/migrations/0001_initial.py

Il est possible d'afficher l'output de la migration sous forme sql (il faut reprendre le numéro définit dans polls/migrations) :

    python manage.py sqlmigrate polls 0001

Pour tester ses modifications avant de les appliquer :

    python manage.py check;

Mettre à jour son schéma :

    python manage.py migrate

### l'API

Django est livré avec son API;
Il est possible d'intéragir directement avec grâce à la commande suivante :

    python manage.py shell

Cela équivaut à :

* définir la variable d'environnement DJANGO_SETTINGS_MODULE
* lancer un interpréteur python
    >>> import django
    >>> django.setup()

#### Intéragir avec ses modèles

Importer les modèles définits :

    from polls.models import Question, Choice

Afficher les objets sauvegardés :

    Question.objects.all()

Note : les objets apparaitrons sous la forme d'un objet pur.
Pour que l'affichage des objets soit plus parlant, il faut définir quoi afficher au niveau de la définition de modèle.

Exemple :

    class Question(models.Model):
        # ...
        def __str__(self):
            return self.question_text

Créer un objet :

    from django.utils import timezone
    q = Question(question_text="What's new?", pub_date=timezone.now())
    q.save()

Accéder aux différents champs de son objet :

    q.id
    q.question_text
    q.pub_date

Modifier les attributs de son objet :

    q.question_text = "What's up?"
    q.save()

Requêter la base de données :

    Question.objects.filter(id=1)
    Question.objects.filter(question_text__startswith='What')
    Question.objects.get(id=1)
    Question.objects.get(pk=1)

Autres exemples:

    from django.utils import timezone
    current_year = timezone.now().year
    Question.objects.get(pub_date__year=current_year)

    q = Question.objects.get(pk=1)
    q.was_published_recently()

Ajouter des éléments :

    q = Question.objects.get(pk=1)
    q.choice_set.all(
    q.choice_set.create(choice_text='Not much', votes=0)
    q.choice_set.create(choice_text='The sky', votes=0)

### Django Admin

L'interface d'admin django permet de s'acquitter du boulot qu'est de faire une interface d'administration.
Elle permet de gérer les modèles depuis le site web avec gestion de l'authentification.

#### Créer l'utilisateur admin

    python manage.py createsuperuser

#### Accéder à l'interface d'admin

    http://site_url/admin/

Exemple :

    http://127.0.0.1:8000/admin

#### Rendre une application modifiable

Il faut l'enregistrer auprès du module d'admin dans le fichier d'admin de l'application (myapp/admin.py)

    from .models import MyModel
    admin.site.register(MyModel)

Exemple :

    #vim polls/admin.py

    from django.contrib import admin

    from .models import Question

    admin.site.register(Question)

#### Gestion des droits

Par défaut la gestion des droits est fournie par le module django.contrib.auth


Troubleshooting
-----------------------------

### Erreur

#### Log

    log output

#### Description

#### Résolution

Sample
-----------------------------

### Title 3
#### Title 4

Normal text

* bullet points
* bp2

1 bp ordered
2 bp ordered

    console output
