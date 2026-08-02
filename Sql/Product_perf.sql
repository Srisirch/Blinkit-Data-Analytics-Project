-- Top 10products by rev
SELECT p.product_id, p.product_name,p.category,
	SUM(oi.quantity) as total_quan,
    ROUND(SUM(oi.quantity*oi.unit_price),2) as total_rev
FROM blinkit_order_items oi
JOIN blinkit_products p on oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_rev DESC
LIMIT 10;

-- Top Categories by Revenue and Quantity
SELECT p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM blinkit_order_items oi
JOIN blinkit_products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Category Contribution Percentage
WITH category_revenue AS (
    SELECT 
        p.category,
        SUM(oi.quantity * oi.unit_price) AS category_revenue
    FROM blinkit_order_items oi
    JOIN blinkit_products p ON oi.product_id = p.product_id
    GROUP BY p.category
),
total AS (
    SELECT SUM(category_revenue) AS grand_total FROM category_revenue
)
SELECT 
    cr.category,
    ROUND(cr.category_revenue, 2) AS revenue,
    ROUND((cr.category_revenue / t.grand_total) * 100, 2) AS contribution_pct
FROM category_revenue cr
CROSS JOIN total t
ORDER BY contribution_pct DESC;