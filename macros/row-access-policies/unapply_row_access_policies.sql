{% macro unapply_row_access_policies() %}
    {% if execute %}
    {% set materialization_map = {"table": "table", "view": "view", "incremental": "table", "snapshot": "table"} %}
        {%- for node in graph.nodes.values()| selectattr("resource_type", "equalto", "model") -%}
            {% set materialization = materialization_map[node.config.get("materialized")] %}
            {% for column in  node.columns.values() %}

                {%- call statement("row_access_policies_check", fetch_result=True) -%}
                SELECT COUNT(policy_name)
                FROM
                    table(
                        information_schema.policy_references(
                            ref_entity_name => '{{node.database ~ '.' ~ node.schema ~ '.'~ node.name}}',
                            ref_entity_domain => '{{materialization}}'
                        )
                    )
                {%- endcall -%}
                {%- set number_of_row_access_policies = load_result("row_access_policies_check")["data"][0][0] -%}
                {% if number_of_row_access_policies > 0     %}
                    {% if column.meta.row_access_policy| length > 0 %}
                        ALTER {{materialization}} IF EXISTS {{node.database}}.{{node.schema}}.{{node.name}} DROP ALL ROW ACCESS POLICIES;
                    {% endif %}
                {% endif %} 
            {%- endfor -%}
        {% endfor %}
    {% endif %}
{% endmacro %}
