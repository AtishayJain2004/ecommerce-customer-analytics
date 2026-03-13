Create database ECommerceAnalytics 

-- Cleaning Table (Category_translation)--
delete from category_translation
where product_category_name='product_category_name'

select top 10 * from
category_translation

-- Data Inspection --

select count(*) as customers from customers
select count(*) as orders from orders
select count(*) as order_items from order_items
select count(*) as order_payments from order_payments
select count(*) as products from products
select count(*) as sellers from sellers
select count(*) as category_translation from category_translation

-- checking the total number of cancelled orders --

select order_status, count(*)
from orders
group by order_status

-- Creating a Master Sales Table --

select
	o.order_id,
	o.order_purchase_timestamp,
	c.customer_id,
	c.customer_city,
	c.customer_state,
	oi.product_id,
	oi.price,
	oi.freight_value,
	p.product_category_name,
	ct.product_category_name_english
into master_sales
from orders o
join customers c
on o.customer_id = c.customer_id
join order_items oi
on o.order_id = oi.order_id
join products p 
on oi.product_id = p.product_id
left join category_translation ct
on p.product_category_name = ct.product_category_name
where o.order_status = 'delivered' 

select count(*) as total_count from master_sales 

select top 10 * from master_sales 

-- calculating total revenue --
select
sum(price) as total_revenue
from master_sales

-- monthly sales trend -- 
select
YEAR (order_purchase_timestamp) as order_year,
MONTH (order_purchase_timestamp) as order_month,
sum (price) as monthly_revenue,
count(order_id) as total_orders
from master_sales
group by 
YEAR (order_purchase_timestamp), 
MONTH (order_purchase_timestamp) 
order by
order_year,
order_month

-- Top Selling Product Categories --

Select
product_category_name_english,
count(*) as total_items_sold,
sum(price) as total_revenue
from master_sales
group by product_category_name_english
order by total_revenue desc

-- Top 5 Customer Cities --

select
customer_city,
count(order_id) as total_orders,
sum(price) as total_revenue
from master_sales
group by customer_city
order by total_revenue desc

-- Average Order Value --

Select
sum(price) / count(distinct order_id)
as avg_order_value
from master_sales

-- Identyfying Repeat Customers --

Select
customer_id,
count( distinct order_id) as total_orders
from master_sales
group by customer_id
order by total_orders desc

-- repeat customers vs one-time buyers --
Select
case
when order_count = 1 then 'One-Time Customer'
else 'Repeat Customer'
end as customer_type,
count(*) as number_of_customers
from(
	select
	customer_id,
	count(distinct order_id) as order_count
	from master_sales
	group by customer_id
) t
group by
case
when order_count = 1 then 'One-Time Customer'
else 'Repeat Customer'
end

-- Top Spending Customers --
select top 10
customer_id,
sum(price) as total_spent
from master_sales
group by customer_id
order by total_spent desc

-- Most Expensive Products sold --

select top 10
product_id,
sum(price) as total_revenue
from master_sales
group by product_id
order by total_revenue desc

-- RFM Analysis --

select max(order_purchase_timestamp)
as latest_date
from master_sales 
--creating RFM Table--
select
	customer_id,

	datediff(
		day,
		max(order_purchase_timestamp),
		(select max(order_purchase_timestamp) from master_sales))as recency,
		count(distinct order_id) as frequency,
		sum(price) as monetary

into rfm_table

from master_sales 
group by customer_id 

--checking Metrics--

--1--

select count(*) from rfm_table

--2--

select top 10 * from rfm_table

--3--

select top 10 * from rfm_table order by monetary desc

--4--

select top 10 * from rfm_table order by recency desc

-- Creating RFM Scores --

select
	customer_id,
	recency,
	frequency,
	monetary,

	ntile(5) over (order by recency desc) as r_score,
	ntile(5) over (order by frequency asc) as f_score,
	ntile(5) over (order by monetary asc) as m_score

into rfm_scores
from rfm_table

-- RFM Scores --

select top 10 * from rfm_scores

-- creating combined RFM Scores --

select
customer_id,
recency,
frequency,
monetary,
r_score,
f_score,
m_score,

cast(r_score as varchar) +
cast(f_score as varchar) +
cast(m_score as varchar) as rfm_segment

from rfm_scores 

select count(*) from rfm_scores

-- Creating Customer Segments --

select
customer_id,
recency,
frequency,
monetary,
r_score,
f_score,
m_score,

case
	when r_score >= 4 and f_score >= 4 and m_score >= 4 then 'Champions'
	when r_score >= 3 and f_score >= 4 then 'Loyal Customers'
	when r_score >= 4and f_score <= 2 then 'New Customers'
	when r_score <= 2 and f_score >= 3 then 'At Risk'
	else 'Others'
end as customer_segment

into rfm_segments

from rfm_scores 

-- Checking Segments --

select top 20 * from rfm_segments 

-- counting customers in each segment --

select
customer_segment,
count(*) as total_customers
from rfm_segments
group by customer_segment
order by total_customers desc


