-- De la table aménagement, récupérer le nombre de type d'aménagements au global pour la métropole (avec la longueur moyenne par aménagement)

WITH amenagement_table AS (
    SELECT
        typeamenagement
        ,COUNT(typeamenagement) AS nb_amenagements_total
        ,ROUND(SUM(longueur),0) AS longueur_amenagement
    FROM {{ref("stg_amenagement")}}
    GROUP BY typeamenagement
    ORDER BY nb_amenagements_total DESC
)

-- Récupérer la longueur moyenne d'un aménagement
SELECT
    *
    ,ROUND(SAFE_DIVIDE(longueur_amenagement,nb_amenagements_total),0) AS longueur_moyenne_amenagement
FROM amenagement_table