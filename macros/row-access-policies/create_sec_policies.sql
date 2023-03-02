{% macro create_sec_policies() %}
use database security;
create schema if not exists security.sec;

{{sec_allowed_state()}};

{% endmacro %}