-- Récupérer les données sur le type de mobilier de stationnement par commune
{{ config(
    materialized='view'
)}}

SELECT
    commune
    ,codeinsee
    ,mobiliervelo
    ,count(commune) AS nb_mobilier
FROM velyon-batch-1187.dbt_mchanut.stg_stationnement
GROUP BY commune,codeinsee,mobiliervelo
ORDER BY commune,nb_mobilier DESC