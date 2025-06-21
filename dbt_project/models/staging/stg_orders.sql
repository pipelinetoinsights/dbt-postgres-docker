with source as (
    select * from {{ source('dbt_demo', 'orders') }}
),

renamed as (
    select
        id as order_id,
        customer_id,
        order_date,
        total_amount,
        status as order_status,
        -- Add some business logic
        case 
            when total_amount >= 300 then 'high_value'
            when total_amount >= 100 then 'medium_value'
            else 'low_value'
        end as order_value_category,
        -- Add date parts for analysis
        extract(year from order_date) as order_year,
        extract(month from order_date) as order_month,
        extract(day from order_date) as order_day
    from source
)

select * from renamed 