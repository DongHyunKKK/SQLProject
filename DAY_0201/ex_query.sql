use sakila;

select * from language;

select name from language;

select language_id,
	'COMMON' language_usage,
	language_id * 3.14 lang_pi_value,
	upper(name) language_name
from language;

# 위와 결과 동일
select language_id,
	'COMMON' as language_usage,
	language_id * 3.14 as lang_pi_value,
	upper(name) as language_name
from language;

# 중복된 actor_id 발생
select actor_id from film_actor order by actor_id;

# 중복 제거
select distinct actor_id from film_actor order by actor_id;

# 파생 테이블 만들기
select first_name, last_name, email
	from customer
	where first_name = 'JESSIE';

select concat(cust.last_name, ', ', cust.first_name) full_name, cust.email
from
	(select first_name, last_name, email
	from customer
	where first_name = 'JESSIE'
	) as cust;

# 위 결과와 동일
select concat(last_name, '. ', first_name) full_name, email
from customer
where first_name = 'JESSIE';

# 임시 테이블 만들기
create temporary table actors_j
   (actor_id smallint(5),
   first_name varchar(45),
   last_name varchar(45));
desc actors_j;

select actor_id, first_name, last_name
from actor where last_name like 'J%';

insert into actors_j
	select actor_id, first_name, last_name
	from actor where last_name like 'J%';

select * from actors_j;

# 가상 테이블 만들기
create view cust_vw as
	select customer_id, first_name, last_name, active
	from customer;

select * from cust_vw;

select first_name, last_name from cust_vw
where active = 0;

# 테이블 연결
select customer.first_name, customer.last_name,
	time(rental.rental_date) as rental_time
from customer inner join rental
	on customer.customer_id = rental.customer_id 
where date(rental.rental_date) = '2005-06-14';

# DATETIME 데이터
select date('2021-07-29 09:02:03');  # date() 함수

select time('2021-07-29 09:02:03');  # time() 함수


select c.first_name, c.last_name,
	time(r.rental_date) rental_date
from customer c inner join rental r
	on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14';

# 위에서 as 키워드 추가, 결과는 같다.
select c.first_name, c.last_name,
	time(r.rental_date) as rental_date
from customer as c inner join rental as r
	on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14';


# Where 절 - 필터 조건
select title
from film
where rating = 'G' and rental_duration >= 7;

# Where 절 - 필터 조건
select title, rating, rental_duration
from film
where (rating = 'G' and rental_duration >= 7)
	or (rating = 'PG-13' and rental_duration < 4);

# Group by절과 having절
select c.first_name, c.last_name, count(*) as 대여횟수
from customer as c inner join rental as r
	on c.customer_id = r.customer_id 
group by c.first_name, c.last_name
having count(*) >= 40;
order by count(*) desc;

# order by절 - 오름차순 정렬
select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c inner join rental as r
	on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14'
order by c.last_name, c.first_name asc;

# order by절 - 내림차순 정렬
select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c 
	inner join rental as r
	on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14'
order by c.last_name, c.first_name desc;

# order by절 - 컬럼순서(index)를 통한 정렬
select c.first_name, c.last_name,
	time(r.rental_date) as rental_time
from customer as c
	inner join rental as r
	on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14'
order by time(r.rental_date) desc;  # 1부터 시작

# 실습 3-1
select actor_id, first_name, last_name
from actor
order by last_name, first_name;  # last_name이 동일한 경우 first_name 순으로 정렬

# 실습 3-2
select actor_id, first_name, last_name
from actor
where last_name = 'WILLIAMS' or last_name = 'DAVIS';

# 실습 3-3
select distinct customer_id
from rental
where date(rental_date) = '2005-07-05';

# 실습 3-4
select c.store_id, c.email, r.rental_date, r.return_date
from customer as c inner join rental as r
	on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14'
order by return_date desc;

