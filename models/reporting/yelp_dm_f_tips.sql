with dwh_tips as(
    select * from {{ ref('yelp_f_tips') }}
)

select 
    tps_f_sk,
    tps_tps_d_sk,
    tps_usr_d_sk,
    tps_bus_d_sk,
    tps_dt_d_sk,
    tps_likes as "Likes",
    tps_sec_state
from dwh_tips