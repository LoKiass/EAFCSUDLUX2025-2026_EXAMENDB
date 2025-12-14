CREATE OR REPLACE PROCEDURE ajout_tache (nom_tache TEXT,temps_estimer INT,tache_parent TEXT)
AS $$
DECLARE
    parent_id INT;
BEGIN
    IF tache_parent = nom_tache THEN RAISE EXCEPTION 'La tache ne peut pas être parent de elle même !'; END IF;
    -- Dans le cas ou nous avons fait le zigoto à avoir une tache parent avec le nom tache identique, dans tous les cas
    -- Il ne mettra pas l'id du parent car il n'existe pas dans la table !
    -- Mais pour eviter du temps d'excution de la fontion

    IF temps_estimer < 0 THEN RAISE EXCEPTION 'Le temps estimer ne peut pas etre negatif'; END IF;
    -- Si le temps est negatif, on le refuse


    IF tache_parent IS NOT NULL THEN -- Verifier les arguments d'entrer de la fonction pour avoir si la tache à un parent ou non
        IF EXISTS(SELECT 1 FROM Task WHERE nom_task = nom_tache) THEN -- Verifier l'existence de la tache ou non
            RAISE EXCEPTION 'La tache existe déjà' ;
        ELSE
            SELECT task_id INTO parent_id
            FROM Task
            WHERE nom_task = tache_parent; -- Recuprer l'id du parent pour la table Task

            INSERT INTO Task (parent_id, nom_task, description_task, temp_tache)
            VALUES (parent_id, nom_tache, ' ', temps_estimer);
        END IF;
    ELSE
        INSERT INTO Task (nom_task, description_task, temp_tache)
        VALUES (nom_tache, ' ', temps_estimer);
    END IF;

END;
$$ LANGUAGE plpgsql;
