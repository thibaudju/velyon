-- De la table aménagement, récupérer l'évolution des types d'aménagements par année et par commune

SELECT
    commune
    ,annee
    ,typeamenagement
    ,COUNT(commune) AS nb_amenagements_par_type
    ,ROUND(SUM(longueur),0) AS longueur_amenagement
FROM {{ref("stg_amenagement")}}
GROUP BY commune,annee,typeamenagement
ORDER BY commune,nb_amenagements_par_type DESC