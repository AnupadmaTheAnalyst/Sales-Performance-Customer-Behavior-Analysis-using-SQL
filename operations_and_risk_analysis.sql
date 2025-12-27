/*
Project: Operations & Risk Analysis
Objective:
Identify operational inefficiencies, cancellation risks, and regional performance gaps.
Dataset: sales_dataset
*/

/**Cancellation Risk Analysis**/
-- Business Question:
-- Where are cancellations occurring and which products are affected?
-- Insight Type: Operational risk assessment

/*Cancelled orders*/
select *
from sales_dataset
where STATUS='Cancelled';

/*Cancelled orders by product line*/
select PRODUCTLINE, count(distinct ORDERNUMBER) as cancelled_orders
from sales_dataset
where STATUS='Cancelled'
group by PRODUCTLINE;

/*Shipped vs cancelled percentage*/
select PRODUCTLINE, round(sum(case when STATUS like 'Shipped' then 1 else 0 end)*100.0/count(distinct case when STATUS in ('Shipped', 'Cancelled') then ORDERNUMBER end),2) as Shipped_orders_Percent, round(sum(case when STATUS like 'Cancelled' then 1 else 0 end)*100.0/count(distinct case when STATUS in ('Shipped', 'Cancelled') then ORDERNUMBER end),2) as Cancelled_orders_Percent
from sales_dataset
group by PRODUCTLINE;

-- Business Insight:
-- High cancellation rates indicate operational or customer satisfaction issues.

/*Regional Performance Analysis*/
-- Business Question:
-- Which regions generate the highest and lowest sales and customer activity?
-- Insight Type: Regional performance

/*Highest revenue region*/
select ADDRESS, round(sum(SALES),2) as Highest_total_sales
from sales_dataset
group by ADDRESS
order by Highest_total_sales desc
limit 1;

/*Regions with most orders*/
select ADDRESS, count(distinct ORDERNUMBER) as Highest_orders
from sales_dataset
group by ADDRESS
order by Highest_orders desc limit 3;

/*Region with the lowest number of unique customers.*/
select address, count(distinct CUSTOMERNAME) as unique_customers
from sales_dataset
group by address
order by unique_customers asc limit 1;

/*Top products per region*/
select PRODUCTLINE, ADDRESS, round(Total_sales,2) as Total_revenue
from (select PRODUCTLINE, ADDRESS, sum(SALES) as Total_sales, rank() over(partition by ADDRESS order by sum(SALES) desc)rnk
	  from sales_dataset
      group by PRODUCTLINE, ADDRESS)t
where rnk<=2;

-- Business Insight:
-- Supports regional sales strategy and market expansion decisions.

/**Product & Deal-Size Gaps**/
-- Business Question:
-- Are there products underperforming in specific deal sizes?
-- Insight Type: Product-deal gap analysis

/*Products never sold in small deals*/
select distinct PRODUCTLINE
from sales_dataset p
where not exists (select 1
					   from sales_dataset s
                       where s.PRODUCTLINE=p.PRODUCTLINE
                       and s.DEALSIZE='Small');
                       
-- Business Insight:
-- Identifies missed opportunities in pricing or packaging strategy.

/**Deal Size Efficiency**/
-- Business Question:
-- Which deal sizes generate higher average revenue per order?
-- Insight Type: Deal efficiency

/*Average sales per order by deal size, excluding cancelled orders*/
select DEALSIZE, round(avg(Avg_sales),2) as Avg_sales_per_order
from (select ORDERNUMBER, DEALSIZE, avg(SALES) as Avg_sales
		from sales_dataset
		where STATUS <> 'Cancelled'
		group by ORDERNUMBER, DEALSIZE)t
group by DEALSIZE;

-- Business Insight:
-- Guides focus toward more profitable deal structures.
