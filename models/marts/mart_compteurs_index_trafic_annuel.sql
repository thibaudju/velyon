WITH yearly_norm_trafic AS (
SELECT 
    EXTRACT (YEAR FROM start_hour) AS year,
    AVG(normalized_count) as trafic
FROM {{ ref('int_compteurs_mesures') }}
GROUP BY year
ORDER BY year
)

SELECT
    year,
    trafic / MIN (trafic) OVER () AS index_trafic,
    trafic / (LAG (trafic, 1) OVER(ORDER BY year ASC)) -1 AS evo_yoy
FROM yearly_norm_trafic
ORDER BY year ASC