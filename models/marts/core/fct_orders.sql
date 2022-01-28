with payments as (
    select * from {{ ref('stg_payments') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

order_payments as (

    select
	
	    orderid,
        sum(case when payment_status = 'success' then amount end) as amount_paid
		
    from payments
		
    group by 1
	
),


final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        coalesce(order_payments.amount_paid, 0) as amount_paid

    from orders

    left join order_payments ON order_id = orderid

)

select * from final