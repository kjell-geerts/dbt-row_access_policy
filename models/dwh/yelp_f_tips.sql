with stg_yelp_tips as(
    select * from {{ ref('yelp_base_tips') }}
)

select 
    HASH(yelp_tips_line_id) as tps_f_sk,
    HASH(yelp_tips_line_id) as tps_tps_d_sk,
    HASH(yelp_tips_user_id) as tps_usr_d_sk,
    HASH(yelp_tips_business_id) as tps_bus_d_sk,
    HASH(yelp_tips_date) as tps_dt_d_sk,
    date(yelp_tips_synced) as tps_dt_synced_d_sk,
    yelp_tips_likes as tps_likes
from stg_yelp_tips