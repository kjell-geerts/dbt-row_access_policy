with stg_yelp_tips as(
    select * from {{ ref('yelp_base_tips') }}
),
stg_yelp_business as(
    select yelp_business_id, array_agg(yelp_business_state) as yelp_business_state 
    from {{ ref('yelp_base_business') }} 
    group by yelp_business_id
)

select 
    HASH(tps.yelp_tips_line_id) as tps_f_sk,
    HASH(tps.yelp_tips_line_id) as tps_tps_d_sk,
    HASH(tps.yelp_tips_user_id) as tps_usr_d_sk,
    HASH(tps.yelp_tips_business_id) as tps_bus_d_sk,
    HASH(tps.yelp_tips_date) as tps_dt_d_sk,
    date(tps.yelp_tips_synced) as tps_dt_synced_d_sk,
    tps.yelp_tips_likes as tps_likes,
    bus.yelp_business_state as tps_sec_state
from stg_yelp_tips tps
inner join stg_yelp_business bus
on tps.yelp_tips_business_id = bus.yelp_business_id