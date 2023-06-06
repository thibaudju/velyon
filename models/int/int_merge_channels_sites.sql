{{ config(
    materialized='view'
)}}



SELECT
    mesures.*,
    sites.lon,
    sites.lat
FROM {{ ref('stg_compteurs_channels') }} AS mesures
JOIN {{ ref('stg_compteurs_sites_comptage') }} AS sites ON mesures.site_id = sites.site_id