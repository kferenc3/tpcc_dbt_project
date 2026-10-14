-- One row per item with units sold and revenue.
select
    i.item_id,
    i.item_name,
    i.price,
    coalesce(sum(ol.quantity), 0)   as units_sold,
    coalesce(sum(ol.amount), 0)     as revenue
from {{ ref('stg_tpcc__item') }} i
left join {{ ref('stg_tpcc__order_line') }} ol
    on ol.item_id = i.item_id
group by 1, 2, 3
