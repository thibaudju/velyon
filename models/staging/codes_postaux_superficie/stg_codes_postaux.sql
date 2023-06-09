SELECT 
  code_postal AS CP
  ,code_commune_insee as insee
  ,nom_de_la_commune
  ,geometry
FROM   
   (SELECT *   
FROM `velyon-batch-1187.codes_postaux_insee.codes_postaux`) AS codes_postaux