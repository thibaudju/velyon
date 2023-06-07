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
    ,_03_St_Priest
    ,_04_Cr__pieux
    ,_05_Bollier__lyon7_
    ,_06_St_Fons
    ,_07_Neuville
    ,_08_Couzon
    ,_09_Insa_Doua
    ,_10_Genas
    ,_11_Corbas
    ,_12_Mions
    ,_13_Loyasse__lyon5_
    ,_14_Charly__St_Genis_
    ,_15_Pressin__StGenis_
    ,_16_Limonest
    ,_17_Poleymieux
    ,_18_Salvagny
    ,_19_Collonge
    ,_21_S__r__zin
    ,_23_St_Germain
    ,_24_Batti__re__lyon5_
    ,_25_Bron
    ,_26_Montanay
    ,_27_Champagne
    ,_28_Cailloux
    ,_29_Rilleux
    ,_30_Meyzieu
    ,_31_St_Consorce
    ,_32_Givors   
FROM pluviometrie.pluvio_2012) AS p  
UNPIVOT  
   (qty_pluie FOR pluviometre IN   
      (_01_Villeurbanne
      ,_02_Jonage
      ,_03_St_Priest
      ,_04_Cr__pieux
      ,_05_Bollier__lyon7_
      ,_06_St_Fons
      ,_07_Neuville
      ,_08_Couzon
      ,_09_Insa_Doua
      ,_10_Genas
      ,_11_Corbas
      ,_12_Mions
      ,_13_Loyasse__lyon5_
      ,_14_Charly__St_Genis_
      ,_15_Pressin__StGenis_
      ,_16_Limonest
      ,_17_Poleymieux
      ,_18_Salvagny
      ,_19_Collonge
      ,_21_S__r__zin
      ,_23_St_Germain
      ,_24_Batti__re__lyon5_
      ,_25_Bron
      ,_26_Montanay
      ,_27_Champagne
      ,_28_Cailloux
      ,_29_Rilleux
      ,_30_Meyzieu
      ,_31_St_Consorce
      ,_32_Givors
    )  
)AS unpvt
ORDER BY date