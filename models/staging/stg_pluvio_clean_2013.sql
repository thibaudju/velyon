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
   (SELECT
    Date
    ,_01_Villeurbanne
    ,_02_Jonage
    ,_03_saint_priest
    ,_04_crepieux
    ,_05_bollier
    ,_06_St_Fons
    ,_07_Neuville
    ,_08_Couzon
    ,_09_insa
    ,_10_Genas
    ,_11_Corbas
    ,_12_Mions
    ,_13_lyon_5_loyasse
    ,_14_charly
    ,_15_st_genis_pressin
    ,_16_Limonest
    ,_17_Poleymieux
    ,_18_la_tour_salvagny
    ,_19_collonges_mont_d_or
    ,_21_serezin
    ,_23_St_Germain
    ,_24_lyon_5_les_battieres
    ,_25_bron_meteo
    ,_26_Montanay
    ,_27_champagne_mont_d_or
    ,_28_Cailloux
    ,_29_rillieux
    ,_30_Meyzieu
    ,_31_St_Consorce
    ,_32_Givors   
FROM pluviometrie.pluvio_2013) AS p  
UNPIVOT  
   (qty_pluie FOR pluviometre IN   
      (_01_Villeurbanne
      ,_02_Jonage
      ,_03_saint_priest
      ,_04_crepieux
      ,_05_bollier
      ,_06_St_Fons
      ,_07_Neuville
      ,_08_Couzon
      ,_09_insa
      ,_10_Genas
      ,_11_Corbas
      ,_12_Mions
      ,_13_lyon_5_loyasse
      ,_14_charly
      ,_15_st_genis_pressin
      ,_16_Limonest
      ,_17_Poleymieux
      ,_18_la_tour_salvagny
      ,_19_collonges_mont_d_or
      ,_21_serezin
      ,_23_St_Germain
      ,_24_lyon_5_les_battieres
      ,_25_bron_meteo
      ,_26_Montanay
      ,_27_champagne_mont_d_or
      ,_28_Cailloux
      ,_29_rillieux
      ,_30_Meyzieu
      ,_31_St_Consorce
      ,_32_Givors
    )  
)AS unpvt
ORDER BY date