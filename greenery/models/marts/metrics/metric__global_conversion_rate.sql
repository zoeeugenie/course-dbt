{{ config(
    materialized = 'table'
    )
}}

WITH fct_sessions_enriched AS (
    SELECT *
    FROM {{ ref('fct_sessions_enriched')}}
)

SELECT
    SUM(CASE 
        WHEN checkout = 1 AND order_id IS NOT NULL
        THEN 1 ELSE 0 END)::numeric / 
    COUNT(DISTINCT session_id)::numeric AS conversion_rate                           
FROM fct_sessions_enriched 
