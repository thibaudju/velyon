{{ config(
    materialized='view'
)}}

-- Cleaning de la table aménagement

SELECT
    int64_field_0 AS id
    ,PARSE_DATE("%Y", CAST(anneelivraison AS STRING)) AS annee
    ,CONCAT(nom,", ",commune1,", ","Rhône",", ","FRANCE") AS adresse_complete
    ,nom
    -- Pour une seule commune1 nulle (avec juste une commune2)
    ,CASE 
        WHEN commune1 IS NULL THEN commune2
        ELSE commune1
        END
        AS commune
    -- Pour une seule insee1 nulle (avec juste insee2)
    ,CASE
        WHEN insee1 IS NULL THEN insee2
        ELSE insee1
        END
    AS insee
    ,commune2
    ,insee2
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
    ,* EXCEPT (int64_field_0,zonecirculationapaisee,financementac,commune1,insee1,nom,reseau,localisation,commune2,insee2,anneelivraison)
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