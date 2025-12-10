DROP PROCEDURE ajout_colaborateur(nom text, prenom text);

CREATE OR REPLACE PROCEDURE ajout_colaborateur(pnom text, pprenom text)
AS
$$
DECLARE
    temp_pseudo text;
    final_pseudo text;
    counter int := 1; -- Permet de commencer à partir de 1
BEGIN
    -- Obtention du pseudo temporaire par la soustraction des chaque 2 premier charactere
    temp_pseudo = LOWER(SUBSTRING(pnom FROM 1 FOR 2) || SUBSTRING(pprenom FROM 1 FOR 2));

    -- Permet de verifier si un collaborateur avec le même pseudo existe
    WHILE EXISTS(
        SELECT 1
        FROM collaborateur
        WHERE pseudo = temp_pseudo || '0' || counter
    ) LOOP
        counter := counter + 1;
    END LOOP;

    -- Verifier si un il est le prermier collaborateur avec ce pseudonyme ou non
    IF counter <= 0 then
        final_pseudo = concat(temp_pseudo, '0', '1');
    ELSE
        final_pseudo = concat(temp_pseudo, '0', CAST(counter AS TEXT));
    end if;


    INSERT INTO Collaborateur (nom, prenom, pseudo)
    VALUES (pnom, pprenom, final_pseudo);
    -- Suppresion de l'update afin d'inserer toutes les valeurs directement dans la table sans update
    -- Ce qui permet une procédure stocker plus certaines sans transaction obligatoire
END;
$$LANGUAGE plpgsql;




