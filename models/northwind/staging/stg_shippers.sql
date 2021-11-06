WITH 
    source_data AS (
        SELECT
            shipper_id,
            company_name,
            phone
        FROM {{ source('erp_northwind', 'public_shippers') }}
    )
SELECT * FROM source_data