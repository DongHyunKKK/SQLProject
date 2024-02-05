use testdb;

# 테이블 생성
create table string_tbl
(char_fld char(30),
vchar_fld varchar(30),
text_fld text);

# 문자열 데이터를 테이블에 추가
insert into string_tbl (char_fld, vchar_fld, text_fld)
values ('This is char data',
		'This is varchar data',
		'This is text data');

# 저장된 내용 확인
select * from string_tbl;

# 설정길이보다 문자열의 길이가 길어서 오류 발생
update string_tbl
set vchar_fld = 'This is a piece of extremely long varchar data';

# 문자열 내부에 작은 따옴표 포함 - 작은 따옴표를 하나 더 추가
update string_tbl
set text_fld = 'This string didn''t workm but it does now';

# 문자열 내부에 작은 따옴표 포함 - 백슬래시('\') 문자 추가
# update string_tbl
# set text_fld = 'This string didn\'t work, butit does now';

# 문자열 내부에 작은 따옴표 포함 - quote() 내장 함수
select quote(text_fld)
from string_tbl;

insert into string_tbl(char_fld, vchar_fld, text_fld)
values ('This string is 28 characters',
		'This string is 28 characters',
		'This string is 28 characters');

# length() 함수 : 문자열의 개수를 반환
select length(char_fld) char_length,
length(vchar_fld) as varchar_length,
length(text_fld) as text_length
from string_tbl;

# position() 함수 => 부분 문자열의 위치를 반환
select position('characters' in vchar_fld), vchar_fld
from string_tbl;

# locate('문자열', 열이름, 시작위치) 함수
select locate('is', vchar_fld, 5), vchar_fld
from string_tbl;

# strcmp('문자열1', '문자열2') 함수 : 문자열 비교

# string_tbl 삭제후 새로운 데이터 추가
delete from string_tbl;

insert into string_tbl(vchar_fld)
values ('abcd'), ('xyz'), ('QRSTUV'), ('qrstuv'), ('12345');

# vchar_fld의 값을 오름 차순 정렬
select vchar_fld from string_tbl order by vchar_fld;

# strcmp() 예제 - 5개의 서로 다른 문자열 비교
select strcmp('12345', '12345') 12345_12345,
	   strcmp('abcd', 'xyz') abcd_xyz,
	   strcmp('abcd', 'QRSTUV') abcd_QRSTUV,
	   strcmp('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
	   strcmp('12345', 'xyz') 12345_xyz,
	   strcmp('xyz', 'qrstuv') xyz_qrstuv;
	
	  
use sakila;

# y로 끝나면 1을 반환, 아니면 0을 반환
select name, (name like '%y') ends_in_y
from category;

# 위와 결과 동일
select name, (name regexp 'y$') ends_in_y
from category;

use testdb;

# string_tbl 리셋
delete from string_tbl;

insert into string_tbl (text_fld)
values ('This string was 29 characters');

# concat() 함수 : 문자열 추가 함수
update string_tbl
set text_fld = concat(text_fld, ', but now it is longer');

# 변경된 text_fld 열 확인
select text_fld from string_tbl;

# concat()함수 활용
use sakila;
select concat(first_name, ' ', last_name, ' has been a customer sincs ', date(create_date)) as cust_narrative
from customer;

# insert() 함수 - insert(문자열, 시작위치, 길이, 새로운 문자열)
# 세 번째 인수값(길이) = 0 : 새로운 문자열이 삽입
select insert('goodbye world', 9, 0, 'cruel ') as string;

# 세 번째 인수값 > 0 : 해당 문자열로 대치
select insert('goodbye world', 1, 7, 'hello') as string;

# replace() 함수 - replace(문자열, 기존 문자열, 새로운 문자열)
select replace('goodbye world', 'goodbye', 'hello') as replace_str;

# substr() 또는 substring() 함수 - substr(문자열, 시작위치, 개수)
# 문자열에서 시작 위치에서 개수만큼 추출
select substr('goodbye cruel world', 9, 5);