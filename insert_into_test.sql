-- COMMAN TEST POUR LA PROCEDURE STOCKER ajout_tache
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