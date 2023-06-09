-- De la table stationnement, récupérer le nombre de capacité vélos en plus par an au global pour la métropole

SELECT
    annee
    ,sum(capacite) AS capacite_statio_velos
FROM {{ref("int_stationnement")}}
GROUP BY annee
ORDER BY capacite_statio_velos DESC