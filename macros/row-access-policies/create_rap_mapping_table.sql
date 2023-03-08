{% macro create_rap_mapping_table() %}
    {% if execute and env_var('DBT_RAP')=='Y'%}
        {% set materialization_map = {"table": "table", "view": "view", "incremental": "table", "snapshot": "table"} %}
        {% set rap_list = [] %}
            {%- for node in graph.nodes.values()| selectattr("resource_type", "equalto", "model") -%}
                {% if node.columns  | length > 0 %}
                {% set materialization = materialization_map[node.config.get("materialized")] %}
                    {%- call statement("get_all_rap", fetch_result=True) -%}   
                        SELECT   
                            policy_db,
                            policy_schema,
                            policy_name,
                            policy_kind,
                            ref_database_name,
                            ref_schema_name,
                            ref_entity_name,
                            ref_entity_domain,
                            t0.value::string as ref_entity_column,
                            policy_status
                        FROM
                            table(
                                information_schema.policy_references(
                                    ref_entity_name => '{{node.database ~ '.' ~ node.schema ~ '.'~ node.name}}',
                                    ref_entity_domain => '{{materialization}}'
                                )
                            ),
                        lateral flatten(input => PARSE_JSON(ref_arg_column_names)::variant) as t0;
                    {%- endcall -%}
                    {%- for existing_rap in load_result("get_all_rap")["data"]  -%}
                        {% do rap_list.append(existing_rap) %}  
                    {% endfor %}
                {% endif %}
            {% endfor %}

        USE SCHEMA SEC;

        CREATE OR REPLACE TABLE RAP_MAPPING(
            ID NUMBER AUTOINCREMENT START 1 INCREMENT 1,
            POLICY_DB VARCHAR(255),
            POLICY_SCHEMA VARCHAR(255),
            POLICY_NAME VARCHAR(255),
            POLICY_KIND VARCHAR(255),
            REF_DATABASE_NAME VARCHAR(255),
            REF_SCHEMA_NAME VARCHAR(255),
            REF_ENTITY_NAME VARCHAR(255),
            REF_ENTITY_DOMAIN VARCHAR(255),
            REF_ENTITY_COLUMN VARCHAR(255),
            POLICY_STATUS VARCHAR(255),
            UPDATE_TIME DATETIME
        );

        SET var_update_time  = CURRENT_TIMESTAMP;

        INSERT INTO RAP_MAPPING (POLICY_DB, POLICY_SCHEMA, POLICY_NAME, POLICY_KIND, REF_DATABASE_NAME, REF_SCHEMA_NAME, REF_ENTITY_NAME, REF_ENTITY_DOMAIN, REF_ENTITY_COLUMN, POLICY_STATUS, UPDATE_TIME) VALUES

            {%- for rap in rap_list %}
            ('{{rap[0]}}', '{{rap[1]}}', '{{rap[2]}}', '{{rap[3]}}','{{rap[4]}}', '{{rap[5]}}', '{{rap[6]}}', '{{rap[7]}}','{{rap[8]}}', '{{rap[9]}}', getvariable('VAR_UPDATE_TIME'))
            {%- if not loop.last %},{% endif -%}
        {% endfor %}
    {% endif %}
{% endmacro %}