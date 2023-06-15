-- On vient récupérer la population totale ainsi que la superficie en km2 de chaque
-- commune de l'agglomération lyonnaise (Grand Lyon)
-- Rajouter un left join avec stg_codes_postaux
with
    communes as (
        select distinct commune, insee, sum(nb_habitants) as total_habitants
        from {{ ref("stg_population") }}
        group by commune, insee
        order by commune
    ),

    total_tables as (
        select distinct
            communes.commune,
            codes.CP,
            superficies.surface_km2,
            codes.commune_CP,
            CAST(codes.insee as string) as insee
        from communes
        left join {{ ref("stg_superficies") }} as superficies using (insee)
        full outer join {{ ref("stg_codes_postaux") }} as codes using (insee)
    )

select
    case
        when total_tables.commune is null
        then total_tables.commune_CP
        else total_tables.commune
    end as commune,
    total_tables.* except (commune_CP, commune)
from total_tables
order by commune
