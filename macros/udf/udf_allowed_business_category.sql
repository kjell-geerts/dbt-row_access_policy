{% macro udf_allowed_business_category() %}
    CREATE OR REPLACE FUNCTION ALLOWED_BUSINESS_CATEGORY()
    RETURNS ARRAY
    LANGUAGE SQL
    MEMOIZABLE AS 'select array_agg(allowed_value) from yelp_security_table where col_name = ''BUSINESS_CATEGORY'' and USERNAME = getvariable(''VAR_TABLEAU_USER'')';

{% endmacro %}