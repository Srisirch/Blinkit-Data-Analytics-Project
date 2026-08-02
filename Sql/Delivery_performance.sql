SELECT delivery_status,
	COUNT(*) AS total_orders,
    ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),2) AS percentage
FROM blinkit_delivery_performance
GROUP BY delivery_status
ORDER BY total_orders DESC;

-- delayed deliveries vs low ratings

SELECT CASE
	WHEN d.delivery_status = 'On Time' THEN 'On Time'
    ELSE 'Delayed'
END AS delivery_category,
COUNT(DISTINCT f.order_id) AS feedback_count,
ROUND(AVG(f.rating),2) as avg_rating
FROM blinkit_delivery_performance d
JOIN blinkit_customer_feedback f on d.order_id=f.order_id
GROUP BY delivery_category;

-- Delivery Performance by Day of Week
SELECT DAYNAME(o.order_date) AS day_of_week,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN d.delivery_status = 'On Time' THEN 1 ELSE 0 END) AS on_time_orders,
    ROUND(SUM(CASE WHEN d.delivery_status = 'On Time' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS on_time_pct
FROM blinkit_orders o
JOIN blinkit_delivery_performance d ON o.order_id = d.order_id
GROUP BY DAYNAME(o.order_date), DAYOFWEEK(o.order_date)
ORDER BY DAYOFWEEK(o.order_date);

-- Delayed Deliveries vs Average Rating
SELECT 
    CASE 
        WHEN d.delivery_status = 'On Time' THEN 'On Time'
        ELSE 'Delayed'
    END AS delivery_category,
    COUNT(DISTINCT f.order_id) AS feedback_count,     
    ROUND(AVG(f.rating), 2) AS avg_rating
FROM blinkit_delivery_performance d
JOIN blinkit_customer_feedback f ON d.order_id = f.order_id   
GROUP BY delivery_category;
