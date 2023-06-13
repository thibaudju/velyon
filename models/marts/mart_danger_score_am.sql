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
    FROM {{ ref('mart_geo_accidents_amenagements') }} t1
),

sq2 AS (
    SELECT
        sq1.typeamenagement
        ,COUNT(sq1.typeamenagement) AS nb_accidents
        ,ROUND(AVG(danger_score),2) AS danger_score
    FROM sq1
    GROUP BY typeamenagement
),

sq3 AS (
    SELECT
        sq2.*
        ,ROUND((t2.longueur_amenagement/1000),1) AS longueur
    FROM sq2
    LEFT JOIN {{ ref('mart_nb_typeam') }} t2
    ON sq2.typeamenagement = t2.typeamenagement
)

SELECT
    *
    ,ROUND((nb_accidents/longueur),2) AS acc_by_km
FROM sq3
ORDER BY danger_score DESC

