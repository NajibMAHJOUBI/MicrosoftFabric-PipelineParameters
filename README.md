# Microsoft Fabric : Mise en place de Pipeline dynamique avec des paramètres

Ce tutoriel a pour objectif de montrer la façon d'utiliser des paramètres dans les pipelines de données dans Microsoft Fabric.

Dans les architectures modernes, les paramètres des pipelines de données jouent un rôle crucial pour créer des solutions flexibles, réutilisables et maintenables. 

Dans cette série de tutoriels, nous allons explorer l'implémentation au sein de trois composants essentiels : l'activité Copy Data, les notebooks et les procédures stockées.

## Pourquoi paramétriser les Pipelines de données ?

Les paramètres rendent les pipelines plus dynamiques notamment en permettant : 

- **Réutilisables** : Pourvoir exécuter le m^eme pipeline avec différentes configurations (par exemple des sources ou des destinations différentes)

- **Maintenance simplifiée** : Modifier le comportement d'un pipeline sans altérer le code





## Création d'un Workspace

Pour illustrer les propos de cet article, nous allons mettre en place un environnement dédiés avec les différents éléments nécessaires (Workspace, Lakehouse et base SQL).

Commençons par créer un Workspace, en suivant les étapes suivantes : 

 1. Cliquer sur **Home** depuis la volet gauche de l'interface de Microsoft Fabric

 2. CLiquer sur le bouton **+ New Workspace**
 3. Depuis le volet droit qui s'ouvre, entrer un nom pour ce nouveau Workspace dans le champ **Name**. Ici nous allons nommer notre Workspace **TutorialPipelineParameters**.
 4. Entrer un description dans le champ **Description** [Optionnel]
  Cliquer sur le bouton **Create** pour lancer la création du Workspace
  
![](images/Article/00%20-%20Create%20Workspace.png)

## Création d'un Lakehouse

Après la création de notre Workspace, nous allons voir comment créer un Lakehouse de données pour stocker les différents fichiers qui seront manipuler dans ce tutorial. Depuis l'interface de notre Workspsapce, suivre les étape suivante : 

1. Cliquer sur le bouton **+ New item**
2. Depuis le volet droit qui s'ouvre, taper le terme "*Lakehouse*" dans le champ de recherche
3. Cliquer sur l'icône **Lakehouse**.

![](images/Article/01%20-%20Create%20Lakehouse%20-%2000.png)


Dans la fenêtre qui s'ouvre, nous allons paramétrer ce nouveau Lakehouse en suivant les étapes suivantes : 

1. Entrer un nom de votre choix dans le champ **Name**
2. Depuis le champ **Location**, s'assurer sur ce Lakehosue est positionner dans le Workspace que nous avons créé dans un premier temps.
3. Cliquer sur le bouton **Create** pour lancer la création de ce **Lakehouse**

![](images/Article/02%20-%20Create%20Lakehouse%20-%2001.png)


## Création d'une base SQL Database

Voyons à présent, comment créer une base de données SQL dans Microsot Fabric. Cette base sera utilisé pour utiliser l'utilisation de procédures stockées utilisant les paramètres d'un pipeline de données. 

Depuis l'interface du Workspace, suivre les étapes suivantes : 

1. Cliquer sur le bouton **+ New item**
2. Dans le champ de rechercer, taper le terme *SQL*
3. Sélectionner l'icône **SQL Database**

![](images/Article/02%20-%20Create%20SQL%20Database%20-%2000.png)

Cela va ouvrir la fenêtre **New SQL database** et suivre les étapes suivantes :

1. Entrer un nom pour cette nouvelle base de données dans le champ **Name**
2. Cliquer sur le bouton **Create** pour lancer la création de la base de données. 

![](images/Article/02%20-%20Create%20SQL%20Database%20-%2001.png)

## Création d'un Pipeline

![](images/Article/03%20-%20Create%20Pipeline%20-%2000.png)

![](images/Article/03%20-%20Create%20Pipeline%20-%2001.png)

## Définition des Paramètres dans un Pipeline

![](images/Article/04%20-%20Define%20Parameters%20-%2000.png)

![](images/Article/04%20-%20Define%20Parameters%20-%2001.png)

## Utilisation de Paramètres dans une activité Copy data

![](images/Article/05%20-%20Add%20Copy%20Data%20-%2000.png)

![](images/Article/05%20-%20Add%20Copy%20Data%20-%2001.png)




## Utilisation de Paramètre dans un Notebook
## Utilisation de Paramètre dans une Procédure Stockée


## Conclusion

Les paramètres dans Microsoft Fabric offrent une flexibilité essentielle pour créer des pipelines de données robustes et réutilisables. En maîtrisant leur utilisation, vous pouvez :

- Centraliser la configuration

- Faciliter les déploiements multi-environnements

- Améliorer la maintenance des pipelines

- Automatiser les exécutions