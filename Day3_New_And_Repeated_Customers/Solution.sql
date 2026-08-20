USE SQL100Days;

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);


-- order_date, new_customer_count, repeat_customer_count

WITH first_visit AS(SELECT customer_id,
       min(order_date) AS first_visist_date
FROM customer_orders
GROUP BY customer_id)
,count_customers AS(
SELECT co.order_id,co.order_date,fv.customer_id,
       CASE WHEN order_date = first_visist_date THEN 1 ELSE 0 END AS new_customer,
       CASE WHEN order_date <> first_visist_date THEN 1 ELSE 0 END AS repeat_customer

FROM
    customer_orders co
INNER JOIN
        first_visit fv
ON
    co.customer_id = fv.customer_id)
SELECT
    order_date,
    SUM(new_customer) AS new_customer ,
    SUM(repeat_customer) AS repeated_customer
FROM count_customers
GROUP BY order_date;



-- First finding the 1st order date from of the customer
-- If that is not qual to first order date then it is a repeated order
-- Group by date and sum of orders


WITH first_visit AS(
    SELECT customer_id, min(order_date) AS first_visist_date
FROM customer_orders
GROUP BY customer_id)
SELECT
    co.order_date,
    SUM( CASE WHEN order_date = first_visist_date THEN 1 ELSE 0 END ) AS new_customer,
    SUM(CASE WHEN order_date <> first_visist_date THEN 1 ELSE 0 END) AS repeat_customer
FROM customer_orders co INNER JOIN first_visit fv ON co.customer_id = fv.customer_id
GROUP BY co.order_date;