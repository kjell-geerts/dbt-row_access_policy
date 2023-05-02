{{
    config(
        materialized='incremental',
        unique_key='tps_f_sk'
    )
}}

with dwh_tips as(
    select * from {{ ref('yelp_f_tips') }}
),
dwh_business AS(
    SELECT * FROM {{ ref('yelp_d_business') }}
),
dwh_users AS(
    SELECT * FROM {{ ref('yelp_d_users') }}
),
dwh_business_categories AS(
    SELECT bus_cat_d_sk, array_agg(bus_cat_name) as bus_cat_name,array_agg(bus_cat_name) as bus_cat_sec_name FROM {{ ref('yelp_d_business_categories') }} GROUP BY bus_cat_d_sk
)

SELECT
    tps_date as "Tip Date",
    usr_id as "User ID",
    usr_name as "User Name",
    usr_yelping_since as "User Yelping Since",
    usr_review_count as "User Review Count",
    usr_fans as "User Fans",
    usr_average_stars as "User Average Stars",
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
    tps_likes as "Likes",
    array_to_string(bus_cat_name,', ') as "Business Categories",
    tps_sec_state,
    bus_cat_sec_name,
    tps_f_sk
from dwh_tips t
inner join dwh_business b
on t.tps_bus_d_sk = b.bus_d_sk
inner join dwh_users u
on t.tps_usr_d_sk = u.usr_d_sk
inner join dwh_business_categories bc
on t.tps_bus_d_sk = bc.bus_cat_d_sk