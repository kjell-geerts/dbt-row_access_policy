use database security;
create schema if not exists security.sec;

{% macro apply_row_access_policies() %}
    {% if execute and env_var('DBT_RAP')=='Y' %}
        {%- for node in graph.nodes.values()| selectattr("resource_type", "equalto", "model") -%}
            {% for column in  node.columns.values() %}
                {% if column.meta.row_access_policy| length > 0 %}
                    ALTER TABLE reporting.kjellgeerts.{{node.name}} add row access policy security.sec.{{column.meta.row_access_policy}} ON ({{column.name}});
                {% endif %}
            {%- endfor -%}
        {% endfor %}
    {% endif %}
{% endmacro %}

