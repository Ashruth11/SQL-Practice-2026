-- 1. Show customer names along with their order IDs. (Hint: Use orders and customers)
select c.full_name,o.order_id
from customers c
inner join orders o
on c.customer_id=o.customer_id;

-- 2. List the names of products and their prices that have been ordered. (Hint: Use products and order_items)
select p.product_name,o.unit_price
from products p
inner join order_items o
on p.product_id=o.product_id;

-- 3. Show each customer's name and the total amount of their order. Include customers even if they haven't placed an order. (Hint: Use customers and orders)
select c.full_name,sum(o.total_amount)
from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.full_name;

-- 4. Show all products and whether they have been ordered. (Hint: Use LEFT JOIN between products and order_items)
select p.product_name,o.order_id
from products p
left join order_items o
on p.product_id=o.product_id;

-- 5. Show a list of all customers and orders. Include customers with no orders and orders with missing customer information. (Hint: Use FULL OUTER JOIN)
select c.customer_id,c.full_name,o.order_id,o.order_date
from customers c
full outer join orders o
on c.customer_id=o.customer_id;

-- 6. List all products and orders. Include products never ordered and orders with missing products. (Hint: Use FULL OUTER JOIN)
select p.product_name,o.order_id
from products p
full outer join order_items o
on p.product_id=o.product_id;

-- 7. Show customers who share the same phone number. (Hint: SELF JOIN on customers table)
SELECT c1.full_name AS customer1, c2.full_name AS customer2, c1.phone
FROM customers c1
INNER JOIN customers c2 
ON c1.phone = c2.phone AND c1.customer_id <> c2.customer_id;

-- 8. Show order IDs along with the full name of the customer and the order status. (Hint: Use orders and customers)
select o.order_id,c.full_name,o.status
from orders o
inner join customers c
on c.customer_id=o.customer_id;

-- 9. List all products ordered in each order. Show order_id and product_name. (Hint: Use order_items and products)
select o.order_id,p.product_name as items
from products p
join order_items o
on p.product_id=o.product_id;


-- Bonus question - grouped items into single order_id
select o.order_id,String_Agg(p.product_name,', ') as items
from products p
join order_items o
on p.product_id=o.product_id
group by order_id;

-- 10. Display all order items with product name, quantity, and unit_price. (Hint: Use order_items and products)
select p.product_name,o.quantity,o.unit_price
from products p
join order_items o
on p.product_id=o.product_id;

-- 11. Show all customers who have placed an order, along with their email. (Hint: Use DISTINCT if needed)
select distinct c.full_name,c.email
from customers c
join orders o
on c.customer_id=o.customer_id
order by c.full_name asc;

-- 12. List all orders that include "Pizza" in the product name. Show order_id and product_name.
select o.order_id,p.product_name
from order_items o
join products p
on o.product_id=p.product_id
where p.product_name like '%Pizza%';

-- 13. Show all orders with their customer's full name, product name, and quantity. (Hint: Use three tables!)
select o.order_id,c.full_name,p.product_name,o.quantity
from customers c
join orders o1 on o1.customer_id=c.customer_id
join order_items o on o.order_id=o1.order_id
join products p on p.product_id=o.product_id;

-- 14. Bonus: Show all products that have **never** been ordered. (Hint: LEFT JOIN and IS NULL)
select p.product_name,o.order_id
from products p
left join order_items o
on p.product_id=o.product_id
where o.order_id is null;





