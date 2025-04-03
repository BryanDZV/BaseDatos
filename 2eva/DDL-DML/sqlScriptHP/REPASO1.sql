/*Consulta básica con WHERE y comparación
Selecciona los nombres y correos de los clientes cuyo ID sea mayor que 1.*/
SELECT CNAME,EMAIL
FROM CUSTOMERS
WHERE CUSTID >1;

/*Uso de operadores lógicos
Muestra los productos con precio mayor a 50 y con más de 100 unidades en stock.*/
SELECT NAME,PRICE
FROM PRODUCTS
WHERE PRICE >50 AND STOCK>100;

/*Reglas de precedencia
Selecciona los empleados cuyo salario esté entre 3000 y 5000, o trabajen en el departamento 20.*/
SELECT ENAME,SAL,DEPTNO
FROM EMPLOYEES
WHERE SAL BETWEEN 3000 AND 5000 OR DEPTNO=20;

/*Uso de LIKE para patrones
Encuentra los clientes cuyo correo termina en @example.com*/
SELECT *
FROM CUSTOMERS
WHERE EMAIL LIKE '%example.com';

/*Concatenación de columnas
Muestra los nombres de los clientes junto con su dirección en un solo campo, separados por una coma*/
SELECT CNAME || ','||ADDRESS AS CLIENTE_INFO
FROM CUSTOMERS;

/*Uso de fechas en condiciones
Selecciona las órdenes realizadas después del 1 de marzo de 2024.*/

SELECT ORDID
FROM ORDERS
WHERE ORDER_DATE > TO_DATE('2024-03-01', 'YYYY-MM-DD');

/*Ordenamiento simple
Muestra todos los productos ordenados por su precio de forma descendente.*/
SELECT NAME,PRICE
FROM PRODUCTS
ORDER BY PRICE DESC;

/*Uso de operadores aritméticos
Calcula el costo total de cada producto en ORDER_ITEMS multiplicando su cantidad por el precio.*/

SELECT O.ORDID,P.PRICE,O.QUANTITY*P.PRICE AS CANTIDAD_TOTAL
FROM ORDER_ITEMS O
INNER JOIN PRODUCTS P ON O.PRODID=P.PRODID;

/*Reglas de precedencia en cálculos
Muestra el precio total incluyendo un impuesto del 10% sobre el precio de cada producto.*/
SELECT P.PRICE AS PRECIO,P.PRICE+(P.PRICE*0.1) AS PRECIO_CON_IVA
FROM PRODUCTS P;

/*Combinación de condiciones
Selecciona los empleados contratados antes de 2022 y cuyo salario esté entre 3000 y 5000.*/

SELECT ename, sal, hiredate FROM EMPLOYEES 
WHERE hiredate < TO_DATE('2022-01-01', 'YYYY-MM-DD') AND sal BETWEEN 3000 AND 5000;

/*Alias para columnas
Muestra el nombre y precio de los productos con un alias que indique "Producto" y "Costo".*/
SELECT NAME AS PRODUCTO,PRICE AS COSTO
FROM PRODUCTS;

/*Condiciones con NOT
Encuentra las órdenes que no están completadas*/

SELECT ORDID, STATUS
FROM ORDERS
WHERE STATUS NOT IN('Completed');



/*Uso de DISTINCT
Muestra todas las ubicaciones únicas de los departamentos.*/

SELECT  DISTINCT LOC
FROM DEPARTMENTS;


/*Ordenar por múltiples columnas
Ordena a los empleados por su salario de forma descendente y, en caso de empate, por nombre de forma ascendente.*/

SELECT ENAME,SAL
FROM EMPLOYEES
ORDER BY SAL DESC,ENAME ASC;

/*Fechas y operadores de comparación
Selecciona las transacciones realizadas el 6 de marzo de 2024.*/
SELECT TRANSID,PAYMENT_DATE
FROM TRANSACTIONS
WHERE payment_method=TO_DATE('06-03-2024','DD-MM-YYYY');

/*Filtrar con operadores de comparación
Encuentra los productos con precio menor a 100 o con más de 150 unidades en stock.+*/

SELECT NAME,PRICE,STOCK
FROM PRODUCTS
WHERE PRICE < 100 AND STOCK >100;

/*Uso de IS NULL y IS NOT NULL
Encuentra a los empleados que no tienen un gerente asignado.*/

SELECT ENAME
FROM EMPLOYEES 
WHERE MGR IS NULL;

/*Unir tablas para obtener más información
Selecciona las órdenes junto con los nombres de los clientes que las realizaron.*/

SELECT O.ORDID,C.CNAME
FROM ORDERS O
INNER JOIN CUSTOMERS C ON O.CUSTID=C.CUSTID;


/*Condiciones con operadores lógicos avanzados
Encuentra las órdenes realizadas por clientes con ID mayor a 1 y con estado Completed o Shipped.*/
SELECT O.ORDID,O.STATUS
FROM ORDERS O
WHERE O.CUSTID>1 AND O.STATUS ='Completed' or o.status='Shipped';


/*Uso de operadores matemáticos complejos
Calcula la ganancia estimada si se venden todas las unidades en stock para cada producto.*/


SELECT name, stock * price AS estimated_revenue FROM PRODUCTS;

