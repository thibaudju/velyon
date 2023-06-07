-- Récupérer les données sur le type de mobilier de stationnement par commune
{{ config(
    materialized='view'
)}}

SELECT
    commune
    ,insee
    ,mobiliervelo
    ,count(commune) AS nb_mobilier
FROM {{ref("stg_stationnement")}}
GROUP BY commune,insee,mobiliervelo
ORDER BY commune,nb_mobilier DESC