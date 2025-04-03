--1Generar un alias para correos electrónicos
--Crea un alias para cada correo electrónico en formato inicial_del_nombre@empresa.com.
SELECT CNAME,EMAIL,CUSTID, SUBSTR(CNAME,1,1) || '@empresa.com' as alias_Email
FROM CUSTOMERS;
--2. Calcular el valor total del inventario de cada producto
--Muestra el nombre del producto, su precio, la cantidad en stock y el valor total calculado.
SELECT PRODID,NAME,PRICE,STOCK ,(PRICE*STOCK) AS VALOR_TOTAL 
FROM products;
--3 Formatear números de teléfono
--Convierte los números de teléfono en el formato (XXX) XXX-XXXX.
SELECT C.CUSTID,C.CNAME,C.PHONE,'('||SUBSTR(C.PHONE,1,3)||')'|| SUBSTR(C.PHONE,4,3) ||'-'||SUBSTR(C.PHONE,7,4) AS TELEFONO_FORMATEADO
FROM CUSTOMERS C;

SELECT custid, cname, phone,
       '(' || SUBSTR(phone, 1, 3) || ') ' || SUBSTR(phone, 4, 3) || '-' || SUBSTR(phone, 7, 4) AS telefono_formateado
FROM CUSTOMERS;
--4 Categorías únicas por productos
--Para cada producto, muestra las categorías asociadas en una sola línea, separadas por comas.

SELECT PC.PRODID,CONCAT(P.NAME ||' ',C.CNAME) AS CATEGORIA_UNICA
FROM PRODUCTS P
LEFT JOIN PRODUCT_CATEGORIES PC ON P.PRODID=PC.PRODID
INNER JOIN categories C ON PC.CATID=C.CATID;

SELECT p.prodid, p.name, 
       LISTAGG(c.cname, ', ') WITHIN GROUP (ORDER BY c.cname) AS categorias
FROM PRODUCTS p
JOIN PRODUCT_CATEGORIES pc ON p.prodid = pc.prodid
JOIN CATEGORIES c ON pc.catid = c.catid
GROUP BY p.prodid, p.name;

--5 Contar el número de clientes
--Utiliza la función COUNT para obtener el número total de clientes.
SELECT COUNT(DISTINCT(CNAME))AS TOTAL_CLIENTES
FROM CUSTOMERS;

SELECT COUNT(*) AS TOTAL_CLIENTES
FROM CUSTOMERS;
--6 Sumar el total de productos vendidos
--Usa SUM para calcular la cantidad total de productos vendidos (suma de las cantidades en ORDER_ITEMS)
SELECT SUM (ORDER_ITEMS.QUANTITY) AS TOTAL_PRODUCTOS_VENDIDOS
FROM ORDER_ITEMS;
SELECT SUM (DISTINCT(ORDER_ITEMS.QUANTITY)) AS TOTAL_PRODUCTOS_VENDIDOS
FROM ORDER_ITEMS;

--7 Obtener el precio promedio de los productos
--Calcula el precio promedio de los productos usando AVG.
SELECT AVG(DISTINCT(P.PRICE))  AS PRECIO_MEDIO_PRODUCTOS
FROM PRODUCTS P;
--8 Obtener el salario máximo y mínimo de los empleados
--Usa MAX y MIN para encontrar el salario más alto y más bajo entre los empleados.

SELECT MAX(DISTINCT(SAL)) AS SALARIO_MAS_ALTO,MIN(DISTINCT(SAL)) AS SAL_MAS_BAJO
FROM EMPLOYEES;

--9. Obtener la cantidad total de órdenes por estado
--Utiliza COUNT y GROUP BY para contar las órdenes agrupadas por su estado.
SELECT O.STATUS,COUNT((O.STATUS)) AS ORDENES_POR_ESTADO
FROM orders O
GROUP BY STATUS ORDER BY O.STATUS DESC;
--10. Obtener la orden con el monto total más alto
--Usa MAX para obtener el ordid de la orden con el monto más alto.

SELECT ordid, total_amount
FROM ORDERS
WHERE total_amount = (SELECT MAX(total_amount) FROM ORDERS);


--11  Obtener el producto más barato
--Utiliza MIN para encontrar el producto con el precio más bajo.
 
 SELECT NAME,PRICE
 FROM PRODUCTS 
 WHERE PRICE=(SELECT MIN(DISTINCT(PRICE))FROM products);
 
 --12Calcular la cantidad total de órdenes por cliente
--Utiliza COUNT para contar las órdenes realizadas por cada cliente.
SELECT custid, COUNT(DISTINCT(ORDERS.ORDID)) AS total_ordenes
FROM ORDERS
GROUP BY custid;

--13 Calcular el total gastado por cada cliente
--Usa SUM para calcular el total gastado por cada cliente (sumando el total_amount de la tabla ORDERS).

SELECT CUSTID,SUM(DISTINCT(TOTAL_AMOUNT)) AS TOTAL_GASTAD
FROM orders
GROUP BY CUSTID;

SELECT custid, SUM(total_amount) AS total_gastado
FROM ORDERS
GROUP BY custid;

--14 Contar el número de productos por categoría
--Utiliza COUNT y GROUP BY para contar cuántos productos hay en cada categoría.
SELECT PRODID,COUNT((CATID))
FROM product_categories
GROUP BY PRODID;

SELECT DISTINCT P.NAME,C.CNAME,C.CATID
FROM products P
LEFT JOIN product_categories PC ON P.PRODID=PC.PRODID
INNER JOIN CATEGORIES C  ON PC.CATID=C.CATID;

--*-*-*-*-
SELECT c.cname AS categoria, COUNT(p.prodid) AS cantidad_productos
FROM CATEGORIES c
JOIN PRODUCT_CATEGORIES pc ON c.catid = pc.catid
JOIN PRODUCTS p ON pc.prodid = p.prodid
GROUP BY c.cname;

--11 Obtener el salario promedio de los empleados por departamento
--Calcula el salario promedio de los empleados en cada departamento utilizando AVG.

SELECT D.DNAME AS NOMBRE_departamento, AVG((E.SAL)) AS SALARIO_PROMEDIO
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPTNO=D.DEPTNO
GROUP BY D.DNAME;

SELECT d.dname AS NOMBRE_departamento, AVG(e.sal) AS salario_promedio
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.deptno = d.deptno
GROUP BY d.dname;

--12Obtener el total de ventas de cada producto
--Usa SUM para calcular el total de ventas por producto, multiplicando la cantidad por el precio de cada producto.
SELECT P.NAME, SUM((P.PRICE*OT.QUANTITY)) AS TOTAL_VENTAS_PRODUCTO
FROM PRODUCTS P
LEFT JOIN ORDER_ITEMS OT ON P.PRODID=OT.PRODID
GROUP BY P.NAME;


SELECT p.name AS producto, SUM(oi.quantity * p.price) AS total_ventas
FROM ORDER_ITEMS oi
JOIN PRODUCTS p ON oi.prodid = p.prodid
GROUP BY p.name;

--14 Encontrar la cantidad de productos que quedan en stock para cada producto
--Calcula la cantidad total de productos restantes en stock sumando las cantidades disponibles.

SELECT P.NAME,SUM((P.STOCK)) AS PRODUCTOS_STOCK
FROM PRODUCTS P
GROUP BY P.NAME;

SELECT name, stock
FROM PRODUCTS;

--15 Obtener la cantidad total de productos vendidos por cada orden
--Usa SUM para calcular la cantidad total de productos vendidos en cada orden.



SELECT ordid, SUM(quantity) AS total_productos_vendidos
FROM ORDER_ITEMS
GROUP BY ordid;


-- Obtener el empleado con el salario más bajo
--Utiliza MIN para encontrar el empleado con el salario más bajo.

SELECT E.ENAME,SAL
FROM EMPLOYEES E
WHERE SAL=(SELECT MIN(SAL)FROM EMPLOYEES E);
SELECT empno, ename, sal
FROM EMPLOYEES
WHERE sal = (SELECT MIN(sal) FROM EMPLOYEES);

