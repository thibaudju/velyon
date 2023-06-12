-- De la table aménagement, récupérer la longueur totale d'aménagements, le nombre de stationnements vélo par commune

WITH inter_tables AS(
SELECT
    commune
    ,ROUND(SUM(longueur),0) AS longueur_amenagement
    ,MAX(stat.capacite_statio_velos) AS capacite_totale_velos
FROM {{ref("stg_amenagement")}}
LEFT JOIN {{ref("mart_nb_capstat_commune")}} AS stat USING(commune)
GROUP BY commune
)

-- On récupère les données sur le nombre d'habitants
-- On crée 2 KPI : la longueur d'aménagement/habitant et la capacité de stationnement vélos/habitant
SELECT
    commune,
    insee,
    geometry,
    MAX(longueur_amenagement) AS longueur_amenagement,
    MAX(inter_tables.capacite_totale_velos) AS capacite_totale_velos,
    MAX(nb_habitants) AS total_habitants,
    ROUND(SAFE_DIVIDE(MAX(longueur_amenagement),MAX(nb_habitants)),1) AS longueur_ame_par_habitant,
    ROUND(SAFE_DIVIDE(MAX(capacite_totale_velos),MAX(nb_habitants)),3) AS stationnement_par_habitant
FROM inter_tables
LEFT JOIN {{ref("stg_population")}} AS pop USING(commune)
GROUP BY commune,insee,geometry
ORDER BY longueur_ame_par_habitant DESC
