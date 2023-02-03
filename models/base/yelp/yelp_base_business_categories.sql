WITH business_categories AS(
    select 
        business_id,
        categories
    from {{ source('YELP', 'YELP_ACADEMIC_DATASET_BUSINESS') }}
)
SELECT 
    bc.business_id as yelp_business_id,
    bc.categories as yelp_business_categories,
    c.value::varchar as yelp_business_category
FROM business_categories bc,
lateral flatten(input => bc.categories) c