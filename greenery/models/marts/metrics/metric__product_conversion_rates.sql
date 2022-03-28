{{ config(
    materialized = 'table'
    )
}}

WITH int_conversion_events AS ( 
    SELECT *
    FROM {{ ref('int_conversion_events')}}
)

    SELECT product_name
        , product_id
        , round(purchases / views, 4) as conversion_rate
    FROM int_conversion_events
    ORDER BY 3 DESC


