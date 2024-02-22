-- Create a database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS walmartSales;

-- Define the structure of the 'sales' table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Perform data cleaning
SELECT
	*
FROM sales;

-- Add the 'time_of_day' column
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

-- Alter table to add 'time_of_day' column
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- Update 'time_of_day' column based on time ranges
UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- Add 'day_name' column
SELECT
	date,
	DAYNAME(date)
FROM sales;

-- Alter table to add 'day_name' column
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

-- Update 'day_name' column based on dates
UPDATE sales
SET day_name = DAYNAME(date);

-- Add 'month_name' column
SELECT
	date,
	MONTHNAME(date)
FROM sales;

-- Alter table to add 'month_name' column
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

-- Update 'month_name' column based on dates
UPDATE sales
SET month_name = MONTHNAME(date);

-- Perform generic queries

-- Count the number of unique cities in the data
SELECT 
	DISTINCT city
FROM sales;

-- Identify the city corresponding to each branch
SELECT 
	DISTINCT city,
    branch
FROM sales;

-- Count the number of unique product lines
SELECT
	DISTINCT product_line
FROM sales;

-- Identify the most sold product lines
SELECT
	SUM(quantity) as qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY qty DESC;

-- Calculate total revenue by month
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month_name 
ORDER BY total_revenue;

-- Identify the month with the highest COGS
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM sales
GROUP BY month_name 
ORDER BY cogs;

-- Identify the product line with the highest revenue
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- Identify the city with the highest revenue
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch 
ORDER BY total_revenue;

-- Identify the product line with the highest VAT
SELECT
	product_line,
	AVG(tax_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line and categorize them as "Good" or "Bad"
SELECT 
	AVG(quantity) AS avg_qnty
FROM sales;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM sales
GROUP BY product_line;

-- Identify branches that sold more products than the average
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- Identify the most common product lines by gender
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- Calculate the average rating for each product line
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- Identify the number of unique customer types
SELECT
	DISTINCT customer_type
FROM sales;

-- Identify the number of unique payment methods
SELECT
	DISTINCT payment
FROM sales;

-- Identify the most common customer type
SELECT
	customer_type,
	count(*) as count
FROM sales
GROUP BY customer_type
ORDER BY count DESC;

-- Identify the customer type with the highest number of purchases
SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

-- Identify the gender of the majority of customers
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Identify the gender distribution per branch
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM sales
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Determine the time of day with the highest average ratings
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Determine the time of day with the highest average ratings per branch
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Identify the day of the week with the highest average ratings
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;

-- Identify the day of the week with the highest average ratings per branch
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;

-- Determine the number of sales made in each time of the day per weekday 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Determine which customer types bring the most revenue
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;

-- Identify the city with the highest average tax/VAT percent
SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Determine which customer types pay the most in VAT
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;
