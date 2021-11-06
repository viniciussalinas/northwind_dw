WITH 
    source_data AS (
        SELECT
            country,
            city,
            fax,
            postal_code,
            --_sdc_table_version,
            address,
            region,
            --_sdc_received_at,
            customer_id,
            --_sdc_sequence,
            contact_name,
            phone,
            company_name,
            contact_title
            -- colunas sdc para armazenar historico dos dados
            --_sdc_batched_at,
            --_sdc_extracted_at
        FROM {{ source('erp_northwind', 'public_customers') }}
    )
SELECT * FROM source_data