{{ config(
    materialized='view',
    partition_by={
      "field": "start_datetime",
      "data_type": "DATETIME",
      "granularity": "year"
    }
)}}

SELECT 
channel_id,
counter_id,
CAST(REGEXP_REPLACE(start_datetime, r'\+.*', '') AS DATETIME FORMAT "YYYY-MM-DD HH24:MI:SS") AS start_datetime,
CAST(REGEXP_REPLACE(end_datetime, r'\+.*', '') AS DATETIME FORMAT "YYYY-MM-DD HH24:MI:SS") AS end_datetime,
count
FROM velyon-batch-1187.mesures_compteurs.all_mesures
WHERE count > 0
ORDER BY start_datetime