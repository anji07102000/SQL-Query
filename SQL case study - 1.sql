
CREATE DATABASE Employee;

USE Employee

-- Create the Employee Table and insert the values

CREATE TABLE Employee_table(
	Employee_id INT PRIMARY KEY NOT NULL,
	First_name VARCHAR(100),
	Last_name VARCHAR(100),
	Salary INT CHECK (Salary>0),
	Joining_date SMALLDATETIME,
	Department VARCHAR (100)
)
GO

SELECT * From Employee_table
sp_help Employee_table

INSERT INTO Employee_table(Employee_id, First_name, Last_name, Salary, Joining_date, Department)

SELECT 1,'Anika','Arora',100000,'2020-02-14 9:00:00','HR' UNION ALL
SELECT 2,'Veena','Verma',80000,'2011-06-15 9:00:00','Admin' UNION ALL
SELECT 3,'Vishal','Singhal',300000,'2020-02-16 9:00:00','HR' UNION ALL
SELECT 4,'Sushanth','Singh',500000,'2020-02-17 9:00:00','Admin' UNION ALL
SELECT 5,'Bhupla','Bhati',500000,'2011-06-18 9:00:00','Admin' UNION ALL
SELECT 6,'Dheeraj','Diwan',200000,'2011-06-19 9:00:00','Account' UNION ALL
SELECT 7,'Karan','Kumar',75000,'2020-01-14 9:00:00','Account' UNION ALL
SELECT 8,'Chandrika','Chauhan',90000,'2011-04-15 9:00:00','Admin'


--Create Employee Bonus table and inserting values into it

CREATE TABLE Employee_bonus(
	Employee_ref_id INT FOREIGN KEY references Employee_table(Employee_id),
	Bonus_Amount INT,
	Bonus_Date SMALLDATETIME
)
GO

INSERT INTO Employee_Bonus(Employee_ref_id, Bonus_Amount, Bonus_Date)
SELECT 1,5000,'2020-02-16 0:00:00' UNION ALL
SELECT 2,3000,'2011-06-16 0:00:00' UNION ALL
SELECT 3,4000,'2020-02-16 0:00:00'UNION ALL
SELECT 1,4500,'2020-02-16 0:00:00'UNION ALL
SELECT 2,3500,'2011-06-16 0:00:00'

SELECT * FROM Employee_bonus

-- Create Employee title table and insert the data into it

Create Table Employee_title(
 Employee_id int,
 Employee_title varchar(100),
 Affective_date smalldatetime
)
GO
Insert into Employee_title(Employee_id,Employee_title,Affective_date)
select 1,'Manager','2016-02-20 0:00:00' union all
select 2,'Executive','2016-06-11 0:00:00' union all
select 8,'Executive','2016-06-11 0:00:00' union all
select 5,'Manager','2016-06-11 0:00:00' union all
select 4,'Asst.Manager','2016-06-11 0:00:00' union all
select 7,'Executive','2016-06-11 0:00:00' union all
select 6,'Lead','2016-06-11 0:00:00' union all
select 3,'Lead','2016-06-11 0:00:00'

select* from Employee_title

--Tasks To Be Performed:
--1 Display the “FIRST_NAME” from Employee table using the alias name as Employee_name
SELECT First_name AS Employee_name
FROM Employee_table

--2 Display “LAST_NAME” from Employee table in upper case.
SELECT UPPER(Last_name) AS LAST_NAME
FROM Employee_table

--3 Display unique values of DEPARTMENT from EMPLOYEE table.
SELECT DISTINCT(Department)
FROM Employee_table

--4 Display the first three characters of LAST_NAME from EMPLOYEE table.
SELECT SUBSTRING(Last_name,1,3)
FROM Employee_table

--5 Display the unique values of DEPARTMENT from EMPLOYEE table and prints its length.
SELECT DISTINCT(LEN(Department))
FROM Employee_table

--6 Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a single column AS FULL_NAME. 
 --a space char should separate them.
 SELECT CONCAT(First_name,' ',Last_name) AS Full_name
 FROM Employee_table

--7 DISPLAY all EMPLOYEE details from the employee table order by FIRST_NAME Ascending.
SELECT *
FROM Employee_table
ORDER BY First_name ASC

--8. Display all EMPLOYEE details order by FIRST_NAME Ascending and DEPARTMENT Descending
SELECT *
FROM Employee_table
ORDER BY First_name ASC, Department DESC

--9 Display details for EMPLOYEE with the first name as “VEENA” and “KARAN” from EMPLOYEE table.
SELECT *
FROM Employee_table
WHERE First_name IN ('Veena','Karan')

--10 Display details of EMPLOYEE with DEPARTMENT name as “Admin”.
SELECT *
FROM Employee_table
WHERE Department IN ('Admin')

--11 DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’.
SELECT *
FROM Employee_table
WHERE First_name LIKE 'V%'

--12 DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000.
SELECT *
FROM Employee_table
WHERE Salary BETWEEN 100000 AND 500000

--13 Display details of the employees who have joined in Feb-2020.
SELECT *
FROM Employee_table
WHERE Joining_date BETWEEN '2020-02-01' AND '2020-02-28'

--14 Display employee names with salaries >= 50000 and <= 100000.
SELECT *
FROM Employee_table
WHERE Salary >=50000 AND Salary <=100000
--WHERE Salary BETWEEN 50000 AND 100000

--16 DISPLAY details of the EMPLOYEES who are also Managers.
SELECT *
FROM Employee_table as et
JOIN Employee_title as title ON et.Employee_id = title.Employee_id
WHERE Employee_title = 'Manager'

--17 DISPLAY duplicate records having matching data in some fields of a table.
SELECT * 
FROM Employee_title
JOIN
(	SELECT Employee_title, Affective_date 
	FROM Employee_title
	GROUP BY Employee_title, Affective_date
	HAVING COUNT(*) > 1
	)Employee
	ON  Employee.Employee_title = Employee_title.Employee_title
	AND Employee.Affective_Date = Employee_title.Affective_Date


--18 Display only odd rows from a table.
SELECT *
FROM Employee_table
WHERE Employee_id %2!=0

--19 Clone a new table from EMPLOYEE table.
SELECT *
INTO Employee_newtable
FROM Employee_table

SELECT *
FROM Employee_newtable

--20 DISPLAY the TOP 2 highest salary from a table
SELECT *
FROM Employee_table
WHERE Salary IN
				(SELECT TOP (2)Salary
				FROM Employee_table
				GROUP BY Salary
				ORDER BY Salary DESC
				)

--21. DISPLAY the list of employees with the same salary.
SELECT *
FROM Employee_table e
WHERE Salary IN 
				( SELECT Salary
				  FROM Employee_table et
				  WHERE e.Employee_id <> et.Employee_id
				 ) 
				  
/*SELECT *
FROM (
		SELECT *
		,DENSE_RANK() OVER(ORDER BY Salary DESC) AS same_sal
		FROM Employee_table
	) AS z
WHERE same_sal =1;*/


--22 Display the second highest salary from a table.
SELECT *
FROM 
	(SELECT *
	,DENSE_RANK() OVER(ORDER BY Salary DESC) AS sec_high_sal
	FROM Employee_table
	)AS y
WHERE sec_high_sal =2

--23 Display the first 50% records from a table.
SELECT TOP 50 PERCENT *
FROM Employee_table

/*SELECT *
FROM (
	  SELECT*
	  ,ROW_NUMBER() OVER(ORDER BY(SELECT NULL)) AS rn
	  FROM Employee_table
	 ) AS it
WHERE RN <=(SELECT COUNT(*)
			FROM Employee_table)*0.5*/
			

--24. Display the departments that have less than 4 people in it.
SELECT *
FROM Employee_table
WHERE Department IN (
					SELECT Department
					FROM Employee_table
					GROUP BY Department
					HAVING COUNT(*)<4
					)

--25. Display all departments along with the number of people in there.
SELECT Department, COUNT(*)
FROM Employee_table
GROUP BY Department

--26 Display the name of employees having the highest salary in each department.
SELECT First_name,Last_name,Department,Salary
FROM Employee_table
WHERE Salary IN (
				 SELECT MAX(Salary)
				 from Employee_table
				 GROUP BY Department
				 )

--27 Display the names of employees who earn the highest salary.
SELECT First_name,Last_name,Salary
FROM Employee_table
WHERE Salary IN (
				 SELECT MAX(Salary)
				 FROM Employee_table
				 )

--28 Diplay the average salaries for each department
SELECT Department, AVG(Salary)
FROM Employee_table
GROUP BY Department

--29 display the name of the employee who has got maximum bonus
SELECT Employee_ref_id, SUM(Bonus_Amount)as Total_bonus
INTO Employee_bonus_backup
FROM Employee_bonus
GROUP BY Employee_ref_id
SELECT First_name, Last_name
FROM Employee_table AS et
JOIN Employee_bonus AS eb ON et.Employee_id = eb.Employee_ref_id
WHERE Total_bonus = (SELECT max(Bonus_Amount)
					 FROM Employee_bonus_backup )

--select *
--from Employee_bonus


--30 Display the first name and title of all the employees.

--SELECT *
--FROM Employee_title

SELECT et.Employee_id, First_name,Department,Employee_title
FROM Employee_table AS et
JOIN Employee_title AS title ON et.Employee_id = title.Employee_id
