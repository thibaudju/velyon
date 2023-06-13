WITH sq1 AS (
    SELECT
        t1.commune
        ,t1.score_velo
        ,CASE
            WHEN t2.danger_score IS NULL THEN 0
            ELSE T2.danger_score
            END AS danger_score
    FROM {{ ref('mart_nb_am_stat_commune') }} t1
    LEFT JOIN {{ ref('mart_danger_score') }} t2 
    ON t1.commune = t2.commune
),

sq2 AS (
    SELECT
        *
        ,NTILE (10) OVER (ORDER BY score_velo) AS velo_rank
        ,NTILE (10) OVER (ORDER BY danger_score) AS danger_rank
    FROM sq1
),

sq3 AS (
    SELECT
        *
        ,(velo_rank*danger_rank) AS int_rank
    FROM sq2 
)

SELECT
    *
    ,NTILE (10) OVER (ORDER BY int_rank) AS indice_cyclable
FROM sq3
ORDER BY indice_cyclable ASC

