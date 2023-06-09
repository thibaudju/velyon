{{ config(
    materialized='view',
)}}

-- Cleaning de la table "caracteristiques_accidents"

SELECT 
Num_Acc,
CAST((FORMAT_TIMESTAMP('%Y-%m-%d', TIMESTAMP(DATE(CONCAT(CAST(an AS STRING), '-', CAST(mois AS STRING), '-', CAST(jour AS STRING)))))) AS DATE) AS date_date,
hrmm  as heure_minute,
    CASE 
        WHEN lum = 1 THEN 'Plein jour'
        WHEN lum = 2 THEN 'Crépuscule ou aube'
        WHEN lum = 3 THEN 'Nuit sans éclairage public'
        WHEN lum = 4 THEN 'Nuit avec éclairage public non allumé'
        WHEN lum = 5 THEN 'Nuit avec éclairage public allumé'
        ELSE ' '
    END as lumiere,
dep as departement,
CAST(com as INT64) AS commune_insee,
    CASE 
        WHEN agg = 1 THEN 'Hors agglomération'
        WHEN agg = 2 THEN 'En agglomération'
        ELSE ' '
    END as agglomeration,
    CASE
        WHEN int = 1 THEN 'Hors intersection'
        WHEN int = 2 THEN 'Intersection en X'
        WHEN int = 3 THEN 'Intersection en T'
        WHEN int = 4 THEN 'Intersection en Y'
        WHEN int = 5 THEN 'Intersection à plus de 4 branches'
        WHEN int = 6 THEN 'Giratoire'
        WHEN int = 7 THEN 'Place'
        WHEN int = 8 THEN 'Passage à niveau'
        WHEN int = 9 THEN 'Autre intersection'
        ELSE ' '
    END as intersection,
    CASE
        WHEN atm = -1 THEN 'Non renseigné'
        WHEN atm = 1 THEN 'Normale'
        WHEN atm = 2 THEN 'Pluie légère'
        WHEN atm = 3 THEN 'Pluie forte'
        WHEN atm = 4 THEN 'Neige - grêle'
        WHEN atm = 5 THEN 'Brouillard - fumée'
        WHEN atm = 6 THEN 'Vent fort - tempête'
        WHEN atm = 7 THEN 'Temps éblouissant'
        WHEN atm = 8 THEN 'Temps couvert'
        WHEN atm = 9 THEN 'Autre'
        ELSE ' '
    END as meteo,
    CASE
        WHEN col = -1 THEN 'Non renseigné'
        WHEN col = 1 THEN 'Deux véhicules - frontale'
        WHEN col = 2 THEN 'Deux véhicules – par l’arrière'
        WHEN col = 3 THEN 'Deux véhicules – par le coté'
        WHEN col = 4 THEN 'Trois véhicules et plus – en chaîne'
        WHEN col = 5 THEN 'Trois véhicules et plus - collisions multiples'
        WHEN col = 6 THEN 'Autre collision'
        WHEN col = 7 THEN 'Sans collision'
        ELSE ' '
    END as collision,
UPPER(COALESCE(adr,'')) as adresse,
COALESCE(lat, '') as Latitude,
COALESCE(long, '') as Longitude

FROM velyon-batch-1187.accident.caracteristiques_all as t1

-- Filtre sur le département de Lyon
WHERE dep like '69%'