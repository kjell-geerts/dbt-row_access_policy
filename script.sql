        
        {%- for node in graph.nodes.values()| selectattr("resource_type", "equalto", "model") -%}
           {% if node.columns  | length > 0 %}
            {% set column_list = [] %}
            {% set row_access_policy_list = [] %}
            {% for column in  node.columns.values() %}
                {% if column.meta.row_access_policy| length > 0 %}
                    {% do column_list.append(column.name) %}
                    {% do row_access_policy_list.append(column.meta.row_access_policy) %}          
                {% endif %}
            {%- endfor -%}
            {{materialization}} {{node.database}}.{{node.schema}}.{{node.name}} {{row_access_policy_list[0]}} {{column_list|join(", ")}}       
            {% endif %}
        {% endfor %}