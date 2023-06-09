-- De la table stationnement, récupérer la capacité de stationnement vélos au global pour la métropole

SELECT
    commune
    ,sum(capacite) AS capacite_statio_velos
FROM {{ref("int_stationnement")}}
GROUP BY commune
ORDER BY commune