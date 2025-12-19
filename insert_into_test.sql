-- COMMANDE TEST POUR LA FONCTION get_hierarchy
SELECT * FROM get_hierachy(1);

-- TEST DEFENSIF EFFECTUER LE 18/12 à 19h04
SELECT * FROM get_hierachy(33); -- Ne doit pas fonctionner
SELECT * FROM get_hierachy('a'); -- Ne doit pas fonctionner
SELECT * FROM get_hierachy(); -- Ne doit pas fonctionner


-- COMMANDE TEST POUR LA PROCEDURE STOCKER ajout_tache
CALL ajout_tache ('TACHE1', 11, '');
CALL ajout_tache('TACHE2', 11, 'TACHE1');
CALL ajout_tache('TACHE4', 11, 'TACHE1');
CALL ajout_tache('TACHE10', 11, 'TACHE2');

CALL ajout_tache ('TACHE5', 11, '');
CALL ajout_tache('TACHE6', 11, 'TACHE5');
CALL ajout_tache('TACHE7', 11, 'TACHE5');
CALL ajout_tache('TACHE8', 11, 'TACHE8');
CALL ajout_tache('TACHE91', 11, 'TACHE91'); -- NE DEVREZ PAS FONCTIONNER
CALL ajout_tache('TACHE 81', -1, ''); -- NE DEVREZ PAS FONCTIONNER

-- TEST DEFENSIF EFFECTUER LE 18/12 à 18h22 : TERMINER A 18h51
CALL ajout_tache('1', 13, ''); -- ne devrez pas fonctionner
CALL ajout_tache('!', 0, ''); -- ne devrez pas fonctionner
CALL ajout_tache('a', 0, 'a'); -- ne devrez pas fonctionner
CALL ajout_tache('A', -1, 'X'); -- ne devrez pas fonctionner
CALL ajout_tache('', 'A', ''); -- ne deverez pas fonctionner
CALL ajout_tache('Une belle tache', 0, 'AAAA'); -- NE DEVREZ PAS FONCTIONNER
call ajout_tache('Le feu', 0, 'Une belle tache'); -- Doit fonctioner
CALL ajout_tache('C', 0, '!');
CALL ajout_tache('n', 0, '');


SELECT * FROM get_hierachy(13);

SELECT * FROM task;

-- COMMANDE TEST POUR LA PROCEDURE STOCKER ajout_colaborateur
CALL ajout_colaborateur('Matteo', 'DAseurs');
CALL ajout_colaborateur('Matteo', 'Diseurs');
SELECT * FROM collaborateur;

-- TEST DEFENSIF EFFECTUER LE 18/12 à 17h11 : FIN A 18H20 AVEC SUCCES
CALL ajout_colaborateur('', ''); -- NE DEVREZ PAS FONCTIONNER
CALL ajout_colaborateur(' ', ''); -- NE DEVREZ PAS FONCTIONNER
CALL ajout_colaborateur('X', ' '); -- NE DEVREZ PAS FONCTIONNER
CALL ajout_colaborateur('         ', 'x'); -- NE DEVREZ PAS FONCTIONNER
CALL ajout_colaborateur('1', '1'); -- NE DEVREZ PAS FONCTIONNER
CALL ajout_colaborateur('a', 'a'); -- DOIT FONCTIONNER
CALL ajout_colaborateur('A', '!'); -- NE DOIT PAS FONCTIONNER



-- COMMANDE TEST POUR LA PROCEDURE STOCJER attribution_colaborateur
CALL attribution_colaborateur('madi02', 'TACHE2'); -- Fonctionne
CALL attribution_colaborateur('madi0', 'TACHE1'); -- Ne fonctionne pas
CALL attribution_colaborateur('madi0', 'TACHE'); -- Ne fonctionne pas
CALL attribution_colaborateur('madi0', 'TACHE1'); -- Ne fonctionne pas

CALL attribution_colaborateur('madi02', 'TACHE3'); -- Ne fonctionne pas
CALL attribution_colaborateur('madi01', 'TACHE3'); -- Ne fonctionne pas
CALL attribution_colaborateur('madi03', 'TACHE3'); -- Ne fonctionne pas
CALL attribution_colaborateur('mada01', 'TACHE3'); -- Ne fonctionne pas
SELECT * FROM task_colab ORDER BY task_id;

-- TEST DEFENSIIF EFFECTUER LE 18/12 à 18h53 : Terminer à 19h00
CALL attribution_colaborateur('a', '!'); -- Ne doit pas fonctionner
CALL attribution_colaborateur('madi01', 'Une belle tache');
CALL attribution_colaborateur('', '');


-- COMMANDE TEST POUR LA FONCTION temps_tache

SELECT * FROM temps_tache('TACHE1', TRUE);
SELECT * FROM task

-- TEST DEFENSIF Effectuer le 19/12 -- TERMINER LE 19/12 A 18h22
SELECT * FROM temps_tache('JE SIIS ÄS ', false); -- Ne doit pas fonctionner car la tache existe pas
SELECT * FROM temps_tache('', false); -- Ne doit pas fonctionner
SELECT * FROM temps_tache(' ', false); -- Ne doit pas fonctionner
SELECT * FROM temps_tache('X', true); -- Doit fonctionner

SELECT * FROM task;