{{ config(
    materialized='view',
)}}

-- Création d'une table int_accidents pour regrouper les informations principales

-- sq1 = première jointure avec la table caracteristiques_accidents

WITH sq1 AS (
    SELECT
        cara.date_date
        ,cara.Num_Acc
        ,veh.num_veh
        ,veh.cle
        ,veh.categorie_vehicule
        ,cara.intersection
        ,cara.longitude
        ,cara.latitude
        ,cara.meteo
    FROM {{ref('stg_caracteristiques_accidents')}} as cara
    LEFT JOIN {{ref('stg_vehicules_accidents')}} as veh
        ON cara.Num_Acc = veh.Num_Acc
    WHERE veh.categorie_vehicule = 'Bicyclette'
),

-- Jointure optionelle avec la table pluie pour obtenir la quantité exacte de pluie en cas d'accidents

sq2 AS (
    SELECT
        sq1.*
        ,plu.pluie_mm
    FROM sq1
    LEFT JOIN {{ref('int_pluvio_by_day')}} as plu
    ON sq1.date_date = plu.date_date
),

-- Join avec la table lieux_accidents

sq3 AS (
    SELECT
        sq2.*
        ,lieux.situation
        ,lieux.voie_reservee
    FROM sq2
    LEFT JOIN {{ref('stg_lieux_accidents')}} as lieux
    ON sq2.Num_Acc = lieux.Num_Acc
)

-- Join avec la table usagers_accidents

SELECT
    sq3.Num_Acc
    ,sq3.cle
    ,sq3.date_date
    ,sq3.categorie_vehicule
    ,usa.sexe
    ,usa.annee_naissance
    ,usa.gravite_blessure
    ,sq3.meteo
    ,sq3.pluie_mm
    ,sq3.situation
    ,sq3.intersection
    ,sq3.voie_reservee
    ,usa.trajet
    ,sq3.longitude
    ,sq3.latitude
FROM sq3
LEFT JOIN {{ref('stg_usagers_accidents')}} as usa
ON sq3.cle = usa.cle 
ORDER BY sq3.Num_Acc DESC

