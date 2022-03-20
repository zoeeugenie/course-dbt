{{
  config(
    materialized='table'
  )
}}

WITH fct_orders AS (
  SELECT *
  FROM {{ ref('fct_orders') }}
)

, dim_customers AS (
  SELECT *
  FROM {{ ref('dim_customers')}}
)

SELECT  *
  , CASE 
      WHEN n_orders_lifetime > 1
      THEN 1 
      ELSE 0 
      END AS repeat_customer
FROM(
  SELECT 
    c.*
    , AVG(unique_products_purchased)        AS unique_products_per_order_avg
    , AVG(items_purchased_total)            AS items_per_order_avg
    , SUM(items_purchased_total)            AS items_purchased_lifetime
    , MIN(first_order)                      AS first_order
    , MIN(last_order)                       AS last_order
    , AVG(discounted)                       AS share_orders_discounted
    , COUNT(DISTINCT order_id)              AS n_orders_lifetime
  FROM dim_customers c
  LEFT JOIN fct_orders o 
    ON c.user_id = o.user_id

  {{ dbt_utils.group_by(11)}}
) t




