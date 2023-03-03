{% macro udf_allowed_state() %}
    CREATE OR REPLACE FUNCTION ALLOWED_STATE()
    RETURNS ARRAY
    LANGUAGE SQL
    MEMOIZABLE AS 'select array_agg(allowed_value) from yelp_security_table where col_name = ''STATE'' and USERNAME = getvariable(''VAR_TABLEAU_USER'')';

    CREATE OR REPLACE ROW access POLICY state_policy as(state array) RETURNS boolean ->
        array_contains('ALL VALUES'::variant,allowed_state()) or arrays_overlap(state, allowed_state());

{% endmacro %}