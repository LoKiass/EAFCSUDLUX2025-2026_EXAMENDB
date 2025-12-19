CREATE OR REPLACE PROCEDURE attribution_colaborateur(pseudo_collab TEXT, nom_tache TEXT)
AS
$$
    DECLARE
        tid INT;
        cid int;
    BEGIN
-- BLOC DEFENSIVE DE TEST DE L'ENTRER DE LA FONCTION
    IF (check_for_text(nom_tache) IS FALSE) THEN RAISE EXCEPTION 'Le nom de la tache ne peu contenir uniquement des lettres'; END IF;


-- Debut de la fonction
        IF EXISTS( -- Verifie l'existence d'une tache en fonction du nom et de du contenue de la table Task
            SELECT 1 FROM task WHERE nom_task = nom_tache
        ) THEN
            IF EXISTS( -- Verifie l'existence d'un coloborateur en fonction du nom et du contenue de la table Colaborateur
                SELECT 1 FROM collaborateur AS C WHERE pseudo_collab = c.pseudo
            ) THEN
                SELECT t.task_id FROM Task AS t WHERE t.nom_task = nom_tache INTO tid; -- Recuperer ID des taches pour la table de jointure et de l'inserer dans la table de jointure
                SELECT c.colab_id FROM collaborateur AS c WHERE c.pseudo = pseudo_collab INTO cid; -- Recuprer ID du colaborateur pour l'inserer dans la table de jointure

                IF EXISTS( -- Verifie l'existence d'une tache dans la table Task colab
                    SELECT 1 FROM task_colab AS tc
                    INNER JOIN task AS t
                    ON t.task_id = tc.task_id AND t.task_id = tid
                ) THEN
                    INSERT INTO task_colab VALUES (cid, tid, 'PARTICIPANT'); -- Si une tache existe déjà, cela veut dire qu'il y a deja 1 responsable
                ELSE
                    INSERT INTO task_colab VALUES (cid, tid, 'RESPONSABLE'); -- Si une tache n'existe pas, cela veut dire que la tache n'a pas été atttribue
                end if;
            ELSE
                RAISE EXCEPTION 'Aucun colaborateur trouver' USING HINT = 'Verifier existence du colaborateur' ;
            end if;
        ELSE
            RAISE EXCEPTION 'Aucune Task trouver' USING HINT = 'Verifier existence de la tâche' ;
        END IF;
        RAISE NOTICE 'Action effectuer avec succes';
    END;

$$ LANGUAGE plpgsql;

