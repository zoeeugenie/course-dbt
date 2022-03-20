{{
  config(
    materialized='table'
  )
}}

WITH stg_users AS (
  SELECT *
  FROM {{ ref('stg_users') }}
),

stg_addresses AS (
SELECT *
FROM {{ ref('stg_addresses')}}

)

SELECT 
    user_id,
    first_name,
    last_name,
    email,
    address,
    zipcode,
    state,
    country,
    phone_number,
    created_at,
    updated_at
FROM stg_users u 
LEFT JOIN
  stg_addresses a 
USING (address_id)