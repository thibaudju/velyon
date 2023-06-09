-- De la table stationnement, récupérer la capacité de stationnement vélos au global pour la métropole

SELECT
    sum(capacite) AS capacite_statio_velos
FROM {{ref("int_stationnement")}}