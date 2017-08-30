drop table payment;
drop table invoice;
drop table shipment;
drop table orderlineitem;
drop table orders;
drop table address;
drop table product;
drop table manufacturer;
drop table customer;
drop table packagehandler;
drop table salesperson;

drop type payment_t;
drop type invoice_t;
drop type shipment_t;
drop type orderlineitem_t;
drop type order_t;
drop type address_t;
drop type product_t;
drop type manufacturer_t;
drop type customer_t;
drop type packagehandler_t;
drop type salesperson_t;
drop type employee_t;
drop type account_t;

create type account_t as object (accountno varchar(20), password varchar(8), 
fname varchar(15), lname varchar(15), d_of_b date,
map member function getAge return integer,
member function getFullName return varchar);
/

create type employee_t as object (eid char(3), acct account_t,
sin varchar(9), salary number (7,2),
member function getSalary return number) not final;
/

create type salesperson_t under employee_t (commission number(7,2), rate number(5,2), hours number(4,2),
overriding member function getSalary return number);
/

create type packagehandler_t under employee_t (workplace varchar(30));
/

create type customer_t as object (cid char(3), acct account_t, 
title varchar(20), vipstatus varchar(10));
/

create type manufacturer_t as object (mid char(3), mname varchar(20));
/

create type product_t as object (pid char(3), pname varchar(20), price number(6,2), cost number(6,2),
mid ref manufacturer_t, order member function compareProfit(p product_t) return integer)
/

create type address_t as object (aid char(3), street varchar(30), city varchar(20), province varchar(20), postalcode varchar(10),
cid ref customer_t, member function getFullAddress return varchar);
/

create type order_t as object (oid char(3), orderdate date, status varchar(20),
eid ref employee_t, aid ref address_t);
/

create type orderlineitem_t as object (olid char(3), qty char(5),
oid ref order_t, pid ref product_t);
/

create type shipment_t as object (sid char(3), shipdate date, 
eid ref employee_t, oid ref order_t);
/

create type invoice_t as object (invid char(5), description varchar(50), amount number(7,2), 
oid ref order_t);
/

create type payment_t as object (payid char(5), amountpaid number(7,2), 
invid ref invoice_t);
/

create table salesperson of salesperson_t(eid primary key);

create table packagehandler of packagehandler_t(eid primary key);

create table customer of customer_t(cid primary key);

create table manufacturer of manufacturer_t(mid primary key);

create table product of product_t(pid primary key);

create table address of address_t(aid primary key);

create table orders of order_t(oid primary key);

create table orderlineitem of orderlineitem_t(olid primary key);

create table shipment of shipment_t(sid primary key);

create table invoice of invoice_t(invid primary key);

create table payment of payment_t(payid primary key);

create type body account_t as map member function getAge
return integer
is
begin
return extract(year from sysdate) - extract(year from self.d_of_b);
end;
member function getFullName
return varchar
is
begin
return self.fname||' '||self.lname;
end;
end;
/

create type body employee_t as member function getSalary
return number
is
begin
return self.salary;
end;
end;
/

create type body salesperson_t as overriding member function getSalary 
return number
is
begin
return (self.rate * self.hours) + self.commission;
end;
end;
/

create type body address_t as member function getFullAddress
return varchar
is
begin
return self.street||', '||self.city||', '||self.province||' '||self.postalcode;
end;
end;
/

create type body product_t as order member function compareProfit(p product_t)
return integer
is 
begin
if (self.price - self.cost < p.price - p.cost) then
return -1;
elsif (self.price - self.cost > p.price - p.cost) then
return 1;
else
return 0;
end if;
end;
end;
/

insert into salesperson values(salesperson_t('001',
account_t('19790624','********','Manuel','Fernandez','24-Jun-1979'),
'526040769','0','260.91','15.25','36'));
insert into salesperson values(salesperson_t('002',
account_t('19901102','********','Lily','Jackson','02-Nov-1990'),
'528140772','0','328.43','11.10','20'));
insert into salesperson values(salesperson_t('003',
account_t('19680331','********','Samantha','Nelson','31-Mar-1968'),
'533043632','0','67.65','14.50','11'));
insert into salesperson values(salesperson_t('004',
account_t('19851017','********','Ish','Matthews','17-Oct-1985'),
'523073689','0','176.06','11.10','25'));

insert into packagehandler values(packagehandler_t('005',
account_t('19740107','********','Michael','Baldwin','07-Jan-1974'),
'526423226','28580','Mississauga'));
insert into packagehandler values(packagehandler_t('006',
account_t('19771028','********','John','Wesley','28-Oct-1977'),
'533066240','32360','Toronto'));
insert into packagehandler values(packagehandler_t('007',
account_t('19821203','********','May','Lampard','03-Dec-1982'),
'526045532','30790','Oshawa'));

insert into customer values(customer_t('001',
account_t('15000001','********','Malcom','Williams','20-Apr-1989'),
'Mr.','vip'));
insert into customer values(customer_t('002',
account_t('15000002','********','Stacey','Quinn','08-Aug-1988'),
'Ms.','vip'));
insert into customer values(customer_t('003',
account_t('15000003','********','Karen','Smith','03-Dec-1976'),
'Mrs.','regular'));
insert into customer values(customer_t('004',
account_t('15000004','********','Jessica','Clifford','03-Dec-1991'),
'Ms.','regular'));

insert into manufacturer values(manufacturer_t('001','Alienware'));
insert into manufacturer values(manufacturer_t('002','LG'));
insert into manufacturer values(manufacturer_t('003','Samsung'));
insert into manufacturer values(manufacturer_t('004','Panasonic'));

insert into product values(product_t('001','LED TV','1099.99','990.00',
(select ref(m) from manufacturer m where m.mid='003')));
insert into product values(product_t('002','Plasma TV','1488.88','999.00',
(select ref(m) from manufacturer m where m.mid='002')));
insert into product values(product_t('003','Gaming Mouse','199.99','150.00',
(select ref(m) from manufacturer m where m.mid='001')));
insert into product values(product_t('004','Mechanical Keyboard','362.50','280.00',
(select ref(m) from manufacturer m where m.mid='001')));
insert into product values(product_t('005','Bluetooth Speaker','163.79','120.00',
(select ref(m) from manufacturer m where m.mid='004')));

insert into address values(address_t('001','58 Saddlecreek Drive','Toronto','ON','M2H3L5',
(select ref(c) from customer c where c.cid='001')));
insert into address values(address_t('002','42 Hull Street','Mississauga','ON','L4T1C6',
(select ref(c) from customer c where c.cid='002')));
insert into address values(address_t('003','863 Aaron Avenue','Ottawa','ON','K2A3P1',
(select ref(c) from customer c where c.cid='003')));
insert into address values(address_t('004','27 Mill River Drive','Vaughan','ON','L6A0Y7',
(select ref(c) from customer c where c.cid='004')));

insert into orders values(order_t('001','04-Nov-2014','in progress',
(select ref(e) from salesperson e where e.eid='001'),
(select ref(a) from address a where a.aid='001')));
insert into orders values(order_t('002','30-Oct-2014','completed',
(select ref(e) from salesperson e where e.eid='004'),
(select ref(a) from address a where a.aid='003')));
insert into orders values(order_t('003','14-Nov-2014','in progress',
(select ref(e) from salesperson e where e.eid='003'),
(select ref(a) from address a where a.aid='002')));
insert into orders values(order_t('004','06-Nov-2014','in progress',
(select ref(e) from salesperson e where e.eid='002'),
(select ref(a) from address a where a.aid='004')));
insert into orders values(order_t('005','11-Nov-2014','shipped',
(select ref(e) from salesperson e where e.eid='002'),
(select ref(a) from address a where a.aid='002')));
insert into orders values(order_t('006','20-Jan-2015','in progress',
(select ref(e) from salesperson e where e.eid='002'),
(select ref(a) from address a where a.aid='003')));

insert into orderlineitem values(orderlineitem_t('001','1',
(select ref(o) from orders o where o.oid='001'),
(select ref(p) from product p where p.pid='001')));
insert into orderlineitem values(orderlineitem_t('002','1',
(select ref(o) from orders o where o.oid='001'),
(select ref(p) from product p where p.pid='005')));
insert into orderlineitem values(orderlineitem_t('003','2',
(select ref(o) from orders o where o.oid='002'),
(select ref(p) from product p where p.pid='001')));
insert into orderlineitem values(orderlineitem_t('004','3',
(select ref(o) from orders o where o.oid='003'),
(select ref(p) from product p where p.pid='003')));
insert into orderlineitem values(orderlineitem_t('005','1',
(select ref(o) from orders o where o.oid='004'),
(select ref(p) from product p where p.pid='002')));
insert into orderlineitem values(orderlineitem_t('006','2',
(select ref(o) from orders o where o.oid='005'),
(select ref(p) from product p where p.pid='004')));
insert into orderlineitem values(orderlineitem_t('007','1',
(select ref(o) from orders o where o.oid='006'),
(select ref(p) from product p where p.pid='001')));

insert into shipment values(shipment_t('001','12-Nov-2014',
(select ref(e) from packagehandler e where e.eid='007'),
(select ref(o) from orders o where o.oid='002')));
insert into shipment values(shipment_t('002','18-Nov-2014',
(select ref(e) from packagehandler e where e.eid='005'),
(select ref(o) from orders o where o.oid='005')));

insert into invoice values(invoice_t('001','2 LEDTV','2485.98',
(select ref(o) from orders o where o.oid='002')));
insert into invoice values(invoice_t('002','1 LEDTV and 1 BTSPKR','1264.91',
(select ref(o) from orders o where o.oid='001')));
insert into invoice values(invoice_t('003','2 KYBRD','830.55',
(select ref(o) from orders o where o.oid='005')));
insert into invoice values(invoice_t('004','1 PlasmaTV','1682.43',
(select ref(o) from orders o where o.oid='004')));

insert into payment values(payment_t('001','1000.00',
(select ref(i) from invoice i where i.invid='001')));
insert into payment values(payment_t('002','1485.98',
(select ref(i) from invoice i where i.invid='001')));
insert into payment values(payment_t('003','500.00',
(select ref(i) from invoice i where i.invid='003')));

/* 1. formulate a specified query with treat */
select treat(deref(i.oid.eid) as salesperson_t).commission as commission, i.oid.eid.acct.getFullName() as salesperson, i.amount from invoice i where i.amount in (select sum(p.amountPaid) from payment p group by p.invid);

/* 2. Formulate a query demonstrating MAP method */
select c.acct.getFullName() as name, c.acct.getAge() as age, c.vipstatus from customer c where c.vipstatus = 'vip';

/* 3. Formulate a query demonstrating ORDER method */
select p.pid, p.pname, p.compareProfit((select value(i) from product i where i.pid = '001')) as profitCompare from product p order by value(p);

/* 4. Formulate a query demonstrating method from supertype */
select s.eid.eid, s.eid.acct.getFullName() as name, s.eid.getSalary() as pay from shipment s where s.oid.oid = '005';

/* 5. Formulate a query demonstrating overridden method from subtype */
select s.eid, s.acct.getFullName() as name, s.commission, s.rate, s.hours, s.getSalary() as pay from salesperson s where s.rate = '11.10';

/* 6. Formulate a query demonstrating other method */
select o.oid, o.orderdate, o.aid.getFullAddress() as address from orders o where o.status = 'in progress' order by orderdate;

/* 7. Hot Item */
select sum(o.qty) as qty, o.pid.pname as product, o.pid.mid.mname as brand from orderlineitem o group by o.pid.pname, o.pid.mid.mname having sum(o.qty) = (select max(sum(o.qty)) from orderlineitem o group by o.pid.pname);

/* 8. Average days to complete an order */
select avg(a.days) as avgcompletion from (select s.shipdate - s.oid.orderdate as days, s.oid.oid as orders from shipment s) a;

/* 9. Employee that has most orders */
select n.name from (select count(o.oid) as count, o.eid.acct.getFullName() as name from orders o group by o.eid.acct.getFullName() order by count desc) n where rownum = 1;

/* 10. Customer that did not pay in full */
select i.oid.aid.cid.acct.getFullName() as name, i.amount as total, a.amtpaid as paid from invoice i, (select sum(p.amountpaid) as amtpaid, p.invid.invid as invid from payment p group by p.invid.invid) a where i.invid = a.invid and i.amount > a.amtpaid;

/* 11. Shipment detailed report */
select s.eid.acct.getFullName()||' shipped '||trim(a.qty)||' '||a.pname||' from '||treat(deref(s.eid) as packagehandler_t).workplace||' to '||a.city as shipdetail from shipment s, (select o.qty as qty, o.pid.pname as pname, o.oid.aid.city as city, o.oid.oid as oid from orderlineitem o) a where s.oid.oid = a.oid;