select
    cast(i_id as int)                       as item_id,
    trim(i_name)                            as item_name,
    cast(i_price as decimal(18, 2))         as price
from {{ source('tpcc', 'item') }}
