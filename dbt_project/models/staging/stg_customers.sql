with source as (
    select * from {{ source('dbt_demo', 'customers') }}
),

renamed as (
    select
        id as customer_id,
        name as customer_name,
        email as customer_email,
        city as customer_city,
        created_at as customer_created_at,
        -- Add some data quality checks
        case 
            when email like '%@%' then true 
            else false 
        end as is_valid_email,
        -- Extract domain from email
        split_part(email, '@', 2) as email_domain
    from source
)

select * from renamed 