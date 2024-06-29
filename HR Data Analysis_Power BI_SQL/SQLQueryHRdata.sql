SELECT *
FROM [SQL tutorial].[dbo].[HRdata]

-- Employee Count

SELECT SUM([Employee Count]) AS EmplyoeeCount
FROM [SQL tutorial].[dbo].[HRdata]
WHERE Education = 'High School'
--WHERE Department = 'Sales'

-- Attrition Count

SELECT Count([Attrition]) AS AttritionCount
FROM [SQL tutorial].[dbo].[HRdata]
WHERE Attrition = 'Yes' AND Education = 'Doctoral Degree'

-- Attrition rate

SELECT round(((SELECT Count([Attrition]) FROM [SQL tutorial].[dbo].[HRdata] WHERE Attrition='Yes' AND Department = 'Sales')/SUM([Employee Count]))*100,2) AS AttritionRate
FROM [SQL tutorial].[dbo].[HRdata]
WHERE Department = 'Sales'

-- Active Employee

SELECT SUM([Employee Count]) - (SELECT Count([Attrition]) FROM [SQL tutorial].[dbo].[HRdata] WHERE Attrition = 'Yes' AND Gender = 'Male' ) AS ActiveEmployee
FROM [SQL tutorial].[dbo].[HRdata]
WHERE Gender = 'Male'

-- Average Age

SELECT round(AVG(Age),0) AS AverageAge
FROM [SQL tutorial].[dbo].[HRdata]

-- Attrition by Gender

SELECT Gender, count (Attrition) As AttritionCount
FROM [SQL tutorial].[dbo].[HRdata]
Where Attrition = 'Yes'
Group by Gender
Order by count(Attrition) desc

-- Attrition by Department

SELECT Department, count (Attrition) As AttritionCount,
round((cast(count(Attrition) as numeric)
/ (select count(Attrition) FROM [SQL tutorial].[dbo].[HRdata] Where Attrition = 'Yes'))*100, 2) as AttritionPerc
FROM [SQL tutorial].[dbo].[HRdata]
Where Attrition = 'Yes'
Group by Department
Order by count(Attrition) desc

-- no of emplyoee by age group

SELECT Age, count([Employee Count]) as EmployeeCount
FROM [SQL tutorial].[dbo].[HRdata]
Group by Age
Order by Age

-- Attrition by Education Field

SELECT [Education Field], count (Attrition) As AttritionCount
FROM [SQL tutorial].[dbo].[HRdata]
Where Attrition = 'Yes'
Group by [Education Field]
Order by count(Attrition) desc

--Attrition by Age group and Gender

SELECT [CF_age band], Gender, count (attrition) as AttritionCount
FROM [SQL tutorial].[dbo].[HRdata]
Where Attrition = 'Yes'
GROUP BY [CF_age band], Gender