# 🛒 E-Commerce Sales Analysis (SQL)

##  Project Overview
This project is a complete end-to-end analysis of an e-commerce dataset.Using SQL I explored KPIs, customer behavior, marketing impact, sales trends,  cohort retention, rfm segmentation.  It covers **8 levels** of progressively advanced business questions — from basic KPIs to RFM segmentation and cohort analysis — to provide actionable insights.

##  Problem Statement
Businesses often collect large amounts of transactional data but struggle to turn it into insights. This project demonstrates how to:
- Clean and model raw transactional data  
- Answer key business questions (sales, marketing, customer behavior)  
- Build dashboards that help decision-makers act faster

##  Levels & Key Questions 

 **Level 1:** Revenue & Basic Transaction Metrics

1️⃣ Calculate total invoice amount for each transaction.

2️⃣ Find the top 10 transactions with the highest invoice value.

3️⃣ Calculate total revenue for each product category.

4️⃣ List the total number of transactions and total quantity sold for each month.

5️⃣ Find the average order value (AOV) for each customer.

 **Level 2:** Customer Acquisition & Retention

6️⃣ How many new customers were acquired each month?

7️⃣ Show month-on-month retention: How many customers from each cohort month purchased again in future months?

8️⃣ Which month had the highest repeat rate?

9️⃣ What is the churn rate month by month?

10️⃣ Which customers have made only one purchase in 2019?

 **Level 3:** Discount & Coupon Impact

1️⃣1️⃣ How many transactions used a coupon?

1️⃣2️⃣ Calculate total discount amount given for each category.

1️⃣3️⃣ Compare average revenue per transaction for transactions with and without coupon applied.

 **Level 4:** Sales Trends & Seasonality

1️⃣4️⃣ Show daily revenue trend across the year.

1️⃣5️⃣ Which day of the week has the highest sales?

1️⃣6️⃣ Which location generates the most revenue?

1️⃣7️⃣ Which product category shows strong seasonality?

**Level 5:** Marketing Effectiveness

1️⃣8️⃣ Calculate total revenue, total marketing spend, and marketing spend as % of revenue by month.

1️⃣9️⃣ Is there a correlation between marketing spend and revenue growth? (Prepare the data for visualization)

2️⃣0️⃣ Which marketing channel (online/offline) spends more?

 **Level 6:** Customer Segmentation

2️⃣1️⃣ Calculate RFM values for each customer:

2️⃣2️⃣ Segment customers as Premium, Gold, Silver, Standard based on RFM percentiles.

 **Level 7:** Predictive Prep

2️⃣4️⃣ Calculate average days between purchases for repeat customers.

2️⃣5️⃣ Assign customers to next purchase group (0–30 days, 30–60 days, 60–90 days, 90+ days).

 **Level 8:** Cohort Analysis

2️⃣6️⃣ Create cohorts by month of first purchase.

2️⃣7️⃣ Show retention matrix: % of cohort retained in following months.

2️⃣8️⃣ Which cohort has the highest lifetime revenue?

##  Tools and Technology Used
- **SQL (MySQL)** – Data cleaning, transformations, and answering business questions  
- **Power BI** – Interactive dashboards and visualizations  
- **Excel** – Quick checks and initial exploration  


##  Workflow 
I divided the analysis into multiple levels to mirror real-world problem solving:
1. **Level 1–3:** Basic KPIs, coupons, discounts, and sales trends  
2. **Level 4–6:** Marketing spend analysis, RFM segmentation, and cross-sell patterns  
3. **Level 7–9:** Cohort analysis, retention matrix, lifetime value and insights  

Each level builds on the previous one — similar to how analysts iterate in a real job.

###  Challenges Faced
- Cleaning inconsistent dates and coupon codes  
- Joining multiple tables (sales, discount, tax, marketing)  
- Building correct cohort/retention logic  
- Translating SQL results into clear, impactful visuals  

I overcame these by writing modular SQL scripts and validating each step with sample outputs.


##  Insights
- **Revenue grew steadily** in Q3 with a peak on weekends  
- **Marketing spend** on online channels produced higher ROI than offline  
- **Premium customers (RFM)** generated 3x the revenue of Standard customers  
- **Cohort retention** improved after targeted discounts were introduced  
- **Cross-sell**: Products A and B are most frequently bought together  

##  Conclusion
This project shows how raw transactional data can be turned into actionable business insights using SQL and Power BI.  
It also demonstrates a repeatable workflow for analyzing any retail/e-commerce dataset.

