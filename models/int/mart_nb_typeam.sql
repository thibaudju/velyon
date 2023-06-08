-- De la table aménagement, récupérer le nombre de type d'aménagements au global pour la métropole

{{ config(
    materialized='view'
)}}

SELECT
    typeamenagement
    ,count(typeamenagement) AS nb_amenagements_par_type
FROM {{ref("stg_amenagement")}}
GROUP BY typeamenagement
ORDER BY nb_amenagements_par_type DESC