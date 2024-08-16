CREATE DATABASE sql_project_p2;
-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,	
    sale_date DATE,	 
    sale_time TIME,	
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),	
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM retail_sales LIMIT 10;

-- Data Cleaning
SELECT * FROM retail_sales WHERE transaction_id IS NULL;
SELECT * FROM retail_sales WHERE sale_date IS NULL;
SELECT * FROM retail_sales WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

DELETE FROM retail_sales
WHERE transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

-- Data Exploration
SELECT COUNT(*) as total_sale FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) as total_customers FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

-- Q1: Retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- Q2: Retrieve transactions where the category is 'Clothing' and quantity sold is more than 4 in Nov-2022
SELECT * FROM retail_sales
WHERE category = 'Clothing'
    AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND quantity >= 4;

-- Q3: Calculate total sales for each category
SELECT category, SUM(total_sale) as net_sale, COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

-- Q4: Find the average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q5: Find all transactions where the total_sale is greater than 1000
SELECT * FROM retail_sales WHERE total_sale > 1000;

-- Q6: Find the total number of transactions made by each gender in each category
SELECT category, gender, COUNT(*) as total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- Q7: Calculate the average sale for each month, and find the best-selling month in each year
SELECT YEAR(sale_date) as year, MONTH(sale_date) as month, AVG(total_sale) as avg_sale
FROM retail_sales
GROUP BY year, month
ORDER BY avg_sale DESC
LIMIT 1;

-- Q8: Find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q9: Find the number of unique customers who purchased items from each category
SELECT category, COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Q10: Create shifts and count the number of orders (Morning <12, Afternoon 12-17, Evening >17)
SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY shift;
