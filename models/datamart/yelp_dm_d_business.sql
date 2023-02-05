WITH dwh_business AS(
    SELECT * FROM {{ ref('yelp_d_business') }}
)
select 
    bus_d_sk,
    bus_id as "Business ID",
    bus_name as "Business Name",
    bus_type as "Business Type",
    bus_open as "Business Open",
    bus_address as "Business Address",
    bus_city as "Business City",
    bus_state as "Business State",
    bus_longitude as "Business Longitude",
    bus_latitude as "Business Latitude",
    bus_stars as "Business Stars",
    bus_review_count as "Business Review Count",
    bus_sec_state
from dwh_business