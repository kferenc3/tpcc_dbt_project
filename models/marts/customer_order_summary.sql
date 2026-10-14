-- One row per customer with simple order and revenue totals.
with order_totals as (
    select
        o.customer_key,
        o.order_key,
        o.ordered_at,
        sum(ol.amount) as order_amount
    from {{ ref('stg_tpcc__orders') }} o
    left join {{ ref('stg_tpcc__order_line') }} ol
        on ol.order_key = o.order_key
    group by o.customer_key, o.order_key, o.ordered_at
)

select
    c.customer_key,
    c.first_name,
    c.last_name,
    c.city,
    c.state,
    c.credit_status,
    count(t.order_key)                      as order_count,
    coalesce(sum(t.order_amount), 0)        as lifetime_revenue,
    min(t.ordered_at)                       as first_order_at,
    max(t.ordered_at)                       as last_order_at
from {{ ref('stg_tpcc__customer') }} c
left join order_totals t
    on t.customer_key = c.customer_key
group by 1, 2, 3, 4, 5, 6
