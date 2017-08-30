/*1. product with profit greater than $100*/
xquery
let $p:=doc("/public/itec4220ngrp4/ms3_product.xml")
for $x in $p/ITEMS/PRODUCT
where $x/PRICE - $x/COST > 100
return $x/PNAME
/

/*2. products that are supplied by Alienware*/
xquery
let $p:=doc("/public/itec4220ngrp4/ms3_product.xml")
for $x in $p/ITEMS/PRODUCT
where $x/MANUFACTURER/MNAME = 'Alienware'
return $x/PNAME
/

/*3. Order that has more than 1 items */
xquery
let $s:=doc("/public/itec4220ngrp4/ms3_order.xml")
for $x in $s/DETAIL/ORDER
where count($x/PRODUCT/PID) > 1 or $x/PRODUCT/QTY > 1
return $x/@oid
/

/*4. sin number of salesperson who gets paid less than $300*/
xquery
let $s:=doc("/public/itec4220ngrp4/ms3_salesperson.xml")
for $x in $s/SalesDetail/Salesperson
where $x/PAY < 300
return $x/SIN
/

/*5. account number of customer whose status is vip */
xquery
let $c:=doc("/public/itec4220ngrp4/ms3_customer.xml")
for $x in $c/CustomerDetail/Customer
where $x/VIPSTATUS = 'vip'
return $x/ACCT/ACCOUNTNO
/


/*6. products that were ordered*/
xquery
let $p:=doc("/public/itec4220ngrp4/ms3_product.xml")
let $o:=doc("/public/itec4220ngrp4/ms3_order.xml")
for $x in $p/ITEMS/PRODUCT
for $y in $o/DETAIL/ORDER/PRODUCT
where $x/@pid=$y/PID
return $x/PNAME/text()
/

/*7. Customer that placed the order*/
xquery
let $c:=doc("/public/itec4220ngrp4/ms3_customer.xml")
let $o:=doc("/public/itec4220ngrp4/ms3_order.xml")
for $x in $c/CustomerDetail/Customer
for $y in $o/DETAIL/ORDER
where $x/Order/OID=$y/@oid
return $x/ACCT/FNAME/text()
/

/*8. Salesperson that handled the order*/
xquery
let $s:=doc("/public/itec4220ngrp4/ms3_salesperson.xml")
let $o:=doc("/public/itec4220ngrp4/ms3_order.xml")
for $x in $s/SalesDetail/Salesperson
for $y in $o/DETAIL/ORDER
where $x/Order/OID=$y/@oid
return $x/ACCT/FNAME/text()
/

/*9. salesperson who is responsible for order from vip customer that are in progress*/
xquery
let $s:=doc("/public/itec4220ngrp4/ms3_salesperson.xml")
let $c:=doc("/public/itec4220ngrp4/ms3_customer.xml")
for $x in $s/SalesDetail/Salesperson
for $y in $c/CustomerDetail/Customer
where $x/Order/OID=$y/Order/OID and $y/VIPSTATUS = 'vip' and $y/Order/STATUS = 'in progress'
return concat($x/EID,"-",$x/ACCT/FNAME)
/
