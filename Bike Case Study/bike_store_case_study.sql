-- Question 1:
/* Emily would like to know how many bikes the shop owns by category. Can you get this for her? Display the category name and the number of
   bikes the shop owns in each category (call this column number_of_bikes ).Show only the categories where the number of bikes is
   greater than 2 .
*/

select category,count(id) as number_of_bikes
from bike
group by category
having count(id) > 2;

-- Question 2:
/*
Emily needs a list of customer names with the total number of memberships purchased by each. For each customer, display the customer's
name and the count of memberships purchased (call this column membership_count ). Sort the results by membership_count , starting 
with the customer who has purchased the highest number of memberships.Keep in mind that some customers may not have purchased
any memberships yet. In such a situation, display 0 for the membership_count .
*/

select c.name,count(m.membership_type_id) as membership_count
from customer c
left join membership m on c.id=m.customer_id
group by c.name
order by membership_count desc;

-- Question 3:
/*Emily is working on a special offer for the winter months. Can you help her prepare a list of new rental prices?

For each bike, display the following:

id
category
old_price_per_hour
new_price_per_hour
old_price_per_day
new_price_per_day

💸 Discount Rules:
-- Electric bikes:
10% discount on hourly rentals
20% discount on daily rentals
-- Mountain bikes:
20% discount on hourly rentals
50% discount on daily rentals
-- All other bikes:
50% discount on both hourly and daily rentals
-- Make sure to round all new prices to 2 decimal places.
*/

select id,category,price_per_hour as old_price_per_hour,
		case when category='electric' then round(price_per_hour*0.9,2)
			 when category='mountain bike' then round(price_per_hour*0.8,2)
			 else round(price_per_hour*0.5,2)
		end as new_price_per_hour,
		price_per_day as old_price_per_day,
		case when category='electric' then round(price_per_day*0.8,2)
			 when category='mountain bike' then round(price_per_day*0.5,2)
			 else round(price_per_day*0.5,2)
		end as new_price_per_day
from bike;
		
-- Question 4:
/*
Emily is looking for counts of the rented bikes and of the available bikes in each category.Display the number of available bikes 
(call this column available_bikes_count) and the number of rented bikes(call this column rented_bikes_count) by bike category.
*/

select category,
		count(case when status='available' then 1 end) as available_bikes_count,
		count(case when status='rented' then 1 end) as rented_bikes_count		
from bike
group by category

-- Question 5:
/*
Emily is preparing a sales report. She needs to know the total revenue from rentals by month, by year, and across all years.

For each row, display the following:

-- year
-- month (use null for yearly totals)
-- revenue
📌 Instructions:

Only include rental revenue (🚫 exclude membership revenue).
Sort the data chronologically:
	Show monthly revenue for each year.
	After listing all months of a year, include the yearly total with month = null.
	At the end, show the all-time total with both year and month as null.
*/
select *from rental;
select extract(year from start_timestamp) as year,extract(month from start_timestamp) as month,sum(total_paid) as revenue
from rental
group by Rollup(year,month)
order by year,month asc

-- Question 6
/*Emily has asked you to get the total revenue from memberships for each combination of year, month, and membership type.

Display the year, the month, the name of the membership type (call this column membership_type_name), and the total revenue 
(call this column total_revenue) for every combination of year, month, and membership type. Sort the results by year, month,
and name of membership type.
*/

select extract(year from m.start_date) as year,extract(month from m.start_date) as month,m1.name as membership_type_name,sum(m.total_paid) as total_revenue
from membership m
join membership_type m1
on m.membership_type_id=m1.id
group by year,month,membership_type_name
order by year,month,membership_type_name;


-- Question 8
/*
Now it's time for the final task.
Emily wants to segment customers based on the number of rentals and see the count of customers in each segment. Use your SQL skills to get this!

Categorize customers based on their rental history as follows:

	Customers who have had more than 10 rentals are categorized as 'more than 10'.
	Customers who have had 5 to 10 rentals (inclusive) are categorized as 'between 5 and 10'.
	Customers who have had fewer than 5 rentals are categorized as 'fewer than 5'.
	
Calculate the number of customers in each category.

Display two columns:
	rental_count_category (the rental count category)
	customer_count (the number of customers in each category)
*/

select *from membership;
with customer_rentals as(
		select customer_id,count(*) as rental_count
		from rental
		group by customer_id
)
select 
		case
			when rental_count>10 then 'more than 10'
			when rental_count between 5 and 10 then 'between 5 and 10'
			else 'fewer than 5'
		end as rental_count_category,count(*) as customer_count
from customer_rentals
group by rental_count_category;





   