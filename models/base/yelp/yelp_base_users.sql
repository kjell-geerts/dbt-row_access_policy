select 
    _line as yelp_users_line_id,
    user_id as yelp_users_id,
    name as yelp_users_name,
    yelping_since as yelp_users_yelping_since,
    review_count as yelp_users_review_count,
    fans as yelp_users_fans,
    average_stars as yelp_users_average_stars,
    _fivetran_synced as yelp_users_synced
from {{ source('YELP', 'YELP_ACADEMIC_DATASET_USER') }}