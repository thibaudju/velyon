-- On vient récupérer la population totale ainsi que la superficie en km2 de chaque commune de l'agglomération lyonnaise (Grand Lyon)
-- Rajouter un left join avec stg_codes_postaux

WITH communes AS (
SELECT 
   commune
   ,insee
   ,SUM(nb_habitants) AS total_habitants
FROM {{ref("stg_population")}}
GROUP BY commune,insee
ORDER BY commune
),

total_tables AS (
SELECT 
    communes.commune
    ,communes.insee
    ,codes.CP
    ,superficies.surface_km2
    ,codes.commune_CP
    FROM communes
LEFT JOIN {{ref("stg_superficies")}} AS superficies USING (insee)
FULL OUTER JOIN {{ref("stg_codes_postaux")}} AS codes USING (insee)
)

SELECT 
    CASE
        WHEN total_tables.commune IS NULL THEN total_tables.commune_CP
        ELSE total_tables.commune
        END
    AS commune
    ,total_tables.* EXCEPT (commune_CP,commune)
FROM total_tables
ORDER BY commune