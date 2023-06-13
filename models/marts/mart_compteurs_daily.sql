SELECT
    DATE_TRUNC(start_hour, DAY) AS day,
    SUM(nb_passages) AS nb_passages,
    AVG (normalized_count) AS avg_normalized_count
FROM {{ ref('int_compteurs_mesures') }}
GROUP BY day