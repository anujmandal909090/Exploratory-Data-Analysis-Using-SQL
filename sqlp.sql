use prr;
-- Q1. Find the top 3 highest spending customers overall, based on the sum of total_amount
-- from their 'Delivered' orders only. Show customer_id, full name, and total spend.

SELECT o.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
round(SUM(o.total_amount),2) AS total_spent FROM sqlp_orders AS o
JOIN sqlp_customers AS c 
ON c.customer_id = o.customer_id
GROUP BY o.customer_id , c.first_name , c.last_name
ORDER BY total_spent DESC
LIMIT 3;

-- Q2. For every category in products, find the best-selling product (by total quantity sold
-- across all orders). Show category, product_name, and total_quantity_sold. Use a window
-- function.

SELECT *FROM 
(SELECT p.category,
p.product_name,SUM(o.quantity) AS sold_quantity,
DENSE_RANK() OVER (PARTITION BY p.category
ORDER BY SUM(o.quantity) DESC) AS rnk FROM sqlp_products AS p
JOIN sqlp_orders AS o
ON o.product_id = p.product_id
GROUP BY p.category, p.product_name) AS t
WHERE rnk = 1;

-- Q3. List all customers who have never placed a single order.

select c.customer_id, concat(c.first_name," ",c.last_name) as Full_name 
from sqlp_customers as c 
left join sqlp_orders as o 
on c.customer_id = o.customer_id
where o.order_id is null;

-- Q4. Find the month-over-month growth in total revenue (sum of total_amount) for 2024.
-- Show month, revenue, previous_month_revenue, and growth_percent.

with monthy_revenue as ( select month(order_date) as month_, round(sum(total_amount)) as revenue 
from sqlp_orders 
where year(order_date) = "2024"
group by month(order_date))

select month_, revenue, lag(revenue) over(order by month_) as previous_amount,
round((revenue - lag(revenue) over(order by month_))/lag(revenue) over(order by month_)*100,2) 
as persenateg
from monthy_revenue 
order by month_;

-- Q5. For each shop, calculate what percentage of its orders were 'Cancelled' or 'Returned'.
-- Show shop_name, total_orders, problem_orders, and problem_percent, sorted worst-first.

WITH cr AS (
    SELECT 
        shop_id,
        COUNT(order_id) AS cancel_orders
    FROM sqlp_orders
    WHERE order_status IN ('Cancelled', 'Returned')
    GROUP BY shop_id
)

SELECT 
    s.shop_id,
    s.shop_name,
    (c.cancel_orders / COUNT(o.order_id)) * 100 AS percentage
FROM sqlp_shops AS s
LEFT JOIN cr AS c
    ON s.shop_id = c.shop_id
JOIN sqlp_orders AS o
    ON s.shop_id = o.shop_id
GROUP BY s.shop_id, s.shop_name, c.cancel_orders;

-- Q6. Find customers who have ordered from more than 3 different shops. Show customer_id,
-- full name, and count of distinct shops.

select c.customer_id,concat(c.first_name," ",c.last_name) as full_name, 
count(distinct o.shop_id) as shop_id from sqlp_orders as o
join sqlp_customers as c
on o.customer_id = c.customer_id
group by c.customer_id,c.first_name,c.last_name
having shop_id >= 3
order by c.customer_id asc;

-- Q7. Write a query to find the second highest total_amount order placed by each customer
-- (customers with fewer than 2 orders should be excluded).

select * from 
(select customer_id,total_amount, dense_rank() 
over(partition by customer_id order by total_amount desc)
as rnk
 from sqlp_orders) t
where rnk = 2;

-- Q8. Calculate the running (cumulative) total revenue per shop ordered by order_date.

SELECT shop_id, order_date,round(SUM(total_amount)) AS daily_revenue,
round(SUM(SUM(total_amount)) 
OVER (PARTITION BY shop_id ORDER BY order_date)) AS cumulative_revenue
FROM sqlp_orders
GROUP BY shop_id, order_date
ORDER BY shop_id, order_date;

-- Q9. Identify products that have never been ordered at all.

select p.product_id,p.product_name from sqlp_products as p
left join sqlp_orders as o 
on p.product_id = o.product_id
where o.product_id is null;

-- Q10. Find the average order value (total_amount) per loyalty_tier, but only counting
-- customers who signed up before 2023-01-01.

select c.loyalty_tier, round(avg(o.total_amount),2) as Total_amount from sqlp_customers as c
join sqlp_orders as o
on c.customer_id = o.customer_id
where c.signup_date <  '2023-01-01'
group by c.loyalty_tier;

-- Q11. For each customer, find the number of days between their signup_date and their first
-- order_date. Show customer_id, full name, signup_date, first_order_date, and
-- days_to_first_order.

select c.customer_id, concat(c.first_name," ",c.last_name), c.signup_date, 
min(o.order_date) as first_order_date,
datediff(min(o.order_date), c.signup_date) as day_to_first_order
from sqlp_customers as c 
join sqlp_orders as o
on c.customer_id = o.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name,c.signup_date;

-- Q13. classifies every order into a bucket: 'Low' (total_amount < 5000),
-- 'Medium' (5000-20000), 'High' (>20000)

select order_id,total_amount,
case 
when total_amount < 5000 then "Low"
when total_amount <= 20000 then "Median"
else "High"
end as classify 
from sqlp_orders ;

-- Q14. Find the top-performing shop (by total revenue) in each state. Show state, shop_name,
-- and revenue. 

select * from
(select s.shop_name,s.state, round(sum(o.total_amount),2) as total_amount, 
dense_rank() over(partition by s.state 
order by sum(o.total_amount) desc) as rnk 
from sqlp_shops as s 
join sqlp_orders as o
on s.shop_id = o.shop_id
group by s.shop_name, s.state) t
where rnk = 1;

-- Q16. Find customers whose total spend is above the overall average customer spend (only
-- counting customers who have at least one order).

select customer_id, round(sum(total_amount),2) as total_amount from sqlp_orders
group by customer_id 
having sum(total_amount) > (select round(avg(total_amount),2) as average from sqlp_orders) 
and count(order_id) >= 1
order by customer_id asc;

-- Q17. For each shop_type, find the shop with the highest number of 'Delivered' orders and
-- the shop with the lowest, in the same result set.

select * from
(select s.shop_type, s.shop_id, count(o.order_id) as order_delivered ,
dense_rank() over(partition by s.shop_type 
order by count(o.order_id) asc) as lowest_rnk,
dense_rank() over(partition by s.shop_type 
order by count(o.order_id) desc) as highest_rnk
from sqlp_shops as s 
join sqlp_orders as o
on s.shop_id = o.shop_id
where o.order_status = "Delivered"
group by s.shop_id,s.shop_type) t
where highest_rnk = 1 or lowest_rnk = 1;

-- Q18. Write a query to detect customers who placed more than one order on the exact same
-- order_date (possible duplicate/batch orders). Show customer_id, order_date, and number of
-- orders that day.

select customer_id, count(order_id)  , order_date from sqlp_orders
group by order_date, customer_id
having count(order_id) >= 2;

-- Q19. Find the three-month moving average of order count for each shop (based on
-- order_date month).

with monthly_orders as (select shop_id,
month(order_date) as month_,
count(order_id) as total_orders
from sqlp_orders 
group by shop_id, month(order_date))

select shop_id,month_,total_orders,round(avg(total_orders) over(partition by shop_id
order by month_ rows between 2 preceding and current row),2) as three_month_moving_avg

from monthly_orders
order by shop_id, month_;
-- Q20. For every product category, compute what percentage of total company revenue it
-- contributes, and show only categories contributing more than 10%.

with total_amt as ( select p.category , round(sum(o.total_amount)) as total_value
from sqlp_orders as o
join sqlp_products as p 
on o.product_id = p.product_id 
group by p.category) 

select category,total_value, 
round(total_value/(select sum(total_amount) from sqlp_orders)*100,2) as persenatge
from total_amt
where round(total_value/(select sum(total_amount) from sqlp_orders)*100,2) > 10;


-- Q21. Find customers who bought products from every single category available in the
-- products table (i.e., 'category completionists').

select o.customer_id from sqlp_orders as o
join sqlp_products as p
on o.product_id = p.product_id
group by customer_id 
having count(distinct p.category) = 
(select count(distinct category) from sqlp_products);

-- Q22. Write a query showing, for each shop, the busiest day of week (Mon/Tue/...) by number
-- of orders placed.

select * from
(select s.shop_id,s.shop_name, dayname(o.order_date) as day_name,count(o.order_id),
rank() over(partition by s.shop_id order by count(o.order_id) desc) as rnk 
from sqlp_orders as o 
join sqlp_shops as s
on o.shop_id = s.shop_id 
group by day_name, s.shop_id,s.shop_name) as t
where rnk = 1;

-- Q23. Find the customer(s) with the longest gap (in days) between two consecutive orders.

select customer_id, max(gap) as max_gap from
(select customer_id ,datediff(order_date , lag(order_date) 
over(partition by customer_id order by order_date)) as gap
from sqlp_orders) as t
group by customer_id
order by max_gap desc
limit 10;

-- Q24. Create a query that returns each shop's revenue rank overall, revenue rank within its
-- own state, and the difference between the two ranks in one result set.

with s_table as (select s.shop_id,s.state ,round(sum(o.total_amount),2) as s_amount ,
dense_rank() over(partition by s.state order by sum(o.total_amount) desc) as s_rnk 
from sqlp_orders as o 
join sqlp_shops as s
on o.shop_id = s.shop_id
group by s.shop_id, s.state),

table_ as (select s.shop_id, round(sum(o.total_amount),2) as amount,
dense_rank() over(order by sum(o.total_amount) desc) as rnk
from sqlp_orders as o
join sqlp_shops as s
on o.shop_id = s.shop_id
group by shop_id)

select table_.shop_id as shop_id , table_.rnk as overall_rank, 
s_table.s_rnk as state_rank ,table_.rnk - s_table.s_rnk as difference from table_ 
join s_table 
on table_.shop_id = s_table.shop_id
order by table_.shop_id asc;

-- Q25. Build a full customer summary report: customer_id, full name, loyalty_tier, total
-- number of orders, total spend, average order value, favorite category (most frequently
-- ordered), and most-used payment_method — all in a single query

with fav_cat as (select * from 
(select o.customer_id , count(o.order_id) as order_count, p.category,
row_number() over(partition by o.customer_id order by count(o.order_id) desc) as rnk 
from sqlp_orders as o
join sqlp_products as p
on o.product_id = p.product_id
group by o.customer_id,p.category) as t
where rnk = 1),

 fav_pay as (select * from 
(select customer_id , count(order_id) as order_count, payment_method,
row_number() over(partition by customer_id order by count(order_id) desc) as rnk 
from sqlp_orders
group by customer_id,payment_method) as t
where rnk = 1)

select o.customer_id,concat(c.first_name," ",c.last_name) as full_name, 
c.loyalty_tier,count(o.order_id) as total_order ,round(sum(o.total_amount)),
 round(avg(o.total_amount)) as avg_value,f.category,p.payment_method 
 from sqlp_orders as o
join sqlp_customers as c
on o.customer_id = c.customer_id
join fav_cat as f
on f.customer_id = o.customer_id
join fav_pay as p
on p.customer_id = o.customer_id
group by o.customer_id ,
c.first_name,
c.last_name,
c.loyalty_tier,
f.category,
p.payment_method
order by o.customer_id;


 