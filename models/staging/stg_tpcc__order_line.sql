select
    concat_ws('-', ol_w_id, ol_d_id, ol_o_id, ol_number)    as order_line_key,
    concat_ws('-', ol_w_id, ol_d_id, ol_o_id)               as order_key,
    cast(ol_i_id as int)                                    as item_id,
    cast(ol_quantity as int)                                as quantity,
    cast(ol_amount as decimal(18, 2))                       as amount
from {{ source('tpcc', 'order_line') }}
