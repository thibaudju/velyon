-- Regrouper l'évolution de la population par année avec le nombre d'aménagements cyclables

{{ config(
    materialized='view'
)}}

WITH pre_filter AS (
    SELECT
    am.* EXCEPT (anneelivraison),
    CAST(am.anneelivraison AS STRING) AS anneelivraison,
    pop.annee,
    pop.nb_habitants
FROM {{ref('amenagement_communes')}} AS am
JOIN {{ref('population')}} AS pop ON (am.insee1 = pop.insee)
)


-- Attention cette action de filtre supprime pas mal de données d'aménagements, notamment en raison du fait que les données de population s'arrêtent à 2019...
-- Action de filtre pour que seules les années égales soient affichées (année livraison aménagement VS population année)
SELECT
    commune1 AS commune,
    insee1 AS insee,
    * EXCEPT (anneelivraison,commune1,insee1)
FROM pre_filter
WHERE anneelivraison = annee
ORDER BY commune,annee