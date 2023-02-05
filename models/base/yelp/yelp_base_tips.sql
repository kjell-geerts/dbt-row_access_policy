select 
    _line as yelp_tips_line_id,
    user_id as yelp_tips_user_id,
    text as yelp_tips_comment,
    business_id as yelp_tips_business_id,
    likes as yelp_tips_likes,
    date as yelp_tips_date,
    type as yelp_tips_type,
    _fivetran_synced as yelp_tips_synced
from {{ source('YELP', 'YELP_ACADEMIC_DATASET_TIP') }}