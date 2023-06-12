SELECT 
  nom
  ,nomreduit
  ,CAST(insee AS STRING) AS insee
  ,trigramme
  ,surface_km2
  ,datemaj
  ,gid
  ,geometry
FROM   
   (SELECT *   
FROM `velyon-batch-1187.superficies.superficies`)
WHERE nom <> ""
ORDER BY nom