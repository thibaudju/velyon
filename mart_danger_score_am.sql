WITH sq1 AS (
    SELECT
        typeamenagement
        ,CASE 
                WHEN gravite_blessure = 'Non défini' THEN 1
                WHEN gravite_blessure = 'Indemne' THEN 2
                WHEN gravite_blessure = 'Blessé léger' THEN 4
                WHEN gravite_blessure = 'Blessé hospitalisé' THEN 6
                WHEN gravite_blessure = 'Tué' THEN 10
                END AS danger_score
    FROM {{ ref('mart_geo_accidents_amenagements') }}
)

SELECT
    typeamenagement
    ,COUNT(typeamenagement) AS nb_accidents
    ,ROUND(AVG(danger_score),2) as danger_score
FROM sq1
GROUP BY typeamenagement
ORDER BY danger_score DESC

