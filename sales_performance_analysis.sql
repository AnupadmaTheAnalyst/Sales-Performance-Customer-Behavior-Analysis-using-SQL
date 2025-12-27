/*
Project: Sales Performance Analysis
Objective: Analyze revenue trends, seasonality, product performance, and deal size contribution to support sales planning and forecasting.
Dataset: sales_dataset
*/

/**Revenue Trends & Seasonality**/
-- Business Question:
-- How is overall sales performance trending across years and months?
-- Insight Type: Revenue trends & seasonality

/*Total sales for each year*/
select YEAR_ID as year, round(sum(SALES),2) as total_sales
from sales_dataset
group by YEAR_ID;

/*Monthly sales totals for all years.*/
select monthname(ORDERDATE) as Month, round(sum(SALES),2) as Total_sales
from sales_dataset
group by monthname(ORDERDATE);

/*Total number of orders placed each year*/
select YEAR_ID as Year, count(distinct ORDERNUMBER) as Total_orders
from sales_dataset
group by YEAR_ID
order by Total_orders desc;

/*Top 3 months with the highest total sales across all years.*/
select monthname(ORDERDATE) as Month, round(sum(SALES),2) as Highest_sales
from sales_dataset
group by monthname(ORDERDATE)
order by Highest_sales desc limit 3;

/*Running total (cumulative sales) for each month across all years.*/
select MONTH_ID, YEAR_ID, Monthly_sales, round(sum(Monthly_sales) over(order by YEAR_ID, MONTH_ID),2) as running_total
from (select MONTH_ID, YEAR_ID, round(sum(SALES),2) as Monthly_sales
	  from sales_dataset
      group by MONTH_ID, YEAR_ID)t
order by YEAR_ID, MONTH_ID;

-- Business Insight:
-- Helps leadership identify peak seasons, growth years, and revenue stability.

/**Best-Performing Product Lines**/
-- Business Question:
-- Which product lines and products contribute the most to revenue?
-- Insight Type: Product performance analysis

/*Best-selling product based on total revenue.*/
select PRODUCTLINE, round(sum(SALES),2) as Total_revenue
from sales_dataset
group by PRODUCTLINE
order by Total_revenue desc limit 1;

/*Total sales by product line*/
select PRODUCTLINE, round(sum(SALES),2) as Total_sales
from sales_dataset
group by PRODUCTLINE
order by Total_sales desc;

/*Top 5 product codes by total revenue.*/
select PRODUCTCODE, round(sum(SALES),2) as Total_revenue
from sales_dataset
group by PRODUCTCODE
order by Total_revenue desc limit 5;

-- Business Insight:
-- Enables focus on high-performing products and optimization of product portfolio.

/**Deal Size Performance**/
-- Business Question:
-- How do different deal sizes impact total revenue?
-- Insight Type: Deal size performance

/*Sales performance by deal size category.*/
 select DEALSIZE, round(sum(SALES),2) as sales
 from sales_dataset
 group by DEALSIZE;
 
/*Total revenue generated from “Large” deal size orders.*/
select DEALSIZE, sum(SALES) as Total_revenue
from sales_dataset
where DEALSIZE like '%Large%'
group by DEALSIZE;

-- Business Insight:
-- Large deals may drive disproportionate revenue, guiding pricing and negotiation strategy.

/**Sales Growth Momentum**/
-- Business Question:
-- Which periods show the highest increase in sales momentum?
-- Insight Type: Sales growth momentum

/*Month with the highest increase in sales compared to the previous month.*/
select MONTH_ID, round(sales_increase,2) as Highest_sales_increased
from (select MONTH_ID, monthly_sales-lag(monthly_sales) over(order by MONTH_ID) as sales_increase
	  from (select MONTH_ID, sum(SALES) as monthly_sales
			from sales_dataset
            group by MONTH_ID)t)x
order by sales_increase desc
limit 1;

-- Business Insight:
-- Highlights growth spikes and supports proactive sales strategy during high-momentum periods.
