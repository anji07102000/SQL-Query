CREATE DATABASE SAKASANIAKKA

USE SAKASANIAKKA

CREATE TABLE Location(
	Location_ID INT primary key,City VARCHAR (30)
)

INSERT INTO Location(Location_ID,City)
/*Values (122,'New York'),
 (123,'Dallas'),
 (124,'Chicago'),
 (167,'Boston');*/

SELECT 122,'New York' UNION ALL
SELECT 123,'Dallas' UNION ALL
SELECT 124,'Chicago' UNION ALL
SELECT 167,'Boston'

drop table Location

select * from Location

Create table Department
( Department_ID int primary key,
 Name varchar (30),
 Location_ID int foreign key references Location(Location_ID)
)

Insert into Department (Department_ID,Name,Location_ID)
Values (10,'Accounting',122),
	   (20,'Sales',124),
	   (30,'Research',123),
	   (40,'operations',167)

select * from Department

Create table Job(
	Job_ID int primary key,
	Designation Varchar (30)
)

Insert into Job(Job_ID,Designation)
Values (667, 'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670, 'Sales Person'),
(671, 'Manager'),
(672, 'President')

select * from Job


Create table Employee (
	Employee_ID int, 
	Last_Name varchar (30),
	First_Name varchar (30),
	Middle_Name varchar (30),
	Job_ID int foreign key references Job (Job_ID),
	Hire_Date date,
	Salary int,
	Comm int,
	Department_ID int foreign key references Department(Department_ID))

insert into Employee (Employee_ID, 
	Last_Name,
	First_Name,
	Middle_Name,
	Job_ID,
	Hire_Date,
	Salary,
	Comm,
	Department_ID)
values (7369, 'SMITH', 'JOHN', 'Q', 667,  '17-DEC-84', 800, NULL, 20),
	(7499, 'ALLEN', 'KEVIN', 'J', 670,  '20-FEB-8', 1600, 300, 30),
	(7505, 'DOYLE', 'JEAN', 'K', 671,  '04-APR-85', 2850, NULL, 30),
	(7506, 'DENNIS', 'LYNN', 'S', 671,  '15-MAY-85', 2750, NULL, 30),
	(7507, 'BAKER', 'LESLIE', 'D', 671, '10-JUN-85', 2200, NULL, 40),
	(7521, 'WARK', 'CYNTHIA', 'D', 670,  '22-FEB-85', 1250, 500, 30);

SIMPLE QUERIES:
--1. LIST ALL THE EMPLOYEE DETAILS.
select * from Employee


--2. LIST ALL THE DEPARTMENT DETAILS
select * from Department


--3. LIST ALL JOB DETAILS.
select * from Job


--4. LIST ALL THE LOCATIONS.
select * from Location

--5. LIST OUT THE FIRSTNAME, LASTNAME, SALARY, COMMISSION FOR ALL EMPLOYEES.
select First_Name, Last_Name, Salary, Comm
from Employee


--6. LIST OUT EMPLOYEEID,LAST NAME, DEPARTMENT ID FOR ALL EMPLOYEES AND ALIAS 
--EMPLOYEEID AS "ID OF THE EMPLOYEE", LAST NAME AS "NAME OF THE EMPLOYEE", DEPARTMENTID AS "DEP_ID".
select Employee_ID as ID_of_the_Employee, Last_name as Name_of_the_Employee, Department_ID as Dep_ID
from Employee

--7. LIST OUT THE EMPLOYEES ANNUAL SALARY WITH THEIR NAMES ONLY.
select First_name,Last_name,Salary
from Employee

--------------------------------------------------------------------------------------------------------------------------------------------------------

WHERE CONDITION:

--1. LIST THE DETAILS ABOUT "SMITH"
select *
from Employee
where Last_Name = 'Smith'

--2. LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 20.
select *
from Employee
where Department_ID = 20

--3. LIST OUT THE EMPLOYEES WHO ARE EARNING SALARY BETWEEN 3000 AND 4500.
select *
from Employee
where Salary between 3000 and 4500

--4. LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 10 OR 20.
select *
from Employee
where Department_ID = 10 or Department_ID =20

--5. FIND OUT THE EMPLOYEES WHO ARE NOT WORKING IN DEPARTMENT 10 OR 30.
select *
from Employee
--where not Department_ID =10 or not Department_ID =30
where Department_ID not in (10,30)

--6. LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S'.
select *
from Employee
where Last_Name like 'S%'

--7. LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S' AND ENDS WITH 'H'.
select *
from Employee
where Last_Name like 'S%H'

--8. LIST OUT THE EMPLOYEES WHOSE NAME LENGTH IS 4 AND START WITH 'S'.
select *
from Employee
where Last_Name like 'S___'

--9. LIST OUT EMPLOYEES WHO ARE WORKING IN DEPARRTMENT 10 AND DRAW THE SALARIES MORE THAN 3500.
select *
from Employee
where Department_ID = 10 and Salary >3500

--10. LIST OUT THE EMPLOYEES WHO ARE NOT RECEVING COMMISSION.
select *
from Employee
where Comm is null

-------------------------------------------------------------------------------------------------------------------------------------------------------------

ORDER BY CLAUSE:

--1. LIST OUT THE EMPLOYEE ID, LAST NAME IN ASCENDING ORDER BASED ON THE EMPLOYEE ID.
select Employee_ID, Last_name
from Employee
order by Employee_ID

--2. LIST OUT THE EMPLOYEE ID, NAME IN DESCENDING ORDER BASED ON SALARY.
select Employee_ID,Last_name,Salary
from Employee
order  by Salary desc

--3. LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST-NAME IN ASCENDING ORDER
select *
from Employee
order by Last_Name 

--4. LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST-NAME IN ASCENDING ORDER AND THEN ON DEPARTMENT_ID IN DESCENDING ORDER.
select *
from Employee
order by Last_Name, Department_ID desc

--------------------------------------------------------------------------------------------------------------------------------------------------------------

GROUP BY & HAVING CLAUSE

--1. HOW MANY EMPLOYEES, WHO ARE IN DIFFERENT DEPARTMENTS WISE IN THE ORGANIZATION.
select Name,count(Employee_ID) as no_of_emp
from Employee e
inner join Department d on e.Department_ID=d.Department_ID
group by Name

select *
from Employee

select *
from Job

--2. LIST OUT THE DEPARTMENT WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARY OF THE EMPLOYEES.
select Name,Max(Salary) as Max_sal,Min(Salary) as Min_sal,AVG(Salary) as Avg_sal
from Employee e
join Department d on e.Department_ID=d.Department_ID
group by Name

--3. LIST OUT JOB WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARIES OF THE EMPLOYEES.
select Designation,Max(Salary) as Max_sal,Min(Salary) as Min_sal,AVG(Salary) as Avg_sal
from Employee e
join Job j on e.Job_ID=j.Job_ID
group by Designation

--4. LIST OUT THE NUMBER OF EMPLOYEES JOINED IN EVERY MONTH IN ASCENDING ORDER.
select count(Employee_ID) as no_of_emp,Month(Hire_Date) as joined_month
from Employee
Group by Hire_Date
order by Hire_Date

--5. LIST OUT THE NUMBER OF EMPLOYEES FOR EACH MONTH AND YEAR, IN THE ASCENDING ORDER BASED ON THE YEAR, MONTH.
select count(Employee_ID) as no_of_emp,MONTH(Hire_Date) as month_of_join, YEAR(Hire_Date) as year_of_join
from Employee
group by Hire_Date
order by year_of_join asc,month_of_join desc

--6. LIST OUT THE DEPARTMENT ID HAVING ATLEAST FOUR EMPLOYEES.
select Department_ID,Count(Employee_ID)
from Employee 
group by Department_ID
having COUNT(Employee_ID)=4

--7. HOW MANY EMPLOYEES JOINED IN JANUARY MONTH.
select count(Employee_ID), MONTH(Hire_Date)
from Employee
group by Hire_Date
Having Month(Hire_Date) = 01

--8. HOW MANY EMPLOYEES JOINED IN JANUARY OR SEPTEMBER MONTH.
select count(Employee_ID), MONTH(Hire_Date)
from Employee
group by Hire_Date
Having MONTH(Hire_Date) in (1,9,4)   -- 01 or MONTH(Hire_Date) = 09 or MONTH(Hire_Date) = 04

--9. HOW MANY EMPLOYEES WERE JOINED IN 1985?
select COUNT(Employee_ID), YEAR(Hire_Date)
from Employee
group by Year(Hire_Date)
Having YEAR(Hire_Date) = 1985 

--10. HOW MANY EMPLOYEES WERE JOINED EACH MONTH IN 1985.
select count(Employee_ID) as no_of_emp, MONTH(Hire_Date) as month_join, YEAR(Hire_Date) year_join
from Employee
group by Hire_Date
having YEAR(Hire_Date) = 1985

--11. HOW MANY EMPLOYEES WERE JOINED IN MARCH 1985?
select count(Employee_ID) no_of_emp, MONTH(Hire_date) Month_join, YEAR(Hire_Date) as Year_Join
from Employee
group by Hire_Date
having YEAR(Hire_date) = 1985 and MONTH(Hire_Date)= 03 

--12. WHICH IS THE DEPARTMENT ID, HAVING GREATER THAN OR EQUAL TO 3 EMPLOYEES JOINED IN APRIL 1985?
select COUNT(Employee_ID), Department_ID,MONTH(Hire_Date), YEAR(Hire_Date)
from Employee
group by Hire_Date, Department_ID
Having MONTH(Hire_Date) = 04 and Year(Hire_Date) = 1985 and Count(Employee_ID) >=3

select *
from Employee

-------------------------------------------------------------------------------------------------------------------------------------------------------------

--JOINS

--1. LIST OUT EMPLOYEES WITH THEIR DEPARTMENT NAMES.
select  e.Employee_ID,e.Last_Name, d.Name
from Employee e
join Department d on e.Department_ID = d.Department_ID

--2. DISPLAY EMPLOYEES WITH THEIR DESIGNATIONS.
select e.Last_name,j.Designation
from Employee e
join Job j on e.Job_ID = j.Job_ID

--3. DISPLAY THE EMPLOYEES WITH THEIR DEPARTMENT NAMES AND REGIONAL GROUPS.
select e.Last_Name, d.Name, l.City
from Employee e
join Department d on e.Department_ID = d.Department_ID
join Location l on d.Location_ID = l.Location_ID

--4. HOW MANY EMPLOYEES WHO ARE WORKING IN DIFFERENT DEPARTMENTS AND DISPLAY WITH DEPARTMENT NAMES.
select count(Employee_ID) as no_of_emp,d.Name
from Employee e
join Department d on e.Department_ID = d.Department_ID
group by d.Name

--5. HOW MANY EMPLOYEES WHO ARE WORKING IN SALES DEPARTMENT.
select COUNT(Employee_ID),d.Name
from Employee e
join Department d on e.Department_ID = d.Department_ID
group by d.Name 
Having d.Name = 'Sales'

--6. WHICH IS THE DEPARTMENT HAVING GREATER THAN OR EQUAL TO 5 EMPLOYEES AND DISPLAY THE DEPARTMENT NAMES IN ASCENDING ORDER.
select COUNT(Employee_ID),d.Name
from Employee e
join Department d on e.Department_ID = d.Department_ID
group by d.Name
having count(Employee_ID)>=5
order by d.Name asc

--7. HOW MANY JOBS IN THE ORGANIZATION WITH DESIGNATIONS.
select count(Job_ID) as no_of_jobs, Designation
from Job
group by Designation

--8. HOW MANY EMPLOYEES ARE WORKING IN "NEW YORK".
select COUNT(Employee_ID) as No_of_emp, l.City
from Employee e
join Department d on e.Department_ID=d.Department_ID
join Location l on d.Location_ID = l.Location_ID
group by l.City
Having l.City = 'Dallas'


--9. DISPLAY THE EMPLOYEE DETAILS WITH SALARY GRADES.

Create table Salary_Grade(
	Grade Varchar(30),
	Lower_bound int,
	Upper_bound int
	)

insert into Salary_Grade (Grade,Lower_bound,Upper_bound)
values ('I',4000.00,5000.00),
	('II',3999.00,3000.00),
	('III',2999.00,2000.00),
	('IV',1999.00,1000.00),
	('V',999.00,300)

select * from Salary_Grade

select last_name,salary,grade
from employee e,salary_grade s
where salary between lower_bound and upper_bound

--10. LIST OUT THE NO. OF EMPLOYEES ON GRADE WISE.
select grade,count(*)
from salary_grade s,employee e
where salary between lower_bound and upper_bound
group by grade
order by grade desc

--11. DISPLAY THE EMPLOYEE SALARY GRADES AND NO. OF EMPLOYEES BETWEEN 2000 TO 5000 RANGE OF SALARY.
select grade,count(*)
from salary_grade s,employee e
where salary between lower_bound and upper_bound
			and lower_bound>=2000 and upper_bound<=5000
group by grade
order by grade

--12. DISPLAY THE EMPLOYEE DETAILS WITH THEIR MANAGER NAMES.
alter table Employee
add Manager_ID int 

update Employee
set Manager_ID = case 
	when Employee_ID = 7369 then 7902
	when Employee_ID = 7499 then 7698
	when Employee_ID = 7505 then 7839
	when Employee_ID = 7506 then 7839
	when Employee_ID = 7507 then 7839
	when Employee_ID = 7521 then 7698
	else 0
end;


Select e.Employee_ID Employee_ID,e.last_name Employee_name, m.last_name Manager_name 
from Employee e
join Employee m on e.Manager_ID=m.Manager_ID

--13. DISPLAY THE EMPLOYEE DETAILS WHO EARN MORE THAN THEIR MANAGERS SALARIES.
select e.last_name "employee name",
	e.salary "employee salary",
    m.last_name "manager name",
    m.salary "manager salary"
from employee e
inner join employee m on e.manager_id=m.employee_id and e.salary>m.salary

--14. SHOW THE NO. OF EMPLOYEES WORKING UNDER EVERY MANAGER.
select m.last_name,count(*) "number of employees"     
from employee e
inner join employee m on m.employee_id=e.manager_id
group by m.last_name
	     

--15. DISPLAY EMPLOYEE DETAILS WITH ALL DEPARTMENTS.
Select m.manager_id, count(*) 
from employee e
join employee m on e.employee_id=m.manager_id 
group by m.manager_id

--16. DISPLAY ALL EMPLOYEES IN SALES OR OPERATION DEPARTMENTS.select employee_id,last_name,e.department_id,name
from employee e
left outer join department d on e.department_id=d.department_id
and d.department_id in (select department_id from department
                        where name in('sales','operations'))

------------------------------------------------------------------------------------------------------------------------------------------------------------

--SET OPERATORS

--1. LIST OUT THE DISTINCT JOBS IN SALES AND ACCOUNTING DEPARTMENTS.                

select Job_ID
from Employee


select distinct salesjobs.Designation
from employee as salesemployees
join Job as salesjobs on salesemployees.Job_ID = salesjobs.Job_ID
join Department as salesdepartments on salesemployees.Department_ID = salesdepartments.Department_ID
where salesdepartments.name = 'sales'

union

select distinct accountingjobs.Designation
from employee as accountingemployees
join Job as accountingjobs on accountingemployees.Job_ID = accountingjobs.Job_ID
join department as accountingdepartments on accountingemployees.Department_ID = accountingdepartments.Department_ID
where accountingdepartments.name = 'accounting';


--2. LIST OUT ALL THE JOBS IN SALES AND ACCOUNTING DEPARTMENTS.

select salesjobs.Designation
from employee as salesemployees
join Job as salesjobs on salesemployees.Job_ID = salesjobs.Job_ID
join Department as salesdepartments on salesemployees.Department_ID = salesdepartments.Department_ID
where salesdepartments.name = 'sales'

union all

select accountingjobs.Designation
from employee as accountingemployees
join Job as accountingjobs on accountingemployees.Job_ID = accountingjobs.Job_ID
join department as accountingdepartments on accountingemployees.Department_ID = accountingdepartments.Department_ID
where accountingdepartments.name = 'accounting';

--3. LIST OUT THE COMMON JOBS IN RESEARCH AND ACCOUNTING DEPARTMENTS IN ASCENDING ORDER.

select Designation
from Job
where Job_ID in (
    select distinct researchemployees.Job_ID
    from Employee as researchemployees
    join Department as researchdepartments on researchemployees.Department_ID = researchdepartments.Department_ID
    where researchdepartments.name = 'research'
)

intersect

select Designation
from Job
where Job_ID in (
    select distinct accountingemployees.job_ID
    from Employee as accountingemployees
    join Department as accountingdepartments on accountingemployees.Department_ID = accountingdepartments.Department_ID
    where accountingdepartments.name = 'accounting'
)
order by Designation;

------------------------------------------------------------------------------------------------------------------------------------------------------------

--SUB QUERIES

--1. DISPLAY THE EMPLOYEES LIST WHO GOT THE MAXIMUM SALARY.

select top(3)*
from Employee
where Salary in (select Salary
				from Employee
				) 
order by Salary desc

select * 
from Employee
where salary in (select max(Salary)
				 from Employee)


--2. DISPLAY THE EMPLOYEES WHO ARE WORKING IN SALES DEPARTMENT.
select *
from Employee
where Department_ID in (select Department_ID
					from Department
					where Name = 'Sales')

--3. DISPLAY THE EMPLOYEES WHO ARE WORKING AS 'CLERCK'.
select *
from Employee
where Job_ID in (select Job_ID
				from Job
				where Designation = 'Clerk')


--4. DISPLAY THE LIST OF EMPLOYEES WHO ARE LIVING IN "NEW YORK".
select *
from Employee
where Department_ID in (select Department_ID
						from Department
						where Location_ID in (select Location_ID
												from Location
												where city = 'New York'));


--5. FIND OUT NO. OF EMPLOYEES WORKING IN "SALES" DEPARTMENT.

select count(Employee_ID)
from Employee
where Department_ID in (select Department_ID
						from Department
						where Name = 'Research')

--6. UPDATE THE EMPLOYEES SALARIES, WHO ARE WORKING AS CLERK ON THE BASIS OF 10%.


update Employee
set Salary = (Salary + Salary *0.1)
where Job_ID in (select Job_ID
				from Job
				where Designation = 'Clerk')


--7. DELETE THE EMPLOYEES WHO ARE WORKING IN ACCOUNTING DEPARTMENT.

delete Employee
where Department_ID in (select Department_ID
						from Department
						where Name = 'Accounting')


--8. DISPLAY THE SECOND HIGHEST SALARY DRAWING EMPLOYEE DETAILS.
select top 1 Salary
from Employee
where Salary in (select top 2 Salary
				from Employee
				order by Salary desc)
order by salary asc



--9. DISPLAY THE N'TH HIGHEST SALARY DRAWING EMPLOYEE DETAILS. (3rd)
select top 1 Salary
from Employee
where Salary in (select top 3 Salary
				from Employee
				order by Salary desc)
order by salary asc


--10. LIST OUT THE EMPLOYEES WHO EARN MORE THAN EVERY EMPLOYEE IN DEPARTMENT 30.
select *
from Employee
where salary in (select MAX(Salary)
				from Employee
				where Department_ID = 30)


--11. LIST OUT THE EMPLOYEES WHO EARN MORE THAN THE LOWEST SALARY IN DEPARTMENT 30.
select *
from Employee
where salary in (select MIN(Salary)
				from Employee
				where Department_ID = 30)

--12. FIND OUT WHOSE DEPARTMENT HAS NOT EMPLOYEES.
select Name
from Department
where Department_ID not in (select Department_ID
							from Employee)

--13. FIND OUT WHICH DEPARTMENT DOES NOT HAVE ANY EMPLOYEES.
select Name
from Department
where Department_ID not in (select Department_ID
							from Employee)

--14. FIND OUT THE EMPLOYEES WHO EARN GREATER THAN THE AVERAGE SALARY FOR THEIR DEPARTMENT
select Employee_ID,Last_Name,Salary,Department_ID
from Employee e
where Salary > (select AVG(Salary)
				from Employee e1
				where e1.Department_ID = e.Department_ID)



