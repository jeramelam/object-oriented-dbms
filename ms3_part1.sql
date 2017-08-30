set long 32000
set pagesize 60

/*1. select all customer name and their address*/
select xmlroot(xmlelement("customerAddresses", xmlagg(
xmlelement("Customer", xmlattributes(c.cid),
xmlelement("Name",xmlforest(c.acct.Fname as Fname,c.acct.Lname as Lname)),
xmlelement("Address",xmlforest(a.getFullAddress() as FullAddress,a.postalcode as PostalCode))))),
version '1.0') as result
from customer c, address a
where c.cid=a.cid.cid;

/*2.select products details and its manufacturer*/
select xmlroot(xmlelement("Products",xmlagg(
xmlelement("Product",xmlattributes(p.pid),
xmlforest(p.pname, p.price, p.cost),
xmlelement("Manufacturer",xmlforest(m.mid,m.mname))))),
version '1.0') as result
from product p, manufacturer m
where p.mid.mid = m.mid;

/*3.Select SalesPerson that associated with each order*/
select xmlroot(xmlelement("Orders", xmlagg(
xmlelement("Order", xmlattributes(o.oid),
xmlelement("Salesperson", xmlforest(sp.eid),
xmlelement("Name",xmlforest(sp.acct.fname, sp.acct.lname)))))),
version '1.0') as result
from orders o, salesperson sp
where o.eid.eid=sp.eid;

/*4.Select invoices and its payment, group by invid*/
select xmlroot(xmlelement("Invoices", xmlagg(
xmlelement("Invoice",xmlattributes(trim(i.invid) as invid),
xmlagg(xmlelement("Payment", xmlforest(trim(p.payid) as payid, p.amountpaid)))))),
version '1.0') as result
from invoice i, payment p
where p.invid.invid=i.invid
group by i.invid;

/*5.select packagehandlers and packages that each packagehanlder handled, group by eid*/
select xmlroot(xmlelement("ShipmentHistory", xmlagg(
xmlelement("PackageHandler",xmlattributes(p.eid),
xmlagg(xmlelement("Shipment", xmlforest(s.sid, s.shipdate)))))),
version '1.0') as result
from packagehandler p, shipment s
where p.eid = s.eid.eid
group by p.eid;

/*6.Select addresses and orders that sent to there, group by aid*/
select xmlroot(xmlelement("Orders", xmlagg(
xmlelement("Address", xmlattributes(a.aid),
xmlagg(xmlelement("Order",xmlforest(o.oid, o.orderdate, o.status)))))),
version '1.0') as result
from address a, orders o
where a.aid=o.aid.aid
group by a.aid;

/*7.select customers and all addresses belong to them, group by cid*/
select xmlroot(xmlelement("Addresses", xmlagg(
xmlelement("Customer",xmlattributes(c.cid),
xmlagg(xmlelement("Address",xmlforest(a.street,a.city,a.province)))))),
version '1.0') as result
from Customer c, address a
where c.cid=a.cid.cid
group by c.cid;

/*8.Select all manufacturer and its products and price, group by mid*/
select xmlroot(xmlelement("Manufacturers", xmlagg(
xmlelement("Manufacturer",xmlattributes(m.mid as "MID", m.mname as "Name"),
xmlagg(xmlelement("Product",xmlattributes(p.pid as "PID"),xmlforest(p.pname, p.price)))))),
version '1.0') as result
from product p, manufacturer m
where p.mid.mid=m.mid
group by m.mname, m.mid;

/*9.Select orders and all the product's name ordered in each order, group by oid*/
select xmlroot(xmlelement("Orders", xmlagg(
xmlelement("Order",xmlattributes(o.oid),
xmlagg(xmlelement("Product",xmlforest(p.pid,p.pname,trim(ol.qty) as qty)))))),
version '1.0') as result
from orders o, orderlineitem ol, product p
where o.oid=ol.oid.oid and ol.pid.pid=p.pid
group by o.oid;

/*10. select customers and their orders */
select xmlroot(xmlelement("CustomerDetail", xmlagg(
xmlelement("Customer",xmlforest(c.cid,c.title,c.acct,c.vipstatus),
xmlagg(xmlelement("Order",xmlforest(o.oid,o.orderdate,o.status)))))),
version '1.0') as result
from customer c, orders o
where c.cid = o.aid.cid.cid
group by c.cid,c.title,c.acct,c.vipstatus;

/*11. select salespersons and their orders */
select xmlroot(xmlelement("SalesDetail", xmlagg(
xmlelement("Salesperson",xmlforest(e.eid,e.SIN,e.acct,e.getSalary() as Pay),
xmlagg(xmlelement("Order",xmlforest(o.oid,o.orderdate,o.status)))))),
version '1.0') as result
from salesperson e, orders o
where e.eid = o.eid.eid
group by e.eid,e.SIN,e.acct,e.getSalary();