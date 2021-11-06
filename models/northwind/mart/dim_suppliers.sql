{{ config(materialized='table') }}
WITH
    staging AS (
        SELECT *
        FROM {{ ref('stg_suppliers') }}
    ),
    transformed AS (
        SELECT
            row_number() OVER (ORDER BY supplier_id) AS supplier_sk,
            supplier_id,
            company_name,
            contact_name,
            contact_title,
            address,
            city,
            region,
            postal_code,
            country,
            phone,
            fax,
            homepage
        FROM staging
    )
SELECT * FROM transformed