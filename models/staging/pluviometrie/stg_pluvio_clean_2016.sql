{{ config(
    materialized='view'
)}}

SELECT
-- PK --        
  pluviometre
-- PK --
  ,date
-- diviser par 100 pour avoir la donnée en millimètres 
  ,(qty_pluie / 100) as qty_pluie
FROM   
   (SELECT Date
    ,_01_VILLEURBANNE
    ,_02_JONAGE
    ,_03_SAINT_PRIEST
    ,_04_CREPIEUX
    ,_05_BOLLIER
    ,_06_ST_FONS
    ,_07_NEUVILLE
    ,_08_COUZON
    ,_09_INSA
    ,_10_GENAS
    ,_11_CORBAS
    ,_12_MIONS
    ,_13_LYON_5_LOYASSE
    ,_14_CHARLY
    ,_15_ST_GENIS_PRESSIN
    ,_16_LIMONEST
    ,_17_POLEYMIEUX
    ,_18_LA_TOUR_SALVAGNY
    ,_19_COLLONGES_MONT_D_OR
    ,_21_SEREZIN
    ,_23_ST_GERMAIN
    ,_24_LYON_5_LES_BATTIERES
    ,_25_BRON_METEO
    ,_26_MONTANAY
    ,_27_CHAMPAGNE_MONT_D_OR
    ,_28_CAILLOUX
    ,_29_RILLIEUX
    ,_30_MEYZIEU
    ,_31_ST_CONSORCE
    ,_32_GIVORS   
FROM pluviometrie.pluvio_2016) AS p  
UNPIVOT  
   (qty_pluie FOR pluviometre IN   
      (_01_VILLEURBANNE
      ,_02_JONAGE
      ,_03_SAINT_PRIEST
      , _04_CREPIEUX
      ,_05_BOLLIER
      ,_06_ST_FONS
      ,_07_NEUVILLE
      ,_08_COUZON
      ,_09_INSA
      ,_10_GENAS
      ,_11_CORBAS
      ,_12_MIONS
      ,_13_LYON_5_LOYASSE
      ,_14_CHARLY
      ,_15_ST_GENIS_PRESSIN
      ,_16_LIMONEST
      ,_17_POLEYMIEUX
      ,_18_LA_TOUR_SALVAGNY
      ,_19_COLLONGES_MONT_D_OR
      ,_21_SEREZIN
      ,_23_ST_GERMAIN
      ,_24_LYON_5_LES_BATTIERES
      ,_25_BRON_METEO
      ,_26_MONTANAY
      ,_27_CHAMPAGNE_MONT_D_OR
      ,_28_CAILLOUX
      ,_29_RILLIEUX
      ,_30_MEYZIEU
      ,_31_ST_CONSORCE
      ,_32_GIVORS)  
)AS unpvt
ORDER BY date