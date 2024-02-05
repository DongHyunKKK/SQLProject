use shoppingmall;

# 1.
select * from user_table;

select * from buy_table;

# 2. 1)
select userName, prodName, addr, concat(mobile1, mobile2) as 연락처
from buy_table as b
	inner join user_table as u
	on b.userID = u.userID;

# 2. 2)
select distinct b.userID, userName, prodName, addr, concat(u.mobile1, u.mobile2)
from buy_table as b
	inner join user_table as u
	on u.userID = b.userID
where b.userID = 'KYM';

# 2. 3)
select b.userID, userName, prodName, addr, concat(u.mobile1, u.mobile2)
from buy_table as b
	inner join user_table as u
	on u.userID = b.userID
order by b.userID;

# 2. 4)
select distinct b.userID, userName, addr
from buy_table as b
	inner join user_table as u
	on u.userID = b.userID
order by b.userID;

# 2. 5)
select b.userID, userName, addr, concat(u.mobile1, u.mobile2) as 연락
from buy_table as b
	inner join user_table as u
	on u.userID = b.userID
where addr in ('경북', '경남')
order by b.userID;
