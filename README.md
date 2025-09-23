# 🛒 E-Commerce Sales Analysis (SQL)

##  Project Overview
This project is a complete end-to-end analysis of an e-commerce dataset.Using SQL I explored KPIs, customer behavior, marketing impact, sales trends,  cohort retention, rfm segmentation.  It covers **8 levels** of progressively advanced business questions — from basic KPIs to RFM segmentation and cohort analysis — to provide actionable insights.

##  Problem Statement
Businesses often collect large amounts of transactional data but struggle to turn it into insights. This project demonstrates how to:
- Clean and model raw transactional data  
- Answer key business questions (sales, marketing, customer behavior)  
- Build dashboards that help decision-makers act faster

## 📊 Level-wise Findings  

| Level | Focus Area | Key Findings |
|-------|------------|--------------|
| **Level 1 – Basic KPIs** | Total revenue, orders, customers | Revenue **4.71 M**, Orders **25,061**, Quantity Sold **238 K**, AOV **188.2**, Customers **1,468** |
| **Level 2 – Coupons & Discounts** | Coupon usage, discounts | **25,065** purchases used a coupon; **Nest-USA** had the highest total discount amount |
| **Level 3 – Product & Location Performance** | Top products, top revenue | Highest product revenue: **Nest – USA** |
| **Level 4 – Monthly Trends** | Transactions & quantity by month | Total transactions peaked in **December**, total quantity sold peaked in **August** |
| **Level 5 – Customer Insights** | High AOV customers | Customer **12935** had the highest AOV: **4,506** |
| **Level 6 – RFM Segmentation** | Premium vs. Gold vs. Silver vs. Standard | Customers segmented into **Premium, Gold, Silver, Standard** tiers |
| **Level 7 – Cohort Analysis** | Repeat customers & retention | **August** had the highest number of repeat customers; **November** had the highest repeat rate |
| **Level 8 – Marketing Analysis** | Spend & impact | **December** had the highest marketing spend; **June** had the highest marketing impact on revenue |
| **Level 9 – Channels** | Channel comparison | **Offline** sales generated the most revenue |
| **Sales Trends** | Day-of-week sales | **Friday** had the highest sales volume |
| **Location Analysis** | Top revenue location | **Chicago** generated the highest revenue |

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

