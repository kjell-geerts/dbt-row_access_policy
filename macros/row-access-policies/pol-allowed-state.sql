{% macro pol_allowed_state() %}
    {%- for node in graph.nodes.values()| selectattr("resource_type", "equalto", "model") -%}
        {% for column in  node.columns.values() %}
        
            {{'ALTER TABLE reporting.kjellgeerts.yelp_tips_datamart add row access policy security.sec.{{column}} ON (TPS_SEC_STATE);'}}

        {%- endfor -%}
    {% endfor %}
{% endmacro %}

{% macro drop_pol_allowed_state(resource_type="models",meta_key="row_access_policy") %}

    ALTER TABLE reporting.kjellgeerts.yelp_tips_datamart drop row access policy security.sec.meta('row_access_policy');

{% endmacro %}