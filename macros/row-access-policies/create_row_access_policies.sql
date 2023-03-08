{% macro create_row_access_policies() %}
     {% if execute and env_var('DBT_RAP')=='Y' %}
        
        -- CREATE SECURITY TABLE
        {{create_security_table()}}
        
        -- CREATE UDFS
        {{udf_allowed_state()}}
        {{udf_allowed_business_category()}}

        -- CREATE ROW ACCESS POLICIES
        {{rap_state_policy()}}
        {{rap_state_business_category_policy()}}

    {% endif %}
{% endmacro %}