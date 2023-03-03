WITH dwh_users AS(
    SELECT * FROM {{ ref('yelp_d_users') }}
)

select 
    usr_d_sk,
    usr_id as "User ID",
    usr_name as "User Name",
    usr_yelping_since as "User Yelping Since",
    usr_review_count as "User Review Count",
    usr_fans as "User Fans",
    usr_average_stars as "User Average Stars",
    usr_sec_state
from dwh_users