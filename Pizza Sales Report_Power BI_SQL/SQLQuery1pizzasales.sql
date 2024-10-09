--View overall table

SELECT *
FROM [SQL tutorial].[dbo].[PizzaSales]

--Total Revenue

SELECT SUM(total_price) as TotalRevenue
FROM [SQL tutorial].[dbo].[PizzaSales]

--Average Order Value

SELECT SUM(total_price) / COUNT(DISTINCT(order_id)) As AvgOrderValue
FROM [SQL tutorial].[dbo].[PizzaSales]

--Total Pizza Sold

Select SUM(quantity) AS TotalPizzaSold
FROM [SQL tutorial].[dbo].[PizzaSales]

--Total Orders

SELECT COUNT(DISTINCT(order_id)) As TotalOrders
FROM [SQL tutorial].[dbo].[PizzaSales]

--Average Pizza Sold

Select CAST(SUM(quantity)/COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS AvgPizzaSold
FROM [SQL tutorial].[dbo].[PizzaSales]

--Daily Trend

Select DATENAME(dw,order_date) as Orderday, count(distinct(order_id)) as Totalorder
FROM [SQL tutorial].[dbo].[PizzaSales]
GROUP BY DATENAME(dw,order_date)

--Monthly Trend

Select DATENAME(MONTH,order_date) as Orderday, count(distinct(order_id)) as Totalorder
FROM [SQL tutorial].[dbo].[PizzaSales]
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Totalorder DESC

--Percentage of pizza sales by category

SELECT *
FROM [SQL tutorial].[dbo].[PizzaSales]

Select DISTINCT(pizza_category), SUM(quantity),SUM(total_price) as total_sales, SUM(total_price)/(SELECT SUM(total_price) from [SQL tutorial].[dbo].[PizzaSales])*100 AS Percentageofsales
FROM [SQL tutorial].[dbo].[PizzaSales]
GROUP BY pizza_category

--Percentage of pizza sales by pizza size

SELECT Distinct(pizza_size),CAST(sum(total_price) as decimal(10,2)) as total_sales, CAST(sum(total_price)/( select sum(total_price) FROM [SQL tutorial].[dbo].[PizzaSales])*100 AS DECIMAL(10,2)) AS PercentageofSales 
FROM [SQL tutorial].[dbo].[PizzaSales]
GROUP BY pizza_size
ORDER BY total_sales DESC

SELECT TOP 5 pizza_name, SUM(total_price) as Revenue
FROM [SQL tutorial].[dbo].[PizzaSales]
GROUP BY pizza_name
Order by Revenue Desc

SELECT TOP 5 pizza_name, SUM(total_price) as Revenue
FROM [SQL tutorial].[dbo].[PizzaSales]
GROUP BY pizza_name
Order by Revenue

