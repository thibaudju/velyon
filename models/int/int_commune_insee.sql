-- On vient récupérer la population totale ainsi que la superficie en km2 de chaque commune de l'agglomération lyonnaise (Grand Lyon)

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
ORDER BY commune