{% macro rap_state_policy() %}

    CREATE OR REPLACE ROW access POLICY state_policy as(state array) RETURNS boolean ->
        array_contains('ALL VALUES'::variant,allowed_state()) or arrays_overlap(state, allowed_state());

{% endmacro %}