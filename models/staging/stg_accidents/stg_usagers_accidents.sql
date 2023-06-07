{{ config(
    materialized='view',
)}}

SELECT 
Num_Acc,
id_vehicule,
num_veh,
    CASE 
        WHEN catu = 1 THEN 'Conducteur'
        WHEN catu = 2 THEN 'Passager'
        WHEN catu = 3 THEN 'Piéton'
        ELSE ' '
    END as categorie_usager,
     CASE 
        WHEN grav = 1 THEN 'Indemne'
        WHEN grav = 2 THEN 'Tué'
        WHEN grav = 3 THEN 'Blessé hospitalisé'
        WHEN grav = 4 THEN 'Blessé léger'
        ELSE ' '
    END as gravite_blessure,
    CASE 
        WHEN sexe = 1 THEN 'Masculin'
        WHEN sexe = 2 THEN 'Féminin'
        ELSE ' '
    END as sexe,
an_nais as annee_naissance,
     CASE 
        WHEN trajet = -1 THEN 'Non renseigné'
        WHEN trajet = 0 THEN 'Non renseigné'
        WHEN trajet = 1 THEN 'Domicile – travail'
        WHEN trajet = 2 THEN 'Domicile – école'
        WHEN trajet = 3 THEN 'Courses – achats'
        WHEN trajet = 4 THEN 'Utilisation professionnelle'
        WHEN trajet = 5 THEN 'Promenade – loisirs'
        WHEN trajet = 9 THEN 'Autre'
        ELSE ' '
    END as trajet,
    CASE 
        WHEN secu1 = -1 THEN 'Non renseigné'
        WHEN secu1 = 0 THEN 'Aucun équipement'
        WHEN secu1 = 1 THEN 'Ceinture'
        WHEN secu1 = 2 THEN 'Casque'
        WHEN secu1 = 3 THEN 'Dispositif enfants'
        WHEN secu1 = 4 THEN 'Gilet réfléchissant'
        WHEN secu1 = 5 THEN 'Airbag (2RM/3RM)'
        WHEN secu1 = 6 THEN 'Gants (2RM/3RM)'
        WHEN secu1 = 7 THEN 'Gants + Airbag (2RM/3RM)'
        WHEN secu1 = 8 THEN 'Non déterminable'
        WHEN secu1 = 9 THEN 'Autre'
        ELSE ' '
    END as secu1,
    CASE 
        WHEN secu2 = -1 THEN 'Non renseigné'
        WHEN secu2 = 0 THEN 'Aucun équipement'
        WHEN secu2 = 1 THEN 'Ceinture'
        WHEN secu2 = 2 THEN 'Casque'
        WHEN secu2 = 3 THEN 'Dispositif enfants'
        WHEN secu2 = 4 THEN 'Gilet réfléchissant'
        WHEN secu2 = 5 THEN 'Airbag (2RM/3RM)'
        WHEN secu2 = 6 THEN 'Gants (2RM/3RM)'
        WHEN secu2 = 7 THEN 'Gants + Airbag (2RM/3RM)'
        WHEN secu2 = 8 THEN 'Non déterminable'
        WHEN secu2 = 9 THEN 'Autre'
        ELSE ' '
    END as secu2,
        CASE 
        WHEN secu3 = -1 THEN 'Non renseigné'
        WHEN secu3 = 0 THEN 'Aucun équipement'
        WHEN secu3 = 1 THEN 'Ceinture'
        WHEN secu3 = 2 THEN 'Casque'
        WHEN secu3 = 3 THEN 'Dispositif enfants'
        WHEN secu3 = 4 THEN 'Gilet réfléchissant'
        WHEN secu3 = 5 THEN 'Airbag (2RM/3RM)'
        WHEN secu3 = 6 THEN 'Gants (2RM/3RM)'
        WHEN secu3 = 7 THEN 'Gants + Airbag (2RM/3RM)'
        WHEN secu3 = 8 THEN 'Non déterminable'
        WHEN secu3 = 9 THEN 'Autre'
        ELSE ' '
    END as secu3,
    CASE 
        WHEN locp = -1 THEN 'Non renseigné'
        WHEN locp = 0 THEN 'Sans objet'
        WHEN locp = 1 THEN 'A + 50 m du passage piéton'
        WHEN locp = 2 THEN 'A – 50 m du passage piéton'
        WHEN locp = 3 THEN 'Sans signalisation lumineuse'
        WHEN locp = 4 THEN 'Avec signalisation lumineuse'
        WHEN locp = 5 THEN 'Sur trottoir'
        WHEN locp = 6 THEN 'Sur accotement'
        WHEN locp = 7 THEN 'Sur refuge ou BAU'
        WHEN locp = 8 THEN 'Sur contre allée'
        WHEN locp = 9 THEN 'Inconnue'
        ELSE ' '
    END as loc_pieton,
    CASE 
        WHEN actp = '-1' THEN 'Non renseigné'
        WHEN actp = '0' THEN 'Non renseigné ou sans objet'
        WHEN actp = '1' THEN 'Sens véhicule heurtant'
        WHEN actp = '2' THEN 'Sens inverse du véhicule'
        WHEN actp = '3' THEN 'Traversant'
        WHEN actp = '4' THEN 'Masqué'
        WHEN actp = '5' THEN 'Jouant – courant'
        WHEN actp = '6' THEN 'Avec animal'
        WHEN actp = '9' THEN 'Autre'
        WHEN actp = 'A' THEN 'Monte/descend du véhicule'
        WHEN actp = 'B' THEN 'Inconnue'
        ELSE ' '
    END as act_pieton,
    CASE
        WHEN etatp = -1 THEN 'Non renseigné'
        WHEN etatp = 0 THEN 'Seul'
        WHEN etatp = 1 THEN 'Accompagné'
        WHEN etatp = 1 THEN 'En groupe'
        ELSE ' '
    END as etat_pieton,

FROM velyon-batch-1187.accident.usagers_all