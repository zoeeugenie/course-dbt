{{
  config(
    materialized='table'
  )
}}

WITH stg_events AS (
  SELECT *
  FROM {{ ref('stg_events') }}
)

SELECT 
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at_utc,
    order_id,
    product_id
FROM stg_events