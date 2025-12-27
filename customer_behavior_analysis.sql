/*
Project: Customer Behavior Analysis
Objective: Understand customer segmentation, retention, loyalty, and value contribution.
Dataset: sales_dataset
*/

/**Customer Segmentation**/
-- Business Question:
-- How are customers distributed across orders and product engagement?
-- Insight Type: Customer segmentation

/*Top 5 customers by total amount spent.*/
select CUSTOMERNAME as Customers, round(sum(SALES),2) as Total_amount
from sales_dataset
group by CUSTOMERNAME
order by Total_amount desc limit 5;

/*Unique customer count*/
select count(distinct CUSTOMERNAME) as Customers
from sales_dataset;

/*Customers ordering multiple product lines*/
select CUSTOMERNAME, count(distinct PRODUCTLINE) as Count
from sales_dataset
group by CUSTOMERNAME
having count(distinct PRODUCTLINE)>1;

-- Business Insight:
-- Helps identify diversified and strategically important customers.

/**Customer Retention & Loyalty**/
-- Business Question:
-- Which customers demonstrate repeat and consistent purchasing behavior?
-- Insight Type: Customer retention & loyalty

/*Customers with more than 5 orders*/
select CUSTOMERNAME
from sales_dataset
group by CUSTOMERNAME
having count(ORDERNUMBER)>5;

/*Customers who placed orders in more than 3 different months*/
select CUSTOMERNAME
from sales_dataset
group by CUSTOMERNAME
having count(distinct MONTH_ID)>3;

/*Customers ordering in all 12 months (yearly recurring customers).*/
select CUSTOMERNAME as Customers, YEAR_ID
from sales_dataset
group by CUSTOMERNAME, YEAR_ID
having count(distinct MONTH_ID)=12;

-- Business Insight:
-- Loyal customers indicate predictable revenue and lower acquisition cost.

/**High-Value Customers**/
-- Business Question:
-- Who are the most valuable customers based on revenue and order frequency?
-- Insight Type: High-value customer identification

/*Customers with above-average order value*/
select CUSTOMERNAME, round(avg(SALES),2) as Average_sales 
from sales_dataset
group by CUSTOMERNAME
having avg(SALES)>(select avg(SALES) from sales_dataset);

/*Top customers exceeding average order count*/
select CUSTOMERNAME, round(sum(SALES),2) as Total_sales
from sales_dataset
where CUSTOMERNAME in (select CUSTOMERNAME 
					   from sales_dataset
                       group by CUSTOMERNAME
                       having count(distinct ORDERNUMBER)>(select avg(order_count)
															from (select count(distinct ORDERNUMBER) as order_count
																  from sales_dataset
                                                                  group by CUSTOMERNAME)t))
group by CUSTOMERNAME
order by Total_sales desc
limit 5;

-- Business Insight:
-- Supports account prioritization and personalized engagement strategies.

/**Customer Value Growth Over Time**/
-- Business Question:
-- Which customers are increasing their purchase value year-over-year?
-- Insight Type: Customer value growth

/*YoY increase in average order value*/
select YEAR_ID, CUSTOMERNAME as Customers, round(avg_order_value,2) as Average_sales, round(prev_year_avg,2) as Prev_year_average_sales
from (select YEAR_ID, CUSTOMERNAME, avg(SALES) as avg_order_value, lag(avg(SALES)) over(partition by CUSTOMERNAME order by YEAR_ID) as prev_year_avg
	  from sales_dataset
      group by YEAR_ID, CUSTOMERNAME)t
where avg_order_value>prev_year_avg;

-- Business Insight:
-- Customers with rising order value show strong retention and upsell potential.
