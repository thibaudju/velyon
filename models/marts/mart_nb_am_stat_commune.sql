-- De la table aménagement, récupérer la longueur totale d'aménagements, le nombre de stationnements vélo par commune
WITH sq1 AS(
SELECT
    commune
    ,ROUND((SUM(longueur)/1000),1) AS longueur_amenagement
    ,MAX(stat.capacite_statio_velos) AS capacite_tot_stationnement
    ,COUNT(commune) AS nb_amenagements_total
FROM {{ref("stg_amenagement")}}
LEFT JOIN {{ref("mart_nb_capstat_commune")}} AS stat USING(commune)
GROUP BY commune
),

sq2 AS (
    SELECT
        sq1.*
        ,pop.nb_habitants
        ,pop.geometry  
    FROM sq1
    LEFT JOIN {{ref("stg_population")}} AS pop USING(commune)
),

sq3 AS (
    SELECT
        sq2.*
        ,sup.surface_km2
        ,SUM(longueur_amenagement) OVER () AS tot_amenagement
    FROM sq2
    LEFT JOIN {{ ref('stg_superficies') }} AS sup ON sup.nom = sq2.commune
),

sq4 AS (
    SELECT
        sq3.* EXCEPT (tot_amenagement)
        ,ROUND(tot_amenagement,1) AS tot_amenagement
        ,ROUND((surface_km2/longueur_amenagement),2) AS densite_reseau
        ,ROUND((nb_habitants/longueur_amenagement),2) AS accessibilite_reseau
        ,ROUND((nb_habitants/capacite_tot_stationnement),2) AS accessibilite_sta
    FROM sq3
)

SELECT
    sq4.*
    ,ROUND((densite_reseau*accessibilite_reseau*accessibilite_sta),2) AS score_velo
FROM sq4
ORDER BY accessibilite_reseau DESC
