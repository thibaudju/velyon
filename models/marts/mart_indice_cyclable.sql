WITH sq1 AS (
    SELECT
        t1.commune
        ,t1.score_velo
        ,CASE
            WHEN t2.danger_score IS NULL THEN 0
            ELSE T2.danger_score
            END AS securite_score
        ,t1.geometry
    FROM {{ ref('mart_nb_am_stat_commune') }} t1
    LEFT JOIN {{ ref('mart_danger_score') }} t2 
    ON t1.commune = t2.commune
),

sq2 AS (
    SELECT
        sq1.*
        -- top_velos = 1 --> La meilleure en terme d'aménagements vélos
        ,RANK() OVER(ORDER BY score_velo ASC) AS top_velo
        -- top_danger = 1 --> La ville avec le danger score le plus haut (beaucoup d'accidents ou haut niveau de gravité)
        ,RANK() OVER(ORDER BY securite_score ASC) AS top_securite
    FROM sq1
),

sq3 AS (
    SELECT
        *
        -- Score cyclable:  Mix entre le danger score et le score velo (communes réparties en 10 groupes)
        ,(top_velo+top_securite) AS score_cyclable
    FROM sq2 
)

SELECT
    *
    ,RANK() OVER(ORDER BY score_cyclable ASC) AS global_rank
    -- Score de 1 à 10 pour la viz carto basé sur le classement des score_cyclable
    ,NTILE (10) OVER (ORDER BY score_cyclable) AS indice_cyclable
FROM sq3
ORDER BY global_rank ASC