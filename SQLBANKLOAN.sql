SELECT *
FROM [bankloanDB].[dbo].[financial_loan]

--total loan applications

SELECT COUNT(DISTINCT id) AS "Total Loan Application"
FROM [bankloanDB].[dbo].[financial_loan]

--Month to date (december) loan applications

SELECT COUNT(id) AS "Month to date loan application"
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Previous month loan applications

SELECT COUNT(id) AS "Previous Month to date loan application"
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Month to month difference

SELECT
	((SELECT CAST(COUNT(id) as decimal (10,2))
	FROM [bankloanDB].[dbo].[financial_loan]
	WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021) - (SELECT CAST( COUNT(id) AS DECIMAL (10,2))
	FROM [bankloanDB].[dbo].[financial_loan]
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021))*100 / (SELECT CAST( COUNT(id) AS DECIMAL (10,2))
	FROM [bankloanDB].[dbo].[financial_loan]
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021) as MTM_DIFF

-- Total Loan Amount

SELECT CAST((SUM(loan_amount)/1000000.0) AS DECIMAL (10,3)) AS Total_Loan_Amount_Mil
FROM [bankloanDB].[dbo].[financial_loan]

-- Total Loan Amount Month to date(december)

SELECT CAST((SUM(loan_amount)/1000000.0) AS DECIMAL (10,3)) AS MTD_Loan_Amount_Mil
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


-- Previous month Loan Amount Month to date

SELECT CAST((SUM(loan_amount)/1000000.0) AS DECIMAL (10,3)) AS MTD_Loan_Amount_Mil
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Loan amount MTM changes in perct

SELECT 
 CAST ((((SELECT CAST((SUM(loan_amount)/1000000.0) AS DECIMAL (10,3))
	FROM [bankloanDB].[dbo].[financial_loan]
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021) - (SELECT CAST((SUM(loan_amount)/1000000.0) AS DECIMAL (10,3))
	FROM [bankloanDB].[dbo].[financial_loan]
	WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021))*100) / (SELECT CAST((SUM(loan_amount)/1000000.0) AS DECIMAL (10,3))
	FROM [bankloanDB].[dbo].[financial_loan]
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021) AS decimal (10,2)) AS MTD_DIFF_PERT

--Total Amount Received

SELECT CAST((SUM(total_payment))/1000000.0 AS decimal (10,3)) AS Total_Amount_Received
FROM [bankloanDB].[dbo].[financial_loan]

--Month-to-Date (MTD) Total Amount Received 

SELECT CAST((SUM(total_payment))/1000000.0 AS decimal (10,3)) AS Total_Amount_Received
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) =12 AND YEAR(issue_date) = 2021

--Previous Month Total Amount Received 

SELECT CAST((SUM(total_payment))/1000000.0 AS decimal (10,3)) AS Total_Amount_Received
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) =11 AND YEAR(issue_date) = 2021

--Month-over-Month (MoM) changes Total Amount Received


SELECT CAST((SELECT
	((SELECT CAST((SUM(total_payment))/1000000.0 AS decimal (10,3))
	FROM [bankloanDB].[dbo].[financial_loan]
	WHERE MONTH(issue_date) =11 AND YEAR(issue_date) = 2021) - (SELECT CAST((SUM(total_payment))/1000000.0 AS decimal (10,3))
	FROM [bankloanDB].[dbo].[financial_loan]
	WHERE MONTH(issue_date) =12 AND YEAR(issue_date) = 2021))*100 / (SELECT CAST((SUM(total_payment))/1000000.0 AS decimal (10,3))
	FROM [bankloanDB].[dbo].[financial_loan]
	WHERE MONTH(issue_date) =11 AND YEAR(issue_date) = 2021)) AS decimal (10,3)) AS MoM_Amount_Received_Perc


--Average Interest Rate

SELECT CAST((AVG(int_rate))*100.0 AS decimal (10,2)) AS Avg_Int_Rate
FROM [bankloanDB].[dbo].[financial_loan]

-- Alternative round function

SELECT ROUND(AVG(int_rate), 4)*100 AS Avg_Int_Rate
FROM [bankloanDB].[dbo].[financial_loan]

--Average Interest Rate MTD

SELECT CAST(AVG(int_rate) AS decimal (10,5)) AS Avg_Int_Rate_Dec
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) =12 AND YEAR(issue_date) = 2021

--Average Interest Rate Previous Month

SELECT CAST(AVG(int_rate) AS decimal (10,5))*100 AS Avg_Int_Rate_Dec
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) =11 AND YEAR(issue_date) = 2021

--MTM AVG INTEREST RATE

SELECT CAST((SELECT
	((SELECT CAST(AVG(int_rate) AS decimal (10,5))
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) =11 AND YEAR(issue_date) = 2021) - (SELECT CAST(AVG(int_rate) AS decimal (10,5))
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) =12 AND YEAR(issue_date) = 2021)) *100 / (SELECT CAST(AVG(int_rate) AS decimal (10,5))
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) =12 AND YEAR(issue_date) = 2021)) AS decimal (10,3)) AS MTM_INT_RATE_DIFF


-- Average debt to income ratio

SELECT ROUND(AVG(dti), 4)* 100 AS DTI_RATIO
FROM [bankloanDB].[dbo].[financial_loan]


--Month Average debt to income ratio

SELECT ROUND(AVG(dti), 4)* 100 AS DTI_RATIO
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) =12 AND YEAR(issue_date) = 2021


--Previous Month Average debt to income ratio

SELECT ROUND(AVG(dti), 5)* 100 AS DTI_RATIO
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) =11 AND YEAR(issue_date) = 2021

-- Good loan Percentage
SELECT CAST(((COUNT(CASE WHEN loan_status ='Fully Paid' OR loan_status = 'Current' THEN id END))*100.0 / count(id)) AS DECIMAL (10,2)) AS Good_Loan_Perc
FROM [bankloanDB].[dbo].[financial_loan]

--Good Loan Applications

SELECT COUNT(id) AS Good_Loan_Applications
FROM [bankloanDB].[dbo].[financial_loan]
WHERE loan_status = 'Fully Paid' or loan_status = 'Current' 

--Good Loan Funded Amount

SELECT *
FROM [bankloanDB].[dbo].[financial_loan]

SELECT CAST((SUM(loan_amount)/1000000.0) AS DECIMAL (10,2)) AS Good_Loan_Funded_mil
FROM [bankloanDB].[dbo].[financial_loan]
WHERE loan_status = 'Fully Paid' or loan_status = 'Current' 

--Good Loan Total Received Amount

SELECT CAST((SUM(total_payment)/1000000.0) AS DECIMAL (10,2)) AS Good_Loan_Amountrecevied_mil
FROM [bankloanDB].[dbo].[financial_loan]
WHERE loan_status = 'Fully Paid' or loan_status = 'Current' 

--Bad Loan Application Percentage


SELECT CAST((COUNT(CASE WHEN loan_status = 'Charged Off' then id END) * 100.0 /COUNT(id)) AS decimal (10,2)) as Bad_Loan_App_Perc
FROM [bankloanDB].[dbo].[financial_loan]

--Bad Loan Applications

SELECT COUNT(CASE WHEN loan_status = 'Charged Off' then id END) AS Bad_Loan_Applications
FROM [bankloanDB].[dbo].[financial_loan]

--Bad Loan Funded Amount

SELECT SUM(loan_amount) as Bad_Loan_Funded_Amount
FROM [bankloanDB].[dbo].[financial_loan]
WHERE loan_status = 'Charged Off'

--Bad Loan Total Received Amount


SELECT SUM(total_payment) as Bad_Loan_Funded_Amount
FROM [bankloanDB].[dbo].[financial_loan]
WHERE loan_status = 'Charged Off'

-- Loan Details Gride View

SELECT 
loan_status,
Count(id) as LoanCount,
sum(total_payment) as Total_AmountReceived,
sum(loan_amount) as Funded_Amount,
Avg(int_rate*100) as Avg_InterestRate,
AVG(dti*100) as Avg_DTI
FROM [bankloanDB].[dbo].[financial_loan]
GROUP BY loan_status

-- MTD Loan Details

SELECT
loan_status,
sum(total_payment) as Amount_Received,
sum(loan_amount) as Funded_Amount
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY loan_status

-- Previous Month Loan Details

SELECT
loan_status,
sum(total_payment) as Amount_Received,
sum(loan_amount) as Funded_Amount
FROM [bankloanDB].[dbo].[financial_loan]
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
GROUP BY loan_status


SELECT *
FROM [bankloanDB].[dbo].[financial_loan]

--Monthly data by issue date

SELECT
	MONTH(issue_date) as Month_Number,
	DATENAME(MONTH, issue_date) as Month_Name,
	COUNT(id) as total_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_amount_received
	FROM [bankloanDB].[dbo].[financial_loan]
	GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
	ORDER BY MONTH(issue_date)

--Regional Analysis by State 

SELECT
	address_state,
	COUNT(id) as total_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_amount_received
	FROM [bankloanDB].[dbo].[financial_loan]
	GROUP BY address_state
	ORDER BY address_state

--Loan Term Analysis 

SELECT
	term,
	COUNT(id) as total_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_amount_received
	FROM [bankloanDB].[dbo].[financial_loan]
	GROUP BY term
	ORDER BY term

--Employee Length Analysis 

SELECT
	emp_length,
	COUNT(id) as total_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_amount_received
	FROM [bankloanDB].[dbo].[financial_loan]
	GROUP BY emp_length
	ORDER BY emp_length


--Loan Purpose Breakdown 

SELECT
	purpose,
	COUNT(id) as total_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_amount_received
	FROM [bankloanDB].[dbo].[financial_loan]
	GROUP BY purpose
	--ORDER BY emp_length

--Home Ownership Analysis 

SELECT
	home_ownership,
	COUNT(id) as total_applications,
	SUM(loan_amount) as total_funded_amount,
	SUM(total_payment) as total_amount_received
	FROM [bankloanDB].[dbo].[financial_loan]
	GROUP BY home_ownership
	--ORDER BY emp_length


