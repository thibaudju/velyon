-- Récupérer les données sur le type d'aménagement par commune
{{ config(
    materialized='view'
)}}

SELECT
    commune1
    ,insee1
    ,typeamenagement
    ,count(commune1) AS nb_amenagements_par_type
FROM velyon-batch-1187.amenagement.amenagement
GROUP BY commune1,insee1,typeamenagement
ORDER BY commune1,nb_amenagements_par_type DESC