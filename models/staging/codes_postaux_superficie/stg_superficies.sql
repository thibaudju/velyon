SELECT 
  nom
  ,nomreduit
  ,insee
  ,trigramme
  ,surface_km2
  ,datemaj
  ,gid
  ,geometry
FROM   
   (SELECT *   
FROM `velyon-batch-1187.superficies.superficies`)