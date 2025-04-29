CREATE DATABASE superstore;

SELECT * FROM superstore.`sample - eu superstore 2(orders)`;

CREATE TABLE superstore.`sample - eu superstore 2(orders)2`
LIKE superstore.`sample - eu superstore 2(orders)`;

INSERT superstore.`sample - eu superstore 2(orders)2`
SELECT * 
FROM superstore.`sample - eu superstore 2(orders)`;

SELECT * 
FROM superstore.`sample - eu superstore 2(orders)2`;

SELECT * , 
ROW_NUMBER() 
OVER(
PARTITION BY `Row ID`, `Order ID`, `Order Date`, `Ship Date`, `Ship Mode`, `Customer ID`, `Customer Name`, `Segment`, `City`, `State`, `Country`, `Region`, `Product ID`, `Category`, `Sub-Category`, `Product Name`, `Sales`, `Quantity`, `Discount`, `Profit`) AS `Index`
FROM superstore.`sample - eu superstore 2(orders)2`;


SELECT `Order Date`, `Ship Date`, STR_TO_DATE(`Order Date`, '%m/%d/%Y'), STR_TO_DATE(`Ship Date`, '%m/%d/%Y')
FROM superstore.`sample - eu superstore 2(orders)2`;

UPDATE superstore.`sample - eu superstore 2(orders)2`
SET `Order Date` = STR_TO_DATE(`Order Date`, '%m/%d/%Y');

UPDATE superstore.`sample - eu superstore 2(orders)2`
SET `Ship Date` = STR_TO_DATE(`Ship Date`, '%m/%d/%Y'); 

ALTER TABLE superstore.`sample - eu superstore 2(orders)2`
MODIFY COLUMN `Order Date` DATE;

ALTER TABLE superstore.`sample - eu superstore 2(orders)2`
MODIFY COLUMN `Ship Date` DATE;



WITH duplicate_cte AS
(
SELECT * , 
ROW_NUMBER() 
OVER(
PARTITION BY `Row ID`, `Order ID`, `Order Date`, `Ship Date`, `Ship Mode`, `Customer ID`, `Customer Name`, `Segment`, `City`, `State`, `Country`, `Region`, `Product ID`, `Category`, `Sub-Category`, `Product Name`, `Sales`, `Quantity`, `Discount`, `Profit`) AS `Index`
FROM superstore.`sample - eu superstore 2(orders)2`
)
SELECT *
FROM duplicate_cte
WHERE `Index` > 1;


SELECT SUM(Sales) AS Total_Sales
FROM superstore.`sample - eu superstore 2(orders)2`;


SELECT SUM(Profit) AS Total_Profit
FROM superstore.`sample - eu superstore 2(orders)2`;

SELECT COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM superstore.`sample - eu superstore 2(orders)2`;

SELECT `Category`, `Sub-Category`, ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore.`sample - eu superstore 2(orders)2`
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT DATE_FORMAT(`Order Date`, "%m") AS `Month`, ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore.`sample - eu superstore 2(orders)2`
GROUP BY 1
ORDER BY 2 DESC;

SELECT AVG(DATEDIFF(`Ship Date`, `Order Date`)) AS Avg_Shipping_Time, ROUND(SUM(Sales), 2) AS Total_Sales
FROM superstore.`sample - eu superstore 2(orders)2`
ORDER BY 2 DESC;

SELECT `Customer Name`, ROUND(SUM(Profit), 2) AS Total_Profits
FROM superstore.`sample - eu superstore 2(orders)2`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT `Profit`, `Discount`, (`Profit` - `Discount`) AS Comparison
FROM superstore.`sample - eu superstore 2(orders)2`;

