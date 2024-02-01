use sakila;

use sqlclass_db;

select * from nobel;

# 1)
select year, category, fullname
from nobel
where category in ('Physics', 'Peace');

# 2)
select year, category, birth_continent, birth_country
from nobel as n
where n.fullname = 'Albert Einstein';

# 3)
select year, fullname, birth_country
from nobel n
where year between 1910 and 2010;

# 4)
select category, fullname
from nobel n 
where n.fullname like 'John%';

# 5)
select * from nobel
where (year = '1964') and (category not in ('Physiology', 'Medicine'));

# 6)
select year, fullname, gender, birth_country
from nobel
where (category = 'Literature') and (year between '2000' and '2019');

select * from nobel;

# 7)
select category, count(*) as 수상자수
from nobel
group by category 
order by count(*) desc;

# 8)
select distinct year 
from nobel
where year in (select year from nobel where category = 'Physiology or Medicine');

# 9)
select count(distinct year)
from nobel
where year not in (select year from nobel where category = 'Physiology or Medicine');

# 10)
select fullname, category, birth_country
from nobel
where gender = 'female';

# 11)
select birth_country, count(*) as 횟수
from nobel
group by birth_country
order by count(*) desc;

# 12)
select * from nobel
where birth_country = 'Korea';

# 13)
select * from nobel
where (birth_country not in ('Europe', 'North America')) and (birth_country is not null);

# 14)
select birth_country, count(*) as 수상횟수
from nobel
group by birth_country
having count(*) >= 10
order by count(*) desc;

# 15)
select fullname, count(*) as 횟수
from nobel
where fullname != ''
group by fullname
having count(*) >= 2
order by fullname;