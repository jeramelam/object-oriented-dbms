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