WITH users_source AS (
  SELECT *
  FROM {{ source('greenery', 'users') }}
)

SELECT 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
FROM users_source