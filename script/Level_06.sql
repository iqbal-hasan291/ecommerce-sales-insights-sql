-- Level 6: Customer Segmentation

-- 21. Calculate RFM (Recency, Frequency, Monetary) values for each customer
WITH rfm_base AS (
    SELECT 
        CustomerID,
        MAX(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) AS last_purchase_date, -- most recent purchase
        COUNT(DISTINCT Transaction_ID) AS frequency,                          -- total number of purchases
        SUM(invoice_amount) AS monetary_value                                 -- total revenue generated
    FROM invoice_calc
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    DATEDIFF('2019-12-31', last_purchase_date) AS recency_days, -- days since last purchase
    frequency,
    ROUND(monetary_value, 2) AS monetary_value
FROM rfm_base
ORDER BY recency_days ASC;

-- 22. Segment customers as Premium, Gold, Silver, Standard based on RFM percentiles
-- Step 1: Create a view to store base RFM values
CREATE OR REPLACE VIEW RFM_Customer_Score AS
WITH rfm_base AS (
    SELECT 
        CustomerID,
        MAX(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) AS last_purchase_date,
        COUNT(DISTINCT Transaction_ID) AS frequency,
        SUM(invoice_amount) AS monetary_value
    FROM invoice_calc
    GROUP BY CustomerID
),
rfm_scores AS (
    SELECT 
        CustomerID,
        DATEDIFF('2019-12-31', last_purchase_date) AS recency_days,
        frequency,
        ROUND(monetary_value, 2) AS monetary_value,
        NTILE(4) OVER (ORDER BY DATEDIFF('2019-12-31', last_purchase_date) ASC) AS recency_rank,
        NTILE(4) OVER (ORDER BY frequency DESC) AS frequency_rank,
        NTILE(4) OVER (ORDER BY ROUND(monetary_value,2) DESC) AS monetary_rank
    FROM rfm_base
),
rfm_weighted AS (
    SELECT
        CustomerID,
        recency_days,
        frequency,
        monetary_value,
        recency_rank,
        frequency_rank,
        monetary_rank,
        (recency_rank + frequency_rank + monetary_rank) AS rfm_total
    FROM rfm_scores
)
SELECT
    CustomerID,
    recency_days,
    frequency,
    monetary_value,
    recency_rank,
    frequency_rank,
    monetary_rank,
    rfm_total,
    CASE
        WHEN rfm_total >= 9 THEN 'Premium'
        WHEN rfm_total >= 7 THEN 'Gold'
        WHEN rfm_total >= 5 THEN 'Silver'
        ELSE 'Standard'
    END AS rfm_segment
FROM rfm_weighted;


