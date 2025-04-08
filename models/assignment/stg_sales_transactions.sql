{{ config(materialized='view') }}

SELECT
    transaction_id,
    product_id,
    user_id,
    transaction_timestamp,
    revenue,
    cost,
    EXTRACT(YEAR FROM transaction_timestamp) AS transaction_year,
    EXTRACT(MONTH FROM transaction_timestamp) AS transaction_month
FROM
    {{ source('dev_env', 'sales_transactions') }}