-- On récupère les codes postaux de toute la France puis on filtre sur le département du 69

SELECT 
  code_postal AS CP
  ,CAST(code_commune_insee AS INT64) as insee
  ,nom_de_la_commune AS commune_CP
  ,geometry
FROM   
   (SELECT *   
FROM `velyon-batch-1187.codes_postaux_insee.codes_postaux`) AS codes_postaux
WHERE code_commune_insee LIKE "69%"