select 
    _line as yelp_business_line_id,
    business_id as yelp_business_id,
    full_address as yelp_business_full_address,
    open as yelp_business_open,
    city as yelp_business_city,
    review_count as yelp_business_review_count,
    name as yelp_business_name,
    longitude as yelp_business_longitude,
    state as yelp_business_state,
    stars as yelp_business_stars,
    latitude as yelp_business_latitude,
    type as yelp_business_type,
    _fivetran_synced as yelp_business_synced
from {{ source('YELP', 'YELP_ACADEMIC_DATASET_BUSINESS') }}