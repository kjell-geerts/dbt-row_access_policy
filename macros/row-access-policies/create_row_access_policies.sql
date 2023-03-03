{% macro create_row_access_policies() %}
     {% if execute and env_var('DBT_RAP')=='Y' %}
        {{create_security_table()}}
        {{udf_allowed_state()}}
    {% endif %}
{% endmacro %}