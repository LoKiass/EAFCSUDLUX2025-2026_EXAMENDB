CREATE OR REPLACE PROCEDURE ajout_tache (nom_tache TEXT,temps_estimer INT,tache_parent TEXT)
AS $$
DECLARE
    parent_id INT;
BEGIN

    IF tache_parent IS NOT NULL THEN
        SELECT task_id INTO parent_id
        FROM Task
        WHERE nom_task = tache_parent;

        INSERT INTO Task (parent_id, nom_task, description_task, temp_tache)
        VALUES (parent_id, nom_tache, ' ', temps_estimer);

    ELSE
        INSERT INTO Task (nom_task, description_task, temp_tache)
        VALUES (nom_tache, ' ', temps_estimer);
    END IF;

END;
$$ LANGUAGE plpgsql;
