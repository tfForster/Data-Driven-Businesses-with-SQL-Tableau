USE magist;








-- 2.1



-- What categories of tech products does Magist have?
SELECT DISTINCT product_category_name
FROM products;

SELECT DISTINCT
    p.product_category_name,
    t.product_category_name_english
FROM products p
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name;



-- How many products of these tech categories have been sold (within the time window of the database snapshot)? What percentage does that represent from the overall number of products sold?



-- tech products sold absolute number
SELECT
    COUNT(DISTINCT oi.product_id) AS sold_tech_products
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name_english IN (
    'electronics',
    'computers',
    'computers_accessories',
    'telephony',
    'fixed_telephony',
    'cine_photo',
    'pc_gamer',
    'consoles_games',
    'cds_dvds_musicals',
    'dvds_blu_ray',
    'audio',
    'auto'
);

-- tech products sold percentage of all products sold
SELECT
    COUNT(DISTINCT CASE
        WHEN t.product_category_name_english IN (
            'electronics',
            'computers',
            'computers_accessories',
            'telephony',
            'fixed_telephony',
            'cine_photo',
            'pc_gamer',
            'consoles_games',
            'cds_dvds_musicals',
            'dvds_blu_ray',
            'audio',
            'auto'
        )
        THEN oi.product_id
    END) * 100.0
    /
    COUNT(DISTINCT oi.product_id) AS tech_product_percentage
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name;

-- all products sold absolute number
SELECT
    COUNT(DISTINCT product_id) AS total_sold_products
FROM order_items;



-- What’s the average price of the products being sold?



-- average of all products being sold in sale numbers
SELECT
    AVG(price) AS avg_product_price
FROM order_items;


-- average of all unique products 
SELECT
    AVG(product_avg_price) AS avg_product_price
FROM (
    SELECT
        product_id,
        AVG(price) AS product_avg_price
    FROM order_items
    GROUP BY product_id
) t;



-- Are expensive tech products popular?



-- number of tech product sales more expensive than average of all products
SELECT
    COUNT(*) AS expensive_tech_sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name_english IN (
    'electronics',
    'computers',
    'computers_accessories',
    'telephony',
    'fixed_telephony',
    'cine_photo',
    'pc_gamer',
    'consoles_games',
    'cds_dvds_musicals',
    'dvds_blu_ray',
    'audio',
    'auto'
)
AND oi.price > (
    SELECT AVG(price)
    FROM order_items
);


-- all tech sales
SELECT
    COUNT(*) AS total_tech_sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name_english IN (
    'electronics',
    'computers',
    'computers_accessories',
    'telephony',
    'fixed_telephony',
    'cine_photo',
    'pc_gamer',
    'consoles_games',
    'cds_dvds_musicals',
    'dvds_blu_ray',
    'audio',
    'auto'
);


-- percentage expensive tech products of all tech products sold
SELECT
    COUNT(CASE
        WHEN oi.price > (SELECT AVG(price) FROM order_items)
        THEN 1
    END) * 100.0 / COUNT(*) AS expensive_tech_percentage
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name_english IN (
    'electronics',
    'computers',
    'computers_accessories',
    'telephony',
    'fixed_telephony',
    'cine_photo',
    'pc_gamer',
    'consoles_games',
    'cds_dvds_musicals',
    'dvds_blu_ray',
    'audio',
    'auto'
);







-- 2.2








-- How many months of data are included in the magist database?
SELECT
    COUNT(DISTINCT
        CONCAT(
            YEAR(order_purchase_timestamp), '-',
            MONTH(order_purchase_timestamp)
        )
    ) AS total_months
FROM orders;



-- How many sellers are there? How many Tech sellers are there? What percentage of overall sellers are Tech sellers?



-- How many sellers are there? 
SELECT COUNT(DISTINCT seller_id) AS total_sellers
FROM sellers;



-- How many Tech sellers are there?
SELECT COUNT(DISTINCT oi.seller_id) AS tech_sellers
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name_english IN (
    'electronics',
    'computers',
    'computers_accessories',
    'telephony',
    'fixed_telephony',
    'cine_photo',
    'pc_gamer',
    'consoles_games',
    'cds_dvds_musicals',
    'dvds_blu_ray',
    'audio',
    'auto''
);



-- What percentage of overall sellers are Tech sellers?
SELECT
    COUNT(DISTINCT CASE
        WHEN t.product_category_name_english IN (
            'electronics',
            'computers',
            'computers_accessories',
            'telephony',
            'fixed_telephony',
            'cine_photo',
            'pc_gamer',
            'consoles_games',
            'cds_dvds_musicals',
            'dvds_blu_ray',
            'audio',
            'auto'
        )
        THEN oi.seller_id
    END) * 100.0
    /
    COUNT(DISTINCT s.seller_id) AS tech_seller_percentage
FROM sellers s
LEFT JOIN order_items oi
    ON s.seller_id = oi.seller_id
LEFT JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name;



-- What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?



-- What is the total amount earned by all sellers?
SELECT
    SUM(price) AS total_revenue_all_sellers
FROM order_items;

-- What is the total amount earned by all Tech sellers?
SELECT
    SUM(oi.price) AS total_revenue_tech_sellers
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name_english IN (
    'electronics',
    'computers',
    'computers_accessories',
    'telephony',
    'fixed_telephony',
    'cine_photo',
    'pc_gamer',
    'consoles_games',
    'cds_dvds_musicals',
    'dvds_blu_ray',
    'audio',
    'auto'
);







