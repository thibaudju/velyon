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
        ,REPLACE(cara.latitude,",",".") as latitude
        ,REPLACE(cara.longitude,",",".") as longitude
        ,cara.commune_insee
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
),

sq4 AS (
    SELECT
        sq3.*,
        commune,
        total_habitants,
        surface_km2
    FROM sq3 
    LEFT JOIN {{ref('int_commune_insee')}} icom ON icom.insee=sq3.commune_insee
)

-- Join avec la table usagers_accidents

SELECT
    sq4.Num_Acc
    ,sq4.cle
    ,sq4.date_date
    ,sq4.categorie_vehicule
    ,CASE
        WHEN usa.sexe IS NULL THEN "Non défini"
        ELSE usa.sexe
        END AS sexe
    ,CASE
        WHEN usa.annee_naissance IS NULL THEN "Non défini"
        ELSE CAST(usa.annee_naissance AS STRING)
        END AS annee_naissance
    ,CASE
        WHEN usa.gravite_blessure IS NULL THEN "Non défini"
        ELSE usa.gravite_blessure
        END AS gravite_blessure
    ,sq4.meteo
    ,CASE
        WHEN sq4.pluie_mm IS NULL THEN 0
        ELSE sq4.pluie_mm
        END AS pluie_mm
    ,sq4.situation
    ,sq4.intersection
    ,sq4.voie_reservee
    ,CASE
        WHEN usa.trajet IS NULL THEN "Non défini"
        ELSE usa.trajet
        END AS trajet
    ,sq4.latitude as Latitude
    ,sq4.longitude as Longitude
    ,CONCAT(sq4.latitude,",",sq4.longitude) as geo_coordinates
    ,sq4.commune
    ,sq4.total_habitants
    ,sq4.surface_km2
FROM sq4
LEFT JOIN {{ref('stg_usagers_accidents')}} as usa
ON sq4.cle = usa.cle 
ORDER BY sq4.Num_Acc DESC

