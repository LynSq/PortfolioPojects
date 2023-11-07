--- Fast Food Joint Nutrition Values Dataset
--- Source : Kaggle

--Selecting all columns
select *
from dbo.food
where Product like '%veggie%'


--Avg amount of food served
select round(avg(PerServeSize), 2) as avgServe
from dbo.food

--Avg amount of food served by company
select distinct Company, round(avg(PerServeSize), 2) as avgServe
from dbo.food
where Company is not null
group by Company
order by avgServe DESC --KFC has the highest average serve of food 

--Average of everything
select Company, round(avg(PerServeSize), 2) as avgServe, round(avg(Energy), 2) as avg_energy, round(avg(Sugar), 2) as avg_suga, round(avg(Fiber), 2) as avg_fiber, round(avg(Sodium), 2) as avg_sodium, 
round(avg(TotalFat), 2) as avg_TotalF, round(avg(Cholesterol), 2) as avg_cholest, round(avg(TransFat), 2) as avg_TransF, round(avg(SaturatedFat), 2) as avg_sat
from dbo.food
where Company is not null
group by Company 

--Which product has the most fat in it
select company, Product, TotalFat
from dbo.food
where product is not null
order by TotalFat desc 


--What is the average energy level for these products
select round(avg(Energy), 2) as avgE
from dbo.food

--Which product has the most energy
select *
from dbo.food
where product is not null 
order by Energy desc --10 Pc fried leg from KFC has the most energy

--Each companies average, maximum, and minimum product energy level 
select Company, round(avg(Energy), 2) as avg_e, round(max(Energy), 2) as max_e, round(min(Energy), 2) as min_e
from dbo.food
where Company is not null AND TotalFat <> 0
group by Company
order by avg_e DESC --KFC has the most energetic food on avg
--Dominos has the least energetic food on avg



--Showing average nutrition levels without chicken products
select Company, round(avg(Energy), 2) as avg_energy, round(avg(Sugar), 2) as avg_suga, round(avg(Fiber), 2) as avg_fiber, round(avg(Sodium), 2) as avg_sodium, 
round(avg(TotalFat), 2) as avg_TotalF, round(avg(Cholesterol), 2) as avg_cholest, round(avg(TransFat), 2) as avg_TransF, round(avg(SaturatedFat), 2) as avg_sat
from dbo.food
where Product NOT LIKE '%Chicken%' AND Company != 'KFC' 
group by Company 
order by avg_energy desc --Burger King has the highest average level of energy, fiber, totalfat, and saturatedfat in this filter 



--Showing nutrition levels with chicken products only
select Company, round(avg(Energy), 2) as avg_energy, round(avg(Sugar), 2) as avg_suga, round(avg(Fiber), 2) as avg_fiber, round(avg(Sodium), 2) as avg_sodium, 
round(avg(TotalFat), 2) as avg_TotalF, round(avg(Cholesterol), 2) as avg_cholest, round(avg(TransFat), 2) as avg_TransF, round(avg(SaturatedFat), 2) as avg_sat
from dbo.food
where Product LIKE '%Chicken%' OR Product LIKE '%Pc%' 
group by Company
order by avg_energy desc --average nutrition levels are higher 
--KFC has the highest averages in energy, totalfat, saturated, and fiber


-- Showing average nutrition levels with veggie products only 
select Company, round(avg(Energy), 2) as avg_energy, round(avg(Sugar), 2) as avg_suga, round(avg(Fiber), 2) as avg_fiber, round(avg(Sodium), 2) as avg_sodium, 
round(avg(TotalFat), 2) as avg_TotalF, round(avg(Cholesterol), 2) as avg_cholest, round(avg(TransFat), 2) as avg_TransF, round(avg(SaturatedFat), 2) as avg_sat
from dbo.food
where Product LIKE '%Veggie%' and Product Not like '%Chicken%'
group by Company
order by avg_energy desc --Pizza hut has the highest averages in energy, fiber, totalfat, transfat, and saturatedfat in this filter


-- Avg, max, and min cholesteral with chicken products
WITH chicken AS (
SELECT round(AVG(Cholesterol), 2) as avg_c, max(Cholesterol) as max_c, min(Cholesterol) as min_c
FROM dbo.food
WHERE Product like '%Chicken%' or Product like '%Pc%' 
)
select *
from chicken -- chicken has the highest max out the cte's

-- Avg, max, and min cholesteral with veggies Products
WITH veggie AS (
select round(AVG(Cholesterol), 2) as avg_c, max(Cholesterol) as max_c, min(Cholesterol) as min_c
from dbo.food
where Product LIKE '%Veggie%'
)
select *
from veggie --Veggie has the lowest max cholesterol


-- Avg, max, and min cholesteral with Products other than chicken or veggies
WITH other AS (
SELECT round(AVG(Cholesterol), 2) as avg_c, max(Cholesterol) as max_c, min(Cholesterol) as min_c
FROM dbo.food
WHERE Product not like '%Chicken%' and Product not like '%Pc%' and Product not like '%Veggie%'
)
select *
from other -- other has the second lowest max
