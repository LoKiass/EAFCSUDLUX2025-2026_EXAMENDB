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

| Fichier                 | Description                                                                                                                                                            |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `table_creation.sql`    | Script SQL pour créer les tables de la base de données                                                                                                                 |
| `insert_into_test.sql`  | Script SQL pour insérer des données de test                                                                                                                            |
| `get_hierarchy.sql`     | Script SQL contenant la fonction `get_hierarchy` pour récupérer la hiérarchie des tâches                                                                               |
| `README.md`             | Documentation du projet                                                                                                                                                |
| `ennonce.md`            | Énoncé du projet fourni par M. Sana                                                                                                                                    |.
| `ajout_colaborateur.sql` | Script SQL contenant la procedure stocker `ajout_colaborateur` pour inserer dans la table colaborateur leurs nom, prenom, pseudo (Voir fiche téchnique) et le colab_id |

---

## 🚀 Installation et Utilisation

### 1. Créer la base de données

Exécute le script `table_creation.sql` pour créer les tables :



### 2. Insérer les données de test

Exécute le script `insert_into_test.sql` pour insérer les données de test :


### 3. Tester la fonction `get_hierarchy`

Exécute le script `get_hierarchy.sql` pour tester la fonctionnalité :


---

## 📊 Fonctionnalités

### 1. Création des tables
Les tables sont conçues pour répondre aux besoins de l'énoncé, avec des contraintes d'intégrité (clés primaires, étrangères, etc.).

### 2. Insertion des données de test
Des données de test sont fournies pour valider les fonctionnalités.

### 3. Fonction `get_hierarchy`
Cette fonction permet de récupérer la hiérarchie des tâches (parent/enfant). 

### 4. Fonction `ajout_colaborateur`
Cette procédure stocjer permet d'inserer dans le tableau colaborateur des nom, prénom, peudonyme en fonction de l'ennoncé demander et le colab_id

---

## 📝 Documentation Technique

### Schéma de la Base de Données
![img.png](img.png)

Le schéma suivant respecte les formes normales de base de données (1FN, 2FN, 3FN, etc..).
### Fonction get_hierarchy() (voir `get_hierarchy.sql`)
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
3. Et donc de donnée la hierarchie d'une tache

### Utilisation de la commande 
```sql
-- Utilisation de la fonction
SELECT * FROM get_hierarchy(5)
```
### Procédure stocker ajout_colaborateur 
La procédure permet : 
1. L'insertion initiale : Enregistre le nom et prénom du collaborateur dans la base
2. Génération du pseudo : Crée un pseudo à partir des 2 premières lettres du nom et du prénom en minuscules
3. Gestion des doublons : Vérifie l'existence de pseudos similaires et incrémente un compteur jusqu'à trouver un pseudo disponible (ex : duje01, duje02, etc.)
Mise à jour : Affecte le pseudo unique au collaborateur nouvellement inséré



---

## 📎 Annexes

- **Énoncé du projet** : Voir le fichier `ennonce.md`

---

