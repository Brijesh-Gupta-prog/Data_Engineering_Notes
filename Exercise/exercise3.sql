use exercise1;
--6.1

select * from customers_1;
select * from orders_dataset;
select * from order_items;

WITH order_revenue AS (
    
    SELECT
        oi.order_id,
        SUM(oi.price + oi.freight_value) AS order_revenue
    FROM order_items oi
    GROUP BY oi.order_id
),

customer_orders AS (
    
    SELECT
        o.customer_id,
        c.customer_city,
        o.order_id,
        o.order_purchase_timestamp::DATE AS order_date,
        r.order_revenue
    FROM orders_dataset o
    INNER JOIN customers_1 c 
        ON o.customer_id = c.customer_id
    INNER JOIN order_revenue r 
        ON o.order_id = r.order_id
    WHERE o.order_status = 'delivered'
),

customer_lifetime AS (
    
    SELECT
        customer_id,
        customer_city,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(order_revenue) AS total_revenue,
        AVG(order_revenue) AS average_order_value
    FROM customer_orders
    GROUP BY customer_id, customer_city
)

SELECT
    customer_id,
    customer_city,
    first_order_date,
    last_order_date,
    total_orders,
    total_revenue,
    average_order_value,
    DATEDIFF(
        day,
        first_order_date,
        last_order_date
    ) AS customer_tenure_days
FROM customer_lifetime
ORDER BY total_revenue DESC;

   
--6.2

WITH order_payments_total AS (
    
    SELECT
        op.order_id,
        SUM(op.payment_value) AS total_payment_value
    FROM order_payments op
    GROUP BY op.order_id
),
order_details AS (
    
    SELECT
        o.order_id,
        o.customer_id,
        CAST(o.order_purchase_timestamp AS DATE) AS order_date,
        opt.total_payment_value
    FROM orders_dataset o
    INNER JOIN order_payments_total opt
        ON o.order_id = opt.order_id
),
duplicate_orders AS (
    
    SELECT
        customer_id,
        order_date,
        total_payment_value,
        COUNT(*) AS duplicate_count
    FROM order_details
    GROUP BY customer_id, order_date, total_payment_value
    HAVING COUNT(*) > 1
)

SELECT
    od.customer_id,
    od.order_date,
    od.total_payment_value,
    LISTAGG(od.order_id, ', ') 
        WITHIN GROUP (ORDER BY od.order_id) AS order_ids,
    d.duplicate_count
FROM order_details od
INNER JOIN duplicate_orders d
    ON od.customer_id = d.customer_id
   AND od.order_date = d.order_date
   AND od.total_payment_value = d.total_payment_value
GROUP BY
    od.customer_id,
    od.order_date,
    od.total_payment_value,
    d.duplicate_count
ORDER BY
    d.duplicate_count DESC,
    od.order_date;


--6.4

with customer_metrics AS (
 select 
   c.customer_id,
   COUNT(DISTINCT o.order_id) AS total_orders,
   COALESCE(SUM(op.payment_value),0) AS total_revenue,
   COALESCE(SUM(op.payment_value)/NULLIF(COUNT(DISTINCT o.order_id),0),0) AS average_order_value,
   MAX(o.order_purchase_timestamp) AS last_order_date
   FROM customers_1 c
   LEFT JOIN orders_dataset o on c.customer_id = o.customer_id
   LEFT JOIN order_payments op on o.order_id = op.order_id
   GROUP BY c.customer_id
)
select 
    customer_id,
    total_orders,
    total_revenue,
    average_order_value,
    DATEDIFF(day,last_order_date,current_date()) AS date_since_last_order,
    CASE
       WHEN total_revenue>=1000 THEN 'VIP'
       WHEN total_revenue>=500 THEN 'Regular'
       ELSE 'Casual'
    END AS customer_segment,
    CASE
        WHEN last_order_date IS NULL THEN 'Churned'
        WHEN DATEDIFF(day, last_order_date, CURRENT_DATE) <= 30 THEN 'Active'
        WHEN DATEDIFF(day, last_order_date, CURRENT_DATE) <= 90 THEN 'At Risk'
        ELSE 'Churned'
    END AS recency_status
    FROM customer_metrics
ORDER BY total_revenue DESC;

--7.1

WITH order_times AS (
    SELECT
        order_id,
        order_status,
        DATEDIFF(day, order_purchase_timestamp, order_approved_at)
            AS days_to_approval,

        DATEDIFF(day, order_approved_at, order_delivered_carrier_date)
            AS days_to_carrier,

        DATEDIFF(day, order_delivered_carrier_date, order_delivered_customer_date)
            AS days_to_customer,

        DATEDIFF(day, order_purchase_timestamp, order_delivered_customer_date)
            AS total_delivery_time,
        CASE
            WHEN order_delivered_customer_date IS NOT NULL
             AND order_estimated_delivery_date IS NOT NULL
             AND order_delivered_customer_date <= order_estimated_delivery_date
                THEN 1
            ELSE 0
        END AS on_time_flag
    FROM orders_dataset
)

SELECT
    order_status,
    COUNT(order_id) AS number_of_orders,

    AVG(days_to_approval) AS avg_days_to_approval,
    AVG(days_to_carrier) AS avg_days_to_carrier,
    AVG(days_to_customer) AS avg_days_to_customer,
    AVG(total_delivery_time) AS avg_total_delivery_time,
    ROUND(
        100.0 * SUM(on_time_flag) / NULLIF(COUNT(order_id), 0),
        2
    ) AS on_time_delivery_rate
FROM order_times
GROUP BY order_status
ORDER BY number_of_orders DESC;

--7.2

WITH review_metrics AS (
    SELECT
        r.review_score,
        o.order_id,
        SUM(COALESCE(op.payment_value, 0)) AS order_total
    FROM order_reviews r
    JOIN orders_dataset o
        ON r.order_id = o.order_id
    LEFT JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY r.review_score, o.order_id
)

SELECT
    review_score,
    COUNT(order_id) AS number_of_reviews,
    ROUND(AVG(order_total), 2) AS average_order_value,
    SUM(order_total) AS total_revenue,
    ROUND(100.0 * COUNT(order_id) / SUM(COUNT(order_id)) OVER (), 2) AS percentage_of_total_reviews
FROM review_metrics
GROUP BY review_score
ORDER BY review_score;

--8.1

SELECT
    'orders' AS table_name,
    'customer_id' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(customer_id) AS null_count,
    ROUND(100.0 * (COUNT(*) - COUNT(customer_id)) / COUNT(*), 2) AS null_percentage,
    CASE
        WHEN ROUND(100.0 * (COUNT(*) - COUNT(customer_id)) / COUNT(*), 2) < 5 THEN 'PASS'
        WHEN ROUND(100.0 * (COUNT(*) - COUNT(customer_id)) / COUNT(*), 2) <= 10 THEN 'WARNING'
        ELSE 'FAIL'
    END AS data_quality_status
FROM orders_dataset

UNION ALL

SELECT
    'order_items' AS table_name,
    'product_id' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(product_id) AS null_count,
    ROUND(100.0 * (COUNT(*) - COUNT(product_id)) / COUNT(*), 2) AS null_percentage,
    CASE
        WHEN ROUND(100.0 * (COUNT(*) - COUNT(product_id)) / COUNT(*), 2) < 5 THEN 'PASS'
        WHEN ROUND(100.0 * (COUNT(*) - COUNT(product_id)) / COUNT(*), 2) <= 10 THEN 'WARNING'
        ELSE 'FAIL'
    END AS data_quality_status
FROM order_items

UNION ALL

SELECT
    'order_payments' AS table_name,
    'order_id' AS column_name,
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(order_id) AS null_count,
    ROUND(100.0 * (COUNT(*) - COUNT(order_id)) / COUNT(*), 2) AS null_percentage,
    CASE
        WHEN ROUND(100.0 * (COUNT(*) - COUNT(order_id)) / COUNT(*), 2) < 5 THEN 'PASS'
        WHEN ROUND(100.0 * (COUNT(*) - COUNT(order_id)) / COUNT(*), 2) <= 10 THEN 'WARNING'
        ELSE 'FAIL'
    END AS data_quality_status
FROM order_payments;

--8.2

SELECT
    'Order Items without valid Order ID' AS scenario,
    COUNT(*) AS orphan_count
FROM order_items oi
LEFT JOIN orders_dataset o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL

UNION ALL

SELECT
    'Order Payments without valid Order ID' AS scenario,
    COUNT(*) AS orphan_count
FROM order_payments op
LEFT JOIN orders_dataset o
    ON op.order_id = o.order_id
WHERE o.order_id IS NULL

UNION ALL

SELECT
    'Order Reviews without valid Order ID' AS scenario,
    COUNT(*) AS orphan_count
FROM order_reviews r
LEFT JOIN orders_dataset o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL

UNION ALL

SELECT
    'Orders without valid Customer ID' AS scenario,
    COUNT(*) AS orphan_count
FROM orders_dataset o
LEFT JOIN customers_1 c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

--8.3

WITH order_values AS (
    SELECT
        o.order_id,
        o.order_purchase_timestamp,
        o.order_approved_at,
        o.order_delivered_customer_date,
        COALESCE(SUM(oi.price + oi.freight_value), 0) AS total_order_items_value,
        COALESCE(SUM(op.payment_value), 0) AS total_payment_value,
        COUNT(oi.order_item_id) AS num_order_items,
        COUNT(op.payment_sequential) AS num_payments
    FROM orders_dataset o
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    LEFT JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY o.order_id, o.order_purchase_timestamp, o.order_approved_at, o.order_delivered_customer_date
)

SELECT
    order_id,
    CASE
        WHEN total_payment_value <> total_order_items_value 
             AND num_order_items > 0 
             AND num_payments > 0 THEN 'Payment mismatch with order items'
        WHEN num_payments > 0 AND num_order_items = 0 THEN 'Payment exists but no order items'
        WHEN num_order_items > 0 AND num_payments = 0 THEN 'Order items exist but no payment'
        WHEN order_delivered_customer_date < order_approved_at THEN 'Delivered before approval'
    END AS inconsistency_type
FROM order_values
WHERE 
    (total_payment_value <> total_order_items_value AND num_order_items > 0 AND num_payments > 0)
    OR (num_payments > 0 AND num_order_items = 0)
    OR (num_order_items > 0 AND num_payments = 0)
    OR (order_delivered_customer_date < order_approved_at);


