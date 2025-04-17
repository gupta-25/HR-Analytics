
create database P811_1stweek;
use P811_1stweek;


CREATE TABLE HR_1 (
    Age INT,                                      
    Attrition VARCHAR(10),                        
    BusinessTravel VARCHAR(50),                   
    DailyRate INT,                                
    Department VARCHAR(50),                      
    DistanceFromHome INT,                         
    Education VARCHAR(50),                      
    EducationField VARCHAR(50),                   
    EmployeeCount INT,                           
    EmployeeNumber INT PRIMARY KEY,               
    EnvironmentSatisfaction INT,                  
    Gender VARCHAR(10),                           
    HourlyRate INT,                          
    JobInvolvement INT,                          
    JobLevel INT,                             
    JobRole VARCHAR(50),                         
    JobSatisfaction INT,                      
    MaritalStatus VARCHAR(10)                     
);
DROP TABLE HR_1;
SHOW TABLES;
desc hr_1;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HR_1.csv' 
INTO TABLE HR_1 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

select * from hr_1;

CREATE TABLE HR_2 (
    EmployeeID INT NOT NULL,                  
    MonthlyIncome DECIMAL(10, 2),            
    MonthlyRate DECIMAL(10, 2),               
    NumCompaniesWorked INT,                  
    Over18 CHAR(1),                            
    OverTime CHAR(3),                         
    PercentSalaryHike DECIMAL(5, 2),          
    PerformanceRating INT,                    
    RelationshipSatisfaction INT,             
    StandardHours INT,                       
    StockOptionLevel INT,                     
    TotalWorkingYears INT,                    
    TrainingTimesLastYear INT,                
    WorkLifeBalance INT,                      
    YearsAtCompany INT,                      
    YearsInCurrentRole INT,               
    YearsSinceLastPromotion INT,             
    YearsWithCurrManager INT,               
    PRIMARY KEY (EmployeeID)                  
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/\Hr dataset' 
INTO TABLE HR_2 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

drop table hr_2;
show tables;
select * from hr_1;
select * from hr_2;

# Average Attrition rate for all Departments
select 
avg(Attrition_rate_percentage) as average_attrition_rate
from(
	select
    department, 
	(count(case	when attrition = 'yes' then 1 end)/count(*)*100)
    as Attrition_rate_percentage
	from hr_1
	group by department
    ) as department_attrition;

# Average Hourly rate of Male Research Scientist
select * from hr_1;
select 
Gender,
Jobrole,
avg(hourlyrate) as Avg_Hourly_Rate
from hr_1
where Gender = 'Male'
and
Jobrole = 'Research Scientist'
order by Avg_Hourly_Rate desc;

#Attrition rate Vs Monthly income stats
select * from hr_2;
select * from hr_1;

select 
sum(monthlyincome)as monthly_income_stats,
	(count(case 
	when attrition = 'yes' then 1 END)/count(*)*100 )
    as attrition_rate
from hr_1
join
hr_2
on hr_1.employeenumber = hr_2.employeeid;

#Average working years for each Department
select
Department,
avg(TotalWorkingYears) as avg_working_yrs 
from hr_1
join
hr_2
on hr_1.employeenumber = hr_2.employeeid
group by Department;

#Job Role Vs Work life balance(avg,max,min,sum,count)
select * from hr_2;

select jobrole,
avg(worklifebalance)
from hr_1
join
hr_2
on hr_1.employeenumber=hr_2.EmployeeID
group by jobrole
order by 2;

#Attrition rate Vs Year since last promotion relation
select 
YearsSinceLastPromotion,
concat(
round(
count(case when attrition = 'yes' then 1 end)/(count(*))
*100,
2),
'%') as attrition_rate_percentage
from hr_1
join
hr_2
on hr_1.employeenumber = hr_2.employeeid
group by YearsSinceLastPromotion
order by 1;