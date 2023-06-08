-- De la table aménagement, récupérer le nombre de type d'aménagements et leur longueur en plus par commune (309 lignes)

{{ config(
    materialized='view'
)}}

SELECT
    commune
    ,insee
    ,typeamenagement
    ,COUNT(commune) AS nb_amenagements_par_type
    ,ROUND(SUM(longueur),0) AS longueur_amenagement
FROM {{ref("stg_amenagement")}}
GROUP BY commune,insee,typeamenagement
ORDER BY commune,nb_amenagements_par_type DESC