-- Bussiness Insights 

-- Running total of revenue over time
SELECT
  order_date,
  revenue,
  round(SUM(revenue) OVER (ORDER BY order_date),2) AS running_revenue
FROM ecommerce_staging
ORDER BY order_date;

-- Month-over-month revenue change
with monthly as (
select month(order_date) as `month`,
		round(sum(revenue),2) as total_revenue
from ecommerce_staging
group by 1
),

monthly1 as (select *, lag(total_revenue) over( order by month) as prev_month_revenue from monthly)

select * , round(((total_revenue - prev_month_revenue) / nullif(prev_month_revenue,0) *100 ),2) as pct_change from monthly1 order by 1;

-- Rank top 10 customers by spend within each region
with spendrank as(SELECT
  region,
  customer_id,
  round(SUM(revenue),2) AS total_spend,
  RANK() OVER (PARTITION BY region ORDER BY SUM(revenue) DESC) AS spend_rank
FROM ecommerce_staging
GROUP BY region, customer_id
ORDER BY region, spend_rank)

select * from spendrank where spend_rank < 11 ;

-- Category share of total revenue 
SELECT
  product_category,
  round(SUM(revenue),2) AS category_revenue,
  ROUND(
    SUM(revenue) * 100.0 / SUM(SUM(revenue)) OVER (), 2
  ) AS pct_of_total_revenue
FROM ecommerce_staging
GROUP BY product_category
ORDER BY category_revenue DESC;

