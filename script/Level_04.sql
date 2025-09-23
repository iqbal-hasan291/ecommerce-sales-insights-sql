-- Level 4: Sales Trends & Seasonality

-- 14. Show daily revenue trend across the year
SELECT
    Transaction_Date,
    ROUND(SUM(invoice_amount), 2) AS total_revenue
FROM invoice_calc
GROUP BY Transaction_Date
ORDER BY Transaction_Date;

-- 15. Which day of the week has the highest sales
SELECT
    DAYNAME(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) AS day_of_week,
    ROUND(SUM(invoice_amount), 2) AS total_revenue
FROM invoice_calc
GROUP BY day_of_week
ORDER BY total_revenue DESC;

-- 16. Which location generates the most revenue
SELECT
    cd.Location,
    ROUND(SUM(ic.invoice_amount), 2) AS total_revenue
FROM invoice_calc ic
JOIN customer_data cd 
    ON ic.CustomerID = cd.CustomerID
GROUP BY cd.Location
ORDER BY total_revenue DESC;

-- 17. Which product category shows strong seasonality
SELECT
    ic.Product_Category,
    MONTH(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) AS month_num,
    DATE_FORMAT(STR_TO_DATE(Transaction_Date, '%m/%d/%Y'), '%M') AS month_name,
    ROUND(SUM(ic.invoice_amount), 2) AS total_revenue
FROM invoice_calc ic
GROUP BY ic.Product_Category, month_num, month_name
ORDER BY ic.Product_Category, month_num;
