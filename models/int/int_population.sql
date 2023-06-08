-- On vient récupérer la population totale de l'agglomération lyonnaise (Grand Lyon) par an
{{ config(
    materialized='view'
)}}

SELECT 
   ,annee 
  SUM(nb_habitants) AS total_habitants
FROM {{ref("stg_population")}}
GROUP BY annee
ORDER BY annee