-- On remplace les années vides par 1998 où la validité est différente de "en projet" (car là, les stationnements ne sont pas encore construits)
-- Pour les années vides où la validité est "en projet" alors on met 2024 (année future, on suppose qu'ils seront bien réalisés)

{{ config(
    materialized='view'
)}}

SELECT
    * EXCEPT (annee)
    ,CASE
        WHEN (annee IS NULL AND validite <> "En projet ou en cours de validation") THEN "1998-01-01"
        WHEN (annee IS NULL AND validite = "En projet ou en cours de validation") THEN "2024-01-01"
        ELSE annee
        END
        AS annee
FROM {{ref("stg_stationnement")}}