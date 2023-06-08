-- De la table aménagement, récupérer l'évolution des types d'aménagements par année et par commune

{{ config(
    materialized='view'
)}}

SELECT
    commune
    ,insee
    ,annee
    ,typeamenagement
    ,count(commune) AS nb_amenagements_par_type
FROM {{ref("stg_amenagement")}}
GROUP BY commune,insee,annee,typeamenagement
ORDER BY commune,nb_amenagements_par_type DESC