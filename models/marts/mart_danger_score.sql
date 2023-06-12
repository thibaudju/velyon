-- JOIN avec la table population pour obtenir le nom de la commune et sa population

WITH sq1 AS (
    SELECT
        t1.commune_insee 
        ,t2.commune
        ,t1.Num_Acc
        -- Attribution d'un score en fonction de la gravité de l'accident
        ,CASE 
            WHEN gravite_blessure = 'Non défini' THEN 1
            WHEN gravite_blessure = 'Indemne' THEN 2
            WHEN gravite_blessure = 'Blessé léger' THEN 4
            WHEN gravite_blessure = 'Blessé hospitalisé' THEN 6
            WHEN gravite_blessure = 'Tué' THEN 10
            END AS danger_score
        ,t2.nb_habitants AS population
        ,t2.geometry
FROM {{ref('int_accidents')}} t1
JOIN {{ref('stg_population')}} t2
ON CAST(t1.commune_insee AS STRING) = CAST(t2.insee AS STRING)
),

--Aggrégation des données
sq2 AS (
    SELECT
        commune
        ,COUNT(Num_Acc) AS nb_accidents
        ,ROUND(AVG(population),0) AS population
        ,ROUND(AVG(danger_score),2) AS danger_score
    FROM sq1
    GROUP BY commune
),

sq3 AS (
    SELECT
    *
    --ratio calculé en * 100 afin d'illustrer un peu plus les tendances 
    ,ROUND((nb_accidents/population),3) AS ratio_acc
FROM sq2
)

--Join avec la table population pour obtenir les données géométriques de chaque commune dans le but d'une viz
SELECT
    sq3.*
    ,ROUND((danger_score*1+ratio_acc),2) as danger_score_global
    ,pop.geometry
FROM sq3
LEFT JOIN {{ ref('stg_population') }} AS pop ON sq3.commune = pop.commune
ORDER BY danger_score_global DESC

