with customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        customer_id,
        customer_name,
        customer_email,
        customer_city,
        customer_created_at,
        is_valid_email,
        email_domain,
        -- Add some derived fields
        case 
            when customer_city in ('New York', 'Los Angeles', 'Chicago') then 'Major City'
            else 'Other City'
        end as city_category,
        -- Add customer age (days since creation)
        current_date - date(customer_created_at) as customer_age_days
    from customers
)

select * from final 