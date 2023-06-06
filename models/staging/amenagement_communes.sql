-- Récupérer les données d'aménagement par commune
{{ config(
    materialized='view'
)}}

WITH population AS (
    SELECT
)

SELECT 
    commune1
    ,anneelivraison
    ,count(anneelivraison) AS nb_amenagement
FROM velyon-batch-1187.amenagement.amenagement
GROUP BY commune1,anneelivraison
ORDER BY commune1,anneelivraison