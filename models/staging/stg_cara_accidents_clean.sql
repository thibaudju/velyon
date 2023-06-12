SELECT * FROM {{ref('stg_cara_accidents_ap_2019')}}
UNION ALL 
SELECT * FROM {{ref('stg_cara_accidents_av_2019')}} 
