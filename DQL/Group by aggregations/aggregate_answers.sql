-- Q1. Find the total number of orders for each status.
select status,count(order_id) as total_orders
from orders
group by status;

-- Q2. What is the average order value for each order status?
select status,round(avg(total_amount),2)
from orders
group by status;

-- Q3. Find the total revenue generated on each order date.
select order_date,sum(total_amount)
from orders
group by order_date;

-- Q4. What is the highest, lowest, and average order amount across all orders?
select max(total_amount),min(total_amount),avg(total_amount)
from orders;

-- Q5. How many products are available in each category?
select category,count(*)
from products
group by category;

-- Q6. What is the average price of products in each category?
select category,round(avg(price),2) as avg_price
from products
group by category;

-- Q7. Find the highest and lowest price among all products.
select max(price),min(price)
from products;

-- Q8. How many units of each product_id were sold (based on order_items)?
SELECT product_id, SUM(quantity) AS total_quantity
FROM order_items
GROUP BY product_id;


-- Q9. What is the average unit price for each product_id in order_items?
select product_id,round(avg(unit_price),2) as avg_unit_price
from order_items
group by product_id;

-- Q10. How many times was each product_id ordered (count of appearances in order_items)?
select product_id,count(*) as times_ordered
from order_items
group by product_id;

