-- Regrouper l'évolution de la population par année avec l'évolution du nombre d'aménagements cyclables et de stationnements vélos

{{ config(
    materialized='view'
)}}

-- Création d'un ID pour la table stg_amenagement (regroupement pour avoir le nombre d'aménagements par an et par commune)
WITH amenagement AS (
    SELECT
        commune
        ,insee
        ,annee
        ,CONCAT(insee,"-",annee) AS id_am
        ,COUNT(annee) AS nb_amenagements
    FROM {{ref('stg_amenagement')}}
GROUP BY commune,insee,annee
),

-- Création d'un ID pour la table stg_population
population AS (
    SELECT 
        annee
        ,nb_habitants
        ,commune
        ,insee
        ,CONCAT(insee,"-",annee) AS id_pop
    FROM {{ref('stg_population')}}
),


-- Création d'un ID pour la table stg_stationnement (regroupement pour avoir la capacité de vélos à stationner par an et par commune)
stationnement AS (
    SELECT
        commune
        ,insee
        ,sum(capacite) AS capacite_statio_velos
        ,CONCAT(insee,"-",annee) AS id_stat
    FROM {{ref("stg_stationnement")}}
GROUP BY commune,insee,annee
)

SELECT
    amenagement.*
    ,population.nb_habitants
    ,stationnement.capacite_statio_velos
FROM amenagement
-- On fait un left join pour garder les données d'aménagement mêmes supérieures à 2019 ()
LEFT JOIN population on id_am = id_pop
LEFT JOIN stationnement on id_am = id_stat
WHERE id_am <> ""
ORDER BY commune,capacite_statio_velos DESC