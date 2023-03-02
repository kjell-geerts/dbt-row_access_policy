{% macro unapply_sec_policies() %}
use database security;
create schema if not exists security.sec;

{{drop_pol_allowed_state()}}

{% endmacro %}