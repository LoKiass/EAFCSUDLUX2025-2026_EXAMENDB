-- COMMANDE TEST POUR LA FONCTION get_hierarchy
SELECT * FROM get_hierachy(1);

-- COMMANDE TEST POUR LA PROCEDURE STOCKER ajout_tache
CALL ajout_tache ('TACHE1', 11, '');
CALL ajout_tache('TACHE2', 11, 'TACHE1');
CALL ajout_tache('TACHE4', 11, 'TACHE1');
CALL ajout_tache('TACHE3', 11, 'TACHE2');

CALL ajout_tache ('TACHE5', 11, '');
CALL ajout_tache('TACHE6', 11, 'TACHE5');
CALL ajout_tache('TACHE7', 11, 'TACHE5');
CALL ajout_tache('TACHE8', 11, 'TACHE6');


SELECT * FROM get_hierachy(8);

SELECT * FROM task;

-- COMMANDE TEST POUR LA PROCEDURE STOCKER ajout_colaborateur
CALL ajout_colaborateur('Matteo', 'DAseurs');
CALL ajout_colaborateur('Matteo', 'Diseurs');
SELECT * FROM collaborateur;

-- COMMANDE TEST POUR LA PROCEDURE STOCJER attribution_colaborateur
CALL attribution_colaborateur('madi02', 'TACHE2'); -- Fonctionne
CALL attribution_colaborateur('madi0', 'TACHE1'); -- Fonctionne pas
CALL attribution_colaborateur('madi0', 'TACHE'); -- Fonctionne pas
CALL attribution_colaborateur('madi0', 'TACHE1'); -- Fonctionne pas

CALL attribution_colaborateur('madi02', 'TACHE3'); -- Fonctionne pas
CALL attribution_colaborateur('madi01', 'TACHE3'); -- Fonctionne pas
CALL attribution_colaborateur('madi03', 'TACHE3'); -- Fonctionne pas
CALL attribution_colaborateur('mada01', 'TACHE3'); -- Fonctionne pas


SELECT * FROM task_colab ORDER BY task_id;