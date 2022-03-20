WITH products_source AS (
  SELECT *
  FROM {{ source('greenery', 'products') }}
)

SELECT 
    product_id,
    name,
    price,
    inventory
FROM products_source