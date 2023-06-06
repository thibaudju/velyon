{{ config(
    materialized='view'
)}}


SELECT
    mesures.*,
    sites.lon,
    sites.lat,
    sites.comment
FROM {{ ref('stg_compteurs_all_mesures') }} AS mesures
JOIN {{ ref('int_merge_channels_sites') }} AS sites ON mesures.channel_id = sites.channel_id