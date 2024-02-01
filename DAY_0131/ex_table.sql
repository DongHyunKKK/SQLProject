show databases;

use sakila;

select now();

create database testdb;

use testdb;

# person 테이블 생성
# constraint pk_person : 제약 조건의 이름 설정
# drop table if exists person;
create table person
	(person_id smallint unsigned,
	fname varchar(20),
	lname varchar(20),
	eye_color enum('BR', 'BL', 'GR'),
	birth_date DATE,
	street varchar(30),
	city varchar(20),
	state varchar(20),
	country varchar(20),
	postal_code varchar(20),
	constraint pk_person primary key (person_id)
);

# person table 정보 확인
desc person;

# drop table if exists favorit_food; 
create table favorite_food
	(person_id smallint unsigned,
	food varchar(20),
	constraint pk_favorite_food primary key (person_id, food),
	constraint fk_fav_food_person_id foreign key (person_id) references person(person_id)
);

desc favorite_food;

set foreign_key_checks = 0;
alter table person modify person_id smallint unsigned auto_increment;
set foreign_key_checks = 1;

# 위에서 auto_increment 속성을 설정했기 떄문에 null로 정해도 persion_id에 1이 생성된다.
insert into person
	(person_id, fname, lname, eye_color, birth_date)
	values (null, 'William', 'Turner', 'BR', '1972-05-27');

select * from person;

select person_id, fname, lname, birth_date from person;

select person_id, fname, lname, birth_date
from person where lname = 'Turner';

insert into favorite_food (person_id, food)
values (1, 'pizza'),
	   (1, 'cookie'),
       (1, 'nachos');
      
select food from favorite_food
where person_id = 1 order by food;

insert into person
(person_id, fname, lname, eye_color, birth_date,
street, city, state, country, postal_code)
values(null, 'Susan', 'Smith', 'BL', '1975-11-02',
'23 Maple st.', 'Arlington', 'VA', 'USA', '20220');

select person_id, fname, lname, birth_date from person;

update person
set street = '1225 Tremon St.',
	city = 'MA',
	country = 'USA',
	postal_code = '02138'
where person_id = 1;

select * from person;

delete from person where person_id = 2;

select * from person;

# person 테이블에 데이터 추가
insert into person(person_id, fname, lname)
value (null, 'Kevin', 'Kern');

# favorited_food 테이블의 3번에 데이터 추가
insert into favorite_food (person_id, food)
values (3, 'lasagna');
select * from favorite_food;

update person set birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
where person_id = 1;

select * from person;
