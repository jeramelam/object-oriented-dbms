call dbms_xdb.deleteresource('/public/itec4220ngrp4/ms3_product.xml');
commit;
call dbms_xdb.deleteresource('/public/itec4220ngrp4/ms3_order.xml');
commit;
call dbms_xdb.deleteresource('/public/itec4220ngrp4/ms3_customer.xml');
commit;
call dbms_xdb.deleteresource('/public/itec4220ngrp4/ms3_salesperson.xml');
commit;

declare
  ret boolean;
  	begin
  	ret :=dbms_xdb.createfolder('/public/itec4220ngrp4');
	commit;
end;
/

Declare
  ret boolean;
    begin
    ret := dbms_xdb.createresource('/public/itec4220ngrp4/ms3_product.xml',
	'
	<ITEMS>
	   <PRODUCT pid="001">
	      <PNAME>LED TV</PNAME>
	      <COST>990</COST>
	      <PRICE>1099.99</PRICE>
	      <MANUFACTURER mid="003">
	      	<MNAME>Samsung</MNAME>
	      </MANUFACTURER>
	   </PRODUCT>
	   <PRODUCT pid="002">
	      <PNAME>Plasma TV</PNAME>
	      <COST>999</COST>
	      <PRICE>1488.88</PRICE>
	      <MANUFACTURER mid="002">
	      	<MNAME>LG</MNAME>
	      </MANUFACTURER>
	   </PRODUCT>
	   <PRODUCT pid="003">
	      <PNAME>Gaming Mouse</PNAME>
	      <COST>150</COST>
	      <PRICE>199.99</PRICE>
	      <MANUFACTURER mid="001">
	      	<MNAME>Alienware</MNAME>
	      </MANUFACTURER>
	   </PRODUCT>
	   <PRODUCT pid="004">
	      <PNAME>Mechanical Keyboard</PNAME>
	      <COST>280</COST>
	      <PRICE>362.5</PRICE>
	      <MANUFACTURER mid="001">
	      	<MNAME>Alienware</MNAME>
	      </MANUFACTURER>
	   </PRODUCT>
	   <PRODUCT pid="005">
	      <PNAME>Bluetooth Speaker</PNAME>
	      <COST>120</COST>
	      <PRICE>163.79</PRICE>
	      <MANUFACTURER mid="004">
	      	<MNAME>Panasonic</MNAME>
	      </MANUFACTURER>
	   </PRODUCT>
	</ITEMS>
    ');
	commit;
end;
/

Declare
  ret boolean;
    begin
    ret := dbms_xdb.createresource('/public/itec4220ngrp4/ms3_order.xml',
	'
	<DETAIL>
	  <ORDER oid="001">
	    <PRODUCT>
	      <PID>001</PID>
	      <QTY>1</QTY>
	    </PRODUCT>
	    <PRODUCT>
	      <PID>005</PID>
	      <QTY>1</QTY>
	    </PRODUCT>
	  </ORDER>
	  <ORDER oid="002">
	    <PRODUCT>
	      <PID>001</PID>
	      <QTY>2</QTY>
	    </PRODUCT>
	  </ORDER>
	  <ORDER oid="003">
	    <PRODUCT>
	      <PID>003</PID>
	      <QTY>3</QTY>
	    </PRODUCT>
	  </ORDER>
	  <ORDER oid="004">
	    <PRODUCT>
	      <PID>002</PID>
	      <QTY>1</QTY>
	    </PRODUCT>
	  </ORDER>
	  <ORDER oid="005">
	    <PRODUCT>
	      <PID>004</PID>
	      <QTY>2</QTY>
	    </PRODUCT>
	  </ORDER>
	  <ORDER oid="006">
	    <PRODUCT>
	      <PID>001</PID>
	      <QTY>1</QTY>
	    </PRODUCT>
	  </ORDER>
	</DETAIL>
    ');
	commit;
end;
/

Declare
  ret boolean;
    begin
    ret := dbms_xdb.createresource('/public/itec4220ngrp4/ms3_customer.xml',
	'
	<CustomerDetail>
	  <Customer>
	    <CID>001</CID>
	    <TITLE>Mr.</TITLE>
	    <ACCT>
	      <ACCOUNTNO>15000001</ACCOUNTNO>
	      <PASSWORD>********</PASSWORD>
	      <FNAME>Malcom</FNAME>
	      <LNAME>Williams</LNAME>
	      <D_OF_B>20-APR-89</D_OF_B>
	    </ACCT>
	    <VIPSTATUS>vip</VIPSTATUS>
	    <Order>
	      <OID>001</OID>
	      <ORDERDATE>2014-11-04</ORDERDATE>
	      <STATUS>in progress</STATUS>
	    </Order>
	  </Customer>
	  <Customer>
	    <CID>002</CID>
	    <TITLE>Ms.</TITLE>
	    <ACCT>
	      <ACCOUNTNO>15000002</ACCOUNTNO>
	      <PASSWORD>********</PASSWORD>
	      <FNAME>Stacey</FNAME>
	      <LNAME>Quinn</LNAME>
	      <D_OF_B>08-AUG-88</D_OF_B>
	    </ACCT>
	    <VIPSTATUS>vip</VIPSTATUS>
	    <Order>
	      <OID>003</OID>
	      <ORDERDATE>2014-11-14</ORDERDATE>
	      <STATUS>in progress</STATUS>
	    </Order>
	    <Order>
	      <OID>005</OID>
	      <ORDERDATE>2014-11-11</ORDERDATE>
	      <STATUS>shipped</STATUS>
	    </Order>
	  </Customer>
	  <Customer>
	    <CID>003</CID>
	    <TITLE>Mrs.</TITLE>
	    <ACCT>
	      <ACCOUNTNO>15000003</ACCOUNTNO>
	      <PASSWORD>********</PASSWORD>
	      <FNAME>Karen</FNAME>
	      <LNAME>Smith</LNAME>
	      <D_OF_B>03-DEC-76</D_OF_B>
	    </ACCT>
	    <VIPSTATUS>regular</VIPSTATUS>
	    <Order>
	      <OID>002</OID>
	      <ORDERDATE>2014-10-30</ORDERDATE>
	      <STATUS>completed</STATUS>
	    </Order>
	    <Order>
	      <OID>006</OID>
	      <ORDERDATE>2015-01-20</ORDERDATE>
	      <STATUS>in progress</STATUS>
	    </Order>
	  </Customer>
	  <Customer>
	    <CID>004</CID>
	    <TITLE>Ms.</TITLE>
	    <ACCT>
	      <ACCOUNTNO>15000004</ACCOUNTNO>
	      <PASSWORD>********</PASSWORD>
	      <FNAME>Jessica</FNAME>
	      <LNAME>Clifford</LNAME>
	      <D_OF_B>03-DEC-91</D_OF_B>
	    </ACCT>
	    <VIPSTATUS>regular</VIPSTATUS>
	    <Order>
	      <OID>004</OID>
	      <ORDERDATE>2014-11-06</ORDERDATE>
	      <STATUS>in progress</STATUS>
	    </Order>
	  </Customer>
	</CustomerDetail>
    ');
	commit;
end;
/

Declare
  ret boolean;
    begin
    ret := dbms_xdb.createresource('/public/itec4220ngrp4/ms3_salesperson.xml',
	'
	<SalesDetail>
	  <Salesperson>
	    <EID>001</EID>
	    <SIN>526040769</SIN>
	    <ACCT>
	      <ACCOUNTNO>19790624</ACCOUNTNO>
	      <PASSWORD>********</PASSWORD>
	      <FNAME>Manuel</FNAME>
	      <LNAME>Fernandez</LNAME>
	      <D_OF_B>24-JUN-79</D_OF_B>
	    </ACCT>
	    <PAY>809.91</PAY>
	    <Order>
	      <OID>001</OID>
	      <ORDERDATE>2014-11-04</ORDERDATE>
	      <STATUS>in progress</STATUS>
	    </Order>
	  </Salesperson>
	  <Salesperson>
	    <EID>002</EID>
	    <SIN>528140772</SIN>
	    <ACCT>
	      <ACCOUNTNO>19901102</ACCOUNTNO>
	      <PASSWORD>********</PASSWORD>
	      <FNAME>Lily</FNAME>
	      <LNAME>Jackson</LNAME>
	      <D_OF_B>02-NOV-90</D_OF_B>
	    </ACCT>
	    <PAY>550.43</PAY>
	    <Order>
	      <OID>004</OID>
	      <ORDERDATE>2014-11-06</ORDERDATE>
	      <STATUS>in progress</STATUS>
	    </Order>
	    <Order>
	      <OID>006</OID>
	      <ORDERDATE>2015-01-20</ORDERDATE>
	      <STATUS>in progress</STATUS>
	    </Order>
	    <Order>
	      <OID>005</OID>
	      <ORDERDATE>2014-11-11</ORDERDATE>
	      <STATUS>shipped</STATUS>
	    </Order>
	  </Salesperson>
	  <Salesperson>
	    <EID>003</EID>
	    <SIN>533043632</SIN>
	    <ACCT>
	      <ACCOUNTNO>19680331</ACCOUNTNO>
	      <PASSWORD>********</PASSWORD>
	      <FNAME>Samantha</FNAME>
	      <LNAME>Nelson</LNAME>
	      <D_OF_B>31-MAR-68</D_OF_B>
	    </ACCT>
	    <PAY>227.15</PAY>
	    <Order>
	      <OID>003</OID>
	      <ORDERDATE>2014-11-14</ORDERDATE>
	      <STATUS>in progress</STATUS>
	    </Order>
	  </Salesperson>
	  <Salesperson>
	    <EID>004</EID>
	    <SIN>523073689</SIN>
	    <ACCT>
	      <ACCOUNTNO>19851017</ACCOUNTNO>
	      <PASSWORD>********</PASSWORD>
	      <FNAME>Ish</FNAME>
	      <LNAME>Matthews</LNAME>
	      <D_OF_B>17-OCT-85</D_OF_B>
	    </ACCT>
	    <PAY>453.56</PAY>
	    <Order>
	      <OID>002</OID>
	      <ORDERDATE>2014-10-30</ORDERDATE>
	      <STATUS>completed</STATUS>
	    </Order>
	  </Salesperson>
	</SalesDetail>
    ');
	commit;
end;
/