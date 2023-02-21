
SELECT Month as month_no,
CASE 
	WHEN Month = '01' THEN 'Jan'
	WHEN Month = '02' THEN 'Feb'
	WHEN Month = '03' THEN 'Mar'
	WHEN Month = '04' THEN 'Apr'
	WHEN Month = '05' THEN 'May'
	WHEN Month = '06' THEN 'Jun'
	WHEN Month = '07' THEN 'Jul'
	WHEN Month = '08' THEN 'Aug'
	WHEN Month = '09' THEN 'Sep'
	WHEN Month = '10' THEN 'Oct'
	WHEN Month = '11' THEN 'Nov'
	WHEN Month = '12' THEN 'Dec'
END AS month,
IFNULL(SUM(CASE 
	WHEN Year = '2016' THEN payment_value
END), 0) AS Year2016,
IFNULL(SUM(CASE 
	WHEN Year = '2017' THEN payment_value
END), 0) AS Year2017,
IFNULL(SUM(CASE 
	WHEN Year = '2018' THEN payment_value
END), 0) AS Year2018
FROM (SELECT customer_id,
	order_id,
	order_delivered_customer_date,
	order_status,
	STRFTIME('%m', order_delivered_customer_date) AS Month,
	STRFTIME('%Y', order_delivered_customer_date) AS Year,
	payment_value 
	FROM olist_orders
	INNER JOIN olist_order_payments USING (order_id) 
	WHERE Month IS NOT NULL
	AND order_status = 'delivered'
	AND order_delivered_customer_date IS NOT NULL
	GROUP BY order_id) 
GROUP BY Month;
