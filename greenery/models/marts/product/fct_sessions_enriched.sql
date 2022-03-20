{{ config(
    materialized = 'table'
    )
}}

WITH session_length AS (
    SELECT  
        session_id,
        MIN(created_at_utc) AS first_event,
        MAX(created_at_utc) AS last_event
    FROM {{ ref('fct_events') }}
    GROUP BY session_id
)

, stg_products AS (
    SELECT *
    FROM {{ ref('stg_products')}}
)

SELECT
    int_session_events_agg.session_id,
    int_session_events_agg.user_id,
    dim_customers.first_name,
    dim_customers.last_name,
    dim_customers.email,
    int_session_events_agg.page_view,
    int_session_events_agg.add_to_cart,
    int_session_events_agg.checkout,
    int_session_events_agg.package_shipped,
    session_length.first_event              AS first_session_event,
    session_length.last_event               AS last_session_event,
    (
        date_part('day', session_length.last_event::timestamp - session_length.first_event::timestamp) * 24 +
        date_part('hour', session_length.last_event::timestamp - session_length.first_event::timestamp) * 60 +
        date_part('minute', session_length.last_event::timestamp - session_length.first_event::timestamp)
    )                                       AS session_length_minutes,
    stg_products.name                       AS product_name,
    price,
    inventory                               
FROM {{ ref('int_session_events_agg') }}
LEFT JOIN {{ ref('dim_customers') }}
    ON int_session_events_agg.user_id = dim_customers.user_id
LEFT JOIN session_length
    ON int_session_events_agg.session_id = session_length.session_id
LEFT JOIN stg_products
    ON int_session_events_agg.product_id = stg_produtcs.product_id


