## 📌 Business Context
The company operates in a global sales environment with multiple product lines, deal sizes, and customer segments.
Management wants to analyze historical sales data to understand revenue patterns, customer behavior, and operational efficiency in order to support better business decisions.

This project uses SQL to answer practical business questions related to sales performance, customer contribution, deal-size effectiveness, and order behavior.

---

## 🎯 Project Objectives
- Analyze overall sales performance across years, months, regions, and product lines
- Identify high-value customers and top-performing products
- Understand deal-size impact on revenue
- Analyze customer ordering behavior and retention
- Detect operational issues such as order cancellations
- Apply SQL from basic to advanced business scenarios

---

## 🗂 Dataset Overview
- **Dataset Name:** `sales_data_sample.csv`
- **Data Type:** Historical sales transaction data
- **Key Columns:**
  - `ORDERNUMBER`, `ORDERDATE`, `YEAR_ID`, `MONTH_ID`
  - `CUSTOMERNAME`, `ADDRESS`
  - `PRODUCTLINE`, `PRODUCTCODE`
  - `DEALSIZE`, `STATUS`
  - `QUANTITYORDERED`, `SALES`

---

## 🛠 Tools & Technologies
- **SQL** (MySQL-compatible syntax)
- **GitHub** (project version control & portfolio)
- **Dataset:** Sales transaction data (CSV format)

---
## 🚀 How to Run This Project

1. **Import the CSV file** (`sales_data_sample.csv`) into your SQL database (MySQL, SQLite, etc.).
2. Create a table named `sales_dataset`.
3. Open your SQL client (DBeaver, MySQL Workbench, etc.).
4. Execute the SQL files in this order:
   - `sales_performance_analysis.sql`
   - `customer_behavior_analysis.sql`
   - `operations_and_risk_analysis.sql`
5. Review the query results to see insights for each business question.
---
| Business Question                            | SQL File                           | Output                   |
| -------------------------------------------- | ---------------------------------- | ------------------------ |
| What are revenue trends by year & month?     | `sales_performance_analysis.sql`   | Seasonal patterns        |
| Which product lines contribute most revenue? | `sales_performance_analysis.sql`   | Product prioritization   |
| Who are high-value customers?                | `customer_behavior_analysis.sql`   | Segment targeting        |
| What are key operational risks?              | `operations_and_risk_analysis.sql` | Risk & efficiency checks |
---
## 🔧 SQL Concepts Used
- Aggregations, subqueries
- Window functions (RANK, LAG)
- Conditional logic (CASE WHEN)
- Time-series analysis
---
## 🔍 Key Insights
- Large deal sizes contribute disproportionately to total revenue.
- A small group of customers generates a significant portion of overall sales.
- Certain regions exhibit higher cancellation rates, indicating potential operational risks.
- Some product lines perform strongly only within specific deal size categories.

---
## 📌 Expected Business Actions

- Increase inventory ahead of high-revenue months.
- Target marketing to high-value customer segments.
- Investigate regions with high cancellation risk.
- Squeeze more revenue from smaller deal sizes with targeted promotions.
---

## 💼 Business Impact
- Helps sales leadership identify high-value customers and top-performing regions.
- Supports pricing strategy and deal-size optimization decisions.
- Assists operations teams in identifying and reducing order cancellations.
- Enables data-driven quarterly and annual sales planning.

---
## 🧠 Challenges & Learnings

- Handling NULL values and ensuring accurate aggregations.
- Understanding how window functions improve trend analysis.
- Translating business questions into robust SQL logic.



