use database security
;
create schema if not exists security.sec;

{% macro unapply_row_access_policies() %}
{% if execute %}
{%- call statement("row_access_policies_check", fetch_result=True) -%}
select count(policy_name)
from
    table(
        information_schema.policy_references(
            ref_entity_name => 'reporting.kjellgeerts.yelp_tips_datamart',
            ref_entity_domain => 'table'
        )
    )
{%- endcall -%}

{%- set number_of_row_access_policies = load_result("row_access_policies_check")["data"][0][0] -%}
{% if number_of_row_access_policies > 0 %}
                ALTER TABLE IF EXISTS reporting.kjellgeerts.yelp_tips_datamart DROP ALL ROW ACCESS POLICIES;
{% endif %}
{% endif %}
{% endmacro %}
