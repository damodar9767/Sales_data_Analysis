select * from sales_analytics_5000.ecommerce_sales_analytics_5000;

describe ecommerce_sales_analytics_5000 ;

create table  ecommerce_staging like ecommerce_sales_analytics_5000;
select * from ecommerce_staging;
insert ecommerce_staging select * from ecommerce_sales_analytics_5000;
select * from ecommerce_staging ;

-- Data Integrity checks 
-- checking if revenue matches the amount - the data 
select revenue,round(unit_price * quantity * (1 - discount),2) as calculated_revenue,
		abs(round(revenue - (unit_price * quantity * (1 - discount)),2))  as descreperency from ecommerce_staging 
        where abs(revenue - (unit_price * quantity * (1 - discount)) ) > 0.01;
        
-- checking for null , 
SELECT
  COUNT(*) AS total_rows,
  COUNT(order_id) AS order_id_count,
  COUNT(customer_id) AS customer_id_count,
  COUNT(product_category) AS category_count,
  COUNT(region) AS region_count,
  COUNT(unit_price) AS unit_price_count,
  COUNT(discount) AS discount_count,
  COUNT(delivery_days) AS delivery_days_count,
  COUNT(customer_rating) AS rating_count
FROM ecommerce_staging;

-- checking for duplicate
select order_id , count(*) from ecommerce_sales_analytics_5000 group by order_id having count(*) >1 ; 


-- checking outlier/invalid 
SELECT *
FROM ecommerce_staging
WHERE quantity <= 0
   OR unit_price <= 0
   OR discount NOT BETWEEN 0 AND 1
   OR customer_rating NOT BETWEEN 1 AND 5
   OR delivery_days < 0;
   
   
-- converting date  from text to date format 
SELECT 
    order_date AS text_date,
    STR_TO_DATE(order_date, '%c/%e/%Y') AS converted_date
FROM ecommerce_staging;

UPDATE ecommerce_staging 
SET order_date = STR_TO_DATE(order_date, '%c/%e/%Y');

ALTER TABLE ecommerce_staging 
MODIFY COLUMN order_date DATE;




