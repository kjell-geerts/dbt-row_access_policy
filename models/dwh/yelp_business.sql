WITH stg_business AS(
    SELECT * FROM {{ ref('yelp_base_business') }}
)
select * from stg_business