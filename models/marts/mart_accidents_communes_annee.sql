SELECT
    EXTRACT(YEAR from date_date) as annee,
    commune,
    count(Num_Acc) as nb_accident
FROM {{ref('int_accidents')}} 
GROUP BY annee, commune
order