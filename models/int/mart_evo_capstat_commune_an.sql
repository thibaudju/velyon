-- De la table stationnement, récupérer l'évolution de la capacité vélos par commune et par an

{{ config(
    materialized='view'
)}}

SELECT
    commune
    ,annee
    ,sum(capacite) AS capacite_statio_velos
FROM {{ref("stg_stationnement")}}
GROUP BY commune,annee
ORDER BY commune,capacite_statio_velos DESC