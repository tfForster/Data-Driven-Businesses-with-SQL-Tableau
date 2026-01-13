USE magist;


-- 1

SELECT COUNT(*) FROM Orders;
SELECT order_id FROM Orders;
SELECT COUNT(order_id) FROM Orders;

-- 2

SELECT order_status, COUNT(*) AS anzahl FROM orders GROUP BY order_status ;


-- 3


SELECT
    YEAR(order_purchase_timestamp)  AS year,
    MONTH(order_purchase_timestamp) AS month,
    COUNT(*)                        AS total_orders
FROM orders
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
    year, month;
    

-- 4


SELECT COUNT(DISTINCT product_category_name) FROM products;



-- 5 


SELECT COUNT(*) FROM products GROUP BY product_category_name;

SELECT
    product_category_name,
    COUNT(*) AS product_count
FROM products
GROUP BY product_category_name
ORDER BY product_count DESC;


-- 6


SELECT COUNT(DISTINCT product_id) FROM order_items;


-- 7


SELECT
    MIN(price) AS cheapest_product,
    MAX(price) AS most_expensive_product
FROM order_items;


-- 8


SELECT
    MIN(payment_value) AS cheapest,
    MAX(payment_value) AS most_expensive
FROM order_payments;