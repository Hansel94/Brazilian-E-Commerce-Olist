
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
AVG(CASE 
	WHEN Year = '2016' THEN real_time
END) AS Year2016_real_time,
AVG(CASE 
	WHEN Year = '2017' THEN real_time
END) AS Year2017_real_time,
AVG(CASE 
	WHEN Year = '2018' THEN real_time
END) AS Year2018_real_time,
AVG(CASE 
	WHEN Year = '2016' THEN estimated_time
END) AS Year2016_estimated_time,
AVG(CASE 
	WHEN Year = '2017' THEN estimated_time
END) AS Year2017_estimated_time,
AVG(CASE 
	WHEN Year = '2018' THEN estimated_time
END) AS Year2018_estimated_time
FROM (SELECT order_id,
	customer_id,
	STRFTIME('%m', order_purchase_timestamp) AS Month,
	STRFTIME('%Y', order_purchase_timestamp) AS Year, 
	JULIANDAY(order_estimated_delivery_date) - JULIANDAY(order_purchase_timestamp) AS estimated_time,
	JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_purchase_timestamp) AS real_time
	FROM olist_orders
	WHERE order_status = 'delivered'
	AND order_delivered_customer_date IS NOT NULL
	GROUP BY order_id,
		customer_id)
GROUP BY Month;
