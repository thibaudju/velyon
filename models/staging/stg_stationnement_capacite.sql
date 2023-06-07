-- Récupérer les données sur la capacite totale de stationnement par commune
{{ config(
    materialized='view'
)}}

SELECT
    commune
    ,codeinsee
    ,anneerealisation
    ,sum(capacite) AS capacite_statio_velos
FROM velyon-batch-1187.dbt_mchanut.stg_stationnement
GROUP BY commune,codeinsee,anneerealisation
ORDER BY commune,capacite_statio_velos DESC