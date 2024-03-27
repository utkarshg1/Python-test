-- STEP 1: Create the table
create table athletes(
	ID int,
    Name varchar(200),
    Sex char(1),
    age int,
    height float,
    weight float,
    Team varchar(200),
    NOC varchar(5),
    Games varchar(200),
    Year int,
    Season varchar(50),
    City varchar(200),
    Sports varchar(200),
    Event varchar(200),
    Medal varchar(50));
    
-- STEP 2 : View the blank table
select * from athletes;

-- Viewing the path to add the file
SHOW VARIABLES LIKE "secure_file_priv";

-- STEP 3: Import the table using Load data infile query
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Athletes_Cleaned.csv' 
into table athletes
fields terminated by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
ignore 1 rows;

-- STEP 5: View the table
select * from athletes;

-- STEP 6: View no of rows
select count(*) from athletes;

-- STEP 7 : Settings
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Q1. Show how many medal counts present for entire data.
select medal, count(Medal) as medal_count
from athletes
group by medal;

-- Q2. Show count of unique Sports are present in olympics.
select count(distinct Sports) as sports_count
from athletes;

-- Q3. Show how many different medals won by Team India in data.
select medal, count(medal) as medal_count
from athletes
where Team='India' and medal<>'NoMedal'
group by medal;

-- Q4. Show event wise medals won by india show from highest to lowest medals won in order.
select event, count(medal) as medal_count
from athletes 
where team ='India' and medal<>'NoMedal'
group by event
order by medal_count desc;

-- Q5. Show event and yearwise medals won by india in order of year.
select year, event, count(medal) as medal_count
from athletes
where team='India' and medal<>'NoMedal'
group by event, year
order by year desc;

-- Q6. Show the country with maximum medals won gold, silver, bronze
select team, count(medal) as medal_count
from athletes
where medal<>'NoMedal'
group by team
order by medal_count desc
limit 1;

-- Q7. Show the top 10 countries with respect to gold medals
select team, count(medal) as gold_medal_count
from athletes
where medal='Gold'
group by team
order by gold_medal_count desc
limit 10;

-- Q8. Show in which year did United States won most medals
select year, count(medal) as medal_count
from athletes 
where team = 'United States' and medal<>'NoMedal'
group by year
order by medal_count desc
limit 1;

-- Q9. In which sports United States has most medals
select sports ,count(medal) as medal_count
from athletes 
where team = 'United States' and medal<>'NoMedal'
group by Sports
order by medal_count desc
limit 1;

-- Q10. Find top 3 players who have won most medals along with their sports and country.
select name, sports, team, count(medal) as medal_count
from athletes
where medal<>'NoMedal'
group by name
order by medal_count desc
limit 3;

-- Q11 Find player with most gold medals in cycling along with his country.
select name, team, count(medal) as gold_medal_count
from athletes
where medal='Gold' and sports='Cycling'
group by name
order by gold_medal_count desc
limit 1;

-- Q12. Find player with most medals (Gold + Silver + Bronze) in Basketball also show his country.
select name, team, count(medal) as medal_count
from athletes
where medal<>'NoMedal' and sports='Basketball'
group by name
order by medal_count desc
limit 1;

-- Q13. Find out the count of different medals of the top basketball player
select medal, count(medal) as medal_count
from athletes
where name='Teresa Edwards' and medal<>'NoMedal'
group by medal;

-- Q14. Find out medals won by male, female each year . Export this data and plot graph in excel.
select year, sex, count(medal) as medal_count
from athletes
where medal<>'NoMedal'
group by year, sex
order by year;