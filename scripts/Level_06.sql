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
CREATE VIEW RFM_Customer_Scores AS
WITH rfm_base AS (
    SELECT 
        CustomerID,
        MAX(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) AS last_purchase_date,
        COUNT(DISTINCT Transaction_ID) AS frequency,
        SUM(invoice_amount) AS monetary_value
    FROM invoice_calc
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    DATEDIFF('2019-12-31', last_purchase_date) AS recency_days,
    frequency,
    ROUND(monetary_value, 2) AS monetary_value
FROM rfm_base;

-- Step 2: Rank customers by Recency, Frequency, Monetary
WITH rfm_scores AS (
    SELECT 
        CustomerID,
        recency_days,
        frequency,
        monetary_value,
        NTILE(4) OVER (ORDER BY recency_days ASC) AS recency_rank,   -- lower recency = better
        NTILE(4) OVER (ORDER BY frequency DESC) AS frequency_rank,   -- higher frequency = better
        NTILE(4) OVER (ORDER BY monetary_value DESC) AS monetary_rank -- higher spend = better
    FROM RFM_Customer_Scores
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
        (recency_rank + frequency_rank + monetary_rank) AS rfm_total -- combined score
    FROM rfm_scores
)
-- Step 3: Assign segment based on total RFM score
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
FROM rfm_weighted
ORDER BY rfm_total DESC;

