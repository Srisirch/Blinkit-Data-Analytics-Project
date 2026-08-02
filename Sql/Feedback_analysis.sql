-- Average Rating Overall
SELECT ROUND(AVG(rating), 2) AS overall_avg_rating
FROM blinkit_customer_feedback;

-- Average Rating by Customer Segment
SELECT c.customer_segment,
    ROUND(AVG(f.rating), 2) AS avg_rating,
    COUNT(*) AS feedback_count
FROM blinkit_customer_feedback f
JOIN blinkit_orders o ON f.order_id = o.order_id          
JOIN blinkit_customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY avg_rating DESC;


-- Categories with Lowest Average Rating
SELECT 
    p.category,
    ROUND(AVG(f.rating), 2) AS avg_rating,
    COUNT(*) AS feedback_count
FROM blinkit_customer_feedback f
JOIN blinkit_orders o ON f.order_id = o.order_id
JOIN blinkit_order_items oi ON o.order_id = oi.order_id
JOIN blinkit_products p ON oi.product_id = p.product_id
GROUP BY p.category
HAVING COUNT(*) >= 10          
ORDER BY avg_rating ASC
LIMIT 10;