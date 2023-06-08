{{ config(
    materialized='view'
)}}

SELECT
    --EXTRACT(year from date) as year
    --,EXTRACT(month from date) as month
    --,EXTRACT(day from date) as day
    date_date
    ,ROUND((SUM(qty_pluie) / COUNT (DISTINCT pluviometre)),2) as pluie_mm
FROM {{ref('stg_pluvio_merged')}}

-- Filtre sur les pluviomètres situés en métropole de lyon. Voir pdf dispo sur le site du grand lyon (dans le zip): 
-- https://data.grandlyon.com/jeux-de-donnees/pluviometrie-2021-metropole-lyon/telechargements

WHERE pluviometre = "_01_VILLEURBANNE" OR 
  pluviometre = "_05_BOLLIER" OR
  pluviometre = "_09_INSA" OR
  pluviometre = "_33_INSA2" OR
  pluviometre = "_13_LYON_5_LOYASSE" OR
  pluviometre = "_24_LYON_5_LES_BATTIERES" OR
  pluviometre = "_25_BRON" OR
  pluviometre = "_27_CHAMPAGNE_MONT_D_OR"
GROUP BY date_date
ORDER BY date_date ASC

