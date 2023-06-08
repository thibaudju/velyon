{{ config(
    materialized='view'
)}}

SELECT 
    int64_field_0 AS id
    ,PARSE_DATE("%Y", CAST(anneerealisation AS STRING)) AS annee
    ,codeinsee AS insee
    ,CONCAT(adresse,", ",commune,", ","FRANCE") AS adresse_complete
    ,* except (int64_field_0, abrite, pole,codeinsee,anneerealisation)
    ,CASE
        WHEN pole IS NULL THEN "non défini"
        WHEN pole = " " THEN "non défini"
        ELSE pole
        END
        AS pole
FROM velyon-batch-1187.stationnement.stationnement