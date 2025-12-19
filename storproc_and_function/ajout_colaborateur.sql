CREATE OR REPLACE PROCEDURE ajout_colaborateur(pnom text, pprenom text)
AS
$$
DECLARE
    temp_pseudo text;
    final_pseudo text;
    counter int := 1; -- Permet de commencer à partir de 1
BEGIN
-- Bloc de test defensif de l'entrer de la fonction ajout_colaborateur
    IF pnom IS NULL OR TRIM(pnom) = '' THEN RAISE EXCEPTION 'Vous devez inseré un nom au pre-alable'; END IF;
    IF pprenom IS NULL OR TRIM(pprenom) = '' THEN RAISE EXCEPTION  'Vous devez inserer un prenom au pre-alable'; END IF;
    IF (check_for_text(pnom) IS FALSE) THEN RAISE EXCEPTION  'Le nom doit contenir uniquement des lettre et accent'; END IF;
    IF (check_for_text(pprenom) IS FALSE) THEN RAISE EXCEPTION 'Le prenom doit contenir uniquement des lettre et accent'; END IF;

-- Debut de la fonction
    -- Obtention du pseudo temporaire par la soustraction des chaque 2 premiers charactere
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

    RAISE NOTICE 'Action effectuer avec succès ';
END;
$$LANGUAGE plpgsql;




