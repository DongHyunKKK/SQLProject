use sakila;

# 해당 식이 특정 범위 내에 있는지 확인
select customer_id, rental_date
from rental
where rental_date < '2005-05-25';

# rental_date 컬럼은 datetime 속성으로 시간을 같이 포함 => 16일 미포함
select customer_id, rental_date
from rental
where rental_date <= '2005-06-16'
	and rental_date >= '2005-06-14';

# date(rental_date)를 사용 : 정확한 날짜만 추출
select customer_id, rental_date
from rental
where date(rental_date) <= '2005-06-16'
	and date(rental_date) >= '2005-06-14';
	
# between 연산자 => between [범위의 하한값] and [범위의 상한값]
select customer_id, rental_date
from rental
where date(rental_date) between '2005-06-14' and '2005-06-16';

# 하한값과 상한값이 범위에 포함됨
select customer_id, payment_date, amount
from payment
where amount between 10.0 and 11.99;

# 문자열 범위
select last_name, first_name
from customer
where last_name between 'FA' and 'FRB';

# or 또는 in()연산
select title, rating
from film
where rating in ('G', 'PG');

select title, rating
from film where title like '%PET%';

select title, rating
from film
where rating in (select rating from film where title like '%PET%');

# not in 사용
select title, rating
from film
where rating not in ('PG-13', 'R', 'NC-17');

# 일치 조건
select last_name, first_name
from customer
where last_name like '_A_T%S';

# last_name이 'Q'로 시작하거나 'Y'로 시작하는 고객 이름 검색 => Q로 시작하는 데이터 출력 되고나서 Q로 시작하는 데이터 출력
select last_name, first_name
from customer
where last_name like 'Q%' or last_name like 'Y%';

# 정규 표현식 사용, '^[QY]' : Q 또는 Y로 시작하는 단어 검색 => 위와 결과 같다. 다만 데이터 출력 순서가 다르다.
select last_name
from customer
where last_name regexp '^[QY]';

# null과 조건 조합
select rental_id, customer_id, return_date
from rental
where return_date is null
or return_date not between '2005-05-01' and '2005-09-01';

# 실습 4-1
select payment_id, customer_id, amount, date(payment_date) as payment_id
from payment
where (payment_id between 101 and 120)
and customer_id != 5 and (amount > 8 or date(payment_date) = '2005-08-23');

# 실습 4-2
select payment_id, customer_id, amount, date(payment_date) as payment_date
from payment
where (payment_id between 101 and 120)
and customer_id = 5 and not (amount > 6 or date(payment_date) = '2005-06-19');

# 실습 4-3
select amount from payment
where amount in (1.98, 7.98, 9.98);
