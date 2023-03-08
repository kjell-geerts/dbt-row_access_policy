{% macro create_security_table() %}
    {% if execute and env_var('DBT_RAP')=='Y' %}
        create or replace SCHEMA SEC;

        create or replace TABLE SEC.YELP_SECURITY_TABLE (
            ID NUMBER AUTOINCREMENT START 1 INCREMENT 1,
            COL_NAME VARCHAR(16777216),
            ALLOWED_VALUE VARCHAR(16777216),
            USERNAME VARCHAR(16777216),
            UPDATE_TIME DATETIME
        );

        SET var_update_time  = CURRENT_TIMESTAMP;

        INSERT INTO SEC.YELP_SECURITY_TABLE
        (COL_NAME, ALLOWED_VALUE, USERNAME, UPDATE_TIME)
        VALUES
        ('STATE', 'SC', 'bjorn.cornelis@biztory.be', getvariable('VAR_UPDATE_TIME')),
        ('STATE', 'WI', 'wim.kegels@biztory.be', getvariable('VAR_UPDATE_TIME')),
        ('STATE', 'IL', 'wim.kegels@biztory.be', getvariable('VAR_UPDATE_TIME')),
        ('STATE', 'AZ', 'wim.kegels@biztory.be', getvariable('VAR_UPDATE_TIME')),
        ('STATE', 'ALL VALUES', 'kjell.geerts@biztory.be', getvariable('VAR_UPDATE_TIME')),
        ('BUSINESS_CATEGORY', 'Italian', 'wim.kegels@biztory.be', getvariable('VAR_UPDATE_TIME')),
        ('BUSINESS_CATEGORY', 'Burgers', 'wim.kegels@biztory.be', getvariable('VAR_UPDATE_TIME')),
        ('BUSINESS_CATEGORY', 'Vegan', 'michiel.smulders@biztory.be', getvariable('VAR_UPDATE_TIME')),
        ('BUSINESS_CATEGORY', 'ALL VALUES', 'kjell.geerts@biztory.be', getvariable('VAR_UPDATE_TIME'))
        ;
    {% endif %}
{% endmacro %}