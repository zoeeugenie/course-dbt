WITH promos_source AS (
  SELECT *
  FROM {{ source('greenery', 'promos') }}
)

SELECT 
    promo_id,
    discount,
    status
FROM promos_source