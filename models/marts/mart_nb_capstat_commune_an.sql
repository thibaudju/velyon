-- De la table stationnement, récupérer le nombre de capacité vélos en plus par commune et par an

SELECT
    commune
    ,annee
    ,sum(capacite) AS capacite_statio_velos
FROM {{ref("stg_stationnement")}}
GROUP BY commune,annee
ORDER BY commune,capacite_statio_velos DESC