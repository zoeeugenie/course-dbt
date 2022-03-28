
   
{{ 
    config(
        materialized='table'
    ) 
}}

WITH stg_orders AS (
    SELECT * FROM {{ ref('stg_orders') }} 
)

, promos AS (
    SELECT * FROM {{ ref('stg_promos') }} 
)

, order_items AS (
    SELECT
        order_id
        , COUNT(DISTINCT product_id) as unique_products_purchased
        , SUM(quantity) as items_purchased_total
    FROM {{ ref('stg_order_items') }} 
    GROUP BY order_id
)

SELECT 
    stg_orders.*
    , unique_products_purchased
    , items_purchased_total
    , discount
    , CASE 
        WHEN discount > 0 
        THEN 1 
        ELSE 0 
        END AS discounted
FROM stg_orders
LEFT JOIN order_items
    ON stg_orders.order_id = order_items.order_id
LEFT JOIN promos
    ON stg_orders.promo_id = promos.promo_id
