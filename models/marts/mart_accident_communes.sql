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
            WHEN gravite_blessure = 'Blessé hospitalisé' THEN 8
            WHEN gravite_blessure = 'Non défini' THEN 16
            END AS danger_score
        ,t2.nb_habitants AS population
FROM {{ref('int_accidents')}} t1
JOIN velyon-batch-1187.dbt_cbatardiere.stg_population t2
ON t1.commune_insee = t2.insee 
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
    ,ROUND((nb_accidents/population*100),5) AS ratio_acc
FROM sq2 t1
)

--Join avec la table population pour obtenir les données géométriques de chaque commune dans le but d'une viz
SELECT
    sq3.*
    ,ROUND((danger_score*(1+ratio_acc)),2) as score_velo
    ,geometry
FROM sq3
LEFT JOIN velyon-batch-1187.dbt_cbatardiere.stg_population t2
ON sq3.commune = t2.commune
ORDER BY score_velo DESC

