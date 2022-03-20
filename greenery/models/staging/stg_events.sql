WITH events_source AS (
  SELECT *
  FROM {{ source('greenery', 'events') }}
)

SELECT 
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at AS created_at_utc,
    order_id,
    product_id
FROM events_source