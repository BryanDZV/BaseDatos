--1 Listar todos los clientes.
SELECT * FROM  CUSTOMERS;
--2 Listar los nombres y ciudades de los clientes.
SELECT CUSTID,CITY FROM CUSTOMERS;
--3 Listar las órdenes realizadas por el cliente con custid 2.
SELECT * FROM orders WHERE CUSTID=2;
--4 Mostrar el nombre del producto y su precio.
 SELECT NAME,PRICE FROM products;
--Ejercicios con Alias y Operaciones Aritméticas
--5 Mostrar el precio total (cantidad × precio) para cada artículo en la tabla
SELECT  PRODUCTS.PRODID, ORDER_ITEMS.QUANTITY, (PRODUCTS.PRODID * ORDER_ITEMS.QUANTITY) AS "PRECIO TOTAL"
FROM PRODUCTS, ORDER_ITEMS
WHERE PRODUCTS.PRODID = ORDER_ITEMS.PRODID;
SELECT PRODUCTS.PRODID,ORDER_ITEMS.QUANTITY,(PRODUCTS.PRODID * ORDER_ITEMS.QUANTITY) AS "PRECIO TOTAL"
FROM products
INNER JOIN order_items ON products.prodid=order_items.prodid;
--6 Listar los empleados con su salario anual (sal × 12).
SELECT ENAME,SAL,SAL*12 AS "SALARIO ANUAL"
FROM employees;
--Ejercicios con DISTINCT
--7 Obtener las ciudades únicas(NO DUPLICADOS DISTINCT) donde residen los clientes.
SELECT DISTINCT city FROM CUSTOMERS;
--8 Obtener los departamentos únicos en la tabla EMPLOYEES.
SELECT DISTINCT DEPTNO FROM employees;
--Ejercicios con WHERE y Operadores de Comparación
--9 Listar los empleados con salario mayor a 3000.
SELECT * 
FROM employees
WHERE SAL >3000;
--10 Listar los productos cuyo precio está entre 30 y 300.
SELECT * FROM products WHERE PRICE BETWEEN 30 AND 300;
--11 Listar los empleados que no tienen gerente (mgr IS NULL).
SELECT * FROM employees WHERE MGR IS NULL;
--12 Listar los clientes cuyo nombre comienza con 'A'.
SELECT * FROM customers WHERE NAME LIKE 'A%';
--13 Mostrar las órdenes realizadas en noviembre de 2024.
SELECT * FROM orders WHERE order_date BETWEEN DATE '2024-11-01' AND DATE '2024-11-30';
--Ejercicios con JOIN
--14 Listar las órdenes con el nombre del cliente asociado.
SELECT CUSTOMERS.NAME,ORDERS.*
FROM customers
INNER JOIN ORDERS ON customers.custid=orders.custid;
SELECT CUSTOMERS.NAME,ORDERS.*
FROM customers,orders
WHERE customers.custid=orders.custid;
--15 Listar los nombres de los productos incluidos en la orden con ordid 101.
SELECT PRODUCTS.NAME,ORDER_ITEMS.ORDID 
FROM products
INNER JOIN ORDER_ITEMS ON products.prodid=order_items.prodid AND ORDER_ITEMS.ORDID=101;
SELECT PRODUCTS.NAME, ORDER_ITEMS.ORDID
FROM products,ORDER_ITEMS
WHERE products.prodid=order_items.prodid AND order_items.ordid=101;
--16 Listar los empleados junto con el nombre de su departamento.
SELECT employees.ename,departments.dname
FROM employees
INNER JOIN departments ON employees.deptno=DEPARTMENTS.DEPTNO;
SELECT employees.ename,departments.dname
FROM employees,departments
WHERE employees.deptno=DEPARTMENTS.DEPTNO;
--Ejercicios con Subconsultas
--17 Listar los clientes que realizaron órdenes.
SELECT DISTINCT c.*
FROM CUSTOMERS c
INNER JOIN ORDERS o ON c.custid = o.custid;
--18 Listar los productos incluidos en órdenes realizadas por el cliente 'Alice'.
SELECT DISTINCT PRODUCTS.NAME
FROM PRODUCTS
INNER JOIN ORDER_ITEMS ON PRODUCTS.PRODID = ORDER_ITEMS.PRODID
INNER JOIN ORDERS ON ORDER_ITEMS.ORDID = ORDERS.ORDID
INNER JOIN CUSTOMERS ON ORDERS.CUSTID = CUSTOMERS.CUSTID
WHERE CUSTOMERS.NAME IN ('Alice');

SELECT DISTINCT PRODUCTS.name
FROM PRODUCTS
JOIN ORDER_ITEMS ON PRODUCTS.prodid = ORDER_ITEMS.prodid
JOIN ORDERS ON ORDER_ITEMS.ordid = ORDERS.ordid
WHERE ORDERS.custid = (SELECT custid FROM CUSTOMERS WHERE name = 'Alice');
--19 Ejercicios con ORDER BY
--Listar los empleados ordenados por salario de forma descendente.
SELECT * FROM employees ORDER BY SAL DESC;
--20 Listar los productos ordenados por precio, de menor a mayor.
SELECT * FROM products ORDER BY PRICE,1; 
-- UNION y Funciones
--21 Unir las ciudades de clientes y ubicaciones de departamentos en una sola lista.
SELECT 
    CUSTOMERS.CITY || ' -------- ' || DEPARTMENTS.LOC AS "City and Location"
FROM 
    CUSTOMERS, DEPARTMENTS;




