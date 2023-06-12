SELECT
    Num_Acc
    ,date_date
    ,heure_minute
    ,lumiere
    ,departement
    ,CAST(commune_insee AS STRING) as commune_insee
    ,agglomeration
    ,intersection
    ,meteo
    ,collision
    ,adresse
    ,Latitude
    ,Longitude
FROM {{ref('stg_caracteristiques_accidents')}}
WHERE DATE(date_date) > '2018-12-31'
