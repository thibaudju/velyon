with
    cast_as as (
        select
            safe_cast(replace(latitude, ",", ".") as numeric) as lat,
            safe_cast(replace(longitude, ",", ".") as numeric) as long,
            *
        from {{ ref("int_accidents") }}
    ),
    modulo as (
        select mod(lat, 90) as lat_clean, mod(long, 180) as long_clean, * from cast_as
    ),

    geogpoint as (select st_geogpoint(long_clean, lat_clean) as geom, * from modulo),

    buffer as (select *, st_buffer(geom, 15) as accidents_buffer from geogpoint)

select
    buffer.*,
    extract(year from buffer.date_date) as year_accident,
    CASE
        WHEN amenagements.typeamenagement IS NULL THEN "Aucun Aménagement"
        WHEN amenagements.typeamenagement IS NOT NULL THEN amenagements.typeamenagement
    END AS typeamenagement
from buffer
left join
    velyon-batch-1187.amenagement.pvo_patrimoine_voirie as amenagements
     ON ST_INTERSECTS(ST_BOUNDARY(buffer.accidents_buffer), amenagements.geom)
        AND extract(year from buffer.date_date) >=amenagements.anneelivraison
 