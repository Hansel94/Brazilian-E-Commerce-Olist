
SELECT 
product_category_name_english AS Category,
COUNT(DISTINCT order_id) AS Num_order,
SUM(payment_value) AS Revenue
FROM (SELECT 
	*
	FROM olist_products op
	LEFT JOIN product_category_name_translation pcnt 
	ON pcnt.product_category_name = op.product_category_name
	LEFT JOIN olist_order_items ooi 
	ON ooi.product_id = op.product_id
	LEFT JOIN olist_orders oo 
	ON oo.order_id = ooi.order_id 
	LEFT JOIN olist_order_payments oop 
	ON oop.order_id = oo.order_id 
	--JOIN olist_products_dataset USING (product_id)
	--WHERE order_status = 'delivered'
--	AND product_category_name_english IS NOT NULL
	--WHERE order_status <> 'canceled'
	--AND order_delivered_customer_date IS NOT NULL
	--AND order_delivered_carrier_date IS NOT NULL
	--AND order_approved_at IS NOT NULL
	--AND payment_value IS NOT NULL
)
WHERE Category IS NOT NULL
AND order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
GROUP BY Category 
ORDER BY Revenue DESC 
LIMIT 10;
