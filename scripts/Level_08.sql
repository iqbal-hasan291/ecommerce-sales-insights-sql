--  Level 9: Cohort Analysis

-- 2️6️ Create cohorts by month of first purchase.
SELECT
    CustomerID,
    DATE_FORMAT(
        MIN(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')), 
        '%Y-%m'
    ) AS cohort_month
FROM online_sales
GROUP BY CustomerID;



-- Find each customer's first purchase month = cohort_month
CREATE OR REPLACE VIEW customer_cohort AS
SELECT
    CustomerID,
    DATE_FORMAT(MIN(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')), '%Y-%m') AS cohort_month
FROM online_sales
GROUP BY CustomerID;


-- 2️7️ Show retention matrix: % of cohort retained in following months.
-- Join transactions with cohort info and calculate retention
WITH customer_activity AS (
    SELECT
        c.CustomerID,
        c.cohort_month,
        DATE_FORMAT(STR_TO_DATE(o.Transaction_Date, '%m/%d/%Y'), '%Y-%m') AS txn_month
    FROM online_sales o
    JOIN customer_cohort c ON o.CustomerID = c.CustomerID
),
cohort_counts AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT CustomerID) AS cohort_size
    FROM customer_activity
    GROUP BY cohort_month
),
retention AS (
    SELECT
        cohort_month,
        txn_month,
        COUNT(DISTINCT CustomerID) AS retained_customers
    FROM customer_activity
    GROUP BY cohort_month, txn_month
)
SELECT
    r.cohort_month,
    r.txn_month,
    r.retained_customers,
    ROUND(r.retained_customers * 100.0 / c.cohort_size, 2) AS retention_rate_pct
FROM retention r
JOIN cohort_counts c ON r.cohort_month = c.cohort_month
ORDER BY cohort_month, txn_month;


-- 2️8️ Which cohort has the highest lifetime revenue?
-- Calculate total revenue per cohort
SELECT
    c.cohort_month,
    SUM(i.invoice_amount) AS lifetime_revenue
FROM invoice_calc i
JOIN customer_cohort c ON i.CustomerID = c.CustomerID
GROUP BY c.cohort_month
ORDER BY lifetime_revenue DESC
LIMIT 1;
