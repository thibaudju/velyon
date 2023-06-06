{{ config(
    materialized='view'
)}}



SELECT
* 
FROM {{ ref('stg_compteurs_all_mesures') }}