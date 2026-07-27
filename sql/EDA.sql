-- EDA 
use sales_analytics_5000;

select * from ecommerce_staging;

-- monthly trends by revenue
SELECT
  month(order_date) as Month_of_year ,
  round(SUM(revenue),2) AS total_revenue,
  COUNT(order_id) AS total_orders
FROM ecommerce_staging
GROUP BY 1
ORDER BY 1;

-- Revenue by category

select 	
	product_category ,
    round(SUM(revenue),2) AS total_revenue,
	COUNT(order_id) AS total_orders,
    round(avg(revenue),2) as avg_order_value
from ecommerce_staging
group by product_category
order by 2 desc ;

-- Revenue by region
select 	
	region ,
    round(SUM(revenue),2) AS total_revenue,
	COUNT(order_id) AS total_orders,
    round(avg(revenue),2) as avg_order_value
from ecommerce_staging
group by region
order by 2 desc ;

-- Revenue by payment_method
select 	
	payment_method ,
    round(SUM(revenue),2) AS total_revenue,
	COUNT(order_id) AS total_orders,
    round(avg(revenue),2) as avg_order_value
from ecommerce_staging
group by payment_method
order by 2 desc ;


-- Discount impact on quantity and rating
SELECT
  CASE
    WHEN discount = 0 THEN '0%'
    WHEN discount <= 0.1 THEN '1-10%'
    WHEN discount <= 0.2 THEN '11-20%'
    WHEN discount <= 0.3 THEN '21-30%'
    ELSE '30%+'
  END AS discount_bucket,
  COUNT(*) AS num_orders,
  ROUND(AVG(quantity), 2) AS avg_quantity,
  ROUND(AVG(customer_rating), 2) AS avg_rating
FROM ecommerce_staging
GROUP BY 1
ORDER BY 1;

-- Delivery speed vs rating
SELECT
  CASE
    WHEN delivery_days <= 3 THEN 'Fast (0-3 days)'
    WHEN delivery_days <= 7 THEN 'Medium (4-7 days)'
    ELSE 'Slow (8+ days)'
  END AS delivery_bucket,
  COUNT(*) AS num_orders,
  ROUND(AVG(customer_rating), 2) AS avg_rating
FROM ecommerce_staging
GROUP BY 1
ORDER BY 1;


-- Top customers by spend
SELECT
  customer_id,
  COUNT(order_id) AS num_orders,
  round(SUM(revenue),2) AS total_spend,
  ROUND(AVG(customer_rating), 2) AS avg_rating
FROM ecommerce_staging
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 10;



