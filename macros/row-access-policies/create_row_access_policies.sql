{% macro create_row_access_policies() %}
    USE DATABASE {{var('security_database')}}
    ;
    CREATE SCHEMA IF NOT EXISTS {{var('security_database')}}.{{var('security_schema')}};

     {% if execute and env_var('DBT_RAP')=='Y' %}
        {{udf_allowed_state()}}
    {% endif %}
{% endmacro %}