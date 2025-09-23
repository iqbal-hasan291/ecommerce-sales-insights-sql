# ecommerce-sales-insights-sql

📝 Overview

I analysed a full year of e-commerce transaction data (Jan–Dec 2019) to understand sales performance, customer behaviour, marketing impact, and retention trends.
Using SQL, I calculated KPIs, built cohorts, segmented customers, and generated actionable insights for business decisions.

This project simulates the kind of analysis a real e-commerce analytics team would deliver.

🛠️ Tools Used

MySQL – data cleaning, transformations, calculations

CTEs & Views – to modularise complex queries

Power BI/Excel (optional) – for charts & dashboards

GitHub – version control and sharing

📜 Workflow (my story)

Data Understanding

Transaction data (orders, prices, delivery charges)

Customer data (gender, location, tenure)

Discount coupons, marketing spend, tax rates

Data Preparation

Fixed date formats, handled nulls, joined multiple tables

Created reusable invoice_calc view to calculate invoice value correctly

Analysis Levels

Level 1–3: Revenue, top transactions, monthly orders, new customers

Level 4: Trends & seasonality – daily revenue, day of week, location, seasonal categories

Level 5: Marketing impact – spend vs revenue, spend % of revenue

Level 6: RFM analysis & segmentation into Premium, Gold, Silver, Standard

Level 7: Cross-sell – product pairs for market basket analysis

Level 8: Customer behaviour – average days between purchases, next purchase group prediction

Level 9: Cohort analysis – retention matrix, lifetime revenue per cohort

Challenges

Cleaning inconsistent date formats (%m/%d/%Y vs %b)

Handling missing discounts and GST values

Creating retention and churn logic correctly

Sorting months chronologically while keeping names readable

Solutions

Used STR_TO_DATE and DATE_FORMAT to normalise dates

Used COALESCE to handle null discounts/GST

Created views (invoice_calc, customer_cohort) for reusability

Used CTEs for complex calculations (RFM, churn, retention matrix)
