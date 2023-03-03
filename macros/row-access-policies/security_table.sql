{% macro create_security_table() %}

    create or replace SCHEMA SEC;

    create or replace TABLE SEC.YELP_SECURITY_TABLE (
        ID NUMBER(38,0),
        COL_NAME VARCHAR(16777216),
        ALLOWED_VALUE VARCHAR(16777216),
        USERNAME VARCHAR(16777216)
    );

    INSERT INTO SEC.YELP_SECURITY_TABLE
    (ID, COL_NAME, ALLOWED_VALUE, USERNAME)
    VALUES
    (1, 'STATE', 'SC', 'bjorn.cornelis@biztory.be'),
    (1, 'STATE', 'WI', 'wim.kegels@biztory.be'),
    (1, 'STATE', 'IL', 'wim.kegels@biztory.be'),
    (1, 'STATE', 'AZ', 'wim.kegels@biztory.be'),
    (1, 'STATE', 'ALL VALUES', 'kjell.geerts@biztory.be');
{% endmacro %}