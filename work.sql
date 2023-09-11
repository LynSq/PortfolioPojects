--- Technology Company Layoffs (2022 - 2023)
--- Source: Kaggle

--Selecting all data available
select *
from project.dbo.tl

--Number of companies listed in this data by location
select distinct Headquarter_location, count(Company) as Number_of_Companies
from project.dbo.tl
group by Headquarter_location 
order by Number_of_Companies desc

-- How many companies are public or private
SELECT distinct status, COUNT(Company)
from project.dbo.tl
group by status 

--How many companies per data source provided
SELECT distinct Sources, COUNT(Company) as Number_of_Companies_Researched
from project.dbo.tl
group by Sources 
order by Number_of_Companies_Researched desc 

--Top 10 most impacted industries from layoffs
select top 10 industry, impacted_workforce_percentage
from project.dbo.tl
order by impacted_workforce_percentage desc 

--Top 10 least impacted industries from layoffs
select top 10 industry, impacted_workforce_percentage
from project.dbo.tl
WHERE impacted_workforce_percentage IS NOT NULL
order by impacted_workforce_percentage 

--Top 10 companies with the most layoffs in the dataset
select top 10 company, Total_layoffs
from project.dbo.tl
order by Total_layoffs desc 

--Which company status had the most layoffs (Private or Public)
select distinct Status, sum(Total_layoffs)
from project.dbo.tl
GROUP BY status

--The average status percentage of companies impacted
select distinct Status, ROUND(AVG(impacted_workforce_percentage), 2)
from project.dbo.tl
GROUP BY status

--Headquarter_location that had the most layoffs 
select distinct Headquarter_location, SUM(Total_layoffs) as layoffs
from project.dbo.tl
WHERE Total_layoffs is not null
GROUP BY Headquarter_location
ORDER BY layoffs desc 

--Headquarter_location that had the least layoffs 
select distinct Headquarter_location, SUM(Total_layoffs) as layoffs
from project.dbo.tl
WHERE Total_layoffs is not null
GROUP BY Headquarter_location
ORDER BY layoffs 

--Impacted workforce average percentage for each headquarter
select distinct Headquarter_location, ROUND(AVG(impacted_workforce_percentage), 2) as percentage
from project.dbo.tl
WHERE impacted_workforce_percentage IS NOT NULL
GROUP BY Headquarter_location
order by percentage desc

--Time period where the most layoffs happened 
select top 5 Reported_date, Total_layoffs
from project.dbo.tl
WHERE Total_layoffs is not null
order by Total_layoffs desc

--End of Analysis 