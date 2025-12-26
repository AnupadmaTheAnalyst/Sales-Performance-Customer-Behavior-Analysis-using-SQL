/*
Level: Advanced SQL
Concepts: Windows functions, Time-series analysis, Correlated subqueries, Multi-level aggregation
Objective: Analyze sales trends and customer performance to support business decisions
Dataset: sales_dataset
*/

/*31. Find the top 3 customers in each year based on total sales.*/
select YEAR_ID, CUSTOMERNAME, total_sales
from (select YEAR_ID, CUSTOMERNAME, round(sum(SALES),2) as total_sales, rank() over(partition by YEAR_ID order by sum(SALES) desc)rnk
	  from sales_dataset
      group by YEAR_ID, CUSTOMERNAME)t
where rnk<=3;

/*32. Calculate the running total (cumulative sales) for each month across all years.*/
select MONTH_ID, YEAR_ID, Monthly_sales, round(sum(Monthly_sales) over(order by YEAR_ID, MONTH_ID),2) as running_total
from (select MONTH_ID, YEAR_ID, round(sum(SALES),2) as Monthly_sales
	  from sales_dataset
      group by MONTH_ID, YEAR_ID)t
order by YEAR_ID, MONTH_ID;

/*33. Identify customers whose average order value increased year-over-year.*/
select YEAR_ID, CUSTOMERNAME as Customers, round(avg_order_value,2) as Average_sales, round(prev_year_avg,2) as Prev_year_avg
from (select YEAR_ID, CUSTOMERNAME, avg(SALES) as avg_order_value, lag(avg(SALES)) over(partition by CUSTOMERNAME order by YEAR_ID) as prev_year_avg
	  from sales_dataset
      group by YEAR_ID, CUSTOMERNAME)t
where avg_order_value>prev_year_avg;

/*34. Find products that have never been sold in any “Small” deal size orders.*/
select distinct PRODUCTLINE
from sales_dataset p
where not exists (select 1
					   from sales_dataset s
                       where s.PRODUCTLINE=p.PRODUCTLINE
                       and s.DEALSIZE='Small');
                       
/*35. Show the top 2 product lines by revenue for each address.*/
select PRODUCTLINE, ADDRESS, round(Total_sales,2) as Total_revenue
from (select PRODUCTLINE, ADDRESS, sum(SALES) as Total_sales, rank() over(partition by ADDRESS order by sum(SALES) desc)rnk
	  from sales_dataset
      group by PRODUCTLINE, ADDRESS)t
where rnk<=2;

/*36. For each product, calculate the percentage of shipped vs cancelled orders.*/
select PRODUCTLINE, round(sum(case when STATUS like 'Shipped' then 1 else 0 end)*100.0/count(distinct case when STATUS in ('Shipped', 'Cancelled') then ORDERNUMBER end),2) as Shipped_orders_Percent, round(sum(case when STATUS like 'Cancelled' then 1 else 0 end)*100.0/count(distinct case when STATUS in ('Shipped', 'Cancelled') then ORDERNUMBER end),2) as Cancelled_orders_Percent
from sales_dataset
group by PRODUCTLINE;
 
/*37. Find customers who placed orders in all 12 months (yearly recurring customers).*/
select CUSTOMERNAME as Customers, YEAR_ID
from sales_dataset
group by CUSTOMERNAME, YEAR_ID
having count(distinct MONTH_ID)=12;

/*38. Identify the month with the highest increase in sales compared to the previous month.*/
select MONTH_ID, round(sales_increase,2) as Highest_sales_increased
from (select MONTH_ID, monthly_sales-lag(monthly_sales) over(order by MONTH_ID) as sales_increase
	  from (select MONTH_ID, sum(SALES) as monthly_sales
			from sales_dataset
            group by MONTH_ID)t)x
order by sales_increase desc
limit 1;

/*39. Calculate the average sales per order for each deal size, excluding cancelled orders.*/
select DEALSIZE, round(avg(Avg_sales),2) as Avg_sales_per_order
from (select ORDERNUMBER, DEALSIZE, avg(SALES) as Avg_sales
		from sales_dataset
		where STATUS <> 'Cancelled'
		group by ORDERNUMBER, DEALSIZE)t
group by DEALSIZE;

/*40. Find the top 5 customers with the highest total sales, but only include customers whose total orders exceed the average number of orders per customer.*/
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