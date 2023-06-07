-- Récupérer les données d'aménagement par commune
{{ config(
    materialized='view'
)}}

SELECT 
    commune1
    ,insee1
    ,anneelivraison
    ,count(anneelivraison) AS nb_amenagements
FROM velyon-batch-1187.amenagement.amenagement
GROUP BY commune1,insee1,anneelivraison
ORDER BY commune1