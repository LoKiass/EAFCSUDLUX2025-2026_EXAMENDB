-- DROP FUNCTION get_hierachy(ftask_id int)
CREATE OR REPLACE function get_hierachy(ftask_id int)
RETURNS TABLE(
    ttask_id INT,
    tparent_id INT,
    tdescription TEXT,
    tlevel INT
)
AS
$$
BEGIN
    RETURN QUERY
    WITH RECURSIVE
    -- Recuperer la racine
    racine AS (
        SELECT task_id, parent_id, description_task, 0 AS level
        FROM Task
        WHERE task_id = ftask_id

        UNION ALL

        SELECT t.task_id, t.parent_id, t.description_task, r.level + 1
        FROM Task as t
        JOIN racine AS r ON t.task_id = r.parent_id
    ),
    -- Recuper la fin de l'arbre
    enfant_finale AS (
        SELECT task_id, parent_id, description_task, 0 AS level
        FROM Task
        WHERE task_id = (SELECT task_id FROM racine WHERE parent_id IS NULL)  -- La racine

        UNION ALL

        SELECT t.task_id, t.parent_id, t.description_task, ef.level + 1
        FROM Task as t
        JOIN enfant_finale as ef ON t.parent_id = ef.task_id
    )
    SELECT task_id, parent_id, description_task, level FROM enfant_finale;
    END
$$LANGUAGE plpgsql;



SELECT * from get_hierachy(5)