-- De la table aménagement, récupérer le nombre de type d'aménagements en plus par an au global pour la métropole

{{ config(
    materialized='view'
)}}

SELECT
    typeamenagement
    ,annee
    ,COUNT(typeamenagement) AS nb_amenagements_par_type
    ,ROUND(SUM(longueur),0) AS longueur_amenagement
FROM {{ref("stg_amenagement")}}
GROUP BY typeamenagement,annee
ORDER BY nb_amenagements_par_type DESC