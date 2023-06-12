WITH sq1 AS (
    SELECT
        EXTRACT(YEAR FROM annee) as annee
        ,commune
        ,SUM(longueur) as tot_long
FROM {{ref('stg_amenagement')}} 
)

SELECT
    commune
    ,t1.tot_long/t2.population as KM_par_hab
FROM sq1 AS t1
JOIN {{ref('int_commune_insee')}} AS t2 ON
t1.commune = t2.commune
GROUP BY t1.commune