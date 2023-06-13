SELECT
    annee
    ,typeamenagement
    ,ROUND(SUM(longueur)/1000,1) AS km_amenagements
FROM {{ ref('stg_amenagement') }}
WHERE EXTRACT(YEAR FROM annee) > 2010
GROUP BY annee, typeamenagement
ORDER BY annee ASC
