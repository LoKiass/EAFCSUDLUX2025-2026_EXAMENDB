CREATE OR REPLACE FUNCTION temps_tache(nom_temps text, total boolean = false)
RETURNS INT
AS
$$
    DECLARE
        temp int;
    BEGIN
-- Bloc de test defensif du code
    IF (check_for_text(nom_temps) IS FALSE) THEN RAISE EXCEPTION 'Le nom du temps doit uniquement contenir des lettres'; END IF;
    IF (nom_temps IS NULL OR TRIM(nom_temps) = '') THEN RAISE EXCEPTION 'Vous devez à minimum fournir le nom du temps que vous voulez recuperer'; END IF;
    IF NOT EXISTS(SELECT 1 FROM task WHERE nom_temps = nom_task) THEN RAISE EXCEPTION 'La task fournite existe pas'; END IF;

        IF total = false THEN
            -- Si false, on récupère uniquement le temps d'une seule tâche
            SELECT temp_tache FROM TASK AS T WHERE nom_temps = t.nom_task INTO temp;
        ELSE
            -- Sinon, on récupère le temps de la tâche + tous ses descendants
            WITH RECURSIVE arbre AS (
                -- Recuperation de tache de base
                SELECT temp_tache, task_id, parent_id
                FROM Task
                WHERE nom_task = nom_temps

                UNION ALL

                -- Descendre jusqua l'enfant finale
                SELECT t.temp_tache, t.task_id, t.parent_id
                FROM Task as T
                INNER JOIN arbre as A ON t.parent_id = a.task_id
            )
            SELECT SUM(temp_tache) FROM arbre INTO temp;
        END IF;

        RETURN temp;
    END;
$$ LANGUAGE PLPGSQL;

SELECT * from task