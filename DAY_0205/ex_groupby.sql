use sakila;

# group by 예
select customer_id, count(*)
from rental
group by customer_id;

# 가장많이 대여한 회원 찾기
select customer_id, count(*)
from rental
group by customer_id
order by 2 desc;

# 위와 결과 동일
select customer_id, count(*)
from rental
group by customer_id
order by count(*) desc;

# 필터링 시 group by 뒤에 where이 아닌 having 절을 사용한다. 
select customer_id, count(*)
from rental
group by customer_id
having count(*) >= 40;

# payment 테이블 구성 확인
desc payment;

# payment 테이블의 amount 열에 집계 함수 계산
# - group by절을 사용하지 않음 : 집계 함수에 의해 생성된 값
select max(amount) as max_amt,
	min(amount) as min_amt,
	avg(amount) as avg_amt,
	sum(amount) as tot_amt,
	count(*) as num_payments
from payment;

select customer_id,
	max(amount) as max_amt,
	min(amount) as min_amt,
	avg(amount) as avg_amt,
	sum(amount) as tot_amt,
	count(*) as num_payments
from payment
group by customer_id;

# Null 값 처리

use sakila;

select actor_id, count(*)
from film_actor
group by actor_id;

# 다중 열 그룹화
# - 하나 이상의 열을 이용해서 그룹 생성
# 	- 각 배우들의 영화 등급별 출연 영화 수 계산
#   - group by 절에 여러 개의 컬럼을 사용하는 경우
#   	- select 절에도 해당 컬럼을 같이 사용
#       - 첫 번째 컬럼(fa.actor_id)으로 그룹화
#       - 두 번째 컬럼(f.rating)으로 집계
select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f
	on fa.film_id = f.film_id 
group by fa.actor_id, f.rating 
order by 1, 2;

# 롤업 생성
# - 각 배우/등급의 총합과 각 개별 배우의 총합 계산
# 	- with rollup 옵션
#		- group by 결과로 출력된 항목들의 합계를 나타내는 방법
select fa.actor_id, f.rating, count(*)
from film_actor as fa
	inner join film as f
	on fa.film_id = f.film_id
group by fa.actor_id, f.rating with rollup
order by 1, 2;

# 두 가지 필터 조건 사용
select fa.actor_id, f.rating, count(*)
from film_actor fa
	inner join film f
	on fa.film_id = f.film_id
where f.rating in ('G', 'PG')
group by fa.actor_id, f.rating
having count(*) > 9;

# 앞의 예제에서 having절을 제외한 쿼리 및 결과
select fa.actor_id, f.rating, count(*)
from film_actor fa
	inner join film f
	on fa.film_id = f.film_id
where f.rating in ('G', 'PG')
group by fa.actor_id, f.rating
order by 1 asc;