# Microsoft Fabric : Mise en place de Pipeline dynamique avec des paramètres

Ce tutoriel a pour objectif de montrer la façon d'utiliser des paramètres dans les pipelines de données dans Microsoft Fabric.

Dans les architectures modernes, les paramètres des pipelines de données jouent un rôle crucial pour créer des solutions flexibles, réutilisables et maintenables. 

Dans cette série de tutoriels, nous allons explorer l'implémentation au sein de trois composants essentiels : l'activité Copy Data, les notebooks et les procédures stockées.

## Pourquoi paramétriser les Pipelines de données ?

Les paramètres rendent les pipelines plus dynamiques notamment en permettant : 

- **Réutilisables** : Pourvoir exécuter le m^eme pipeline avec différentes configurations (par exemple des sources ou des destinations différentes)

- **Maintenance simplifiée** : Modifier le comportement d'un pipeline sans altérer le code


## Scénario

Nous allons montrer comment définir des paramètres dans un pipeline de données puis les utiliser dans différents types de flux de données :

- Activité Copy Data
- Notebook Python
- Procédure Stockée

Après avoir défini un paramètre dans un Pipeline de données qui sera utilisé dans l'ensemble des activité du Pipeline, nous allons : 

1. Extraire les données d'une API Rest avec une activité Copy data. L'API est interrogé en utilisant le paramètre du pipeline pour paramétriser l'url envoyé à l'API. Les données téléchargées seront stockées dans un Lakehouse

2. Utiliser un notebook Python pour transformer les données




## Création d'un Workspace

Pour illustrer les propos de cet article, nous allons mettre en place un environnement dédiés avec les différents éléments nécessaires (Workspace, Lakehouse et base SQL).

Commençons par créer un Workspace, en suivant les étapes suivantes : 

 1. Cliquer sur **Home** depuis la volet gauche de l'interface de Microsoft Fabric
 2. Cliquer sur le bouton **+ New Workspace**
 3. Depuis le volet droit qui s'ouvre, entrer un nom pour ce nouveau Workspace dans le champ **Name**. Ici nous allons nommer notre Workspace **TutorialPipelineParameters**.
 4. Entrer une description dans le champ **Description** [Optionnel]
 5. Cliquer sur le bouton **Create** pour lancer la création du Workspace
  
![](images/Article/00%20-%20Create%20Workspace.png)


## Création d'un Lakehouse

Après la création de notre Workspace, nous allons voir comment créer un Lakehouse de données pour stocker les différents fichiers qui seront manipuler dans ce tutorial. Depuis l'interface de notre Workspace, suivre les étape suivante : 

1. Cliquer sur le bouton **+ New item**
2. Depuis le volet droit qui s'ouvre, taper le terme "*Lakehouse*" dans le champ de recherche
3. Cliquer sur l'icône **Lakehouse**.

![](images/Article/01%20-%20Create%20Lakehouse%20-%2000.png)


Cela va ouvrir une fenêtre qui depuis laquelle nous allons pouvoir renseigner le nom du Lakehouse à créer en suivant les étapes suivantes : 

1. Entrer un nom de votre choix dans le champ **Name**
2. Depuis le champ **Location**, s'assurer sur ce Lakehouse est positionner dans le Workspace que nous avons créé dans un premier temps.
3. Cliquer sur le bouton **Create** pour lancer la création de ce **Lakehouse**

![](images/Article/02%20-%20Create%20Lakehouse%20-%2001.png)


## Création d'une base SQL Database

Voyons à présent, comment créer une base de données SQL dans Microsoft Fabric. Cette base sera utilisée pour illustrer l'utilisation de paramètres d'un pipeline de données. 

Depuis l'interface du Workspace, suivre les étapes suivantes : 

1. Cliquer sur le bouton **+ New item**
2. Dans le champ de recherche, taper le terme *SQL*
3. Sélectionner l'icône **SQL Database**

![](images/Article/02%20-%20Create%20SQL%20Database%20-%2000.png)

Cela va ouvrir une fenêtre **New SQL database** et suivre les étapes suivantes :

1. Entrer un nom pour cette nouvelle base de données dans le champ **Name**. Dans notre exemple, nous nommons cette base : SQL *PipelineParameters_SQL*.
2. Cliquer sur le bouton **Create** pour lancer la création de la base de données. 

![](images/Article/02%20-%20Create%20SQL%20Database%20-%2001.png)

## Création d'un Pipeline

La prochaine étape va consister à créer un Pipeline de données. Pour cela, vous allez pouvoir suivre les étapes suivantes :

1. Revenir dans l'interface du Workspace que nous avons créé précédemment
2. Cliquer sur le bouton **+ New item**
3. Dans le volet droit qui s'ouvre, taper le terme **Pipeline** dans le champ de recherche
4. Cliquer sur l'icône du **Pipeline**

![Création du Pipeline](images/Article/03%20-%20Create%20Pipeline%20-%2000.png)

Cela va ouvrir la fenêtre qui va permettre de nommer ce Pipeline en suivant les étapes suivantes :

1. Depuis la fenêtre **New Pipeline**, entrer un nom de votre choix dans le champ **Name**. ici nous le nommons *PipelineParameters*
2. Cliquer sur le bouton **Create** pour lancer la création de ce **Pipeline**.

![](images/Article/03%20-%20Create%20Pipeline%20-%2001.png)

## Définition des Paramètres dans un Pipeline

A présent, nous allons voir comment définir un paramètre au niveau du **Pipeline** de données. Ce paramètre va nous permettre d'illustrer les propos de cet article dans les étapes suivantes.

Depuis l'interface du **Pipeline**, suivre les étapes suivantes : 

1. Cliquer sur le bouton **Paramètres**. Cela va ouvrir un volet droit sur la page.
2. Cliquer sur la croix **x** pour fermer ce volet droit
3. Redimensionner le menu du bas vers le haut


![](images/Article/04%20-%20Define%20Parameters%20-%2000.png)

Dans le champ du bas du **Pipeline**, nous allons pouvoir inscrire les paramètres souhaités de la façon suivante :

1. Aller dans le menu **Parameters**
2. Cliquer sur **+ New** pour ajouter un paramètre et définir ses caractéristiques
3. Dans le champ **Name**, entrer un nom pour le paramètre. Ici le paramètre est nommé *name*.
4. Dans le champ **Type**, choisir le type souhaité pour ce paramètre. Ici le type de paramètre est choisi de type *String*.
5. Dans le champ **Default value**, définir une valeur par défaut si souhaité. Ici nous définissons *canada* comme valeur par défaut.


![](images/Article/04%20-%20Define%20Parameters%20-%2001.png)

## Utilisation de Paramètres dans une activité Copy data

Nous allons commencer par montrer comment utiliser un Paramètre du Pipeline de données dans un flux de données Copy data. 
L'ajout d'une activité Copy data au Pipeline de données se fait de la façon suivante depuis l'interface du **Pipeline**:

1. Depuis le menu, cliquer sur **Add copy data activity** ce qui va l'ajouter au canevas du **Pipeline**
2. Dans les prochaines étapes, nous allons montrer comment définir les différents paramètres de cette activité depuis ce menu.

![Activité Copy data - Menu General](<images/Article/Copy data/05.01 - Activité Copy Data -add new Copy data activity.png>)


### Activité Copy data : menu *General*

Depuis le menu **General**, définir les paramètres de la façon suivante : 

1. Cliquer sur le menu **General**
1. Dans le champ **Name**, donner un nom à cette activité **Copy data**. Ici l'activité est nommée *Request Countries* 

![Activité Copy data - Menu General](<images/Article/Copy data/05.02 - Activité Copy data - menu General.png>)


### Activité Copy data : menu *Source*

Nous allons définir la source des données de cette activité **Copy data**.

#### Activité Copy data : menu *Source* - Paramètre *Connection*

Pour commencer cette étape, nous allons définir le type de connexion : 

1. Sélectionner le menu **Source**
2. Développer le menu déroulant du champ **Connection** 
2. Cliquer sur l'option **Browse all**

![Activité Copy data - Menu Source -Paramètre Connection 0](<images/Article/Copy data/05.03 - Activité Copy data - menu Source - Param Connection 00.png>)

Cela va ouvrir la fenêtre **Choose a data source to get started** dans laquelle vous allez devoir réaliser les étapes suivantes : 

1. Dans le champ de recherche, taper le terme *http*
2. Choisir l'option **Htpp - Other** dans le champ **New sources**

![Activité Copy data - Menu Source -Paramètre Connection 1](<images/Article/Copy data/05.03 - Activité Copy data - menu Source - Param Connection 01.png>)

Cela va ouvrir la fenêtre **Connect data source** dans laquelle vous allez pouvoir définir les paramètres de cette connexion *htttp* en suivant les étapes suivantes : 

1. Renseigner l'adresse de l'API [Restcountries](https://restcountries.com/v3.1/name/) dans le champ **Url**. 
2. Cliquer sur le bouton **Connect**

![Activité Copy data - Menu Source -Paramètre Connection 2](<images/Article/Copy data/05.03 - Activité Copy data - menu Source - Param Connection 02.png>)


#### Activité Copy data : menu *Source* - Paramètre *Relative URL*

Toujours depuis le menu **Source**, nous allons définir le paramétrages de l'appel à cette API. Pour cela, suivre les étapes suivantes : 

1. Cliquer dans le champ **Relative URL**
2. Cliquer sur le lien **Add dynamic content [Alt+Shift+D]**.

![Activité Copy data - Menu Source - Paramètre Relative URL 1](<images/Article/Copy data/05.04 - Activité Copy data - menu Source - Param Relative URL 00.png>)

Cela va ouvrir la fenêtre **Pipeline expression builder** qui va permettre de construire le paramétrage dynamiquement en suivant les étapes suivantes :

1. Choisir le menu **Parameters** ce qui va permettre d'afficher les paramètres définis dans le **Pipeline** de données
2. Choisir le paramètre *name* que nous avons définis précédemment dans le Pipeline
3. Dans la fenêtre, on voit s'afficher l'expression construite par ses actions. On retrouve ici l'appel du paramètre *name* : ```@pipeline().parameters.name```
4. Cliquer sur le bouton **OK** pour fermer cette fenêtre.

![Activité Copy data - Menu Source - Paramètre Relative URL 2](<images/Article/Copy data/05.04 - Activité Copy data - menu Source - Param Relative URL 01.png>)

#### Activité Copy data : menu *Source* - Paramètre *File format*

Enfin pour terminer, vous allez pouvoir le type de fichier qui sera téléchargé de la façon suivante : 

1. Depuis le champ **File format**, définir le type de fichier attendu. Ici, nous allons récupérer des fichier de type *JSON* depuis l'API [Rest Countries](https://restcountries.com/v3.1/name/).

![Activité Copy data - Menu Source - Paramètre File format](<images/Article/Copy data/05.05 - Activité Copy data - menu Source - Param File format.png>)

### Activité Copy data : menu *Destination*

Depuis le menu **Destination**, nous allons pouvoir l'endroit où stocker le fichier téléchargé de l'API.

#### Activité Copy data : menu *Destination* - Paramètre *Connection*

Pour choisir où stocker le fichier téléchargé, il va falloir commencer par choisir la *Lakehouse* que nous avons créé en suivant les étapes suivantes : 

1. Cliquer sur le menu **Destination**
2. Cliquer sur le champ **Connection** ce qui va ouvrir le menu déroulant.
3. Cliquer sur l'option **Browse all**

![Activité Copy data - Menu Destination - Paramètre Connection 0](<images/Article/Copy data/Copy data/05.06 - Activité Copy data - menu Destination - Param Connection 00.png>)

Cela va ouvrir la fenêtre **Choose a destination** : 

1. Choisir le *Lakehouse* que nous avons créé précédemment

![Activité Copy data - Menu Destination - Paramètre Connection 1](<images/Article/Copy data/05.06 - Activité Copy data - menu Destination - Param Connection 01.png>)

#### Activité Copy data : menu *Destination* - Paramètre *File path*

Nous allons  poursuivre de la façon suivante : 

1. Dans le champ **Root folder**, choisir l'option **Files**
2. Dans le champ **File path**, vous allez pouvoir définir le chemin de stockage du fichier. Inscrire le nom du répertoire souhaité dans le premier champ. Dans notre exemple, nous allons les stocker dans un répertoire nommé *JSON*.
3. Sélectionner le deuxième champ depuis le champ **File path**. 
4. Cliquer sur le lien **Add dynamic content [Alt+Shift+D]**. 

![Activité Copy data - Menu Destination - Paramètre File path 0](<images/Article/Copy data/05.07 - Activité Copy data - menu Destination - Param File path 00.png>)

Cela va ouvrir la fenêtre **Pipeline expression builder** qui va permettre de construire l'expression définissant le nom du fichier : 

1. Dans la fenêtre, nous allez pouvoir entrer l'expression suivante ```@concat(pipeline().parameters.name, '.json')```. LA fonction ```@concat()``` permet de concaténer des chaînes de caractères. Dans cette expression,nous réutilisons le paramètre défini dans le **Pipeline** comme nom du fichier avec une extension *JSON*.
2. Cliquer sur le bouton **OK** pour fermer cette fenêtre.

![Activité Copy data - Menu Destination - Paramètre File path 1](<images/Article/Copy data/05.07 - Activité Copy data - menu Destination - Param File path 01.png>)

#### Activité Copy data : menu *Destination* - Paramètre *File format*

Enfin il reste à définir le format de stockage des fichiers à télécharger : 

1. Depuis le champ **File format**, utiliser le menu déroulant et choisir *JSON* comme format de stockage 

![Activité Copy data - Menu Destination - Paramètre File path 2](<images/Article/Copy data/05.08 - Activité Copy data - menu Destination - Param File format.png>)


## Utilisation de Paramètre dans un Notebook

### Mise en place d'un Notebook - Python
#### Création du Notebook
![alt text](<images/Article/Notebook/06.01 Create Notebook 00.png>)
![alt text](<images/Article/Notebook/06.01 Create Notebook 01.png>)

#### Association d'un Lakehouse
![alt text](<images/Article/Notebook/06.02 Add Lakehouse 00.png>)
![alt text](<images/Article/Notebook/06.02 Add Lakehouse 01.png>)

#### Mise en place du code Python
![alt text](<images/Article/Notebook/06.03 Python Notebook 00.png>)
![alt text](<images/Article/Notebook/06.03 Python Notebook 01.png>)

#### Définition d'un paramètre
![alt text](<images/Article/Notebook/06.04 Toggle Parameter Cell.png>)

### Mise en place d'une activité Notebook

#### Ajout d'une activité Notebook au Pipeline
![alt text](<images/Article/Notebook/06.05 Add Notebook Activity.png>)

#### Activité Notebook - Menu General
![alt text](<images/Article/Notebook/06.06 Notebook Activity - Menu General.png>)

#### Activité Notebook - Menu Settings
![alt text](<images/Article/Notebook/06.06 Notebook Activity - Menu Settings.png>)

## Utilisation de Paramètre dans une Procédure Stockée


## Conclusion

Les paramètres dans Microsoft Fabric offrent une flexibilité essentielle pour créer des pipelines de données robustes et réutilisables. En maîtrisant leur utilisation, vous pouvez :

- Centraliser la configuration

- Faciliter les déploiements multi-environnements

- Améliorer la maintenance des pipelines

- Automatiser les exécutions