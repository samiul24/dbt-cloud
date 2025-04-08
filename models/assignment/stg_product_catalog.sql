{{ config(materialized='view') }}

SELECT
    product_id,
    product_name,
    category
FROM
    {{ source('dev_env', 'product_catalog') }}