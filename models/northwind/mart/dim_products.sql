{{ config(materialized='table') }}
WITH
    staging AS (
        SELECT *
        FROM {{ ref('stg_products') }}
    ),
    transformed AS (
        SELECT
            row_number() OVER (ORDER BY product_id) AS product_sk,
            product_id,
            product_name,
            supplier_id,
            category_id,
            quantity_per_unit,
            unit_price,
            units_in_stock,
            units_on_order,
            reorder_level,
            discontinued
        FROM staging
    )
SELECT * FROM transformed