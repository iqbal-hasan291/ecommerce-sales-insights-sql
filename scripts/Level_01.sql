-- -----------------------------------------------------------
--  DATABASE CREATION
-- -----------------------------------------------------------
-- Create a new database for the marketing e-commerce project

CREATE DATABASE marketing_ecommerce;
USE marketing_ecommerce;

-- 🗂️ LEVEL 1: Revenue & Basic Transaction Metrics
-- -----------------------------------------------------------
-- 1️. Calculate total invoice amount for each transaction.
-- This query:
-- - Joins online sales data with discount coupons and tax rates
-- - Calculates: 
--     subtotal (Quantity * Price)
--     discounted price (after applying discount if any)
--     tax amount (after discount)
--     final invoice amount (tax + delivery charges)
-- -----------------------------------------------------------

SELECT 
    os.CustomerID,
    os.Transaction_ID,
    os.Transaction_Date,
    os.Product_SKU,
    os.Product_Category,
    os.Quantity,
    os.Avg_Price,
    os.Delivery_Charges,
    COALESCE(dc.Discount_pct, 0) AS discount_pct,  -- Use 0% if no coupon
    ta.GST,                                        -- GST rate for the product category
    (os.Quantity * os.Avg_Price) AS subtotal,      -- Base price
    ((os.Quantity * os.Avg_Price) * (1 - COALESCE(dc.Discount_pct, 0)/100)) AS discount_price, -- After discount
    ((os.Quantity * os.Avg_Price) * (1 - COALESCE(dc.Discount_pct, 0)/100) * (1 + ta.GST)) AS tax_amount, -- After tax
    ((os.Quantity * os.Avg_Price) * (1 - COALESCE(dc.Discount_pct, 0)/100) * (1 + ta.GST)) + os.Delivery_Charges AS invoice_amount -- Final total
FROM
    online_sales os
LEFT JOIN discount_coupon dc 
    ON DATE_FORMAT(STR_TO_DATE(os.Transaction_Date, '%m/%d/%Y'), '%b') = dc.Month
    AND os.Product_Category = dc.Product_Category
LEFT JOIN tax_amount ta 
    ON os.Product_Category = ta.Product_Category;

-- -----------------------------------------------------------
-- 📄 CREATE VIEW
-- Creates a reusable view called Invoice_Calc
-- So you don’t need to repeat the long calculation every time
-- -----------------------------------------------------------

CREATE VIEW Invoice_Calc AS
SELECT 
    os.CustomerID,
    os.Transaction_ID,
    os.Transaction_Date,
    os.Product_SKU,
    os.Product_Category,
    os.Quantity,
    os.Avg_Price,
    os.Delivery_Charges,
    COALESCE(dc.Discount_pct, 0) AS discount_pct,
    ta.GST,
    (os.Quantity * os.Avg_Price) AS subtotal,
    ((os.Quantity * os.Avg_Price) * (1 - COALESCE(dc.Discount_pct, 0)/100)) AS discount_price,
    ((os.Quantity * os.Avg_Price) * (1 - COALESCE(dc.Discount_pct, 0)/100) * (1 + ta.GST)) AS tax_amount,
    ROUND(((os.Quantity * os.Avg_Price) * (1 - COALESCE(dc.Discount_pct, 0)/100) * (1 + ta.GST)) + os.Delivery_Charges, 0) AS invoice_amount
FROM
    online_sales os
LEFT JOIN discount_coupon dc 
    ON DATE_FORMAT(STR_TO_DATE(os.Transaction_Date, '%m/%d/%Y'), '%b') = dc.Month
    AND os.Product_Category = dc.Product_Category
LEFT JOIN tax_amount ta 
    ON os.Product_Category = ta.Product_Category;

-- -----------------------------------------------------------
-- 2️.Find the top 10 transactions with the highest invoice value.
-- Helps identify big orders for marketing focus or VIP customers.
-- -----------------------------------------------------------

SELECT
    CustomerID,
    Transaction_ID,
    Transaction_Date,
    invoice_amount AS Invoice_value
FROM Invoice_Calc
ORDER BY invoice_amount DESC
LIMIT 10;

-- -----------------------------------------------------------
-- 3️.Calculate total revenue for each product category.
-- Useful for category-wise performance analysis.
-- -----------------------------------------------------------

SELECT
    Product_Category,
    SUM(invoice_amount) AS total_revenue
FROM Invoice_Calc
GROUP BY Product_Category
ORDER BY total_revenue;


-- -----------------------------------------------------------
-- 4️.List total number of transactions and total quantity sold for each month.
-- Helps analyze monthly trends in sales volume and order count.
-- -----------------------------------------------------------

SELECT 
    DATE_FORMAT(STR_TO_DATE(Transaction_Date, '%m/%d/%Y'), '%M') AS month_name,
    COUNT(DISTINCT Transaction_ID) AS total_transactions,
    SUM(Quantity) AS total_quantity
FROM online_sales
GROUP BY MONTH(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')), month_name
ORDER BY MONTH(STR_TO_DATE(Transaction_Date, '%m/%d/%Y'));


-- -----------------------------------------------------------
-- 5️.Find the Average Order Value (AOV) for each customer.
-- AOV = Total Revenue / Total Orders
-- Helps identify high-value customers.
-- -----------------------------------------------------------

SELECT 
    CustomerID,
    SUM(invoice_amount) AS total_revenue,
    COUNT(DISTINCT Transaction_ID) AS total_orders,
    ROUND(SUM(invoice_amount) / COUNT(DISTINCT Transaction_ID), 2) AS avg_order_value
FROM Invoice_Calc
GROUP BY CustomerID;
