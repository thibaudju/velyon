WITH cast_as AS (
  SELECT
SAFE_CAST (REPLACE(Latitude, ",",".") AS NUMERIC) AS lat,
SAFE_CAST (REPLACE(Longitude, ",",".") AS NUMERIC) AS long,
*
   FROM {{ ref('int_accidents') }}
)
,
modulo AS(
  SELECT
  mod(lat, 90) AS lat_clean,
  mod(long, 90) AS long_clean,
  *
  FROM cast_as
)

SELECT 
ST_GEOGPOINT(lat_clean,long_clean) AS geom,
*
FROM modulo
