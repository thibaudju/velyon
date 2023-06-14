SELECT
    Num_Acc
    ,date_date
    ,heure_minute
    ,lumiere
    ,departement
    ,CASE
        WHEN LENGTH(CAST(commune_insee AS STRING)) = 3 THEN CONCAT("69",commune_insee)
        WHEN LENGTH(CAST(commune_insee AS STRING)) = 2 THEN CONCAT("690",commune_insee)
        WHEN LENGTH(CAST(commune_insee AS STRING)) = 1 THEN CONCAT("6900",commune_insee)
        ELSE CAST(commune_insee AS STRING)
        END AS commune_insee
    ,agglomeration
    ,intersection
    ,meteo
    ,collision
    ,adresse
    ,CONCAT(
        LEFT(Latitude, 2),
        '.',
        REPLACE(SUBSTRING(Latitude, 3), '.', '')
    ) AS Latitude
    ,CONCAT(
        LEFT(Longitude, 1),
        '.',
        REPLACE(SUBSTRING(Longitude, 2), '.', '')
    ) AS Longitude
FROM {{ref('stg_caracteristiques_accidents')}}
WHERE DATE(date_date) < '2019-01-01'
