{{ config(materialized='table') }}
WITH
    staging AS (
        SELECT *
        FROM {{ ref('stg_customers') }}
    ),
    transformed AS (
        SELECT
            row_number() OVER (ORDER BY customer_id) AS customer_sk, -- auto-incremental surrogate key
            customer_id,
            country,
            city,
            fax,
            postal_code,
            address,
            region,
            contact_name,
            phone,
            company_name,
            contact_title
        FROM staging
    )
SELECT * FROM transformed