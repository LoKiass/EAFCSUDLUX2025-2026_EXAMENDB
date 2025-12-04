Préparation examen gestion de base de données 25-26

Exercice 1

L'étudiant devra créer une base de données ainsi que les objets décrits ci-dessous.  
La base de données de l'étudiant devra être fonctionnelle pour que son travail puisse être évalué.

Pour une boite de développement d'applications, on souhaite créer une base de données de gestion de projets.  
Le but annoncé étant de pouvoir

-   planifier le temps à allouer au développement des applications
-   monitorer le temps de travail des collaborateurs
-   aider à la facturation des clients

Pour ce faire, on demande plusieurs procédures stockées ou fonctions pour manipuler l'insertion de tâches en base de données.  
Voici les signatures des différentes procédures stockées demandées ainsi que la fonctionnalité attendue :

Contrainte structurelle

Une tâche peut être créée avec ou sans tâche parent.  
Ceci permettra de définir un projet comme une tâche ne disposant d'aucun parent.  
À contrario, une tâche avec un parent dépendra d'une autre tâche.  
Pour trouver le projet d'une tâche, il faudra remonter la chaine des parents jusqu'à trouver la tâche qui ne dispose pas de parent.  
Pour retrouver toutes les tâches d'un projet, il faudra récupérer toutes les tâches dont le parent est le projet ainsi que toutes les tâches dont le parent est une des tâches récupérées et ce, jusqu'à ce qu'aucun lien ne référence une des tâches du projet (voir structure en arbre)

ajout_collaborateur

ajout_collaborateur(nom : text, prenom : text) : void  
Cette procédure stockée permet d'ajouter un collaborateur en base de données  
Un collaborateur doit au moins disposer d'un nom, d'un prénom et d'un pseudonyme.  
Le pseudonyme d'un collaborateur est composé des deux premières lettres de son prénom ainsi que des deux premières lettres de son nom de famille, le tout en minuscule.  
En plus de ces 4 lettres, les pseudonymes disposent d'une partie numérique présentée strictement sur deux char, commençant à 01 et incrémentant de 1 entre chaque itération.  
Ainsi, si nous encodons un Simon Dupont, un Simon Dupond et un Simon Smith, nous aurons les pseudonymes suivants : sidu01, sidu02 et sism01

attribution_collaborateur

attribution_collaborateur(pseudo_collab : text, nom_tache : text) : void  
Cette procédure stockée permet d'attribuer une tâche a un collaborateur.  
Un collaborateur auquel on attribue une tâche est responsable de cette tâche.

ajout_tache

ajout_tache(nom_tache : text, temps_estime : int, tache_parent : text | null) : void  
Cette procédure stockée doit permettre d'ajouter une nouvelle tâche en base de données.

temps_projet

temps_tache(nom_temps : text, total : boolean = false) : intCette fonction permet de récupérer le temps d'une tâche.  
Un boolean "total" permet de récupérer uniquement le temps de la tâche spécifiée si set à false ou de la tâche et de tout ses décendants si il est set à true.
