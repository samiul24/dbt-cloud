{{ config(materialized='table') }}

WITH marketing_agg AS (
    SELECT
        event_year,
        event_month,
        SUM(cost) AS total_marketing_cost,
        COUNT(event_id) AS total_marketing_events
    FROM
        {{ ref('stg_marketing_events') }}
    GROUP BY
        event_year, event_month
),
sales_agg AS (
    SELECT
        s.transaction_year,
        s.transaction_month,
        p.category,
        COUNT(DISTINCT s.user_id) AS unique_customers,
        SUM(s.revenue) AS total_revenue,
        SUM(s.cost) AS total_cost
    FROM
        {{ ref('stg_sales_transactions') }} s
    LEFT JOIN
        {{ ref('stg_product_catalog') }} p ON s.product_id = p.product_id
    GROUP BY
        s.transaction_year, s.transaction_month, p.category
)
SELECT
    s.transaction_year,
    s.transaction_month,
    s.category,
    s.unique_customers,
    s.total_revenue,
    s.total_cost,
    COALESCE(m.total_marketing_cost, 0) AS total_marketing_cost,
    COALESCE(m.total_marketing_events, 0) AS total_marketing_events,
    -- Use the macro to calculate the revenue-to-cost ratio
    {{ calculate_revenue_to_cost_ratio('s.total_revenue', 's.total_cost') }} AS revenue_to_cost_ratio
FROM
    sales_agg s
LEFT JOIN
    marketing_agg m ON s.transaction_year = m.event_year
    AND s.transaction_month = m.event_month
WHERE
    s.total_revenue > 0
ORDER BY
    s.transaction_year, s.transaction_month, s.category