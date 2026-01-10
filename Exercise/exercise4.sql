--5.1

WITH order_values AS (
    SELECT
        o.customer_id,
        o.order_id,
        o.order_purchase_timestamp,
        SUM(p.payment_value) AS total_order_value
    FROM orders_dataset o
    JOIN order_payments p
        ON o.order_id = p.order_id
    GROUP BY
        o.customer_id,
        o.order_id,
        o.order_purchase_timestamp
)
SELECT
    customer_id,
    order_id,
    order_purchase_timestamp,
    total_order_value,
    DENSE_RANK() OVER (
        PARTITION BY customer_id
        ORDER BY total_order_value DESC
    ) AS rank_within_customer
FROM order_values
ORDER BY
    customer_id,
    rank_within_customer;

--5.2


WITH daily_revenue AS (
    SELECT
        CAST(order_purchase_timestamp AS DATE) AS order_date,
        SUM(payment_value) AS daily_revenue
    FROM orders_dataset o
    JOIN order_payments p
        ON o.order_id = p.order_id
    GROUP BY CAST(order_purchase_timestamp AS DATE)
)
SELECT
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM daily_revenue
ORDER BY order_date;

--5.3

SELECT
    pct.c2 AS category_name_en,
    oi.product_id,
    p.product_category_name AS category_name_pt,
    COUNT(*) AS total_quantity_sold
FROM order_items oi
JOIN products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pct ON p.product_category_name = pct.c1
GROUP BY pct.c2, oi.product_id, p.product_category_name
QUALIFY RANK() OVER (PARTITION BY pct.c2 ORDER BY COUNT(*) DESC) = 1
ORDER BY category_name_en;

--5.4

SELECT
    customer_id,
    order_id,
    order_purchase_timestamp,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_purchase_timestamp
    ) AS order_sequence_number,
    DATEDIFF(
        'day',
        LAG(order_purchase_timestamp) OVER (
            PARTITION BY customer_id
            ORDER BY order_purchase_timestamp
        ),
        order_purchase_timestamp
    ) AS days_since_previous_order
FROM orders_dataset
ORDER BY customer_id, order_purchase_timestamp;

--5.5

WITH daily_revenue AS (
    SELECT
        CAST(order_purchase_timestamp AS DATE) AS order_date,
        SUM(payment_value) AS daily_revenue
    FROM orders_dataset o
    JOIN order_payments p
        ON o.order_id = p.order_id
    GROUP BY CAST(order_purchase_timestamp AS DATE)
)
SELECT
    order_date,
    daily_revenue,
    AVG(daily_revenue) OVER (
        ORDER BY order_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7d
FROM daily_revenue
ORDER BY order_date;


--5.6

WITH order_revenue AS (
    SELECT
        o.order_id,
        o.order_purchase_timestamp,
        SUM(p.payment_value) AS order_revenue
    FROM orders_dataset o
    JOIN order_payments p
        ON o.order_id = p.order_id
    GROUP BY o.order_id, o.order_purchase_timestamp
)
SELECT
    order_id,
    order_purchase_timestamp,
    order_revenue,
    ROUND(
        order_revenue * 100.0 / SUM(order_revenue) OVER (),
        2
    ) AS percent_of_total_revenue
FROM order_revenue
ORDER BY order_revenue DESC;


--6.3


WITH monthly_sales AS (
    SELECT
        product_id,
        TO_CHAR(order_purchase_timestamp, 'YYYY-MM') AS year_month,
        COUNT(*) AS quantity_sold
    FROM order_items oi
    JOIN orders_dataset o ON oi.order_id = o.order_id
    GROUP BY product_id, TO_CHAR(order_purchase_timestamp, 'YYYY-MM')
),

sales_with_lag AS (
    SELECT
        product_id,
        year_month,
        quantity_sold,
        LAG(quantity_sold) OVER (
            PARTITION BY product_id
            ORDER BY year_month
        ) AS prev_month_quantity,
        quantity_sold - LAG(quantity_sold) OVER (
            PARTITION BY product_id
            ORDER BY year_month
        ) AS mom_change
    FROM monthly_sales
)

SELECT
    product_id,
    year_month,
    quantity_sold,
    prev_month_quantity,
    mom_change,
    SUM(quantity_sold) OVER (
        PARTITION BY product_id
        ORDER BY year_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_quantity
FROM sales_with_lag
ORDER BY product_id, year_month;

--6.5

WITH product_revenue AS (
    SELECT
        oi.product_id,
        pct.c2 AS category_name_en,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM order_items oi
    JOIN products_dataset p ON oi.product_id = p.product_id
    JOIN product_category_name_translation pct ON p.product_category_name = pct.c1
    GROUP BY oi.product_id, pct.c2
)
SELECT
    category_name_en,
    product_id,
    total_revenue,
    RANK() OVER (PARTITION BY category_name_en ORDER BY total_revenue DESC) AS rank_in_category
FROM product_revenue
QUALIFY rank_in_category <= 3
ORDER BY category_name_en, rank_in_category;

--7.3

WITH customer_count AS (
    SELECT customer_state AS state, COUNT(DISTINCT customer_id) AS num_customers
    FROM customers_1
    GROUP BY customer_state
),
seller_count AS (
    SELECT seller_state AS state, COUNT(DISTINCT seller_id) AS num_sellers
    FROM sellers_dataset
    GROUP BY seller_state
),
order_revenue AS (
    SELECT 
        o.customer_id,
        c.customer_state AS state,
        o.order_id,
        SUM(oi.price + oi.freight_value) AS order_revenue
    FROM orders_dataset o
    JOIN customers_1 c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, o.customer_id, c.customer_state
),
orders_by_state AS (
    SELECT 
        state,
        COUNT(DISTINCT order_id) AS num_orders,
        SUM(order_revenue) AS total_revenue,
        AVG(order_revenue) AS avg_order_value
    FROM order_revenue
    GROUP BY state
),
category_revenue AS (
    SELECT
        c.customer_state AS state,
        p.product_category_name AS category,
        SUM(oi.price + oi.freight_value) AS category_revenue,
        RANK() OVER (PARTITION BY c.customer_state ORDER BY SUM(oi.price + oi.freight_value) DESC) AS rank_in_state
    FROM orders_dataset o
    JOIN customers_1 c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products_dataset p ON oi.product_id = p.product_id
    GROUP BY c.customer_state, p.product_category_name
)
SELECT
    o.state,
    cc.num_customers,
    sc.num_sellers,
    o.num_orders,
    o.total_revenue,
    o.avg_order_value,
    cr.category AS top_product_category
FROM orders_by_state o
LEFT JOIN customer_count cc ON o.state = cc.state
LEFT JOIN seller_count sc ON o.state = sc.state
LEFT JOIN category_revenue cr ON o.state = cr.state AND cr.rank_in_state = 1
ORDER BY o.state;


--7.4

WITH payment_summary AS (
    SELECT
        payment_type,
        AVG(payment_installments) AS avg_installments,
        COUNT(*) AS total_payments,
        SUM(payment_value) AS total_payment_value,
        AVG(payment_value) AS avg_payment_value,
        COUNT(DISTINCT order_id) AS orders_using_type
    FROM order_payments
    GROUP BY payment_type
),
total_orders AS (
    SELECT COUNT(DISTINCT order_id) AS total_orders
    FROM order_payments
)
SELECT
    ps.payment_type,
    ps.avg_installments,
    ps.total_payments,
    ps.total_payment_value,
    ps.avg_payment_value,
    ROUND(ps.orders_using_type * 100.0 / t.total_orders, 2) AS pct_orders_using_type
FROM payment_summary ps
CROSS JOIN total_orders t
ORDER BY ps.total_payment_value DESC;

--7.5

WITH product_sales AS (
    SELECT
        oi.product_id,
        p.product_category_name AS category_name,
        COUNT(*) AS total_quantity_sold,
        SUM(oi.price + oi.freight_value) AS total_revenue
    FROM order_items oi
    JOIN products_dataset p ON oi.product_id = p.product_id
    GROUP BY oi.product_id, p.product_category_name
),
product_reviews AS (
    SELECT
        oi.product_id,
        AVG(orv.review_score) AS avg_review_score,
        COUNT(orv.review_id) AS num_reviews
    FROM order_items oi
    JOIN order_reviews orv ON oi.order_id = orv.order_id
    GROUP BY oi.product_id
),
category_ranks AS (
    SELECT
        ps.product_id,
        ps.category_name,
        ps.total_quantity_sold,
        COALESCE(pr.avg_review_score, 0) AS avg_review_score,
        COALESCE(pr.num_reviews, 0) AS num_reviews,
        RANK() OVER (
            PARTITION BY ps.category_name
            ORDER BY ps.total_revenue DESC
        ) AS revenue_rank_in_category
    FROM product_sales ps
    LEFT JOIN product_reviews pr ON ps.product_id = pr.product_id
),
rank_score AS (
    SELECT
        product_id,
        category_name,
        total_quantity_sold,
        avg_review_score,
        num_reviews,
        revenue_rank_in_category,
        1.0 / revenue_rank_in_category AS category_rank_score
    FROM category_ranks
)
SELECT
    product_id,
    category_name,
    total_quantity_sold,
    avg_review_score,
    num_reviews,
    revenue_rank_in_category,
    ROUND(
        total_quantity_sold * 0.4 +
        avg_review_score * 20 * 0.3 +
        category_rank_score * 100 * 0.3,
        2
    ) AS recommendation_score
FROM rank_score
ORDER BY recommendation_score DESC
LIMIT 20;
