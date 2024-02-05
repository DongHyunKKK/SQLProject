use sakila;

# 합집합 => union all, 중복 제거 안됨
select 'ACTR1' as type, a.first_name, a.last_name
from actor as a
union all
select 'ACTR2' as type, a.first_name, a.last_name
from actor as a;

select c.first_name, c.last_name
from customer c
where c.first_name like 'J%' and c.last_name like 'D%'
union all
select a.first_name, a.last_name
from actor a
where a.first_name like 'J%' and a.last_name like 'D%';

# 합집합 => union, 중복 제거
select c.first_name, c.last_name
from customer c
where c.first_name like 'J%' and c.last_name like 'D%'
union
select a.first_name, a.last_name
from actor a
where a.first_name like 'J%' and a.last_name like 'D%';

# 교집합과 내부 조인 비교
select c.first_name, c.last_name
from customer c
where c.first_name like 'J%' and c.last_name like 'D%'
intersect
select a.first_name, a.last_name
from actor a
where a.first_name like 'J%' and a.last_name like 'D%';

select c.first_name, c.last_name
from customer as c
	inner join actor as a
	on (c.first_name = a.first_name) and (c.last_name = a.last_name)
where a.first_name like 'J%' and a.last_name like 'D%';

# 실습 6-3
select first_name, last_name
from actor
where last_name like 'L%'
union
select first_name, last_name
from customer
where last_name like 'L%'
order by last_name;
