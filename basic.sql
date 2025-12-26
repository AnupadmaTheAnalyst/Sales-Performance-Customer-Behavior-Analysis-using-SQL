/*
Level: Basic SQL
Concepts: SELECT, WHERE, GROUP BY, ORDER BY, HAVING, LIMIT
Objective: To understand the dataset and answer straight business questions.
Dataset: sales_dataset
*/

/*1. Show the first 10 rows from the sales dataset.*/
select * from sales_dataset limit 10;

/*2. Find the total sales for each year.*/
select YEAR_ID as year, round(sum(SALES),2) as total_sales
from sales_dataset
group by YEAR_ID;

/*3. Count how many orders were placed from each product line.*/
select PRODUCTLINE, count(distinct ORDERNUMBER) as Total_ordernumber
from sales_dataset
group by PRODUCTLINE;

/*4. Identify the top 5 customers by total amount spent.*/
select CUSTOMERNAME as Customers, round(sum(SALES),2) as Total_amount
from sales_dataset
group by CUSTOMERNAME
order by Total_amount desc limit 5;

/*5.Calculate the total quantity sold for each product line.*/
select PRODUCTLINE, sum(QUANTITYORDERED) as Total_quantity_sold
from sales_dataset
group by PRODUCTLINE;

/*6. Find the average order value (average sales amount).*/
select round(avg(SALES),2) as average_sales
from sales_dataset;

/*7. Show monthly sales totals for all years.*/
select monthname(ORDERDATE) as Month, round(sum(SALES),2) as Total_sales
from sales_dataset
group by monthname(ORDERDATE);

/*8. Find the best-selling product based on total revenue.*/
select PRODUCTLINE, round(sum(SALES),2) as Total_revenue
from sales_dataset
group by PRODUCTLINE
order by Total_revenue desc limit 1;

/*9. List all customers who placed more than 5 orders.*/
select CUSTOMERNAME
from sales_dataset
group by CUSTOMERNAME
having count(ORDERNUMBER)>5;

/*10. Calculate total sales by product line and sort them from highest to lowest.*/
select PRODUCTLINE, round(sum(SALES),2) as Total_sales
from sales_dataset
group by PRODUCTLINE
order by Total_sales desc;