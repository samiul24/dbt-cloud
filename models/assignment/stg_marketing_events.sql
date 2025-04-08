{{ config(materialized='view') }}

SELECT
    event_id,
    user_id,
    event_type,
    event_timestamp,
    channel,
    campaign,
    cost,
    EXTRACT(YEAR FROM event_timestamp) AS event_year,
    EXTRACT(MONTH FROM event_timestamp) AS event_month
FROM
    {{ source('dev_env', 'marketing_events') }}