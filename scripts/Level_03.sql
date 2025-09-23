-- ------------------------------------------
-- Level 3: Discount & Coupon Impact
-- ------------------------------------------

-- 1️1. How many transactions used a coupon?

SELECT 
    COUNT(DISTINCT Transaction_ID) AS tnx_with_coupon
FROM
    online_sales
WHERE
    Coupon_Status IS NOT NULL
        AND Coupon_Status <> ' ';
        
-- 1️2. Calculate total discount amount given for each category.
WITH discount_calc AS (
    SELECT 
        os.Product_Category,
        os.Quantity,
        os.Avg_Price,
        COALESCE(dc.Discount_pct, 0) AS Discount_pct,
        (os.Quantity * os.Avg_Price) * COALESCE(dc.Discount_pct, 0) / 100 AS discount_amount
    FROM 
        online_sales os
    LEFT JOIN 
        discount_coupon dc 
        ON DATE_FORMAT(STR_TO_DATE(os.Transaction_Date, '%m/%d/%Y'), '%b') = dc.Month
        AND os.Product_Category = dc.Product_Category
)

SELECT
    Product_Category,
    ROUND(SUM(discount_amount), 2) AS total_discount_amount
FROM 
    discount_calc
GROUP BY
    Product_Category
ORDER BY
    total_discount_amount DESC;    
-- -----------------------------------------------------------------------    

-- 1️3. Compare average revenue per transaction for transactions with and without coupon applied.
WITH invoice_calc AS (
  SELECT 
    os.Transaction_ID,
    os.CustomerID,
    os.Quantity,
    os.Avg_Price,
    os.Delivery_Charges,
    os.Coupon_Status,
    COALESCE(dc.Discount_pct, 0) AS Discount_pct,
    ta.GST,
    -- Calculate invoice value
    ((os.Quantity * os.Avg_Price) * (1 - COALESCE(dc.Discount_pct, 0) / 100) * (1 + ta.GST))
    + os.Delivery_Charges AS invoice_amount
  FROM 
    online_sales os
  LEFT JOIN 
    discount_coupon dc 
      ON DATE_FORMAT(STR_TO_DATE(os.Transaction_Date, '%m/%d/%Y'), '%b') = dc.Month
      AND os.Product_Category = dc.Product_Category
  LEFT JOIN 
    tax_amount ta 
      ON os.Product_Category = ta.Product_Category
)

SELECT 
  CASE 
    WHEN COALESCE(Discount_pct, 0) > 0 THEN 'With Coupon'
    ELSE 'Without Coupon'
  END AS coupon_applied,
  COUNT(DISTINCT Transaction_ID) AS total_transactions,
  ROUND(AVG(invoice_amount), 2) AS avg_revenue_per_transaction
FROM 
  invoice_calc
GROUP BY 
  coupon_applied;











