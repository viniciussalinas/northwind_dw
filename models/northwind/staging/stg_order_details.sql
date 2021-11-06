WITH 
    source_data AS (
        SELECT
            order_id,
            product_id,
            unit_price,
            quantity,
            discount
        FROM {{ source('erp_northwind', 'public_order_details') }}
    )
SELECT * FROM source_data