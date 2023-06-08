-- De la table stationnement, récupérer la capacité de stationnement vélos au global pour la métropole

{{ config(
    materialized='view'
)}}

SELECT
    sum(capacite) AS capacite_statio_velos
FROM {{ref("stg_stationnement")}}