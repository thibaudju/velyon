-- De la table aménagement, récupérer la longueur totale d'aménagements, le nombre de stationnements vélo par commune

WITH inter_tables AS(
SELECT
    commune
    ,ROUND(SUM(longueur),0) AS longueur_amenagement
    ,MAX(stat.capacite_statio_velos) AS capacite_totale_velos
    ,COUNT(commune) AS nb_amenagements_total
FROM {{ref("stg_amenagement")}}
LEFT JOIN {{ref("mart_nb_capstat_commune")}} AS stat USING(commune)
GROUP BY commune
),

-- On récupère les données sur le nombre d'habitants
-- On crée 2 KPI : la longueur d'aménagement/habitant et la capacité de stationnement vélos/habitant
-- On transforme les m d'aménagements en km
inter_tables2 AS (
SELECT
    commune
    ,ROUND(MAX(longueur_amenagement/1000),1) AS longueur_amenagement_km
    ,MAX(nb_amenagements_total) AS nb_amenagements_total
    ,MAX(inter_tables.capacite_totale_velos) AS capacite_totale_velos
    ,MAX(nb_habitants) AS total_habitants
    ,ROUND(SAFE_DIVIDE(MAX(capacite_totale_velos),MAX(nb_habitants)),3) AS stationnement_par_habitant
FROM inter_tables
LEFT JOIN {{ref("stg_population")}} AS pop USING(commune)
GROUP BY commune
),

inter_tables3 AS (
SELECT
    inter_tables2.*
    ,sup.surface_km2
FROM inter_tables2
LEFT JOIN {{ ref('stg_superficies') }} AS sup ON sup.nom = inter_tables2.commune
),

-- Join à nouveau avec la table population pour obtenir les données de géométrie dans le cadre de la visualisation
inter_tables4 AS (
SELECT
    inter_tables3.*
    ,pop.geometry
    ,ROUND(SAFE_DIVIDE(nb_habitants,surface_km2),1) AS densite_pop
FROM inter_tables3
LEFT JOIN {{ ref('stg_population') }} AS pop ON inter_tables3.commune = pop.commune
)

SELECT 
    inter_tables4.*
    --,ROUND(SAFE_DIVIDE(MAX(total_habitants),MAX(longueur_amenagement_km)),1) AS nb_habitant_long
    --,ROUND(SAFE_DIVIDE(MAX(longueur_amenagement_km),MAX(surface_km2)),3) AS infra_density
FROM inter_tables4
ORDER BY densite_pop DESC