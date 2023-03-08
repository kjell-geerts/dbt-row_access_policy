{% macro udf_allowed_state() %}
    CREATE OR REPLACE FUNCTION ALLOWED_STATE()
    RETURNS ARRAY
    LANGUAGE SQL
    MEMOIZABLE AS 'select array_agg(allowed_value) from yelp_security_table where col_name = ''STATE'' and USERNAME = getvariable(''VAR_TABLEAU_USER'')';

{% endmacro %}