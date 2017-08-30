OracleXML getXML -user "itec4220ngrp4/b4let383" \
-conn "jdbc:oracle:thin:@sit.yorku.ca:1521:studb10g" \
-rowsetTag "Order" -rowTag "Pending" \
"select o.oid, o.orderdate, c.acct as customerDetail from customer c, orders o where c.cid = o.aid.cid.cid and o.status='in progress'"

OracleXML getXML -user "itec4220ngrp4/b4let383" \
-conn "jdbc:oracle:thin:@sit.yorku.ca:1521:studb10g" \
-rowsetTag "Payment" -rowTag "Overdue" \
"select c.acct.getFullName() as name, i.amount as total, a.amtpaid as paid from invoice i, (select sum(p.amountpaid) as amtpaid, p.invid.invid as invid from payment p group by p.invid.invid) a, customer c where i.invid = a.invid and i.amount > a.amtpaid and c.cid = i.oid.aid.cid.cid"

OracleXML getXML -user "itec4220ngrp4/b4let383" \
-conn "jdbc:oracle:thin:@sit.yorku.ca:1521:studb10g" \
-rowsetTag "Orderline" -rowTag "Details" \
"select c.acct.getFullName() as name, o.pid.pname, trim(o.qty) as qty from customer c, orderlineitem o where o.oid.aid.cid.cid = c.cid and c.vipstatus='vip'"
