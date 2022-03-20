{{
  config(
    materialized='table'
  )
}}

WITH stg_products AS (
  SELECT *
  FROM {{ ref('stg_products') }}
)

SELECT 
    product_id,
    name,
    price,
    inventory
FROM stg_products