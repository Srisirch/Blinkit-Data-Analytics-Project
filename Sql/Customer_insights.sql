-- customer segment distribution

SELECT customer_segment,
	COUNT(*) as number_of_customers,
    ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM blinkit_customers),2) as percentage
FROM blinkit_customers
GROUP BY customer_segment
ORDER BY number_of_customers DESC;

-- average spend per segment

SELECT c.customer_segment,
	COUNT(DISTINCT c.customer_id) as total_customers,
    ROUND(SUM(oi.quantity*oi.unit_price),2) as total_rev,
    ROUND(SUM(oi.quantity*oi.unit_price)/COUNT(DISTINCT c.customer_id),2) as avg_spend
FROM blinkit_customers c
JOIN blinkit_orders o ON c.customer_id = o.customer_id
JOIN blinkit_order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_segment
ORDER BY avg_spend DESC;
