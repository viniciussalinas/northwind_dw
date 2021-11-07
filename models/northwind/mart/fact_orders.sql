-- materializando como tabela, nao como view
{{ config(materialized='table') }}

-- SELECT * FROM {{ ref('stg_orders') }}
-- o ideal eh que se construa a fact com todas as dimensoes
WITH 
    customer AS (
        SELECT
            customer_sk,
            customer_id
        FROM {{ ref('dim_customers') }}
    ),
    supplier AS (
        SELECT
            supplier_sk,
            supplier_id
        FROM {{ ref('dim_suppliers') }}
    ),
    product AS (
        SELECT
            product_sk,
            product_id,
            supplier_id
        FROM {{ ref('dim_products') }}
    ),
    shipper AS (
        SELECT
            shipper_sk,
            shipper_id
        FROM {{ ref('dim_shippers') }}
    ),
    order_detail AS (
        SELECT
            order_id,
            product_id,
            unit_price,
            quantity,
            discount
        FROM {{ ref('stg_order_details') }}
    ),
    orders_with_sk AS (
        SELECT
            orders.order_id,
            customer.customer_id,
            order_detail.product_id,
            supplier.supplier_id,
            shipper.shipper_id,
            orders.ship_city AS cidade,
            orders.employee_id,
            orders.order_date,
            orders.ship_region,
            orders.shipped_date,
            orders.ship_country,
            orders.ship_name,
            orders.ship_postal_code,
            orders.ship_city,
            orders.freight,
            orders.ship_address,
            orders.required_date,
            order_detail.unit_price,
            order_detail.quantity,
            order_detail.discount
        FROM {{ ref('stg_orders') }} orders
        LEFT JOIN customer ON orders.customer_id = customer.customer_id
        LEFT JOIN shipper ON orders.shipper_id = shipper.shipper_id
        LEFT JOIN order_detail ON orders.order_id = order_detail.order_id
        LEFT JOIN product ON order_detail.product_id = product.product_id
        LEFT JOIN supplier ON product.supplier_id = supplier.supplier_id
    )
SELECT * FROM orders_with_sk