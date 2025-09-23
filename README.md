# 🛒 E-Commerce Sales Analysis (SQL)

##  Project Overview
This project is a complete end-to-end analysis of an e-commerce dataset.Using SQL I explored KPIs, customer behavior, marketing impact, sales trends,  cohort retention, rfm segmentation. It covers **8 levels** of progressively advanced business questions — from basic KPIs to RFM segmentation and cohort analysis — to provide actionable insights.

##  Problem Statement
Businesses often collect large amounts of transactional data but struggle to turn it into insights. This project demonstrates how to:
- Clean and model raw transactional data  
- Answer key business questions (sales, marketing, customer behavior)  
- Build dashboards that help decision-makers act faster

##  Tools and Technology Used
- **SQL (MySQL)** – Data cleaning, transformations, and answering business questions  
- **Excel** – Quick checks and initial exploration  

##  Workflow 
I divided the analysis into multiple levels to mirror real-world problem solving:
1. **Level 1–3:** Basic KPIs, coupons, discounts, and sales trends  
2. **Level 4–6:** Marketing spend analysis, RFM segmentation, and cross-sell patterns  
3. **Level 7–8:** Cohort analysis, retention matrix, lifetime value and insights  

Each level builds on the previous one — similar to how analysts iterate in a real job.

###  Challenges Faced
- Cleaning inconsistent dates and coupon codes  
- Joining multiple tables (sales, discount, tax, marketing)  
- Building correct cohort/retention logic  
- Translating SQL results into clear, impactful visuals  

I overcame these by writing modular SQL scripts and validating each step with sample outputs.

##  Level-wise Findings  

| Level | Focus Area | Key Findings |
|-------|------------|--------------|
| **Basic KPIs** | Total revenue, orders, customers | Revenue **4.71 M**, Orders **25,061**, Quantity Sold **238 K**, AOV **188.2**, Customers **1,468** |
| **Level 1 – Revenue & Basic Transaction Metrics** | Revenue, Orders, Products | Highest product revenue: **Nest – USA**; Total transactions peaked in **December**; Total quantity sold peaked in **August** |
| **Level 2 – Customer Acquisition & Retention** | New Customers, Retention, Retention Rate (%) | **August** had the highest repeat customers; **November** had the highest repeat rate |
| **Level 3 – Discount & Coupon Impact** | Coupon usage, Discount impact | **25,065** purchases used a coupon; **Nest-USA** had the highest total discount amount |
| **Level 4 – Sales Trends & Seasonality** | Monthly & Weekly Trends, Day-of-Week Sales, Location | **Friday** had the highest sales volume; **Chicago** generated the highest revenue |
| **Level 5 – Marketing Effectiveness** | Coupon impact, Discount impact | **December** had the highest marketing spend; **June** had the highest marketing impact on revenue; **Offline** sales generated the most revenue |
| **Level 6 – RFM Segmentation** | Premium, Gold, Silver, Standard | Customers segmented into **Premium, Gold, Silver, Standard** tiers |
| **Level 7 – Predictive Prep** | Average Days Between Purchases | Calculated average days between purchases and total orders for each customer |
| **Level 8 – Cohort Analysis** | Cohort Month, Retention, Churn (%) | Built cohorts by first purchase month; Calculated retention % and churn % over time |


##  Key Insights  

- **High Discounts Drive Revenue** – The **Nest-USA** product achieved the highest revenue largely because it offered the largest discounts, indicating that price incentives strongly influence purchase volume.  

- **Marketing Spend Boosts Transactions** – **December** recorded the highest number of transactions, correlating with the month’s peak marketing spend. This shows that increased marketing investment directly drives sales activity.  

- **Retention Dynamics** – **November** achieved the highest repeat-customer rate, suggesting successful re-engagement campaigns or seasonal loyalty patterns.  

- **Sales Pattern by Day** – **Friday** consistently saw the most sales, likely because customers purchase ahead of the **Saturday off-day**, indicating a predictable weekly demand cycle.  

- **Discount & Coupon Impact** – Over **25,000** purchases used a coupon, underscoring the strong effect of promotional strategies on customer behaviour and revenue generation.  

- **Segmented Customer Value** – RFM analysis revealed distinct **Premium, Gold, Silver, and Standard** segments, enabling targeted marketing and personalised offers.  

- **Seasonality & Planning** – Peaks in **quantity sold (August)** and **transactions (December)** provide a clear picture of seasonal demand trends, guiding inventory and marketing planning.  

- **Predictive Readiness** – Average days between purchases and cohort retention rates lay the groundwork for churn prediction and lifetime value modelling.  

##  Conclusion
This project shows how raw transactional data can be turned into actionable business insights using SQL and Power BI.  
It also demonstrates a repeatable workflow for analyzing any retail/e-commerce dataset.

---

## 👤 Author  

**Md Iqbal Hossain**  
Data Analyst | Business Intelligence |   

🔗 [LinkedIn Profile](https://www.linkedin.com/in/iqbalhossain29/)

Feel free to connect with me for feedback, collaboration, or data-driven discussions!  

