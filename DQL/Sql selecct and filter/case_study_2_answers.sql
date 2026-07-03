-- 1. Retrieve a list of all distinct product categories.
select distinct category
from products;

-- 2. Show all product names in uppercase.
select upper(product_name) from products;

-- 3. Select all customers who have not provided a phone number.
select * from customers
where phone is null;

-- 4. Show the first 5 customers sorted alphabetically by name.
select full_name from customers
order by full_name asc
limit 5;

-- 5. Show the 6th to 10th customers alphabetically.
select full_name from customers
where customer_id between 6 and 10
order by full_name asc;

-- 6. Show products with a price between $5 and $15.
select product_name from products
where price between 5 and 15;

-- 7. List orders and label them as "High" if total_amount > $50, "Medium" if between $20-$50, and "Low" otherwise.
SELECT 
    order_id,
    customer_id,
    total_amount,
    CASE
        WHEN total_amount > 50 THEN 'High'
        WHEN total_amount BETWEEN 20 AND 50 THEN 'Medium'
        ELSE 'Low'
    END AS order_label
FROM orders;

-- 8. Display orders with total_amount NULL, and replace it with 0.
SELECT order_id,
       COALESCE(total_amount, 0) AS total_amount
FROM orders
WHERE total_amount IS NULL;

-- 9. Show full_name and the first word from their name only.
select full_name,split_part(full_name,' ',1)
from customers;

-- 10. Show all orders placed today (assume CURRENT_DATE).
select *from orders
where order_date::date=Current_date;

-- 11. List orders sorted by priority: Delivered > Confirmed > Shipped > Pending.
select * from orders
order by 
	case status
		when 'Delivered' then 1
		when 'Confirmed' then 2
		when 'Shipped' then 3
		when 'Pending' then 4
		else 5
	end;

-- 12. Show current date, and how many days ago each order was placed.
select order_date,current_date,current_date - order_date as days_ago
from orders;

-- 13. Show a list of customers with NULL phone numbers labeled as 'Missing'.
select full_name,coalesce(phone,'Missing') as phone
from customers;

-- 14. List products whose name contains the word 'Pizza'.
select product_name
from products
where product_name like '%Pizza%';

-- 15. Display total number of characters in each product name.
select product_name,length(product_name) as length
from products;

