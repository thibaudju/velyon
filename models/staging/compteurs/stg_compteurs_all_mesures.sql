{{ config(
    materialized='view',
    partition_by={
      "field": "start_datetime",
      "data_type": "DATETIME",
      "granularity": "year"
    }
)}}

WITH dates_clean AS (
SELECT 
mesures.channel_id,
mesures.counter_id,
CAST(REGEXP_REPLACE(start_datetime, r'\+.*', '') AS DATETIME FORMAT "YYYY-MM-DD HH24:MI:SS") AS start_datetime,
CAST(REGEXP_REPLACE(end_datetime, r'\+.*', '') AS DATETIME FORMAT "YYYY-MM-DD HH24:MI:SS") AS end_datetime,
count
FROM velyon-batch-1187.mesures_compteurs.all_mesures AS mesures
WHERE count > 0 AND start_datetime >= "2011-01-01"

ORDER BY start_datetime
)

SELECT
    dates_clean.channel_id,
    dates_clean.counter_id,
    -- normalize time step to 1h and group by to obtain sum of counter
    DATETIME_TRUNC(start_datetime, HOUR) AS start_hour,
    SUM(COUNT) as nb_passages
FROM dates_clean

-- join with stg_compteurs_channel to remove channels that are not BIKE
JOIN {{ ref('stg_compteurs_channels') }} AS channels ON dates_clean.channel_id = channels.channel_id
WHERE dates_clean.channel_id IN (channels.channel_id)
GROUP BY channel_id, counter_id, start_hour
