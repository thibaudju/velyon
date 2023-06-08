{{ config(
    materialized='view',
)}}


-- création d'une clé unique avec la combinaison Num_Acc + num_veh --

WITH sb1 AS (
  SELECT
    concat(Num_Acc, num_veh) as cle
    ,*
FROM velyon-batch-1187.accident.vehicules_all
),

-- Cette subquery compte le nombre de fois où la clé "unique" appararait (environ 100 lignes avaient mal été completées
-- ce qui créait quelques doublons dans les clés)

    sb2 AS (
        SELECT
        COUNT(cle) OVER(PARTITION BY cle) as iteration
        ,*
    FROM sb1
    )

-- Cleaning de la table "vehicules_accidents"

SELECT 
Num_Acc,
num_veh,
cle,
id_vehicule,
    CASE 
        WHEN catv = 00 THEN 'Indéterminable'
        WHEN catv = 01 THEN 'Bicyclette'
        WHEN catv = 02 THEN 'Cyclomoteur <50cm3'
        WHEN catv = 03 THEN 'Voiturette'
        WHEN catv = 04 THEN 'scooter immatriculé'
        WHEN catv = 05 THEN 'motocyclette'
        WHEN catv = 06 THEN 'side-car'
        WHEN catv = 07 THEN 'VL seul'
        WHEN catv = 08 THEN 'VL + caravane'
        WHEN catv = 09 THEN 'VL + remorque'
        WHEN catv = 10 THEN 'VU seul'
        WHEN catv = 11 THEN 'VU (10) + caravane'
        WHEN catv = 12 THEN 'VU (10) + remorque'
        WHEN catv = 13 THEN 'PL seul 3,5T <PTCA <= 7,5T'
        WHEN catv = 14 THEN 'PL seul > 7,5T'
        WHEN catv = 15 THEN 'PL > 3,5T + remorque'
        WHEN catv = 16 THEN 'Tracteur routier seul'
        WHEN catv = 17 THEN 'Tracteur routier + semi-remorque'
        WHEN catv = 18 THEN 'transport en commun'
        WHEN catv = 19 THEN 'tramway'
        WHEN catv = 20 THEN 'Engin spécial'
        WHEN catv = 21 THEN 'Tracteur agricole'
        WHEN catv = 30 THEN 'Scooter < 50 cm3'
        WHEN catv = 31 THEN 'Motocyclette > 50 cm3 et <= 125 cm3'
        WHEN catv = 32 THEN 'Scooter > 50 cm3 et <= 125 cm3'
        WHEN catv = 33 THEN 'Motocyclette > 125 cm3'
        WHEN catv = 34 THEN 'Scooter > 125 cm3'
        WHEN catv = 35 THEN 'Quad léger <= 50 cm3'
        WHEN catv = 36 THEN 'Quad lourd > 50 cm3'
        WHEN catv = 37 THEN 'Autobus'
        WHEN catv = 38 THEN 'Autocar'
        WHEN catv = 39 THEN 'Train'
        WHEN catv = 40 THEN 'Tramway'
        WHEN catv = 41 THEN '3RM <= 50 cm3'
        WHEN catv = 42 THEN '3RM > 50 cm3 <= 125 cm3'
        WHEN catv = 43 THEN '3RM > 125 cm3'
        WHEN catv = 50 THEN 'EDP à moteur'
        WHEN catv = 60 THEN 'EDP sans moteur'
        WHEN catv = 80 THEN 'VAE'
        WHEN catv = 99 THEN 'Autre véhicule'
        ELSE ' '
    END as categorie_vehicule,
     CASE 
        WHEN obs = -1 THEN 'Non renseigné'
        WHEN obs = 0 THEN 'Sans objet'
        WHEN obs = 1 THEN 'Véhicule en stationnement'
        WHEN obs = 2 THEN 'Arbre'
        WHEN obs = 3 THEN 'Glissière métallique'
        WHEN obs = 4 THEN 'Glissière béton'
        WHEN obs = 5 THEN 'Autre glissière'
        WHEN obs = 6 THEN 'Bâtiment, mur, pile de pont'
        WHEN obs = 7 THEN 'Support de signalisation verticale ou poste d’appel d’urgence'
        WHEN obs = 8 THEN 'Poteau'
        WHEN obs = 9 THEN 'Mobilier urbain'
        WHEN obs = 10 THEN 'Parapet'
        WHEN obs = 11 THEN 'Ilot, refuge, borne haute'
        WHEN obs = 12 THEN 'Bordure de trottoir'
        WHEN obs = 13 THEN 'Fossé, talus, paroi rocheuse'
        WHEN obs = 14 THEN 'Autre obstacle fixe sur chaussée'
        WHEN obs = 15 THEN 'Autre obstacle fixe sur trottoir ou accotement'
        WHEN obs = 16 THEN 'Sortie de chaussée sans obstacle'
        WHEN obs = 17 THEN 'Buse – tête d’aqueduc'
        ELSE ' '
    END as obstacle_fixe,
    CASE 
        WHEN obsm = -1 THEN 'Non renseigné'
        WHEN obsm = 0 THEN 'Aucun'
        WHEN obsm = 1 THEN 'Piéton'
        WHEN obsm = 2 THEN 'Véhicule'
        WHEN obsm = 4 THEN 'Véhicule sur rail'
        WHEN obsm = 5 THEN 'Animal domestique'
        WHEN obsm = 6 THEN 'Animal sauvage'
        WHEN obsm = 9 THEN 'Autre'        
        ELSE ' '
    END as obstacle_mobile,
     CASE 
        WHEN choc = -1 THEN 'Non renseigné'
        WHEN choc = 0 THEN 'Aucun'
        WHEN choc = 1 THEN 'Avant'
        WHEN choc = 2 THEN 'Avant droit'
        WHEN choc = 3 THEN 'Avant gauche'
        WHEN choc = 4 THEN 'Arrière'
        WHEN choc = 5 THEN 'Arrière droit'
        WHEN choc = 6 THEN 'Arrière gauche'
        WHEN choc = 7 THEN 'Côté droit'
        WHEN choc = 8 THEN 'Côté gauche'        
        WHEN choc = 8 THEN 'Chocs multiples (tonneaux)'        
        ELSE ' '
    END as choc,
    CASE 
        WHEN manv = -1 THEN 'Non renseigné'
        WHEN manv = 0 THEN 'Inconnue'
        WHEN manv = 1 THEN 'Sans changement de direction'
        WHEN manv = 2 THEN 'Même sens, même file'
        WHEN manv = 3 THEN 'Entre 2 files'
        WHEN manv = 4 THEN 'En marche arrière'
        WHEN manv = 5 THEN 'A contresens'
        WHEN manv = 6 THEN 'En franchissant le terre-plein central'
        WHEN manv = 7 THEN 'Dans le couloir bus, dans le même sens'
        WHEN manv = 8 THEN 'Dans le couloir bus, dans le sens inverse'
        WHEN manv = 9 THEN 'En s’insérant'
        WHEN manv = 10 THEN 'En faisant demi-tour sur la chaussée'
        WHEN manv = 11 THEN 'Changeant de file à gauche'
        WHEN manv = 12 THEN 'Changeant de file à droite'
        WHEN manv = 13 THEN 'Déporté à gauche'
        WHEN manv = 14 THEN 'Déporté à droite'
        WHEN manv = 15 THEN 'Tournant à gauche'
        WHEN manv = 16 THEN 'Tournant à droite'
        WHEN manv = 17 THEN 'Dépassant à gauche'
        WHEN manv = 18 THEN 'Dépassant à droite'
        WHEN manv = 19 THEN 'Traversant la chaussée'
        WHEN manv = 20 THEN 'Manœuvre de stationnement'
        WHEN manv = 21 THEN 'Manœuvre d’évitement'
        WHEN manv = 22 THEN 'Ouverture de porte'
        WHEN manv = 23 THEN 'Arrêté (hors stationnement)'
        WHEN manv = 24 THEN 'En stationnement (avec occupants)'
        WHEN manv = 25 THEN 'Circulant sur trottoir'
        WHEN manv = 26 THEN 'Autres manœuvres'
        ELSE ' '
    END as manoeuvre,
    CASE 
        WHEN motor = -1 THEN 'Non renseigné'
        WHEN motor = 0 THEN 'Inconnue'
        WHEN motor = 1 THEN 'Hydrocarbures'
        WHEN motor = 2 THEN 'Hybride électrique'
        WHEN motor = 3 THEN 'Electrique'
        WHEN motor = 4 THEN 'Hydrogène'
        WHEN motor = 5 THEN 'Humaine'
        WHEN motor = 6 THEN 'Autre'
        ELSE ' '
    END as motor
        
FROM sb2
-- filtre pour garder les clés qui apparaissent uniquement une fois
WHERE iteration =1
