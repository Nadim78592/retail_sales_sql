CREATE DATABASE dbbb;
USE dbbb;
DROP DATABASE dbbb;
CREATE TABLE retail_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(10),
age INT,
category VARCHAR(100),	
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);
SELECT*FROM retail_sales
limit 10;

-- record count : determine the total number of records in the dataset
SELECT COUNT(*) FROM retail_sales;

-- customer count : find out how many unique customer
SELECT COUNT(DISTINCT customer_id) AS unique_cust FROM retail_sales;

-- category count : identify all unique product category
SELECT COUNT(DISTINCT category) AS unique_category FROM retail_sales;

-- null value check : check for any null value in dataset and delete records with missing data
SELECT * FROM retail_sales
WHERE
sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR
age IS NULL OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR
cogs is null;
SELECT * FROM retail_sales;
SET SQL_SAFE_UPDATES = 1;
DELETE FROM retail_sales
WHERE
sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR
age IS NULL OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR
cogs is null;

-- DATA ANALYSIS AND FINDINGS:
-- the following sql queries were developed to answer specific business questions

-- Q1 write a sql queries to retrieve all columns for sales made on '2022-11-05':
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

-- Q2 write a sql query to retrieve all transactions where the category is 'clothing' and 
-- the quantity sold is more than 4 in the month of nov-22:
SELECT * FROM retail_sales
WHERE category ='clothing' AND DATE_FORMAT(sale_date, '%Y-%m')='2022-11'
AND quantity >= 4;

SELECT * FROM retail_sales
WHERE category ='clothing' AND TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
AND quantity >= 4;

-- Q3 write a sql query to calculate the total sales (total_sale) for each category:
SELECT category, SUM(total_sale)  as net_sale,
COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;


-- Q4 write a sql query to find the average age of customer who purchased items from
-- the beauty category
SELECT ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category='Beauty';

SELECT AVG(age) as avg_age
FROM retail_sales
WHERE category='Beauty';

-- Q5 write a sql query to find all transactions where the total_sale > 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q6 write a sql query to find the total no. of transactions (transaction_id) made by each 
-- gender in each category
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- Q7 write a sql query to calculate the average sale for each month. find out best selling
-- month in each year
/*SELECT year, month, avg_sale FROM (    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rnk = 1*/
SELECT 
  EXTRACT(YEAR FROM sale_date) AS year,
  EXTRACT(MONTH FROM sale_date) AS month,
  AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY year, month;


SELECT*FROM retail_sales;

-- Q8 write a sql query to find the top 5 customer based on the highest total sales

SELECT customer_id, SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;

-- Q9 write a sql query to find the number of unique customer who purchased item from
-- each category
SELECT category, COUNT(DISTINCT customer_id) AS uniq_cust
FROM retail_sales
GROUP BY category;

/* Q10 write a sql query to create each shift and number of orders ( eg morning<12, 
afternoon between 12 and 17, evening>17).*/
SELECT CASE
WHEN HOUR (sale_time) < 12 THEN 'morning'
WHEN HOUR (sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
ELSE 'evening'
END AS Shift,
COUNT(*) AS num_of_orders
FROM retail_sales
GROUP BY Shift;

SELECT*FROM retail_sales;

/* Findings
1. customer demographics:
the list shows all kinds of people, young and old, buying things like shirts, dresses and
makeup.

2. high value transactions:
a few people spent lot of money, over 1000 on fancy stuff

3. sales trends:
sales change every month, sometimes they are high, and sometimes they are low this shows
us which months are super busy for shopping

4. customer insight:
we found out who spends the most money and which products are the most popular

Report( what we made to show the info,)
. sale summary:
we made a report that shows how much stuff was sold, who bought it and which items sold
sold the best

. trends analysis:
we made a report to see how sale go up and down each month and spot any patterns
*/







