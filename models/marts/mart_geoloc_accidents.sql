SELECT
    Num_Acc
    ,geo_coordinates
    ,sexe
    ,gravite_blessure
    ,voie_reservee
    ,situation
FROM {{ref('int_accidents')}}