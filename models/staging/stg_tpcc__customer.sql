select
    concat_ws('-', c_w_id, c_d_id, c_id)    as customer_key,
    cast(c_id as int)                       as customer_id,
    cast(c_d_id as int)                     as district_id,
    cast(c_w_id as int)                     as warehouse_id,
    trim(c_first)                           as first_name,
    trim(c_last)                            as last_name,
    trim(c_city)                            as city,
    trim(c_state)                           as state,
    trim(c_credit)                          as credit_status,
    cast(c_balance as decimal(18, 2))       as balance,
    cast(c_since as timestamp)              as customer_since
from {{ source('tpcc', 'customer') }}
