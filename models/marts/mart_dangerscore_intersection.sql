WITH sq1 AS (
    SELECT
        intersection
        ,CASE 
            WHEN gravite_blessure = 'Non défini' THEN 1
            WHEN gravite_blessure = 'Indemne' THEN 2
            WHEN gravite_blessure = 'Blessé léger' THEN 4
            WHEN gravite_blessure = 'Blessé hospitalisé' THEN 8
            WHEN gravite_blessure = 'Non défini' THEN 16
            END AS danger_score
    FROM {{ref('int_accidents')}}
)

SELECT
    intersection
    ,ROUND(AVG(danger_score),2) AS danger_score
    ,COUNT(danger_score) as nb_accidents
FROM sq1
GROUP BY intersection
ORDER BY danger_score DESC

