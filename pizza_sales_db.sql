select *
from pizza_sales;
select count(pizza_id)
from pizza_sales;
-- KPI
-- Total Revenue
select round(sum(total_price)) as Total_Revenue
from pizza_sales;
-- Average order value
select sum(total_price) / count(distinct order_id) as Average_order_value
from pizza_sales;
-- Total pizza sold
select sum(quantity) as Total_pizza_sold
from pizza_sales;
-- Total orders
select count(distinct order_id) as Total_orders
from pizza_sales;
-- Average pizzas per order 
select cast(
        cast(sum(quantity) as decimal(10, 2)) / cast(count(distinct order_id) as decimal(10, 2)) as decimal (10, 2)
    ) as average_pizzas_per_order
from pizza_sales;
-- Problem statement
-- Daily trend for order 
select to_char(order_date, 'Day name') as order_day,
    count(distinct order_id) as Total_orders
from pizza_sales
group by to_char(order_date, 'Day name');
-- Hourly trend from order 
select EXTRACT(
        HOUR
        FROM order_time
    ) as order_hours,
    count(distinct order_id) as Total_orders
from pizza_sales
group by EXTRACT(
        HOUR
        FROM order_time
    )
order by count(distinct order_id) desc;
-- percentage of sales by pizza category 
select pizza_category,
    sum(total_price) as Total_sales,
    sum(total_price) * 100 / (
        select sum(total_price)
        from pizza_sales
        where EXTRACT(
                MONTH
                FROM order_date
            ) = 1
    ) as total_percentage_of_sales
from pizza_sales
where EXTRACT(
        MONTH
        FROM order_date
    ) = 1
Group by pizza_category
order by sum(total_price) desc;
select pizza_size,
    cast(sum(total_price) as decimal(10, 2)) as Total_sales,
    cast(
        sum(total_price) * 100 / (
            select sum(total_price)
            from pizza_sales
        ) as decimal(10, 2)
    ) as PTA
from pizza_sales
Group by pizza_size
order by PTA desc;
-- Total pizza sold 
select pizza_category,
    sum(quantity) as Total_pizza_sold
from pizza_sales
group by pizza_category
order by Total_pizza_sold DESC;
-- top 5 best sellers 
select pizza_name_id,
    sum(quantity) as total_sales
from pizza_sales
group by pizza_name_id
order by total_sales DESC
limit 5;
-- top 5 worst sellers
select pizza_name_id,
    sum(quantity) as total_sales
from pizza_sales
group by pizza_name_id
order by total_sales
limit 5;