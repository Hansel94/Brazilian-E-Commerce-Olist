
SELECT 
Category,
COUNT(DISTINCT order_id) AS Num_order,
SUM(payment_value) AS Revenue
FROM (SELECT 
	customer_id,
	order_id, 
	order_status,
	payment_value,
	product_id,
	product_category_name_english AS Category
	FROM olist_orders
	LEFT JOIN olist_order_payments USING (order_id)
	LEFT JOIN olist_order_items ooid USING (order_id)
	LEFT JOIN olist_products USING (product_id)
	LEFT JOIN product_category_name_translation USING (product_category_name)
	WHERE order_status = 'delivered'
)
WHERE Category IS NOT NULL
GROUP BY Category 
ORDER BY Revenue ASC 
LIMIT 10
