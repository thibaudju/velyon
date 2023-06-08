{{ config(
    materialized='view'
)}}

-- Fusion de tous les fichiers par année 
WITH pluvio_merged AS (
    SELECT *FROM {{ref('stg_pluvio_clean_2011')}} AS stg2011 
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2012')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2013')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2014')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2015')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2016')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2017')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2018')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2019')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2020')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2021')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2022')}}
    UNION ALL
    SELECT *FROM {{ref('stg_pluvio_clean_2023')}}
)
-- normalisation des noms de pluviomètres basés sur la table "pluviometre.liste_pluviometres"
SELECT
    CASE
        WHEN REGEXP_CONTAINS (pluviometre,"01") THEN "_01_VILLEURBANNE"
        WHEN REGEXP_CONTAINS (pluviometre,"02") THEN "_02_JONAGE"
        WHEN REGEXP_CONTAINS (pluviometre,"03") THEN "_03_ST_PRIEST|"
        WHEN REGEXP_CONTAINS (pluviometre,"04") THEN "_04_CREPIEUX"
        WHEN REGEXP_CONTAINS (pluviometre,"05") THEN "_05_BOLLIER"
        WHEN REGEXP_CONTAINS (pluviometre,"06") THEN "_06_ST_FONS"
        WHEN REGEXP_CONTAINS (pluviometre,"07") THEN "_07_NEUVILLE"
        WHEN REGEXP_CONTAINS (pluviometre,"08") THEN "_08_COUZON"
        WHEN REGEXP_CONTAINS (pluviometre,"09") THEN "_09_INSA"
        WHEN REGEXP_CONTAINS (pluviometre,"10") THEN "_10_GENAS"
        WHEN REGEXP_CONTAINS (pluviometre,"11") THEN "_11_CORBAS"
        WHEN REGEXP_CONTAINS (pluviometre,"12") THEN "_12_MIONS"
        WHEN REGEXP_CONTAINS (pluviometre,"13") THEN "_13_LYON_5_LOYASSE"
        WHEN REGEXP_CONTAINS (pluviometre,"14") THEN "_14_ST_GENIS_CHARLY"
        WHEN REGEXP_CONTAINS (pluviometre,"15") THEN "_15_ST_GENIS_PRESSIN"
        WHEN REGEXP_CONTAINS (pluviometre,"16") THEN "_16_LIMONEST"
        WHEN REGEXP_CONTAINS (pluviometre,"17") THEN "_17_POLEYMIEUX"
        WHEN REGEXP_CONTAINS (pluviometre,"18") THEN "_18_LA_TOUR_SALVAGNY"
        WHEN REGEXP_CONTAINS (pluviometre,"19") THEN "_19_COLLONGE"
        WHEN REGEXP_CONTAINS (pluviometre,"21") THEN "_21_SEREZIN"
        WHEN REGEXP_CONTAINS (pluviometre,"23") THEN "_23_ST_GERMAIN"
        WHEN REGEXP_CONTAINS (pluviometre,"24") THEN "_24_LYON_5_LES_BATTIERES"
        WHEN REGEXP_CONTAINS (pluviometre,"25") THEN "_25_BRON"
        WHEN REGEXP_CONTAINS (pluviometre,"26") THEN "_26_MONTANAY"
        WHEN REGEXP_CONTAINS (pluviometre,"27") THEN "_27_CHAMPAGNE_MONT_D_OR"
        WHEN REGEXP_CONTAINS (pluviometre,"28") THEN "_28_CAILLOUX"
        WHEN REGEXP_CONTAINS (pluviometre,"29") THEN "_29_RILLIEUX"
        WHEN REGEXP_CONTAINS (pluviometre,"30") THEN "_30_MEYZIEU"
        WHEN REGEXP_CONTAINS (pluviometre,"31") THEN "_31_ST_CONSORCE"
        WHEN REGEXP_CONTAINS (pluviometre,"32") THEN "_32_GIVORS"
        WHEN REGEXP_CONTAINS (pluviometre,"33") THEN "_33_INSA2"
        WHEN REGEXP_CONTAINS (pluviometre,"34") THEN "_34_JONAGE2"
        WHEN REGEXP_CONTAINS (pluviometre,"35") THEN "_35_SAINT_PRIEST2"
        WHEN REGEXP_CONTAINS (pluviometre,"36") THEN "_36_COUZON2"
        WHEN REGEXP_CONTAINS (pluviometre,"37") THEN "_37_QUINCIEUX"
        END
        AS pluviometre
    ,CAST(date AS DATE) AS date_date 
    ,qty_pluie  
FROM pluvio_merged
ORDER BY date ASC  