--1.1

SELECT
    c.customer_id,
    c.customer_unique_id,
    o.order_id,
    o.order_purchase_timestamp
FROM customers_1 c
LEFT JOIN orders_dataset o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

--1.2


select 
   o.order_id,
   o.order_item_id,
   o.product_id,
   p.product_category_name,
   o.price,
   o.freight_value
from order_items o
  inner join products_dataset p ON o.product_id = p.product_id
ORDER BY order_id,o.order_item_id;


--1.3

SELECT
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp
FROM orders_dataset o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL;


--2.1
select * from customers_1;
SELECT
    o.order_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp,
    COALESCE(t.c2, p.product_category_name) AS product_category_name,
    oi.price AS price_per_item,
    op.payment_type,
    op.payment_value
FROM orders_dataset o
JOIN customers_1 c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products_dataset p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.c1
JOIN order_payments op
    ON o.order_id = op.order_id
ORDER BY o.order_id, oi.order_item_id;

--2.2

SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(op.payment_value), 0) AS total_amount_spent,
    COALESCE(SUM(op.payment_value) / NULLIF(COUNT(DISTINCT o.order_id), 0),0) AS average_order_value
FROM customers_1 c
LEFT JOIN orders_dataset o
    ON c.customer_id = o.customer_id
LEFT JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state
ORDER BY total_amount_spent DESC;

--2.3

SELECT
    s.seller_id,
    s.seller_city,
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS number_of_unique_orders,
    COALESCE(
        SUM(oi.price + oi.freight_value),
        0
    ) AS total_revenue,
    COALESCE(
        SUM(oi.price + oi.freight_value)
        / NULLIF(COUNT(DISTINCT oi.order_id), 0),
        0
    ) AS average_order_value,
    COUNT(DISTINCT oi.product_id) AS number_of_unique_products_sold
FROM sellers_dataset s
LEFT JOIN order_items oi
    ON s.seller_id = oi.seller_id
GROUP BY
    s.seller_id,
    s.seller_city,
    s.seller_state
ORDER BY total_revenue DESC;

--3.1

SELECT
    o.order_id,
    o.order_status,
    SUM(
        COALESCE(oi.price, 0) + COALESCE(oi.freight_value, 0)
    ) AS total_revenue
FROM orders_dataset o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.order_status
ORDER BY total_revenue DESC;


--3.2

SELECT
    customer_id,
    COALESCE(
        'Customer ' || customer_id || ' from ' 
        || COALESCE(customer_city, 'Unknown City') || ', ' 
        || COALESCE(customer_state, 'Unknown State'),
        'Customer ' || customer_id || ' from Unknown City, Unknown State'
    ) AS customer_display_name
FROM customers_1
ORDER BY customer_id;


--3.3

select 
   COALESCE(product_category_name,'Uncategorized') As product_category,
   count(product_id) As Number_of_products,
   AVG(product_weight_g) As avg_product_weight,
   SUM(product_width_cm+product_length_cm+product_height_cm) As avg_product_dimensions
From products_dataset
GROUP BY COALESCE(product_category_name,'Uncategorized')
ORDER BY product_category;

--4.1

SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS order_count,
    COALESCE(SUM(op.payment_value), 0) AS total_revenue,
    COALESCE(SUM(op.payment_value) / NULLIF(COUNT(DISTINCT o.order_id), 0), 0) AS average_order_value,
    COALESCE(MIN(op.payment_value), 0) AS min_order_value,
    COALESCE(MAX(op.payment_value), 0) AS max_order_value
FROM orders_dataset o
LEFT JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY o.order_status
ORDER BY order_count DESC;


--4.2

SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(op.payment_value), 0) AS total_revenue,
    COALESCE(SUM(op.payment_value) / NULLIF(COUNT(DISTINCT o.order_id), 0), 0) AS average_order_value
FROM customers_1 c
JOIN orders_dataset o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY
    c.customer_id,
    c.customer_unique_id,
    c.customer_city
ORDER BY total_revenue DESC
LIMIT 10;

--4.3

SELECT
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    COALESCE(SUM(op.payment_value), 0) AS total_revenue,
    COALESCE(SUM(op.payment_value) / NULLIF(COUNT(DISTINCT o.order_id), 0), 0) AS average_order_value
FROM orders_dataset o
LEFT JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY
    EXTRACT(YEAR FROM o.order_purchase_timestamp),
    EXTRACT(MONTH FROM o.order_purchase_timestamp)
ORDER BY
    year,
    month;


--4.4

SELECT
    COALESCE(t.c2, p.product_category_name) AS category_name,
    COUNT(DISTINCT p.product_id) AS number_of_unique_products,
    COUNT(oi.order_id) AS total_quantity_sold,
    SUM(COALESCE(oi.price, 0) + COALESCE(oi.freight_value, 0)) AS total_revenue,
    AVG(COALESCE(oi.price, 0)) AS average_product_price
FROM products_dataset p
JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.c1
GROUP BY COALESCE(t.c2, p.product_category_name)
HAVING SUM(COALESCE(oi.price, 0) + COALESCE(oi.freight_value, 0)) > 1000
ORDER BY total_revenue DESC;


--4.5

select 
   payment_type,
   count(*) As Number_Of_Payment,
   COALESCE(SUM(payment_value),0) As total_payment_value,
   COALESCE(AVG(payment_value),0) As avarage_payment_value,
   count(DISTINCT(order_id)) As number_of_unique_orders
FROM ORDER_PAYMENTS
GROUP BY payment_type
ORDER BY total_payment_value;




   


