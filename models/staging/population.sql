{{ config(
    materialized='view'
)}}

SELECT 
  nb_habitants
  ,annee
  ,commune
  ,insee
  ,gid
  ,geometry
FROM   
   (SELECT *   
FROM `velyon-batch-1187.population.population`) AS population
UNPIVOT  
   (nb_habitants FOR annee IN   
      (pop2019,pop2018,pop2017,pop2016,pop2015,pop2014,pop2013,pop2012,pop2011)  
)AS pop_by_year