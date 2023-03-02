{% macro apply_sec_policies() %}
use database security;
create schema if not exists security.sec;

{{pol_allowed_state()}}

{% endmacro %}