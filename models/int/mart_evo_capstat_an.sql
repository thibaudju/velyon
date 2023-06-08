-- De la table stationnement, récupérer l'évolution de la capacité vélos par an au global pour la métropole

{{ config(
    materialized='view'
)}}

SELECT
    annee
    ,sum(capacite) AS capacite_statio_velos
FROM {{ref("stg_stationnement")}}
GROUP BY annee
ORDER BY capacite_statio_velos DESC