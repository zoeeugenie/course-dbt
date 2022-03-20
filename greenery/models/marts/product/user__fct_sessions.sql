{{ config(
    materialized = 'table'
    )
}}

WITH fct_sessions_enriched AS (
    SELECT *
    FROM {{ ref('fct_sessions_enriched')}}
)

SELECT
    user_id,
    first_name,
    last_name,
    email,
    COUNT(DISTINCT session_id)          AS n_sessions_lifetime, 
    MIN(first_session_event)            AS first_session_event,
    MAX(last_session_event)             AS last_session_event,
    AVG(session_length_minutes)         AS session_length_minutes_avg
FROM fct_sessions_enriched

{{ dbt_utils.group_by(4)}}