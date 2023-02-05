WITH stg_users AS(
    SELECT * FROM {{ ref('yelp_base_users') }}
),
stg_business as(
    select distinct tps.yelp_tips_user_id, bus.yelp_business_state from {{ ref('yelp_base_tips') }} tps
    inner join {{ ref('yelp_base_business') }} bus
    on tps.yelp_tips_business_id = bus.yelp_business_id
)

select 
    hash(usr.yelp_users_id) as usr_d_sk,
    usr.yelp_users_id as usr_id,
    usr.yelp_users_name as usr_name,
    usr.yelp_users_yelping_since as usr_yelping_since,
    usr.yelp_users_review_count as usr_review_count,
    usr.yelp_users_fans as usr_fans,
    usr.yelp_users_average_stars as usr_average_stars,
    usr.yelp_users_synced as usr_synced,
    array_agg(bus.yelp_business_state) as usr_sec_state
from stg_users usr
inner join stg_business bus
on usr.yelp_users_id = bus.yelp_tips_user_id
group by 1,2,3,4,5,6,7,8