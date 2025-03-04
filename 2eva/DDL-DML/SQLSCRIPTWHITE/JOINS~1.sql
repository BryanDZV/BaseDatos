DESCRIBE CUSTOMERS;
DESCRIBE ORDERS;
DESCRIBE PRODUCTS;
DESCRIBE ORDER_ITEMS;
DESCRIBE SALGRADES;
--SELECT tabla1.columna1, tabla2.columna2
--FROM tabla1
--INNER JOIN tabla2 ON tabla1.columna_comun(pk) = tabla2.columna_comun(fk);

--1 Lista los nombres de los clientes y las fechas de sus pedidos.
SELECT CUSTOMERS.NAME,ORDERS.ORDER_DATE FROM CUSTOMERS,ORDERS WHERE CUSTOMERS.CUSTID=ORDERS.CUSTID;
SELECT CUSTOMERS.NAME,ORDERS.ORDER_DATE FROM CUSTOMERS INNER JOIN ORDERS ON CUSTOMERS.CUSTID=ORDERS.CUSTID;

--2 Muestra los detalles de los productos y sus precios, incluidos en los pedidos.
SELECT PRODUCTS.NAME,PRODUCTS.PRICE,ORDER_ITEMS.QUANTITY FROM PRODUCTS,ORDER_ITEMS WHERE PRODUCTS.PRODID=ORDER_ITEMS.PRODID;
SELECT PRODUCTS.NAME,PRODUCTS.PRICE,ORDER_ITEMS.QUANTITY FROM PRODUCTS INNER JOIN ORDER_ITEMS ON PRODUCTS.PRODID=ORDER_ITEMS.PRODID;
--3 Encuentra los nombres de los empleados y los departamentos donde trabajan:
SELECT employees.ENAME,departments.DNAME FROM employees,departments WHERE departments.DEPTNO=employees.DEPTNO;
SELECT employees.ENAME,departments.DNAME FROM employees INNER JOIN departments ON employees.DEPTNO=departments.DEPTNO;
--4 Lista los nombres de los clientes y los productos que han pedido:
SELECT customers.NAME,products.NAME FROM customers,products,ORDERS,ORDER_ITEMS WHERE customers.CUSTID=ORDERS.CUSTID AND ORDERS.ORDID=ORDER_ITEMS.ORDID AND ORDER_ITEMS.PRODID=products.PRODID;
SELECT customers.NAME,products.NAME FROM customers INNER JOIN orders ON customers.CUSTID=orders.CUSTID 
INNER JOIN order_items ON orders.ORDID=order_items.ORDID 
INNER JOIN products ON order_items.PRODID=products.PRODID;
--5 Muestra todos los rangos salariales y los empleados que se encuentran dentro de esos rangos, incluyendo rangos sin empleados:
SELECT SALGRADES.grade, EMPLOYEES.ename
FROM SALGRADES, EMPLOYEES
WHERE EMPLOYEES.sal(+) BETWEEN SALGRADES.losal AND SALGRADES.hisal;

SELECT SALGRADES.grade, EMPLOYEES.ename
FROM SALGRADES
LEFT JOIN EMPLOYEES ON EMPLOYEES.sal BETWEEN SALGRADES.losal AND SALGRADES.hisal;
