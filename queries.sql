/* 1. formulate a specified query with treat */
select treat(deref(i.oid.eid) as salesperson_t).commission as commission, i.oid.eid.acct.getFullName() as salesperson, i.amount from invoice i where i.amount in (select sum(p.amountPaid) from payment p group by p.invid);

/* 2. Formulate a query demonstrating MAP method */
select c.acct.getFullName() as name, c.acct.getAge() as age, c.vipstatus from customer c where c.vipstatus = 'vip';

/* 3. Formulate a query demonstrating ORDER method */
select p.pid, p.pname, p.compareProfit((select value(i) from product i where i.pid = '001')) as profitCompare from product p order by value(p);

/* 4. Formulate a query demonstrating method from supertype - getSalary() */
select s.eid.eid, s.eid.acct.getFullName() as name, s.eid.getSalary() as pay from shipment s where s.oid.oid = '005';

/* 5. Formulate a query demonstrating overridden method from subtype - getSalary() */
select s.eid, s.acct.getFullName() as name, s.commission, s.rate, s.hours, s.getSalary() as pay from salesperson s where s.rate = '11.10';

/* 6. Formulate a query demonstrating other method - getFullAddress() */
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