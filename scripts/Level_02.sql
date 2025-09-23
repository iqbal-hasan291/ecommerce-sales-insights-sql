-- -----------------------------------------------------------
-- 🗂️ Level 2: Customer Acquisition & Retention
-- -----------------------------------------------------------

-- 6️. Find how many new customers were acquired each month.
-- Logic: 1. Get first transaction date for each customer.
       -- 2. Count unique customers by month of their first purchase.

WITH first_purchase AS (
  SELECT 
    CustomerID,
    MIN(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) AS first_txn_date
  FROM online_sales
  GROUP BY CustomerID
)
SELECT 
  DATE_FORMAT(first_txn_date, '%M') AS month_name,
  COUNT(DISTINCT CustomerID) AS new_customers
FROM first_purchase
GROUP BY MONTH(first_txn_date), month_name
ORDER BY MONTH(first_txn_date);

-- -----------------------------------------------------------
-- 7️. Find how many customers from each cohort purchased again later.
-- Logic:
-- 1. Find the cohort month = first purchase month.
-- 2. Join back to all transactions.
-- 3. Count distinct customers for each cohort vs. transaction month.
-- -----------------------------------------------------------

WITH cohort AS (
  SELECT CustomerID, MIN(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) AS first_txn_date
  FROM online_sales
  GROUP BY CustomerID
),
transactions AS (
  SELECT CustomerID, STR_TO_DATE(Transaction_Date, '%m/%d/%Y') AS txn_date
  FROM online_sales
)
SELECT
  DATE_FORMAT(c.first_txn_date, '%M') AS cohort_month,
  DATE_FORMAT(t.txn_date, '%M') AS txn_month,
  COUNT(DISTINCT t.CustomerID) AS repeat_customers
FROM cohort c
JOIN transactions t ON c.CustomerID = t.CustomerID
GROUP BY MONTH(c.first_txn_date), cohort_month, MONTH(t.txn_date), txn_month
ORDER BY MONTH(c.first_txn_date), MONTH(t.txn_date);

-- -----------------------------------------------------------
-- 8️. Find the month with the highest repeat rate.
-- Logic:
-- 1. Join each transaction to its cohort month.
-- 2. If txn month > cohort month, it’s a repeat.
-- 3. Count repeat vs. total customers for each txn month.
-- -----------------------------------------------------------

WITH cohort AS (
  SELECT CustomerID, MIN(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) AS first_txn_date
  FROM online_sales
  GROUP BY CustomerID
),
transactions AS (
  SELECT CustomerID, STR_TO_DATE(Transaction_Date, '%m/%d/%Y') AS txn_date
  FROM online_sales
),
joined AS (
  SELECT
    t.CustomerID,
    MONTH(t.txn_date) AS txn_month_num,
    DATE_FORMAT(t.txn_date, '%M') AS txn_month_name,
    MONTH(c.first_txn_date) AS cohort_month_num
  FROM transactions t
  JOIN cohort c ON t.CustomerID = c.CustomerID
)
SELECT
  txn_month_name AS txn_month,
  COUNT(DISTINCT CASE WHEN txn_month_num > cohort_month_num THEN CustomerID END) AS repeat_customers,
  COUNT(DISTINCT CustomerID) AS total_customers,
  ROUND(COUNT(DISTINCT CASE WHEN txn_month_num > cohort_month_num THEN CustomerID END) / COUNT(DISTINCT CustomerID) * 100, 2) AS repeat_rate_pct
FROM joined
GROUP BY txn_month_num, txn_month_name
ORDER BY txn_month_num;

-- -----------------------------------------------------------
-- 9️. Find churn rate month by month.
-- Logic:
-- 1. Find each customer’s last purchase month.
-- 2. Count customers whose last txn matches current month = churned.
-- 3. Divide by total active customers that month.
-- -----------------------------------------------------------


WITH customer_txns AS (
  SELECT CustomerID, STR_TO_DATE(Transaction_Date, '%m/%d/%Y') AS txn_date
  FROM online_sales
),
customer_last_txn AS (
  SELECT CustomerID, DATE_FORMAT(MAX(txn_date), '%Y-%m') AS last_txn_month
  FROM customer_txns
  GROUP BY CustomerID
),
monthly_customers AS (
  SELECT 
    DATE_FORMAT(txn_date, '%Y-%m') AS txn_month,
    MONTH(txn_date) AS txn_month_num,
    DATE_FORMAT(txn_date, '%M') AS txn_month_name,
    CustomerID
  FROM customer_txns
  GROUP BY txn_month, txn_month_num, txn_month_name, CustomerID
)
SELECT
  m.txn_month_name AS txn_month,
  COUNT(DISTINCT CASE WHEN m.txn_month = cl.last_txn_month THEN m.CustomerID END) AS churned_customers,
  COUNT(DISTINCT m.CustomerID) AS total_customers,
  ROUND(COUNT(DISTINCT CASE WHEN m.txn_month = cl.last_txn_month THEN m.CustomerID END) / COUNT(DISTINCT m.CustomerID) * 100, 2) AS churn_rate_pct
FROM monthly_customers m
JOIN customer_last_txn cl ON m.CustomerID = cl.CustomerID
GROUP BY m.txn_month_num, m.txn_month_name
ORDER BY m.txn_month_num;

-- -----------------------------------------------------------
-- 10. Find customers with only 1 purchase in 2019.
-- Logic:
-- 1. Filter for 2019 transactions only.
-- 2. Group by customer, count transactions.
-- 3. Keep customers with only 1 transaction
-- -----------------------------------------------------------


SELECT
  CustomerID,
  COUNT(Transaction_ID) AS txn_count
FROM online_sales
WHERE YEAR(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) = 2019
GROUP BY CustomerID
HAVING txn_count = 1;
