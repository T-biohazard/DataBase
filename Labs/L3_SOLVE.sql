drop table depositor cascade constraints;
drop table borrower cascade constraints;
drop table account cascade constraints;
drop table loan cascade constraints;
drop table customer cascade constraints;
drop table branch cascade constraints;

create table account
   (account_number 	varchar(15)	not null,
    branch_name		varchar(15)	not null,
    balance 		number		not null,
    primary key(account_number));

create table branch
   (branch_name 	varchar(15)	not null,
    branch_city 	varchar(15)	not null,
    assets 		number		not null,
    primary key(branch_name));

create table customer
   (customer_name 	varchar(15)	not null,
    customer_street 	varchar(12)	not null,
    customer_city 	varchar(15)	not null,
    primary key(customer_name));

create table loan
   (loan_number 	varchar(15)	not null,
    branch_name		varchar(15)	not null,
    amount 		number		not null,
    primary key(loan_number));

create table depositor
   (customer_name 	varchar(15)	not null,
    account_number 	varchar(15)	not null,
    primary key(customer_name, account_number),
    foreign key(account_number) references account(account_number),
    foreign key(customer_name) references customer(customer_name));

create table borrower
   (customer_name 	varchar(15)	not null,
    loan_number 	varchar(15)	not null,
    primary key(customer_name, loan_number),
    foreign key(customer_name) references customer(customer_name),
    foreign key(loan_number) references loan(loan_number));

/* populate relations */

insert into customer	values ('Jones',	'Main',		'Harrison');
insert into customer	values ('Smith',	'Main',		'Rye');
insert into customer	values ('Hayes',	'Main',		'Harrison');
insert into customer	values ('Curry',	'North',	'Rye');
insert into customer	values ('Lindsay',	'Park',		'Pittsfield');
insert into customer	values ('Turner',	'Putnam',	'Stamford');
insert into customer	values ('Williams',	'Nassau',	'Princeton');
insert into customer	values ('Adams',	'Spring',	'Pittsfield');
insert into customer	values ('Johnson',	'Alma',		'Palo Alto');
insert into customer	values ('Glenn',	'Sand Hill',	'Woodside');
insert into customer	values ('Brooks',	'Senator',	'Brooklyn');
insert into customer	values ('Green',	'Walnut',	'Stamford');
insert into customer	values ('Jackson',	'University',	'Salt Lake');
insert into customer	values ('Majeris',	'First',	'Rye');
insert into customer	values ('McBride',	'Safety',	'Rye');

insert into branch	values ('Downtown',	'Brooklyn',	 900000);
insert into branch	values ('Redwood',	'Palo Alto',	2100000);
insert into branch	values ('Perryridge',	'Horseneck',	1700000);
insert into branch	values ('Mianus',	'Horseneck',	 400200);
insert into branch	values ('Round Hill',	'Horseneck',	8000000);
insert into branch	values ('Pownal',	'Bennington',	 400000);
insert into branch	values ('North Town',	'Rye',		3700000);
insert into branch	values ('Brighton',	'Brooklyn',	7000000);
insert into branch	values ('Central',	'Rye',		 400280);

insert into account	values ('A-101',	'Downtown',	500);
insert into account	values ('A-215',	'Mianus',	700);
insert into account	values ('A-102',	'Perryridge',	400);
insert into account	values ('A-305',	'Round Hill',	350);
insert into account	values ('A-201',	'Perryridge',	900);
insert into account	values ('A-222',	'Redwood',	700);
insert into account	values ('A-217',	'Brighton',	750);
insert into account	values ('A-333',	'Central',	850);
insert into account	values ('A-444',	'North Town',	625);

insert into depositor values ('Johnson','A-101');
insert into depositor values ('Smith',	'A-215');
insert into depositor values ('Hayes',	'A-102');
insert into depositor values ('Hayes',	'A-101');
insert into depositor values ('Turner',	'A-305');
insert into depositor values ('Johnson','A-201');
insert into depositor values ('Jones',	'A-217');
insert into depositor values ('Lindsay','A-222');
insert into depositor values ('Majeris','A-333');
insert into depositor values ('Smith',	'A-444');

insert into loan	values ('L-17',		'Downtown',	1000);
insert into loan	values ('L-23',		'Redwood',	2000);
insert into loan	values ('L-15',		'Perryridge',	1500);
insert into loan	values ('L-14',		'Downtown',	1500);
insert into loan	values ('L-93',		'Mianus',	500);
insert into loan	values ('L-11',		'Round Hill',	900);
insert into loan	values ('L-16',		'Perryridge',	1300);
insert into loan	values ('L-20',		'North Town',	7500);
insert into loan	values ('L-21',		'Central',	570);

insert into borrower values ('Jones',	'L-17');
insert into borrower values ('Smith',	'L-23');
insert into borrower values ('Hayes',	'L-15');
insert into borrower values ('Jackson',	'L-14');
insert into borrower values ('Curry',	'L-93');
insert into borrower values ('Smith',	'L-11');
insert into borrower values ('Williams','L-17');
insert into borrower values ('Adams',	'L-16');
insert into borrower values ('McBride',	'L-20');
insert into borrower values ('Smith',	'L-21');

commit;




--1
select branch_city ,branch_name
from branch
where assets >1000000;

--2


select branch_name,account_number
from account
where branch_name='Downtown' and
 balance>=600 and balance<750;


--3

select account_number 
from account natural join branch
where city='Rey';

--or cartesian

--4
select loan_number
from loan natural join customer
where amount >=1000 and 
customer_city='Harrison';

--5
select *
from account 
order by balance desc; 

--6

select * from customer
 order by customer_city ;

--7
select cn.customer_name 
from customer cn, account an,branch bn
where cn.customer_name=bn.customer_name and
an.account_number=bn.  account_number
intersect
select br.customer_name
from loan l, borrower br
where br.loan_number =l.loan_number ; 

--8
SELECT c.customer_name ,c.customer_street,c.customer_city 
  FROM customer c,account a,depositor d
where c.customer_name=d.customer_name and
         a.account_number=d.account_number;
union
 select b.customer_name,c.customer_street,c.customer_city
 from borrower b,loan l,customer c
where l.loan_number = b.loan_number and
      b.customer_name=c.customer_name; 





--10
select sum(assetrs) as "totl assets"
from branch;
--11
SELECT avg(a.balance) AS "Average Balance"
 FROM account a,branch b
 where a.branch_name=b.branch_name
 GROUP BY branch_city ;
    --12           
select min(amount) as "Minimum Loan" from loan
group by branch_name;
        --13         
select count(branch_name) as "Number of loans" from loan group by branch_name;
          --14       
select c.customer_name,a.account_number from account a,customer c,depositor d 
where a.account_number=d.account_number and c.customer_name=d.customer_name and balance=(select max(balance) from account);



















































