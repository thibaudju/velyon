WITH accidents_annuels AS (
SELECT
    EXTRACT (YEAR FROM date_date) AS year,
    COUNT(categorie_vehicule) AS nb_accidents_velo,

FROM {{ ref('int_accidents') }}
GROUP BY year
ORDER BY year
)

SELECT 
accidents_annuels.*,
trafic.trafic_annuel,
trafic.index_trafic
FROM accidents_annuels
LEFT JOIN {{ ref('mart_compteurs_index_trafic_annuel') }} AS trafic ON accidents_annuels.year = trafic.year
ORDER BY accidents_annuels.year