/*Muestra el número total de productos que hay en la base de datos.*/

SELECT COUNT (STOCK) AS TOTALES_PRODUCTOS,P.NAME
FROM PRODUCTS P
GROUP BY P.NAME;
/*Obtén el precio promedio de todos los productos en la tabla PRODUCTS.*/
SELECT AVG(P.PRICE) AS PRECIO_MEDIO
FROM PRODUCTS P;

/*Lista las categorías y el total de productos asignados a cada categoría.*/

SELECT C.CNAME AS CATEGORIA, COUNT(PC.PRODID) AS TOTAL_PRODUCTOS_POR_ID
FROM CATEGORIES C
INNER JOIN PRODUCT_CATEGORIES PC ON C.CATID=PC.CATID
GROUP BY C.CNAME;

/*Encuentra las órdenes completadas por cada cliente, 
junto con el monto total que han gastado.*/

SELECT C.CNAME AS CLIENTES, SUM(O.TOTAL_AMOUNT) AS TOTAL_GASTADO
FROM CUSTOMERS C
INNER JOIN ORDERS O ON C.CUSTID=O.CUSTID
WHERE O.STATUS='Completed'
GROUP BY C.CNAME;




/*Muestra los productos que tienen menos
de 100 unidades en stock, junto con su precio promedio.*/


SELECT P.NAME,AVG(P.PRICE) AS PRECIO_PROMEDIO
FROM PRODUCTS P
WHERE P.STOCK<100
GROUP BY P.NAME;

/*Lista las órdenes realizadas en cada mes, mostrando
el mes, el número de órdenes y el monto total.*/

SELECT TO_CHAR(O.ORDER_DATE,'MM') AS MES,COUNT(O.ORDID) AS NUMERO_ORDEN,SUM(O.TOTAL_AMOUNT) AS TOTAL_MONTO
FROM ORDERS O
GROUP BY TO_CHAR(O.ORDER_DATE,'MM');


/**/

