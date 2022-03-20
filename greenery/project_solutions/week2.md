# Part 1: Models

## 1. What is our user repeat rate? **0.76**
```
select avg(repeat_customer) as repeat_rate
from dbt_zoe_r.user__fct_orders;
```

## 2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
I think when taking a look at what might be predictive of probability of being a repeat user I’d check out things like, whether the first order was discounted, when the first order was placed, the time between first order and user creation, where the customer ordered from, add to cart behavior and the purchase amount (bucketed).

I'd look at bad user experience, like long delays between order and delivery, or potentailly by product_id to see if there were any problematic products. 

It'd be helpful to have more categorization of product type, user demographic information and more payment details. 

## 3. Why did you organize the models in the way you did?
The idea behind the setup is basically to keep anything that will be broadly used in `core`, and then have basic events-level fct tables and user-aggregation tables in the other marts.

I feel like I didn't have a ton of time to invest into this, but I kept with core/marketing/product for my marts and added a `dim_customers`, `dim_products` and `fct_orders` since this information felt central to product, marketing and a variety of other potential areas. For marketing I added `user__fct_orders` which contains order information aggregated at the customer level, and enriched with customer dimensions. This should faciliate marketing analyses. For product, I added the `int_session_events_agg` from our working session on Wednesday, `fct_sessions_enriched` which builds on the intermedaite table with session length and customer information, and finally `user__fct_sessions` which had session data aggreated at the user level. 


# Part 2: Tests
## 1. What assumptions are you making about each model? 
I feel like you _could_ spend an hour plus on this question and I ran a bit short on time this week. At the bare minimum though, what I assumed and added tests for was that there was a unique, non-null primary key for each table (outside of staging, I didn't go back and add tests to staging). 

## 2. Did you find any “bad” data as you added and ran tests on your models? 
Nope, I think the things I'm testing for would have caused some other obvious errors so I'm not surprised I didn't catch anything. 

## 3. Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
You can just create jobs to refresh models that run daily, the tests will run as well. Looks like you can get kind of fancy with alerting and even send alerts to Slack.

