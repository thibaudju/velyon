{{ config(
    materialized='view'
)}}


SELECT
-- Select only useful columns 
    channel_id,
    site_id,
    comment,
    provider_direction_code,
    time_step,
FROM velyon-batch-1187.mesures_compteurs.channel AS channels
-- filter on bike counters
WHERE mobility_type = "BIKE"
ORDER BY last_updated_at ASC