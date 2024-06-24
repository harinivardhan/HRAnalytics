SELECT * FROM hranalytics.`merged hr1 & hr2`;


#1 Average Attrition rate for all Departments

with cte as (
SELECT department, count(case when attrition = 'Yes' then 1 end) as attritioncount,
count(employeenumber) totalemployees
 FROM hranalytics.`merged hr1 & hr2`
 group by department)
 select Department, (attritioncount/totalemployees)*100 as AttritionRate from cte
 ;


with cte as (
SELECT department, count(case when attrition = 'Yes' then 1 end) as attritioncount
 FROM hranalytics.`merged hr1 & hr2`
 group by department)
 select Department, round((attritioncount)*100/(select sum(attritioncount) from cte),1) as AttritionRate from cte
 ;

#2 Average Hourly rate of Male Research Scientist

SELECT Gender, jobrole, avg(HourlyRate) FROM hranalytics.`merged hr1 & hr2`
where Gender = 'Male' and jobrole ='Research Scientist'
group by Gender, jobrole;


#3 Attrition rate Vs Monthly income stats

with cte as(
SELECT 
case when `Sheet 2.MonthlyIncome`>1000 and `Sheet 2.MonthlyIncome`<5000 then '1000-5000'
when `Sheet 2.MonthlyIncome`<10000 then '5000-10000'
when `Sheet 2.MonthlyIncome`<20000 then '10000-20000'
when `Sheet 2.MonthlyIncome`<30000 then '20000-30000'
when `Sheet 2.MonthlyIncome`<40000 then '30000-40000'
when `Sheet 2.MonthlyIncome`>40000 then '40000+'
else "<1000"
end as IncomeRange,
count(case when attrition = 'Yes' then 1 end) as attritioncount
FROM hranalytics.`merged hr1 & hr2`
group by IncomeRange)
select IncomeRange, round( (attritioncount)*100/(select sum(attritioncount) from cte),1) as AttritionRate from cte
;


#4 Average working years for each Department

SELECT Department, avg(`Sheet 2.TotalWorkingYears`) as AverageWorkingYear
FROM hranalytics.`merged hr1 & hr2`
group by Department
;


#5 Job Role Vs Work life balance

SELECT jobrole, `Sheet 2.WorkLifeBalance`,count(EmployeeNumber) FROM hranalytics.`merged hr1 & hr2`
group by jobrole,`Sheet 2.WorkLifeBalance`
order by jobrole
;

#6 Attrition rate Vs Year since last promotion relation


with cte as(
SELECT 

case 
when `Sheet 2.YearsSinceLastPromotion` <=5 then '1-5'
when `Sheet 2.YearsSinceLastPromotion` <=10  then '6-10'
when `Sheet 2.YearsSinceLastPromotion` <=15  then '11-15'
when `Sheet 2.YearsSinceLastPromotion` <=20  then '16-20'
when `Sheet 2.YearsSinceLastPromotion` <=25  then '21-25'
when `Sheet 2.YearsSinceLastPromotion` <=30  then '26-30'
when `Sheet 2.YearsSinceLastPromotion` <=35  then '31-35'
else '36-40'
end as YearSinceLastPromotion,
count(case when attrition = 'Yes' then 1 end) as attritioncount
FROM hranalytics.`merged hr1 & hr2`
group by YearSinceLastPromotion)
select YearSinceLastPromotion,  round( (attritioncount)*100/(select sum(attritioncount) from cte),1) as AttritionRate from cte
;



#7 Attrition rate vs Job Satisfaction

With cte as(
SELECT JobSatisfaction,count(case when attrition = 'Yes' then 1 end) as attritioncount FROM hranalytics.`merged hr1 & hr2`
group by jobsatisfaction)
select Jobsatisfaction, round( (attritioncount)*100/(select sum(attritioncount) from cte),1) as AttritionRate from cte order by jobsatisfaction ;	




#8 Business travel vs Attrition rate

with cte as (
SELECT businesstravel, count(case when attrition = 'Yes' then 1 end) as attritioncount
 FROM hranalytics.`merged hr1 & hr2`
 group by BusinessTravel)
 select businesstravel, round( (attritioncount)*100/(select sum(attritioncount) from cte),1) as AttritionRate from cte 
 ;
  
 #9 PERFORMANCE RATING VS Average WORKING YEARS
 
 SELECT  `Sheet 2.PerformanceRating`,round(avg(`Sheet 2.TotalWorkingYears`),1) as AverageWorkingYears FROM hranalytics.`merged hr1 & hr2`
 group by `Sheet 2.PerformanceRating` order by `Sheet 2.PerformanceRating`
 ;  
 
 



 