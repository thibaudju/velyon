{{ config(
    materialized='view'
)}}

SELECT
    int64_field_0 AS id 
    ,nom
    ,commune2
    ,insee2
    -- Pour une seule commune1 nulle (avec juste une commune2)
    ,CASE 
        WHEN commune1 IS NULL THEN commune2
        ELSE commune1
        END
    AS commune1
    -- Pour une seule insee1 nulle (avec juste insee2)
    ,CASE
        WHEN insee1 IS NULL THEN insee2
        ELSE insee1
        END
    AS insee1
    -- Réseau (valeurs nulles)
    ,CASE
        WHEN reseau IS NULL THEN "Non défini"
        ELSE reseau
        END
    AS reseau
     -- Localisation (valeurs nulles)
    ,CASE
        WHEN localisation IS NULL THEN "Non défini"
        ELSE localisation
        END
    AS localisation
    ,* EXCEPT (int64_field_0,zonecirculationapaisee,financementac,commune1,insee1,nom,reseau,localisation,commune2,insee2)
      -- Financement (valeurs nulles)
    ,CASE
        WHEN financementac IS NULL THEN "Non défini"
        ELSE financementac
        END
    AS financement
      -- Zone circulation apaisée (valeurs nulles)
    ,CASE
        WHEN zonecirculationapaisee IS NULL THEN "Non défini"
        ELSE zonecirculationapaisee
        END
    AS zonecirculationapaisee
FROM velyon-batch-1187.amenagement.amenagement