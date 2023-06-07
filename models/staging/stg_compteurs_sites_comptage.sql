{{ config(
    materialized='view'
)}}

SELECT
    site_id,
    fr_insee_code,
    site_name,
    ylat / POWER(10, 16) AS latitude,
    xlong/ POWER(10,16) AS longitude
FROM velyon-batch-1187.mesures_compteurs.sites_comptage AS sites
