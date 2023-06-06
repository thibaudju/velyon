{{ config(
    materialized='view'
)}}

SELECT 
    int64_field_0 AS id,
    * EXCEPT (int64_field_0)
FROM velyon-batch-1187.stationnement.stationnement