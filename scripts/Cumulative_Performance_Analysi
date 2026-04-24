/*
===============================================================================
Cumulative Performance Analysis
===============================================================================
Objective:
    - Compute progressive totals and rolling averages for key indicators.
    - Monitor how performance builds over time.
    - Reveal long-term patterns using cumulative calculations.

Techniques Used:
    - Window functions: SUM() OVER(), AVG() OVER()
    - Running totals and moving averages

Summary:
    The query below evaluates aggregated sales over time and applies
    window functions to highlight overall growth and pricing trends.
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
    SELECT 
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t
