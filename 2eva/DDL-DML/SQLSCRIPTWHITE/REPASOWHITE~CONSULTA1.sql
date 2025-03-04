/*Consulta básica con WHERE y comparación
Selecciona los nombres y direcciones de los clientes cuyo ID sea menor o igual a 2.*/
SELECT CNAME,ADDRESS
FROM CUSTOMERS
WHERE CUSTID<=2;

/*Operador IN con múltiples valores
Encuentra los productos que tienen un precio de 25.75, 45.60 o 300.00.*/
SELECT NAME,PRICE
FROM PRODUCTS
WHERE PRICE IN (25.75,45.60,300.00);

/*Uso de BETWEEN con fechas
Muestra todas las órdenes realizadas entre el 1 de enero y el 31 de marzo de 2024.*/
SELECT ORDID,ORDER_DATE AS FECHA
FROM ORDERS
WHERE ORDER_DATE BETWEEN TO_DATE('01-01-2024','DD-MM-YYYY') AND TO_DATE('31-03-2024');

/*Uso de funciones de cadena (LOWER, UPPER)
Muestra los nombres de los productos en letras mayúsculas.*/
SELECT UPPER(NAME) AS NOMBRE_MAYUSCULAS
FROM PRODUCTS;

/*Filtrar por palabras específicas con LIKE
Encuentra los empleados cuyo nombre empieza con la letra 'J'.*/

SELECT ENAME
FROM EMPLOYEES
WHERE ENAME LIKE 'J%';

/*Ordenar con alias
Ordena a los clientes por sus nombres de forma ascendente, usando un alias para "Nombre del Cliente".*/
SELECT CNAME AS "NOMBRE DEL CLIENTE"
FROM CUSTOMERS
ORDER BY CNAME ASC;

/*Unión de tablas con INNER JOIN
Encuentra el nombre del producto y la categoría correspondiente.*/
SELECT P.NAME,C.CNAME
FROM PRODUCTS P
INNER JOIN PRODUCT_CATEGORIES PC ON P.PRODID=PC.PRODID
INNER JOIN CATEGORIES C ON PC.CATID=C.CATID;

/*
Filtrar con operadores de desigualdad
Muestra los empleados que tienen un salario mayor a 3000 pero no trabajan en el departamento 20.*/

SELECT ENAME,DEPTNO
FROM EMPLOYEES
WHERE SAL >3000 AND DEPTNO<>20;

/*
Agrupación y funciones agregadas (COUNT)
Encuentra cuántos productos hay en cada categoría.*/
SELECT  C.CNAME,COUNT(*) AS TOTAL_PRODUCTOS
FROM CATEGORIES C 
INNER JOIN product_categories PC ON C.CATID=PC.CATID
GROUP BY C.CNAME;

/*
Suma total (SUM)
Calcula el monto total de todas las órdenes realizadas.*/

SELECT SUM(TOTAL_AMOUNT) as MONTO_TOTAL
FROM ORDERS;

/*Agrupación con condiciones (HAVING)
Muestra las categorías que tienen más de 1 producto.*/

SELECT C.CNAME,COUNT(*)AS PRODUCTO_TOTAL_QUE_TIENE
FROM CATEGORIES C
INNER JOIN PRODUCT_CATEGORIES PC ON C.CATID=PC.CATID 
group by C.CNAME
HAVING COUNT (*)>1;

/*Subconsulta en WHERE
Encuentra los productos que han sido ordenados al menos una vez.*/
SELECT DISTINCT P.NAME
FROM PRODUCTS P
INNER JOIN ORDER_ITEMS OI ON P.PRODID=OI.PRODID
WHERE OI.ORDID>1; 

SELECT name FROM PRODUCTS WHERE prodid IN (SELECT prodid FROM ORDER_ITEMS WHERE PRODID IS NOT NULL);

/*Uso de LEFT JOIN
Encuentra todas las órdenes y muestra también las que no tienen transacciones asociadas.*/
SELECT O.ORDID, T.transid
FROM ORDERS O
LEFT JOIN TRANSACTIONS T ON O.ORDID=T.ORDID;
/*
Uso de RIGHT JOIN
Muestra todas las categorías y sus productos, incluyendo aquellas categorías sin productos asignados.*/

SELECT C.CNAME,P.NAME
FROM CATEGORIES C
RIGHT JOIN PRODUCT_CATEGORIES PC ON C.CATID=PC.CATID
LEFT JOIN PRODUCTS P ON PC.PRODID=P.PRODID;


/*Calcular promedio (AVG)
Encuentra el salario promedio de los empleados por departamento.*/
SELECT AVG(SAL) AS SALARIO_PROMEDIO
FROM EMPLOYEES
GROUP BY DEPTNO;

/*Filtrar con funciones de fecha
Muestra las transacciones realizadas en el mes de marzo de cualquier año.*/

SELECT *
FROM TRANSACTIONS
WHERE PAYMENT_DATE >= DATE '2024-03-01' AND payment_date < DATE '2024-04-01';

/*Subconsulta en SELECT
Muestra los nombres de los clientes junto con la cantidad total de órdenes que han realizado.*/

SELECT C.CNAME,COUNT(O.ORDID)
FROM CUSTOMERS C
INNER JOIN ORDERS O ON C.CUSTID=O.CUSTID
GROUP BY C.CNAME;

SELECT cname, (SELECT COUNT(*) FROM ORDERS WHERE ORDERS.custid = CUSTOMERS.custid) AS total_orders 
FROM CUSTOMERS;

/*Contar valores únicos (COUNT DISTINCT)
Encuentra cuántas ubicaciones únicas tienen los departamentos.*/

SELECT DISTINCT COUNT(D.LOC) AS "NUMERO DE LOCALIZACIONES"
FROM DEPARTMENTS D;

/*Consulta compleja con varias uniones
Muestra el nombre de los clientes, la fecha de la orden y los nombres de los productos incluidos en cada orden.*/

SELECT C.CNAME,O.ORDER_DATE,P.NAME
FROM CUSTOMERS C
INNER JOIN ORDERS O ON C.CUSTID=O.CUSTID
INNER JOIN ORDER_ITEMS OI ON O.ORDID=OI.ORDID
INNER JOIN PRODUCTS P ON OI.PRODID=P.PRODID;

/*
Eliminar duplicados con DISTINCT
Muestra todas las combinaciones únicas de nombres de departamentos y ubicaciones.*/
SELECT DISTINCT DNAME,LOC
FROM DEPARTMENTS






