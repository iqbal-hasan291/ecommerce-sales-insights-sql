-- Level 8: Predictive Prep

-- 24. Calculate average days between purchases for repeat customers
-- Steps:
--   1. Extract transaction dates per customer
--   2. Use LAG() to calculate the gap between consecutive purchases
--   3. Compute average days between purchases for each customer

WITH txn_dates AS (
    SELECT
        CustomerID,
        STR_TO_DATE(Transaction_Date, '%m/%d/%Y') AS txn_date
    FROM online_sales
),
txn_lags AS (
    SELECT
        CustomerID,
        txn_date,
        LAG(txn_date) OVER (PARTITION BY CustomerID ORDER BY txn_date) AS prev_txn_date
    FROM txn_dates
),
txn_diffs AS (
    SELECT
        CustomerID,
        DATEDIFF(txn_date, prev_txn_date) AS days_between
    FROM txn_lags
    WHERE prev_txn_date IS NOT NULL
)
SELECT
    CustomerID,
    ROUND(AVG(days_between), 2) AS avg_days_between_purchases, -- average purchase gap
    COUNT(*) + 1 AS total_purchases                            -- total purchase count
FROM txn_diffs
GROUP BY CustomerID
HAVING total_purchases > 1 -- only include repeat customers
ORDER BY avg_days_between_purchases;

-- 25. Assign customers to next purchase group based on average purchase frequency
-- Groups:
--   0–30 days
--   30–60 days
--   60–90 days
--   90+ days

CREATE VIEW Avg_Days_Between_Purchases AS
WITH txn_dates AS (
    SELECT
        CustomerID,
        STR_TO_DATE(Transaction_Date, '%m/%d/%Y') AS txn_date
    FROM online_sales
),
txn_lags AS (
    SELECT
        CustomerID,
        txn_date,
        LAG(txn_date) OVER (PARTITION BY CustomerID ORDER BY txn_date) AS prev_txn_date
    FROM txn_dates
),
txn_diffs AS (
    SELECT
        CustomerID,
        DATEDIFF(txn_date, prev_txn_date) AS days_between
    FROM txn_lags
    WHERE prev_txn_date IS NOT NULL
)
SELECT
    CustomerID,
    ROUND(AVG(days_between), 2) AS avg_days_between_purchases,
    COUNT(*) + 1 AS total_purchases
FROM txn_diffs
GROUP BY CustomerID
HAVING total_purchases > 1;

-- Assign customers into groups based on predicted next purchase window
SELECT
    CustomerID,
    avg_days_between_purchases,
    CASE
        WHEN avg_days_between_purchases <= 30 THEN '0–30 days'
        WHEN avg_days_between_purchases <= 60 THEN '30–60 days'
        WHEN avg_days_between_purchases <= 90 THEN '60–90 days'
        ELSE '90+ days'
    END AS next_purchase_group
FROM Avg_Days_Between_Purchases
ORDER BY avg_days_between_purchases;
