
SELECT customer_state,
SUM(payment_value) AS Revenue
FROM olist_customers 
INNER JOIN olist_orders 
USING (customer_id)
INNER JOIN olist_order_payments  
USING (order_id)
WHERE order_status = 'delivered' AND order_delivered_customer_date IS NOT NULL 
GROUP BY customer_state
ORDER BY Revenue DESC
LIMIT 10;
