WITH addresses_source AS (
  SELECT *
  FROM {{ source('greenery', 'addresses') }}
)

SELECT 
    address_id,
    address,
    zipcode,
    state,
    country
FROM addresses_source