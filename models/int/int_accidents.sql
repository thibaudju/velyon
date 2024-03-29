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
    FROM {{ref('stg_cara_accidents_clean')}} as cara
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

sq4 AS (
    SELECT
        sq2.*
        ,commune
    FROM sq2
    LEFT JOIN {{ref("int_commune_insee")}} as com
    ON sq2.commune_insee = com.insee
),
-- Join avec la table lieux_accidents
sq3 AS (
    SELECT
        sq4.*
        ,lieux.situation
        ,lieux.voie_reservee
    FROM sq4
    LEFT JOIN {{ref('stg_lieux_accidents')}} as lieux
    ON sq4.Num_Acc = lieux.Num_Acc
)
-- Join avec la table usagers_accidents
SELECT
    sq3.Num_Acc
    ,sq3.cle
    ,sq3.date_date
    ,sq3.categorie_vehicule
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
    ,sq3.meteo
    ,CASE
        WHEN sq3.pluie_mm IS NULL THEN 0
        ELSE sq3.pluie_mm
        END AS pluie_mm
    ,sq3.situation
    ,sq3.intersection
    ,sq3.voie_reservee
    ,sq3.commune
    ,CASE
        WHEN usa.trajet IS NULL THEN "Non défini"
        ELSE usa.trajet
        END AS trajet
    ,sq3.latitude as Latitude
    ,sq3.longitude as Longitude
    ,CONCAT(sq3.latitude,",",sq3.longitude) as geo_coordinates
    ,CAST(sq3.commune_insee AS STRING) AS commune_insee
FROM sq3
LEFT JOIN {{ref('stg_usagers_accidents')}} as usa
ON sq3.cle = usa.cle
ORDER BY sq3.Num_Acc DESC





