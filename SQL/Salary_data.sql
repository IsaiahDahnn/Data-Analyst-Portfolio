/* Project Questions */

/*
1. What is the count of each gender?
2. What is the average age of each gender?
3. What are the top 5 job title who pays the most?
4. What is the average salary of each gender?
5. How many people for each country who's salary is above average?
6. What is the average salary of each education level?
7. How many people who has 10 or above years of experience?
8. What is the average salary of people with below 10 years of experience 
	compare to people with more than decade of working experience?
9. What is the lowest salary in USA with 10 years and above average? 
10. What is the Job Title of PHD holder who got the highest Salary?
*/  


# 1. What is the count of each gender?

SELECT IFNULL(Gender,'Total') AS Gender,
	COUNT(Gender) AS Count
FROM portfolio.salary_data_based_country
GROUP BY Gender
WITH rollup;

# 2. What is the average age of each gender?

SELECT IFNULL(Gender, 'TOTAL') AS Gender,
	CAST(AVG(AGE) AS DECIMAL(5,2)) AS Average_Age
FROM portfolio.salary_data_based_country
GROUP BY Gender
ORDER BY Average_Age DESC 

# 3. What are the top 5 job title who pays the most?

SELECT Job_Title, Salary
FROM portfolio.salary_data_based_country
ORDER BY Salary DESC
LIMIT 5

# 4. What is the average salary of each gender?

SELECT Gender,
	CAST(AVG(Salary) AS DECIMAL(15,2)) AS Average_Salary
FROM portfolio.salary_data_based_country
GROUP BY Gender
ORDER BY Average_Salary DESC

# 5. How many people for each country who's salary is above average?

SELECT Country, COUNT(CASE WHEN Salary > 115329 THEN 1 END) AS COUNT
FROM portfolio.salary_data_based_country
GROUP BY Country

# 6. What is the average salary of each education level?

SELECT Education_Level,
	CAST(AVG(Salary) AS DECIMAL(15,2)) AS Average_Salary
FROM portfolio.salary_data_based_country
GROUP BY Education_Level
ORDER BY Average_Salary DESC

# 7. How many people who has 10 or above years of experience?

SELECT COUNT(CASE WHEN Years_of_Experience >= 10 THEN 1 ELSE NULL END ) AS Count
FROM portfolio.salary_data_based_country

# 8. What is the average salary of people with below 10 years of experience compare to people with more than decade of working experience?

SELECT CAST(AVG(Salary) AS DECIMAL(15,2)) AS Salary_Below_Decade, 
	(SELECT CAST(AVG(Salary) AS DECIMAL(15,2))
	FROM portfolio.salary_data_based_country
    WHERE Years_of_Experience >= 10) AS Salary_Above_Decade
FROM portfolio.salary_data_based_country
WHERE Years_of_Experience < 10

# 9. What is the lowest salary in USA with 10 years and above average? 
	
SELECT Country, Salary, Years_of_Experience
FROM portfolio.salary_data_based_country
WHERE Years_of_Experience >= 10 AND Country = 'USA'
ORDER BY Salary 
LIMIT 1	

# 10. What is the Job Title of PHD holder who got the highest Salary?

SELECT Education_Level, Job_Title, Salary
FROM portfolio.salary_data_based_country
WHERE Education_Level = 'PhD'
ORDER BY Salary DESC
LIMIT 1  