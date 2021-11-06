WITH
    -- source_data eh apelido
    source_data AS (
        SELECT
            order_id,
            employee_id,
            order_date,
            customer_id,
            ship_region,
            shipped_date,
            ship_country,
            ship_name,
            ship_postal_code,
            ship_city,
            freight,
            ship_via as shipper_id,
            ship_address,
            required_date
        -- dbt trabalha com ref (referencia - tabelas criadas dentro do dbt) e source (fonte - que vem do processo de el)
        -- sources configurados no source.yml
        FROM {{ source('erp_northwind', 'public_orders') }}
    )

SELECT * FROM source_data