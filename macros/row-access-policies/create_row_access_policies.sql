{% macro create_row_access_policies() %}
use database security;
create schema if not exists security.sec;

    {{udf_allowed_state()}}

{% endmacro %}