WITH stg_users AS(
    SELECT * FROM {{ ref('yelp_base_users') }}
)

select 
    hash(yelp_users_id) as usr_d_sk,
    yelp_users_id as usr_id,
    yelp_users_name as usr_name,
    yelp_users_yelping_since as usr_yelping_since,
    yelp_users_review_count as usr_review_count,
    yelp_users_fans as usr_fans,
    yelp_users_average_stars as usr_average_starts,
    yelp_users_synced as usr_synced
from stg_users