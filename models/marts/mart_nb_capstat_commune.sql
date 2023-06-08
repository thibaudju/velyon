-- De la table stationnement, récupérer la capacité de stationnement vélos au global pour la métropole

{{ config(
    materialized='view'
)}}

SELECT
    commune
    ,sum(capacite) AS capacite_statio_velos
FROM {{ref("stg_stationnement")}}
GROUP BY commune
ORDER BY commune