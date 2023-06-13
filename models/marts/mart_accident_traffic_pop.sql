WITH requete_1 AS (
    SELECT 
        year,
        round(index_trafic,2) as index_trafic
    FROM
        `velyon-batch-1187.dbt_prod.mart_compteurs_index_trafic_annuel`
),
requete_2 AS (
    SELECT
        year,
        SUM(nb_habitants) AS total_habitants,
        max(requete_1.index_trafic) as index_trafic
    FROM
        requete_1
    LEFT JOIN
        velyon-batch-1187.dbt_prod.stg_population AS pop ON EXTRACT(YEAR FROM (CAST(pop.annee AS DATE))) = requete_1.year
    GROUP BY
        requete_1.year
),
requete_3 AS (

    SELECT
      year,
      max(requete_2.total_habitants) as total_habitants,
      max(requete_2.index_trafic) as index_trafic,
      sum(capacite_statio_velos) as capacite_statio_velo
    FROM requete_2
    LEFT JOIN velyon-batch-1187.dbt_prod.mart_nb_capstat_an t1 ON EXTRACT(YEAR FROM t1.annee)=requete_2.year
    GROUP BY year
),
requete_4 AS(

SELECT 
      year,
      count(Num_acc) as total_accidents,
      max(requete_3.total_habitants) as total_habitants,
      max(requete_3.index_trafic) as index_trafic,
      max(requete_3.capacite_statio_velo) as capacite_statio_velo

FROM requete_3
LEFT JOIN `velyon-batch-1187.dbt_prod.int_accidents`  t2 ON EXTRACT(YEAR FROM t2.date_date)=requete_3.year
GROUP BY year
)

SELECT 
requete_4.*

FROM requete_4

ORDER BY year DESC
