WITH 
    source_data AS (
        SELECT
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
        FROM {{ source('erp_northwind', 'public_suppliers') }}
    )
SELECT * FROM source_data