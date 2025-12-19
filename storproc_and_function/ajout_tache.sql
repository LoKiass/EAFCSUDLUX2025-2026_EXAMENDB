CREATE OR REPLACE PROCEDURE ajout_tache (nom_tache TEXT,temps_estimer INT,tache_parent TEXT)
AS $$
DECLARE
    parent_id INT;
BEGIN
-- Bloc de test defensif de l'entrer de la fonction
    IF tache_parent = nom_tache THEN RAISE EXCEPTION 'La tache ne peut pas être parent de elle même !'; END IF;
    -- Dans le cas ou nous avons fait le zigoto à avoir une tache parent avec le nom tache identique, dans tous les cas
    -- Il ne mettra pas l'id du parent car il n'existe pas dans la table !
    -- Mais pour eviter du temps d'excution de la fontion

    IF nom_tache IS NULL OR TRIM(nom_tache) = '' THEN RAISE EXCEPTION 'Vous devez fournir un nom pour la tache'; END IF;
    IF temps_estimer < 0 THEN RAISE EXCEPTION 'Le temps estimer ne peut pas etre negatif'; END IF; -- Si le temps est negatif, on le refuse
    IF (check_for_text(nom_tache) IS FALSE) THEN RAISE EXCEPTION 'Le nom de la tâche doit uniquement contenir des lettre et des accents'; END IF;


-- Debut de la fonction
    IF tache_parent IS NULL OR TRIM(tache_parent) = '' THEN -- Verifier si la tache parent et vide ou contient uniquement que des espaces
        INSERT INTO Task (nom_task, description_task, temp_tache)
        VALUES (nom_tache, ' ', temps_estimer);
    ELSE
        IF (check_for_text(tache_parent) IS FALSE) THEN RAISE EXCEPTION 'La tache parent ne peux uniquement contenir des lettres '; END IF;

        IF EXISTS (SELECT 1 FROM Task AS t WHERE tache_parent = t.nom_task) THEN -- Verifier l'existence de la tache parent dans la base de donné
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
            RAISE EXCEPTION 'La tache parent fournite existe pas';
        END IF;
    END IF;
END;
$$ LANGUAGE plpgsql;
