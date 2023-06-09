-- On remplace les années vides par 1998 où la validité est différente de "en projet" (car là, les stationnements ne sont pas encore construits)

{{ config(
    materialized='view'
)}}

SELECT
    * EXCEPT (annee)
    ,CASE
        WHEN annee IS NULL THEN "1998-01-01"
        ELSE annee
        END
        AS annee
FROM {{ref("stg_stationnement")}}
WHERE validite <> "En projet ou en cours de validation"