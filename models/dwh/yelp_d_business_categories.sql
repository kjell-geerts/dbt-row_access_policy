WITH stg_business_categories AS(
    SELECT * FROM {{ ref('yelp_base_business_categories') }}
)
select 
    HASH(yelp_business_id) as bus_cat_d_sk,
    yelp_business_category as bus_cat_name,
    to_array(yelp_business_category) as bus_cat_sec_cat
from stg_business_categories