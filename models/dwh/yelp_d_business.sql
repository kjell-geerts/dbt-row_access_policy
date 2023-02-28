{{
    config(
        materialized='incremental',
        unique_key='bus_d_sk'
    )
}}


WITH stg_business AS(
    SELECT * FROM {{ ref('yelp_base_business') }}
)
select 
    HASH(yelp_business_id) as bus_d_sk,
    yelp_business_id as bus_id,
    yelp_business_name as bus_name,
    yelp_business_type as bus_type,
    yelp_business_open as bus_open,
    yelp_business_full_address as bus_address,
    yelp_business_city as bus_city,
    yelp_business_state as bus_state,
    yelp_business_longitude as bus_longitude,
    yelp_business_latitude as bus_latitude,
    yelp_business_stars as bus_stars,
    yelp_business_review_count as bus_review_count,
    date(yelp_business_synced) as bus_synced,
    to_array(yelp_business_state) as bus_sec_state
from stg_business