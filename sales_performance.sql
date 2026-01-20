create database sales_performance;
use sales_performance;

CREATE TABLE sales_data (
    OrderID INT,
    Date DATE,
    Region VARCHAR(50),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    SalesPerson VARCHAR(50),
    Revenue DECIMAL(12,2),
    Month INT,
    Year INT,
    MonthName VARCHAR(10)
);

-- Checking if table works or not.

SELECT * FROM sales_data
order by OrderID;

-- Adding row number for better visual

SELECT *, ROW_NUMBER() OVER (ORDER BY Date, OrderID) AS RowNum
FROM sales_data;

-- Total Business Performance

SELECT 
    COUNT(DISTINCT OrderID) AS Total_Orders,
    SUM(Revenue) AS Total_Revenue,
    AVG(Revenue) AS Avg_Order_Value
FROM sales_data;

-- Monthly Sales Trend

SELECT 
    Year,
    Month,
    MonthName,
    ROUND(SUM(Revenue), 2) AS Monthly_Revenue
FROM sales_data
GROUP BY Year, Month, MonthName
ORDER BY Year, Month;

-- Region-wise Performance

SELECT 
    Region,
    ROUND(SUM(Revenue), 2) AS Revenue
FROM sales_data
GROUP BY Region
ORDER BY Revenue DESC;

-- Top 5 Products

SELECT 
    Product,
    ROUND(SUM(Revenue), 2) AS Revenue
FROM sales_data
GROUP BY Product
ORDER BY Revenue DESC
LIMIT 5;

-- Best Salesperson

SELECT 
    SalesPerson,
    ROUND(SUM(Revenue), 2) AS Revenue
FROM sales_data
GROUP BY SalesPerson
ORDER BY Revenue DESC;

-- Month-over-Month Growth

WITH monthly AS (
    SELECT 
        Year,
        Month,
        SUM(Revenue) AS revenue
    FROM sales_data
    GROUP BY Year, Month
)
SELECT 
    Year,
    Month,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY Year, Month) AS MoM_Change
FROM monthly
ORDER BY Year, Month;









