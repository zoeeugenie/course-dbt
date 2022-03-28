{{
    config(
        materialized = 'table'
    )
}}

-- get every event type in a dict
-- package_shipped
-- page_view
-- checkout
-- add_to_cart
{%
    set event_types = dbt_utils.get_query_results_as_dict(
      "select distinct quote_literal(event_type) as event_type, event_type as column_name from"
      ~ ref('fct_events')
    )
%}

WITH fct_events AS (
    SELECT * 
    FROM {{ ref('fct_events') }}
)

-- for every event type get the number of events of that type per user
SELECT 
    session_id
    , created_at_utc
    , user_id
    , product_id
    , order_id
    {% for event_type in event_types['event_type'] %}
    , SUM( CASE WHEN event_type = {{ event_type }}
                THEN 1 ELSE 0 END) AS {{ event_types['column_name'][loop.index0] }}
    {% endfor %}
FROM fct_events
-- group by helper function
{{ dbt_utils.group_by(5)}}