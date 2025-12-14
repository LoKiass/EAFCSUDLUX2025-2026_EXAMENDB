# Projet d'Examen : Administration et Gestion Avancée de Base de Données

**Année académique 2025-2026**  
**Enseignant : M. Sana**

---

## 📌 Description du Projet

Ce projet consiste à concevoir une base de données relationnelle pour répondre aux exigences de l'énoncé. Il inclut :
- La création des tables avec le respecte de la normalisation de la base de donné
- L'insertion de données de test
- Le développement d'une fonction pour récupérer la hiérarchie des tâches
- Respect de la normalisation de base de données relationelle 

---

## 📂 Structure des Fichiers

| Fichier                         | Description                                                                                                                                                                                                        |
|---------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `table_creation.sql`            | Script SQL pour créer les tables de la base de données                                                                                                                                                             |
| `insert_into_test.sql`          | Script SQL pour insérer des données de test                                                                                                                                                                        |
| `get_hierarchy.sql`             | Script SQL contenant la fonction `get_hierarchy` pour récupérer la hiérarchie des tâches                                                                                                                           |
| `README.md`                     | Documentation du projet                                                                                                                                                                                            |
| `ennonce.md`                    | Énoncé du projet fourni par M. Sana                                                                                                                                                                                |.
| `ajout_colaborateur.sql`        | Script SQL contenant la procedure stocker `ajout_colaborateur` pour inserer dans la table colaborateur leurs nom, prenom, pseudo (Voir fiche téchnique) et le colab_id                                             |
| `ajout_tache.sql`               | Script SQL contenant la procedure stocker `ajout_tache` pour inserer dans la table Task une nouvelle tache (voir fiche técnique)                                                                                   |
| `temps_projet.sql`              | Script SQL contenant la fonction `temps_taches` afin de récupérer le temps d'une tâche si les arguments d'entrer sont à FALSE, mais récupère le temps de toutes les tâches descendante et elle même si mise à true | 
| `attribution_colaborateur.sql`  | Script SQL contenant la procédure stocker `attribution_colaborateur`. Elle permet d'attribuer à un colaborateur une tâche de la table Task                                                                                                                                                                                           
---

## 🚀 Installation et Utilisation

### 1. Créer la base de données

Exécute le script `table_creation.sql` pour créer les tables :



### 2. Insérer les données de test

Exécute le script `insert_into_test.sql` pour insérer les données de test :


### 3. Tester la fonction `get_hierarchy` par exemple 

Exécute le script `get_hierarchy.sql` et appeler la fonction pour tester la fonctionnalité :


---

## 📊 Fonctionnalités

### 1. Création des tables
Les tables sont conçues pour répondre aux besoins de l'énoncé, avec des contraintes d'intégrité (clés primaires, étrangères, etc.).

### 2. Insertion des données de test
Des données de test sont fournies pour valider les fonctionnalités.

### 3. Fonction `get_hierarchy`
Cette fonction permet de récupérer la hiérarchie des tâches (parent/enfant). 

### 4. Procédure stocker `ajout_colaborateur`
Cette procédure stocjer permet d'inserer dans le tableau colaborateur des nom, prénom, peudonyme en fonction de l'ennoncé demander et le colab_id

### 5. Procédure stocker `ajout_tache`
Cette procédure stocker permet d'ajouter une tâche dans la table `Task`

### 6. Procédure stocker `attribution_colaborateur`
Cette procédure stocker permet d'attribuer un collaborateur à une tâche dans la table de jointure `Task_Colab`

### 7. Fonction `temps_projet`
Cette fonction permet de récupérer en détail le temps restant pour une tâche si l'argument de la variable est `false`, si l'argument de la variable est `TRUE`, alors on aura en retour le temps de toutes les tâches descendante et d'elle même

---

## 📝 Documentation Technique

### Schéma de la Base de Données
![img.png](img.png)

Le schéma suivant respecte les formes normales de base de données (1FN, 2FN, 3FN, etc..).
### Fonction `get_hierachy(ftask_id int)` 
Fonction get_hierarchy :
À partir d'une tâche donnée, cette fonction permet de :

1. Remonter la hiérarchie : Récupérer tous les parents de la tâche, jusqu'à atteindre le parent principal (ou racine).
```sql
racine AS (
        SELECT task_id, parent_id, description, 0 AS level
        FROM Task
        WHERE task_id = ftask_id

        UNION ALL

        SELECT t.task_id, t.parent_id, t.description, r.level + 1
        FROM Task as t
        JOIN racine AS r ON t.task_id = r.parent_id
    ),
```
2. Descendre la hiérarchie : À partir du parent principal, récupérer récursivement tous les enfants (et leurs sous-enfants) jusqu'à ce qu'il n'y ait plus de liens possibles.
```sql
    enfant_finale AS (
        SELECT task_id, parent_id, description, 0 AS level
        FROM Task
        WHERE task_id = (SELECT task_id FROM racine WHERE parent_id = 0)  -- La racine

        UNION ALL

        SELECT t.task_id, t.parent_id, t.description, ef.level + 1
        FROM Task as t
        JOIN enfant_finale as ef ON t.parent_id = ef.task_id
    )
```

### Procédure stocker `ajout_colaborateur(pnom text, pprenom text)`
La procédure permet : 
1. De recuperer les 2 premier charactères du prenom/nom du collaborateur temporairement 
```sql
    temp_pseudo = LOWER(SUBSTRING(pnom FROM 1 FOR 2) || SUBSTRING(pprenom FROM 1 FOR 2));
```
2. Verifier si le pseudo actuel (seulement la soustraction des nom/prenom) existe déjà, si oui, ajouter 1 au compteur qui commence de base à 1 (madi01 -> madi02 -> madi03)
```sql
    WHILE EXISTS(
        SELECT 1
        FROM collaborateur
        WHERE pseudo = temp_pseudo || '0' || counter
    ) LOOP
        counter := counter + 1;
    END LOOP;
```
3. Inserer dans la base de données la résultat trouver et et définir le pseudo finale 
```sql
IF counter <= 0 then
        final_pseudo = concat(temp_pseudo, '0', '1');
    ELSE
        final_pseudo = concat(temp_pseudo, '0', CAST(counter AS TEXT));
    end if;


INSERT INTO Collaborateur (nom, prenom, pseudo)
VALUES (pnom, pprenom, final_pseudo);
```
### Procedure stocker `ajout_tache (nom_tache TEXT,temps_estimer INT,tache_parent TEXT)`
### Description
Ajoute une nouvelle tâche dans la base de données avec support de hiérarchie parent-enfant.
Paramètres
```sql
nom_tache (TEXT) - Nom de la tâche
temps_estimer (INT) - Temps estimé
tache_parent (TEXT) - Nom de la tâche parente (NULL pour tâche racine)
```

### Fonctionnement

Si tache_parent est spécifié → recherche son ID et crée une sous-tâche
Si tache_parent est NULL → crée une tâche racine

Exemple
```sql
CALL ajout_tache('Développement', 40, NULL);
```
```sql
-- Sous-tâche
CALL ajout_tache('Codage API', 15, 'Développement');
```

### Procédure stocker `attribution_colaborateur(pseudo_collab TEXT, nom_tache TEXT)`
La procédure permet d'attribuer un collaborateur à une tâche et insérer dans la table de jointure `Task_Colaborateur` l'id du collaborateur et l'id de la tâche mais aussi 

2. Vérifier l'existence d'un collaborateur et d'une tâche par leurs ID
```sql 
  IF EXISTS( -- Verifie l'existence d'une tache en fonction du nom et de du contenue de la table Task
            SELECT 1 FROM task WHERE nom_task = nom_tache
        ) THEN
            IF EXISTS( -- Verifie l'existence d'un coloborateur en fonction du nom et du contenue de la table Colaborateur
                SELECT 1 FROM collaborateur AS C WHERE pseudo_collab = c.pseudo
```

2. Récupérer les ID pour les insérer dans la table de jointure 
```sql
SELECT t.task_id FROM Task AS t WHERE t.nom_task = nom_tache INTO tid; -- Recuperer ID des taches pour la table de jointure et de l'inserer dans la table de jointure
                SELECT c.colab_id FROM collaborateur AS c WHERE c.pseudo = pseudo_collab INTO cid; -- Recuprer ID du colaborateur pour l'inserer dans la table de jointure
```

3. Si la tâche est affectée pour la première fois, alors le collaborateur devient le responsable de cette tâche, sinon, il devient simplement un participant
```sql 
IF EXISTS( -- Verifie l'existence d'une tache dans la table Task colab
                    SELECT 1 FROM task_colab AS tc
                    INNER JOIN task AS t
                    ON t.task_id = tc.task_id AND t.task_id = tid
                ) THEN
                    INSERT INTO task_colab VALUES (cid, tid, 'PARTICIPANT'); -- Si une tache existe déjà, cela veut dire qu'il y a deja 1 responsable
                ELSE
                    INSERT INTO task_colab VALUES (cid, tid, 'RESPONSABLE'); -- Si une tache n'existe pas, cela veut dire que la tache n'a pas été atttribue
                end if;
```


### Fonction `temps_tache(nom_temps text, total boolean = false)`
La fonction permet : 
1.  Si la fonction a comme argument d'entrer `false `, elle va récupérer le temps de la tâche 
```sql 
IF total = false THEN
            -- Si false, on récupère uniquement le temps d'une seule tâche
            SELECT temp_tache FROM TASK AS T WHERE nom_temps = t.nom_task INTO temp;
```

2. Si la fonction a comme argument d'entrer `true`, elle va :
   3. De récupérer la tâche de base 
   ```sql
    WITH RECURSIVE arbre AS (
                -- Recuperation de tache de base
                SELECT temp_tache, task_id, parent_id
                FROM Task
                WHERE nom_task = nom_temps

                UNION ALL
    ```
   4. Récursivement de récupérer chaque enfant de la tâche de base 
   ````sql
          -- Descendre jusqua l'enfant finale
                SELECT t.temp_tache, t.task_id, t.parent_id
                FROM Task as T
                INNER JOIN arbre as A ON t.parent_id = a.task_id
            )
    ```
---

## 📎 Annexes

- **Énoncé du projet** : Voir le fichier `ennonce.md`
- Arborésence du projet : 
```
EAFCUDLUX2025-2026
├── ennonce
├── storproc_and_function
    ├── ajout_colaborateur.sql
    ├── ajout_tache.sql
    ├── attribution_colaborateur.sql
    ├── get_hierarchy.sql
    └── temps_projet.sql
├── img.png
├── insert_into_test.sql
├── readme.md
└── table_creation.sql    
     
```
---

