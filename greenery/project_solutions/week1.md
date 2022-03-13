1. How many users do we have? **130**
```
select count(distinct user_id) as n_users
from dbt_zoe_r.stg_users;
```

2. On average, how many orders do we receive per hour? **8**
```
select avg(n_orders)
from(
  select substring(cast(created_at AS VARCHAR), 1, 13),
    count(distinct order_id)       as n_orders
  from dbt_zoe_r.stg_orders
  group by 1
) t
;
```


3. On average, how long does an order take from being placed to being delivered? **3 days 21 hrs and 24 minutes**

```
select 
  avg(delivered_at - created_at) as avg_time_to_delivery
from dbt_zoe_r.stg_orders;
```

4. How many users have only made one purchase? Two purchases? Three+ purchases? **1 order --> 25 users, 2 orders --> 28 users, 3+ orders --> 71 users**

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
```
select 
  case
    when n_orders = 1 then '1' 
    when n_orders = 2 then '2' 
    when n_orders >= 3 then '3+'
    else 'unknown' end          as n_order_bucket,
  count(*)                      as n_users
from (
    select 
      user_id, 
      count(distinct order_id) as n_orders
    from dbt_zoe_r.stg_orders
    group by user_id) t
  group by 1
;
```

5. On average, how many unique sessions do we have per hour? **16**

```
select avg(n_sessions)
from(
  select substring(cast(created_at AS VARCHAR), 1, 13) as hr,
    count(distinct session_id)       as n_sessions
  from dbt_zoe_r.stg_events
  group by 1
) t
;
```