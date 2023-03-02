{% macro udf_allowed_state() %}
    CREATE OR REPLACE FUNCTION SEC.ALLOWED_STATE()
    RETURNS ARRAY
    LANGUAGE SQL
    MEMOIZABLE AS 'select array_agg(allowed_value) from sec.yelp_security_table where col_name = ''STATE'' and USERNAME = getvariable(''VAR_TABLEAU_USER'')';

    CREATE OR REPLACE ROW access POLICY sec.state_policy as(state array) RETURNS boolean ->
        array_contains('ALL VALUES'::variant,sec.allowed_state()) or arrays_overlap(state,sec.allowed_state());

{% endmacro %}