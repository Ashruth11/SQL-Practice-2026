-- Q1
select full_name,email from customers;

-- Q2
select product_name as Item,price as Cost from products;

-- Q3
select * from products where category='Beverages';

-- Q4
select * from products where price>5;

-- Q5
select *from orders where total_amount>=10;

-- Q6
select * from customers where phone is null;

-- Q7
select *from products where price between 3 and 6;

-- Q8
select *from products
where product_name in ('French Fries', 'Veg Burger','Margherita Pizza');

-- Q9
select * from customers
where full_name like 'A%';

-- Q10
select distinct c.*
from customers c
inner join orders o
on c.customer_id=o.customer_id;

-- Q11
select * from orders
where status!='Delivered';

-- Q12
select *from products
where price not between 4 and 6;

-- Q13
select * from products
where category not in ('Main Course', 'Snacks','Beverages');

-- Q14
select *from customers
where full_name not like 'S%';

-- Q15
select order_item_id,(quantity * unit_price) as total_price
from order_items;

-- Q16
select product_name from products
order by price desc
limit 10;

-- Q17
select full_name from customers
order by full_name asc;

-- Q18
select full_name from customers
order by created_at desc
limit 5;

-- Q19
select product_name from products
order by random()
limit 3;



