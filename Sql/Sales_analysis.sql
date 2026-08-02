-- Total revenue, total orders, average order values

SELECT COUNT(DISTINCT o.order_id) AS total_orders,
	ROUND(SUM(oi.quantity*oi.unit_price),2) AS total_revenue,
	ROUND(SUM(oi.quantity*oi.unit_price)/COUNT(DISTINCT o.order_id),2) AS average_order_value
FROM blinkit_orders o
JOIN blinkit_order_items oi ON o.order_id = oi.order_id;


-- Monthly sales trend
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
	COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity*oi.unit_price),2) AS total_revenue,
    ROUND(SUM(oi.quantity*oi.unit_price)/COUNT(DISTINCT o.order_id),2) AS average_order_value
FROM blinkit_orders o
JOIN blinkit_order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

-- Weekly sales
SELECT YEAR(o.order_date) AS year,
    WEEK(o.order_date, 1) AS week_number,          
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM blinkit_orders o
JOIN blinkit_order_items oi ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), WEEK(o.order_date, 1)
ORDER BY year, week_number;


-- Revenue by Customer Segment
SELECT c.customer_segment,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id), 2) AS aov
FROM blinkit_orders o
JOIN blinkit_order_items oi ON o.order_id = oi.order_id
JOIN blinkit_customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY total_revenue DESC;



    