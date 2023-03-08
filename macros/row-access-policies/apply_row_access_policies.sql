{% macro apply_row_access_policies() %}
    {% if execute and env_var('DBT_RAP')=='Y' %}
    {% set materialization_map = {"table": "table", "view": "view", "incremental": "table", "snapshot": "table"} %}
        {%- for node in graph.nodes.values()| selectattr("resource_type", "equalto", "model") -%}
            {% if node.columns  | length > 0 %}
            {% set column_list = [] %}
            {% set node_list = [] %}
            {% set row_access_policy_list = [] %}
            {% set materialization = materialization_map[node.config.get("materialized")] %}
                {% for column in  node.columns.values() %}
                    {% if column.meta.row_access_policy| length > 0 %}
                        {% do column_list.append(column.name) %}
                        {% do node_list.append(node.name) %}
                        {% do row_access_policy_list.append(column.meta.row_access_policy) %}
                    {% endif %}
                {%- endfor -%}
                {% if node_list | length > 0 %}
                    ALTER {{materialization}} {{node.database}}.{{node.schema}}.{{node.name}} add row access policy {{row_access_policy_list[0]}} ON ({{column_list|join(", ")}});
            {% endif %}
            {% endif %}
        {% endfor %}
    {% endif %}
{% endmacro %}

