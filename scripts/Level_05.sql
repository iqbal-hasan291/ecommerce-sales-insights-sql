--  Level 5: Marketing Effectiveness

-- 1️8. Calculate total revenue, total marketing spend, 
WITH revenue_per_day AS (
    SELECT
        DATE(STR_TO_DATE(Transaction_Date, '%m/%d/%Y')) AS txn_date,
        SUM(invoice_amount) AS daily_revenue
    FROM invoice_calc
    GROUP BY txn_date
),
revenue_per_month AS (
    SELECT
        DATE_FORMAT(txn_date, '%Y-%m') AS month,
        SUM(daily_revenue) AS total_revenue
    FROM revenue_per_day
    GROUP BY month
),
marketing_per_month AS (
    SELECT
        DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS month,
        SUM(Offline_Spend + Online_Spend) AS total_marketing_spend
    FROM marketing_spend
    GROUP BY month
)
SELECT
    r.month,
    ROUND(r.total_revenue, 2) AS total_revenue,
    ROUND(m.total_marketing_spend, 2) AS total_marketing_spend,
    ROUND((m.total_marketing_spend / r.total_revenue) * 100, 2) 
        AS marketing_pct_of_revenue
FROM revenue_per_month r
LEFT JOIN marketing_per_month m 
    ON r.month = m.month
ORDER BY r.month;


-- 1️9. Is there a correlation between marketing spend and revenue growth?
WITH revenue_trends AS (
    SELECT
        month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY month) AS prev_revenue
    FROM revenue_per_month
),
marketing_trends AS (
    SELECT
        month,
        total_marketing_spend,
        LAG(total_marketing_spend) OVER (ORDER BY month) AS prev_spend
    FROM marketing_per_month
)
SELECT
    r.month,
    ROUND(((r.total_revenue - r.prev_revenue) / r.prev_revenue) * 100, 2) 
        AS revenue_growth_pct,
    ROUND(((m.total_marketing_spend - m.prev_spend) / m.prev_spend) * 100, 2) 
        AS marketing_growth_pct
FROM revenue_trends r
JOIN marketing_trends m 
    ON r.month = m.month
ORDER BY r.month;


-- 2️0. Which marketing channel (online/offline) spends more?
SELECT 
    'Offline' AS channel,
    ROUND(SUM(Offline_Spend), 2) AS total_spend
FROM marketing_spend

UNION ALL

SELECT 
    'Online' AS channel,
    ROUND(SUM(Online_Spend), 2) AS total_spend
FROM marketing_spend;
