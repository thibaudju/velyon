{{ config(
    materialized='view'
)}}


SELECT
    mesures.*,
    sites.lon,
    sites.lat,