select
    concat_ws('-', o_w_id, o_d_id, o_id)    as order_key,
    concat_ws('-', o_w_id, o_d_id, o_c_id)  as customer_key,
    cast(o_id as int)                       as order_id,
    cast(o_ol_cnt as int)                   as line_count,
    cast(o_entry_d as timestamp)            as ordered_at
from {{ source('tpcc', 'orders') }}
