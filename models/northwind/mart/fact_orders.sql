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
    orders_with_sk AS (
        SELECT
            orders.order_id,
            customer.customer_id,
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
            orders.shipper_id,
            orders.ship_address,
            orders.required_date
            -- mais colunas de orders
        FROM {{ ref('stg_orders') }} orders
        LEFT JOIN customer ON orders.customer_id = customer.customer_id
    )
SELECT * FROM orders_with_sk