{{ config(
    materialized='view'
)}}

SELECT 
    *
FROM velyon-batch-1187.stationnement.stationnement