{{ config(
    materialized='view',
)}}

-- Cleaning de la table "lieux_accidents"

SELECT 
Num_Acc,
    CASE 
        WHEN catr = 1 THEN 'Autoroute'
        WHEN catr = 2 THEN 'Route nationale'
        WHEN catr = 3 THEN 'Route Départementale'
        WHEN catr = 4 THEN 'Voie Communales'
        WHEN catr = 5 THEN 'Hors réseau public'
        WHEN catr = 6 THEN 'Parc de stationnement ouvert à la circulation publique'
        WHEN catr = 7 THEN 'Routes de métropole urbaine'
        WHEN catr = 9 THEN 'autre'
        ELSE ' '
    END as categorie_route,
    CASE 
        WHEN circ = 1 THEN 'Non renseigné'
        WHEN circ = 2 THEN 'A sens unique'
        WHEN circ = 3 THEN 'Bidirectionnelle'
        WHEN circ = 4 THEN 'A chaussées séparées'
        WHEN circ = 5 THEN 'Avec voies d’affectation variable'
        ELSE ' '
    END as circulation,
nbv as nombre_de_voies,
    CASE
        WHEN vosp = -1 THEN 'Non renseigné'
        WHEN vosp = 0 THEN 'Sans objet'
        WHEN vosp = 1 THEN 'Piste cyclable'
        WHEN vosp = 2 THEN 'Bande cyclable'
        WHEN vosp = 3 THEN 'Voie réservée'
        ELSE ' '
    END as voie_reservee,
    CASE
        WHEN prof = -1 THEN 'Non renseigné'
        WHEN prof = 1 THEN 'Plat'
        WHEN prof = 2 THEN 'Pent'
        WHEN prof = 3 THEN 'Sommet de côte'
        WHEN prof= 4 THEN 'Bas de côte'
        ELSE ' '
    END as profil_route,
    CASE
        WHEN plan = -1 THEN 'Non renseigné'
        WHEN plan = 1 THEN 'Partie rectiligne'
        WHEN plan = 2 THEN 'En courbe à gauche'
        WHEN plan = 3 THEN 'En courbe à droite'
        WHEN plan= 4 THEN 'En « S »'
        ELSE ' '
    END as plan,
COALESCE(lartpc,'') as largeur_tpc,
COALESCE(larrout, '') as largeur_route,
    CASE
        WHEN surf = -1 THEN 'Non renseigné'
        WHEN surf = 1 THEN 'Normale'
        WHEN surf = 2 THEN 'Mouillée'
        WHEN surf = 3 THEN 'Flaques'
        WHEN surf = 4 THEN 'Inondée'
        WHEN surf = 5 THEN 'Enneigée'
        WHEN surf = 6 THEN 'Boue'
        WHEN surf = 7 THEN 'Verglacée'
        WHEN surf = 8 THEN 'Corps gras – huile'
        WHEN surf = 9 THEN 'Autre'
        ELSE ' '
    END as surface,
    CASE
        WHEN infra = -1 THEN 'Non renseigné'
        WHEN infra = 0 THEN 'Aucun'
        WHEN infra = 1 THEN 'Souterrain - tunnel'
        WHEN infra = 2 THEN 'Pont - autopont'
        WHEN infra = 3 THEN 'Bretelle d’échangeur ou de raccordement'
        WHEN infra = 4 THEN 'Voie ferrée'
        WHEN infra = 5 THEN 'Carrefour aménagé'
        WHEN infra = 6 THEN 'Zone piétonne'
        WHEN infra = 7 THEN 'Zone de péage'
        WHEN infra = 8 THEN 'Chantiers'
        WHEN infra = 9 THEN 'Autres'
        ELSE ' '
    END as infrastructure,
    CASE
        WHEN situ = -1 THEN 'Non renseigné'
        WHEN situ = 0 THEN 'Aucun'
        WHEN situ = 1 THEN 'Sur chaussée'
        WHEN situ = 2 THEN 'Sur bande d’arrêt d’urgence'
        WHEN situ = 3 THEN 'Sur accotement'
        WHEN situ = 4 THEN 'Sur trottoir'
        WHEN situ = 5 THEN 'Sur piste cyclable'
        WHEN situ = 6 THEN 'Sur autre voie spéciale'
        WHEN situ = 8 THEN 'Autres'
        ELSE ' '
    END as situation

FROM velyon-batch-1187.accident.lieux_all