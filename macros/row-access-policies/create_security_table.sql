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
    (2, 'STATE', 'WI', 'wim.kegels@biztory.be'),
    (3, 'STATE', 'IL', 'wim.kegels@biztory.be'),
    (4, 'STATE', 'AZ', 'wim.kegels@biztory.be'),
    (5, 'STATE', 'ALL VALUES', 'kjell.geerts@biztory.be'),
    (6, 'BUSINESS_CATEGORY', 'Italian', 'wim.kegels@biztory.be'),
    (7, 'BUSINESS_CATEGORY', 'Burgers', 'wim.kegels@biztory.be'),
    (8, 'BUSINESS_CATEGORY', 'Vegan', 'michiel.smulders@biztory.be'),
    (9, 'BUSINESS_CATEGORY', 'ALL VALUES', 'kjell.geerts@biztory.be')
    ;
{% endmacro %}