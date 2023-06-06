{{ config(
    materialized='view'
)}}

SELECT 
    int64_field_0 AS id
    ,* except (int64_field_0, abrite, pole)
    ,CASE
        WHEN pole IS NULL THEN "non défini"
        ELSE pole
        END
        AS pole
FROM velyon-batch-1187.stationnement.stationnement




