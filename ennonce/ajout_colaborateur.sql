DROP PROCEDURE ajout_colaborateur(nom text, prenom text);

CREATE OR REPLACE PROCEDURE ajout_colaborateur(pnom text, pprenom text)
AS
$$
DECLARE
    temp_pseudo text;
    final_pseudo text;
    counter int := 1; -- Permet de commencer à partir de 1
BEGIN
    -- Inserer les donner de base dans la base de donner et recuperer le pseudo temporaire sans chiffre
    INSERT INTO Collaborateur (nom, prenom)
    VALUES (pnom, pprenom);
    temp_pseudo = LOWER(SUBSTRING(pnom FROM 1 FOR 2) || SUBSTRING(pprenom FROM 1 FOR 2));


    -- Permet de veriier si un collaborateur avec le même pseudo existe
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
        final_pseudo = concat(temp_pseudo, '0', CAST(counter AS VARCHAR));
    end if;

    -- Update de la row déjà existante
    UPDATE collaborateur
    SET pseudo = final_pseudo
    WHERE colab_id = (SELECT MAX(colab_id) FROM Collaborateur);


END;
$$LANGUAGE plpgsql;

CALL ajout_colaborateur('Matteo', 'DAseurs');
CALL ajout_colaborateur('Matteo', 'Diseurs');
SELECT * FROM collaborateur;

