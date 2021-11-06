{{ config(materialized='table') }}
WITH
    staging AS (
        SELECT *
        FROM {{ ref('stg_shippers') }}
    ),
    transformed AS (
        SELECT
            row_number() OVER (ORDER BY shipper_id) AS shipper_sk,
            shipper_id,
            company_name,
            phone
        FROM staging
    )
SELECT * FROM transformed