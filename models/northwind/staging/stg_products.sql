WITH 
    source_data AS (
        SELECT
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
        FROM {{ source('erp_northwind', 'public_products') }}
    )
SELECT * FROM source_data