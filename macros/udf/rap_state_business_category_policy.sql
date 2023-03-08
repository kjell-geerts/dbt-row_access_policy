{% macro rap_state_business_category_policy() %}

    CREATE OR REPLACE ROW access POLICY state_business_category_policy as(business_category array, state array) RETURNS boolean ->
        (array_contains('ALL VALUES'::variant,allowed_state()) or arrays_overlap(state, allowed_state())) AND
        (array_contains('ALL VALUES'::variant,allowed_business_category()) or arrays_overlap(business_category, allowed_business_category()));

{% endmacro %}