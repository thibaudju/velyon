{{ config(
    materialized='view'
)}}

SELECT 
  nb_habitants
  -- Pour retirer le "pop" devant les années et pour transformer en date
  ,PARSE_DATE("%Y", CAST(SUBSTRING(annee,4) AS STRING)) AS annee
  ,commune
  ,CAST(insee AS STRING) AS insee
  ,gid
  ,geometry
FROM   
   (SELECT *   
FROM `velyon-batch-1187.population.population`) AS population
UNPIVOT  
   (nb_habitants FOR annee IN   
      (pop2019,pop2018,pop2017,pop2016,pop2015,pop2014,pop2013,pop2012,pop2011,pop2010,pop2009,pop2008,pop2007)  
)AS pop_by_year
WHERE annee = "pop2019"
ORDER BY commune