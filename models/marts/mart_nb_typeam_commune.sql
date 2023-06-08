-- De la table aménagement, récupérer le nombre de type d'aménagements et leur longueur en plus par commune (309 lignes)

SELECT
    commune
    ,typeamenagement
    ,COUNT(commune) AS nb_amenagements_par_type
    ,ROUND(SUM(longueur),0) AS longueur_amenagement
FROM {{ref("stg_amenagement")}}
GROUP BY commune,typeamenagement
ORDER BY commune,nb_amenagements_par_type DESC