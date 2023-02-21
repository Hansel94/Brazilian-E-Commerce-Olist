
SELECT customer_state AS State, 
	ROUND(AVG((JULIANDAY(order_estimated_delivery_date)) - ROUND(JULIANDAY(order_delivered_customer_date)))) AS Delivery_Difference
FROM olist_customers
INNER JOIN olist_orders 
USING (customer_id)
WHERE order_status <> 'canceled' AND order_delivered_customer_date IS NOT NULL
GROUP BY State
ORDER BY Delivery_Difference ASC;
