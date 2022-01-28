with payments as (
    
    select 
        id as payment_id,
        orderid,
        paymentmethod,
		status as payment_status,

    -- amount is stored in cents, convert it to dollars
		amount / 100 as amount,
		created,
		_batched_at

    from `dbt-tutorial.stripe.payment`
)

select * from payments