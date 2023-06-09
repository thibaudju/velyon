-- On vient récupérer la population totale de l'agglomération lyonnaise (Grand Lyon) par an
{{ config(
    materialized='view'
)}}

WITH communes AS(
SELECT 
   commune
   ,insee
   ,SUM(nb_habitants) AS total_habitants
FROM {{ref("stg_population")}}
GROUP BY commune,insee
ORDER BY commune
)

SELECT 
    communes.*
    ,superficies.surface_km2
FROM communes
LEFT JOIN {{ref("stg_superficies")}} AS superficies USING (insee)