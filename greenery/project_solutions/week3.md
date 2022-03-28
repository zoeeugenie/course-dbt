## Part 1: Conversion Rates

1. What is our overall conversion rate? **62.46%**

```
select *
from dbt_zoe_r.metric__global_conversion_rates
;
```

2. What is our conversion rate by product?
| product_name        | conversion_rate |
|---------------------|-----------------|
| String of pearls    | 0.6094          |
| Arrow Head          | 0.5556          |
| Cactus              | 0.5455          |
| ZZ Plant            | 0.5397          |
| Bamboo              | 0.5373          |
| Rubber Plant        | 0.5185          |
| Monstera            | 0.5102          |
| Calathea Makoyana   | 0.5094          |
| Fiddle Leaf Fig     | 0.5             |
| Majesty Palm        | 0.4925          |
| Aloe Vera           | 0.4923          |
| Devil's Ivy         | 0.4889          |
| Philodendron        | 0.4839          |
| Jade Plant          | 0.4783          |
| Pilea Peperomioides | 0.4746          |
| Spider Plant        | 0.4746          |
| Dragon Tree         | 0.4677          |
| Money Tree          | 0.4643          |
| Orchid              | 0.4533          |
| Bird of Paradise    | 0.45            |
| Ficus               | 0.4265          |
| Birds Nest Fern     | 0.4231          |
| Pink Anthurium      | 0.4189          |
| Boston Fern         | 0.4127          |
| Alocasia Polly      | 0.4118          |
| Peace Lily          | 0.4091          |
| Ponytail Palm       | 0.4             |
| Snake Plant         | 0.3973          |
| Angel Wings Begonia | 0.3934          |
| Pothos              | 0.3443          |


```
select product_name, conversion_rate
from dbt_zoe_r.metric__product_conversion_rates
order by 2 desc ; 
```

_Why might some products have higher conversion rates?_ Could be a huge number of things, but off the top of my head: inherently better quality, better value or higher demand, faster shipping, better placement on the website, better showcasing on the site (like photography etc).

## Part 2: Making a macro
Most really useful macros appear to already exist in dbt packgaes, which is great! I think in "real life" I'd probably use custom macros for unique business logic, like custom bucketing or fiscal year adjustments when it doesn't match the calendar year. 

Just for playing around I added a macro that checks if values are between [0,1] but ultimately when adding tests on conversion rate metrics, I just went with a built in macro.

## Part 3: Hooks
Added the grant role hook to `dbt_project.yml`

## Part 4: Packages
I already install `dbt_utils` but added `dbt_great_expectations`.
