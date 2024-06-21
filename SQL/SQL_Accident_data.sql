SELECT *
FROM [SQLTUTORIAL].[dbo].[road_accident]

--calculate current year (2022) casualties

SELECT SUM(number_of_casualties) AS CY_Casualties
FROM [SQLTUTORIAL].[dbo].[road_accident]
WHERE YEAR(accident_date)= '2022'

--calculate current year (2022) accidents

SELECT COUNT(accident_index) AS CY_Accidents
FROM [SQLTUTORIAL].[dbo].[road_accident]
WHERE YEAR(accident_date)='2022'

--calculate current year (2022) fatal casualties

SELECT SUM(number_of_casualties) AS CY_Fatal_Casualties
FROM [SQLTUTORIAL].[DBO].[road_accident]
WHERE accident_severity = 'Fatal' AND YEAR(accident_date) = '2022'

--calculate current year (2022) serious casualties

SELECT SUM(number_of_casualties) AS CY_Serious_Casualties
FROM [SQLTUTORIAL].[DBO].[road_accident]
WHERE accident_severity = 'Serious' AND YEAR(accident_date) = '2022'

--calculate current year (2022) slight casualties

SELECT SUM(number_of_casualties) AS CY_Slight_Casualties
FROM [SQLTUTORIAL].[DBO].[road_accident]
WHERE accident_severity = 'Slight' AND YEAR(accident_date) = '2022'

--calcualate percentage% of fatal casualties

SELECT CAST(CAST(SUM(number_of_casualties) AS decimal(10,2))*100/ 
(SELECT CAST(SUM(number_of_casualties) AS decimal(10,2)) FROM [SQLTUTORIAL].[dbo].[road_accident]) AS decimal (10,2)) AS Pct_of_Fatalities
FROM [SQLTUTORIAL].[dbo].[road_accident]
WHERE accident_severity = 'Fatal'

--casualties by vehicle type

SELECT DISTINCT(vehicle_type)
FROM [SQLTUTORIAL].[dbo].[road_accident]

SELECT

CASE
	WHEN vehicle_type IN ('Car', 'Taxi/Private hire car') THEN 'Car'
	WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricultural'
	WHEN vehicle_type IN ('Motorcycle 50cc and under', 'Motorcycle over 500cc', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle 125cc and under', 'Pedal cycle') THEN 'Bike'
	WHEN vehicle_type IN ('Minibus (8 - 16 passenger seats)' , 'Bus or coach (17 or more pass seats)') THEN 'Bus'
	WHEN vehicle_type IN ('Van / Goods 3.5 tonnes mgw or under', 'Goods over 3.5t. and under 7.5t', 'Goods 7.5 tonnes mgw and over')THEN 'Van'
	ELSE 'Other'

END AS Vehicle_Group,

SUM(number_of_casualties) AS CY_Casualties
FROM [SQLTUTORIAL].[dbo].[road_accident]
WHERE YEAR(accident_date)='2022'
GROUP BY 

CASE
	WHEN vehicle_type IN ('Car', 'Taxi/Private hire car') THEN 'Car'
	WHEN vehicle_type IN ('Agricultural vehicle') THEN 'Agricultural'
	WHEN vehicle_type IN ('Motorcycle 50cc and under', 'Motorcycle over 500cc', 'Motorcycle over 125cc and up to 500cc', 'Motorcycle 125cc and under', 'Pedal cycle') THEN 'Bike'
	WHEN vehicle_type IN ('Minibus (8 - 16 passenger seats)' , 'Bus or coach (17 or more pass seats)') THEN 'Bus'
	WHEN vehicle_type IN ('Van / Goods 3.5 tonnes mgw or under', 'Goods over 3.5t. and under 7.5t', 'Goods 7.5 tonnes mgw and over')THEN 'Van'
	ELSE 'Other'

END


-- CY casualties monthly trend

SELECT DATENAME(MONTH, accident_date) as Month_Name, sum(number_of_casualties) AS CY_Casualties
FROM [SQLTUTORIAL].[dbo].[road_accident]
WHERE YEAR(accident_date) = '2022'
GROUP BY DATENAME(MONTH, accident_date)


-- CY casualties by road type

SELECT road_type AS Road_Type, sum(number_of_casualties) AS CY_Casualties
FROM [SQLTUTORIAL].[dbo].[road_accident]
WHERE YEAR(accident_date) = '2022'
GROUP BY road_type


--CY casualties by urban or rural

SELECT urban_or_rural_area, CAST(CAST(sum(number_of_casualties) AS DECIMAL (10,2)) *100   /
(SELECT SUM(number_of_casualties) FROM [SQLTUTORIAL].[dbo].[road_accident] WHERE YEAR(accident_date) = '2022') AS decimal(10,2))  AS PCT
FROM [SQLTUTORIAL].[dbo].[road_accident]
WHERE YEAR(accident_date) = '2022'
GROUP BY urban_or_rural_area

--CY casualties by light_conditions

SELECT

CASE
	WHEN light_conditions IN ('Darkness - no lighting', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - lighting unknown') THEN 'Night'
	ELSE 'Day'
END  AS light_cond,

CAST(CAST(SUM(number_of_casualties)*100 AS decimal (10,2))/ (SELECT SUM(number_of_casualties) FROM [SQLTUTORIAL].[dbo].[road_accident] WHERE YEAR(accident_date) = '2022') AS decimal (10,2)) AS CY_Casualties
FROM [SQLTUTORIAL].[dbo].[road_accident]
WHERE YEAR(accident_date) = '2022'
GROUP BY 

CASE
	WHEN light_conditions IN ('Darkness - no lighting', 'Darkness - lights lit', 'Darkness - lights unlit', 'Darkness - lighting unknown') THEN 'Night'
	ELSE 'Day'
END

-- Top 10 CY casualties by location

SELECT TOP 10 local_authority, sum(number_of_casualties) AS CY_Casualties
FROM [SQLTUTORIAL].[dbo].[road_accident]
WHERE YEAR(accident_date) = '2022'
GROUP BY local_authority
ORDER BY CY_Casualties desc





