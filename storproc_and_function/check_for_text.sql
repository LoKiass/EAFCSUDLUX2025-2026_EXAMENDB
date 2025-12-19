CREATE OR REPLACE FUNCTION check_for_text(StringToTest text)
RETURNS boolean
AS $$
BEGIN
    -- Vérifier si contient uniquement des lettres (avec accents) et espaces
    RETURN StringToTest ~ '^[a-zA-ZÀ-ÿ\s]+$';
END;
$$ LANGUAGE plpgsql;