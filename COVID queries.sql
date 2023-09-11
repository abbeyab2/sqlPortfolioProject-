select *
from CovidDeaths
order by 3,4

select *
from CovidVaccinations
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
where location like '%state%'
order by 1,2

--likelihood of dieing of covid in locations
select location, date,population, total_cases, total_deaths,(total_deaths*100)/total_cases as PercentageDeath
from CovidDeaths
where total_deaths is not null AND location like '%Australia%'
order by 1,2

--what is the percentage of the population that got covid 
select location, date, population, total_cases, (total_cases/population)*100 as PercentageOfInfections
from CovidDeaths
where total_cases is not null AND location like '%Australia%'
order by 1,2

--which country have the highest infection per her popuplation 
select location,  population, max(total_cases) as TotalNoInfection, max((total_cases/population)*100) as PercentofInfectedpopulation
from CovidDeaths
where total_cases is not null
group by location, population
order by percentofinfectedpopulation desc

--highest COVID death count by country
select location, population, max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
where continent is not null and total_deaths is not null
group by location, population
order by TotalDeathCount desc

--highest COVID death count by continet(this part of the data is not clean... as there location inputed as continent.
select location, max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths
where continent is null
group by location
order by TotalDeathCount desc

--GLOBAL NUMBERS 
select date, sum(new_cases) as TotalNewCase, sum(cast(total_deaths as int)) as TotalDeath
from CovidDeaths
where continent is not null
group by date
order by 1,2

select *
from CovidDeaths as CD
join CovidVaccinations as CV
on CD.location = CV.location and CD.date = CV.date

