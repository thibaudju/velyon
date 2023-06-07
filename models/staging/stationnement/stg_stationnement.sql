{{ config(
    materialized='view'
)}}

SELECT 
    int64_field_0 AS id
    ,PARSE_DATE("%Y", CAST(anneerealisation AS STRING)) AS annee
    ,codeinsee AS insee
    ,* except (int64_field_0, abrite, pole,codeinsee)
    ,CASE
        WHEN pole IS NULL THEN "non défini"
        ELSE pole
        END
        AS pole
FROM velyon-batch-1187.stationnement.stationnement




