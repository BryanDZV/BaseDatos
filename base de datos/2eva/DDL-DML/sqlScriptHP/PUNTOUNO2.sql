describe employees;
describe departments
DESCRIBE customers
DESCRIBE order_items
DESCRIBE orders
DESCRIBE products

--1 Muestra los nombres de los empleados y su salario junto con la ubicación del departamento en el que trabajan.

SELECT EMPLOYEES.ENAME,EMPLOYEES.SAL,DEPARTMENTS.LOC
from employees 
INNER JOIN departments ON employees.DEPTNO=departments.DEPTNO;
--2Obtén los nombres de los empleados que trabajan en el departamento con la ubicación "NEW YORK".
SELECT EMPLOYEES.ENAME,DEPARTMENTS.LOC
FROM EMPLOYEES
INNER JOIN departments ON employees.DEPTNO=departments.DEPTNO 
WHERE departments.LOC='New York';
--3Muestra el nombre de los clientes y la fecha del pedido para los pedidos realizados en noviembre de 2024.
SELECT customers.NAME,orders.ORDER_DATE
FROM customers
INNER JOIN ORDERS ON customers.CUSTID=orders.CUSTID
WHERE ORDER_DATE BETWEEN TO_DATE ('01-11-2024','DD-MM-YYYY') AND TO_DATE ('30-11-2024','DD-MM-YYYY');
--4Muestra el nombre de los productos y su precio, junto con la cantidad de cada producto que se ha pedido.
SELECT PRODUCTS.NAME ,PRODUCTS.PRICE,order_items.QUANTITY
FROM PRODUCTS
INNER JOIN order_items ON products.PRODID=order_items.PRODID;
--5Muestra el total gastado por cada cliente, sumando el precio de los productos multiplicado por la cantidad para cada uno de sus pedidos.
SELECT customers.NAME,(products.PRICE*order_items.QUANTITY) AS "TOTAL GASTADO"
FROM customers
INNER JOIN orders ON customers.CUSTID=orders.CUSTID
INNER JOIN order_items ON orders.ORDID=order_items.ORDID
INNER JOIN products ON order_items.PRODID=products.PRODID;//???
SELECT C.name AS customer_name, SUM(P.price * OI.quantity) AS total_spent
FROM CUSTOMERS C
JOIN ORDERS O ON C.custid = O.custid
JOIN ORDER_ITEMS OI ON O.ordid = OI.ordid
JOIN PRODUCTS P ON OI.prodid = P.prodid
GROUP BY C.name;

--6Muestra el nombre de los empleados que tienen un salario superior a 4000.
SELECT E.ENAME,E.SAL
FROM employees E
WHERE E.SAL>4000;
--7 : Muestra el nombre del cliente y la cantidad de productos que ha comprado en total.
SELECT C.NAME,(OI.ORDID*OI.QUANTITY) AS "PRODUCTOS TOTALES"
FROM customers C
INNER JOIN ORDERS  ON C.CUSTID=ORDERS.CUSTID
INNER JOIN order_items OI ON ORDERS.ORDID=OI.ORDID;//???
SELECT C.name AS customer_name, SUM(OI.quantity) AS total_quantity
FROM CUSTOMERS C
JOIN ORDERS O ON C.custid = O.custid
JOIN ORDER_ITEMS OI ON O.ordid = OI.ordid
GROUP BY C.name;
--8Muestra el nombre de los clientes que han hecho un pedido después del 3 de noviembre de 2024.
SELECT C.NAME
FROM customers C
INNER JOIN orders ON C.CUSTID=orders.CUSTID
WHERE ORDER_DATE > TO_DATE('03-11-2024','DD-MM-YYYY');
SELECT C.name AS customer_name
FROM CUSTOMERS C
JOIN ORDERS O ON C.custid = O.custid
WHERE O.order_date > TO_DATE('2024-11-03', 'YYYY-MM-DD');
--9Muestra los nombres de los productos que han sido comprados más de 3 veces.
SELECT P.NAME
FROM products P
INNER JOIN order_items ON P.PRODID=order_items.PRODID
WHERE order_items.ORDID >1;

SELECT P.name AS product_name
FROM PRODUCTS P
JOIN ORDER_ITEMS OI ON P.prodid = OI.prodid
GROUP BY P.name
HAVING SUM(OI.quantity) > 3;

--10Obtener la lista de todos los clientes concatenando el nombre y la ciudad:
SELECT C.NAME || C.CITY  AS "CLIENTES CON CIUDAD"
FROM customers C;
--11 Mostrar los empleados con salarios mayores a $3000 pero menores a $5000:
SELECT E.ENAME,E.SAL
FROM employees E
WHERE SAL BETWEEN 3000 AND 5000;
--12
SELECT O.ORDID,O.ORDER_DATE
FROM orders O
WHERE ORDER_DATE > TO_DATE('2-11-2024','DD-MM-YYYY') 
ORDER BY ORDER_DATE ;
--13Mostrar los productos con precio superior a $50 o cantidad mayor o igual a 2:
SELECT P.PRICE,P.NAME
FROM products P
INNER JOIN order_items ON P.PRODID=order_items.PRODID
WHERE P.PRICE > 50 OR order_items.QUANTITY>= 2;
--14Mostrar los nombres de los empleados que no tienen un gerente asignado:
SELECT E.MGR,E.ENAME
FROM employees E
WHERE E.MGR IS NULL;
--15Obtener los productos con un precio menor a $100 multiplicado por su cantidad:
SELECT P.NAME,P.PRICE,OI.QUANTITY,(P.PRICE*OI.QUANTITY)AS"MULTIPLICADO POR CANTIDAD"
FROM products P
INNER JOIN order_items OI ON P.PRODID=OI.PRODID
WHERE P.PRICE<100;

--16 Mostrar los empleados que trabajan en los departamentos ubicados en Chicago o Los Ángeles:
SELECT D.DEPTNO,D.LOC,E.ENAME,D.DNAME
FROM departments D
INNER JOIN employees E ON D.DEPTNO=E.DEPTNO
WHERE D.LOC IN('Chicago','Los Angeles');

SELECT e.ename, d.dname, d.loc 
FROM EMPLOYEES e 
JOIN DEPARTMENTS d ON e.deptno = d.deptno 
WHERE d.loc IN ('Chicago', 'Los Angeles');

--17Mostrar las órdenes realizadas por el cliente con ID 2, ordenadas por fecha descendente:
SELECT C.NAME,C.CUSTID,O.ORDID,O.ORDER_DATE
FROM customers C
INNER JOIN orders O ON C.CUSTID=O.CUSTID
WHERE C.CUSTID=2
ORDER BY ORDER_DATE DESC;



--18Mostrar los productos cuyo precio es mayor a $30 pero menor a $300, junto con sus cantidades:
SELECT P.NAME,P.PRICE,OI.QUANTITY
FROM products P
INNER JOIN order_items OI ON P.PRODID= OI.PRODID
WHERE P.PRICE >30 AND P.PRICE<300;

--19 Mostrar los empleados cuyo salario es exactamente igual al límite superior de su rango salarial:
SELECT E.ENAME,E.SAL,S.HISAL
FROM employees E,salgrades S
WHERE E.SAL=S.HISAL;

SELECT e.ename, e.sal, sg.hisal 
FROM EMPLOYEES e 
JOIN SALGRADES sg ON e.sal = sg.hisal;

--20Mostrar las órdenes que tienen más de 3 ítems:
SELECT O.ORDID,OI.QUANTITY,P.NAME
FROM orders O
INNER JOIN ORDER_ITEMS OI ON O.ORDID=OI.ORDID
INNER JOIN products P ON OI.PRODID=P.PRODID
WHERE OI.PRODID >3;

--21 Mostrar los clientes que no realizaron ninguna orden:
SELECT C.NAME
FROM customers C
LEFT JOIN orders ON C.CUSTID=orders.CUSTID
WHERE orders.ORDID IS NULL;

SELECT c.name 
FROM CUSTOMERS c,orders O
WHERE C.CUSTID=O.CUSTID(+) AND O.ORDID IS NULL;

--22 Mostrar las órdenes realizadas en días específicos (1 o 3 de noviembre de 2024):
SELECT O.ORDID,O.ORDER_DATE,O.CUSTID
FROM orders O
WHERE O.ORDER_DATE IN(TO_DATE('01-11-2024','DD-MM-YYYY'),TO_DATE('03-11-2024','DD-MM-YYYY')) ;

--23Mostrar los empleados con salarios inferiores al de su gerente:
SELECT e.ename, e.sal, m.ename AS manager_name, m.sal AS manager_salary 
FROM EMPLOYEES e 
INNER JOIN EMPLOYEES m ON e.mgr = m.empno 
WHERE e.sal < m.sal;

--24Mostrar los empleados cuyo nombre empieza con la letra "J":
SELECT E.ENAME
FROM employees E
WHERE E.ENAME LIKE 'J%';
--25 
SELECT C.NAME
FROM customers C
WHERE C.CITY NOT IN('New York','Los Angeles');

SELECT name, city 
FROM CUSTOMERS 
WHERE city NOT IN ('New York', 'Los Angeles');
--26Mostrar la información de los productos ordenados por precio en orden descendente y cantidad ascendente:

SELECT *
FROM products P
INNER JOIN ORDER_ITEMS ON P.PRODID=ORDER_ITEMS.PRODID
ORDER BY P.PRICE DESC, ORDER_ITEMS.QUANTITY ASC;

