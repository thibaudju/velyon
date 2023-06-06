{{ config(
    materialized='view'
)}}

SELECT
    site_id,
    fr_insee_code,
    site_name,
    lon,
    lat

FROM velyon-batch-1187.mesures_compteurs.sites_comptage AS sites
