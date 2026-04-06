# E-Commerce-Data-Analysis

**Executive Summary**

This project explores e-commerce sales and return behavior from January 2024 to December 2025 using SQL and Power BI. After cleaning the dataset, 4,975 usable rows remained from the original 5,000. The analysis found an overall upward sales trend across the two-year period, with a sharp spike in July 2024, a drop in August 2024, and more stable growth in Q4 2025. Fashion recorded the highest return rate, while higher discounts did not show a clear positive impact on sales. Credit Card was the most common payment method, and Electronics, Home, and Fashion were the strongest sales categories.

**Business Problem:**

A mid-sized e-commerce company wants to understand monthly sales performance, order patterns, and return behavior across categories and regions.

**Dataset Overview:**

- 1 row represents 1 customer order
- 5000 rows and 11 columns
- date range: January 2024 - December 2025

**Methodology:**

1. SQL query that extracts, cleans, and transforms the data from the database.
2. Graphs in Power BI for EDA process and data visualization

**Skills:**

- SQL: CTEs, Joins, Case, aggregate functions
- Power BI: DAX, writing functions, ETL

**Cleaning Summary:**

- 18 duplicates removed
- 6 rows with with the same order_id but conflicting values in other columns were removed
- Standardize the date format on order_date column
- Replacing inconsistent values (blank, N/A) into NULL values
- Fixing data type so it’s in line with the value
- result: 4975 usable rows, with some NULL values retained

**EDA Questions:**

1. How do monthly sales trends change over time?
2. Which regions and cities generate the most sales?
3. Which categories have the highest return rates?
4. Do higher discounts seem to affect sales amount or returns?
5. Which payment methods are most common, and do they differ by customer type or region?


**Findings:**

<img width="1276" height="349" alt="image" src="https://github.com/user-attachments/assets/e5827a78-dd45-46e8-80c7-32f61793b407" />

Sales trend is upward overall on 2024 - 2025. There’s volatility with notable peaks in July 2024 and a sharp drop in August 2024. And a stable increase across Q4 2025.



<img width="479" height="326" alt="sales region" src="https://github.com/user-attachments/assets/c020e283-12c1-4647-8632-958fcabfa059" />
<img width="1276" height="349" alt="sales trend" src="https://github.com/user-attachments/assets/0fbfc53b-d748-4757-80e5-fb97a439e91e" />

West Region (25,754M) and Seattle (4,587M) generate the most sales




<img width="1170" height="423" alt="return" src="https://github.com/user-attachments/assets/ef6f5e99-f83a-4c2d-9e97-078ddaae4569" />

Fashion categories have the highest return rates at 30.27%  (148 orders) across 2024-2025



<img width="769" height="274" alt="disc" src="https://github.com/user-attachments/assets/cb7b9a8b-bdc0-4836-b3a8-4e88ff2c5584" />

Higher discount levels do not show a clear uplift in sales in this dataset. Very high discount levels also appear to have higher return rates, but the sample size is too small to draw a firm conclusion.


<img width="839" height="410" alt="payment method" src="https://github.com/user-attachments/assets/590295ea-2cc2-4a66-8732-59520b58224b" />

Credit Card is the most common payment method


<img width="979" height="296" alt="sales category" src="https://github.com/user-attachments/assets/13712b18-59ec-4b3b-b9f2-21b2facf65f1" />

The categories that generates most sales are Electronics, Home, and Fashion



 **Recommended Next Steps:**

- Investigate the August sales drop by comparing category, region, and payment method mix against July.
- Review whether the July spike was driven by a specific region, city, or category rather than broad business growth.
- Analyze return behavior in Fashion more deeply to identify whether certain products, price bands, or discount levels are driving higher returns.
- Test whether the West region’s higher sales come from higher order volume or higher average order value.










