-- De la table aménagement, récupérer le nombre de type d'aménagements par commune (309 lignes)

{{ config(
    materialized='view'
)}}

SELECT
    commune
    ,insee
    ,typeamenagement
    ,count(commune) AS nb_amenagements_par_type
FROM {{ref("stg_amenagement")}}
GROUP BY commune,insee,typeamenagement
ORDER BY commune,nb_amenagements_par_type DESC