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
